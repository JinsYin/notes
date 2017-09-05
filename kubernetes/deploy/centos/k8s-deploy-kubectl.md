# 部署 kubectl

kubectl 默认从 `~/.kube/config` 配置文件中获取访问 kube-apiserver 地址、证书、用户名等信息，如果没有配置该文件，执行命令时出错：

```bash
$  kubectl get pods
The connection to the server localhost:8080 was refused - did you specify the right host or port?
```

## 下载 kubectl

```bash
$ wget -O /tmp/k8s-client.tar.gz https://dl.k8s.io/$KUBECTL_VERSION/kubernetes-client-linux-amd64.tar.gz
$ mkdir -p /tmp/k8s-client && tar -xzf /tmp/k8s-client.tar.gz -C /tmp/k8s-client --strip-components=1
$ cp /tmp/k8s-client/client/bin/kube* /usr/local/sbin/
$ chmod a+x /usr/local/sbin/kube*
```

OR

```bash
$ # Usage: ./scripts/k8s-deploy-kubectl.sh install ${KUBECTL_VERSION}
$ ./scripts/k8s-deploy-kubectl.sh install v1.6.2
```


## 配置 kubeconfig

```bash
$ export KUBE_MASTER_IP=172.72.1.12 # 替换为 kubernetes master 集群任一机器 IP
$ export KUBE_APISERVER="https://${KUBE_MASTER_IP}:6443"
$ export KUBE_CLUSTER_NAME="kubernetes"
$ export KUBE_CONTEXT_NAME="kubernetes"
```

* 设置集群参数

```bash
$ kubectl config set-cluster ${KUBE_CLUSTER_NAME} \
  --certificate-authority=/etc/kubernetes/ssl/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER}
```

* 设置客户端认证参数

```bash
$ kubectl config set-credentials admin \
  --client-certificate=/etc/kubernetes/ssl/admin.pem \
  --embed-certs=true \
  --client-key=/etc/kubernetes/ssl/admin-key.pem
```

* 设置上下文参数

```bash
$ kubectl config set-context ${KUBE_CONTEXT_NAME} \
  --cluster=${KUBE_CLUSTER_NAME} \
  --user=admin
```

* 设置默认上下文

```bash
$ kubectl config use-context ${KUBE_CONTEXT_NAME}
```

OR

```bash
$ ./scripts/k8s-deploy-kubectl.sh config ${KUBE_APISERVER} ${KUBE_CLUSTER_NAME} ${KUBE_CONTEXT_NAME}
```


## 配置

```bash
$ cat ~/.kube/config
apiVersion: v1
clusters:
- cluster:
    server: http://172.28.128.100:8080
  name: default-cluster
contexts:
- context:
    cluster: default-cluster
    user: default-admin
  name: default-context
current-context: default-context
kind: Config
preferences: {}
users: []
```

```bash
$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    server: http://172.28.128.100:8080
  name: default-cluster
- cluster:
    server: http://172.28.128.100:8080
  name: demo-cluster
contexts:
- context:
    cluster: default-cluster
    user: default-admin
  name: default-context
- context:
    cluster: demo-cluster
    user: ""
  name: demo-system
current-context: default-context
kind: Config
preferences: {}
users: []
```