# macOS

macOS 之前叫 OS X 。

macOS 是基于 BSD Unix 设计的，而 Linux 很大程度受到了 System-V Unix 和 GNU 工具的影响。

## 常规

* 锁屏/退出登录：<kbd>Ctrl + Command + Q</kbd>
* 熄屏：
  * <kbd>Shift + Ctrl + Power</kbd>
  * 合上笔记本

## 安全

1. 「安全性与隐私」 > 「通用」 > 「进入睡眠或开始屏幕保护程序 立即 要求输入密码」

## 延长电池寿命

1. 设置显示屏幕保护程序后，依然会使用其处理器、图形芯片和显示器。为了节能，您可以使用节能偏好设置选取在显示器关闭或进入睡眠状态之前 Mac 应处于闲置状态的时长。

## Bash

```sh
$ cat ~/.bash_profile
alias ll='ls -alF'

$ source ~/.bash_profile
```

## 参考

* [如何在 Mac 上显示屏幕保护程序](https://support.apple.com/zh-cn/HT204379)
