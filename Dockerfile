FROM python:3.12.8-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        jq \
        curl \
        git \
    && rm -rf /var/lib/apt/lists/*

ENV PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    POETRY_VERSION=2.0.0 \
    CYCLONEDX_VERSION=5.1.1

WORKDIR /opt

RUN pip install "cyclonedx-bom==$CYCLONEDX_VERSION"
RUN pip install "poetry==$POETRY_VERSION"
RUN poetry self add poetry-plugin-export@1.8.0

COPY update_dependencies.sh /opt
