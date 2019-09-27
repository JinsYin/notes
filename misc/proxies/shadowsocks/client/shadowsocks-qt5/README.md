# Shadowsocks-QT5 （不再更新）

Shadowsocks-QT5 用于直连 Shadowsocks Server，所以需要在 Shadowsocks-QT5 中配置用于连接 Shadowsocks Server 的 `ip`、`port`、`密码`、`加密方式` 的信息。

## Ubuntu

1. 安装

```sh
$ sudo apt-get -f install libappindicator1 libindicator7 # 依赖
$ sudo add-apt-repository ppa:hzwhuang/ss-qt5
$ sudo apt-get update
$ sudo apt-get install shadowsocks-qt5
```

2. 添加代理 ip 信息，并在本地开一个代理（默认127.0.0.1，端口1080）
3. chrome 安装 [switchomega 插件](https://github.com/FelisCatus/SwitchyOmega/releases)
4. 浏览器配置 (或者直接使用“系统代理”，不用其他配置)
