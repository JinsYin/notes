# Shadowsocks 客户端

## 使用 shadowsocks-qt5 （不再更新）

shadowsocks-qt5 用于直连 shadowsocks server，所以需要在 shadowsocks-qt5 中配置用于连接 shadowsocks server 的 host ip、port、密码、加密方式的信息。

* ubuntu

```sh
$ sudo add-apt-repository ppa:hzwhuang/ss-qt5
$ sudo apt-get update
$ sudo apt-get install shadowsocks-qt5
```

## 使用 ShadowsocksX-NG

## 使用 shadowsocks-libev

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
