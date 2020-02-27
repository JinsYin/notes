# Shell  别名

```sh
alias ..="cd .."
alias ~="cd ~"
alias -="cd -"
alias /="cd /"

alias ll="ls -hail"
alias md="mkdir -p"
alias rd="rmdir"
alias cp="cp -i"
alias rd="rm -r"
alias mkdir="mkdir -p"
alias os="cat /etc/os-release" # linux
alias sum="paste -sd+ - | bc" # 对列进行求和
alias reload="exec ${SHELL} -l" # Reload the shell (i.e. invoke as a login shell)
alias .zshrc="vi ~/.zshrc"
alias .bashrc="vi ~/.bashrc"
alias zshrc="source ~/.zshrc"
alias bashrc="source ~/.bashrc"

alias HOME="echo $HOME"
alias path="echo -e ${PATH//:/\\n}" # Print each PATH entry on a separate line
alias PATH="echo $PATH"

alias home="cd ~"
alias doc="cd ~/Documents"
alias down="cd ~/Downloads"
alias desk="cd ~/Desktop"
alias tmp="cd /tmp"
alias opt="cd /opt"
alias dev="cd /dev"
alias var="cd /var"
```

> zsh 默认设置了很多不错的别名

## 参考

* [github.com/mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles/blob/master/.aliases)
