# Kubernetes Node

Node 是 Pod 真正运行的主机，可以物理机，也可以是虚拟机。为了管理 Pod，每个 Node 节点上至少要运行 `container runtime`（比如docker或者rkt）、`kubelet` 和 `kube-proxy` 服务。


## Node 管理

不像其他的资源（如 Pod 和 Namespace），Node 本质上不是 Kubernetes 来创建的，Kubernetes 只是管理 Node 上的资源。虽然可以通过 Manifest 创建一个 Node 对象（如下 json 所示），但 Kubernetes 也只是去检查是否真的是有这么一个 Node，如果检查失败，也不会往上调度 Pod。

```json
{
  "kind": "Node",
  "apiVersion": "v1",
  "metadata": {
    "name": "10.240.79.157",
    "labels": {
      "name": "my-first-k8s-node"
    }
  }
}
```

这个检查是由 Node Controller 来完成的。Node Controller 负责：

  * 维护 Node 状态
  * 与 Cloud Provider 同步 Node
  * 给 Node 分配容器 CIDR
  * 删除带有 NoExecute taint 的 Node 上的Pods
  * 默认情况下，kubelet 在启动时会向 master 注册自己，并创建 Node 资源。

* 禁止 Pod 调度到某个节点

仅仅是禁止新的 Pod 被调度到该节点，原先调度到该节点的 Pod 并不发生变化。

```bash
$ kubectl cordon <node-name>
```

* 驱逐某个节点上的所有 Pod

```bash
$ kubectl drain <node-name>
```

该命令会删除该节点上的所有 Pod（DaemonSet 除外），并在其他节点上重新启动，通常在某个节点需要维护时才使用该命令。该命令会自动调用 `kubectl cordon <node-name>` 命令。当该节点维护完成并启动好 kubelet 后，再使用 `kubectl uncordon <node-name>` 即可将该节点添加到 kubernetes 集群中。


## Node 的状态

每个 Node 都包括以下状态信息：

  * 地址：包括 hostname、外网 IP 和内网 IP
  * 条件（Condition）：包括OutOfDisk、Ready、MemoryPressure和DiskPressure
  * 容量（Capacity）：Node 上的可用资源，包括CPU、内存和Pod总数
  * 基本信息（Info）：包括内核版本、容器引擎版本、OS类型等

```bash
$ kubectl get nodes -o wide
```


## Taints 和 tolerations

Taints 和 tolerations 用于保证 Pod 不被调度到不合适的 Node 上，Taint 应用于 Node 上，而 toleration 则应用于 Pod 上（Toleration 是可选的）。

比如，可以使用 taint 命令给 node1 添加 taints：

```bash
$ kubectl taint nodes node1 key1=value1:NoSchedule
$ kubectl taint nodes node1 key1=value2:NoExecute
```