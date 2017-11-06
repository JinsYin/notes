# Shadowsocks 

Shadowsocks 也通常简称 ss，支持 `sock4` 、`sock5`、`http`、`https` 等代理方式。


## 服务端部署 Shadowsocks server

* docker

```bash
$ docker run -d --name ss --restart=always -p 1314:1314 ficapy/shadowsocks -s 0.0.0.0 -p 1314 -k password -m aes-256-cfb
```

* ubuntu

```bash
$ apt-get install python-pip

$ # 安装最新版本
$ pip install git+https://github.com/shadowsocks/shadowsocks.git@master

$ # 安装指定版本版本
$ pip install git+https://github.com/shadowsocks/shadowsocks.git@2.8.2

$ # 命令行后台部署
$ ssserver -s 0.0.0.0 -p 8788 -k password -m aes-256-cfb -d start

$ # 停止
$ ssserver -d stop
```

* centos

```bash
$ yum install python-setuptools && easy_install pip
$ pip install git+https://github.com/shadowsocks/shadowsocks.git@master

$ # 使用配置文件来部署，https://github.com/shadowsocks/shadowsocks/wiki/Configuration-via-Config-File
$ ssserver -c /etc/shadowsocks.json -d start

$ cat /etc/shadowsocks.json
{
  "server":"12.34.56.78",
  "server_port":8388,
  "local_address": "127.0.0.1",
  "local_port":1080,
  "password":"mypassword",
  "timeout":300,
  "method":"aes-256-cfb",
  "fast_open": false
}

$ # 停止
$ ssserver -c /etc/shadowsocks.json -d stop
```


## 安装 GUI 客户端　shadowsocks-qt5

shadowsocks-qt5 用于直连 shadowsocks server，所以需要在 shadowsocks-qt5 中配置用于连接 shadowsocks server 的 host ip、port、密码、加密方式的信息。

* ubuntu

```bash
$ sudo add-apt-repository ppa:hzwhuang/ss-qt5
$ sudo apt-get update
$ sudo apt-get install shadowsocks-qt5
```


## 安装命令行客户端 shadowsocks-libev

shadowsocks-libev 既可以用作 shadowsocks server（`ss-server`，配置和 shadowsocks 几乎是一样的），又可以用作 shadowsocks client （`ss-local`）， 但常被用作客户端。使用 shadowsocks-libev 可以在企业内部服务器上搭建一个供内部人员使用的无密钥代理（二层代理），从而避免内部人员直接通过密钥连接远程的代理，此时的 shadowsocks-libev 对于内部人员来说其实是一个服务端。

* ubuntu

```bash
$ # 安装 shadowsocks-libev
$ sudo apt-get install software-properties-common -y
$ sudo add-apt-repository ppa:max-c-lv/shadowsocks-libev
$ sudo apt-get update
$ sudo apt install shadowsocks-libev
```

客户端：

```bash
$ vi /etc/shadowsocks-libev/config.json
{
  "server":"12.34.56.78",
  "server_port":8388,
  "local_address": "0.0.0.0",
  "local_port":1080,
  "password":"mypassword",
  "timeout":60,
  "method":"aes-256-cfb"
}

$ # 启动 shadowsocks client
$ nohup ss-local -c /etc/shadowsocks-libev/config.json >> /var/log/shadowsocks-libev.log &
```

服务端：

```bash
$ # 修改配置
$ vi /etc/shadowsocks-libev/config.json
$ vi /etc/default/shadowsocks-libev

$ # 启动 shadowsocks server （ss-server）
$ /etc/init.d/shadowsocks-libev start
```

* centos

```bash
$ # 安装 shadowsocks-libev
$ yum install epel-release -y
$ yum install gcc gettext autoconf libtool automake make pcre-devel asciidoc xmlto c-ares-devel libev-devel libsodium-devel mbedtls-devel -y

$ # 添加 shadowsocks-libev 源：https://copr.fedorainfracloud.org/coprs/librehat/shadowsocks/
$ vi /etc/yum.repos.d/shadowsocks-libev.repo

$ # yum update
$ yum install shadowsocks-libev
```

服务端：

```bash
$ # 修改配置
$ vi /etc/shadowsocks-libev/config.json
$ vi /etc/sysconfig/shadowsocks-libev

$ # 运行 shadowsocks server （ss-server）
$ systemctl start shadowsocks-libev
```


## Ubuntu 配置代理

* 全局手动代理

`System Settings` > `Network` > `Network proxy` > `Manual` > 仅在 Socks Host 栏中填写本地的 sock 主机和端口，默认是: `127.0.0.1` 和 `1080`。

* 全局自动代理

使用自动代理需要配置 PAC （Proxy Autoproxy Config，代理自动配置）。[GenPAC](https://github.com/JinnLynn/GenPAC) 是基于 gfwlist 的 PAC 文件生成工具，支持自定义规则。

```bash
$ # 安装最新版本的 genpac
$ pip install --upgrade https://github.com/JinnLynn/genpac/archive/master.zip

$ # 生成 pac 文件到指定路径中
$ genpac --pac-proxy "SOCKS5 127.0.0.1:1080" --gfwlist-proxy="SOCKS5 127.0.0.1:1080" --output="/home/yin/shadowsocks/autoproxy.pac" --gfwlist-url="https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt"
```

`System Settings` > `Network` > `Network proxy` > `Automatic` > 填入 pac 文件路径：`file:///home/yin/shadowsocks/autoproxy.pac`。


## 配置文件

* [gfwlist](https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt)：大陆白名单（需要使用 ss 的墙外网站列表）
* [gui-config](./gui-config.json): ss 客户端配置，请自行修改


## Shadowsocks 客户端下载地址

* [IOS](https://github.com/shadowsocks/shadowsocks-iOS/releases)
* [Android](https://github.com/shadowsocks/shadowsocks-android/releases)
* [Linux](https://github.com/shadowsocks/shadowsocks-qt5/releases)
* [Windows](https://github.com/shadowsocks/shadowsocks-windows/releases)


## 参考

* [shadowsocks-qt5 安装指南](https://github.com/shadowsocks/shadowsocks-qt5/wiki/%E5%AE%89%E8%A3%85%E6%8C%87%E5%8D%97)
* [JinnLynn/GenPAC](https://github.com/JinnLynn/GenPAC)
* [在 Ubuntu 下设置 Shadowsocks 为 pac 自动代理](https://www.mengdodo.com/?p=7330)
* [ubuntu 14 安装 shadowsocks-qt5 并配置 pac 全局代理](http://blog.csdn.net/strokess/article/details/52015014)
* [shadowsocks/shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev)