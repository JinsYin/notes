# NVIDIA

## 知识点

显卡由 `显存` 和 `GPU` 组成。GPU 用于图形计算，功能上类似与 CPU；显存用于存储计算数据，功能上类似于内存。

## 监控显卡

```bash
$ nvidia-smi
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 387.26                 Driver Version: 387.26                    |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  P106-100            Off  | 00000000:02:00.0 Off |                  N/A |
| 38%   23C    P8     4W / 120W |   5777MiB /  6075MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   1  P106-100            Off  | 00000000:03:00.0 Off |                  N/A |
| 38%   21C    P8     4W / 120W |   5777MiB /  6075MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   2  P106-100            Off  | 00000000:04:00.0 Off |                  N/A |
| 38%   22C    P8     4W / 120W |   5777MiB /  6075MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   3  P106-100            Off  | 00000000:05:00.0 Off |                  N/A |
| 38%   24C    P8     4W / 120W |   5777MiB /  6075MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   4  P106-100            Off  | 00000000:81:00.0 Off |                  N/A |
| 38%   23C    P8     4W / 120W |   5777MiB /  6075MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   5  P106-100            Off  | 00000000:82:00.0 Off |                  N/A |
| 38%   21C    P8     4W / 120W |   5777MiB /  6075MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|    0     21084      C   /usr/bin/python                             5759MiB |
|    1     21084      C   /usr/bin/python                             5759MiB |
|    2     21084      C   /usr/bin/python                             5759MiB |
|    3     21084      C   /usr/bin/python                             5759MiB |
|    4     21084      C   /usr/bin/python                             5759MiB |
|    5     21084      C   /usr/bin/python                             5759MiB |
+-----------------------------------------------------------------------------+
```

解析：

* GPU Fan：
* Name Temp：显卡温度

```bash
# 查看显卡型号和数量
$ nvidia-smi -L

# 每个 10 秒输出一次显卡的状态
$ nvidia-smi -l 10
```

## 安装 nvidia-docker/nvidia-docker2

* nvidia-docker

```bash
% yum install nvidia-docker
```

* nvidia-docker2

```bash
# 查看可用版本
$ yum list {nvidia-docker2,nvidia-container-runtime} --showduplicates

# 需要先移除 nvidia-docker
$ yum remove -y nvidia-docker

$ yum install -y nvidia-docker2-2.0.1-1.docker1.12.6 nvidia-container-runtime-2.0.0-1.docker1.12.6
```

## 参考

* [ubuntu14.04 + CUDA8 + cuDNN5 + Tensorflow](https://www.cnblogs.com/zengcv/p/6564517.html)