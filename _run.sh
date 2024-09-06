#!/bin/bash

docker run --rm -d -it \
  -v "$(pwd)/docs-1":/docs \
  -p 3000:3000 \
  --name docsify-1 \
  docsify/play-1