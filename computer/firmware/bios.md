# BIOS

_BIOS_ （Basic Input/Output System，即基本输入输出系统，也称之为 _System BIOS_、_ROM BIOS_ 或 _PC BIOS_）是在通电引导阶段运行硬件初始化，以及为操作系统和程序提供运行时服务的固件。BIOS 欲安装在计算机的主板上，是计算机启动电源时运行的第一个软件。

现时 UEFI 已经取代传统 BIOS，且 Intel 将于 2020 年弃用传统 BIOS 接口，届时 Intel 产品不再支持基于16位实模式的 UEFI CSM（UEFI兼容性支持模块）。

## 简介

作者：Gary Kildall

## BIOS 与 CMOS

BIOS 是存储在 EEPROM，而 CMOS 为随机存储器（RAM）；
BIOS 中存储的是程序，而 CMOS 中存储的是普通信息。

## 核心功能

* 计算机硬件自检
* CMOS 设置
* 引导操作系统启动
* 提供硬件 I/O
* 硬件中断

## 核心模块

| 模块                     | 描述                                                                               |
| ------------------------ | ---------------------------------------------------------------------------------- |
| Boot Block 引导模块      | 直接负责执行 BIOS 程序本身入口、计算机基本硬件的检测和初始化                       |
| CMOS 设置模块            | 实现对硬件信息进行设置，并保存在 CMOS 中，是除了启动初始化以外 BIOS 程序常用的功能 |
| 扩展配置数据（ESCD）模块 | 用于 BIOS 与 OS 交换硬件配置数据                                                   |
| DMI                      | 充当了硬件管理工具和系统层之间接口的角色，用户可以直观地获取硬件的任何信息         |

## 供应商

当前全球只有四家独立的 BIOS 供应商（IBV）：

* Phoenix Technologies
* American Megatrends
* Insyde Software
* Byosoft