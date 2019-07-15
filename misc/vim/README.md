# Vim

## GVim

```bash
# Ubuntu
$ apt-get install vim-gnome

# CentOS
$ yum install vim-X11
```

## 快捷键

| 快捷键   | 命令                  |
| -------- | --------------------- |
| 保存     | `:w`                  |
| 退出     | `:q`                  |
| 强制退出 | `:q!`                 |
| 保存退出 | `:wq`                 |
| 替换     | `:%s/原内容/现内容/g` |
| 剪切     |                       |
| 复制     |                       |
| 粘贴     |                       |
| 选取     |                       |
| 全选     |                       |
| 删除     |                       |

## Neovim

### 安装

```bash
$ curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
$ chmod u+x nvim.appimage

# 拷贝到全局可执行路径
$ sudo cp nvim.appimage /usr/local/bin/nvim

# 改变权限，确保普通用户可使用
$ sudo chmod a+rwX /usr/local/bin/nvim
```

## 参考

* [vim常用命令总结](http://www.cnblogs.com/yangjig/p/6014198.html)
* [文本三巨头：zsh、tmux 和 vim](http://blog.jobbole.com/86571/)