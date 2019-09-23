# Oh-My-Zsh 插件

| 插件              | 路径                                      | 描述                                        |
| ----------------- | ----------------------------------------- | ------------------------------------------- |
| git               | `$ZSH/plugins/git/git.plugin.zsh`         | Git 别名、分支信息                          |
| extract           | `$ZSH/plugins/extract/extract.plugin.zsh` | 使用 `x` 命令可以一键解压所有类型的压缩文件 |
| autojump          |                                           |                                             |
| colored-man       |                                           |                                             |
| colorize          |                                           |                                             |
| copydir           |                                           |                                             |
| command-not-found |                                           |                                             |
| history           |                                           |                                             |
| sublime           |                                           |                                             |
| brew              |                                           |                                             |
| osx               |                                           |                                             |
| z                 |                                           |                                             |

## 添加插件

```zsh
$ vi ~/.zshrc
...
plugins=(
    git
)
...
```

```sh
$ source ~/.zshrc
```

## 插件原理

Oh-my-zsh 的插件本质上是一个 zsh shell 脚本，位于 `$ZSH/plugins/$plugin/$plugin.plugin.zsh`。

```sh
$ cat ~/.zshrc
...
export ZSH="/home/yin/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git ...)
source $ZSH/oh-my-zsh.sh
...
```

```sh
$ cat $ZSH/oh-my-zsh.sh
...
if [[ -z "$ZSH_CUSTOM" ]]; then
    ZSH_CUSTOM="$ZSH/custom"
fi

...

# Load all of the plugins that were defined in ~/.zshrc
for plugin ($plugins); do
  if [ -f $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh
  elif [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH/plugins/$plugin/$plugin.plugin.zsh
  fi
done
...
```
