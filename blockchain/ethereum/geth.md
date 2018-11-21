# Geth

Geth 是以太坊的一个客户端通讯软件，是以太坊网络和个人计算机之间的“继电器”，可以下载和同步区块链。还把信息传输到挖矿软件。

## 安装运行

* Ubuntu

```bash
# susod
$ apt-get install software-properties-common
$ add-apt-repository -y ppa:ethereum/ethereum
$ apt-get update
$ apt-get install geth
```

```bash
$ geth --datadir=/root/.ethereum --fast --cache=512
```

* Docker

[ethereum/client-go](https://hub.docker.com/r/ethereum/client-go/)

```bash
$ docker run -d --name ethereum-node --privileged -v /root:/root
  -p 8545:8545 -p 30303:30303 ethereum/client-go:stable --fast --cache=512
```

> 数据目录位于 `/root/.ethereum`，密钥文件位于 `/root/.ethereum/keystore` 目录下。
> 注意：一定要牢记密码并备份密钥文件，因为从账号发送交易，包括发送以太币，必须同时有密钥文件和密码；如果忘记密码或丢失秘钥文件，将会丢失所有的以太币。

## 命令

```bash
# 创新新账户
$ geth account new

# 查询
$ geth account list
```

```bash
$ geth console
>
> # 查询账户
> eth.accounts
> personal.listAccounts
>
> # 新建账户
> personal.newAccount('your-passowrd')
>
> # 启动挖矿
> miner.start()
>
> # 停止挖矿
> miner.stop()
>
> # 查询账户余额
> eth.getBalance(eth.accounts[0])
>
> # 定义、编译只能合约
> source = "contract test { function multiply(uint a) returns(uint d) { return a * 7; } }"
> contract = eth.compile.solidity(source).test

# 设置 etherbase
> miner.setEtherbase(eth.accounts[n]) //etherbase地址并不需要一定是本机上
```

## 钱包

需要先同步区块。

* Mist
* Ethereum Wallet

## 参考

* [Installing Go Ethereum](https://geth.ethereum.org/install/)
* [以太坊开发 - Geth 的使用入门](http://blog.csdn.net/chenyufeng1991/article/details/53458175)
* [以太坊私有链搭建和 Geth 客户端使用](https://bitshuo.com/topic/5985c4c5876cd8953c30b378)
* [Geth JSON-RPC](https://github.com/ethereum/go-ethereum#programatically-interfacing-geth-nodes)