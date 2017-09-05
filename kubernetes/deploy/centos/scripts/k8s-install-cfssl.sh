#!/bin/bash
# Author: JinsYin <jinsyin@gmail>

wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 -O /usr/local/sbin/cfssl
wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 -O /usr/local/sbin/cfssljson
wget https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64 -O /usr/local/sbin/cfssl-certinfo

chmod +x /usr/local/sbin/cfssl
chmod +x /usr/local/sbin/cfssljson
chmod +x /usr/local/sbin/cfssl-certinfo

mkdir -p /etc/kubernetes/ssl