#!/bin/sh


if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 3
    done

    echo "PostgreSQL started."
fi

cd $BASE_DIR/src

python manage.py migrate
python manage.py collectstatic --noinput
gunicorn --config gunicorn_config.py config.wsgi:application --bind 0.0.0.0:8000
