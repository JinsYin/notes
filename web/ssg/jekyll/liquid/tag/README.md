---
render_with_liquid: false # (jekyll 4.0) https://jekyllrb.com/docs/liquid/tags/#code-snippet-highlighting
---

# Tag

## include

```html
```

## capture

## assign

```html
{% assign children_list = site.pages | sort:"nav_order" %}
```

## highlight

```html
{% highlight javascript %}
module.exports = app => {
  app.on('issues.opened', async context => {
    const params = context.issue({
      body: 'Hello World!'
    })
    await context.github.issues.createComment(params)
  })
}
{% endhighlight %}
```

## link

```html
```
