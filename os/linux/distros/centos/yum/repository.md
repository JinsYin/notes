# Yum Repository

## 配置文件

* 目录位置：`/etc/yum.repos.d`
* 文件后缀：`.repo`
* 配置选项

| 配置选项                  | 描述                     | 示例                                                                  |
| ------------------------- | ------------------------ | --------------------------------------------------------------------- |
| Repository ID（Required） | 唯一仓库 ID              | `[examplerepo]`                                                       |
| `name`（Required）        | 可读的仓库名称           | `name=Example`                                                        |
| `baseurl`                 | repodata 目录的 URL      | `baseurl=http://mirror.cisp.com/CentOS/6/os/i386/`                    |
| `enabled`                 | 执行更新和安装时启用该源 | `enabled=1`                                                           |
| `gpgcheck`                | 启用/禁止 GPG 签名检查   | `gpgcheck=1`                                                          |
| `gpgkey`                  | GPG 密钥的 URL           | `gpgkey=http://mirror.cisp.com/CentOS/6/os/i386/RPM-GPG-KEY-CentOS-6` |
| `exclude`                 | 排除的软件包列表         | `exclude=httpd,mod_ssl`                                               |
| `includepkgs`             | 包含的软件包列表         | `include=kernel`                                                      |

## 添加源

* 内置源

```bash
$ ls -l /etc/yum.repos.d
-rw-r--r--. 1 root root 1664 8月  30 2017 CentOS-Base.repo
-rw-r--r--. 1 root root 1309 8月  30 2017 CentOS-CR.repo
-rw-r--r--. 1 root root  649 8月  30 2017 CentOS-Debuginfo.repo
-rw-r--r--. 1 root root  314 8月  30 2017 CentOS-fasttrack.repo
-rw-r--r--. 1 root root  630 8月  30 2017 CentOS-Media.repo
-rw-r--r--. 1 root root 1331 8月  30 2017 CentOS-Sources.repo
-rw-r--r--. 1 root root 3830 8月  30 2017 CentOS-Vault.repo
```

* EPEL 源

EPEL（Extra Packages for Enterprise Linux）是由 Fedora 社区维护的项目，旨在为 RHEL 及其发行版提供额外的软件包。

> EPEL 默认安装最新的软件包，针对次新版本的软件包仍然需要使用 RPM 包来安装

安装/配置：

```bash
# （方式一和方式二默认配置文件为 /etc/yum.repos.d/epel.repo 和 /etc/yum.repos.d/epel-testing.repo）

# 方式一：安装来自内置源的 epel-release 软件包以自动配置 EPEL 源
$ yum install -y epel-release

# 方式二：安装来自 Fedora 的 RPM 包以自动配置 EPEL 源
$ yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# 方式三：手动配置
```

检查校验：

```bash
# 仓库列表
$ yum repolist
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirrors.163.com
 * epel: mirrors.aliyun.com
 * extras: centos.ustc.edu.cn
 * updates: mirrors.cn99.com

repo id                 repo name                                           status
base/7/x86_64           CentOS-7 - Base                                     10,019
epel/x86_64             Extra Packages for Enterprise Linux 7 - x86_64      13,197
extras/7/x86_64         CentOS-7 - Extras                                   413
updates/7/x86_64        CentOS-7 - Updates                                  1,945
repolist: 25,574

# ---------------------------------------- #

# 查看软件包版本
$ yum list ansible --showduplicates
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirrors.163.com
 * epel: mirrors.aliyun.com # EPEL 自动选择了阿里云的镜像
 * extras: centos.ustc.edu.cn
 * updates: mirrors.cn99.com

Installed Packages
ansible.noarch              2.6.9-1.el7.ans             installed

Available Packages
ansible.noarch              2.4.2.0-2.el7               extras
ansible.noarch              2.7.10-1.el7                epel # 该版本的软件是由 EPEL 源提供的
```

* ELRepo 源

```bash
# http://elrepo.org/tiki/tiki-index.php
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
yum install https://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
```

## 查看源

```bash
$ yum repolist

# 含测试源
$ yum repolist all
```