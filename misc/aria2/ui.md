# Aria2 UI

WebUI 作为客户端连接 aria2 守护进程，所以需要先在后台启动 aria2c。

* [webui-aria2](https://github.com/ziahamza/webui-aria2)
* [AriaNg](https://github.com/mayswind/AriaNg)
* [YAAW](https://github.com/binux/yaaw)

## webui-aria2

```bash
# Go to "http://localhost"
$ docker run -d --name webui-aria2 --restart=always -p 80:80 timonier/webui-aria2:latest
```

## YAAW

* [YAAW for Chrome](https://chrome.google.com/webstore/detail/yaaw-for-chrome/dennnbdlpgjgbcjfgaohdahloollfgoc)

## aria2gui

* [Aria2GUI for macOS](https://github.com/yangshun1029/aria2gui)