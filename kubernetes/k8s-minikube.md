# Minikube

Minikube 用于开发环境，可以在本地 VM 一键部署单节点的 Kubernetes 集群，支持 Linux、Mac、Windows 操作系统。


## 安装要求

* kubectl
* macOS
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
$ # 安装
$ curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/
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
$ # 安装
$ curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.20.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
$
$ # 查看版本
$ minikube version
$
$ # 查看支持的 k8s 版本
$ minikube get-k8s-versions
```


## 集群

```bash
$ # 启动集群
$ minikube start
$
$ # 集群状态
$ minikube status
$
$ # 停止集群
$ minikube stop
```


## 部署 Node.js 应用

* 安装

```bash
$ sudo apt-get install nodejs -y
$
$ ln /usr/bin/nodejs /usr/bin/node
$
$ node --version
0.10.25
```

* 运行

```js
$ cat server.js
var http = require('http');

var handleRequest = function(request, response) {
  console.log('Received request for URL: ' + request.url);
  response.writeHead(200);
  response.end('Hello World!');
};
var www = http.createServer(handleRequest);
www.listen(8080);
```

```bash
$ node server.js
$ 
$ curl http://localhost:8080/
```

* 构建镜像

```
$ cat Dockerfile
FROM node:6.9.2
EXPOSE 8080
COPY server.js .
CMD node server.js
```

```bash
$ docker build -t hello-node:v1 -f Dockerfile .
```

## 创建 Deployment

```bash
$ # 创建
$ kubectl run hello-node --image=hello-node:v1 --port=8080
$ 
$ # 查看
$ kubectl get deployments
$
$ # 查看集群事件
$ kubectl get events
$
$ # 查看 kubectl 配置
$ kubectl config view
```

## 创建 Service

```bash
$ # 创建
$ kubectl expose deployment hello-node --type=LoadBalancer
$
$ # 查看
$ kubectl get services
```

## 参考

> https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/