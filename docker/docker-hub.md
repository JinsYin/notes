# Docker 远程仓库

注册登录

```bash
# 先到 http://hub.docker.com 上注册账号，注册完成之后默认会有一个以用户名命名的仓库
$ docker login
```

构建镜像

```bash
# you 是用户名也是远程仓库名，也可以自己在官网上创建仓库
$ docker build -t you/spark-standalone:2.0.0 -f Dockerfile .
```

上传镜像

```bash
$ docker push you/spark-standalone:2.0.0
```
