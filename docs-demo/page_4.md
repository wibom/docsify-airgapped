> Current document: `page_4.md`


# Emojis

Docsify natively uses emojis from `githubassets`. We have bundled these with the container
image.

- https://docsify.js.org/#/plugins?id=emoji

Use standard github shorthand to render them:

- For a full list, snoop here: https://gist.github.com/rxaviers/7360908

```markdown
:thumbsup:
```
:thumbsup:


```markdown
:grin:
```
:grin:


```markdown
:100:
```
:100:


Standard text short-cuts don't work though.

```markdown
:)
```
:)




## Use bundled offline emoji assets

We edit the containerized Docsify module 
(`.docsify/static/node_modules/docsify/lib/docsify.min.js`) at container build time: 

- before: `https://github.githubassets.com/images/icons/emoji/`
- after:  `.docsify/static/assets/emojis`

This ensures that the browser will use the locally available emoji for rendering the page;
e.g. `http://localhost:3000/.docsify/static/assets/emojis/unicode/1f4af.png?v8.png`.


The build-time edit happens inside `customize.sh`, like so:
```shell
sed -i \
    "s/https:\/\/github.githubassets.com\/images\/icons\/emoji/${PAT}\/assets\/emojis/g" \
    ${CONTAINER_DIR}/node_modules/docsify/lib/docsify.min.js
```


> [!NOTE|style:flat]
> As of Docsify v4.13 the Emoji-plugin is no longer used, therefore editing the plugin
> (`.docsify/static/node_modules/docsify/lib/plugins/emoji.min.js`) has no effect and is
> not necessary. 

