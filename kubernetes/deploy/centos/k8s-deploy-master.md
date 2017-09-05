# 部署 Kubernetes Master 节点

## 下载二进制包

```bash
$ wget -O kubernetes-server.tar.gz https://dl.k8s.io/v1.6.2/kubernetes-server-linux-amd64.tar.gz
$ mkdir -p /tmp/kubernetes-server && tar -xzvf kubernetes-server.tar.gz -C /tmp/kubernetes-server --strip-components=1
```