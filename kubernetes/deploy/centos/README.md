# Kubernetes 1.6.2

使用二进制部署最新 kubernetes v1.6.2 集群，而不是使用 kubeadm 等自动化方式来部署集群。


## 集群分布

ip          | hostname   | role   | components |
----------- | ---------- | ------ | ---------- |
172.72.1.10 | k8s-master | master | 
172.72.1.11 | k8s-node-1 | node   |
172.72.1.12 | k8s-node-2 | node   |


## 系统环境

  * CentOS: 7.3.1611
  * Kernel: 3.10.0-514.26.2
  * Kubernetes: 1.6.2
  * Docker: 1.12.6
  * Etcd: 3.1.7
  * Flanneld: 0.7.1 (vxlan)

TLS 认证通信 (所有组件，如 etcd、kubernetes master 和 node)
RBAC 授权
kubelet TLS BootStrapping
kubedns、dashboard、heapster (influxdb、grafana)、EFK (elasticsearch、fluentd、kibana) 插件
私有 docker registry，使用 ceph rgw 后端存储，TLS + HTTP Basic 认证


## 步骤

  * [部署 Master](./k8s-deploy-master.md)
  * [部署 Node](./k8s-deploy-node.md)
  * [部署 Kubectl 工具](./k8s-deploy-kubectl.md)


## 参考

  * [opsnull/follow-me-install-kubernetes-cluster](https://github.com/opsnull/follow-me-install-kubernetes-cluster)