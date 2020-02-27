# Shell 配置

```sh
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vi'
else
  export EDITOR='vim'
fi
```
