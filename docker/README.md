# Dcoker 从入门到放弃

## 目录

* [docker 安装](./docker-install.md)
* [docker 命令](./docker-command.md)
* [docker swarm](./docker-swarm.md)
* [docker hub](./docker-hub.md)
* [docker 网络](./docker-network.md)
* [dockerfile](./docker-dockerfile.md)

## 参考

* [Docker 最佳实践](https://rootsongjc.gitbooks.io/kubernetes-handbook/appendix/docker-best-practice.html)

## 容器中使用 systemd

如果想要在容器中使用 init 进程（如：`systemd`），必须要确保第一个进程（`PID=1`）是 init 进程，而不是其他进程（如：`sh`、`bash`）。另外，为了连接 DBus，容器还必须拥有特权（`privileged`）。

```bash
# CentOS（/sbin/init -> ../lib/systemd/systemd）
$ docker run -d --privileged=true --name centos74 centos:7.4.1708 /sbin/init

# Ubuntu（/sbin/init -> ../lib/systemd/systemd）
$ docker run -d --privileged=true --name ubuntu1604 ubuntu:16.04 /sbin/init
```