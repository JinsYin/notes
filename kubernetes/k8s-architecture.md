# Kubernetes 架构

![kubernetes 架构](./img/k8s-architecture.png)


## 核心组件

| Name                    | 功能描述                 |
| ----------------------- | ----------------------- |
| etcd                    | 保存整个集群的状态 |
| flannel                 | 可选，基于 Etcd 的容器网络 |
| container runtime       | 负责镜像管理以及 Pod 和容器的真正运行（CRI），支持 Docker 和　rkt |

* Kubernetes master

| Name                    | 功能描述                 |
| ----------------------- | ----------------------- |
| kube-apiserver          | 提供了资源操作的唯一入口，并提供认证、授权、访问控制、API 注册和发现等机制 |
| kube-scheduler          | 负责资源的调度，按照预定的调度策略将 Pod 调度到相应的机器上 |
| kube-controller-manager | 负责维护集群的状态，比如故障检测、自动扩展、滚动更新等 |

* Kubernetes node

| Name                    | 功能描述                 |
| ----------------------- | ----------------------- |
| kubelet                 | 负责管理 Pod 和维护容器的生命周期，同时也负责 Volume（CVI）和网络（CNI）的管理，并与 Kubernetes master 通信 |
| kube-proxy              | 负责为 Service 提供 cluster 内部的服务发现和负载均衡 |

另外还有一个二进制包 `hyperkube`， 它可以合并了上面所有的 kubernetes 二进制包，类似于 busybox。

除了核心组件，还有一些推荐的 Add-ons：

  * kube-dns - 负责为整个集群提供 DNS 服务
  * Ingress - Controller 为服务提供外网入口
  * Heapster - 提供资源监控
  * Dashboard - 提供 GUI
  * Federation - 提供跨可用区的集群
  * Fluentd-elasticsearch - 提供集群日志采集、存储与查询


## 基本概念

* Master

  * Master 负责管理集群：调度应用、维护应用理想状态、伸缩应用，以及滚动更新。

* Node（原名 Minion）

  * 运行 Pod 的主机，可以是物理机，也可以是虚拟机，类似 Mesos 集群的 Slave 节点；
  * 为了管理 Pod，每个 Node 节点上至少要运行 container runtime（docker 或 rkt）、kubelet 和 kube-proxy　服务；
  * 生产环境的 Kubernetes 最少需要 `3` 个 Node。

![Kubernetes Node](./img/k8s-node.png)

* Pod

  * Pod 是 Kubernetes 的最小单元, 每个 pod 可以包含一个或者多个容器; 为了便于管理，一般情况下同一个 pod 里运行相同业务的容器；
  * 同一个 pod 中的多个容器共享相同的系统栈（网络，存储），可以通过进程间通信和文件共享这种简单高效的方式组合完成服务；
  * 同一个 pod 只能运行在同一个机器上，一台机器可以运行多个 pod；
  * Pod 是 Kubernetes 集群中所有业务类型的基础，目前 K8s 中的业务主要可以分为长期伺服型（long-running）、批处理型（batch）、节点后台支撑型（node-daemon）和有状态应用型（stateful application），分别对应的控制器为 Deployment、Job、DaemonSet 和 PetSet。

![Kubernetes Pod](./img/k8s-pod.png)

* Namespace

  * Namespace 为 K8s 集群中的资源和对象提供虚拟的隔离作用，比如可以用来将系统内部的对象划分为不同的项目组或用户组。
  * K8s 集群初始有两个名字空间，分别是默认名字空间 default 和系统名字空间 kube-system，常见的 pods, services, replication controllers 和 deployments 等都是属于某一个 namespace 的（默认是 default），而 node, persistentVolumes 等则不属于任何 namespace。

