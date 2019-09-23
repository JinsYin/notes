# /proc/bus

| 子文件或子目录   | 描述              |
| ---------------- | ----------------- |
| /proc/bus/       | 计算机的各种总线  |
| /proc/bus/input/ | 输入总线，如：USB |
| /proc/bus/pci/   | PCI 总线          |

## /proc/bus/input

```sh
$ cat /proc/bus/input/devices
-----------------------------
I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button"
P: Phys=PNP0C0C/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
U: Uniq=
H: Handlers=kbd event0
B: PROP=0
B: EV=3
B: KEY=10000000000000 0

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button"
P: Phys=LNXPWRBN/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
U: Uniq=
H: Handlers=kbd event1
B: PROP=0
B: EV=3
B: KEY=10000000000000 0

I: Bus=0003 Vendor=18f8 Product=0f99 Version=0110
N: Name="USB OPTICAL MOUSE "
P: Phys=usb-0000:00:14.0-3/input0
S: Sysfs=/devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3:1.0/0003:18F8:0F99.0001/input/input5
U: Uniq=
H: Handlers=mouse0 event2
B: PROP=0
B: EV=17
B: KEY=1f0000 0 0 0 0
B: REL=103
B: MSC=10

I: Bus=0003 Vendor=18f8 Product=0f99 Version=0110
N: Name="USB OPTICAL MOUSE "
P: Phys=usb-0000:00:14.0-3/input1
S: Sysfs=/devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3:1.1/0003:18F8:0F99.0002/input/input6
U: Uniq=
H: Handlers=sysrq kbd event3
B: PROP=0
B: EV=10001f
B: KEY=3007f 0 0 483ffff17aff32d bf54444600000000 1 130f938b17c000 677bfad9415fed e09effdf01cfffff fffffffffffffffe
B: REL=40
B: ABS=100000000
B: MSC=10

I: Bus=0003 Vendor=04d9 Product=a0cd Version=0111
N: Name="USB Keyboard"
P: Phys=usb-0000:00:14.0-4/input0
S: Sysfs=/devices/pci0000:00/0000:00:14.0/usb3/3-4/3-4:1.0/0003:04D9:A0CD.0003/input/input7
U: Uniq=
H: Handlers=sysrq kbd event4 leds
B: PROP=0
B: EV=120013
B: KEY=1000000000007 ff800000000007ff febeffdff3cfffff fffffffffffffffe
B: MSC=10
B: LED=7

I: Bus=0003 Vendor=04d9 Product=a0cd Version=0111
N: Name="USB Keyboard"
P: Phys=usb-0000:00:14.0-4/input1
S: Sysfs=/devices/pci0000:00/0000:00:14.0/usb3/3-4/3-4:1.1/0003:04D9:A0CD.0004/input/input8
U: Uniq=
H: Handlers=sysrq kbd event5
B: PROP=0
B: EV=10001f
B: KEY=3f0003007f 0 0 483ffff17aff32d bf54444600000000 1 130f938b17c000 677bfad941dfed e0beffdf01cfffff fffffffffffffffe
B: REL=40
B: ABS=100000000
B: MSC=10

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel PCH Rear Mic"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input9
U: Uniq=
H: Handlers=event6
B: PROP=0
B: EV=21
B: SW=10

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel PCH Front Mic"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input10
U: Uniq=
H: Handlers=event7
B: PROP=0
B: EV=21
B: SW=10

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel PCH Line Out"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input11
U: Uniq=
H: Handlers=event8
B: PROP=0
B: EV=21
B: SW=40

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel PCH Front Headphone"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input12
U: Uniq=
H: Handlers=event9
B: PROP=0
B: EV=21
B: SW=4

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA NVidia HDMI/DP,pcm=3"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input13
U: Uniq=
H: Handlers=event10
B: PROP=0
B: EV=21
B: SW=140

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA NVidia HDMI/DP,pcm=7"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input14
U: Uniq=
H: Handlers=event11
B: PROP=0
B: EV=21
B: SW=140

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA NVidia HDMI/DP,pcm=8"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input15
U: Uniq=
H: Handlers=event12
B: PROP=0
B: EV=21
B: SW=140
```

```sh
$ cat /proc/bus/input/handlers
------------------------------
N: Number=0 Name=rfkill
N: Number=1 Name=kbd
N: Number=2 Name=sysrq (filter)
N: Number=3 Name=mousedev Minor=32
N: Number=4 Name=evdev Minor=64
N: Number=5 Name=joydev Minor=0
N: Number=6 Name=leds
```

## /proc/bus/pci/devices

```sh
$ cat /proc/bus/pci/devices
---------------------------
0000	80860100	0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	snb_uncore
0008	80860101	18	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	pcieport
00a0	80861e31	19	        f7120004	               0	               0	               0	               0	               0	               0	           10000	               0	               0	               0	               0	               0	               0	xhci_hcd
00b0	80861e3a	1c	        f713c004	               0	               0	               0	               0	               0	               0	              10	               0	               0	               0	               0	               0	               0	mei_me
00c8	80861502	1b	        f7100000	        f7139000	            f041	               0	               0	               0	               0	           20000	            1000	              20	               0	               0	               0	               0	e1000e
00d0	80861e2d	10	        f7138000	               0	               0	               0	               0	               0	               0	             400	               0	               0	               0	               0	               0	               0	ehci-pci
00d8	80861e20	1e	        f7130004	               0	               0	               0	               0	               0	               0	            4000	               0	               0	               0	               0	               0	               0	snd_hda_intel
00e8	80861e26	17	        f7137000	               0	               0	               0	               0	               0	               0	             400	               0	               0	               0	               0	               0	               0	ehci-pci
00f0	8086244e	0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0
00f8	80861e47	0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	               0	lpc_ich
00fa	80862822	1a	            f091	            f081	            f071	            f061	            f021	        f7136000	               0	               8	               4	               8	               4	              20	             800	               0	ahci
00fb	80861e22	5	        f7135004	               0	               0	               0	            f001	               0	               0	             100	               0	               0	               0	              20	               0	               0
0100	10de0fc2	1d	        f6000000	        e000000c	               0	        f000000c	               0	            e001	        f7000002	         1000000	        10000000	               0	         2000000	               0	              80	           80000	nouveau
0101	10de0e1b	11	        f7080000	               0	               0	               0	               0	               0	               0	            4000	               0	               0	               0	               0	               0	               0	snd_hda_intel
```
