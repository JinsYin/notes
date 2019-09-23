# history 插件

## 实现

```sh
$ cat $ZSH/plugins/history/history.plugin.zsh
alias h='history'

function hs
{
    history | grep $*
}

alias hsi='hs -i'
```

## 用法

```sh
$ h
```

```sh
$ hs cd # 搜索 cd 相关的历史命令
```

* 使 history 命令显示时间格式

```sh
$ vi ~/.zshrc
...
HIST_STAMPS="yyyy-mm-dd"
...
```
