#!/bin/bash
# Author: JinsYin <jinsyin@gmail.com>
set -x

CEPH_RELEASE=$1
NUM_NODES=$2

# 避免重复配置
if [ -e ~/ceph.conf ]; then
  echo "skipping Ceph config because it's been done before"
  exit 0
fi


# 第一次登录时，避免键入 Enter 来重新连接（也不需要检查 ~/.ssh/known_keys）
tee ~/.ssh/config << EOF
Host *
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
EOF

chmod 0600 ~/.ssh/config


# 设置 ceph 节点
for x in $(seq 1 $NUM_NODES); do
  if [ $x == 1 ]; then ceph_nodes="ceph-node-1"; else ceph_nodes="$ceph_nodes ceph-node-$x"; fi
done


# 所有节点安装 ceph（安装 ceph 会自动添加一个 ceph 用户）
# 由于总是安装失败，所以选择直接使用源来安装
# ceph-deploy install --release=$CEPH_RELEASE ceph-admin $ceph_nodes
# ceph-deploy install --release=$CEPH_RELEASE --repo-url=http://mirrors.aliyun.com/ceph/rpm-$CEPH_RELEASE/el7 --gpg-url=http://mirrors.aliyun.com/ceph/keys/release.asc ceph-admin $ceph_nodes


# 创建集群
ceph-deploy new ceph-admin $ceph_nodes


# 配置 ceph.conf
if [ $NUM_NODES == 1 ]; then
  tee -a ceph.conf << EOF
osd pool default size = 1
osd pool default min size = 1
osd crush chooseleaf type = 0
EOF
elif [ $NUM_NODES -ge 2 ]; then
  osd_min_size=`expr $NUM_NODES - 1`
  tee -a ceph.conf << EOF
osd pool default size = $NUM_NODES
osd pool default min size = $osd_min_size
EOF
fi


# 初始化并启动 monitor
ceph-deploy mon create-initial


# 为 ceph 节点添加管理权限
ceph-deploy admin ceph-admin $ceph_nodes
sudo chmod +r /etc/ceph/ceph.client.admin.keyring


# 创建 OSD
for x in $(seq 1 $NUM_NODES); do
  ssh ceph-node-$x "sudo mkdir -p /ceph/osd;sudo chown -R ceph:ceph /ceph"
  ceph-deploy osd prepare ceph-node-$x:/ceph/osd
  ceph-deploy osd activate ceph-node-$x:/ceph/osd

  # 添加可读权限
  ssh ceph-node-$x "sudo chmod +r /etc/ceph/ceph.client.admin.keyring"
done


# ceph-admin 节点都安装 ceph-radosgw 组件并部署网关实例
ceph-deploy install --rgw ceph-admin
ceph-deploy rgw create ceph-admin