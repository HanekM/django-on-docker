#!/bin/sh


if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 3
    done

    echo "PostgreSQL started."
fi


python src/manage.py createsuperuser --noinput
python src/manage.py migrate
python src/manage.py runserver 0.0.0.0:8000

exec "$@"
