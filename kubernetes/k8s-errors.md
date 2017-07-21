# Kubernetes 错误整理

## 错误一

使用官方教程创建一个 deployment 时，发现它一直处于　`ContainerCreate` 状态，而不是 `Running`　状态。

```bash
$ # 创建一个 deployment
$ kubectl run kubernetes-bootcamp --image=docker.io/jocatalin/kubernetes-bootcamp:v1 --port=8080
$
$ # unavailable
$ kubectl get deployments
NAME                  DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
kubernetes-bootcamp   1         1         1            0           2h
$
$ # ContainerCreating
$ kubectl get pods
NAME                                   READY     STATUS              RESTARTS   AGE
kubernetes-bootcamp-3271566451-903pl   0/1       ContainerCreating   0          2h
$
$ # 发现是因为无法访问 gcr.io
$ kubectl describe pod
```

* 解决办法

> https://hub.docker.com/u/googlecontainer/