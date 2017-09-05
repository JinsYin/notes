## Kubeadm 镜像

不同版本的  `kubeadm`，部署集群时所需要的镜像版本也不尽相同。

## 1.6.X

| 组件                                       | 版本       |
| ---------------------------------------- | -------- |
| gcr.io/google_containers/kube-controller-manager-amd64 | v1.6.`x` |
| gcr.io/google_containers/kube-apiserver-amd64 | v1.6.`x` |
| gcr.io/google_containers/kube-scheduler-amd64 | v1.6.`x` |
| gcr.io/google_containers/kube-proxy-amd64 | v1.6.`x` |
| gcr.io/google_containers/pause-amd64     | 3.0      |
| gcr.io/google_containers/etcd-amd64      | 3.0.17   |

| 插件                                       | 版本                |
| ---------------------------------------- | ----------------- |
| gcr.io/google_containers/k8s-dns-sidecar-amd64 | 1.14.1            |
| gcr.io/google_containers/k8s-dns-kube-dns-amd64 | 1.14.1            |
| gcr.io/google_containers/k8s-dns-dnsmasq-nanny-amd64 | 1.14.1            |
|                                          |                   |
| prom/prometheus                          | v1.3.1            |
| prom/node-exporter                       | 0.12.0            |
|                                          |                   |
| weaveworks/weave-npc                     | 2.0.4             |
| weaveworks/weave-kube                    | 2.0.4             |
|                                          |                   |
| kubernetes-dashboard-amd64               | v1.6.`x` ~ v1.6.3 |

## 1.7.X

