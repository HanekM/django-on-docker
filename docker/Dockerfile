# pull official base image
# FROM python:3.10-slim-buster AS base

FROM python:3.11-slim-buster

RUN set -ex \
    && RUN_DEPS=" \
        mime-support \
        postgresql-client \
        pipenv \
        netcat \
        libpq-dev \
        python-dev \
    " \
    && apt-get update && apt-get install -y --no-install-recommends $RUN_DEPS  \
    && rm -rf /var/lib/apt/lists/*

# set work directory
ENV BASE_DIR=/project
WORKDIR ${BASE_DIR}

# make scripts directory & copy scripts & give permissions to be executed
RUN mkdir -p ./scripts
COPY ./scripts ./scripts
RUN chmod +x ./scripts/*

# install dependencies
RUN pip install --upgrade pip
ADD Pipfile Pipfile.lock ./
RUN pipenv install -d --system --deploy

# copy your project code
ADD . .
