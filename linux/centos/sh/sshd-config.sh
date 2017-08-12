#!/bin/bash
# Author: JinsYin <jinsyin@gmail.com>

sed -i "s|GSSAPIAuthentication yes|GSSAPIAuthentication no|g" /etc/ssh/sshd_config

sed -i "s|#PermitRootLogin yes|PermitRootLogin yes|g" /etc/ssh/sshd_config

sed -i "s|#UseDNS yes|UseDNS no|g" /etc/ssh/sshd_config

systemctl restart sshd