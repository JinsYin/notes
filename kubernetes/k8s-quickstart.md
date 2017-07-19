# Kubernetes 入门

## 集群架构

![集群图表](./k8s-cluster-diagram.png)

* Master

Master 负责管理集群：调度应用、维护应用理想状态、伸缩应用，以及滚动更新。

* Node

Node 可以是虚拟机也可以是物理机，在 Kubernetes 集群中作为 worker 使用。每个节点有一个 `Kubelet`，负责管理节点并与 Kubernetes master 通信。另外，每个节点还需要一个容器引擎，Kubernetes 支持 docker 和 rkt。生产环境的 Kubernetes 最少需要 `3` 个 节点。


## Minikube

Minikube 用于开发环境，可以在本地一键部署单节点的 Kubernetes 集群，支持 Linux、Mac、Windows 操作系统。

* 安装

```bash
$ curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.20.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
$
$ minikube version
```

* 启动集群

为了和 Kubernetes 交互，Minikube 要求预装 `kubectl`。

```bash
$ # 安装 kubectl
$ curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/
$
$ # 客户端版本是 kubectl 版本，服务器版本是 Master 上 Kubernetes 的版本
$ kubectl version
$
$ # 集群信息
$ kubectl cluster-info
$ kubectl cluster-info dump
$
$ # 查看集群节点（ready 状态表示正准备接受应用部署）
$ kubectl get nodes
```

```bash
$ minikube start
$ minikube status
```

* 部署应用

```bash
$ kubectl run hello-minikube --image=gcr.io/google_containers/echoserver:1.4 --port=8080
$ kubectl run kubernetes-bootcamp --image=docker.io/jocatalin/kubernetes-bootcamp:v1 --port=8080
$
$ kubectl expose deployment hello-minikube --type=NodePort
$
$ kubectl get pod
$
$ kubectl get deployments
$
$ curl $(minikube service hello-minikube --url)
```

* 停止集群

```bash
$ minikube stop
```

## 参考

* [Kubernetes Tutorials](https://kubernetes.io/docs/tutorials/)