# 安装 Geth

## Ubuntu 环境

```bash
# sudo
$ apt-get install software-properties-common
$ add-apt-repository -y ppa:ethereum/ethereum
$ apt-get update
$ apt-get install geth
```

```bash
$ geth --datadir=~/.ethereum --fast --cache=512
```

## Docker 环境

```bash
$ docker run -d --privileged \
  -n ethereum-node \
  -v /root:/root \
  -p 8545:8545 \
  -p 30303:30303 \
  ethereum/client-go:stable --fast --cache=512
```

## 存储目录

| 目录     | 路径                   |
| -------- | ---------------------- |
| 数据目录 | `~/.ethereum`          |
| 密钥目录 | `~/.ethereum/keystore` |

> 一定要牢记 **密码** 并备份 **密钥文件**，因为从账号发送交易，包括发送以太币，必须同时有密钥文件和密码；如果忘记密码或丢失秘钥文件，将会丢失所有的以太币。