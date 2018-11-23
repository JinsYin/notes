# Dockerfile

## ADD 和 COPY

`ADD` 可以下载远程文件，以及自动解压 *.tar.gz 压缩包。

## ARG

`ARG` 类似于 `ENV`，不同的是 `ARG` 在镜像构建的时候可以通过命令行参数 `--build-arg` 进行修改。

* Dockerfile

```ini
ARG HADOOP_TARBALL=http://www.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
```

* 构建镜像

```bash
docker build -f Dockerfile -t dockerce/hadoop:2.7.3 --build-arg HADOOP_TARBALL=hadoop-2.7.3.tar.gz .
```

## ADD & wget & curl

使用 `ADD` 和 `wget` 下载文件时，每次 `docker build` 都会重新下载一次，但 `curl` 不会。