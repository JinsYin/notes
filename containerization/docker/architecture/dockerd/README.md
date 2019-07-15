# Docker Daemon - A self-sufficient runtime for containers

从 Docker 1.12.x 版本开始已经不再支持使用 `docker -d` 命令来启动 Docker Daemon，而是使用单独的 `dockerd` 命令。

## 配置参数

| 参数选项                 | 描述                                                          | 示例                                                     |
| ------------------------ | ------------------------------------------------------------- | -------------------------------------------------------- |
| `--add-runtime=[]`       | 注册额外的 OCI 兼容的容器运行时                               | `--add-runtime=nvidia=/usr/bin/nvidia-container-runtime` |
| `-H`, `--host=[]`        | 连接 daemon socket(s)；默认值为 `/var/run/docker.sock`        | `-H tcp://0.0.0.0:2375 -H /var/run/docker.sock`          |
| `-g`, `--graph`          | 数据存储目录；默认路径为 `/var/lib/docker`                    | `-g=/data/docker`                                        |
| `--insecure-registry=[]` | 允许从非 HTTPS 的 registry 的主机、主机列表或 CIDR 中拉取镜像 | `--insecure-registry=10.2.0.0/16`                        |
| `--storage-driver`       | 存储驱动；支持 `aufs`、`overlay`、`overlay2`、 `devicemapper` | `--storage-driver=overlay`                               |
| `--cluster-store`        | 分布式存储后端                                                | `--cluster-store=etcd://a.com:2379`                      |
| `--log-driver`           | 日志驱动；支持 `json-file`（默认）、`journald`                | `--log-driver=journald`                                  |
| `--bip`                  | 指定网桥（默认 `docker0`）的 CIDR；默认值为 `172.17.0.1/16`   | `--bip=172.16.0.1/16`                                    |
| `--ip-forward=true`      | 启动内核参数 `net.ipv4.ip_forward`，以允许 IP 转发            | `--ip-forward=true`                                      |
| `--registry-mirror=[]`   | 指定其他的 registry 镜像源；默认为 `index.docker.io`          | `--registry-mirror=https://registry.docker-cn.com`       |

> 除了使用命令行参数外，还可以在 /etc/docker/daemon.json 文件中修改 Docker Daemon 的配置。

## Storage Driver

## Volume Driver

## 进程分析

```bash
init
+
|
+---dockerd
    +
    |
    +---+ docker-containerd
        |
        +------- docker-containerd-shim
```

## 参考

* [DOCKER 源码分析（六）：DOCKER DAEMON 网络](http://blog.daocloud.io/docker-source-code-analysis-part6/)