FROM python:2-alpine

RUN apk add --no-cache git build-base postgresql-dev

RUN git clone https://github.com/occrp/id-backend.git /id/
WORKDIR /id/
RUN pip install --no-cache-dir -r requirements.txt

# Adds our application code to the image

EXPOSE 8080

ARG ID_VERSION=0.0.0-x
ENV ID_VERSION=$ID_VERSION

LABEL VERSION=$ID_VERSION

CMD gunicorn --bind 0.0.0.0:8080 -w `nproc --all` --log-file - api_v3.wsgi:application
