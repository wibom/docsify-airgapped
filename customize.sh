#!/bin/sh

#
# Bundle some online assets with the container in /tmp/static
#

#
# This creates the directory node_modules and populates it with
# a bunch of methods, including docsify
#
mkdir -p /tmp/static
cd /tmp/static
npm init -y
npm install docsify --save

# Add admonition plugin: https://github.com/RayYH/docsify-admonition
curl https://unpkg.com/docsify-plugin-flexible-alerts -L > \
    /tmp/static/node_modules/docsify/lib/plugins/flexible-alerts.min.js

