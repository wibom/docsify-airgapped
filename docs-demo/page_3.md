> Current document: `page_3.md`

# Showcase syntax highlighting

Syntax highlighting is powered by Prism.

- https://docsify.js.org/#/language-highlight


> [!NOTE|style:flat]
> Language support is controlled in the `index.html` page. Simply add languages as 
> necessary.
>
> ```bash
>   <!-- syntax highlighting -->
>  <script src=".docsify/static/node_modules/prismjs/components/prism-bash.min.js"></script>   
>  <script src=".docsify/static/node_modules/prismjs/components/prism-r.min.js"></script> 
>  <script src=".docsify/static/node_modules/prismjs/components/prism-python.min.js"></script>
>  <script src=".docsify/static/node_modules/prismjs/components/prism-docker.min.js"></script>
>  <script src=".docsify/static/node_modules/prismjs/components/prism-markdown.min.js"></script>
>  <script src=".docsify/static/node_modules/prismjs/components/prism-yaml.min.js"></script>
>  <script src=".docsify/static/node_modules/prismjs/components/prism-json.min.js"></script>
> ```

## Bash

```bash
# bash syntax highlighting
VAR="some string"
CODE=${VAR} + "text"
for i in ${ARR[@]}; do
    # This is horribly wrong
    echo $i
done
```

## Html

```html
<!-- html -->

<bold> classics </bold>
```

## R
```r
# This is R-code
helloworld <- dplyr::mutate(ds, foo)
print("hello world")
ds %>% mutate()
```


## Docker
```docker
RUN some stuff
CMD some other stuff
ADD this

# and finally
ENTRYPOINT ["some", "string"]

```

## Markdown
```markdown

# So, highlight this then

* As you were.
* Don't be afraid.

`we will not yield`. **Right**?
```

## Yaml
```yaml
# yaml stuff
some:
- high tech
guru: of the highest order

```

## Json
```json
# json stuff
{
  "name": "John Doe",
  "age": 30,
  "city": "New York",
  "isEmployed": true,
  "skills": ["JavaScript", "React", "Node.js"]
}

```

