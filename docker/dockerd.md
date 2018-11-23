# Docker Daemon

Docker 1.12.x 版本已经不再使用 `docker -d` 命令来启动 Docker Daemon，而是使用 `dockerd` 命令。

## 配置参数

| 参数                   | 含义                                                     | 示例                                                  |
| ---------------------- | -------------------------------------------------------- | ----------------------------------------------------- |
| -H, --host=[]          | 连接 daemon socket(s)                                    | -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock  |
| -g, --graph            | Docker 的数据根目录，默认：`/var/lib/docker`             | -g=/data/docker                                       |
| --insecure-registry=[] | 使用不安全的 registry                                    | --insecure-registry=10.2.0.0/16                       |
| --storage-driver       | 存储驱动：`aufs`、`overlay`、`overlay2`、 `devicemapper` | --storage-driver=overlay                              |
| --cluster-store        | 分布式存储后端                                           | --cluster-store=etcd://a.com:2379                     |
| --log-driver           | 日志驱动：`json-file`（默认）、` journald`               | --log-driver=journald                                 |
| --bip                  | 为网桥（docker0） 配置 CIDR 网络地址                     | --bip=172.17.42.1/16                                  |
| --ip-forward           | 开启 `net.ipv4.ip_forwar` 内核参数                       | --ip-forward=true                                     |
| --registry-mirror      | 可以指定国内的镜像源                                     | --registry-mirror=https://docker.mirrors.ustc.edu.cn/ |

## Storage Driver

## Volume Driver

## 参考

* [DOCKER 源码分析（六）：DOCKER DAEMON 网络](http://blog.daocloud.io/docker-source-code-analysis-part6/)