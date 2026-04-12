#!/bin/bash
NAME="docsify-demo"
DOCS="docs-demo"  # Documents to serve (relative path on host)

# Spin up container
# The entrypoint automatically copies bundled assets into /docs/.docsify
podman run -d \
  -v "$(pwd)/${DOCS}":/docs \
  -p 3000:3000 \
  --name ${NAME} \
  docker-archive:docsify.v4.13-r2.tar
