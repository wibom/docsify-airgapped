
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

- To allow `RUN apk --update add curl` in the Dockerfile, change from `node:latest` to `node:alpine`. 
	- Use `docker exec -it ... /bin/sh` to interact.
	- (Originally we used `docker exec -it ... /bin/bash)`, if I recall... 

## Attempting to download external dependencies 
With a little ChatGPT help:

- Drop into container `docker exec -it docsify-1 /bin/sh`.
- `mkdir static`
- `cd static`
- `npm init -y` (creates /docs/static/package.json)
- `npm install docsify --save` 
	- creates /node_modules with a bunch of methods (dirs) inside, including docsify
 - Redirect inside `index.html`
	 - <script src="static/node_modules/docsify/lib/docsify.min.js"></script>
- Tried downloading external java script dependencies 
  `wget --recursive --no-parent --convert-links --page-requisites --no-directories --directory-prefix=static/js https://cdn.jsdelivr.net/npm/docsify/lib/docsify.min.js`

	- All this did was create a separate copy of `docsify.min.js`, but we already have this from the `npm install`.
		- Comparing the files shows they are NOT identical though...
- Let's try the same for another resource referenced within `index.html`:
	- `wget --recursive --no-parent --convert-links --page-requisites --no-directories --directory-prefix=static/js //cdn.jsdelivr.net/npm/docsify/themes/vue.css`
	- Redirect inside `index.html`
	  <link rel="stylesheet" href="static/js/vue.css">

## Make off-line using the script `customize.sh`

- Prettify all previous work by:
	- Writing up the commands used in a script: `customize.sh`.
	- Modify dockerfile to ADD the script and RUN it at build time. 
		- This adds all external assets to `/tmp/static/` within the container.
	- Modify the run-script to copy `tmp/static` to `/docs/.docsify`.
		- We have not solved the UID/GID-mapping; the `.docsify`-directory volume mapped under `/docs` is owned by root on the host...

> As the next step: try and add emojis, like we did last time :)
> 
  
# Todo
- [x] add syntax-hightligh for all languages. 
	- See previous attempt.
- [x] Is there a mermaid-plugin we can add?
	- Read this: https://docsify.js.org/#/markdown?id=supports-mermaid
- [x] can we activate the search function?
- [x] can we add the 'copy to clipboard' plugin?
- [x] have we atm installed docsify twice, both globally (dockerfile) and locally (customize.sh)?
- [ ] figure out how to run rootless with podman...
- [ ] write up readme for Github
- [ ] check for VScode-extension for docsify-markdown... 
- [ ] Squish all commits into an `init`-commit... and push to GitHub.
