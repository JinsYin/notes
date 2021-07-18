# Greenplum 平台要求

## 最小集群

Master Host => 1 台
Segment Host => 2 台

## 操作系统

* RHEL/CentOS 6/7
* Ubuntu 18.04

说明：

* 使用 RHEL/CentOS 6 系统，Greenplum 性能会显著下降
* 推荐 RHEL/CentOS >= 7.3

### 软件依赖

RHEL/CentOS 6/7 软件依赖：

```sh
# ALL
$ sudo yum install -y epel-release

# ALL（安装 RPM 软件包时会自动将其作为依赖项安装）
$ sudo yum install -y apr apr-util bash bzip2 curl krb5 libcurl libevent libxml2 libyaml \
    zlib openldap openssh openssl perl readline rsync R sed tar zip

# Only RHEL7/Centos7
$ sudo yum install -y openssl-libs
```

Ubuntu 18.04 软件依赖：

```sh
# 安装 DEB 软件包时会自动将其作为依赖项安装
$ sudo apt-get -y install libapr1 libaprutil1 bash bzip2 krb5-multidev libcurl3-gnutls \
    libcurl4 libevent-2.1-6 libxml2 libyaml-0-2 zlib1g libldap-2.4-2 openssh-client \
    openssh-client openssl perl readline rsync sed tar zip net-tools less iproute2
```

### Java 依赖

Greenplum 6 使用以下 Java 版本来支持 PL/Java 和 PXF ：

* OpenJDK 8/11
* OracleJDK 8/11

## 硬件和网络

最低硬件要求：

| CPU | 内存 | 磁盘空间 | 网络 |
| --- | --- | --- | --- |
| x86_64 | 16GB/Host  | * GPDB: 150MB/Host <br> * 元数据：300MB/Segment <br> * 剩余空间 >= 30% | 10Gb/s |

推荐/建议：

* 所有服务器具有相同的硬件和软件配置
* 多网卡绑定

## 存储系统

* 文件系统 => XFS
* 网络块设备（挂载 XFS）运行 GPDB => 可行
* 网络文件系统运行 GPDB => 不推荐
* HCI（超融合基础设施）虚拟化 => 不推荐

## Hadoop 发行版

Greenplum 6 集成了 Greenplum PXF（Platform Extension Framework） v5.10.0，支持访问 Hadoop、对象存储和 SQL [外部数据存储](http://docs.greenplum.org/6-4/admin_guide/external/pxf-overview.html)。

PXF 支持 CDH、HDP、MapR、通用 Apache Hadoop 发行版。PXF 捆绑了它所依赖的所有 JAR 文件，包括以下 Hadoop 库：

| PXF 版本 | Hadoop 版本 | Hive 版本 | HBase 版本 |
| -------- | ---------- | -------- | ------ |
| 5.10.0 | 2.x, 3.1+ | 1.x, 2.x, 3.x+ | 1.3.2 |
| 5.8.2 | 2.x | 1.x | 1.3.2 |
| 5.8.1 | 2.x | 1.x | 1.3.2 |

注：如果要访问 CDH 集群上的 JSON 数据，PXF 要求 CDH 版本大于等于 5.8

## 参考

* [Platform Requirements](http://docs.greenplum.org/6-4/install_guide/platform-requirements.html)