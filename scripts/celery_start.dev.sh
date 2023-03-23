#!/bin/bash

while getopts t: flag
do
    case "${flag}" in
        t) type=${OPTARG};;
    esac
done

cd ${BASE_DIR}/src

celery -A config $type -l INFO
