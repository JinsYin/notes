# take

## 实现

```zsh
$ which take
take () {
	mkdir -p $@ && cd ${@:$#}
}
```
