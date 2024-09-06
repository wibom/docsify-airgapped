# Template from:
# https://frameworks.readthedocs.io/en/latest/framework/api/docsifyDocker.html

FROM node:latest
LABEL description="A demo Dockerfile for build Docsify."
WORKDIR /docs

# RUN from erlier attempt 
# (but that repo is removed: https://github.com/quintoandar/docker-docsify
RUN npm install -g docsify-cli@latest && \
  npm install -g docsify@latest

EXPOSE 3000/tcp
ENTRYPOINT [ "docsify", "serve", "." ]
