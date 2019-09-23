# 内存

## 释放交换空间

```sh
% swapoff -a && swapon -a
```

## 查看内存条数

```sh
$ dmidecode | grep -A19 "Memory Device$"
Memory Device
  Array Handle: 0x003E
  Error Information Handle: Not Provided
  Total Width: 64 bits
  Data Width: 64 bits
  Size: 8192 MB
  Form Factor: DIMM
  Set: None
  Locator: DIMM3
  Bank Locator: Not Specified
  Type: DDR3
  Type Detail: Synchronous
  Speed: 1600 MHz
  Manufacturer: 0420
  Serial Number: 0800D3000000
  Asset Tag: 00153400
  Part Number: DDR3 1600
  Rank: 2
  Configured Clock Speed: 1600 MHz
```
