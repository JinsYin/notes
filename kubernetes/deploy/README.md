# Kubernetes 集群部署

## 单机部署

  * [Minikube](./k8s-minikube.md)

## 手动部署

## Kubeadm 部署

kubeadm 目前还是 `beta` 版本，请不要用于生产环境。


## 在线体验

* ### play-with-k8s


[Play with Kubernetes](http://play-with-k8s.com/)提供了一个免费的Kubernets体验环境，直接访问[http://play-with-k8s.com](http://play-with-k8s.com/)就可以使用kubeadm来创建Kubernetes集群。注意，每个创建的集群最长可以使用4小时。

Play with Kubernetes有个非常方便的功能：自动在页面上显示所有NodePort类型服务的端口，点解该端口即可访问对应的服务。

详细使用方法可以参考[Play-With-Kubernetes](https://kubernetes.feisky.xyz/appendix/play-with-k8s.html)。

```bash
$ # node1: 初始化一个 master
$ kubeadm init --apiserver-advertise-address $(hostname -i)

$ # node2: 加入一个 node
$ kubeadm join --token 09ed46.29e7cede69d551e7 10.0.3.3:6443

$ # 创建集群网络
$ kubectl apply -n kube-system -f \
    "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
    
 $ # 创建 kubernetes dashboard
 $ curl -L -s https://git.io/kube-dashboard  | sed 's/targetPort: 9090/targetPort: 9090\n  type: LoadBalancer/' | kubectl apply -f -
```

> https://kubernetes.feisky.xyz/appendix/play-with-k8s.html

* ### Katacoda playground

[Katacoda playground](https://www.katacoda.com/courses/kubernetes/playground)也提供了一个免费的2节点Kuberentes体验环境，网络基于WeaveNet，并且会自动部署整个集群。但要注意，刚打开[Katacoda playground](https://www.katacoda.com/courses/kubernetes/playground)页面时集群有可能还没初始化完成，可以在master节点上运行`launch.sh`等待集群初始化完成。

部署并访问kubernetes dashboard的方法：

```
# 在master node上面运行
kubectl create -f https://git.io/kube-dashboard
kubectl proxy --address='0.0.0.0' --port=8080 --accept-hosts='^*$'&
```

然后点击Terminal Host 1右边的➕，从弹出的菜单里选择View HTTP port 8080 on Host 1，即可打开Kubernetes的API页面。在该网址后面增加`/ui`即可访问dashboard。

### Katacoda getting-started-with-kubeadm 

https://www.katacoda.com/courses/kubernetes/getting-started-with-kubeadm