# Oh My Zsh

Oh-My-Zsh 是一个 Zsh 的配置管理框架（包括主题管理和插件管理），内置了大量插件和主题以及一个自动更新工具。

## 目录

## Issue

* 进入 Git 仓库目录存在卡顿问题 - 原因是 oh-my-zsh 需要获取 Git 更新信息

```sh
# 设置 oh-my-zsh 不读取文件变化信息
$ git config --global --add oh-my-zsh.hide-dirty 1

# 甚之：禁止 oh-my-zsh 自动获取 Git 信息
$ git config --global --add oh-my-zsh.hide-dirty 1
```

## 参考

* [github.com/robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
