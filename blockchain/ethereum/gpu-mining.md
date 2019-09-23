# GPU 挖矿

## eth & ethminer 挖矿

```sh
eth -i -v 8 -j // -j for rpc
ethminer -G -M // -G for GPU, -M for benchmark
tail -f geth.log
```

### eth 挖矿

```sh
eth -m on -G -a -i -v 8 //
```

## geth & ethminer 挖矿

```sh
# 如果没有账号，创建新账号
$ geth account new

$ geth --rpc --rpccorsdomain localhost 2>> geth.log &

ethminer -G // -G for GPU, -M for benchmark
tail -f geth.log
```
