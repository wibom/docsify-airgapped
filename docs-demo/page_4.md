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

At build time, `customize.sh` patches the Docsify core module
(`.docsify/static/node_modules/docsify/lib/docsify.min.js`) so that emoji image URLs
point to the locally bundled assets instead of the GitHub CDN:

- before: `https://github.githubassets.com/images/icons/emoji/`
- after:  `.docsify/static/assets/emojis/`

This ensures that the browser uses locally available emojis for rendering; e.g.
`http://localhost:3000/.docsify/static/assets/emojis/unicode/1f4af.png?v8.png`.

The relevant section in `customize.sh`:
```shell
PAT=$(echo "${CONTAINER_DIR}" | sed 's|^/[^/]*/||; s|/|\\/|g')
sed -i \
    "s/https:\/\/github.githubassets.com\/images\/icons\/emoji/${PAT}\/assets\/emojis/g" \
    "${CONTAINER_DIR}/node_modules/docsify/lib/docsify.min.js"
```

After patching, a verification step ensures no references to the CDN remain:
```shell
if grep -q "github.githubassets.com/images/icons/emoji" \
    "${CONTAINER_DIR}/node_modules/docsify/lib/docsify.min.js"; then
    echo "ERROR: Emoji URL patch failed"
    exit 1
fi
```

> [!NOTE|style:flat]
> As of Docsify v4.13, emojis are resolved directly in the core module
> (`docsify.min.js`). The separate emoji plugin
> (`.docsify/static/node_modules/docsify/lib/plugins/emoji.min.js`) is no longer used and
> does not need to be patched.

