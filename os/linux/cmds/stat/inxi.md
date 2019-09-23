# inxi

## 安装

```sh
$ yum install -y inxi
```

## 示例

```sh
$ inxi -Fi
System:    Host: Yin Kernel: 4.4.0-148-generic x86_64 (64 bit) Desktop: Gnome Distro: Ubuntu 14.04 trusty
Machine:   System: Dell product: OptiPlex 9010 version: 01
           Mobo: Dell model: 0T3G9D version: A02 Bios: Dell version: A13 date: 03/27/2013
CPU:       Quad core Intel Core i5-2320 CPU (-MCP-) cache: 6144 KB flags: (lm nx sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx)
           Clock Speeds: 1: 3202.031 MHz 2: 3196.406 MHz 3: 3203.906 MHz 4: 3208.242 MHz
Graphics:  Card: NVIDIA GK107 [GeForce GT 630 OEM]
           X.Org: 1.17.2 drivers: nouveau (unloaded: fbdev,vesa) Resolution: 1920x1080@60.0hz, 1920x1080@60.0hz, 1920x1080@60.0hz
           GLX Renderer: Gallium 0.4 on NVE7 GLX Version: 3.0 Mesa 11.0.2
Audio:     Card-1: Intel 7 Series/C210 Series Family High Definition Audio Controller driver: snd_hda_intel
           Card-2: NVIDIA GK107 HDMI Audio Controller driver: snd_hda_intel
           Sound: Advanced Linux Sound Architecture ver: k4.4.0-148-generic
Network:   Card: Intel 82579LM Gigabit Network Connection driver: e1000e
           IF: eth1 state: up speed: 1000 Mbps duplex: full mac: 90:b1:1c:a5:42:7b
           WAN IP: 116.235.235.133 IF: veth0357603@if17 ip: N/A IF: vmnet8 ip: 192.168.135.1
           IF: eth1 ip: 192.168.16.100 IF: vmnet1 ip: 172.16.164.1 IF: docker0 ip: 172.17.0.1
           IF: virbr0 ip: 192.168.122.1
Drives:    HDD Total Size: 1120.2GB (12.5% used) 1: id: /dev/sda model: ST1000DM003 size: 1000.2GB
           2: id: /dev/sdb model: KINGSTON_SHFS37A size: 120.0GB
Partition: ID: / size: 110G used: 103G (99%) fs: ext4
RAID:      No RAID devices detected - /proc/mdstat and md_mod kernel raid module present
Sensors:   System Temperatures: cpu: 29.8C mobo: 27.8C gpu: 54.0
           Fan Speeds (in rpm): cpu: N/A
Info:      Processes: 387 Uptime: 5 days Memory: 10035.2/32130.2MB Client: Shell (bash) inxi: 1.9.17
```
