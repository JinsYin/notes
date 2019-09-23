# Ext3

_Ext3_（第三代扩展文件系统 third extended filesystem）是 Linux 内核常用的日志文件系统。与 ext2 相比，其主要优点是日志记录（journaling），这提高了可靠性，并且可以避免异常关机后检查文件系统。其成功这是 ext4 。

## 简介

* 时间：2001 年 11 月
* 设计者：Stephen Tweedie
* 设计优势：日志记录（journaling）

## 大小限制

| 块大小  | 最大文件大小 | 最大文件系统大小 |
| ------- | ------------ | ---------------- |
| **1KB** | 16GB         | 4TB              |
| **2KB** | 256GB        | 8TB              |
| **4KB** | 2TB          | 16TB             |
| **8KB** | 2TB          | 32TB             |

解读：在 ext3 文件系统中，当逻辑块的大小为 1KB 时，文件最大可以是 16GB，而文件系统最大可以是 4TB

## 日志选项（journaling options）

* journaling
* ordered
* writeback
