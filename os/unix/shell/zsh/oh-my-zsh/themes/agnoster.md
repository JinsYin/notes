# Agnoster 主题

## Powerline 字体

### 安装字体

```sh
# clone
$ git clone https://github.com/powerline/fonts.git --depth=1

# install
$ cd fonts && ./install.sh

# clean-up
$ cd .. && rm -rf fonts
```

### 设置终端主题

* iTerm2

【iTerm2】 -> 【Preferences...】 -> 【Profiles】 -> 【Colors】 -> 【Color Presets...】 -> 【Solarized Dark】

* MacOS Terminal

```sh
# 下载后双击安装 Solarized Dark 主题
$ git clone https://raw.githubusercontent.com/altercation/solarized/master/osx-terminal.app-colors-solarized/Solarized%20Dark%20ansi.terminal
```

【Terminal】 -> 【Preferences...】 -> 【Profiles】 -> 设置【Solarized Dark】为默认主题

### 更改终端字体

* Gnome Terminal

【Edit】 -> 【Profiles...】 -> 【Edit】 -> 取消【Use the system fixed width font】 -> 选择【Ubuntu Mono derivative Powerline | 13】或【Noto Mono for Powerline | 11】等字体及大小

* iTerm2

【iTerm2】 -> 【Preferences...】 -> 【Profiles】 -> 【Text】 -> 【Font】 -> 选择【Cousine for Powerline】或【Roboto Mono for Powerline】等字体（默认字体是 ”Monaco“）

* MacOS Terminal

【Terminal】 -> 【Preferences...】 -> 【Profiles】 -> 选择默认主题 -> 【Text】 -> 【Font】 -> 【Change...】 -> 【Noto Mono for Powerline】或【Roboto Mono for Powerline】等字体

### 测试字体

```sh
$ echo "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"
```
