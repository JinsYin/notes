# Kubernetes Namespace

Namespace 常用来隔离不同的用户，比如 Kubernetes 自带的服务一般运行在 `kube-system` namespace 中。当你的项目和人员众多的时候可以考虑根据项目属性，例如生产、测试、开发划分不同的 namespace。

集群中默认会有 `default` 和 `kube-system` 这两个 namespace，但并不是所有的资源对象都会对应 namespace，`node` 和 `persistentVolume` 就不属于任何 namespace。


## Namespace 操作

`kubect` 可以通过 `--namespace` 或者 `-n` 选项指定 namespace。如果不指定，默认为 `default`。查看操作下,也可以通过设置 `--all-namespace=true` 来查看所有 namespace 下的资源。

* 查询

Namespace 包含两种状态 `Active` 和 `Terminating`。在 namespace 删除过程中，namespace 状态被设置成 `Terminating`。

```bash
$ # kubectl get ns
$ kubectl get namespaces
NAME          STATUS    AGE
default       Active    6d
kube-system   Active    6d
```

* 创建

```bash
$ # (1) 命令行创建
$ kubectl create namespace my-namespace
$
$ # (2) 通过文件创建
$ cat my-namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: my-namespace

$ kubectl create -f my-namespace.yaml
```

* 删除

```bash
$ kubectl delete namespaces my-namespace
```

注意：

  * 删除一个 namespace 会自动删除所有属于该 namespace 的资源；
  * default 和 kube-system 命名空间不可删除；
  * PersistentVolumes 是不属于任何 namespace 的，但 PersistentVolumeClaim 是属于某个特定 namespace 的；
  * Events 是否属于 namespace 取决于产生 events 的对象。