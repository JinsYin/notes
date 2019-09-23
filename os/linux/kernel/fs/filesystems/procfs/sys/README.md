# /proc/sys

`sysctl` 作用于该目录。

```sh
$ sysctl -a
```

```sh
$ ls -l /proc/sys
4026531855 dr-xr-xr-x   1 root root 0  7月 22 10:10 ./
         1 dr-xr-xr-x 313 root root 0  7月 22 10:09 ../
  29728495 dr-xr-xr-x   1 root root 0  7月 22 13:35 abi/
  29728496 dr-xr-xr-x   1 root root 0  7月 22 13:35 debug/
     16861 dr-xr-xr-x   1 root root 0  7月 22 02:10 dev/
      8612 dr-xr-xr-x   1 root root 0  7月 22 02:10 fs/
  29728497 dr-xr-xr-x   1 root root 0  7月 22 13:35 fscache/
     10453 dr-xr-xr-x   1 root root 0  7月 22 10:10 kernel/
      7609 dr-xr-xr-x   1 root root 0  7月 22 02:10 net/
  29728498 dr-xr-xr-x   1 root root 0  7月 22 13:35 sunrpc/
      7636 dr-xr-xr-x   1 root root 0  7月 22 02:10 vm/
```

## 参考

* [Documentation for /proc/sys](https://www.kernel.org/doc/html/latest/admin-guide/sysctl/index.html)
