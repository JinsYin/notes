# Ethminer

## 注意事项

* 自行挖矿前，必须确保本地区块链与主链完全同步（同步之前需要先同步系统时间），否则将不会在主链上挖矿；
* 在同步完成之前，eth 区块链下载器／同步器将延迟挖矿；同步完成之后，挖矿将自动开始；
* 为了挖掘以太币，必须设置 etherbase/coinbase 地址；

## 同步系统时间

* CentOS

```sh
# sudo
$ yum install -y ntp
$ ntpdate cn.pool.ntp.org
$ hwclock -w
$ systemctl enable ntpd
$ systemctl restart ntpd
```

* Ubuntu

```sh
# sudo
$ apt-get install -y ntp
$ ntpdate cn.pool.ntp.org
$ hwclock -w
$ update-rc.d ntp defaults
$ service ntp restart
```

## 安装准备

* 安装显卡驱动和 CUDA（略）
* 安装 nvidai-docker 1.0 或 2.0
* 安装 Geth（略，自己挖矿时需要）
* 安装 ethminer

```sh
# 官方下载地址： https://github.com/ethereum-mining/ethminer/tags
```

## 基准测试

* OpenCL

```sh
$ ethminer -G -M --opencl-device 0
$ ethminer -G -M --opencl-device 1
$ ethminer -G -M --opencl-device 2
```

* CUDA

```sh
$ ethminer -U -M
```

## CPU 挖矿

Geth 目前尽支持本地 CPU 挖矿。

```sh
# 会自动同步区块
$ geth --etherbase 1 --mine # 1 表示本地账户索引
$ geth --etherbase '0xa4d8e9cae4d04b093aac82e6cd355b6b963fb7ff' --mine
```

## GPU 自己挖矿（solo mining）

为了支持 GPU 自己挖矿，可以将 geth 和 ethminer 结合使用，其中 ethminer 作为 worker，geth 作为 scheduler，两者之间通过 `IPC-RPC`/`JSON-RPC`/`WS-RPC` 通信。为了将 DAG 存入内存，每个 GPU 需要 `1 ~ 2GB` 的内存。

* IPC-RPC 接口（默认开启）

```sh
$ geth account new
$ geth --rpc --rpccorsdomain localhost 2>> geth.log &

$ ethminer -G  // -G for GPU, -M for benchmark
$ tail -f geth.log
```

* HTTP-RPC 接口

```sh
# 30303: peer 之间同步区块，8545: 客户端访问
$ geth --etherbase '0xa4d8e9cae4d04b093aac82e6cd355b6b963fb7ff' --rpc --rpcaddr 0.0.0.0 --rpcport 8545 --rpccorsdomain localhost

# CUDA GPU
$ ethminer -U -F http://192.168.10.40:8545
```

* WS-RPC 接口（没有测试通过，可能是 ethminer 不支持 websocket）

```sh
$ geth --etherbase '0xa4d8e9cae4d04b093aac82e6cd355b6b963fb7ff' --ws --wsaddr 0.0.0.0 --wsport 8546 --wsorigins "*"

# CUDA GPU
$ ethminer -U -F ws://192.168.10.40:8546
```

## GPU 矿池挖矿

### 命令行挖矿

```sh
# 显存低于 2G 需要进行如下设置，否则忽略
$ export GPU_FORCE_64BIT_PTR=0
$ export GPU_MAX_HEAP_SIZE=100
$ export GPU_USE_SYNC_OBJECTS=1
$ export GPU_MAX_ALLOC_PERCENT=100
$ export GPU_SINGLE_ALLOC_PERCENT=100

# 请自行选择矿池
# ethminer -U -S eu1.ethermine.org:4444 -FS eu1.ethermine.org:14444 -O <Your_Ethereum_Address>.<RigName> --farm-recheck 200
$ ethminer -U -S eu1.ethermine.org:4444 -FS eu1.ethermine.org:14444 -O 79e478b8825fc50d9fde647ccc97483b5174f66f.X --farm-recheck 200
```

命令行参数：

  * -U: CUDA 驱动的 GPU；
  * -G: OpenCL 驱动的 GPU；
  * -S: stratum 协议连接的矿池服务器；
  * -FS: 备用的矿池服务器；
  * -O: 钱包地址，RigName 随便填写，通常是矿机名；
  * --farm-recheck: 重新更新任务的时间间隔，单位 ms，默认值 500；机器少，单台算力 100M 以上的话可以设置为 100 ；一般机器建议设置为 200 ；数值越小拒绝率越低，但是过小会导致机器算力下降。
  * --opencl-device: 为指定显卡设备启动 ethminer（配合 -G 使用）。
  * --cl-local-work ：运算位宽，可以是 64，128 ，256 ； 默认值为 64，越高越好，当设置较高数值闪退时请降低该数值。
  * --cl-global-work：显卡运算线程数； 该值为一般为 8192 或者 16384。

