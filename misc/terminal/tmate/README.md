# tmate

Tmate 即 teammates，作为 tmux 的一个分支，它们使用相同的配置（如快捷键）。它是一个终端多路复用器，同时具有即时分享终端的能力。

## 安装 tmate

```sh
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:tmate.io/archive
sudo apt-get update
sudo apt-get install tmate
```

```sh
# tmate show-messages 报错及解决方法
# tmate: /home/yin/anaconda3/lib/libcrypto.so.1.0.0: no version information available (required by /usr/lib/x86_64-linux-gnu/libssh.so.4)
$ mv /home/yin/anaconda3/lib/libcrypto.so.1.0.0 /home/yin/anaconda3/lib/libcrypto.so.1.0.0.bak
```

## 如何工作

* 运行 tmate 时，会通过 libssh 在后台创建一个连接到 <tmate.io> （由 tmate 开发者维护的后台服务器）的 ssh 连接。
* <tmate.io> 服务器的 ssh 密钥通过 DH 交换进行校验。
* 客户端通过本地 ssh 密钥进行认证。
* 连接创建后，本地 tmux 服务器会生成一个 150 位（不可猜测的随机字符）会话令牌。
* 队友能通过用户提供的 SSH 会话 ID 连接到 <tmate.io>。

## 必要条件

由于 <tmate.io> 服务器需要通过本地 ssh 密钥来认证客户机，因此其中一个必备条件就是生成 SSH 密钥 key。 记住，每个系统都要有自己的 SSH 密钥。

```sh
ssh-keygen -t rsa
```