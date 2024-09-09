#!/bin/bash
NAME="docsify-1"

docker run --rm -d -it \
  -v "$(pwd)/docs-1":/docs \
  -p 3000:3000 \
  --name ${NAME} \
  docsify/play-1

# make stuff bundled in /tmp/static available
docker exec ${NAME} mkdir -p /docs/.docsify/
docker exec ${NAME} cp -r /tmp/static /docs/.docsify

