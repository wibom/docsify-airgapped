#!/bin/bash
NAME="docsify-demo"
DOCS="docs-demo"  # Documents to serve (relative path on host)

# If the container has run before, there are likley a copy of the bundled assets left
# in the container. Clean that up before we spin up a new instance of the container.
REMNANTS="$(pwd)/${DOCS}/.docsify"
rm -rf ${REMNANTS}

# Spin up container
podman run -d \
  -v "$(pwd)/${DOCS}":/docs \
  -p 3000:3000 \
  --name ${NAME} \
  docker-archive:docsify.v4.13.tar

# Make bundled assets in the container avaiable to Docsify by copying it to Docsify's
# working directory in the container `/docs`:
podman exec ${NAME} cp -r /tmp/.docsify /docs/.docsify
