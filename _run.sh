#!/bin/bash
NAME="docsify-1"

docker run --rm -d -it \
  -v "$(pwd)/docs-1":/docs \
  -p 3000:3000 \
  --name ${NAME} \
  docsify/play-1

# Make stuff bunded in the container avaiable to Docsify by copying it to Docsify's
# working directory `/docs`:
docker exec ${NAME} cp -r /tmp/.docsify /docs/.docsify
