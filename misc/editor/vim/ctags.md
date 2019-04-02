# Ctags

代码索引生成工具

```bash
# vim 默认安装了 ctags
$ sudo apt-get install exuberant-ctags
```

```bash
$ cd project/

# 生成索引文件 .tags （默认文件名：tags）
$ ctags -f .tags -R .

# 打开定义有 [变量名/函数名] 的文件
$ vim -t [变量名/函数名]
```

```
1．$ctags –R * ($为Linux系统Shell提示符,这个命令上面已经有所介绍)
1. $ vi –t tag (请把tag替换为您欲查找的变量或函数名)
3．:ts(ts助记字：tagslist, “:”开头的命令为VI中命令行模式命令)
4．:tp(tp助记字：tagspreview)---此命令不常用，可以不用记
5．:tn(tn助记字：tagsnext) ---此命令不常用，可以不用记
6．Ctrl+ ]跳到光标所在函数或者结构体的定义处
7．Ctrl+ T返回查找或跳转
```

> 运行vim的时候，必须在“tags”文件所在的目录下运行。否则，运行vim的时候还要用“:set tags=”命令设定“tags”文件的路径，这样vim才能找到“tags”文件。在完成编码时，可以手工删掉tags文件

* [Gutentags](https://github.com/ludovicchabant/vim-gutentags) - 负责 tags 文件的管理：自动重新生成 tags 文件