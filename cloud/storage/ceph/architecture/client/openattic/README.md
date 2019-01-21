# OpenAttic

OpenAttic 是一个开源的 Ceph 和存储管理解决方案，提供了 Web 界面用于管理和监控 Ceph 集群资源。用户不需要熟悉 Ceph 组件的内部工作原理，任何任务都可以通过使用 OpenAttic 的 Web 界面或 REST API 来执行。

## 系统要求

目前，OpenAttic 的 `latest` 和 `stable` 版本（`3.x` 开始）都只支持 `openSUSE Leap 42.3` 发行版，只有 `2.x` 版本支持：

* Debian Linux 8 “Jessie”
* Red Hat Enterprise Linux 7 (RHEL) and derivatives (CentOS 7, Oracle Linux 7 or Scientific Linux 7)
* openSUSE Leap 42.1, SUSE Linux Enterprise Server 12 (SLES12) (via the openSUSE Build Service)
* Ubuntu 14.04 LTS “Trusty Thar”
* Ubuntu 16.04 LTS “Xenial Xerus”

> 64 位 Linux

## 准备工作

1. 外网连接通畅
2. `hostname --fqdn` 输出有意义
3. 安装配置 ntpd 以同步时钟
4. 配置防火墙以允许外部访问

```bash
# <your zone ie internal|public>
$ firewall-cmd --permanent --zone=<your zone ie internal|public> --add-service=http
$ firewall-cmd --permanent --zone=<your zone ie internal|public> --add-service=samba
$ firewall-cmd --permanent --zone=<your zone ie internal|public> --add-service=nfs
$ firewall-cmd --permanent --zone=<your zone ie internal|public> --add-service=iscsi-target
$ firewall-cmd --reload
```

## 安装

### CentOS

* <https://hub.docker.com/r/minyk/openattic/>

### 配置

```bash
# EPEL 外部源
$ yum install -y epel-release

# openattic-release 源
$ yum install http://repo.openattic.org/rpm/openattic-2.x-el7-x86_64/openattic-release.rpm
```

```bash
# 不会自动安装 Openattic Web GUI，因为它对 OpenAttic 集群节点不是必需的
$ yum install -y openattic

# 选择节点安装
$ yum install -y openattic-gui
```

```bash
sed -i 's|#service_perfdata_file=.*|service_perfdata_file=/var/log/pnp4nagios/service-perfdata|g' /etc/nagios/nagios.cfg
sed -i 's|#service_perfdata_file_template=.*|service_perfdata_file_template=DATATYPE::SERVICEPERFDATA\tTIMET::$TIMET$\tHOSTNAME::$HOSTNAME$\tSERVICEDESC::$SERVICEDESC$\tSERVICEPERFDATA::$SERVICEPERFDATA$\tSERVICECHECKCOMMAND::$SERVICECHECKCOMMAND$\tHOSTSTATE::$HOSTSTATE$\tHOSTSTATETYPE::$HOSTSTATETYPE$\tSERVICESTATE::$SERVICESTATE$\tSERVICESTATETYPE::$SERVICESTATETYPE$service_perfdata_file_mode=a|g' /etc/nagios/nagios.cfg
sed -i 's|#service_perfdata_file_mode=.*|service_perfdata_file_mode=a|g' /etc/nagios/nagios.cfg
sed -i 's|#service_perfdata_file_processing_interval=.*|service_perfdata_file_processing_interval=15|g' /etc/nagios/nagios.cfg
sed -i 's|#service_perfdata_file_processing_command=.*|service_perfdata_file_processing_command=process-service-perfdata-file|g' /etc/nagios/nagios.cfg

sed -i 's|#host_perfdata_file=.*|host_perfdata_file=/var/log/pnp4nagios/host-perfdata|g' /etc/nagios/nagios.cfg
sed -i 's|#host_perfdata_file_template=.*|host_perfdata_file_template=DATATYPE::HOSTPERFDATA\tTIMET::$TIMET$\tHOSTNAME::$HOSTNAME$\tHOSTPERFDATA::$HOSTPERFDATA$\tHOSTCHECKCOMMAND::$HOSTCHECKCOMMAND$\tHOSTSTATE::$HOSTSTATE$\tHOSTSTATETYPE::$HOSTSTATETYPE$|g' /etc/nagios/nagios.cfg
sed -i 's|#host_perfdata_file_mode=.*|host_perfdata_file_mode=a|g' /etc/nagios/nagios.cfg
sed -i 's|#host_perfdata_file_processing_interval=.*|host_perfdata_file_processing_interval=15|g' /etc/nagios/nagios.cfg
sed -i 's|#host_perfdata_file_processing_command=.*|host_perfdata_file_processing_command=process-host-perfdata-file|g' /etc/nagios/nagios.cfg
```

```bash
$ vi /etc/nagios/objects/commands.cfg
#
# definitions for PNP processing commands
# Bulk with NPCD mode
#
define command {
 command_name process-service-perfdata-file
 command_line /bin/mv /var/log/pnp4nagios/service-perfdata /var/spool/pnp4nagios/service-perfdata.$TIMET$
}

define command {
 command_name process-host-perfdata-file
 command_line /bin/mv /var/log/pnp4nagios/host-perfdata /var/spool/pnp4nagios/host-perfdata.$TIMET$
}
```

```bash
# 验证配置是否正确
$ nagios --verify-config /etc/nagios/nagios.cfg
```

#### 服务

```bash
# 将 start 和 enable 多个服务，初始化 openAttic 数据并扫描系统以查找要包含的池和卷
$ oaconfig install # --allow-broken-hostname
```

访问：<http://openattic.yourdomain.com/openattic>，默认用户密码：`openattic`/`openattic`

```bash
# 修改默认用户密码
$ oaconfig changepassword openattic
```

#### 配置 Ceph

```plain
/etc/ceph/ceph.client.admin.keyring
/etc/ceph/ceph.conf
```

```bash
# chgrp openattic /etc/ceph/ceph.conf /etc/ceph/ceph.client.admin.keyring
# chmod g+r /etc/ceph/ceph.conf /etc/ceph/ceph.client.admin.keyring
```

```bash
# 安装 openattic-module-ceph
$ yum install -y openattic-module-ceph

# 安装新模块后必须执行
$ oaconfig install # --allow-broken-hostname
```

### Ubuntu

### openSUSE Leap 42.3

```bash
# Ceph Luminous 源
$ zypper addrepo http://download.opensuse.org/repositories/filesystems:/ceph:/luminous/openSUSE_Leap_42.3/filesystems:ceph:luminous.repo

# OpenAttic 源
$ zypper addrepo http://download.opensuse.org/repositories/filesystems:openATTIC:3.x/openSUSE_Leap_42.3/filesystems:openATTIC:3.x.repo
```

```bash
# 刷新源
$ zypper refresh

# 安装
$ zypper install openattic
```

### Docker

```dockerfile
FROM opensuse/leap:42.3
```

## OpentAttic 中启用 Ceph 支持

```bash
$ ceph-deploy admin openattic.yourdomain.com
```

```plain
/etc/ceph/ceph.client.admin.keyring
/etc/ceph/ceph.conf
```

## 参考

* [Openattic 简介及在 Ceph 集群中部署](https://blog.csdn.net/qq_23348071/article/details/76222955)
* <https://hub.docker.com/r/minyk/openattic/>