# Shadowsocks

Shadowsocks 也通常简称 ss，支持 `sock4` 、`sock5`、`http`、`https` 等代理协议。

## Server

### 使用 [shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev) 【推荐】

Shadowsocks-libev 既可以用作 shadowsocks server（`ss-server`，配置和 shadowsocks 几乎是一样的），又可以用作 shadowsocks client （`ss-local`），但常被用作客户端。
使用 shadowsocks-libev 可以在企业内部服务器上搭建一个供内部人员使用的无密钥代理（二层代理），从而避免内部人员直接通过密钥连接远程的代理（如果有此需求可以考虑 [shadowsocks-manager](https://github.com/shadowsocks/shadowsocks-manager)），此时的 shadowsocks-libev 对于内部人员来说其实是一个服务端（另外使用 DNS 也是一种选择）。

* Docker

```sh
# 官方希望你是这样使用的（docker inspect），但这样只能作为 Server 使用
$ docker run -d --name ss-server --restart=always \
  -p 1314:1314 \
  -e SERVER_ADDR=0.0.0.0 \
  -e SERVER_PORT=1314 \
  -e PASSWORD=xxx \
  -e METHOD=aes-256-cfb \
  -e TIMEOUT=300 \
  -e DNS_ADDRS=8.8.8.8,8.8.4.4 \
  shadowsocks/shadowsocks-libev

# 建议（最新版本可能不稳定，建议使用指定版本的镜像）
$ docker run -d --name ss-server -p 1314:1314 --restart=always \
  shadowsocks/shadowsocks-libev ss-server -s 0.0.0.0 -p 1314 -k xxx -m aes-256-cfb
```

* Ubuntu

```sh
# 安装 shadowsocks-libev
$ sudo apt-get install software-properties-common -y
$ sudo add-apt-repository ppa:max-c-lv/shadowsocks-libev
$ sudo apt-get update
$ sudo apt install shadowsocks-libev
```

```sh
# 修改配置
$ vi /etc/default/shadowsocks-libev
$ vi /etc/shadowsocks-libev/config.json
{
  "server":"12.34.56.78", # 外网 IP
  "server_port":8388,
  "local_address":"0.0.0.0",
  "local_port":1080,
  "password":"mypassword",
  "timeout":60,
  "method":"aes-256-cfb"
}

# 启动 shadowsocks server （ss-server）
$ /etc/init.d/shadowsocks-libev start
```

* CentOS

```sh
# 安装 shadowsocks-libev
$ yum install epel-release -y
$ yum install gcc gettext autoconf libtool automake make pcre-devel asciidoc xmlto c-ares-devel libev-devel libsodium-devel mbedtls-devel -y

# 添加 shadowsocks-libev 源：https://copr.fedorainfracloud.org/coprs/librehat/shadowsocks/
$ vi /etc/yum.repos.d/shadowsocks-libev.repo

$ yum install shadowsocks-libev
```

### 使用 [shadowsocks](https://github.com/shadowsocks/shadowsocks/tree/master) 【不怎么更新了】

* Docker

```sh
$ docker run -d --name ss --restart=always -p 1314:1314 ficapy/shadowsocks -s 0.0.0.0 -p 1314 -k password -m aes-256-cfb
```

* Ubuntu

```sh
$ apt-get install python-pip

# 安装最新版本
$ pip install git+https://github.com/shadowsocks/shadowsocks.git@master

# 安装指定版本版本
$ pip install git+https://github.com/shadowsocks/shadowsocks.git@2.8.2

# 命令行后台部署
$ ssserver -s 0.0.0.0 -p 8788 -k password -m aes-256-cfb -d start

# 停止
$ ssserver -d stop
```

* CentOS

```sh
$ yum install python-setuptools && easy_install pip
$ pip install git+https://github.com/shadowsocks/shadowsocks.git@master

# 使用配置文件来部署，https://github.com/shadowsocks/shadowsocks/wiki/Configuration-via-Config-File
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

# 停止
$ ssserver -c /etc/shadowsocks.json -d stop
```

```sh
# 修改配置
$ vi /etc/shadowsocks-libev/config.json
$ vi /etc/sysconfig/shadowsocks-libev

# 运行 shadowsocks server （ss-server）
$ systemctl start shadowsocks-libev
```

## Client

### 使用 shadowsocks-qt5 （不再更新）

shadowsocks-qt5 用于直连 shadowsocks server，所以需要在 shadowsocks-qt5 中配置用于连接 shadowsocks server 的 host ip、port、密码、加密方式的信息。

* ubuntu

```sh
$ sudo add-apt-repository ppa:hzwhuang/ss-qt5
$ sudo apt-get update
$ sudo apt-get install shadowsocks-qt5
```

### 使用 shadowsocks-libev

* Docker

```sh
# 端口映射不知道为什么不可行
$ docker run -d --name ss-local --net=host --restart=always \
  shadowsocks/shadowsocks-libev ss-local -s 12.34.56.78 -p 1314 -l 1080 -k xxx -m aes-256-cfb
```

* Ubuntu

```sh
# 配置
$ vi /etc/shadowsocks-libev/config.json
{
  "server":"12.34.56.78",
  "server_port":8388,
  "local_address":"0.0.0.0",
  "local_port":1080,
  "password":"mypassword",
  "timeout":60,
  "method":"aes-256-cfb"
}

# 启动 shadowsocks client
$ nohup ss-local -c /etc/shadowsocks-libev/config.json >> /var/log/shadowsocks-libev.log &
```

* CentOS

除配置路径与 Ubuntu 有所不同外，其他均一致：

```sh
# 配置
$ vi /etc/shadowsocks-libev/config.json
$ vi /etc/sysconfig/shadowsocks-libev
```

## Privoxy

利用 Privoxy 可以将 socks 转成 http 。

## 参考

* [科学上网漫游指南](https://lvii.gitbooks.io/outman/content/)
* [shadowsocks-qt5 安装指南](https://github.com/shadowsocks/shadowsocks-qt5/wiki/%E5%AE%89%E8%A3%85%E6%8C%87%E5%8D%97)
* [JinnLynn/GenPAC](https://github.com/JinnLynn/GenPAC)
* [在 Ubuntu 下设置 Shadowsocks 为 pac 自动代理](https://www.mengdodo.com/?p=7330)
* [ubuntu 14 安装 shadowsocks-qt5 并配置 pac 全局代理](http://blog.csdn.net/strokess/article/details/52015014)
* [shadowsocks/shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev)