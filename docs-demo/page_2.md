> Current document: `page_2.md`

# Showcase admonitions
There are two ways to use admonitions.


## Docsify default 
- Ref: https://docsify.js.org/#/helpers?id=important-content

------------------------------------------------------------------------------------------
 
```text
!> **Time** is money, my friend!
```
!> **Time** is money, my friend!

------------------------------------------------------------------------------------------

```text
?> **WARNING** text to stand out.
```
?> **WARNING** text to stand out.




## "flexible-alerts" plugin:
- Ref: https://github.com/fzankl/docsify-plugin-flexible-alerts

There are four built in classes:

1. 
```text
> [!NOTE]
> "Do. Or do not. There is no try." - Yoda
```
> [!NOTE]
> "Do. Or do not. There is no try." - Yoda

------------------------------------------------------------------------------------------

2. 
```text
> [!ATTENTION]
> "I find your lack of faith disturbing." - Darth Vader
```
> [!ATTENTION]
> "I find your lack of faith disturbing." - Darth Vader

------------------------------------------------------------------------------------------

3. 
```text
> [!WARNING|style:flat]
> "Don't Panic." - The Hitchhiker's Guide to the Galaxy
```
> [!WARNING]
> "Don't Panic." - The Hitchhiker's Guide to the Galaxy

------------------------------------------------------------------------------------------

4. 
```text
> [!TIP]
> "I'd far rather be happy than right any day." - Slartibartfast
```
> [!TIP]
> "I'd far rather be happy than right any day." - Slartibartfast

#### Tweaking
Each of the  built in classes can be customized further as documented here:
https://github.com/fzankl/docsify-plugin-flexible-alerts?tab=readme-ov-file#customizations

- Custom label:  
```text
> [!TIP|label: words of wisdom]
> "Would it save you a lot of time if I just gave up and went mad now?" - Arthur Dent
```
> [!TIP|label: Words of wisdom]
> "Would it save you a lot of time if I just gave up and went mad now?" - Arthur Dent

- Make it "flat":
```text
> [!TIP|style: flat]
> "I hope life isn't a big joke, because I don't get it." - Jack Handey
```
> [!TIP|style: flat]
> "I hope life isn't a big joke, because I don't get it." - Jack Handey

- Hide the icon:
```text
> [!TIP|iconVisibility:hidden]
> "Maybe in order to understand mankind, we have to look at the word itself. Basically, 
> it's made up of two separate words — 'mank' and 'ind.' What do these words mean? 
> It's a mystery, and > that's why so is mankind." - Jack Handey
```
> [!TIP|iconVisibility:hidden]
> "Maybe in order to understand mankind, we have to look at the word itself. Basically, 
> it's made up of two separate words — 'mank' and 'ind.' What do these words mean? 
> It's a mystery, and > that's why so is mankind." - Jack Handey

- Hide the label:
```text
> [!TIP|labelVisibility:hidden]
> "I think the monkeys at the zoo should have to wear sunglasses so they can't hypnotize 
> you." - Jack Handey
```
> [!TIP|labelVisibility:hidden]
> "I think the monkeys at the zoo should have to wear sunglasses so they can't hypnotize 
> you." - Jack Handey

- Custom icon
```text
> [!TIP|icon:fas fa-skull]
> "If you ever drop your keys into a river of molten lava, let 'em go, because, man, 
> they're gone." - Jack Handey
```
> [!TIP|icon:fas fa-skull]
> "If you ever drop your keys into a river of molten lava, let 'em go, because, man, 
> they're gone." - Jack Handey


### Customized admonitions

These are custom admonitions, configured in `index.html` with icons from Font Awesome
(bundled with container image, and linked in `index.html`).

- See original java script:
  https://github.com/fzankl/docsify-plugin-flexible-alerts/blob/main/src/index.js


- 
```text
> [!QUOTE]
> An alert of type 'quote' using style 'callout' with default settings.
```
> [!QUOTE]
> An alert of type 'quote' using style 'callout' with default settings.

------------------------------------------------------------------------------

- 
```text
> [!COMMENT]
> An alert of type 'comment' using style 'callout' with default settings.
```
> [!COMMENT]
> An alert of type 'comment' using style 'callout' with default settings.

    - In `index.html` we apply this mapping: `className: 'note'`. Thus `COMMENT` will 
      inherit the CSS-class from `NOTE` and have the same look and feel, although a 
      different icon.

------------------------------------------------------------------------------

- 
```text
> [!abstract]
> An alert of type 'abstract' using style 'callout' with default settings.
```
> [!ABSTRACT]
> An alert of type 'abstract' using style 'callout' with default settings.

------------------------------------------------------------------------------

- 
```text
> [!bug]
> An alert of type 'bug' using style 'callout' with default settings.
```
> [!bug]
> An alert of type 'bug' using style 'callout' with default settings.


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