测试矿池服务器（stratum server）：

```sh
# 通过 ping 包选择延时最短的矿池服务器
$ ping eu1.ethermine.org

# 检查服务器是否可以连通
$ telnet eu1.ethermine.org 4444
```

### systemd

```sh
# --cuda-devices 0 限制使用哪块显卡
$ vi /usr/lib/systemd/system/ethminer.service
[Unit]
Description=Ethereum ethminer
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/bin/ethminer -U -S huabei-pool.ethfans.org:3333 -FS huabei-pool.ethfans.org:13333 -O "0xf7559ad5361b95a2d04e542b9d96acbff4240134.X" -SP 1 --farm-recheck 200
ExecReload=/bin/kill -s HUP $MAINPID
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

```sh
# 启动
$ systemctl start ethminer
$ systemctl enable ethminer

# 查看日志
$ journalctl -f -u ethminer

# 停止
$ systemctl stop ethminer
$ systemctl disable ethminer
```

### Docker 挖矿

```sh
# 基准测试
$ nvidia-docker run -it dockerce/cuda-ethminer:9.1-0.12.0 ethminer -U -M

# 矿池挖矿（ethermine 矿池）
$ nvidia-docker run -d --name ethminer --net=host --restart=always dockerce/cuda-ethminer:9.1-0.12.0 \
  ethminer -U -S us2.ethermine.org:14444 -FS eu2.ethermine.org:14444 \
  -O 79e478b8825fc50d9fde647ccc97483b5174f66f.X --farm-recheck 200

# 矿池挖矿（星火矿池）
$ nvidia-docker run -d --name ethminer --net=host --restart=always dockerce/cuda-ethminer:9.1-0.12.0 \
  ethminer -U -S huabei-pool.ethfans.org:3333 -FS huabei-pool.ethfans.org:13333 \
  -O "0xf7559ad5361b95a2d04e542b9d96acbff4240134.X" -SP 1 --farm-recheck 200
```

### 代理矿池挖矿

```sh
# 启动代理（传递 "EP_" 开头的环境变量可以改变配置文件，也可以自行挂载 /ethproxy/eth-proxy.conf）
$ docker run -d --name ethproxy --net=host --restart=always \
  -e EP_HOST="0.0.0.0" -e EP_PORT="9090" \
  -e EP_WALLET="0xf7559ad5361b95a2d04e542b9d96acbff4240134" \
  -e EP_POOL_HOST="us2.ethermine.org" -e EP_POOL_PORT="4444" \
  -e EP_POOL_HOST_FAILOVER1="us1.ethermine.org" -e EP_POOL_PORT_FAILOVER1="14444" \
  -e EP_POOL_HOST_FAILOVER2="eu1.ethermine.org" -e EP_POOL_PORT_FAILOVER2="14444" \
  -e EP_POOL_HOST_FAILOVER3="asia1.ethermine.org" -e EP_POOL_PORT_FAILOVER3="14444" \
  -e EP_LOG_TO_FILE="True" -e EP_DEBUG="True" -e EP_ENABLE_WORKER_ID="True" \
  -e EP_MONITORING="True" -e EP_MONITORING_EMAIL="yrqiang@163.com" dockerce/eth-proxy:0.0.5
```

```sh
# 选择代理进行挖矿
$ nvidia-docker run -d --name ethminer --net=host --restart=always dockerce/cuda-ethminer:9.0-0.12.0 ethminer -U -F http://192.168.10.51:9090/Y
```

```sh
# 打开浏览器查看数据
$ curl https://ethermine.org/miners/79e478b8825fc50d9fde647ccc97483b5174f66f
```

## 参考

* [ethereum/go-ethereum Mining](https://github.com/ethereum/go-ethereum/wiki/Mining)
* [EtherMining](https://www.reddit.com/r/EtherMining/)
* [Go Ethereum](https://github.com/ethereum/go-ethereum)
* [EarthLab-Luxembourg/docker-cuda-ethminer](https://github.com/EarthLab-Luxembourg/docker-cuda-ethminer)
* [使用显卡挖以太币教程](https://zhuanlan.zhihu.com/p/26246769)
