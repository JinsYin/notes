# Kubernetes YAML 配置

kubernetes 中创建 RC（Replicationtroller）、pod、svc（service）都应该通过 yaml 文件创建。


## apiVersion

* v1
* betav1
* extensisons/v1beta1


## kind

* Pod
* Replicationcontroller
* service
* Deployment


## metadata

* metadata.name
* metadata.labels.name


## spec

* spec.replicas


## Examples

```
apiVersion: v1
kind: Pod
metadata:
  name: testpod
containers:
  image: nginx:1.11.9-alpine
```