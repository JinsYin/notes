# 对象

## forloop

forloop.length -- length of the entire for loop
forloop.index -- index of the current iteration
forloop.index0 -- index of the current iteration (zero based)
forloop.rindex -- how many items are still left?
forloop.rindex0 -- how many items are still left? (zero based)
forloop.first -- is this the first iteration?
forloop.last -- is this the last iteration?

```liquid
{{ forloop.index0 }}

{{ forloop.last }}
```
