# Geth 命令

## 账户管理

```bash
# 创建账户（需要设置密码，且必须牢记该密码）
$ geth account new

# 账户列表
$ geth account list
```

## 钱包管理

```bash
```

## 交互环境（JavaScript）

（账户余额等信息需要同步主链才有数据）

```bash
# 进入交互模式，将 STDERR 输出到文件
$ geth console 2>> geth.log
```

* 账户管理

```bash
# 查询账户
> eth.accounts
> personal.listAccounts

# 新建账户
> personal.newAccount('your-passowrd')

# 解锁账户
> personal.unlockAccount("0x...","your-passowrd")
```

* 交易

```bash
# 查询账户余额
> eth.getBalance(eth.accounts[0])
> eth.getBalance("0x...")

# 设置 etherbase
> miner.setEtherbase(eth.accounts[n]) //etherbase地址并不需要一定是本机上

> eth.sendTransaction({from:"0x...", to:"0x...", value:web3.toWei(3,"ether")})
```

* 挖矿

```bash
# 启动 CPU 挖矿
> miner.start()

# 停止 CPU 挖矿
> miner.stop()
```

* 智能合约

```bash
# 定义、编译智能合约
> source = "contract test { function multiply(uint a) returns(uint d) { return a * 7; } }"
> contract = eth.compile.solidity(source).test
```