# Flannel on CentOS

Flannel 是 CoreOS 团队针对 Kubernetes 设计的一个网络规划服务，简单来说，它的功能是让集群中的不同节点主机创建的 Docker 容器都具有全集群唯一的虚拟 IP 地址。

Flannel 的设计目的就是为集群中的所有节点重新规划 IP 地址的使用规则，从而使得不同节点上的容器能够获得 `同属一个内网` 且 `不重复` 的 IP 地址，并让属于不同节点上的容器能够直接通过内网 IP 通信。


## 原理

Flannel 实质上是一种 “覆盖网络(overlay network)”，也就是将 TCP 数据包装在另一种网络包里面进行路由转发和通信，目前已经支持 `UDP`（默认）、`VxLAN`、`AWS VPC` 和 `GCE` 路由等数据转发方式。

![Flannel](../img/docker-network-flannel.png)

数据从源容器中发出后，经由所在主机的 docker0 虚拟网卡转发到 flannel0 虚拟网卡，这是个 P2P 的虚拟网卡，flanneld 服务监听在网卡的另外一端。

Flannel 通过 Etcd 服务维护了一张节点间的路由表，在稍后的配置部分我们会介绍其中的内容。

源主机的 flanneld 服务将原本的数据内容 UDP 封装后根据自己的路由表投递给目的节点的 flanneld 服务，数据到达以后被解包，然后直接进入目的节点的 flannel0 虚拟网卡，然后被转发到目的主机的 docker0 虚拟网卡，最后就像本机容器通信一下的有 docker0 路由到达目标容器。


## 角色分配

| Role                | Hostname | IP Address     |
| ------------------- | -------- | -------------- |
| flannel docker etcd | Host100  | 172.28.128.100 |
| flannel docker      | Host101  | 172.28.128.101 |
| flannel docker      | Host102  | 172.28.128.102 |


## 系统环境

  * Centos 7.3.1611
  * Kernel 3.10.0-514.26.2
  * Docker 1.12.6
  * Etcd 2.3.7
  * Flannel 0.7.1-1


## 配置 Etcd

Flannel 用 Etcd 来存储每台机器的子网地址，因此在启动 Flannel 之前，需要安装并配置 Etcd。下面安装并配置一个单机 etcd：

* 安装、运行

```sh
$ # 安装
$ yum install -y etcd-2.3.7
$
$ # 启动
$ systemctl start etcd.service
$
$ # 开机自启动
$ systemctl enable etcd.service
```

* 配置 CIDR

```sh
$ # 默认使用 UDP 进行数据转发
$ etcdctl set /flannel/network/config '{"Network": "10.20.0.0/16"}'
$
$ # OR
$
$ # 使用 VxLAN 进行数据转发
$ etcdctl set /flannel/network/config '{"Network": "10.20.0.0/16", "SubnetLen": 24, "Backend": {"Type": "vxlan"}}'
```


## 配置 Flannel

* 安装

```sh
$ yum list flannel --showduplicates
$
$ # 安装
$ yum install -y flannel-0.7.1-1*
```

* 配置

如果有宿主机多个物理网卡，使用 `-iface` 参数来指定正确的网卡。

```sh
$ cat /etc/sysconfig/flanneld
FLANNEL_ETCD_ENDPOINTS="http://172.28.128.100:2379"
FLANNEL_ETCD_PREFIX="/flannel/network"
FLANNEL_OPTIONS="-iface=eth1"
```

* 运行

```sh
$ # 启动 flannel 之前先检查 etcd 是否健康
$ etcdctl --endpoints http://172.28.128.100:2379 cluster-health
$
$ # 启动
$ systemctl start flanneld.service
$
$ # 开机自启动
$ systemctl enable flanneld.service
$
$ # 状态
$ systemctl status flanneld.service
```

* 验证

```sh
$ ifconfig flannel0
flannel.1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
  inet 10.20.26.0  netmask 255.255.255.255  broadcast 0.0.0.0
  ether d6:8a:f1:2e:3b:f0  txqueuelen 0  (Ethernet)
  RX packets 18  bytes 1456 (1.4 KiB)
  RX errors 0  dropped 0  overruns 0  frame 0
  TX packets 24  bytes 1624 (1.5 KiB)
  TX errors 0  dropped 0 overruns 0  carrier 0  collisions
```

```sh
$ route -n
0.0.0.0         10.0.2.2        0.0.0.0         UG    100    0        0 eth0
10.0.2.0        0.0.0.0         255.255.255.0   U     100    0        0 eth0
10.20.0.0       0.0.0.0         255.255.0.0     U     0      0        0 flannel.1
10.20.26.0      0.0.0.0         255.255.255.0   U     0      0        0 docker0
169.254.0.0     0.0.0.0         255.255.0.0     U     1003   0        0 eth1
172.28.128.0    0.0.0.0         255.255.255.0   U     0      0        0 eth1
172.172.10.0    0.0.0.0         255.255.255.0   U     0      0        0 bridge0
```

* 用 Kubernetes 安装（略）

```sh
$ kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.7.1/Documentation/kube-flannel.yml
```


