# 自动化

## 构建镜像

`Dockerfile`：

```dockerfile
FROM centos:centos7

ARG GP_VERSION=6.10.0
ENV GP_ADMIN=gpadmin
ENV GP_MASTER_DATA=/data/master
ENV GP_PRIMARY_SEG_DATA=/data/primary
ENV GP_MIRROR_SEG_DATA=/data/mirror

COPY greenplum-db-${GP_VERSION}-rhel7-x86_64.rpm /opt/greenplum-db.rpm

RUN yum -y update \
    # 安装 GP
    && yum install -y openssh-server /opt/greenplum-db.rpm \
    && rm -rf /opt/greenplum-db.rpm \
    # 创建 GP 管理员用户和组（名称和密码均一致）
    && groupadd ${GP_ADMIN} \
    && useradd -m -g ${GP_ADMIN} -s /bin/bash ${GP_ADMIN} \
    && echo ${GP_ADMIN} | passwd ${GP_ADMIN} --stdin \
    # GP 目录授权
    && chown -R gpadmin:gpadmin /usr/local/greenplum* \

# 设置 root 用户的密码为 root，并且生成公私钥
RUN echo root | passwd root --stdin \
    && mkdir -p ~/.ssh \
    && ssh-keygen -t rsa -N '' -b 2048 -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    # 设置 GP 路径
    && echo "source /usr/local/greenplum-db/greenplum_path.sh" > ~/.bashrc \
    && source ~/.bashrc

# 切换到 GP 管理员，后续命令和容器运行时都将使用该用户。如果需要启动 sshd 等服务，运行时必须是 root 用户，可能还需要 pvivileged 特权
USER ${GP_ADMIN}

# 工作目录
WORKDIR ~

ADD entrypoint.sh /root

# 为 GP 管理员用户生成公私钥（所有容器将相同，拷贝公钥一份到 authorized_keys 即可实现所有容器免密钥登录）
RUN mkdir -p ~/.ssh \
    && ssh-keygen -t rsa -N '' -b 2048 -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    # 设置 GP 路径
    && echo "source /usr/local/greenplum-db/greenplum_path.sh" > ~/.bashrc \
    && source ~/.bashrc

VOLUME ["/usr/local", "/home", "/data"]

EXPOSE 22

ENTRYPOINT ["/root/entrypoint.sh"]
```

`entrypoint.sh`:

```sh
chown -R gpadmin:gpadmin /usr/local/greenplum*

su - gpadmin
gpssh -f hostfile_exkeys -e 'ls -l /usr/local/greenplum-db'
gpssh-exkeys -f hostfile_exkeys

GP_MASTER_DATA=${GP_MASTER_DATA:=/data/master}

MASTER_DIRECTORY="/data/master"
PRIMARY_DATA_DIRECTORY="/data/primary /data/primary /data/primary" # 空格作为分隔符
MIRROR_DATA_DIRECTORY="/data/mirror /data/mirror /data/mirror"     # 空格作为分隔符

# 角色： master、standby、segment
GP_ROLE="segment"

GP_STANDBY_MASTER_HOSTNAME="smdw"
GP_HOSTS="mdw,smdw,sdw1,sdw2"
GP_SEGMENT_HOSTS="sdw1,sdw2"
GP_SEGMENTS_PER_HOST=3
GP_MASTER_DIRECTORY="/data/master"
GP_PRIMARY_DATA_DIRECTORY="/data/primary"
GP_MIRROR_DATA_DIRECTORY="/data/mirror"

# master & standby master
fn::create_data_dirs_on_master() {
    source /usr/local/greenplum-db/greenplum_path.sh
    mkdir -p /data/master
    chown gpadmin:gpadmin /data/master
}

fn::check_ssh_on_master() {
    su - gpadmin
    gpssh -f hostfile_exkeys -e 'ls -l /usr/local/greenplum-db'
    gpssh-exkeys -f hostfile_exkeys
}

fn::initsystem() {
    # 检查是否已初始化过，避免重复初始化

    su - gpadmin
    source /usr/local/greenplum-db/greenplum_path.sh

    mkdir -p ~/gpconfigs
    cp $GPHOME/docs/cli_help/gpconfigs/gpinitsystem_config ~/gpconfigs/gpinitsystem_config

    echo -e "sdw1\nsdw2" >> ~/gpconfigs/hostfile_gpinitsystem

    sed -e 's| DATA_DIRECTORY.*| DATA_DIRECTORY=(/data/primary /data/primary /data/primary)|g' ~/gpconfigs/gpinitsystem_config
    sed -e 's|#declare -a MIRROR_DATA_DIRECTORY.*|declare -a MIRROR_DATA_DIRECTORY=(/data/mirror /data/mirror /data/mirror)|g' \
     ~/gpconfigs/gpinitsystem_config

    sed -e 's|#MIRROR_PORT_BASE=7000|MIRROR_PORT_BASE=7000|g' ~/gpconfigs/gpinitsystem_config

    gpinitsystem -c gpconfigs/gpinitsystem_config -h gpconfigs/hostfile_gpinitsystem

    gpinitsystem -c gpconfigs/gpinitsystem_config -h gpconfigs/hostfile_gpinitsystem -s ${GP_STANDBY_MASTER_HOSTNAME} -S ${GP_MASTER_DIRECTORY}
}

fn::chg_primary_data_dir() {
    sed -i 's|||g'
}

# segment host
fn::create_data_dirs_on_segment() {
    source /usr/local/greenplum-db/greenplum_path.sh
    mkdir -p /data/primary
    mkdir -p /data/mirror
    chown -R gpadmin:gpadmin /data/*
}

fn::main() {
    if [ $GP_ROLE == "master" ] then
        # 创建数据目录
        fn::create_data_dirs_for_master

    else
        # 创建数据目录
        fn::create_data_dirs_for_master
    fi
}

fn::main

eval()
```

