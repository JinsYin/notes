# Wireshark

## 安装

```sh
apt-get install wireshark
```

## 普通用户运行 wireshark

Wireshark 实际的抓包工具是 dumpcap，默认情况下它访问网络设备需要 `root` 权限，所以当普通用户使用 wireshark 时是无法读取读取网络设备的。

```sh
sudo groupadd wireshark

sudo usermod -a -G wireshark <You own username>

sudo chgrp wireshark /usr/bin/dumpcap

sudo chmod 750 /usr/bin/dumpcap

sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap

sudo getcap /usr/bin/dumpcap
```

## 启动 npf

```sh
# Windows
$ net start npf
```
