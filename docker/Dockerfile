# pull official base image
# FROM python:3.11.2-slim-buster AS base

FROM python:3.8.2-slim-buster

RUN apt-get update \
    && apt-get install -y netcat postgresql gcc python3-dev musl-dev \
    && rm -rf /var/lib/apt/lists/*

# set work directory
ENV BASE_DIR=/project
WORKDIR ${BASE_DIR}

# make scripts directory & copy scripts & give permissions to be executed
RUN mkdir -p ${BASE_DIR}/scripts
COPY ./scripts ${BASE_DIR}/scripts
RUN chmod +x ${BASE_DIR}/scripts/*

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy project
COPY . .