## 配置 Docker

* 安装 Docker

```sh
$ yum install -y docker-1.12.6
```

* 配置 Docker

启动 flannel 后，会在 `/run/flannel/docker` 文件中自动添加一些由 Docker daemon 的参数所组成的环境变量。Docker daemon 的 `--bip` 参数表示 bridge ip，也就是网桥 docker0 的 IP 地址。

```sh
$ cat /run/flannel/docker
DOCKER_OPT_BIP="--bip=10.20.2.1/24"
DOCKER_OPT_IPMASQ="--ip-masq=true"
DOCKER_OPT_MTU="--mtu=1450"
DOCKER_NETWORK_OPTIONS=" --bip=10.20.2.1/24 --ip-masq=true --mtu=1450"
```

查看 docker.service 发现它自动引入了上面的配置文件，所以不用再手动修改 docker.service 或者 Docker 环境变量（`/etc/sysconfig/docker`、`/etc/sysconfig/docker-network`等）。

```sh
$ systemctl cat docker.service
...
# /usr/lib/systemd/system/docker.service.d/flannel.conf
[Service]
EnvironmentFile=-/run/flannel/docker
```

应该是下面这行代码，使 docker.service 自动引入了 `/run/flannel/docker` 这个配置文件。

```sh
$ systemctl cat flanneldservice | grep ExecStartPost
ExecStartPost=/usr/libexec/flannel/mk-docker-opts.sh -k DOCKER_NETWORK_OPTIONS -d /run/flannel/docker
```

* 重启 Docker

```sh
$ systemctl restart docker.service
```


## 测试

* 检查 docker0

需要看一下各个主机的 docker0 是否都不相同，也可以通过 etcd 查看各自分配的 ip 地址，另外还应该检查一下 `/flannel/network/subnets` 子目录下的 PublicIP（宿主机 IP）是否正确。

```sh
$ etcdctl --endpoints http://172.28.128.100:2379 ls /flannel/network/subnets
```

* Host100

```sh
$ docker run -it --rm alpine:3.5 sh
> hostname -i
> 10.20.87.2
>
> ping 10.20.2.2  # OK
> ping 10.20.26.2 # OK
```

* Host101

```sh
$ docker run -it --rm alpine:3.5 sh
> hostname -i
> 10.20.26.2
>
> ping 10.20.2.2  # OK
> ping 10.20.87.2 # OK
```

* Host102

```sh
$ docker run -it --rm alpine:3.5 sh
> hostname -i
> 10.20.2.2
>
> ping 10.20.26.2 # OK
> ping 10.20.87.2 # OK
```

测试结论： 在部署有 flannel 服务的同网段多台主机中，主机与主机之间、主机与容器之间、容器与容器之间是可以跨主机相互通信的。对于没有部署 flannel 服务的同网段主机而言，主机 => 容器、容器 => 容器依然无法跨主机通信，但容器 => 主机是可以连通的。


## 建议

在为 flannel 配置 CIDR 的时候，建议设置 x.x.x.x/16 网段的 IP 地址，并为每台宿主机容器分配一个 x.x.x.x/24 网段的 IP 地址。

如果想重新修改 CIDR，需要先删除原来的配置：

```sh
$ # 删除原来的配置
$ etcdctl --endpoints http://172.28.128.100:2379 rm -recursive /flannel/network
$
$ # 重新设置 CIDR
$ etcdctl --endpoints http://172.28.128.100:2379 set /flannel/network/config '{"Network": "10.30.0.0/16", "Backend": {"Type": "vxlan"}}'
$
$ # 删除 flanneld 网桥
$ ifconfig flannel0 down
$ ip link del dev flannel0
$
$ # 重启 flannel
$ systemctl restart flanneld.service
$
$ # 重启 docker
$ systemctl restart docker.service
$
$ # 校验
$ ifconfig
$ route -n
```


## 错误整理

* failed to retrieve network config: 100: Key not found (/atomic.io) [97]

  需要确保 FLANNEL_ETCD_PREFIX 与 etcdctl set 是设置的路径是对应的。

* 使用 vagrant + virtualbox 测试的时候，出现了多台虚拟机的 docker0 的 IP 完全一样、以及多台虚拟机的容器 IP 完全一样的问题。

  由于自定义了 private_network，所以出现了两个网卡（eth0、eth1），默认 eth0 是无效的而且多台虚拟机之间也是一样的，而 flannel 默认使用了无效的 eth0 作为物理网卡接口，导致了上面的问题。所以，对于多网卡的主机一定要为 flannel 设置物理网卡接口 `FLANNEL_OPTIONS="-iface=eth1"`。


## 参考

* [DockOne 技术分享（十八）：一篇文章带你了解 Flannel](http://dockone.io/article/618)
* [Configuring flannel for container networking](https://coreos.com/flannel/docs/0.7.1/flannel-config.html)
* [Accessing Kubernetes Pods from Outside of the Cluster](http://alesnosek.com/blog/2017/02/14/accessing-kubernetes-pods-from-outside-of-the-cluster/)
