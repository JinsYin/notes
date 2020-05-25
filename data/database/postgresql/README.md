# PostgreSQL 从入门到放弃

## Server

- ubuntu 部署

```sh
$ sudo apt-get install postgresql
```

- docker 部署

默认情况, `postgres` 用户和数据库会被创建, 端口为 5432.
```sh
$ docker run -it --name postgresql -p 5432:5432 \
-e POSTGRES_USER=root \
-e POSTGRES_PASSWORD=root123456 \
-v pg_data:/var/lib/postgresql/data \
-d postgres:9.4.12-alpine
```

## Client

- 命令行

```sh
$ sudo apt-get install postgresql-client
```

- GUI

```sh
$ sudo apt-get install pgadmin3
```

## 连接服务器

```sh
$ psql -h 127.0.0.1 -U postgres -p 5432 -W root123456
```
