#!/bin/bash
# Author: JinsYin <yrqiang@163.com>

ETCD_VERSION=v3.1.7
ETCD_DOWNLOAD_URL=https://github.com/coreos/etcd/releases/download/$ETCD_VERSION/etcd-$ETCD_VERSION-linux-amd64.tar.gz

# 下载并安装
etcd::install() {
  wget -O /opt/etcd-$ETCD_VERSION-linux-amd64.tar.gz $ETCD_DOWNLOAD_URL

  cd /opt && tar -zxf /opt/etcd-$ETCD_VERSION-linux-amd64.tar.gz

  mv /opt/etcd-$ETCD_VERSION-linux-amd64/etcd* /usr/local/sbin

  rm -rf /opt/etcd*
}


# Start Etcd Service
mkdir -p /var/lib/etcd  # 必须先创建工作目录
cat > etcd.service <<EOF
[Unit]
Description=Etcd Server
After=network.target
After=network-online.target
Wants=network-online.target
Documentation=https://github.com/coreos/etcd

[Service]
Type=notify
WorkingDirectory=/var/lib/etcd/
ExecStart=/root/local/bin/etcd \\
  --name=${NODE_NAME} \\
  --initial-advertise-peer-urls=https://${NODE_IP}:2380 \\
  --listen-peer-urls=https://${NODE_IP}:2380 \\
  --listen-client-urls=https://${NODE_IP}:2379,http://127.0.0.1:2379 \\
  --advertise-client-urls=https://${NODE_IP}:2379 \\
  --initial-cluster-token=etcd-cluster-0 \\
  --initial-cluster=${ETCD_NODES} \\
  --initial-cluster-state=new \\
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF