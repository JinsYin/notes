# Minikube

Minikube 用于开发环境，可以在本地 VM 一键部署单节点的 Kubernetes 集群，支持 Linux、Mac、Windows 操作系统。


## 安装要求

* kubectl
* MacOS
  * xhyve driver, VirtualBox or VMware Fusion
* Linux
  * VirtualBox or KVM
* Windows
  * VirtualBox or Hyper-V
* BIOS 开启了虚拟化
* 网络连接已开启


## 安装

* Kubectl

为了和 Kubernetes 交互，Minikube 要求预装 `kubectl`。

```bash
$ # 版本
$ export KUBECTL_VERSION=v1.6.4
$
$ # 安装
$ curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/
$
$ # 客户端版本是 kubectl 版本，服务器版本是 Master 上 Kubernetes 的版本
$ kubectl version
```

* VirtualBox

```bash
$ # ubuntu 安装
$ sudo apt-cache policy virtualbox
$ sudo apt-get install virtualbox -y
```

* Minikube

```bash
$ # 版本
$ export MINIKUBE_VERSION=v0.20.0
$
$ # 安装
$ curl -Lo minikube https://storage.googleapis.com/minikube/releases/${MINIKUBE_VERSION}/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
$
$ # 查看版本
$ minikube version
$
$ # 查看支持的 kubernetes 版本
$ minikube get-k8s-versions
```


## 集群管理

minikube 支持 virtualbox、kvm 两种 vm 后端，默认使用 virtualbox

```bash
$ # 启动集群
$ minikube start
$
$ # 设置一些参数
$ # minikube start --docker-env HTTP_PROXY=http://proxy-ip:port --vm-driver=virtualbox --memory=1024
$
$ # 启动完成后可以在当前用户下打开 virtualbox 查看虚拟机
$ virtualbox
$
$ # 连接到 vm
$ minikube ssh
$
$ # 集群状态
$ minikube status
$
$ # 停止集群
$ minikube stop
$
$ # 集群信息
$ kubectl cluster-info
```


## Dashboard

```bash
$ minikube dashboard
```


## 其他

除了使用 minikube 部署单节点集群外，还可以使用 [get.k8s.io](https://get.k8s.io/) 提供的方式在多平台安装集群环境。

```bash
$ wget -q -O - https://get.k8s.io | bash
$
$ # or
$
$ curl -fsSL https://get.k8s.io | bash
```


## 参考

  * [kubernetes/minikube](https://github.com/kubernetes/minikube/blob/k8s-v1.6/README.md)
  * [Hello Minikube](https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/)