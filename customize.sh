#!/bin/sh

#
# Bundle online assets with the container 
#
# NOTE:
# The bundled content will be made available to Docsify at runtime. This is done by using
# `docker exec` to copy the content into Docsify's working directory in the container
# (`/docs`). The `/docs` directory is bind-mounted to the host directory containing the
# documents to serve.
# 
# Due to the nature of bind-mounts, we cannot pre-populate the `/docs` directory in the
# container with the bundled content. If we do, the bind mount will obscure the
# pre-existing content in `/docs`, making it appear deleted. (I learned this the hard
# way.)
#
# - https://docs.docker.com/engine/storage/bind-mounts/#mount-into-a-non-empty-directory-on-the-container
# - https://stackoverflow.com/a/61895782
#

# - Bundele assets in a temporary directory. 
# - Assets are to be copied to `/docs/.docsify/static` at runtime
CONTAINER_DIR="/tmp/.docsify/static"
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
        break
    done
    
    
    # Edit the main Docsify module ('docsify.min.js') to use locally bundled emojis
    # instead of the ones hosted by githubassets.    
    # -- Remove `/tmp` and escape slashes in the rest of the path
    PAT=$( echo "${CONTAINER_DIR}" | sed 's|^/[^/]*/||; s|/|\\/|g' )
    sed -i \
        "s/https:\/\/github.githubassets.com\/images\/icons\/emoji/${PAT}\/assets\/emojis/g" \
        ${CONTAINER_DIR}/node_modules/docsify/lib/docsify.min.js

}
function BundleAssets {
    # Download font awesome (icons for custum flexible alerts)

    AF_VER='6.5.2'
    AWESOME="fontawesome-free-${AF_VER}-web"    
    AWESOME_PATH=${CONTAINER_DIR}/assets/fontawesome-free
    AWESOME_TMPDIR='/tmp/awesome'
    mkdir -p ${AWESOME_PATH}
    mkdir -p ${AWESOME_TMPDIR}
    wget --directory-prefix=/tmp/awesome  \
        https://use.fontawesome.com/releases/v${AF_VER}/${AWESOME}.zip
    unzip ${AWESOME_TMPDIR}/${AWESOME}.zip -d ${AWESOME_TMPDIR}
    mv ${AWESOME_TMPDIR}/${AWESOME}/* ${AWESOME_PATH}

    # clean up
    rm -rf ${AWESOME_TMPDIR}


}

BundleModules
BundlePlugins
BundleEmojies
BundleAssets