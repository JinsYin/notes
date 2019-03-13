# Ubuntu 配置代理

## 全局手动代理

`System Settings` > `Network` > `Network proxy` > `Manual` > 仅在 Socks Host 栏中填写本地的 sock 主机和端口，默认是: `127.0.0.1` 和 `1080`。

## 全局自动代理

使用自动代理需要配置 PAC （Proxy Autoproxy Config，代理自动配置）。[GenPAC](https://github.com/JinnLynn/GenPAC) 是基于 gfwlist 的 PAC 文件生成工具，支持自定义规则。

```bash
# 安装最新版本的 genpac
$ pip install --upgrade https://github.com/JinnLynn/genpac/archive/master.zip

# 生成 pac 文件到指定路径中
$ genpac --pac-proxy "SOCKS5 127.0.0.1:1080" --gfwlist-proxy="SOCKS5 127.0.0.1:1080" --output="/home/yin/shadowsocks/autoproxy.pac" --gfwlist-url="https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt"
```

`System Settings` > `Network` > `Network proxy` > `Automatic` > 填入 pac 文件路径：`file:///home/yin/shadowsocks/autoproxy.pac`。

## 配置文件

* [gfwlist](https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt)：大陆白名单（需要使用 ss 的墙外网站列表）
* [gui-config](./gui-config.json): ss 客户端配置，请自行修改