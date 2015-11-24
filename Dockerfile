FROM gliderlabs/alpine:3.2

# Set the environment variables for ftp2http
# - override with docker-compose when needed
ENV listen_host=0.0.0.0 \
    listen_port=2121 \
    passive_port_min=1024 \
    passive_port_max=1048

# Update apk package list and upgrade system.
RUN apk --update add \
    gcc \
    g++ \
    python \
    python-dev \
    py-pip

# Required extra packages for ftp2http-daemon
RUN apk --update add \
    libffi-dev \
    openssl-dev

# Uncomment for testing
# RUN apk --update add bash
# RUN pip install ipdb

# Upgrade python pip
RUN pip install --upgrade pip

# Need to install pbr prior to ftp2http, therefore can't put all requirements together in a requirements.txt.
# Otherwise there's a dependency issue when installing ftp2http.
RUN pip install pbr j2cli
RUN pip install ftp2http

# Add ftp2http config
ADD files/etc/ftp2http.conf.j2 /etc/

# On boot, update the config with correct environment settings
ADD setup.sh /
RUN chmod +x setup.sh

ENTRYPOINT /setup.sh && ftp2http
