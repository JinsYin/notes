# VMware

## 问题

问：

```plain
Could not open /dev/vmmon: No such file or directory. Please make sure that the kernel module `vmmon' is loaded.
```

答：

```bash
cd /tmp && tar xvf /usr/lib/vmware/modules/source/vmmon.tar
cd vmmon-only/ && make
cp vmmon.ko /lib/modules/$(uname -r)/misc/vmmon.ko
modprobe vmmon
```