# getfacl

获取文件访问控制列表（ACL）

## 示例

```sh
$ getfacl /bin/ls
getfacl: Removing leading '/' from absolute path names
# file: bin/ls
# owner: root
# group: root
user::rwx
group::r-x
other::r-x
```
