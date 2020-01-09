# Filter

## Object

URL Filter:

```liquid
{{ page.url | absolute_url }}
```

```liquid
{{ site.lang | default: "en-US" }}
```

```html
<link rel="stylesheet" href="{{ '/assets/css/just-the-docs.css' | absolute_url }}">
```

## Tag

```liquid
{% assign pages = site.pages | sort:"nav_order" %}
```

```liquid
{% assign content_ = content_ | replace: '</table>', '</table></div>' %}
```

## relative_url

`/my-baseurl/assets/style.css`:

```liquid
{{ "/assets/style.css" | relative_url }}

{{ "/assets/style.css" | prepend: site.baseurl }}
```

## absolute_url

`http://example.com/my-baseurl/assets/style.css`:

```liqiud
{{ "/assets/style.css" | absolute_url }}

{{ "/assets/style.css" | prepend: site.url | prepend: site.baseurl }}
```
