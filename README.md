# ftp2http Daemon #

### Running docker ###

This service is run and deployed using [Docker](https://www.docker.com/).
The base image is [gliderlabs/alpine:3.2](https://github.com/gliderlabs/docker-alpine)

Need to create a docker-compose.yml file based on docker-compose.yml.example.

``` sourceCode
docker build .

# Run in background
docker-compose start

# Stop the services
docker-compose stop

OR

# Run in foreground
docker-compose up


```
