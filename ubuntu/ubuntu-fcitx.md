# Ubuntu 配置 fcitx

## 安装 fcitx

如果无意间卸载了 fcitx，可以重新安装。
```bash
$ sudo add-apt-repository -y ppa:fcitx-team/stable
$ sudo apt-get -y update
$ sudo apt-get install -y fcitx
```

## 添加输入法

使用搜狗等输入法，需要确保使用的键盘输入系统是 `fcitx`，如果不是，打开 `Language Support` 软件设置为默认，或者打开 `Input Method` 软件进行设置。安装好搜狗拼音之后，到 `fcitx configuration` 软件中添加搜狗输入法。
