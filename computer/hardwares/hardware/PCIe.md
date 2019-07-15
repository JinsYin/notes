# PCI Express（PCI-E）

## 插槽（slot）和通道（lane）

PCI Express slots on the motherboard can be wider then the number of lanes connected. For example a motherboard can have x8 slot with only x1 lane connected.

检查插入的 PCIe 卡的通道是多少，以及连接的主板 PCIe 总线的插槽是多少：

检查 PCIe 卡的通道数，以及对应的主板 PCIe 总线的插槽数：

```bash
# lspci | grep Mellanox
$ lspci -s 82:00.0 -vvv | grep -E 'LnkCap:|LnkSta:' | grep 'Width'
LnkCap: Port #8, Speed 5GT/s, Width x8, ASPM L0s, Exit Latency L0s unlimited, L1 unlimited
LnkSta: Speed 5GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
```

LnkCap (Link Capacity) - 表明主板 PCIe 总线速率为 `5GT/s`（即 `PCIe 2.0` 原始速率），插槽数为 `x8`
LnkSta (Link State) - 表明 PCIe 卡速率为 `5GT/s`（即 `PCIe 2.0` 原始速率），通道数为 `x8`

## 总线性能

| PCI-E 版本 | 原始速率      | ×1 带宽          | ×4 带宽           | ×8 带宽           | ×16 带宽          |
| ---------- | ------------- | ---------------- | ----------------- | ----------------- | ----------------- |
| 1.0 (gen1) | 2.5 GT/s      | 250 MB/s         | 1 GB/s            | 2 GB/s            | 4 GB/s            |
| 2.0 (gen2) | 5 GT/s        | 500 MB/s         | 2 GB/s            | 4 GB/s            | 8 GB/s            |
| 3.0 (gen3) | 8 GT/s        | 984.6 MB/s       | 3.938 GB/s        | 7.877 GB/s        | 15.754 GB/s       |
| 4.0 (gen4) | 16 GT/s       | 1.969 GB/s       | 7.877 GB/s        | 15.754 GB/s       | 31.508 GB/s       |
| 5.0 (gen5) | 32 or 25 GT/s | 3.9 or 3.08 GB/s | 15.8 or 12.3 GB/s | 31.5 or 24.6 GB/s | 63.0 or 49.2 GB/s |

## 参考

* [维基百科 - PCI Express](https://zh.wikipedia.org/wiki/PCI_Express)