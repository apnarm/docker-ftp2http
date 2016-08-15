FROM python:2.7-alpine

WORKDIR /app
COPY . /app

# Required packages for ftp2http
RUN apk --update add \
 libffi-dev \
 openssl-dev

# Update apk package list and python requirements, install ftp2http, then cleanup
RUN apk --update add --virtual build-dependencies build-base \
 && pip install --upgrade -r requirements.txt \
 && pip install ftp2http \
 && apk del build-dependencies

# Add ftp2http config template.
COPY files/etc/ftp2http.conf.j2 /etc/

# On boot, create the config with correct environment settings.
RUN chmod +x setup.sh
ENTRYPOINT /app/setup.sh && ftp2http
