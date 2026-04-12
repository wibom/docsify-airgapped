#!/bin/sh
#
# Entrypoint: copy bundled assets into the bind-mounted /docs directory,
# then start Docsify.
#

# Remove any stale assets from a previous run
rm -rf /docs/.docsify

# Copy the bundled assets from the image into the working directory
cp -r /tmp/.docsify /docs/.docsify

exec docsify serve .
