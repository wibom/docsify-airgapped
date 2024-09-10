#!/bin/bash
NAME="docsify-1"

docker run --rm -d -it \
  -v "$(pwd)/docs-1":/docs \
  -p 3000:3000 \
  --name ${NAME} \
  docsify/play-1

# Make stuff bundled in /tmp/static available
docker exec ${NAME} mkdir -p /docs/.docsify/
docker exec ${NAME} cp -r /tmp/static /docs/.docsify

# Redirect emojies to the volume mapped bundled asset
docker exec ${NAME} \
  sed -i \
  "s/https:\/\/github.githubassets.com\/images\/icons\/emoji/.docsify\/static\/assets\/emojis/g" \
  .docsify/static/node_modules/docsify/lib/docsify.min.js
