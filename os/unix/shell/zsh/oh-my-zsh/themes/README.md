# Oh-My-Zsh 主题

| 主题                                                                               | 描述     |
| ---------------------------------------------------------------------------------- | -------- |
| [robbyrussell](https://github.com/robbyrussell/oh-my-zsh/wiki/Themes#robbyrussell) | 默认主题 |
| [agnoster](https://github.com/agnoster/agnoster-zsh-theme)                         |          |

## 主题原理

Oh-my-zsh 的主题本质上同样是一个 shell 脚本，位于 `$ZSH/themes/$ZSH_THEME.zsh-theme`。

```sh
$ cat $ZSH/oh-my-zsh.sh
...
if [[ -z "$ZSH_CUSTOM" ]]; then
    ZSH_CUSTOM="$ZSH/custom"
fi
...
if [ ! "$ZSH_THEME" = ""  ]; then
  if [ -f "$ZSH_CUSTOM/$ZSH_THEME.zsh-theme" ]; then
    source "$ZSH_CUSTOM/$ZSH_THEME.zsh-theme"
  elif [ -f "$ZSH_CUSTOM/themes/$ZSH_THEME.zsh-theme" ]; then
    source "$ZSH_CUSTOM/themes/$ZSH_THEME.zsh-theme"
  else
    source "$ZSH/themes/$ZSH_THEME.zsh-theme"
  fi
fi
...
```

## 设置主题

```sh
$ cat ~/.zshrc
...
ZSH_THEME="agnoster"
...
```

```sh
$ source ~/.zshrc
```

