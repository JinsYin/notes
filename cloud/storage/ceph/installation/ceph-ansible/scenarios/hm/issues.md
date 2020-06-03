# Issues

## [#3297](https://github.com/ceph/ceph-ansible/issues/3297)

解决方法：

```sh
# 移除所有 ceph 相关的软件包（ansible mons -m shell -a 'rpm -qa | grep ceph | xargs yum remove -y'）
$ ansible mons -m yum -a 'name=*ceph* state=absent'
```

## Unable to start service ceph-mon

```txt
fatal: [mon205]: FAILED! => {"changed": false, "msg": "Unable to start service ceph-mon@ip-205-gw-ceph-ew: Job for ceph-mon@ip-205-gw-ceph-ew.service failed because start of the service was attempted too often. See \"systemctl status ceph-mon@ip-205-gw-ceph-ew.service\" and \"journalctl -xe\" for details.\nTo force a start use \"systemctl reset-failed ceph-mon@ip-205-gw-ceph-ew.service\" followed by \"systemctl start ceph-mon@ip-205-gw-ceph-ew.service\" again.\n"}
```

解决方法：

```sh
$ ansible mons -m shell -a 'systemctl reset-failed ceph-mon@{{ansible_hostname}}.service'
$ ansible mons -m shell -a 'systemctl start ceph-mon@{{ansible_hostname}}.service'
```
