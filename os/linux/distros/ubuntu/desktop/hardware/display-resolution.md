# 显示器分辨率

不要使用 `root` 用户. 开机的时候用的哪个用户进去的就用哪个用户来操作。

## 查看分辨率选项（获取显卡设备）

```bash
$ xrandr
```

## 生成 1600x900 的分辨率（会生成显示模式）

```bash
$ cvt 1600 900
# 1600x900 59.95 Hz (CVT 1.44M9) hsync: 55.99 kHz; pclk: 118.25 MHz
Modeline "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
```

## 使用 xrandr 添加 cvt 得到的显示模式（VGA1 是显卡设备）

```bash
$ xrandr --newmode "1600x900" 118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
$ xrandr --addmode VGA1 1600x900
$ xrandr --output VGA1 --mode 1600x900
```

## 开机自动设置分辨率

```bash
$ vi ~/.profile
> cvt 1600 900
> xrandr --newmode 1600x900 118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
> xrandr --addmode VGA1 1600x900
```
