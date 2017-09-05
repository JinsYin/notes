# Kubernetes Heapster

Heapster 是 kubernetes 集群监控工具。在1.2的时候，kubernetes 的监控需要在 node 节点上运行 cAdvisor 作为 agent 收集本机和容器的资源数据，包括cpu、内存、网络、文件系统等。在新版的 kubernetes 中，cAdvisor 被集成到 kubelet 中。通过 netstat 可以查看到kubelet新开了一个4194的端口，这就是cAdvisor监听的端口，现在我们然后可以通过http://<node-ip>:4194的方式访问到cAdvisor。

Heapster支持多种后端存储，包括influxDB，Elasticsearch，Kafka等，在这篇文档里，我们使用influxDB作为后端存储来展示heapster的相关配置。需要说明的是，heapster依赖kubernetes dns配置。具体相关配置请参考另一篇博文《kubernetes 1.5配置dns》。

```bash
# 集成到 kubelet 中的 cadvisor
$ netstat -tpln | grep kubelet | grep 4194
$
$ curl http://localhost:4194
```


## 参考

* [Tools for Monitoring Compute, Storage, and Network Resources](https://kubernetes.io/docs/tasks/debug-application-cluster/resource-usage-monitoring/)