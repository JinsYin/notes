# 安装 Oh-my-zsh

## 安装

```sh
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

* 配置目录：`~/.oh-my-zsh/`（`$ZSH` 环境变量的值）
  * 内置主题目录：`~/.oh-my-zsh/themes/`
  * 内置插件目录：`~/.oh-my-zsh/plugins/`
* 定制目录：`$ZSH_CUSTOM`（`~/.oh-my-zsh/custom`）
  * 定制主题目录：`$ZSH_CUSTOM/themes/`
  * 定制插件目录：`$ZSH_CUSTOM/plugins/`

## 更新

手动更新：

```sh
$ upgrade_oh_my_zsh
```

## 卸载

```sh
$ uninstall_oh_my_zsh zsh
```
