# /proc/mounts

包含当前已挂载文件系统的信息

## 相关命令

以下命令会读写该文件的信息：

* `mount`
* `df`

## 示例

```sh
$ cat /proc/mounts
rootfs / rootfs rw 0 0
sysfs /sys sysfs rw,seclabel,nosuid,nodev,noexec,relatime 0 0
proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0
devtmpfs /dev devtmpfs rw,seclabel,nosuid,size=484648k,nr_inodes=121162,mode=755 0 0
securityfs /sys/kernel/security securityfs rw,nosuid,nodev,noexec,relatime 0 0
tmpfs /dev/shm tmpfs rw,seclabel,nosuid,nodev 0 0
devpts /dev/pts devpts rw,seclabel,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000 0 0
tmpfs /run tmpfs rw,seclabel,nosuid,nodev,mode=755 0 0
tmpfs /sys/fs/cgroup tmpfs ro,seclabel,nosuid,nodev,noexec,mode=755 0 0
cgroup /sys/fs/cgroup/systemd cgroup rw,seclabel,nosuid,nodev,noexec,relatime,xattr,release_agent=/usr/lib/systemd/systemd-cgroups-agent,name=systemd 0 0
pstore /sys/fs/pstore pstore rw,nosuid,nodev,noexec,relatime 0 0
cgroup /sys/fs/cgroup/memory cgroup rw,seclabel,nosuid,nodev,noexec,relatime,memory 0 0
cgroup /sys/fs/cgroup/perf_event cgroup rw,seclabel,nosuid,nodev,noexec,relatime,perf_event 0 0
cgroup /sys/fs/cgroup/net_cls,net_prio cgroup rw,seclabel,nosuid,nodev,noexec,relatime,net_prio,net_cls 0 0
cgroup /sys/fs/cgroup/freezer cgroup rw,seclabel,nosuid,nodev,noexec,relatime,freezer 0 0
cgroup /sys/fs/cgroup/pids cgroup rw,seclabel,nosuid,nodev,noexec,relatime,pids 0 0
cgroup /sys/fs/cgroup/blkio cgroup rw,seclabel,nosuid,nodev,noexec,relatime,blkio 0 0
cgroup /sys/fs/cgroup/hugetlb cgroup rw,seclabel,nosuid,nodev,noexec,relatime,hugetlb 0 0
cgroup /sys/fs/cgroup/cpu,cpuacct cgroup rw,seclabel,nosuid,nodev,noexec,relatime,cpuacct,cpu 0 0
cgroup /sys/fs/cgroup/cpuset cgroup rw,seclabel,nosuid,nodev,noexec,relatime,cpuset 0 0
cgroup /sys/fs/cgroup/devices cgroup rw,seclabel,nosuid,nodev,noexec,relatime,devices 0 0
configfs /sys/kernel/config configfs rw,relatime 0 0
/dev/vda1 / xfs rw,seclabel,relatime,attr2,inode64,noquota 0 0
rpc_pipefs /var/lib/nfs/rpc_pipefs rpc_pipefs rw,relatime 0 0
selinuxfs /sys/fs/selinux selinuxfs rw,relatime 0 0
systemd-1 /proc/sys/fs/binfmt_misc autofs rw,relatime,fd=28,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=15562 0 0
mqueue /dev/mqueue mqueue rw,seclabel,relatime 0 0
hugetlbfs /dev/hugepages hugetlbfs rw,seclabel,relatime 0 0
debugfs /sys/kernel/debug debugfs rw,relatime 0 0
overlay /var/lib/docker/overlay2/74da581c081eda43d804a227d31a95695ce4995f0e77528a37f0eb7424d41b6f/merged overlay rw,seclabel,relatime,lowerdir=/var/lib/docker/overlay2/l/A5O4QFJ4WCSUA4JQOHKQZL624U:/var/lib/docker/overlay2/l/LB2M7UAZ6XES4GATJT7DK3PHDZ:/var/lib/docker/overlay2/l/62LVWRWLAK3FOR5RJLSAQXOA35:/var/lib/docker/overlay2/l/ULJQPRT6RPVNN6BXQHUTZ6AYCZ,upperdir=/var/lib/docker/overlay2/74da581c081eda43d804a227d31a95695ce4995f0e77528a37f0eb7424d41b6f/diff,workdir=/var/lib/docker/overlay2/74da581c081eda43d804a227d31a95695ce4995f0e77528a37f0eb7424d41b6f/work 0 0
overlay /var/lib/docker/overlay2/5856ead72705c85f5dc2333b222db87e663827e6bd2ac29b31167361498e92f7/merged overlay rw,seclabel,relatime,lowerdir=/var/lib/docker/overlay2/l/2WZVH4C4YFGKSB5E45X6CUULM3:/var/lib/docker/overlay2/l/LB2M7UAZ6XES4GATJT7DK3PHDZ:/var/lib/docker/overlay2/l/62LVWRWLAK3FOR5RJLSAQXOA35:/var/lib/docker/overlay2/l/ULJQPRT6RPVNN6BXQHUTZ6AYCZ,upperdir=/var/lib/docker/overlay2/5856ead72705c85f5dc2333b222db87e663827e6bd2ac29b31167361498e92f7/diff,workdir=/var/lib/docker/overlay2/5856ead72705c85f5dc2333b222db87e663827e6bd2ac29b31167361498e92f7/work 0 0
proc /run/docker/netns/default proc rw,nosuid,nodev,noexec,relatime 0 0
shm /var/lib/docker/containers/9d229f9a0fd6a1b6e9c822d1b8e94aea59add6e559479ee6d06edf26cc16587c/mounts/shm tmpfs rw,seclabel,nosuid,nodev,noexec,relatime,size=65536k 0 0
shm /var/lib/docker/containers/2e520b806e847735fcf4b3fe5db634bb9b5a4cc2161a384f361de018003d14d5/mounts/shm tmpfs rw,seclabel,nosuid,nodev,noexec,relatime,size=65536k 0 0
proc /run/docker/netns/3816f2463f3d proc rw,nosuid,nodev,noexec,relatime 0 0
fusectl /sys/fs/fuse/connections fusectl rw,relatime 0 0
tmpfs /run/user/0 tmpfs rw,seclabel,nosuid,nodev,relatime,size=101504k,mode=700 0 0
```
