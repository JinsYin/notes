# iptables

## 内核模块

Different kernel modules and programs are currently used for different protocols:

* ip_tables(IPV4)
* ip6_tables(IPV6)
* arp_tables(ARP)
* ebtables(Ethernet frames)

They provide a table-based system for defining firewall rules that can filter or transform packets

## chains of rules

Rules are organized into chains, or in other words, "chains of rules".These chains are named with predefined titles, including `INPUT`, `OUTPUT` and `FORWARD`.

Packet reception falls into `PREROUTING`, while the `INPUT` represents locally delivered data, and forwarded traffic falls into the `FORWARD` chain. Locally generated output passes through the OUTPUT chain, and packets to be sent out are in `POSTROUTING` chain.

## 参考

* [Netfilter](https://en.wikipedia.org/wiki/Netfilter)
* [Iptables](https://en.wikipedia.org/wiki/Iptables)