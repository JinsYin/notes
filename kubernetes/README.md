# Kubernetes 从入门到放弃

Kubernetes 是谷歌开源的容器集群管理系统，是 Google 多年大规模容器管理技术 Borg 的开源版本，主要功能包括：

  * 基于容器的应用部署、维护和滚动升级
  * 负载均衡和服务发现
  * 跨机器和跨地区的集群调度
  * 自动伸缩
  * 无状态服务和有状态服务
  * 广泛的 Volume 支持
  * 插件机制保证扩展性


## 目录

  * [Kubernetes 架构](./k8s-architecture.md)
  * Kubernetes 部署
    * [Minikube Minikube](./deploy/k8s-minikube.md)
    * [Kubernetes On CentOS](./deploy/k8s-on-centos.md)
    * [Kubernetes On CoreOS](./deploy/k8s-on-coreos.md)
  * [Kubernetes 入门](./k8s-quickstart.md)
  * [Kubernetes Dashboard](./k8s-dashboard.md)
  * [Kubernetes 资源](./resource/k8s-resources.md)
  * [Kubernetes 组件](./components/k8s-components.md)
  * [Kubernetes YAML 配置](./k8s-yaml.md)


## 存储

* [Ceph on CoreOS](https://github.com/ceph/ceph-docker/tree/master/examples/coreos)
* [Ceph on Kubernetes](https://github.com/ceph/ceph-docker/tree/master/examples/kubernetes-coreos)
* [Ceph on CoreOS for Kubernetes](https://github.com/ceph/ceph-docker/tree/master/examples/kubernetes-coreos)
* [RBD on Kubernetes](https://github.com/kubernetes/examples/tree/master/staging/volumes/rbd)
* [使用 Ceph RBD 为 Kubernetes 集群提供存储卷](http://tonybai.com/2016/11/07/integrate-kubernetes-with-ceph-rbd/)


## 参考

* [feiskyer/kubernetes-handbook](https://github.com/feiskyer/kubernetes-handbook) - [GitBook](https://feisky.gitbooks.io/kubernetes/)
* [rootsongjc/kubernetes-handbook](https://github.com/rootsongjc/kubernetes-handbook) - [GitBook](https://rootsongjc.gitbooks.io/kubernetes-handbook/)
* [Kubernetes 中文文档](https://www.kubernetes.org.cn/docs)

* [Kubernetes 1.7 新特性：支持绕过 Docker，直接通过 Containerd 管理容器](https://www.kubernetes.org.cn/2311.html) 


https://segmentfault.com/a/1190000003094147