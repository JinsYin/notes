## d

查看最近访问的目录，通过键入数字并回车即可返回到历史目录。

## 实现

```zsh
d () {
	if [[ -n $1 ]]
	then
		dirs "$@"
	else
		dirs -v | head -10
	fi
}

```

## 示例

```sh
yin@Yin:~ $
yin@Yin:~ $ cd Downloads
yin@Yin:~/Downloads $
yin@Yin:~/Downloads $ d
0	~/Downloads
1	~
yin@Yin:~/Downloads $ 1
~
yin@Yin:~ $
```
