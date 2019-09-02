# Evernote | 印象笔记

## 区别

印象笔记：<www.yinxiang.com>
Evernote：<www.evernote.com>

* 不同账号系统：印象笔记和 Evernote 是同一软件，但账号相互独立
* 不同服务器：Evernote 在美国，一下吧
* 本地化功能：印象笔记支持保存微信微博等本地化服务
* 印象笔记的高级账号比 Evernote 更便宜

## 客户端

* Ubuntu / Tusk

Tusk 支持在 Evernote 和印象笔记之间相互切换。

安装：

```sh
# 下载 deb 文件即可
$ google-chrome https://github.com/klaussinani/tusk/releases
```

相关文件：

```plain
/usr/share/doc/tusk
/usr/local/bin/tusk
/opt/Tusk/tusk
```

修改桌面文件：

```sh
# 解决没有 ico 问题
$ wget https://www.yinxiang.com/media/img/favicon.ico -O /opt/Tusk/tusk.ico

$ vi /usr/share/applications/tusk.desktop
[Desktop Entry]
Name=Evernote
Exec="/opt/Tusk/tusk" %U
Terminal=false
Type=Application
Icon=/opt/Tusk/tusk.ico # 默认是 tusk
StartupWMClass=Tusk
Categories=Office;
```

增加命令：

```sh
$ ln -s /opt/Tusk/tusk /usr/local/bin/evernote
```

## 参考

* [Evernote on Linux](https://help.evernote.com/hc/en-us/articles/208313748-Evernote-on-Linux)
* [Evernote 国际版和印象笔记有什么区别？怎么迁移笔记？](https://www.zhihu.com/question/20713950)
* [微信朋友圈文章和聊天记录如何保存到印象笔记？](https://www.zhihu.com/question/20636154)