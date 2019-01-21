"""
Installation:
    Ubuntu:
        * apt-get install librados-dev (14.04)
        * apt-get install python-rados (16.04)
    
    CentOS:
        * yum install librados2-devel
        * yum install python-rados

注：客户端必须安装 "ceph" 或 "ceph-common" 才能执行 connect() 及后续操作
"""
#!/usr/bin/env python2
import rados, sys

cluster = rados.Rados(conffile='/etc/ceph/ceph.conf', conf=dict(keyring='/etc/ceph/ceph.client.admin.keyring'))

print "librados version: " + str(cluster.version())
print "Will attempt to connect to: " + str(cluster.conf_get('mon initial members'))

cluster.connect()
print "\nCluster ID: " + cluster.get_fsid()

print "\n\nCluster Statistics"
print "=================="
cluster_stats = cluster.get_cluster_stats()

for key, value in cluster_stats.iteritems():
        print key, value