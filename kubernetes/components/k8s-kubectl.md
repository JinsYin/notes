# Kubectl

`kubectl` 是 Kubernetes 的命令行工具，它使用 Kubernetes API 和集群交互。

> * kubectl get - list resources
>
> * kubectl describe - show detailed information about a resource
>
> * kubectl logs - print the logs from a container in a pod
>
> * kubectl exec - execute a command on a container in a pod

kubectl get - 类似于 docker ps，查询资源列表
kubectl describe - 类似于 docker inspect，获取资源的详细信息
kubectl logs - 类似于 docker logs，获取容器的日志
kubectl exec - 类似于 docker exec，在容器内执行一个命令
kubectl delete - 类似于 docker rm，删除资源


## kube-shell

[kube-shell](https://github.com/cloudnativelabs/kube-shell) 可以为 kubectl 提供命令提示以及补全。

```bash
$ pip install kube-shell
```


## kubectl get 

* Pod

```bash
$ kubectl get pods -o wide
$
$ kubectl get pods --show-labels
$
$ kubectl get pods -o yaml
```

* Service

```bash
$ kubectl get services/nginx-app -o yaml
```

## kubectl describe
## kubectl logs
## kubectl exec
## kubectl delete

## kubectl create
## kubectl edit

```bash
$ kubectl edit deploy/nginx-deployment
```

创建对象

## kubectl config

* 设置

```bash
$ kubectl config set
```

* 查看

```bash
$ kubectl config view
```

## kubectl scale

## kubectl rolling-update

滚动升级（Rolling Update），通过逐个容器替代升级的方式来实现无中断的服务升级。




## 常用命令

* describe

```bash
$ # pod 的容器的详细信息（IP、端口以及 Pod 的生命周期）
$ kubectl describe pods 
$
$ kubectl describe nodes
$
$ kubectl describe deployments
$
$ kubectl describe services
```

* logs

```bash
$ kubectl logs $POD_NAME
```

## 部署

```bash
$ # 创建 deployment （docker pull nginx:1.11.9-alpine）
$ kubectl run nginx-web --image=docker.io/nginx:1.11.9-alpine --port=80
$
$ kubectl run hello-minikube --image=gcr.io/google_containers/echoserver:1.4 --port=8080
$ kubectl run kubernetes-bootcamp --image=docker.io/jocatalin/kubernetes-bootcamp:v1 --port=8080
$ 
$ # 暴露端口
$ kubectl expose deployment hello-minikube --type=NodePort
$
```

```bash
$ # 集群信息
$ kubectl cluster-info
$ kubectl cluster-info dump
$
$ # 查看集群节点（ready 状态表示正准备接受应用部署）
$ kubectl get nodes
$
$ # 查看 pod 列表
$ kubectl get pods
$ kubectl get pods --all-namespaces
$
$ # 查看 deployment 列表
$ kubectl get deployments
$ 
$ # 手动伸缩
$ kubectl scale deployment/kubernetes-bootcamp --replicas=2
$
$ # 自动伸缩
$ kubectl autocale deployment/kubernetes-bootcamp --min=1 --max=3
$
$ # 查看 service 列表
$ kubectl get services
$ curl $(minikube service hello-minikube --url)
$
$ # pod 详情
$ kubectl describe pod kubernetes-bootcamp
```

* 更新应用

前面写yaml的时候，apiVersion写的是v1表示第1个版本，如果现在v2出来了，要用v2，是不是要把vi删掉建v2呢？如果是话k8s也太不智能了。 
使用kubectl apply -f 选择新版本的文件，k8s会自动对比运行中版本、老版本、新版本之间的区别，自动更新应用。

```bash
$ kubectl apply -f nginx-app-v2.yaml
```


## 参考

> https://kubernetes.io/docs/user-guide/kubectl-overview/

* [kubectl](https://github.com/feiskyer/kubernetes-handbook/blob/master/components/kubectl.md)
* [kubectl Cheat Sheet](https://kubernetes.io/docs/user-guide/kubectl-cheatsheet/)
* [Overview of kubectl](https://kubernetes.io/docs/user-guide/kubectl-overview/)