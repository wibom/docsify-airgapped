#!/bin/sh
set -e

#
# Bundle online assets with the container
#
# NOTE:
# The bundled content will be made available to Docsify at runtime. The entrypoint
# script copies the content into Docsify's working directory in the container (`/docs`).
# The `/docs` directory is bind-mounted to the host directory containing the documents
# to serve.
#
# Due to the nature of bind-mounts, we cannot pre-populate the `/docs` directory in the
# container with the bundled content. If we do, the bind mount will obscure the
# pre-existing content in `/docs`, making it appear deleted.
#
# - https://docs.docker.com/engine/storage/bind-mounts/#mount-into-a-non-empty-directory-on-the-container
# - https://stackoverflow.com/a/61895782
#

# Bundle assets in a temporary directory.
# Assets are copied to `/docs/.docsify/static` at runtime by the entrypoint.
CONTAINER_DIR="/tmp/.docsify/static"
mkdir -p "${CONTAINER_DIR}"


bundle_modules() {
    cd "${CONTAINER_DIR}"
    npm init -y

    # Core docsify and theme
    npm install docsify@4 --save
    npm install docsify-themeable@0 --save

    # Mermaid diagram support
    npm install mermaid@11 --save
    npm install docsify-mermaid@2 --save

    # Plugins
    npm install docsify-plugin-flexible-alerts@1 --save
    npm install docsify-copy-code@3 --save

    # Font Awesome 7 (icons for custom flexible alerts)
    npm install @fortawesome/fontawesome-free@7 --save
}

bundle_emojis() {
    emojis_tmpdir="${CONTAINER_DIR}/assets/emojis/unicode/"
    mkdir -p "${emojis_tmpdir}"

    # Download the emoji index from GitHub API
    # Ref: https://github.com/docsifyjs/docsify/blob/develop/build/emoji.js
    echo "Downloading emoji index from api.github.com/emojis..."
    wget -q https://api.github.com/emojis -O "${CONTAINER_DIR}/emojis_resource.json"

    json_file="${CONTAINER_DIR}/emojis_resource.json"

    if [ ! -s "${json_file}" ]; then
        echo "WARNING: Failed to download emoji index. Emojis will not work offline."
        return 0
    fi

    # Download each emoji image
    total=$(jq 'keys | length' "${json_file}")
    echo "Downloading ${total} emoji images..."

    count=0
    for key in $(jq -r 'keys[]' "${json_file}"); do
        url=$(jq -r --arg k "${key}" '.[$k]' "${json_file}")
        filename=$(basename "${url}" | awk -F '?' '{print $1}')

        if ! curl -sS -f "${url}" --output "${emojis_tmpdir}/${filename}"; then
            echo "WARNING: Failed to download emoji: ${key}"
        fi

        count=$((count + 1))
        if [ $((count % 200)) -eq 0 ]; then
            echo "  ... downloaded ${count}/${total} emojis"
        fi
    done
    echo "Downloaded ${count}/${total} emoji images."

    # Patch docsify.min.js to use locally bundled emojis instead of githubassets CDN
    PAT=$(echo "${CONTAINER_DIR}" | sed 's|^/[^/]*/||; s|/|\\/|g')
    sed -i \
        "s/https:\/\/github.githubassets.com\/images\/icons\/emoji/${PAT}\/assets\/emojis/g" \
        "${CONTAINER_DIR}/node_modules/docsify/lib/docsify.min.js"

    # Verify the patch was applied
    if grep -q "github.githubassets.com/images/icons/emoji" \
        "${CONTAINER_DIR}/node_modules/docsify/lib/docsify.min.js"; then
        echo "ERROR: Emoji URL patch failed — docsify.min.js still references githubassets."
        exit 1
    fi
    echo "Emoji URL patch applied successfully."
}


bundle_modules
bundle_emojis