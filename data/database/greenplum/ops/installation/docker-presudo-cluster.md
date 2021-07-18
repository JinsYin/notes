# 基于 Docker 的伪集群

## 基础镜像

```sh
$ docker run -it --privileged --name gpdb-base --hostname gpdb -i centos:centos7 /bin/bash
```

## 安装 GPDB

安装依赖：

```sh
$ yum install -y sudo vim net-tools openssh-client openssh-server java-1.8.0-openjdk # firewalld

$ curl -o cm5.tar.gz https://archive.cloudera.com/cm5/cm/5/cloudera-manager-centos7-cm5.16.2_x86_64.tar.gz
```

安装 Greenplum：

```sh
$ export GPDB_VERSION=6.7.1
$ yum install -y https://github.com/greenplum-db/gpdb/releases/download/${GPDB_VERSION}/greenplum-db-${GPDB_VERSION}-rhel7-x86_64.rpm
```

创建用户和组：

```sh
$ groupadd gpadmin
$ useradd -m -g gpadmin -s /bin/bash gpadmin
$ passwd gpadmin
```

```sh
$ chown -R gpadmin:gpadmin /usr/local/greenplum-db
```

```sh
$ su - gpadmin
$ echo 'source /usr/local/greenplum-db/greenplum_path.sh' >> ~/.bashrc
```

## 构建基础镜像

准备 Pivotal Greenplum 安装包（没有选择社区版的 GPDB）：

```sh
$ ls
greenplum-db-6.10.0-rhel7-x86_64.rpm
```

脚本：

```bash
#!/bin/sh
# wait-for-postgres.sh

set -e

host="$1"
shift
cmd="$@"

until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$host" -U "postgres" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"
exec $cmd
```

Dockerfile：

```Dockerfile
FROM centos:centos7

ARG GP_VERSION=6.10.0
ENV GP_ADMIN=gpadmin

COPY greenplum-db-${GP_VERSION}-rhel7-x86_64.rpm /opt/greenplum-db.rpm

RUN yum -y update \
    # 安装 GP
    && yum install -y openssh-server /opt/greenplum-db.rpm \
    && rm -rf /opt/greenplum-db.rpm \
    # 设置 root 用户的密码为 root
    && echo root | passwd root --stdin \
    # 创建 GP 管理员用户和组（名称和密码均一致）
    && groupadd ${GP_ADMIN} \
    && useradd -m -g ${GP_ADMIN} -s /bin/bash ${GP_ADMIN} \
    && echo ${GP_ADMIN} | passwd ${GP_ADMIN} --stdin \
    # GP 目录授权
    && chown -R gpadmin:gpadmin /usr/local/greenplum* \
    && chgrp -R gpadmin /usr/local/greenplum*

# 切换当前用户，以及设置运行时的用户（实测发现：如果运行时不是 root 用户，privileged 无效，也就无法使用 systemd 启动 sshd）
USER ${GP_ADMIN}

# 工作目录
WORKDIR ~

# 为 GP 管理员用户生成公私钥（所有容器将相同，拷贝公钥一份到 authorized_keys 即可实现所有容器免密钥登录）
RUN su - ${GP_ADMIN} \
    && ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    # 设置 GP 路径
    && echo "source /usr/local/greenplum-db/greenplum_path.sh" > ~/.bashrc \
    && source ~/.bashrc

VOLUME ["/usr/local", "/home", "/data"]

EXPOSE 22

CMD ["/bin/bash"]
```

构建镜像（可选）：

```sh
$ docker build --build-arg GP_VERSION=6.10.0 -t greenplum:6.10.0 -f Dockerfile .
```

## 自动

`docker-compose.yaml`：

