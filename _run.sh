#!/bin/bash

docker run --rm -d -it \
  -v "$(pwd)/docs-1":/docs \
  -p 3000:3000 \
  --name docsify-1 \
  docsify/play-1

docker exec docsify-1 mkdir -p /docs/.docsify/lib/plugins
docker exec docsify-1 cp /tmp/flexible-alerts.min.js /docs/.docsify/lib/plugins/flexible-alerts.min.js
