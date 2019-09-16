# Dashboard 模块

## 启用

```bash
$ ceph mgr module enable dashboard
```

## 配置

### 配置 SSL/TLS

### 配置主机名和端口

```bash
$ ceph config set mgr mgr/dashboard/server_addr $IP
$ ceph config set mgr mgr/dashboard/server_port $PORT # 7000
```

```bash
$ ceph mgr services
```

### 配置用户名和密码

```bash
$ ceph dashboard set-rgw-api-host <host>
$ ceph dashboard set-rgw-api-port <port>
```