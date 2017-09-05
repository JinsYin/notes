# Kubernetes 入门

## 部署 nginx

```bash
$ kubectl run nginx-app --image=nginx:1.11.9-alpine --port=80 --replicas=3
```

部署好后查看事件日志（`kubectl get events`）发现，实际上并没有真正部署成功，原因是每个 Pod 依赖一个 `gcr.io/google_containers/pause-amd64:3.0` 的镜像，而由于国内的 Great Firewall 导致无法下载 Google 的镜像，但是还是可以使用间接的方式创建这些镜像：

```bash
$ # 所有 Node 节点
$ docker pull googlecontainer/pause-amd64:3.0
$ docker tag googlecontainer/pause-amd64:3.0 gcr.io/google_containers/pause-amd64:3.0
```


## 部署 Node


默认情况，所有的 Pod 仅在集群内部是可见的。如果要从本机访问应用容器，需要在主机和 Kubernetes 集群之间创建一个代理。

```bash
$ # 创建代理
$ kubectl proxy
$
$ # Pod Name
$ export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
$ echo $POD_NAME
$
$ # 查看应用容器的输出
$ curl http://localhost:8001/api/v1/proxy/namespaces/default/pods/$POD_NAME/
$ 
$ # 容器日志（没有指定容器名是因为这个 Pod 里只有一个容器）
$ kubectl logs $POD_NAME
$
$ # 在容器中执行命令
$ kubectl exec $POD_NAME env
$ kubectl exec -it $POD_NAME bash
$
$ # 查看　Pod IP
$ kubectl get pods -o yaml -l run=nginx-web | grep podIP
```

* Service

![Kubernetes Service](./img/k8s-service.png)

Service 在 Kubernetes 中是一个抽象概念，它定义了一组逻辑的 Pod 集合以及访问它们的策略。Service 使用 YAML 和 JSON 来定义。

```bash
$ kubectl get services
$
$ # 创建一个 service 并且暴露到集群外
$ kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080
$
$ # service 列表
$ kubectl get services
$
$ # 查看对外开放的端口等信息
$ kubectl describe services/kubernetes-bootcamp
```

* Scaling

![Kubernetes Scaling](./k8s-scaling-before.png)
![Kubernetes Scaling](./k8s-scaling-after.png)

```scala
$ # DESIRED：设置的副本；CURRENT：当前有多少个副本在运行；UP-TO-DATE：更新的副本数；AVAILABLE：有多少副本可用
$ kubectl get deployments
$
$ # 扩大（scale up） Deployment
$ kubectl scale deployment/kubernetes-bootcamp --replicas=4
$
$ # 检查 pod 数量
$ kubectl get pods -o wide
$
$ kubectl describe deployments/kubernetes-bootcamp
$
$ # 查看暴露的 IP 和 Port
$ kubectl describe services/kubernetes-bootcamp
$
$ # Service 会负载均衡，每次请求可能会访问不同的 pod
$ curl host01:$NODE_PORT
$
$ # 缩减（scale down） Deployment
$ kubectl scale deployments/kubernetes-bootcamp --replicas=2
$ 
$ kubectl get deployments
$
$ kubectl get pods -o wide
```

* Updating

```bash
$ # 查看应用的镜像版本
$ kubectl get pods
$ 
$ # 更新应用的镜像版本为 v2
$ kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2
$
$ # 检查应用是否更新
$ curl host01:$NODE_PORT
$
$ # 确认更新
$ kubectl rollout status deployments/kubernetes-bootcamp
$
$ # 更新到 v10 （v10版本并不存在）
$ kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v10
$
$ # 发现部署错误
$ kubectl get deployments
$ kubectl get pods
$ 
$ # 回滚到上一个版本
$ kubectl rollout undo deployments/kubernetes-bootcamp
$
$ kubectl get pods
$ kubectl describe pods
```


## 创建集群

开发环境使用 Minikube 创建集群，MiniKube 的具体安装教程可以看[k8s-minikube.md](./k8s-minikube.md)。

```bash
$ # 检查版本
$ minikube version
$ 
$ # 启动集群
$ minikube start
$
$ # 检查　kubectl 版本
$ kubectl version
$
$ # 集群信息
$ kubectl cluster-info
$ 
$ # 查看所有可以用于发布应用的节点
$ kubectl get nodes
$
$$ # 节点端口
$ export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
$ echo NODE_PORT=$NODE_PORT
$
$ # 测试应用是否暴露在集群外
$ kubectl get nodes
$ curl minikube:$NODE_PORT
$
$ # Deployment 会为 Pod 自动创建 label
$ kubectl describe deployments
$
$ # 使用 label 来查看 pod
$ kubectl get pods -l run=kubernetes-bootcamp
$
$ # 使用 label 来查看 service
$ kubectl get services -l run=kubernetes-bootcamp
$ 
$ # 新增一个 label
$ kubectl label pod $POD_NAME app=v1
$ 
$ kubectl describe pods $POD_NAME
$
$ # 使用新 label 查询 pod
$ kubectl get pods -l app=v1
$
$ # 删除 service
$ kubectl delete service -l run=kubernetes-bootcamp
$ kubectl get services
$ curl minikube:$NODE_PORT
$
$ # 集群内部访问
$ kubectl exec -ti $POD_NAME curl localhost:8080
```

## 部署应用

* Kubernetes Deployment

Deployment 负责创建、更新应用实例。创建　Deployment 后，Kubernetes master 调度　Deployment 创建的应用实例到集群节点上。应用实例创建后，Deployment 控制器会连续不断地监控这些应用。

![Kubernetes deployment](./img/k8s-deployment.md)

```bash
$ # 创建 deployment
$ kubectl run nginx-web --image=nginx:1.11.9-alpine --port=80
$
$ # 先下载镜像
$ docker pull docker.io/jocatalin/kubernetes-bootcamp:v1
$
$ # 包括完整的 repository url
$ kubectl run kubernetes-bootcamp --image=docker.io/jocatalin/kubernetes-bootcamp:v1 --port=8080
$
$ # 查看创建的 Deployment
$ kubectl get deployments
$
$ # 删除 Deployment
$ kubectl delete deployments d1 d2 ...
```


## 参考

* [Kubernetes Tutorials](https://kubernetes.io/docs/tutorials/)
