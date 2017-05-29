# ubuntu 调整分辨率

## 查看分辨率选项（获取显卡设备）
```
xrandr
```

## 生成 1400x900 的分辨率(会生成显示模式)
```bash
$ cvt 1440 900
# 1440x900 59.89 Hz (CVT 1.30MA) hsync: 55.93 kHz; pclk: 106.50 MHz
Modeline "1440x900_60.00"  106.50  1440 1528 1672 1904  900 903 909 934 -hsync +vsync
```

## 使用xrandr添加cvt得到的显示模式（VGA1是显卡设备）
```bash
$ sudo xrandr --newmode "1440x900" 106.50 1440 1528 1672 1904 900 903 909 934 -hsync +vsync
$ sudo xrandr --addmode VGA1 1440x900
$ sudo xrandr --output VGA1 --mode 1440x900
```

## 开机自动设置分辨率
```
$ sudo vi ~/.profile
> cvt 1440 900
> xrandr --newmode 1440x900 106.50 1440 1528 1672 1904 900 903 909 934 -hsync +vsync
> xrandr --addmode VGA1 1440x900
```
