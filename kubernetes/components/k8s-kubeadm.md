# kubeadm 工作原理

Kubernetes 1.4 引入了 kubeadm 命令，它将集群启动简化为两条命令，不需要再使用复杂的 kube-up 脚本。一旦 Kubernetes 被安装，kubeadm init 启动 master 节点，而 kubeadm join 可以将节点并入集群。


## 镜像准备

下面提到的镜像基于目前的 1.6.2 版本，每次更新都会有不同。

Image | Ver Component
gcr.io/google_containers/kube-proxy-amd64 v1.6.2  Kubernetes
gcr.io/google_containers/kube-controller-manager-amd64  v1.6.2  Kubernetes
gcr.io/google_containers/kube-apiserver-amd64 v1.6.2  Kubernetes
gcr.io/google_containers/kube-scheduler-amd64 v1.6.2  Kubernetes
gcr.io/google_containers/etcd-amd64 3.0.17  Kubernetes
gcr.io/google_containers/pause-amd64  3.0 Kubernetes
gcr.io/google_containers/k8s-dns-sidecar-amd64  1.14.1  DNS
gcr.io/google_containers/k8s-dns-kube-dns-amd64 1.14.1  DNS
gcr.io/google_containers/k8s-dns-dnsmasq-nanny-amd64  1.14.1  DNS
gcr.io/google_containers/etcd 2.2.1 Calico
quay.io/calico/node v1.1.3  Calico
quay.io/calico/cni  v1.8.0  Calico
quay.io/calico/kube-policy-controller v0.5.4  Calico


## 参考

* [Using kubeadm to Create a Cluster](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/)
* [kubeadm Setup Tool Reference Guide](https://kubernetes.io/docs/admin/kubeadm/)
* [使用 kubeadm 将 Kubernetes 集群从 1.6 版本升级到 1.7](https://www.kubernetes.org.cn/2408.html)