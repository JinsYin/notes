# Kubernetes Volume

目前，Kubernetes 支持以下 Volume 类型：

  * GCEPersistentDisk
  * AWSElasticBlockStore
  * AzureFile
  * AzureDisk
  * FC (Fibre Channel)
  * FlexVolume
  * Flocker
  * NFS
  * iSCSI
  * RBD (Ceph Block Device)
  * CephFS
  * Cinder (OpenStack block storage)
  * Glusterfs
  * VsphereVolume
  * Quobyte Volumes
  * HostPath (single node testing only – local storage is not supported in any way and WILL NOT WORK in a multi-node cluster)
  * VMware Photon
  * Portworx Volumes
  * ScaleIO Volumes
  * StorageOS


> 注意，这些 volume 并非全部都是持久化的，比如 emptyDir、secret、gitRepo 等，这些 volume 会随着 Pod 的消亡而消失。


## PV 和 PVC

PersistentVolume（PV）和 PersistentVolumeClaim（PVC）提供了更方便的管理卷的方法：PV 提供网络存储资源，而 PVC 请求存储资源。

PV 和 PVC 可以将 Pod 和数据卷解耦，Pod 不需要知道确切的文件系统或者支持它的持久化引擎。


## PV

PersistentVolume（PV）是集群之中的一块网络存储。跟 Node 一样，也是集群的资源。PV 跟 Volume (卷) 类似，但它独立于 Pod 的生命周期。

* 定义

```yaml
# 定义 NFS 持久化卷
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs001
spec:
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Recycle
  nfs:
    path: /tmp
    server: 172.17.0.2
```

* 访问模式

PV 的访问模式有三种：

  * ReadWriteOnce（RWO）: 在单节点上，以读写的方式被挂载。
  * ReadOnlyMany（ROX）: 在多节点上，以只读的方式被挂载。
  * ReadWriteMany（RWX）: 在多节点上，以读写的方式被挂载。

> 不是每一种存储都支持以上三种方式，像共享方式，目前支持的还比较少，比较常用的是 NFS。
> 尽管 PV 支持多种访问模式，但在同一时刻一个 volume 只能以一种访问模式被挂载。

Volume Plugin | ReadWriteOnce | ReadOnlyMany  | ReadWriteMany |
------------- | ------------- | ------------- | ------------- |
CephFS        | Y             | Y             | Y             |
RBD           | Y             | Y             | N             |


* 回收策略

PV 的回收策略（persistentVolumeReclaimPolicy）也有三种：

  * Retain: 不清理保留 Volume（需要手动清理）。
  * Recycly: 删除数据，即 `rm -rf /thevolume/*` （只有 NFS 和 HostPath 支持）。
  * Delete: 删除存储资源，比如删除 AWS EBS 卷（只有 AWS EBS、GCE PD、Azure Disk 和 Cinder 支持）。


## StorageClass

使用 PV 创建很多 Volume 是不是很方便，Kubernetes 提供了 StorageClass 来动态创建 PV，StorageClass 封装了不同类型的存储供 PVC 选用。

StorageClass 包括两个主要的字段：

  * provisioner: PV 插件
  * parameters: 描述 PV 的配置信息

* Ceph RBD

```yaml
apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: ceph-storage-class
provisioner: kubernetes.io/rbd
parameters:
  monitors: 192.168.68.53:6789,192.168.68.54:6789,192.168.68.57:6789
  adminId: kube
  adminSecretName: ceph-secret
  adminSecretNamespace: kube-system
  pool: kube
  userId: kube
  userSecretName: ceph-secret-user
```

parametes 参数含义：

  * monitors: Ceph Monitor 的地址，多个 Monitor 之间用逗号分割
  * adminId: Ceph 客户端用于创建块设备的用户
  * adminSecretName: admin 的 SecretID
  * adminSecretNamespace: Secret 的 namespace
  * pool: Ceph RBD 的 pool 存储池
  * userID: 用于块设备映射的用户 ID，默认可以和 admin 一致
  * userSecretName： Ceph-Secret 的 ID


## PVC

PV 是存储资源，而 PersistentVolumeClaim（PVC）是对 PV 的请求。PVC 跟 Pod 类似：Pod 消费 Node 的资源，而 PVC 消费 PV 的资源；Pod 能够请求 CPU 和内存资源，而 PVC 请求特定大小和访问模式的数据卷。

在 PVC 绑定 PV 时通常根据两个条件来绑定，一个是存储的大小，另一个就是访问模式。

* 定义

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: myclaim
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 8Gi
  storageClassName: ceph-storage-class
  selector:
    matchLabels:
      release: "stable"
    matchExpressions:
      - {key: environment, operator: In, values: [dev]}
```
