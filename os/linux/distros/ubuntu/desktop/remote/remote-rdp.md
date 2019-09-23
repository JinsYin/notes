# RDP 远程连接

Windows 默认使用 `RDP` 协议（端口：`3389`）开启远程连接，所以客户端客也需要使用该协议来连接远程。

## 设置

* 安装

```sh
$ sudo apt-get update

# 安装 xRDP
$ sudo apt-get install xrdp

# 安装 XFCE4
$ sudo apt-get install xfce4
```

* 配置 xRDP

```sh
# 不要在 root 用户下配置，而是在登录用户下
$ echo xfce4-session > ~/.xsession

$ sudo vi /etc/xrdp/startwm.sh
#!/bin/sh

if [ -r /etc/default/locale ]; then
  . /etc/default/locale
  export LANG LANGUAGE
fi

startxfce4
```

* 重启 xRDP

```sh
$ sudo service xrdp restart
```

## 参考

* [Can I access Ubuntu from Windows remotely?](https://askubuntu.com/questions/592537/can-i-access-ubuntu-from-windows-remotely)
* [How To Setup Ubuntu Remote Desktop XRDP Server for Windows Client](https://www.youtube.com/watch?v=gFdBSyy4xcM)
