# zsh_stats

查询使用频率前 20 的命令

## 实现

```zsh
$ which zsh_stats
zsh_stats () {
	fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}
```

## 示例

```zsh
$
```
