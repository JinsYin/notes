# 安装 RDMA 软件包

RHEL/CentOS 7.x 中，`Infiniband Support` Group 包含 RDMA 相关的所有软件包，包括用于实现 RDMA 的 `InfiniBand`、`RoCE` 和 `iWARP` 协议。

## 准备

* 检查 IB 卡类型

```bash
$ lspci | grep Mellanox
04:00.0 InfiniBand: Mellanox Technologies MT26428 [ConnectX VPI PCIe 2.0 5GT/s - IB QDR / 10GigE] (rev b0)
```

```bash
# 查看详细信息
$ lspci -s "04:00.0" -vvv
04:00.0 InfiniBand: Mellanox Technologies MT26428 [ConnectX VPI PCIe 2.0 5GT/s - IB QDR / 10GigE] (rev b0)
  Subsystem: Mellanox Technologies Device 0022
  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
  Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
  Latency: 0, Cache Line Size: 32 bytes
  Interrupt: pin A routed to IRQ 47
  NUMA node: 0
  Region 0: Memory at 91a00000 (64-bit, non-prefetchable) [size=1M]
  Region 2: Memory at 3bfff000000 (64-bit, prefetchable) [size=8M]
  Capabilities: [40] Power Management version 3
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
    Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
  Capabilities: [48] Vital Product Data
    Product Name: KESTREL QDR
    Read-only fields:
      [PN] Part number: MHQH19B-XTR
      [EC] Engineering changes: A1
      [SN] Serial number: MT1037X01146
      [V0] Vendor specific: PCIe Gen2 x8
      [RV] Reserved: checksum good, 0 byte(s) reserved
    Read/write fields:
      [V1] Vendor specific: N/A
      [YA] Asset tag: N/A
      [RW] Read-write area: 109 byte(s) free
    End
  Capabilities: [9c] MSI-X: Enable+ Count=128 Masked-
    Vector table: BAR=0 offset=0007c000
    PBA: BAR=0 offset=0007d000
  Capabilities: [60] Express (v2) Endpoint, MSI 00
    DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 unlimited
      ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 25.000W
    DevCtl: Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
      RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
      MaxPayload 256 bytes, MaxReadReq 4096 bytes
    DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
    LnkCap: Port #8, Speed 5GT/s, Width x8, ASPM L0s, Exit Latency L0s unlimited, L1 unlimited
      ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
    LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
      ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
    LnkSta: Speed 5GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
    DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
    DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF Disabled
    LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
       Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
       Compliance De-emphasis: -6dB
    LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
       EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
  Capabilities: [100 v1] Alternative Routing-ID Interpretation (ARI)
    ARICap: MFVC- ACS-, Next Function: 0
    ARICtl: MFVC- ACS-, Function Group: 0
  Capabilities: [148 v1] Device Serial Number 00-02-c9-03-00-0c-c8-9a
  Kernel driver in use: mlx4_core
  Kernel modules: mlx4_core
```

* 检查 IB 驱动版本

* 查看 IB 卡的 PSID

```bash
$ ibv_devinfo | grep board_id
board_id:   MT_0D81120009
```

## 相关软件包

* openib - 包含 `/etc/init.d/openibd` 初始化脚本的软件包，负责在系统启动时加载所需的内核模块；默认未开启，需要通过 `systemctl enable openibd` 方式开启，可以通过 `/etc/ofed/openib.conf` 进行配置。
* rdma-core - 负责 RDMA 堆栈的内核初始化
* opensm - Infiniband 子网管理器，需要启动 `opensm.service`，通过 `/etc/rdma/opensm.conf` 进行配置。
* ibutils, infiniband-diags (以前叫 openib-diags) - 包含各种实用工具，用于查看 IB 网卡的运行状态、端到端连接
* perftest, qperf - RDMA 的性能测试工具
* libibverbs - 提供 InfiniBand Verbs API

## 安装

```bash
# 查看相关的软件包
$ yum groupinfo "Infiniband Support" # yum group info "Infiniband Support"
Group: Infiniband Support
 Group-Id: infiniband
 Description: Software designed for supporting clustering and grid connectivity using RDMA-based InfiniBand and iWARP fabrics.
 Mandatory Packages: # mandatory 部分
    libibcm
    libibverbs # 所有支持 iWARP、RoCE 或 InfiniBand 用户空间驱动程序
    libibverbs-utils
    librdmacm
    librdmacm-utils
 Default Packages: # default 部分
    dapl
    ibacm
    ibutils
    infiniband-diags
   -iwpmd
   -libhfi1
   -libi40iw
   -libibmad
    libibumad
   -libipathverbs
    libmlx4
    libmlx5
   -libmthca
   -libnes
   -libocrdma
    mstflint
   -opa-address-resolution
   -opa-fastfabric
   -opa-libopamgt
    perftest  # -_-
    qperf     # -_-
   -rdma-core # RHEL 7.4 开始，所有 RDMA 用户空间驱动程序都合并到了该包中
   -srp_daemon
 Optional Packages: # optional 部分
   compat-dapl
   compat-opensm-libs
   libibcommon
   libusnic_verbs
   libvma
   opensm # -_-
   usnic-tools
 Conditional Packages: # conditional 部分
    glusterfs-rdma
```

* 方式一

```bash
# 默认仅安装 mandatory 和 default 两部分的软件包
$ yum groupinstall -y "Infiniband Support"
```

* 方式二（推荐）

