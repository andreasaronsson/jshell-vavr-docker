#!/bin/sh

VOLUMES="-v ${HOST_HOME}:${HOME}"
ENVVARS="-e UID=$(id -u) -e DISPLAY=$DISPLAY -e TERM=$TERM"
PORTS="-p 127.0.0.1:2375:2375"
docker run --rm -u "$USER" -i $ENVVARS $VOLUMES $PORTS -w "$HOME" --net="host" -t 11-djk-slim $CMD

# TODO: Use the env variables instead of socket. This will make is possible to use this devbox on more OSs
# -e "DOCKER_HOST=$DOCKER_HOST" -e "DOCKER_TLS_VERIFY=$DOCKER_TLS_VERIFY" -e "DOCKER_CERT_PATH=/docker-certs" -v "$DOCKER_CERT_PATH:/docker-certs"
