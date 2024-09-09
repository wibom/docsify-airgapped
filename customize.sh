#!/bin/sh

CONTAINER_DIR="/tmp/static"
mkdir -p ${CONTAINER_DIR}

#
# Bundle some online assets with the container in /tmp/static
#

function BundleModules {

    #
    # Create the directory 'node_modules' and populates it with
    # a bunch of methods, including docsify
    #    
    
    # Generate package.json
    cd ${CONTAINER_DIR}
    npm init -y
    npm install docsify --save

}
function BundlePlugins {

    # Add admonition plugin: https://github.com/RayYH/docsify-admonition
    curl https://unpkg.com/docsify-plugin-flexible-alerts -L > \
        ${CONTAINER_DIR}/node_modules/docsify/lib/plugins/flexible-alerts.min.js

}
function BundleEmojies {
    emojis_tmpdir="${CONTAINER_DIR}/assets/emojis/unicode/"
    mkdir -p ${emojis_tmpdir}

    # List of emojis to download:
    # I snooped here: https://github.com/docsifyjs/docsify/blob/develop/build/emoji.js
    # To find: https://api.github.com/emojis
    wget https://api.github.com/emojis -O "${CONTAINER_DIR}/emojis_resource.json"

    # Read the JSON file
    json_file="${CONTAINER_DIR}/emojis_resource.json"
    json=$(cat "$json_file")

    # Loop over the keys in the JSON object
    for key in $(echo "$json" | jq -r 'keys[]'); do
        # Get the URL for the current key
        url=$(echo $json | jq -r --arg k "$key" '.[$k]')
            
        # Extract the file name from thse URL (and remove
        # the ?-suffix)
        filename=$(basename "$url" | awk -F '?' '{print $1}')

        # Download the asset to /tmp
        curl ${url} --output "${emojis_tmpdir}/${filename}"
    done

}

BundleModules
BundlePlugins
BundleEmojies