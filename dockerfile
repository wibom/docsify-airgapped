# Dockerfile starting point:
# https://frameworks.readthedocs.io/en/latest/framework/api/docsifyDocker.html

FROM node:22.8.0-alpine3.20
LABEL description="Docsify air-gapped"
WORKDIR /docs

# Install tini
RUN apk add --no-cache tini

# Global instal of Docsify-CLI; Docsify is installed locally with `customize.sh`
RUN npm install -g docsify-cli@latest 

# Adding tools used by `customize.sh`
RUN apk --update add curl && \
    apk add --no-cache wget jq
    
# `customize.sh` bundles npm-methods and docsify-plugins with the container
# enables running air-gapped
ADD customize.sh /tmp/custom_scripts/
RUN sh /tmp/custom_scripts/customize.sh   

EXPOSE 3000/tcp
ENTRYPOINT ["/sbin/tini", "--"]
CMD [ "docsify", "serve", "." ]
