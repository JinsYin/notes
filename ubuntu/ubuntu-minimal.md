# Ubuntu 最小化安装

## 卸载不常用的软件
```bash
$ sudo apt-get remove -y gnome-sudoku aisleriot gnome-mahjongg gnome-font-viewer gnome-calculator gnome-contacts gucharmap deja-dup gnome-disk-utility xdiagnose empathy thunderbird xul-ext-ubufox landscape-client-ui-install brasero gnome-orca gnome-power-manager update-manager-kde update-manager-kde update-manager-kde webbrowser-app libreoffice* unity-scope-gdrive
```

```bash
$ sudo apt-get -y autoremove
```

## 安装 sogou pinyin
需要确保使用的键盘输入系统是 `fcitx`，如果不是，打开 `Language Support` 软件设置为默认,或者打开 `Input Method` 软件进行设置。安装好搜狗拼音之后，到 `fcitx configuration` 软件中添加搜狗输入法。
> http://pinyin.sogou.com/linux/

## 安装 fcitx
如果无意间卸载了 fcitx，可以重新安装。
```bash
$ sudo add-apt-repository -y ppa:fcitx-team/stable
$ sudo apt-get -y update
$ sudo apt-get install -y fcitx
```

## 安装 chromium
```bash
$ sudo apt-get install -y chromium-browser
```

## 安装 vim
```bash
$ sudo apt-get -y vim
```

## 安装 lantern
> https://github.com/getlantern/lantern

## 卸载 firefox
```bash
$ sudo apt-get remove -y firefox
```

## 移除 repos
```bash
$ rm -rf /etc/apt/sources.list.d/*
```

## 最后

注销或者重启


## 参考文章
> http://forum.ubuntu.org.cn/viewtopic.php?p=2546782
