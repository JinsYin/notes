# 半自动

## 构建镜像

准备 Pivotal Greenplum 安装包（没有选择社区版的 GPDB）：

```sh
$ ls
greenplum-db-6.10.0-rhel7-x86_64.rpm
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

# 切换用户，后续命令和容器运行时都将使用该用户。如果需要启动 sshd 等服务，运行时必须是 root 用户，可能还需要 pvivileged 特权
USER ${GP_ADMIN}

# 工作目录
WORKDIR ~

# 为 GP 管理员用户生成公私钥（所有容器将相同，拷贝公钥一份到 authorized_keys 即可实现所有容器免密钥登录）
RUN mkdir -p ~/.ssh \
    && ssh-keygen -t rsa -N '' -b 2048 -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    # 设置 GP 路径
    && echo "source /usr/local/greenplum-db/greenplum_path.sh" > ~/.bashrc \
    && source ~/.bashrc

VOLUME ["/usr/local", "/home", "/data"]

EXPOSE 22

CMD ["/bin/bash"]
```

构建镜像：

```sh
$ docker build --build-arg GP_VERSION=6.10.0 -t greenplum:6.10.0 -f Dockerfile .
```

## 启动集群

`docker-compose.yml`：

```yaml
version: "2"

services:
  mdw:
    image: greenplum:6.10.0
    hostname: mdw
    container_name: mdw
    restart: always
    user: root              # 运行 /sbin/init 需要 root 用户
    privileged: true        # systemd/systemctl 需要特权模式
    command: ["/sbin/init"] # 将 CentOS 的初始化进程 systemd 作为容器的初始化进程，即可以让容器一直运行，也会自动运行 sshd 服务
    networks:
      gpnet:
        ipv4_address: 172.18.0.9
    volumes:
      - mdw_home:/home
      - mdw_usrlocal:/usr/local
      - mdw_data:/data
    expose:
      - 5432
    external_links:
      - mdw
      - smdw
      - sdw1
      - sdw2
    extra_hosts: # 添加到 /etc/hosts
      - "mdw:172.18.0.9"
      - "smdw:172.18.0.10"
      - "sdw1:172.18.0.11"
      - "sdw2:172.18.0.12"
  smdw:
    image: greenplum:6.10.0
    hostname: smdw
    container_name: smdw
    restart: always
    user: root
    privileged: true
    command: ["/sbin/init"]
    networks:
      gpnet:
        ipv4_address: 172.18.0.10
    volumes:
      - smdw_home:/home
      - smdw_usrlocal:/usr/local
      - smdw_data:/data
    expose:
      - 5432
    external_links:
      - mdw
      - smdw
      - sdw1
      - sdw2
    extra_hosts:
      - "mdw:172.18.0.9"
      - "smdw:172.18.0.10"
      - "sdw1:172.18.0.11"
      - "sdw2:172.18.0.12"
  sdw1:
    image: greenplum:6.10.0
    hostname: sdw1
    container_name: sdw1
    restart: always
    user: root
    privileged: true
    command: ["/sbin/init"]
    networks:
      gpnet:
        ipv4_address: 172.18.0.11
    volumes:
      - sdw1_home:/home
      - sdw1_usrlocal:/usr/local
      - sdw1_data:/data
    external_links:
      - mdw
      - smdw
      - sdw1
      - sdw2
    extra_hosts:
      - "mdw:172.18.0.9"
      - "smdw:172.18.0.10"
      - "sdw1:172.18.0.11"
      - "sdw2:172.18.0.12"
  sdw2:
    image: greenplum:6.10.0
    hostname: sdw2
    container_name: sdw2
    restart: always
    user: root
    privileged: true
    command: ["/sbin/init"]
    networks:
      gpnet:
        ipv4_address: 172.18.0.12
    volumes:
      - sdw2_home:/home
      - sdw2_usrlocal:/usr/local
      - sdw2_data:/data
    external_links:
      - mdw
      - smdw
      - sdw1
      - sdw2
    extra_hosts:
      - "mdw:172.18.0.9"
      - "smdw:172.18.0.10"
      - "sdw1:172.18.0.11"
      - "sdw2:172.18.0.12"

networks:
  gpnet: # network name
    driver: bridge
    ipam:
      config:
        - subnet: 172.18.0.1/24
          gateway: 172.18.0.1

# 值可以为空，使用默认的 driver
volumes:
  mdw_home:
  mdw_usrlocal:
  mdw_data:
  smdw_home:
  smdw_usrlocal:
  smdw_data:
  sdw1_home:
  sdw1_usrlocal:
  sdw1_data:
  sdw2_home:
  sdw2_usrlocal:
  sdw2_data:
```

容器管理：

```sh
# 前台启动
$ docker-compose up

# 后台启动
$ docker-compose up -d

# 停止服务
$ docker-compose down

# 停止服务并删除挂载的卷（通常在需要更新 volume 内容时使用）
$ docker-compose down -v
```

## 集群管理

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
