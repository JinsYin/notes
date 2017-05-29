# Ubuntu 开启远程连接服务
Ubuntu 需要使用 vncserver 来开启远程连接， 但 vnc 并不支持 Ubuntu 原生桌面系统(unity)，需要改用 gnome 桌面系统。

## 安装 gnome
```bash
$ sudo apt-get install gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
```

## 具体参考
> http://blog.csdn.net/a105421548/article/details/46379049
