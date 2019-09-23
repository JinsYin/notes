# Tmux

Tmux 即 terminal multiplexer，它可以在单个屏幕中创建多个终端/窗口，每个窗口运行独立的程序。Tmux 还可以在后台运行，然后重新连接。

## 安装

系统内置的 tmux 比较久，某些功能可能不支持。

* 内置安装

```sh
# Ubuntu
$ apt-get install -y tmux

# CentOS
$ yum install -y tmux
```

* 安装最新（推荐）

```sh
sudo -i

TMUX_VER="2.7"

apt-get update
apt-get install -y libevent-dev libncurses-dev make
wget https://github.com/tmux/tmux/releases/download/${TMUX_VER}/tmux-${TMUX_VER}.tar.gz
tar xvzf tmux-${TMUX_VER}.tar.gz
rm  tmux-${TMUX_VER}.tar.gz
cd tmux-${TMUX_VER}/
./configure && make
make install

cp ./tmux /usr/local/bin/
```

## 基本概念

* 会话（session）
* 窗口（window）
* 面板（pane）

关系：一个会话可以包含多个窗口，一个窗口又可以包含多个面板。

## 快捷键

快捷键前缀：`ctrl + b`，目的是区分 Tmux 命令和其他 Shell 命令，避免冲突。

| 快捷键命令      | 描述                                           |
| --------------- | ---------------------------------------------- |
| `?`             | 显示快捷键帮助文档                             |
| `%`             | 垂直分割窗口（window）为多个窗格（pane）       |
| `"`             | 水平分割窗口（window）为多个窗格（pane）       |
| `c`             | 创建一个新窗口                                 |
| `d`             | detached；保存 tmux 会话在后台，并回到正常终端 |
| `D`             | detached；选择要断开的会话                     |
| `x`             | 关闭 pane                                      |
| `s`             | 调出切换窗口（window）的列表                   |
| `z`             | 最大化当前面板（pane），重复一次恢复正常       |
| `0` `1` `2`     | 切换到某个窗口（window）                       |
| `→` `←` `↑` `↓` | 切换窗格（pane）                               |
| `o`             | 依次切换 pane                                  |

## 配置

### 配置文件

用户配置文件：`~/.tmux.conf`，全局配置文件：`/etc/tmux.conf`。

```sh
$ vi ~/.tmux.conf
# 将快捷键前缀 `Ctrl+b` 修改为 `Ctrl+a`
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# 设置第二个快捷键前缀
set-option -g prefix2 F12

# 设置快捷键 r 用于重载配置文件，等同于 `ctrl+b` + `:` + `source-file ～/.tmux.conf`
bind-key r source-file ~/.tmux.conf \; display-message "Config reloaded..."

# 新增 DELETE 快捷键来删除 pane（）
bind-key DC kill-pane

#
bind-key + new-window

# v2.1 之前的版本
setw -g mode-mouse on # 支持鼠标选取文本等
setw -g mouse-resize-pane on # 支持鼠标拖动调整面板的大小(通过拖动面板间的分割线)
setw -g mouse-select-pane on # 支持鼠标选中并切换面板
setw -g mouse-select-window on # 支持鼠标选中并切换窗口(通过点击状态栏窗口名称)

# v2.1 之后
set-option -g mouse on # 等同于以上4个指令的效果

# 绑定 hjkl 键为面板切换的上下左右键（-r 表示可以在 500ms 内重复按键）
bind -r k select-pane -U # ↑
bind -r j select-pane -D # ↓
bind -r h select-pane -L # ←
bind -r l select-pane -R # →

# 绑定 Ctrl+hjkl 键为面板上下左右调整边缘的快捷指令
bind -r C-k resize-pane -U 10 # 绑定Ctrl+k为往↑调整面板边缘10个单元格
bind -r C-j resize-pane -D 10 # 绑定Ctrl+j为往↓调整面板边缘10个单元格
bind -r C-h resize-pane -L 10 # 绑定Ctrl+h为往←调整面板边缘10个单元格
bind -r C-l resize-pane -R 10 # 绑定Ctrl+l为往→调整面板边缘10个单元格

# 修改第一个窗口的编号
set-option -g base-index 1
```

```sh
# 生效
$ tmux source ~/.tmux.conf
```

### 配置命令

```sh
# 方式二
$ tmux set -g prefix C-s
```

## 命令

```sh
# 查看快捷键
$ tmux list-keys

# 查看所有的 tmux 会话
$ tmux ls

# 新建会话
$ tmux new
$ tmux new -s <session-name>

# 连接最近使用的 tmux 会话
$ tmux a

# 连接到指定会话
$ tmux a -t <session-name>
```

## 保存会话

* Resurrect

```sh
mkdir ~/.tmux/plugins && cd ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tmux-resurrect.git
```

```sh
# 增加配置
$ vi ~/.tmux.conf
run-shell ~/.tmux/plugins/tmux-resurrect/resurrect.tmux
```

保存：prefix + `Ctrl+s`
恢复：prefix + `Ctrl+r`

## 参考

* [文本三巨头：zsh、tmux 和 vim](http://blog.jobbole.com/86571/)
* [What are valid keys for tmux?](https://unix.stackexchange.com/questions/140007/what-are-valid-keys-for-tmux)