```yaml
version: "2"

networks:
  gpnet: # network name
    driver: bridge
    ipam:
     config:
       - subnet: 172.100.0.0/24
         gateway: 172.100.0.1

services:
  mdw: # master
    image: greenplum:6.10.0 # or => build: .
    restart: always
    hostname: mdw
    container_name: mdw
    networks:
      gpnet:
        ipv4_address: 172.100.0.9
    depends_on:
      - smdw
      - sdw1
      - sdw2
    command: ["./greenplum.sh", "init"]
  smdw: # standby master
    image: greenplum:6.10.0
    restart: always
    hostname: smdw
    container_name: smdw
    networks:
      gpnet:
        ipv4_address: 172.100.0.10
  sdw1: # segment 1
    image: greenplum:6.10.0
    restart: always
    hostname: sdw1
    container_name: sdw1
    networks:
      gpnet:
        ipv4_address: 172.100.0.11
  sdw2: # segment 2
    image: greenplum:6.10.0
    restart: always
    hostname: sdw2
    container_name: sdw2
    networks:
      gpnet:
        ipv4_address: 172.100.0.12
```

## 半自动

Dockerfile:

```Dockerfile
FROM centos:centos7

ARG GP_VERSION=6.10.0
ENV GP_ADMIN=gpadmin

COPY greenplum-db-${GP_VERSION}-rhel7-x86_64.rpm /opt/greenplum-db.rpm

RUN yum -y update \
    # 安装 GP
    && yum install -y openssh-server /opt/greenplum-db.rpm \
    && rm -rf /opt/greenplum-db.rpm \
    # 设置 root 用户的密码为 root
    && echo root | passwd root --stdin \
    # 创建 GP 管理员用户和组（名称和密码均一致）
    && groupadd ${GP_ADMIN} \
    && useradd -m -g ${GP_ADMIN} -s /bin/bash ${GP_ADMIN} \
    && echo ${GP_ADMIN} | passwd ${GP_ADMIN} --stdin \
    # GP 目录授权
    && chown -R gpadmin:gpadmin /usr/local/greenplum* \
    && chgrp -R gpadmin /usr/local/greenplum*

# root 用户生成 ssh 公私钥
RUN mkdir -p /home/${GP_ADMIN}/.ssh \
    && ssh-keygen -t rsa -N '' -b 2048 -f /home/${GP_ADMIN}/.ssh/id_rsa \
    && cat /home/${GP_ADMIN}/.ssh/id_rsa.pub >> /home/${GP_ADMIN}/.ssh/authorized_keys \
    # 允许 root 使用密码登录
    && sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    # 设置 GP 路径
    && echo "source /usr/local/greenplum-db/greenplum_path.sh" > /home/${GP_ADMIN}/.bashrc \
    # master & standby
    && echo "export MASTER_DATA_DIRECTORY=/data/master/gpseg-1" > ~/.bashrc \
    && source /home/${GP_ADMIN}/.bashrc

# 切换到 GP 管理员用户，以及设置运行时的用户（实测发现：如果运行时不是 root 用户，privileged 无效，也就无法使用 systemd 启动 sshd）
USER ${GP_ADMIN}

# 工作目录
WORKDIR /home/${GP_ADMIN}

# 为 GP 管理员用户生成公私钥（所有容器将相同，拷贝公钥一份到 authorized_keys 即可实现所有容器免密钥登录）
RUN mkdir -p /home/${GP_ADMIN}/.ssh \
    && ssh-keygen -t rsa -N '' -b 2048 -f /home/${GP_ADMIN}/.ssh/id_rsa \
    && cat /home/${GP_ADMIN}/.ssh/id_rsa.pub >> /home/${GP_ADMIN}/.ssh/authorized_keys \
    # 设置 GP 路径
    && echo "source /usr/local/greenplum-db/greenplum_path.sh" > /home/${GP_ADMIN}/.bashrc \
    && source /home/${GP_ADMIN}/.bashrc

VOLUME ["/usr/local", "/home", "/data"]

EXPOSE 22

CMD ["/bin/bash"]
```

`docker-compose.yaml`：

