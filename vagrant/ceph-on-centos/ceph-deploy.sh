#!/bin/bash
# Author: JinsYin <jinsyin@gmail.com>

CEPH_RELEASE=$1

# 安装 yum-utils 和 epel-release
sudo yum install -y yum-utils && sudo yum-config-manager --add-repo https://dl.fedoraproject.org/pub/epel/7/x86_64/ && sudo yum install --nogpgcheck -y epel-release && sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 && sudo rm /etc/yum.repos.d/dl.fedoraproject.org*

# 添加 ceph-deploy 源（sudo）
cat <<EOF > /etc/yum.repos.d/ceph-deploy.repo
[ceph-noarch]
name=Ceph noarch packages
baseurl=http://download.ceph.com/rpm-$CEPH_RELEASE/el7/noarch
enabled=1
gpgcheck=1
type=rpm-md
gpgkey=https://download.ceph.com/keys/release.asc
EOF

# 安装最新版本的 ceph-deploy（或者安装指定版本：yum install ceph-deploy-1.5.36）
yum install -y ceph-deploy