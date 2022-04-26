# pull official base image
FROM python:3.8.2-slim-buster

RUN apt-get update

# set work directory
WORKDIR /usr/src/project

RUN mkdir -p /usr/src/project/scripts
# copy the starting scripts
COPY scripts /usr/src/project/scripts
RUN sed -i 's/\r//g' /usr/src/project/scripts/*
RUN chmod +x /usr/src/project/scripts*

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy project
COPY . .
