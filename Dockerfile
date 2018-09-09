FROM python:2.7.15-alpine

ENV ID_VERSION=master
LABEL VERSION=$ID_VERSION

RUN apk add --no-cache git build-base postgresql-dev

RUN git clone -q --branch $ID_VERSION --depth 1 https://github.com/occrp/id-backend.git /id/

WORKDIR /id/

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

CMD gunicorn -t 60 --keep-alive 5 --bind 0.0.0.0:8080 -w `nproc --all` --log-file - api_v3.wsgi:application