```yaml
version: "2"

networks:
  h_gpnet: # network name
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/24
          gateway: 172.20.0.1

services:
  h_mdw:
    image: greenplum:6.10.0
    hostname: h_mdw
    container_name: h_mdw
    restart: always
    privileged: true        # systemd/systemctl 需要特权模式
    command: ["/sbin/init"] # 将 CentOS 的默认初始化进程（systemd）作为容器的初始化进程，以便可以使用 systemctl 运行 sshd 并使容器一直运行
    networks:
      h_gpnet:
        ipv4_address: 172.20.0.9
    volumes:
      - h_mdw_home:/home
      - h_mdw_usrlocal:/usr/local
      - h_mdw_data:/data
    expose:
      - 5432
    external_links:
      - h_mdw
      - h_smdw
      - h_sdw1
      - h_sdw2
    extra_hosts:
      - "h_mdw:172.20.0.9"
      - "h_smdw:172.20.0.10"
      - "h_sdw1:172.20.0.11"
      - "h_sdw2:172.20.0.12"
  h_smdw:
    image: greenplum:6.10.0
    hostname: h_smdw
    container_name: h_smdw
    restart: always
    privileged: true
    command: ["/sbin/init"]
    networks:
      h_gpnet:
        ipv4_address: 172.20.0.10
    volumes:
      - h_smdw_home:/home
      - h_smdw_usrlocal:/usr/local
      - h_smdw_data:/data
    expose:
      - 5432
    external_links:
      - h_mdw
      - h_smdw
      - h_sdw1
      - h_sdw2
    extra_hosts:
      - "h_mdw:172.20.0.9"
      - "h_smdw:172.20.0.10"
      - "h_sdw1:172.20.0.11"
      - "h_sdw2:172.20.0.12"
  h_sdw1:
    image: greenplum:6.10.0
    hostname: h_sdw1
    container_name: h_sdw1
    restart: always
    privileged: true
    command: ["/sbin/init"]
    networks:
      h_gpnet:
        ipv4_address: 172.20.0.11
    volumes:
      - h_sdw1_home:/home
      - h_sdw1_usrlocal:/usr/local
      - h_sdw1_data:/data
    external_links:
      - h_mdw
      - h_smdw
      - h_sdw1
      - h_sdw2
    extra_hosts:
      - "h_mdw:172.20.0.9"
      - "h_smdw:172.20.0.10"
      - "h_sdw1:172.20.0.11"
      - "h_sdw2:172.20.0.12"
  h_sdw2:
    image: greenplum:6.10.0
    hostname: h_sdw2
    container_name: h_sdw2
    restart: always
    privileged: true
    command: ["/sbin/init"]
    networks:
      h_gpnet:
        ipv4_address: 172.20.0.12
    volumes:
      - h_sdw2_home:/home
      - h_sdw2_usrlocal:/usr/local
      - h_sdw2_data:/data
    external_links:
      - h_mdw
      - h_smdw
      - h_sdw1
      - h_sdw2
    extra_hosts:
      - "h_mdw:172.20.0.9"
      - "h_smdw:172.20.0.10"
      - "h_sdw1:172.20.0.11"
      - "h_sdw2:172.20.0.12"

volumes:
  h_mdw_home:
  h_mdw_usrlocal:
  h_mdw_data:
  h_smdw_home:
  h_smdw_usrlocal:
  h_smdw_data:
  h_sdw1_home:
  h_sdw1_usrlocal:
  h_sdw1_data:
  h_sdw2_home:
  h_sdw2_usrlocal:
  h_sdw2_data:
```

```sh
# 前台启动
$ docker-compose up

# 后台启动
$ docker-compose up -d

# 停止服务
$ docker-compose down

# 停止服务并删除挂载的卷（通常是需要更新 volume 内容时）
$ docker-compose down -v
```

### mdw

1. 默认进入的是 root 用户
2. 切换到 gpadmin 用户，依次登录 smdw、sdw1 和 sdw2，以便将它们添加到 `~/.ssh/known_hosts`
3. 所有节点之间无密钥互访
```sh
$ cat hostfile_exkeys
mdw
smdw
sdw1
sdw2

$ gpssh-exkeys -f hostfile_exkeys

```

```sh
# 默认进入的是 root 用户
mkdir -p /data/master
chown gpadmin:gpadmin /data/master
```



网络

```sh
$ docker network create gpnet --subnet 172.18.0.1/24
```

Host（为了运行 SystemD，进而运行 SSHD）:

