# stty

修改和打印终端设置（即终端属性）。

## 语法

```sh
stty [-F DEVICE | --file=DEVICE] [SETTING]...
stty [-F DEVICE | --file=DEVICE] [-a|--all]
stty [-F DEVICE | --file=DEVICE] [-g|--save]
```

## 选项

| 选项 | 描述                       |
| ---- | -------------------------- |
| `-a` | 以可读形式打印所有当前设置 |

## 示例

* 解读 stty -a

```sh
$ stty -a
speed 38400 baud; rows 25; columns 80; line = 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = M-^?; eol2 = M-^?;
swtch = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = ^W;
lnext = ^V; flush = ^O; min = 1; time = 0;
-parenb -parodd cs8 -hupcl -cstopb cread -clocal -crtscts
-ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon -ixoff
-iuclc ixany imaxbel -iutf8
opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tostop -echoprt
echoctl echoke
```

第 1 行：终端线速（bit/s）、终端窗口大小、数值形式的行规程（`0` 代表 N_TTY，即新行规程）
第 2-4 行：终端特殊字符的设定；如 Ctrl-C（^C）代表中断

* 修改终端特殊字符的设定

```sh
$ stty intr ^L
```