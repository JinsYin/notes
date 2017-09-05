# Kubernetes Pod


## 共享网络和存储

Pod 中的应用可以共享网络空间（IP 地址和端口），因此可以通过 `localhost` 互相发现，但必须协调好应用之间的端口。

Pod 中的应用容器可以共享 volume。


## Pod 与 Controller

在 Kubernetes 中虽然可以直接创建和使用 Pod，但它可能会因为 Node 故障或者调度器故障而被删除。因此，通常是使用 Controller 来管理 Pod 的。

Controller 可以创建和管理多个 Pod，提供副本管理、滚动更新以及集群级别的自愈能力。

管理 Pod 的 Controller 包括：

  * Deployment
  * StatefulSet
  * DaemonSet


## Pod Templates

Pod 模板指的是在其他对象（非 Pod 对象）中定义 Pod，比如 Replication Controllers、Jobs 和 DaemonSets。Controller 会根据 Pod 模板来创建实际的 Pod。

Volume 跟 Pod 有相同的生命周期



## Pod 定义

定义一个 nginx pod：

* 使用 YAML 来定义（推荐）

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.11.9-alpine
    ports:
    - containerPort: 80
```

* 使用 JSON 来定义

```json
{
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "name": "nginx",
    "labels": [
      {"app": "nginx"}
    ]
  },
  "spec": {
    "containers": [
      {
        "name": "nginx",
        "image": "nginx:1.11.9-alpine",
        "ports": [
          {"containerPort": 80}
        ]
      }
    ]
  }
}
```


## 使用 Volume

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis
spec:
  containers:
  - name: redis
    image: redis
    port:
    - containerPort: 80
    volumeMounts:
    - name: redis-storage
      mountPath: /data/redis
  volumes:
  - name: redis-storage
    emptyDir: {}
```


## 私有镜像

在使用私有镜像时，需要创建一个 docker registry secret，并在容器中引用。


```bash
$ # 创建 docker registry secret
$ kubectl create secret docker-registry my_registry_secret --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>
```

容器中引用该 secret：

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: private-reg
spec:
  containers:
  - name: private-reg-container
    image: <my-private-image>
  imagePullSecrets:
  - name: my_registry_secret
```


## RestartPoliy

支持三种 RestartPolicy：

  * Always：只要退出就重启
  * OnFailure：失败退出（exit code 不等于 0）时重启
  * Never：只要退出就不再重启

注意，这里的重启是指在 Pod 所在 Node 上面本地重启，并不会调度到其他 Node 上去。


## 环境变量

环境变量为容器提供了一些重要的资源，包括容器和 Pod 的基本信息以及集群中服务的信息等：

(1) hostname
HOSTNAME 环境变量保存了该 Pod 的 hostname。

（2）容器和 Pod 的基本信息
Pod 的名字、命名空间、IP 以及容器的计算资源限制等可以以 [Downward API](https://kubernetes.io/docs/tasks/inject-data-application/downward-api-volume-expose-pod-information/) 的方式获取并存储到环境变量中。

```
apiVersion: v1
kind: Pod
metadata:
  name: test
spec:
  containers:
    - name: test-container
      image: gcr.io/google_containers/busybox
      command: [ "sh", "-c"]
      args:
      - env
      resources:
        requests:
          memory: "32Mi"
          cpu: "125m"
        limits:
          memory: "64Mi"
          cpu: "250m"
      env:
      - name: MY_NODE_NAME
        valueFrom:
          fieldRef:
            fieldPath: spec.nodeName
      - name: MY_POD_NAME
        valueFrom:
          fieldRef:
            fieldPath: metadata.name
      - name: MY_POD_NAMESPACE
        valueFrom:
          fieldRef:
            fieldPath: metadata.namespace
      - name: MY_POD_IP
        valueFrom:
          fieldRef:
            fieldPath: status.podIP
      - name: MY_POD_SERVICE_ACCOUNT
        valueFrom:
          fieldRef:
            fieldPath: spec.serviceAccountName
      - name: MY_CPU_REQUEST
        valueFrom:
          resourceFieldRef:
            containerName: test-container
            resource: requests.cpu
      - name: MY_CPU_LIMIT
        valueFrom:
          resourceFieldRef:
            containerName: test-container
            resource: limits.cpu
      - name: MY_MEM_REQUEST
        valueFrom:
          resourceFieldRef:
            containerName: test-container
            resource: requests.memory
      - name: MY_MEM_LIMIT
        valueFrom:
          resourceFieldRef:
            containerName: test-container
            resource: limits.memory
  restartPolicy: Never
