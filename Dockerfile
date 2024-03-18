FROM python:3.10.10-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        jq \
        curl \
    && rm -rf /var/lib/apt/lists/*

ENV PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    POETRY_VERSION=1.8.2 \
    CYCLONEDX_VERSION=4.0.0

WORKDIR /opt

RUN pip install "cyclonedx-bom==$CYCLONEDX_VERSION"
RUN pip install "poetry==$POETRY_VERSION"
RUN poetry self add poetry-plugin-export@1.7.0

COPY update_dependencies.sh /opt
