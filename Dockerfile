FROM python:3.12.5-slim

# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True
ENV APP_HOME /app
ENV PORT 8080
ENV HOST 0.0.0.0
ENV STORAGE_BASE /
ENV STORAGE_DIR storage

# Python app installation
WORKDIR $APP_HOME
COPY README.md pyproject.toml setup.py ./
COPY src src/
# The `fs` package uses pkg_resources but doesn't declare setuptools as a dependency.
# Python 3.12 no longer bundles setuptools, so we install it explicitly.
RUN pip install setuptools && pip install .
RUN apt-get update && apt-get install -y curl

ENTRYPOINT ["gcp-storage-emulator"]
CMD ["start"]
