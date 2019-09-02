# 中断处理程序（Interrupt Handler）

内核响应一个特定中断时所执行的函数称之为 _中断处理程序（interrupt handler）_ 或 _中断服务例程（interrupt service routine，ISR）_。设备的中断处理程序是其驱动程序的一部分 —— 设备驱动程序是用于管理设备的内核代码。

中断随时可能发送，因此中断处理程序也就随时可能执行，所以必须保存中断处理程序能够快速执行，才能保证尽可能快地恢复中断代码的执行。

中断处理程序除了要应答硬件设备 “已接收到中断” 外，往往还要完成大量其他工作。以网络设备的中断处理程序为例，其除了要对硬件应答，还要把来自网卡的网络数据包拷贝到内存，对其进行处理后在交给合适的协议栈或应用程序。

## 上半部与下半部

既希望中断处理程序运行得快，又希望中断处理程序完成的工作量多，显然这两个目的是矛盾的。鉴于两个目的的矛盾关系，我们将中断处理分为两个部分。

* 中断处理程序是上半部（top half） - 接收到一个中断，立即开始执行，但只做有严格时限的工作，例如对接收的中断进行应答会复位硬件
* 能够被允许稍后完成的工作会推迟到下半部（bottom half）

## 下半部

## 注册中断处理程序




## 示例

```sh
$ cat /porc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:         21          0          0          0   IO-APIC   2-edge      timer
  1:          3          0          0          0   IO-APIC   1-edge      i8042
  4:          1          0          0          0   IO-APIC   4-edge
  8:          1          0          0          0   IO-APIC   8-edge      rtc0
  9:          0          0          0          0   IO-APIC   9-fasteoi   acpi
 12:          4          0          0          0   IO-APIC  12-edge      i8042
 16:         29          0          0          0   IO-APIC  16-fasteoi   ehci_hcd:usb1
 17:       1007          0          0          0   IO-APIC  17-fasteoi   snd_hda_intel
 23:         33          0          0          0   IO-APIC  23-fasteoi   ehci_hcd:usb2
 25:     452479          0       5718        824   PCI-MSI 327680-edge      xhci_hcd
 26:     370514     178090     218449     443904   PCI-MSI 512000-edge      0000:00:1f.2
 27:        582          0          0    3900537   PCI-MSI 409600-edge      eth1
 28:         24          0          0          0   PCI-MSI 360448-edge      mei_me
 29:        403          0          0          0   PCI-MSI 442368-edge      snd_hda_intel
 30:   17498210          0          0          0   PCI-MSI 524288-edge      nvkm
NMI:       2888       2769       2787       2813   Non-maskable interrupts
LOC:   33566391   33690381   33662034   33522003   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:       2888       2769       2787       2813   Performance monitoring interrupts
IWI:          0          0          0          1   IRQ work interrupts
RTR:          0          0          0          0   APIC ICR read retries
RES:    3524101    2974412    2861750    2439303   Rescheduling interrupts
CAL:    1007675     932491     935047     981101   Function call interrupts
TLB:     988799     930528     933125     979099   TLB shootdowns
TRM:        149        149        149        149   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
DFR:          0          0          0          0   Deferred Error APIC interrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:        304        304        304        304   Machine check polls
ERR:          0
MIS:          0
PIN:          0          0          0          0   Posted-interrupt notification event
PIW:          0          0          0          0   Posted-interrupt wakeup event
```