#!/bin/bash

while getopts t: flag
do
    case "${flag}" in
        t) type=${OPTARG};;
    esac
done

cd /usr/src/project/src

celery -A config $type -l info
