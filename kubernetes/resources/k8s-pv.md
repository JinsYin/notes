k8s-pv.md


访问模式：

  * readwriteonce - 仅支持单一节点对卷进行读写操作
  * readonlymany - 支持多个节点读操作和单一节点写操作
  * readwritemany - 支持多个节点同时进行读写操作

Kubernetes 原生支持GCE持久化卷和AWS的弹性块存储

## 参考

* [Kubernetes 存储机制的实现](https://www.kubernetes.org.cn/1811.html)

https://kubernetes.io/docs/concepts/storage/persistent-volumes/