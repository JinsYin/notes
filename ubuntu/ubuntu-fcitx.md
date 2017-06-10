# Ubuntu 配置 fcitx 及输入法

## 安装 fcitx

如果无意间卸载了 fcitx，可以重新安装。
```bash
$ sudo add-apt-repository -y ppa:fcitx-team/stable
$ sudo apt-get -y update
$ sudo apt-get install -y fcitx
```

使用搜狗等输入法，需要确保使用的键盘输入方式是 `fcitx`，如果不是，打开 `Language Support` 软件设置为默认，或者打开 `Input Method` 软件进行设置。

## 搜狗输入法

下载 deb 安装： http://pinyin.sogou.com/linux/ 。

安装好之后，到 `fcitx configuration` 软件中添加搜狗输入法。

## 搜狗词库

为了是搜狗输入法更加强（niu）大（bi），可以添加更多[词库](http://pinyin.sogou.com/dict/)。常用的词库有：
- [成语俗语](http://pinyin.sogou.com/dict/detail/index/15097)
- [计算机词汇大全](http://pinyin.sogou.com/dict/detail/index/15117)
- [网络流行新词](http://pinyin.sogou.com/dict/detail/index/4)
- [全国省市区县地名](http://pinyin.sogou.com/dict/detail/index/807)
- [四级行政区划地名词库（最全）](http://pinyin.sogou.com/dict/detail/index/763)
- [中国高等院校（大学）大全](http://pinyin.sogou.com/dict/detail/index/20647)
- [淘宝专用词库](http://pinyin.sogou.com/dict/detail/index/22416)
- [手机词汇大全](http://pinyin.sogou.com/dict/detail/index/15185)
- [最新常用聊天短语](http://pinyin.sogou.com/dict/detail/index/40290)
- [日常用语大词库](http://pinyin.sogou.com/dict/detail/index/40288)
- [常用汉语人名大全](http://pinyin.sogou.com/dict/detail/index/29429)
- [足球](http://pinyin.sogou.com/dict/detail/index/15188)
- [程序猿词库](http://pinyin.sogou.com/dict/detail/index/36423)
- [计算机专业词库](http://pinyin.sogou.com/dict/detail/index/403)
- [linux少量术语](http://pinyin.sogou.com/dict/detail/index/225)
- [电脑硬件品牌](http://pinyin.sogou.com/dict/detail/index/1157)
- [热门电影大全](http://pinyin.sogou.com/dict/detail/index/20652)
