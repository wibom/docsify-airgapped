> Current document: `page_2.md`

# Showcase admonitions
There are two ways to use admonitions.


## Using Docsify default 

> Ref: https://docsify.js.org/#/helpers?id=important-content

!> **Time** is money, my friend!


?> **WARNING** text to stand out.x



## Admonitions using "flexible-alerts" plugin:
> Ref: https://github.com/fzankl/docsify-plugin-flexible-alerts


```text
> [!NOTE]
> "Do. Or do not. There is no try." - Yoda
```
> [!NOTE]
> "Do. Or do not. There is no try." - Yoda

------------------------------------------------------------------------------------------

```text
> [!ATTENTION]
> "I find your lack of faith disturbing." - Darth Vader
```

> [!ATTENTION]
> "I find your lack of faith disturbing." - Darth Vader

------------------------------------------------------------------------------------------

```text
> [!WARNING|style:flat]
> "Don't Panic." - The Hitchhiker's Guide to the Galaxy
```

> [!WARNING|style:flat]
> "Don't Panic." - The Hitchhiker's Guide to the Galaxy


------------------------------------------------------------------------------------------

### Nested call outs

```text
> [!TIP|label:Do nested call outs]
> It does not appear to be possible to nest multiple "flexible allerts", however one 
> can use Docsify default call outs within a "flexible allert":
> 
> !> "So long, and thanks for all the fish." - The Hitchhiker's Guide to the Galaxy
```

> [!TIP|label:Do nested call outs]
> It does not appear to be possible to nest multiple "flexible allerts", however one 
> can use Docsify default call outs within a "flexible allert":
> 
> !> "So long, and thanks for all the fish." - The Hitchhiker's Guide to the Galaxy
>



### Custom call outs

These are custom alerts, configured in `index.html` with icons from Font Awesome (bundled
with container image, and linked in `index.html`).

```text
> [!QUOTE]
> An alert of type 'comment' using style 'callout' with default settings.
```
> [!QUOTE]
> An alert of type 'comment' using style 'callout' with default settings.

In `index.html` we apply this mapping: `className: 'quote'`. This is not supported. That
is why it renders without colors, which kinda works as its own CSS-class.

------------------------------------------------------------------------------
```text
> [!COMMENT]
> An alert of type 'comment' using style 'callout' with default settings.
```
> [!COMMENT]
> An alert of type 'comment' using style 'callout' with default settings.

In `index.html` we apply this mapping: `className: 'note'`. Thus `COMMENT` will inherit
the CSS-class from `NOTE` and have the same look and feel, although a different icon.

See original java script:
https://github.com/fzankl/docsify-plugin-flexible-alerts/blob/main/src/index.js

