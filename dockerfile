# Template from:
# https://frameworks.readthedocs.io/en/latest/framework/api/docsifyDocker.html

FROM node:alpine
LABEL description="A demo Dockerfile for build Docsify."
WORKDIR /docs

# RUN from erlier attempt 
# (but that repo is removed: https://github.com/quintoandar/docker-docsify
RUN npm install -g docsify-cli@latest && \
  npm install -g docsify@latest


# https://stackoverflow.com/a/62847426/7439717
RUN apk --update add curl

# Get admonition plugin: https://github.com/RayYH/docsify-admonition
RUN curl https://unpkg.com/docsify-plugin-flexible-alerts -L > /tmp/flexible-alerts.min.js


EXPOSE 3000/tcp
ENTRYPOINT [ "docsify", "serve", "." ]