* Lable

  * Label 是识别 Kubernetes 对象（pod、service、rc）的标签，以 key/value 的方式附加到对象上（key　最长不能超过　63　个字节，value　可以为空，也可以是不超过 253　字节的字符串）；
  * Label 不提供唯一性，并且实际上经常是很多对象（如　Pods）都使用相同的 label 来标注具体的应用；
  * Label 定义好后，其他对象可以使用 `Label Selector` 来选择一组相同 label 的对象（比如 ReplicaSet 和 Service 用 label 来选择一组 Pod）;
  * Label Selector 支持以下几种方式：
    * 等式，如 app=nginx 和 env!=production
    * 集合，如 env in (production, qa)
    * 多个 label（它们之间是 AND 关系），如 app=nginx,env=test

* Annotations

  * Annotations 是 key/value 形式附加到 Kubernetes 对象的注解；
  * 不同于 Label 用于标注和选择对象，Annotations 则是用来记录一些附加信息，用来辅助应用部署、安全策略以及调度策略等，比如 deployment 使用 annotations 来记录 rolling update 的状态。

* Controller Manager

  * Replicateion controller

* Replicateion Controller（RC）

  * RC 是 Kubernetes 中最早的保证 Pod 高可用的 API 对象，通过监控运行中的 Pod 来保证集群中运行指定数目的 Pod 副本；
  * RC 是 Kubernetes 较早期的技术概念，只适用于长 long-running 型的业务类型，比如提供高可用的 Web 服务；
  * RC 会用预先定义好的 Pod 模版来创建 Pod， 创建成功后正在运行的 Pod 实例不会随着模版的改变而改变；
  * RC 通过 SELECTOR（一种 label）与 Pod 对应起来；
  * RC 还有一种神奇的机制: rolling updates， 比如现在某个服务有 5 个正在运行的 Pod, 现在 Pod 本身的业务要更新了, 可以以逐个替换的机制来实现整个 RC 的更新。

* Replica Set（RS）

  * RS 是新一代 RC，提供同样的高可用能力，区别主要在于 RS 后来居上，能支持更多种类的匹配模式;
  * RS 对象一般不单独使用，而是作为 Deployment 的理想状态参数使用。

* Deployment

  * Deployment 表示用户对 Kubernetes 的一次更新操作；
  * Deployment 是一个比 RS 应用模式更广的 API 对象，可以是创建一个新的服务，更新一个新的服务，也可以是滚动升级一个服务；

* Service

  * Service 通过 labels 为应用提供负载均衡和服务发现，匹配 labels 的 Pod IP 和端口列表组成 endpoints，由 kube-proxy 负责将 Service IP 负载均衡到这些 endpoints 上；
  * 每个 Service 都会自动分配一个 cluster IP（仅在集群内部可访问的虚拟地址）和 DNS 名，其他容器可以通过该地址或 DNS 来访问服务；

![Kubernetes Service](./img/k8s-service.png)

* Job

  * Job 是 Kubernetes 用来控制批处理型（batch）任务的 API 对象；
  * Batch 业务与 long-running 业务的主要区别是 batch 业务的运行有头有尾，而 long-runngin 业务在用户不停止的情况下永远运行；
  * Job 管理的 Pod 待任务成功完成后自动退出，成功完成的标志根据不同的 spec.completions 策略而不同：单 Pod 型任务有一个 Pod 成功就标志完成；定数成功型任务保证有 N 个任务全部成功；工作队列型任务根据应用确认的全局成功而标志成功。

* DaemonSet

  * Long-running 型和 batch 型服务的核心在业务应用，可能有些节点运行多个同类业务的 Pod，有些节点上又没有这类 Pod 运行；
  * 而后台支撑型服务的核心关注点在 Kubernetes 集群中的节点（物理机或虚拟机），要保证每个节点上都有一个此类 Pod 运行；
  * 节点可能是所有集群节点也可能是通过 nodeSelector 选定的一些特定节点；
  * 典型的 DaemonSet 型服务包括，存储，日志和监控等在每个节点上支持 Kubernetes 集群运行的服务。