```

(3) 集群中服务的信息

容器的环境变量中还包括了容器运行前创建的所有服务的信息，比如默认的 kubernetes 服务对应了环境变量

```
KUBERNETES_PORT_443_TCP_ADDR=10.0.0.1
KUBERNETES_SERVICE_HOST=10.0.0.1
KUBERNETES_SERVICE_PORT=443
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT=tcp://10.0.0.1:443
KUBERNETES_PORT_443_TCP=tcp://10.0.0.1:443
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_PORT_443_TCP_PORT=443
```

由于环境变量存在创建顺序的局限性（环境变量中不包含后来创建的服务），推荐使用 [DNS](../components/k8s-kube-dns.md) 来解析服务。


## ImagePullPolicy

支持三种 ImagePullPolicy：

  * Always：不管镜像是否存在都会进行一次拉取；
  * Never：不管镜像是否存在都不会进行拉取；
  * IfNotPresent：只有镜像不存在时，才会进行镜像拉取。

注意：

  * 默认为 IfNotPresent，但 :latest 标签的镜像默认为 Always；
  * 拉取镜像时 docker 会进行校验，如果镜像中的 MD5 码没有变，则不会拉取镜像数据；
  * 生产环境中应该尽量避免使用 :latest 标签，而开发环境中可以借助 :latest 标签自动拉取最新的镜像。


## 访问 DNS 的策略

通过 spec.dnsPolicy 参数，可以设置 Pod 中容器访问 DNS 的策略

  * ClusterFirst（配置）：优先基于 cluster domain 后缀，通过 kube-dns 查询；
  * Default：优先从 kubelet 中配置的 DNS 查询。


## 使用主机的 IPC 命名空间

通过设置 hostIPC 参数 True，使用主机的 IPC 命名空间，默认为 False。


## 使用主机的网络命名空间

通过设置 hostNetwork 参数 True，使用主机的网络命名空间，默认为 False。


## 使用主机的 PID 空间

通过设置 hostPID 参数 True，使用主机的 PID 命名空间，默认为 False。

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: busybox1
  labels:
    name: busybox
spec:
  hostIPC: true
  hostPID: true
  hostNetwork: true
  containers:
  - name: busybox
    image: busybox
    command:
    - sleep
    - "3600"
```

## 设置 Pod 中的 hostname

通过 hostname 参数实现，如果未设置默认使用 metadata.name 参数的值作为 Pod 的 hostname。


## 设置 Pod 的子域名

通过 spec.subdomain 参数设置 Pod 的子域名，默认为空

  * 指定 hostname 为 busybox-2 和 subdomain 为 default-subdomain，完整域名为 busybox-2.default-subdomain.default.svc.cluster.local：

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: busybox2
labels:
  name: busybox
spec:
  hostname: busybox-2
  subdomain: default-subdomain
containers:
- name: busybox
  image: busybox
  command:
    - sleep
    - "3600"
```


## 资源限制

Kubernetes 通过 cgroups 限制容器的 CPU 和内存等计算资源，包括 requests（请求，调度器确保调度到资源充足的 Node 上）和 limits（上限）等：

  * spec.containers[].resources.limits.cpu：CPU 上限，可以短暂超过，容器也不会被停止；
  * spec.containers[].resources.limits.memory：内存上限，不可以超过；如果超过，容器可能会被停止或调度到其他资源充足的机器上；
  * spec.containers[].resources.requests.cpu：CPU 请求，可以超过；
  * spec.containers[].resources.requests.memory：内存请求，可以超过；但如果超过，容器可能会在 Node 内存不足时清理。

比如 nginx 容器请求 30% 的 CPU 和 56MB 的内存，但限制最多只用 50% 的 CPU 和 128MB 的内存：

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.11.9-alpine
    resouces:
      requests:
        cpu: "300m"
        memory: "56Mi"
      limits:
        cpu: "500m"
        memory: "128Mi"
```

注意，CPU 的单位是 milicpu，500mcpu=0.5cpu；而内存的单位则包括 E, P, T, G, M, K, Ei, Pi, Ti, Gi, Mi, Ki等。


## 健康检查

为了确保容器在部署后确实处在正常运行状态，Kubernetes 提供了两种探针（Probe，支持 exec、tcp 和 httpGet 方式）来探测容器的状态：

  * LivenessProbe：探测应用是否处于健康状态，如果不健康则删除重建容器；
  * ReadinessProbe：探测应用是否启动完成并且处于正常服务状态，如果不正常则更新容器的状态。

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  containers:
  - image: nginx
    imagePullPolicy: Always
    name: http
    livenessProbe:
      httpGet:
      path: /
      port: 80
      initialDelaySeconds: 15
      timeoutSeconds: 1
    readinessProbe:
      httpGet:
      path: /ping
      port: 80
      initialDelaySeconds: 5
      timeoutSeconds: 1
