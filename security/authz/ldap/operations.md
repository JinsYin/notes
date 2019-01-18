# LDAP 操作

客户端可以请求如下操作：

| Operation                      | 描述                               |
| ------------------------------ | ---------------------------------- |
| StartTLS                       | 使用 LDAPv3 TLS 插件来实现安全连接 |
| Bind                           | 验证和指定 LDAP 协议版本           |
| Search                         | 搜索和/或检索目录条目              |
| Compare                        | 测试命名条目是否包含给定的属性值   |
| Add a new entry                | 添加一个新条目                     |
| Delete an entry                | 删除一个条目                       |
| Modify an entry                | 修改一个条目                       |
| Modify Distinguished Name (DN) | 移除或重命名条目                   |
| Abandon                        | 中止先前的请求                     |
| Extended Operation             | 用于定义其他操作的泛型操作         |
| Unbind                         | 关闭连接（并非 Bind 的反义）       |

## Add

如果 DN 已存在于目录中，目录服务器不会重复添加条目，但会将响应结果的 Result Code 设置为十进制 `68`（`entryAlreadyExists`）

* 添加的条目不能存在，且必须存在直接上级

```plain
dn: uid=user,ou=people,dc=example,dc=com
changetype: add
objectClass: top
objectClass: person
uid: user
sn: last-name
cn: common-name
userPassword: password
```

`uid=user,ou=people,dc=example,dc=com` 必须不存在，并且 `ou=people,dc=example,dc=com` 必须存在

## 删除

* 删除请求必须包含要删除的条目的 DN
* 删除请求只能删除叶子条目（没有下属的条目）