* PetSet

  * RC 和 RS 主要是控制提供无状态服务的，其所控制的 Pod 的名字也是随机设置的，而 PetSet 是用来控制有状态服务的，PetSet 中的每个 Pod 的名字都是事先确定的，不能更改；
  * RC 和 RS 中的 Pod 一般不挂载存储，而 PetSet 中的 Pod 挂载自己独立的存储，如果一个 Pod 出现故障，从其他节点启动一个同样名字的 Pod，并挂载原来的存储继续提供服务；
  * 适合于 PetSet 的业务包括数据库服务 MySQL 和 PostgreSQL，集群化管理服务 Zookeeper、Etcd 等有状态服务。

* Federation（集群联邦）

  * 在云计算环境中，服务的作用范围从近到远一般可以有：同主机（Host，Node）、跨主机同可用区（Available Zone）、跨可用区同地区（Region）、跨地区同服务商（Cloud Service Provider）、跨云平台；
  * Kubernetes 的设计定位是单一集群在同一个地域内，因为同一个地区的网络性能才能满足 Kubernetes 的调度和计算存储连接要求。而联合集群服务就是为提供跨 Region 跨服务商 Kubernetes 集群服务而设计的；
  * 每个 Kubernetes Federation 有自己的分布式存储、API Server 和 Controller Manager。

* Volume

  * Docker 的存储卷作用范围是一个容器，而 Kubernetes 的存储卷的生命周期和作用范围是一个 Pod，并且 Pod 中的所有容器共享存储卷；
  * Kubernetes 支持多种存储卷类型，云平台：AWS，Google 和 Azure；分布式存储：GlusterFS 和 Ceph；主机目录： hostPath 和 NFS；
  * Kubernetes 还支持使用 Persistent Volume Claim（PVC）这种逻辑存储，使用这种存储，使得存储的使用者可以忽略后台的实际存储技术（例如 AWS，Google 或 GlusterFS 和 Ceph），而将有关存储实际技术的配置交给存储管理员通过 Persistent Volume 来配置。

* Persistent Volume（PV）和 Persistent Volume Claim（PVC）

  * PV 和 PVC 使得 Kubernetes 具备了存储的逻辑抽象能力，使得在配置 Pod 的逻辑里可以忽略对实际后台存储技术的配置，而把这项配置的工作交给 PV 的配置者，即集群的管理者；
  * 存储的 PV 和 PVC 的这种关系，跟计算的 Node 和 Pod 的关系是非常类似的；
  * PV 和 Node 是资源的提供者，根据集群的基础设施变化而变化，由 K8s 集群管理员配置；而 PVC 和 Pod 是资源的使用者，根据业务服务的需求变化而变化，由 K8s 集群的使用者即服务的管理员来配置。

* Secret

  * Secret 是用来保存和传递密码、密钥、认证凭证等敏感信息的对象；好处是可以避免把敏感信息明文写在配置文件里，比如访问 Ceph 存储的用户名和密码；
  * 配置文件中通过 Secret 对象引用这些敏感信息。

* User Account 和 Service Account

  * User Account 为人提供账户标识，而 Service Account 为计算机进程和 K8s 集群中运行的 Pod 提供账户标识；
  * User Account 和 Service Account 的一个区别是作用范围；User Account 对应的是人的身份，人的身份与服务的 namespace 无关，所以 User Account 是跨 namespace 的；而 Service Account 对应的是一个运行中程序的身份，与特定 namespace 是相关的。

* RBAC 访问授权

  * 基于角色的访问控制（Role-based Access Control，RBAC）的授权模式；
  * 相对于基于属性的访问控制（Attribute-based Access Control，ABAC），RBAC 主要是引入了角色（Role）和角色绑定（RoleBinding）的抽象概念；
  * 在 ABAC 中，K8s 集群中的访问策略只能跟用户直接关联；而在 RBAC 中，访问策略可以跟某个角色关联，具体的用户在跟一个或多个角色相关联。显然，RBAC像其他新功能一样，每次引入新功能，都会引入新的 API 对象，从而引入新的概念抽象，而这一新的概念抽象一定会使集群服务管理和使用更容易扩展和重用。


## 参考

* [Kubernetes Design and Architecture](https://github.com/kubernetes/community/blob/master/contributors/design-proposals/architecture.md)