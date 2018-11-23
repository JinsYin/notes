# config

## 设置代理

* HTTP

```sh
$ git config --global http.proxy http://127.0.0.1:1070

# 取消
$ git config --global --unset http.proxy
```

* SOCKS

```bash
# socks5h 代替 socks5
$ git config --global http.proxy socks5h://127.0.0.1:1080
```

```bash
# 使用环境变量
$ ALL_PROXY=socks5://127.0.0.1:1080 git clone https://github.com/x/y.git
```

## 参考

* [Git 设置和取消代理](https://gist.github.com/laispace/666dd7b27e9116faece6)