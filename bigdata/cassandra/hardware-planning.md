# 硬件规划

## 压力测试

为了确保硬件满足业务需求，可以使用 `cassandra-stress` 工具进行压力测试。

```bash
$ cassandra-stress help
```

## 磁盘空间

## 网络

建议最小带宽：1000Mb/s

## 防火墙

> <https://docs.datastax.com/en/dse/6.0/dse-admin/datastax_enterprise/security/secFirewallPorts.html#secFirewallPorts__firewall_table>

## 参考

* [Selecting hardware for DataStax Enterprise implementations](https://docs.datastax.com/en/dse-planning/doc/planning/planningHardware.html)
* [cassandra-stress tool](https://docs.datastax.com/en/dse/6.0/dse-admin/datastax_enterprise/tools/toolsCStress.html)