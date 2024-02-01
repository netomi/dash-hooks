FROM docker.io/library/python:3.10.10-slim

RUN apt-get update \
    && apt-get install -y \
        python3 \
        curl \
        jq

ENV PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    POETRY_VERSION=1.7.1 \
    CYCLONEDX_VERSION=4.0.0

WORKDIR /opt

RUN pip install "poetry==$POETRY_VERSION"
RUN pip install "cyclonedx-bom==$CYCLONEDX_VERSION"

RUN curl -L "https://repo.eclipse.org/service/local/artifact/maven/redirect?r=dash-licenses&g=org.eclipse.dash&a=org.eclipse.dash.licenses&v=LATEST" -o /opt/dash.jar

COPY update_dependencies.sh /opt
