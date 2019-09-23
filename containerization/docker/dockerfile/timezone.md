# 时区（TZ）

```sh
# 验证方式
$ date -R
```

## Alpine

* 方式一

```dockerfile
# 建议先在 Dockerfile 中设置默认值，如需修改可以在启动容器时再通过环境变量进行修改
ENV TZ=Asia/Shanghai

# 软连接（如果 /etc/localtime 已存在可以先删除）
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
    && echo $TZ > /etc/timezone
```

* 方式二（推荐）

```dockerfile
# 顺序无关
ENV TZ=Asia/Shanghai
RUN apk add -U tzdata
```

## Ubuntu

* 方式一

```dockerfile
ENV TZ=Asia/Shanghai
RUN apt-get update && apt-get install -y tzdata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
    && echo $TZ > /etc/timezone
```

* 方式二（推荐）

```dockerfile
ENV TZ=Asia/Shanghai
RUN apt-get update && apt-get install -y tzdata
```

## 参考

* [Docker Container time & timezone](https://serverfault.com/questions/683605/docker-container-time-timezone-will-not-reflect-changes/683651)
