# 区块链

## 基本概念

* mine：矿，指比特币等虚拟货币；
* miner：矿工，挖矿的人；
* mining pool：矿池；
* height：高度
* Reward：
* Block Hash：
* Ether：以太币
* Etherbase：
* DAG
* mining farm

## 算力

算力是指挖矿机每秒所做的 Hash 碰撞次数，单位写做 `hash/s` 或 `H/s`，即 Hash Per Second。

FLoating-point Operations Per Second： `FLOPS`

* 算力单位换算

1 PH/s = 1,000 TH/s
1 TH/s = 1,000 GH/s
1 GH/s = 1,000 MH/s
1 MH/s = 1,000 KH/s
1 KH/s = 1,000 H/s

为了简化单位，通常将 `1 PH/s` 简写为 `1P`，也就是说 1P = 1000T。

## 区块高度

区块高度，即区块的长度。所谓的创世区块，也就是第 0 块。

## 矿池挖矿

矿池挖矿是旨在通过联合参与矿工的挖矿力来解决预期收益问题的合作社（挖矿的矿工的算力来解决预期收益问题的合作组织）。作为回报，通常收取0-5%的挖矿奖励。挖矿池从中央账户用工作量证明提交区块并按照参与人贡献的挖矿力比例来重新分配奖励。

警告：大多数挖矿池包含第三方，中心组件，意味着他们是不需信任的。换言之，挖矿池操作人可以把你的收入拿走。谨慎操作。有很多具备开源数据库、不需信任的、去中心化的挖矿池。

警告：挖矿池只会外包工作量证明运算，他们不会使区块生效或运行虚拟机来检查执行交易带来的状态过渡。 这能有效地使挖矿池在安全方面像单个节点一样表现，他们的增长会造成51%攻击的中心化威胁。确保遵守网络能力分配，不要让挖矿池长得太大。

## 交易网站

* [Localbitcoins](https://localbitcoins.com/)
* [Coincola](https://www.coincola.com/)
* [Okex](https://www.okex.com/)

场外：比特币对各国法币（Localbitcoins）, BTC/ETH/BCH对人民币（ [Coincola](https://www.coincola.com/)）

山寨币：Binanace， Chaoex, Gate of Blockchain

比特币期货：BitMEX，Okex

## 参考

* [比特币、以太坊的加密技术](https://github.com/ashchan/bitcoin-ethereum-cryptography/blob/master/Bitcoin%20Ethereum%20Cryptography.pdf)
* [区块高度【区块链生存训练】](https://www.jianshu.com/p/2d4f616cb542)