构建镜像：

```sh
$ docker build --build-arg GP_VERSION=6.10.0 -t greenplum:6.10.0 -f Dockerfile .
```

## 启动集群

```yaml
version: "2"

services:
  gp_mdw:
    image: greenplum:6.10.0
    hostname: gp_mdw
    container_name: gp_mdw  # 默认是 `<directryName>_<serviceName>`
    restart: always
    user: root              # 运行 /sbin/init 需要 root 用户
    privileged: true        # systemd/systemctl 需要特权模式
    command: ["/sbin/init"] # 将 CentOS 的初始化进程 systemd 作为容器的初始化进程，即可以让容器一直运行，也会自动运行 sshd 服务
    networks:
      gp_net:
        ipv4_address: 172.20.0.9
    volumes:
      - gp_mdw_home:/home
      - gp_mdw_pkg:/usr/local
      - gp_mdw_data:/data
    expose:
      - 5432
    external_links:
      - gp_mdw
      - gp_smdw
      - gp_sdw1
      - gp_sdw2
    extra_hosts: # 添加到 /etc/hosts
      - "gp_mdw:172.20.0.9"
      - "gp_smdw:172.20.0.10"
      - "gp_sdw1:172.20.0.11"
      - "gp_sdw2:172.20.0.12"
  gp_smdw: ################################# 可选。如果不行默认 master 和 standy 主备切换，可以不开启
    image: greenplum:6.10.0
    hostname: gp_smdw
    container_name: gp_smdw
    restart: always
    user: root
    privileged: true
    command: ["/sbin/init"]
    networks:
      gp_net:
        ipv4_address: 172.20.0.10
    volumes:
      - gp_smdw_home:/home
      - gp_smdw_pkg:/usr/local
      - gp_smdw_data:/data
    expose:
      - 5432
    external_links:
      - gp_mdw
      - gp_smdw
      - gp_sdw1
      - gp_sdw2
    extra_hosts:
      - "gp_mdw:172.20.0.9"
      - "gp_smdw:172.20.0.10"
      - "gp_sdw1:172.20.0.11"
      - "gp_sdw2:172.20.0.12"
  gp_sdw1:
    image: greenplum:6.10.0
    hostname: gp_sdw1
    container_name: gp_sdw1
    restart: always
    user: root
    privileged: true
    command: ["/sbin/init"]
    networks:
      gp_net:
        ipv4_address: 172.20.0.11
    volumes:
      - gp_sdw1_home:/home
      - gp_sdw1_pkg:/usr/local
      - gp_sdw1_data:/data
    external_links:
      - gp_mdw
      - gp_smdw
      - gp_sdw1
      - gp_sdw2
    extra_hosts:
      - "mdw:172.20.0.9"
      - "smdw:172.20.0.10"
      - "sdw1:172.20.0.11"
      - "sdw2:172.20.0.12"
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
        ipv4_address: 172.20.0.12
    volumes:
      - sdw2_home:/home
      - sdw2_pkg:/usr/local
      - sdw2_data:/data
    external_links:
      - gp_mdw
      - gp_smdw
      - gp_sdw1
      - gp_sdw2
    extra_hosts:
      - "gp_mdw:172.20.0.9"
      - "gp_smdw:172.20.0.10"
      - "gp_sdw1:172.20.0.11"
      - "gp_sdw2:172.20.0.12"

networks:
  gpnet: # network name
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.1/24
          gateway: 172.20.0.1

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