# /proc/[pid]]/mounts

```bash
$ cat /proc/$$/mounts
---------------------
sysfs /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0
proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0
udev /dev devtmpfs rw,relatime,size=16438356k,nr_inodes=4109589,mode=755 0 0
devpts /dev/pts devpts rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000 0 0
tmpfs /run tmpfs rw,nosuid,noexec,relatime,size=3290144k,mode=755 0 0
/dev/disk/by-uuid/07003934-f200-4c54-a4bb-8c82093a285f / ext4 rw,relatime,errors=remount-ro,data=ordered 0 0
none /sys/fs/cgroup tmpfs rw,relatime,size=4k,mode=755 0 0
none /sys/fs/fuse/connections fusectl rw,relatime 0 0
none /sys/kernel/debug debugfs rw,relatime 0 0
none /sys/kernel/security securityfs rw,relatime 0 0
none /run/lock tmpfs rw,nosuid,nodev,noexec,relatime,size=5120k 0 0
none /run/shm tmpfs rw,nosuid,nodev,relatime 0 0
none /run/user tmpfs rw,nosuid,nodev,noexec,relatime,size=102400k,mode=755 0 0
none /sys/fs/pstore pstore rw,relatime 0 0
cgroup /sys/fs/cgroup/cpuset cgroup rw,relatime,cpuset 0 0
cgroup /sys/fs/cgroup/cpu cgroup rw,relatime,cpu 0 0
cgroup /sys/fs/cgroup/cpuacct cgroup rw,relatime,cpuacct 0 0
cgroup /sys/fs/cgroup/blkio cgroup rw,relatime,blkio 0 0
cgroup /sys/fs/cgroup/memory cgroup rw,relatime,memory 0 0
cgroup /sys/fs/cgroup/devices cgroup rw,relatime,devices 0 0
cgroup /sys/fs/cgroup/freezer cgroup rw,relatime,freezer 0 0
cgroup /sys/fs/cgroup/net_cls cgroup rw,relatime,net_cls 0 0
cgroup /sys/fs/cgroup/perf_event cgroup rw,relatime,perf_event 0 0
cgroup /sys/fs/cgroup/net_prio cgroup rw,relatime,net_prio 0 0
cgroup /sys/fs/cgroup/hugetlb cgroup rw,relatime,hugetlb 0 0
cgroup /sys/fs/cgroup/pids cgroup rw,relatime,pids 0 0
/dev/sda1 /home/yin/mnt/sda1 xfs rw,relatime,attr2,inode64,noquota 0 0
rpc_pipefs /run/rpc_pipefs rpc_pipefs rw,relatime 0 0
binfmt_misc /proc/sys/fs/binfmt_misc binfmt_misc rw,nosuid,nodev,noexec,relatime 0 0
systemd /sys/fs/cgroup/systemd cgroup rw,nosuid,nodev,noexec,relatime,name=systemd 0 0
cgroup /sys/fs/cgroup/dsystemd cgroup rw,nosuid,nodev,noexec,relatime,xattr,release_agent=/lib/systemd/systemd-cgroups-agent,name=dsystemd 0 0
/dev/loop0 /snap/spotify/16 squashfs ro,nodev,relatime 0 0
/dev/loop1 /snap/electronic-wechat/7 squashfs ro,nodev,relatime 0 0
/dev/loop2 /snap/redis-desktop-manager/85 squashfs ro,nodev,relatime 0 0
/dev/loop3 /snap/core/4830 squashfs ro,nodev,relatime 0 0
/dev/loop4 /snap/spotify/19 squashfs ro,nodev,relatime 0 0
/dev/loop5 /snap/redis-desktop-manager/31 squashfs ro,nodev,relatime 0 0
/dev/loop6 /snap/core/5145 squashfs ro,nodev,relatime 0 0
/dev/loop7 /snap/core/4917 squashfs ro,nodev,relatime 0 0
none /var/lib/docker/aufs/mnt/bebc62390ef69a12d8cabe30d3e54b8f52a1c3ad04ea8f48d6668c4339ddd2dd aufs rw,relatime,si=8333b5d5a41a6c87,dio,dirperm1 0 0
none /var/lib/docker/aufs/mnt/afa79135a17d845554954f0f6eea5afcab2de0a92488160b87a084a7f79c992f aufs rw,relatime,si=8333b5d2be876c87,dio,dirperm1 0 0
none /var/lib/docker/aufs/mnt/aa08bb63bcdc391e39c7a2875531abd54f00b6cad334e9f07d995e7214a2b88a aufs rw,relatime,si=8333b5d2be875c87,dio,dirperm1 0 0
nsfs /run/docker/netns/default nsfs rw 0 0
shm /var/lib/docker/containers/86e99aeb720052fea4c57bcc70f6f6aef053692bd9b579148e729fbb6d323e49/mounts/shm tmpfs rw,nosuid,nodev,noexec,relatime,size=65536k 0 0
shm /var/lib/docker/containers/05c4dd21fa48269ac669df91bf7b04f3e7f2ff83009b898942834be06115d6b9/mounts/shm tmpfs rw,nosuid,nodev,noexec,relatime,size=65536k 0 0
shm /var/lib/docker/containers/7d0f47463f27717a3836adab0b200d654e4d4bf021dfbcbbb8645b7ae8599f6d/mounts/shm tmpfs rw,nosuid,nodev,noexec,relatime,size=65536k 0 0
vmware-vmblock /run/vmblock-fuse fuse.vmware-vmblock rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other 0 0
gvfsd-fuse /run/user/1000/gvfs fuse.gvfsd-fuse rw,nosuid,nodev,relatime,user_id=1000,group_id=1000 0 0
/dev/sdd4 /media/yin/Ubuntu\04014.0 vfat rw,nosuid,nodev,relatime,uid=1000,gid=1000,fmask=0022,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,showexec,utf8,flush,errors=remount-ro 0 0
none /var/lib/docker/aufs/mnt/83e31eca7296e99f712537a69dc5ed8a7adde7c72dd674977792a1f0e9a7f70f aufs rw,relatime,si=8333b5d250c17c87,dio,dirperm1 0 0
shm /var/lib/docker/containers/18400ac53cea550a4a10adc001d2a43e9a5af550ec7b151ebe92e553cbe9b20c/mounts/shm tmpfs rw,nosuid,nodev,noexec,relatime,size=65536k 0 0
/dev/sda3 /media/yin/7456B33F56B30142 fuseblk rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other,blksize=4096 0 0
/dev/sda2 /media/yin/000B3CE60003997E fuseblk rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other,blksize=4096 0 0
```