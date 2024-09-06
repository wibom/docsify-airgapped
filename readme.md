
Inspiration here: 
- https://frameworks.readthedocs.io/en/latest/framework/api/docsifyDocker.html
- https://littlstar.github.io/docker-docsify/#/?id=docker-docsify
- https://michaelcurrin.github.io/docsify-js-tutorial/#/
- Offline: https://docsify.js.org/#/pwa
- `/mnt/c/Users/caewim02/Documents/_sandbox_/docsify` (laptop)

# attempt-1
- Make it work online.

```dockerfile
FROM node:latest
LABEL description="A demo Dockerfile for build Docsify."
WORKDIR /docs-1
RUN npm install -g docsify-cli@latest
EXPOSE 3000/tcp
ENTRYPOINT docsify serve .
```