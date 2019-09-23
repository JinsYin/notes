# Teleconsole

Teleconsole 是一个免费服务，用于与你信任的人共享终端会话，你的朋友可以通过 SSH 和浏览器加入到终端会话中。此外，Teleconsoel 还支持转发本地 TCP 端口。可以将其用于直播或分享。

## 安装

```sh
# 最新
$ curl https://www.teleconsole.com/get.sh | sh
```

## 终端共享

* 启动会话

```sh
$ teleconsole
Starting local SSH server on localhost...
Requesting a disposable SSH proxy on as.teleconsole.com for root...
Checking status of the SSH tunnel...

Your Teleconsole ID: asff06df7c4fd7f1ef83a62bd7b5c85eb06ba31762
WebUI for this session: https://as.teleconsole.com/s/ff06df7c4fd7f1ef83a62bd7b5c85eb06ba31762
To stop broadcasting, exit current shell by typing 'exit' or closing the window.
```

* 好友连接

```sh
# 通过会话 ID 连接
$ teleconsole join asff06df7c4fd7f1ef83a62bd7b5c85eb06ba31762

# 通过 WebUI 连接
$ google-chrome https://as.teleconsole.com/s/ff06df7c4fd7f1ef83a62bd7b5c85eb06ba31762
```

* 关闭会话

```sh
# Ctrl+d
$ exit
```

## 端口转发

* 启动会话

```sh
# 假设想要邀请好友访问本地的 localhost:8888 服务
$ teleconsole -f localhost:8888 # 可以省略 localhost
Starting local SSH server on localhost...
Requesting a disposable SSH proxy on as.teleconsole.com for root...
Checking status of the SSH tunnel...

Your Teleconsole ID: as9dd31d9f5b3de0c7ebea12a8999d694cdaab83d9
WebUI for this session: https://as.teleconsole.com/s/9dd31d9f5b3de0c7ebea12a8999d694cdaab83d9
```

* 好友访问

```sh
# 新增 ATTENTION，好友可以通过 localhost:9000 访问到代理端相应的服务
$ teleconsole join as9dd31d9f5b3de0c7ebea12a8999d694cdaab83d9
Teleconsole: joining session...
ATTENTION: yin has invited you to access port 8888 on their machine via localhost:9000
```

> 注：由于 Teleconsole 仅是一个 SSH 服务器，因此您与之共享会话 ID 的任何人都可以在不通知您的请求下访问端口转发的服务

## 参考

* [github.com/gravitational/teleconsole](https://github.com/gravitational/teleconsole)
* [Teleconsole - 与您的朋友分享您的 Linux 终端](https://www.howtoing.com/teleconsole-share-linux-terminal-session-with-friends)
