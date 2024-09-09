# Emojies

I wish to get emojies working offline.

How?

:)

:100:

:thumbsup:

:grin:

--------

# This works because

We run this at container start time:
```shell
docker exec ${NAME} \
  sed -i \
  "s/https:\/\/github.githubassets.com\/images\/icons\/emoji/.docsify\/static\/assets\/emojis/g" \
  .docsify/static/node_modules/docsify/lib/docsify.min.js
```

Thereby replacing the the occurrence of `https://github.githubassets.com/images/icons/emoji/` 
with the local asset `.docsify/static/assets/emojis`, within the file 
`.docsify/static/node_modules/docsify/lib/docsify.min.js`.

The browser will grab the asset from: 
`http://localhost:3000/.docsify/static/assets/emojis/unicode/1f4af.png?v8.png`


The same address is specified in `.docsify/static/node_modules/docsify/lib/plugins/emoji.min.js`,
but apparently that has no effect.



# Legacy stuff - old container attempt locally on laptop

This exists in `/lib/docsify.js` (and therefore also in `min.js`: https://www.quora.com/What-is-difference-between-JS-and-Min-JS):

`https://github.githubassets.com/images/icons/emoji/`

What happens if I change it in the "min.js"...?

Try changing it to `https://github.foo.githubassets.com/images/icons/emoji/`.

And now the nice little emojies on this page are gone..

And when I change it back - I get the emojies back :grin:

> [!ATTENTION]
> Can this base-url be changed to some local resource????


---

Made changes to `docsify.min.js`. 
