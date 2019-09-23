# Systemd

## 配置 Unit File

* 方式一（推荐）

```sh
# node_exporter unit file （创建 node_exporter.service 文件）
$ vi /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter

[Service]
EnvironmentFile=/etc/sysconfig/node_exporter
ExecStart=/usr/local/bin/node_exporter $OPTIONS

[Install]
WantedBy=multi-user.target
```

```sh
$ chmod 664 /etc/systemd/system/node_exporter.service

# 解决 node_expoter unit file 中的环境变量（创建 node_expoter 文件）
$ vi /etc/sysconfig/node_exporter
OPTIONS="--collector.textfile.directory /var/lib/node_exporter/textfile_collector"

$ mkdir -p /var/lib/node_exporter/textfile_collector
```

* 方式二

```sh
# docker unit file （创建 docker.service 文件）
$ vi /usr/lib/systemd/system/docker.service
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target
Wants=network-online.target

[Service]
Type=notify
ExecStart=/usr/bin/dockerd $DOCKER_OPTIONS $DOCKER_NETWORK_OPTIONS $DOCKER_STORAGE_OPTIONS
ExecReload=/bin/kill -s HUP $MAINPID
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
TimeoutStartSec=0
Delegate=yes
KillMode=process
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s

[Install]
WantedBy=multi-user.target
```

```sh
$ chmod 664 /usr/lib/systemd/system/docker.service

# 如需配置其他信息，需要创建 docker.service.d 目录
$ mkdir /usr/lib/systemd/system/docker.service.d

# 解决 docker unit file 中相关的环境变量（创建 docker.conf 文件）
$ cat /usr/lib/systemd/system/docker.service.d/docker.conf
[Service]
Environment="DOCKER_OPTIONS=--storage-driver=overlay --log-level=error --exec-opt=native.cgroupdriver=cgroupfs --insecure-registry=172.1.0.0/16 --insecure-registry=172.254.0.0/16 --registry-mirror=https://registry.docker-cn.com
```

```sh
# 需要 reload
$ systemctl daemon-reload
```
