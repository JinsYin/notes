# Kubernetes On CentOS

![Kubernetes Cluster](./img/kubernetes-cluster.png)


## 角色分配

| Role       | Hostname   | IP             | Components |
| ---------- | ---------- | ----------     | ---------- |
| master     | k8s-master | 172.28.128.100 | flannel etcd kube-apiserver kube-controller-manager kube-scheduler |
| node       | k8s-node-1 | 172.28.128.101 | flannel kubelet kube-proxy |
| node       | k8s-node-2 | 172.28.128.102 | flannel kubelet kube-proxy |


## 系统环境

  * Centos 7.3.1611
  * Kernel 3.10.0-514.26.2
  * Docker 1.12.6
  * Etcd 2.3.7
  * Kubernetes 1.5.2
  * Flannel 0.7.1-1


## 预操作

* 系统

```bash
$ # 发行版本
$ cat /etc/redhat-release
CentOS Linux release 7.3.1611 (Core)
$
$ # Kernel
$ uname -r
3.10.0-514.26.2.el7.x86_64
```

* 关闭防火墙

```bash
$ systemctl stop firewalld
```

* 同步时间

```bash
$ # 安装
$ yum install -y ntp
$
$ # 同步
$ ntpdate cn.pool.ntp.org
$
$ systemctl start ntpd.service
$ systemctl enable ntpd.service
```

* Docker

```bash
$ yum install -y docker-1.12.6
$
$ systemctl start docker.service
$ systemctl enable docker.service
```

* 其他

```bash
$ yum install -y net-tools
```


## Master

* etcd、flannel

[Flannel On CentOS](../docker/network/flannel/README.md)

* 安装、公共配置

```bash
$ # master 安装
$ yum install -y kubernetes-master-1.5.2
```

```bash
$ # 公共配置（部分）
$ cat /etc/kubernetes/config
KUBE_LOGTOSTDERR="--logtostderr=true"

KUBE_LOG_LEVEL="--v=0"

KUBE_ALLOW_PRIV="--allow-privileged=true"

KUBE_MASTER="--master=http://172.28.128.100:8080"
```

* kube-apiserver：

```bash
$ # 部分配置
$ cat /etc/kubernetes/apiserver
KUBE_API_ADDRESS="--address=0.0.0.0 --advertise-address=172.28.128.100"

KUBE_API_PORT="--port=8080"

KUBE_ETCD_SERVERS="--etcd-servers=http://172.28.128.100:2379"

# 
KUBE_SERVICE_ADDRESSES="--service-cluster-ip-range=10.254.0.0/16"

# KUBE_ADMISSION_CONTROL="--admission-control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ServiceAccount,ResourceQuota"
KUBE_ADMISSION_CONTROL="--admission-control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ResourceQuota"
```

* kube-controller-manager

```bash
$ # 暂时不变
$ cat /etc/kubernetes/controller-manager
```

* kube-scheduler

```bash
$ # 暂时不变
$ cat /etc/kubernetes/scheduler
```

* 启动服务

```bash
$ for SERVICE in kube-apiserver kube-controller-manager kube-scheduler; do
  systemctl restart $SERVICE
  systemctl enable $SERVICE
  systemctl status $SERVICE
done
```

* 验证

```bash
$ netstat -tpln
```


## Node

* flannel

[Flannel On CentOS](../docker/network/flannel/README.md)

* 安装、公共配置

```bash
$ yum install -y kubernetes-node-1.5.2
```

```bash
$ # 公共配置（部分）
$ cat /etc/kubernetes/config
KUBE_LOGTOSTDERR="--logtostderr=true"

KUBE_LOG_LEVEL="--v=0"

KUBE_ALLOW_PRIV="--allow-privileged=true"

KUBE_MASTER="--master=http://172.28.128.100:8080"
```

* kubelet

```bash
$ cat /etc/kubernetes/kubelet
KUBELET_ADDRESS="--address=0.0.0.0"

KUBELET_PORT="--port=10250"

# 各自的主机 IP
KUBELET_HOSTNAME="--hostname-override=172.28.128.101"

KUBELET_API_SERVER="--api-servers=http://172.28.128.100:8080"

# 注释掉
#KUBELET_POD_INFRA_CONTAINER="--pod-infra-container-image=registry.access.redhat.com/rhel7/pod-infrastructure:latest"

KUBELET_ARGS=""
```

* kube-proxy

```bash
$ cat /etc/kubernetes/proxy
KUBE_PROXY_ARGS="--proxy-mode=userspace"
```

* 启动服务