```

## Init Container

Init Container 在所有容器运行之前执行（run-to-completion），常用来初始化配置。

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: init-demo
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    volumeMounts:
    - name: workdir
      mountPath: /usr/share/nginx/html
  # These containers are run during pod initialization
  initContainers:
  - name: install
    image: busybox
    command:
    - wget
    - "-O"
    - "/work-dir/index.html"
    - http://kubernetes.io
    volumeMounts:
    - name: workdir
      mountPath: "/work-dir"
  dnsPolicy: Default
  volumes:
  - name: workdir
    emptyDir: {}
```


## 容器生命周期钩子

容器生命周期钩子（Container Lifecycle Hooks）监听容器生命周期的特定事件，并在事件发生时执行已注册的回调函数。支持两种钩子：

  * postStart：容器启动后执行，注意由于是异步执行，它无法保证一定在 ENTRYPOINT 之后运行。如果失败，容器会被杀死，并根据 RestartPolicy 决定是否重启；
  * preStop：容器停止前执行，常用于资源清理。如果失败，容器同样也会被杀死。

而钩子的回调函数支持两种方式：

  * exec：在容器内执行命令
  * httpGet：向指定 URL 发起 GET 请求

postStart 和 preStop钩子示例：

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: lifecycle-demo
spec:
  containers:
  - name: lifecycle-demo-container
    image: nginx
    lifecycle:
      postStart:
        exec:
          command: ["/bin/sh", "-c", "echo Hello from the postStart handler > /usr/share/message"]
      preStop:
        exec:
          command: ["/usr/sbin/nginx","-s","quit"]
```


## 使用 Capabilities

默认情况下，容器都是以非特权容器的方式运行。比如，不能在容器中创建虚拟网卡、配置虚拟网络。

Kubernetes 提供了修改 Capabilities 的机制，可以按需要给容器增加或删除。比如下面的配置给容器增加了 CAP_NET_ADMIN 并删除了 CAP_KILL。

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hello-world
spec:
  containers:
  - name: friendly-container
    image: "alpine:3.4"
    command: ["/bin/echo", "hello", "world"]
    securityContext:
      capabilities:
        add:
        - NET_ADMIN
        drop:
        - KILL
```


## 限制网络带宽

可以通过给 Pod 增加 `kubernetes.io/ingress-bandwidth` 和 `kubernetes.io/egress-bandwidth` 这两个 annotation 来限制 Pod 的网络带宽。

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: qos
  annotation:
    kubernetes.io/ingress-bandwidth: 3M
    kubernetes.io/egress-bandwidth: 4M
spec:
  containers:
  - name: iperf3
    image: networkstatic/iperf3
    command:
      - iperf3
      - -s
```

> 目前只有 kubenet 网络插件支持限制网络带宽，其他 CNI 网络插件暂不支持这个功能。

kubenet 的网络带宽限制其实是通过 tc 来实现的：

```bash
$ # setup qdisc (only once)
$ tc qdisc add dev cbr0 root handle 1: htb default 30
$ # download rate
$ tc class add dev cbr0 parent 1: classid 1:2 htb rate 3Mbit
$ tc filter add dev cbr0 protocol ip parent 1:0 prio 1 u32 match ip dst 10.1.0.3/32 flowid 1:2
$ # upload rate
$ tc class add dev cbr0 parent 1: classid 1:3 htb rate 4Mbit
$ tc filter add dev cbr0 protocol ip parent 1:0 prio 1 u32 match ip src 10.1.0.3/32 flowid 1:3
```


## 调度到指定的 Node 上

可以通过 nodeSelector、nodeAffinity、podAffinity 以及 Taints 和 tolerations 等来将 Pod 调度到需要的 Node 上。

也可以通过设置 nodeName 参数，将 Pod 调度到制定 node 节点上。

比如，使用 nodeSelector，首先给 Node 加上标签：

```bash
$ kubectl label nodes <your-node-name> disktype=ssd
```

接着，指定该 Pod 只想运行在带有 disktype=ssd 标签的 Node 上：

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  nodeSelector:
    disktype: ssd
```

nodeAffinity、podAffinity 以及 Taints 和 tolerations 等的使用方法请参考 [调度器](./components/k8s-kube-shceduler.md) 章节。


## 自定义 hosts

默认情况下，容器的 `/etc/hosts` 是 kubelet 自动生成的，并且仅包含 localhost 和 podName 等。不建议在容器内直接修改 /etc/hosts 文件，因为在 Pod 启动或重启时会被覆盖。

从 v1.7 开始，可以通过 pod.Spec.HostAliases 来增加 hosts 内容，如

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hostaliases-pod
spec:
  hostAliases:
  - ip: "127.0.0.1"
    hostnames:
    - "foo.local"
    - "bar.local"
  - ip: "10.1.2.3"
    hostnames:
    - "foo.remote"
    - "bar.remote"
  containers:
  - name: cat-hosts
    image: busybox
    command:
    - cat
    args:
    - "/etc/hosts"
```


## 参考

  * [Pod Overview](https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/)
  * [Pod 概念](https://kubernetes.feisky.xyz/concepts/pod.html#)