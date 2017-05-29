## SSH debug
```
$ ssh -vv root@192.168.111.191
```

## GSSAPI 禁用
- client端连接时禁用： ssh -o GSSAPIAuthentication=no -vv root@192.168.111.191
- server端禁用： vi /etc/ssh/sshd_config: GSSAPIAuthentication no (也可以不使用DNS解析：UseDNS no)

## 允许root用户登录
```
# vi /etc/ssh/sshd_config
PermitRootLogin yes
```

## 参考
> http://blog.csdn.net/wenwenxiong/article/details/48685723