```bash
$ for SERVICE in kube-proxy kubelet; do
  systemctl restart $SERVICE
  systemctl enable $SERVICE
  systemctl status $SERVICE 
done
```

* 验证

```bash
$ netstat -tpln
```

```bash
$ # Node 节点
$ kubectl --server=172.28.128.100:8080 get nodes -o wide
$
$ # Master 节点（前提是 KUBE_API_ADDRESS 绑定的地址是 0.0.0.0，否则乖乖使用上面的命令）
$ kubectl get nodes -o wide
```

* 配置　kubectl

为避免每次在 Master、Node 节点上执行 kubectl 命令都要带一个　`--server` 参数，可以进行以下配置。

```bash
$ # https://github.com/kubernetes/kubernetes/issues/23726#issuecomment-258381872
$ kubectl config set-cluster default-cluster --server=http://172.28.128.100:8080
$ kubectl config set-context default-context --cluster=default-cluster --user=default-admin
$ kubectl config use-context default-context
```


## 测试

```bash
$ # 查看所有组件的状态
$ kubectl get cs
$
$ # 部署一个应用
$ kubectl run nginx-web --image=nginx:1.11.9-alpine --replicas=2 --port=80
$
$ # 查看部署的 pods、deployment
$ kubectl get pods
$ kubectl get deployments
$
$ # 查看部署情况、日志等
$ kubectl describe all
```


## 错误整理

* kube-apiserver 启动的时候，查看日志（`journalctl -xe`），出现 `Authentication is disabled`，并且绑定的 IP 也不对。

  原因是有多个网卡导致绑定了错误的 IP 地址，添加参数 `--advertise-address` 即可。

* 创建　nginx-web 测试时，使用 `kubectl describe deployments` 查看日志出现　“Error creating: No API token found for service account "default", retry after the token is automatically created and added to the service account”。

  1). 跳过认证

  解决办法是从 “/etc/kubernetes/apiserver” 的环境变量 `KUBE_ADMISSION_CONTROL` 中剔除 `ServiceAccount`，并重启 kube-apiserver.service 服务。

  2). 解决认证

  https://github.com/kubernetes/kubernetes/issues/11355#issuecomment-127378691

  http://blog.csdn.net/jinzhencs/article/details/51435020

  kubectl get secrets
  kubectl get serviceaccounts

* 无法下载镜像，“Error syncing pod, skipping: failed to "StartContainer" for "POD" with ImagePullBackOff: "Back-off pulling image \"gcr.io/google_containers/pause-amd64:3.0\""”

方法一). 修改 tag

```bash
$ docker pull googlecontainer/pause-amd64:3.0
$
$ docker tag googlecontainer/pause-amd64:3.0 gcr.io/google_containers/pause-amd64:3.0
```

方法二). 把镜像上传私有仓库

```bash
$ docker pull googlecontainer/pause-amd64:3.0
$
$ docker tag googlecontainer/pause-amd64:3.0 x.x.x.x:5000/google_containers/pause-amd64:3.0
$
$ docker push x.x.x.x:5000/google_containers/pause-amd64:3.0
$
$ cat /etc/kubernetes/apiserver
KUBELET_POD_INFRA_CONTAINER="--pod-infra-container-image=x.x.x.x:5000/google_containers/pause-amd64:3.0"
$
$ systemctl restart kube-apiserver
```

方法三). 直接使用 Docker Hub 仓库

```bash
$ cat /etc/kubernetes/apiserver
KUBELET_POD_INFRA_CONTAINER="--pod-infra-container-image=docker.io/google_containers/pause-amd64:3.0"
$
$ systemctl restart kube-apiserver
```

* `kubectl get endpoints kubernetes` 查看后发现 `kubernetes` 这个 service 的 endpoints 不正确。

  原因是测试环境有多块网卡，而 `kubernetes` 这个 service 使用了默认的网卡导致出错

  解决办法： 为 kube-apiserver 增加 `--advertise-address=x.x.x.x` 参数。


## Kubernetes Dashboard

```bash
$ docker pull googlecontainer/kubernetes-dashboard-amd64:v1.6.2
$
$ docker tag gcr.io/google_containers/kubernetes-dashboard-amd64:v1.6.2
```


## 参考

* [Kubernetes On CentOS](https://kubernetes.io/docs/getting-started-guides/centos/centos_manual_config/)
* [Installing Kubernetes Cluster with 3 minions on CentOS 7 to manage pods and services](https://severalnines.com/blog/installing-kubernetes-cluster-minions-centos7-manage-pods-services)