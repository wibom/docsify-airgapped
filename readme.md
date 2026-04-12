
# Docsify Air-Gapped Container

This repository contains a containerized version of
[Docsify](https://github.com/docsifyjs/docsify), with all necessary assets bundled to run
in an air-gapped environment.


## Quick Start

```shell
# Clone the repository
git clone https://github.com/wibom/docsify-airgapped.git

# Build the container image
bash _build.sh

# Deploy the container and serve demo documents
bash _run.sh
```


## Overview

The container image is built in two stages:

1. **Builder stage** — downloads and bundles all JavaScript dependencies, plugins, emoji
   images, and icon fonts into `/tmp/.docsify/static/` using `customize.sh`. All
   dependencies are managed through `npm` for reproducibility.

2. **Runtime stage** — a clean `node:24-alpine` image with only `tini` and `docsify-cli`.
   The bundled assets are copied from the builder stage. No build tools remain in the
   final image, reducing size and CVE surface.


### Why `entrypoint.sh`?

Docsify's working directory (`/docs`) is bind-mounted from the host when the container
runs. By design, a bind mount obscures any files that were already in the mount-point
directory inside the container. This means we cannot place the bundled assets inside
`/docs` at build time — the bind mount would hide them.

Instead, the bundled assets live in `/tmp/.docsify` inside the image. At startup,
`entrypoint.sh` copies them into the bind-mounted `/docs/.docsify/` so that Docsify can
reference them with relative paths like `.docsify/static/node_modules/...`. It then starts
the Docsify server. This removes the need for a manual `podman exec` copy step after
starting the container.

The `_run.sh` script demonstrates this workflow and serves the included demo documents
(`docs-demo/`) on port 3000.


### Font Awesome backward compatibility

Font Awesome 7 is bundled with two backward-compatibility CSS files (`v5-font-face.min.css`
and `v4-shims.min.css`), loaded in `index.html`. This means existing documentation using
old class syntax (`fas fa-skull`, `far fa-file`) continues to render without changes.


## Repository Structure

| File / Directory | Purpose |
|------------------|---------|
| `dockerfile`     | Multi-stage container build (builder + runtime). |
| `customize.sh`   | Runs during the builder stage: installs npm packages and downloads emoji images. |
| `entrypoint.sh`  | Runs at container startup: copies bundled assets from `/tmp/.docsify` into the bind-mounted `/docs/.docsify/`, then starts the Docsify server. |
| `_build.sh`      | Builds the container image and saves it to a `.tar` file. |
| `_run.sh`        | Loads the image and starts a demo container serving `docs-demo/`. |
| `docs-demo/`     | Sample documentation site used for testing. |
| `.dockerignore`  | Keeps the build context small. |


## Bundled Components

| Component                      | Version              |
|--------------------------------|----------------------|
| Docsify                        | 4.x                  |
| docsify-cli                    | 4.4.4                |
| docsify-themeable              | 0.x                  |
| Mermaid                        | 11.x                 |
| docsify-mermaid                | 2.x                  |
| docsify-plugin-flexible-alerts | 1.x                  |
| docsify-copy-code              | 3.x                  |
| Font Awesome Free              | 7.x (FA5/FA4 compat) |
| PrismJS (syntax highlight)     | bundled with docsify  |
| GitHub Emojis                  | all                  |
