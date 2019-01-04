# RDMA 验证（连通性测试）

## udaddy

* server

```bash
$ udaddy
udaddy: starting server
```

* client

```bash
$ udaddy -s 10.0.10.160
udaddy: starting client
udaddy: connecting
initiating data transfers
receiving data transfers
data transfers complete
test complete
return status 0 # 0 表示连通
```

## rdma_server、rdma_client

* server

```bash
$ rdma_server
rdma_server: start
```

* client

```bash
$ rdma_client -s 10.0.10.160
rdma_client: start
rdma_client: end 0 # 0 表示连通
```

## ibping

`ibping` 工具用于 `ping` 另一台 IB 设备。

* server

```bash
% ibping -S
```

* client

```bash
# 传递的是 Port GUID，不是 Node GUID 和 System GUID，Port GUID 可以使用 'iblinkinfo' 命令获取
$ ibping -G 0x0002c903000d81f9
```

## ibdiagnet

`ibdiagnet` 工具用于查看整个子网的诊断（diagnostic）信息。

```bash
$ ibdiagnet -lw 4x -ls 5 -c 1000
----------------------------------------------------------------
-I- Stages Status Report:
    STAGE                                    Errors Warnings
    Bad GUIDs/LIDs Check                     0      0
    Link State Active Check                  0      0
    General Devices Info Report              0      0
    Performance Counters Report              0      0
    Specific Link Width Check                0      0
    Specific Link Speed Check                0      5
    Partitions Check                         0      0
    IPoIB Subnets Check                      0      1
```