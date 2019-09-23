# MongoDB 从入门到放弃

## 使用 docker 部署 mongodb server

```sh
$ docker run -it --name mongodb -v mongodb_data:/data/db -p 27017:27017 -d mongo
```

## 安装 mongodb client

```
1. mongochef
2. apt-get install mongodb-org-shell=3.2.12
```

## 命令行连接

```sh
$ mongo --host 127.0.0.1 --port 27017
```
