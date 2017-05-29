## SSH debug
```
$ ssh -vv root@192.168.111.191
```

## 禁用GSSAPI
- client端禁用
```bash
$ ssh -o GSSAPIAuthentication=no -vv root@192.168.111.191
```
- server端禁用
```
$ vi /etc/ssh/sshd_config
> GSSAPIAuthentication no
```

## 禁用DNS解析
```
$ vi /etc/ssh/sshd_config
> UseDNS no
```

## 允许root用户登录
```
$ vi /etc/ssh/sshd_config
> PermitRootLogin yes
```

## 参考
> http://blog.csdn.net/wenwenxiong/article/details/48685723
