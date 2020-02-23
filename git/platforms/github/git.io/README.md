# Git.io

[Git.io](git.io) 是 Github 提供的短地址服务，可用于缩短 Github 的网址（`github.com`、`github.io`）。

## 实践

```sh
# git.io/jinsyin -> github.com/jinsyin
$ curl -i https://git.io -F "url=https://github.com/jinsyin" -F "code=jinsyin"

# git.io/weplay.me -> github.com/jinsyin/jinsyin.github.io
$ curl -i https://git.io -F "url=https://github.com/jinsyin/jinsyin.github.io" -F "code=weplay.me"

# git.io/knowledge-base -> github.com/jinsyin/knowledge-base
$ curl -i https://git.io -F "url=https://github.com/jinsyin/knowledge-base" -F "code=knowledge-base"

# git.io/cloud-native-handbook -> github.com/jinsyin/cloud-native-handbook
$ curl -i https://git.io -F "url=https://github.com/jinsyin/cloud-native-handbook" -F "code=cloud-native-handbook"

# git.io/cloud-native -> jinsyin.github.io/cloud-native-handbook
$ curl -i https://git.io -F "url=https://jinsyin.github.io/cloud-native-handbook" -F "code=cloud-native"

$ curl -i https://git.io -F "url=https://jinsyin.github.io/cloud-native-handbook?gitio=cloudnative" -F "code=cloudnative"
```

注意事项：

* [Git.io](git.io) 需要 Fan 墙
* 谨慎实践，因为一旦设置将不能再更改
* 不能将多个短地址指向同一个目标 URL（不过可以通过增加 `#` 或 `?` 来间接解决），即使请求成功最终也不会生效

<!--

## Todo

* 把知识库中已有的项目都添加短地址，考虑到目标路径可能发送变化，统一重定向到 jinsyin.github.io/knowledge-base?gitio=xxx

-->