```sh
# gpmaster1
$ docker run -d --privileged --name gpmaster1 --net gpnet --ip 172.18.0.2 --hostname gpmaster1 -v mdw_home:/home/gpadmin -v mdw_data:/data gpdb:6.7.1 /sbin/init

# gpsegment1
$ docker run -d --privileged --name gpsegment1 --net gpnet --ip 172.18.0.3 --hostname gpsegment1 gpdb:6.7.1 /sbin/init

# gpsegment2
$ docker run -d --privileged --name gpsegment2 --net gpnet --ip 172.18.0.4 --hostname gpsegment2 gpdb:6.7.1 /sbin/init

# gpsegment3
$ docker run -d --privileged --name gpsegment3 --net gpnet --ip 172.18.0.5 --hostname gpsegment3 gpdb:6.7.1 /sbin/init

# gpfdist
$ docker run -d --privileged --name gpfdist --net gpnet --ip 172.18.0.100 --hostname gpfdist gpdb:6.7.1 /sbin/init
```

获取 IP 地址：

```sh
# gpmaster1
$ docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' gpmaster1
172.19.0.2

# gpsegment1
$ docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' gpsegment1
172.19.0.3

# gpsegment2
$ docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' gpsegment2
172.19.0.4

# gpsegment3
$ docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' gpsegment3
172.19.0.5
```

进入容器：

```sh
# gpmaster1
$ docker exec -it gpmaster1 /bin/bash

# gpsegment1
$ docker exec -it gpsegment1 /bin/bash

# gpsegment2
$ docker exec -it gpsegment2 /bin/bash

# gpsegment3
$ docker exec -it gpsegment3 /bin/bash
```


```sh
$ docker commit gpdb-base gpdb:6.7.1
```

## 无密钥配置：

所有主机:

```sh
# root 用户
$ vi /etc/hosts
172.19.0.2 gpmaster1
172.19.0.3 gpsegment1
172.19.0.4 gpsegment2
172.19.0.4 gpsegment3
```

```sh
$ ssh-keygen -t rsa -b 4096
```

gpmaster1 无密钥访问 segment 主机：

```sh
$ ssh-copy-id gpmaster1
$ ssh-copy-id gpsegment1
$ ssh-copy-id gpsegment2
$ ssh-copy-id gpsegment3
```

```sh
# gpadmin 用户
$ su - gpadmin

$ vi ~/hostfile_exkeys
gpmaster1
gpsegment1
gpsegment2

# 所有主机之间无密钥互访
$ gpssh-exkeys -f hostfile_exkeys
```

## 确认安装

在 gpmaster1 节点运行以下步骤来确保 Greenplum 软件被安装且配置正确：

```sh
# 登录到 gpadmin
$ su - gpadmin

# 使用 gpssh 检查是否可以无密钥登录到所有机器，并确保 Greenplum 软件在所有软件上被安装
# 所有主机将返回一样的内容，且目录的所有者为 gpadmin 用户
$ gpssh -f hostfile_exkeys -e 'ls -l /usr/local/greenplum-db'
[gpsegment1] ls -l /usr/local/greenplum-db
[gpsegment1] lrwxrwxrwx 1 gpadmin gpadmin 29 Jun  4 08:23 /usr/local/greenplum-db -> /usr/local/greenplum-db-6.7.1
[ gpmaster1] ls -l /usr/local/greenplum-db
[ gpmaster1] lrwxrwxrwx 1 gpadmin gpadmin 29 Jun  4 08:23 /usr/local/greenplum-db -> /usr/local/greenplum-db-6.7.1
[gpsegment2] ls -l /usr/local/greenplum-db
[gpsegment2] lrwxrwxrwx 1 gpadmin gpadmin 29 Jun  4 08:23 /usr/local/greenplum-db -> /usr/local/greenplum-db-6.7.1
```

## 创建数据目录

master 节点不存储用户数据，只存储目录表和系统元数据。

```sh
# gpmaster1 [root]
$ mkdir -p /data/master
$ chown gpadmin:gpadmin /data/master
```

## 验证
