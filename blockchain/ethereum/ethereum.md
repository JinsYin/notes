# Ethereum

## Go Ethereum（geth）

### 安装


### 账户管理

```bash
$ docker run -d --name ethereum-node --privileged \
  -p 8545:8545 -p 30303:30303 \
  -v /root:/root \
  ethereum/client-go --fast --cache=512
```


### 使用 Mist 以太坊钱包


## GPU 挖矿

算法是内存难解的，为了使 DAG 适合内存，每个 GPU 需要 1-2GB 内存。GPU 挖矿软件是基于 `OpenCL` 实现的。

```bash
eth account new // Set-up ethereum account if you do not have one
geth --rpc --rpccorsdomain localhost 2>> geth.log &
ethminer -G // -G for GPU, -M for benchmark
tail -f geth.log
```

### 用 geth 使用 ethminer 挖矿

* 挖矿流程

  * 开启 geth（`geth --rpc`），这会同步以太坊区块链数据（目前大概 27G），同步时间会比较长且会消耗大量内存，因此需要确保内存充足；
  * 待 geth 同步完成（同步不再进行就算完成）后，使用 `ethminer -G` 开启挖矿进程。

* 相关命令

```bash
# 获取 OpenCL 设备列表
$ ethminer --list-devices
```

* 基准测试

```bash
# 通过 CUDA 使用 GPU 作基准测试（126839357）
$ ethminer -U -M

# 通过 OpenCL 使用 GPU 作基准测试
$ ethminer -G -M

# 对某个 OpenCL 作基准测试
$ ethminer -G -M --opencl-device 0
```

* 挖矿命令

安装完 CUDA 后，默认会自动安装 OpenCL，路径：`/usr/local/cuda/include/CL/`。

> https://github.com/EarthLab-Luxembourg/docker-cuda-ethminer/blob/master/mesos_marathon.json
> https://github.com/EarthLab-Luxembourg/docker-cuda-ethminer