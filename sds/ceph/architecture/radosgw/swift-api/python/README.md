# Swift for Python

## 安装

```bash
# 最新版本
$ pip install python-swiftclient
```

## 示例

```bash
import swiftclient

user = 's3demo:swiftdemo'
key = 'jjyy'
authurl = 'http://192.168.8.220:8080/auth'

conn = swiftclient.Connection(user=user, key=key, authurl=authurl)

"创建一个 container"
conn.put_container('mycontainer')

"列出所有 container"
for container in conn.get_account()[1]:
    print(container['name'])
```

## 参考

* [PYTHON SWIFT EXAMPLES](http://docs.ceph.com/docs/jewel/radosgw/swift/python/)
* [github.com/openstack/python-swiftclient](https://github.com/openstack/python-swiftclient)