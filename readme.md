
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
To enable Docsify to run in an air-gapped environment, we have bundled all necessary
modules plus selected plugins and features within the container image. These assets are
downloaded to a local directory in the container (`/tmp/.docsify/static`) during the build
process, managed by the `customize.sh` script.

At runtime, the bundled assets are copied to Docsify’s working directory (`/docs` in the
container) using `podman exec`. The `_run.sh` script demonstrates this process and also
bind-mounts and serves the included demo documents (`/docs-demo`), showcasing some of the
bundled Docsify plugins and features.
