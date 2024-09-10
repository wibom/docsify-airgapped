#!/bin/sh

#
# Bundle online assets with the container 
#

# The directory to use for storing bundled assets:
CONTAINER_DIR="/tmp/static"
mkdir -p ${CONTAINER_DIR}


function BundleModules {

    # https://www.geeksforgeeks.org/where-does-npm-install-the-packages/

    #
    # Install packages locally in ${CONTAINER_DIR}/node_modules
    #    
 
    cd ${CONTAINER_DIR}
    npm init -y
    npm install docsify@4 --save
    npm install mermaid@10 --save  # for some reason we still end up with v11 ?

}
function BundlePlugins {

    # Add admonition plugin: https://github.com/fzankl/docsify-plugin-flexible-alerts
    curl -L https://unpkg.com/docsify-plugin-flexible-alerts \
        -o ${CONTAINER_DIR}/node_modules/docsify/lib/plugins/flexible-alerts.min.js

    # https://github.com/Leward/mermaid-docsify
    curl -L https://unpkg.com/docsify-mermaid@2.0.1/dist/docsify-mermaid.js \
        -o ${CONTAINER_DIR}/node_modules/docsify/lib/plugins/docsify-mermaid.js

    # Download version 2 of the docsify-copy-code plugin
    curl -L https://unpkg.com/docsify-copy-code@2/dist/docsify-copy-code.min.js \
        -o ${CONTAINER_DIR}/node_modules/docsify/lib/plugins/docsify-copy-code.min.js

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
            
        # Extract the file name from thse URL (and remove the ?-suffix)
        filename=$(basename "$url" | awk -F '?' '{print $1}')

        # Download the asset to /tmp
        curl ${url} --output "${emojis_tmpdir}/${filename}"
    done

}

BundleModules
BundlePlugins
BundleEmojies