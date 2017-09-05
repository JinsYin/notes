# Kubernetes IP

Kubernetes 中管理主要有三种类型的IP：Pod IP 、Cluster IP 和 外部IP。

## Pod IP

Kubernetes的最小部署单元是Pod。利用Flannel作为不同HOST之间容器互通技术时，由Flannel和etcd维护了一张节点间的路由表。Flannel的设计目的就是为集群中的所有节点重新规划IP地址的使用规则，从而使得不同节点上的容器能够获得“同属一个内网”且”不重复的”IP地址，并让属于不同节点上的容器能够直接通过内网IP通信。 
每个Pod启动时，会自动创建一个镜像为gcr.io/google_containers/pause:0.8.0的容器，容器内部与外部的通信经由此容器代理，该容器的IP也可以称为Pod IP。


## Cluster IP

service的cluster-ip是k8s系统中的虚拟ip地址，只能在内部访问。
如果需要在外部访问的话，可以通过NodePort或者LoadBalancer的方式


## 外部IP

## 参考

* [Kubernetes 中的 PodIP、ClusterIP 和外部 IP](http://blog.csdn.net/liukuan73/article/details/54773579)