```bash
# 如果想安装 mandatory、default 和 optional 部分的软件包，执行以下命令
$ yum --setopt=group_package_types=default,mandatory,optional groupinstall -y "Infiniband Support"
```

## 卸载、更新

```bash
# 卸载
$ yum groupremove -y "Infiniband Support"

# 更新
$ yum groupupdate -y "Infiniband Support"
```

## 启动 RDMA 服务

当检查到支持 RDMA 的硬件时，无论是 InfiniBand 还是 iWARP 或 RoCE/IBoE，udev 会指示 `systemd` 启动 `rdma` 服务。

```bash
# 手动启动服务
$ systemctl start rdma.service
$ systemctl enable rdma.service

# 状态、日志
$ systemctl status rdma.service
$ journalctl -f -u rdma.service
```

如果正在使用 InfiniBand transport 且子网中没有托管交换机，必须启动 Subnet Manager（SM）。可以执行 `ibstat` 命令检查 IB 网络是否已连通，从而决定是否需要启动 `opensm` 服务。只需在子网中的任一台机器执行次操作即可：

```bash
# 需要安装 optional 部分的软件包
$ systemctl start opensm.service
$ systemctl enable opensm.service
```

## 验证网络连通性

```bash
$ ibstat
CA 'mlx4_0'
  CA type: MT26428
  Number of ports: 1
  Firmware version: 2.9.1000
  Hardware version: b0
  Node GUID: 0x0002c903000cc89a
  System image GUID: 0x0002c903000cc89d
  Port 1:
    State: Active          # 反之为 Down
    Physical state: LinkUp # 反之为 Polling
    Rate: 40
    Base lid: 3
    LMC: 0
    SM lid: 5
    Capability mask: 0x0259086a
    Port GUID: 0x0002c903000cc89b
    Link layer: InfiniBand
```

## 停止 RDMA 服务

如果 SM 正在运行，必须在卸载驱动前停止它。

```bash
systemctl stop opensm.service
systemctl stop rdma.service

systemctl disable opensm.service
systemctl disable rdma.service
```

## RDMA 配置

`rdma` 服务读取 `/etc/rdma/rdma.conf` 配置文件，以找出默认情况下管理员希望加载的内核级和用户级 RDMA 协议。编辑该文件可以打开或关闭各种驱动程序。

可以打开和禁用的各种驱动程序：

| Driver Name | 描述                                                                                             |
| ----------- | ------------------------------------------------------------------------------------------------ |
| IPoIB       | IP 网络仿真层，允许 IP 应用程序在 InfiniBand 网络上运行                                          |
| SRP         | SCSI Request Protocol，允许计算机通过 `SRP` 协议挂载远程 drive 或 driver array，就像本地硬盘一样 |
| SRPT        | `SRP` 协议的 target/server 模式，这会加载为其他计算机导出 drive 或 drive array 所需的内核支持    |
| ISER        | Linux Kernel 的常规 iSCSI 层的低级驱动程序，可通过 InfiniBand 网络为 iSCSI 设备提供传输          |
| RDS         | Linux Kernel 中的 Reliable Datagram Service                                                      |

参数列表：

| Parameter name  | Supported values | 描述                      |
| --------------- | ---------------- | ------------------------- |
| IPOIB_LOAD      | yes/no           | 加载 IPoIB 模块           |
| SRP_LOAD        | yes/no           | 加载 SRP initiator  模块  |
| SRPT_LOAD       | yes/no           | 加载 SRP target  模块     |
| ISER_LOAD       | yes/no           | 加载 ISER initiator  模块 |
| FIXUP_MTRR_REGS | yes/no           | 修改系统 mtrr 寄存器      |

```bash
# 默认
$ cat /etc/rdma/rdma.conf
# Load IPoIB
IPOIB_LOAD=yes
# Load SRP (SCSI Remote Protocol initiator support) module
SRP_LOAD=yes
# Load SRPT (SCSI Remote Protocol target support) module
SRPT_LOAD=yes
# Load iSER (iSCSI over RDMA initiator support) module
ISER_LOAD=yes
# Load iSERT (iSCSI over RDMA target support) module
ISERT_LOAD=yes
# Load RDS (Reliable Datagram Service) network protocol
RDS_LOAD=no
# Load NFSoRDMA client transport module
XPRTRDMA_LOAD=yes
# Load NFSoRDMA server transport module
SVCRDMA_LOAD=no
# Load Tech Preview device driver modules
TECH_PREVIEW_LOAD=no
```

## 放宽内存限制

RDMA 通信要求固定计算机中的物理内存（意味着如果整个计算机上在可用内存上运行不足，则不允许内核将该内存交换到 paging file）。固定内存需要特权（privileged），为了允许除了 root 之外的用户运行大型 RDMA 程序，可能需要增加运行非 root 用户在系统中固定的内存量。

```bash
# 退出重新登录即生效
$ vi /etc/security/limits.d/rdma.conf
* soft memlock unlimited
* hard memlock unlimited
```

```bash
# 立即生效
$ ulimit -l unlimited
```

## 参考

* [Implementing RDMA on Linux](https://lenovopress.com/lp0823.pdf)
* [Getting Started with InfiniBand](https://people.redhat.com/dledford/infiniband_get_started.html)
* [INFINIBAND AND RDMA RELATED SOFTWARE PACKAGES](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-infiniband_and_rdma_related_software_packages)
* [CONFIGURE IPOIB USING THE COMMAND LINE](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configure_ipoib_using_the_command_line)