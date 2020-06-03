# 防火墙

## 公共端口

| 端口号 | 描述     |
| ------ | -------- |
| 22     | SSH 端口 |

## 节点间端口

| 端口号 | 描述                                |
| ------ | ----------------------------------- |
| 7000   | Cassandra 集群节点间通信的端口      |
| 7001   | Cassandra 集群节点间 SSL 通信的端口 |
| 7199   | Cassandra JMX 监控端口              |

## 客户端端口

| 端口号 | 描述                                                                 |
| ------ | -------------------------------------------------------------------- |
| 9042   | Cassandra 客户端端口                                                 |
| 9160   | Cassandra 客户端端口（Thrift）                                       |
| 9142   | `native_transport_port_ssl` 的默认值，在需要加密和未加密连接时很有用 |

## 参考

* [Configuring firewall port access](https://docs.datastax.com/en/ddacsecurity/doc/ddacsecurity/secureFireWall.html)
