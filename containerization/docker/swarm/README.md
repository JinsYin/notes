# Docker Swarm

注意区分 docker swarm mode， docker swarm， swarmkit。为了方便，本文中 swarm 统一指 docker swarm mode。
> http://mt.sohu.com/20160818/n464799101.shtml

Docker swarm 默认使用`overlay`作为多主机网络通信 driver, 支持`负载均衡`、`服务发现`以及`任务扩展`。

## 工作原理

![docker swarm](./img/docker-swarm.png)

## 集群管理

开放端口

* 2377: 集群管理通信端口 [TCP]
* 7946: 集群节点通信端口 [TCP & UDP]
* 4789: overlay 网络传输端口 [TCP & UDP]

创建集群

```sh
# 创建 manager
$ docker swarm init --advertise-addr [ip] # 本地主机 IP
```

```sh
# 获取添加 manager 的方法
$ docker swarm join-token manager
```

```sh
# 获取添加 worker 的方法
$ docker swarm join-token worker
```

```sh
# 集群节点
$ docker node ls
$ docker node inspect [node]
```

```sh
# 角色转换
$ docker node promote [node] # 转换为 manager
$ docker node demote [node] # 转换为 worker
```

## 服务及任务管理

```sh
$ docker service create --name web --replicas 3 -p 8080:80 nginx:1.11.9-alpine # 自动 pull 镜像
$ docker service ls
$ docker service inspect web # 服务信息
$ docker service ps web # 任务信息
$ docker service scale web=5 # 扩展任务，限 --mode=replicated
$ docker service update --image nginx:1.11.9 web # 更新服务的镜像
$ docker service update --publish-add 9090:90  web # 添加映射端口
$ docker service rm web
```

service、task、container之间的关系
![docker-service-task-container](./img/docker-service-task-container.png)

service mode ("replicated" and "global" services)
![docker service mode](./img/docker-service-mode.png)

端口映射关系（自带负载均衡）
![docker port mapping](./img/docker-port-mapping.png)

## 错误

### ERROR 1

```sh
$ docker swarm init --advertise-addr 192.168.111.199
Error response from daemon: --cluster-store and --cluster-advertise daemon configurations are incompatible with swarm mode
```

原因是 swarm mode 下 --cluster-store 和 --cluster-advertise 不兼容，因为在 docker daemon 中使用了 etcd 作集群存储，所以需要先删除它，并重启 docker。

## 参考

* [Docker 1.13 编排能力进化](https://yq.aliyun.com/articles/69444)
* [Compose file version 3 reference](https://docs.docker.com/compose/compose-file/)
* [Docker 1.13 最实用命令行：终于可以愉快地打扫房间了](https://segmentfault.com/a/1190000007822648)
