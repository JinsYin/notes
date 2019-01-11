# Packetbeat 入门

## 安装

```bash
ELASTIC_VERSION="6.5.0"

yum install -y libpcap

curl -L https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-${ELASTIC_VERSION}-x86_64.rpm -o /tmp/packetbeat.rpm

rpm -ivh /tmp/packetbeat.rpm

rm -f /tmp/packetbeat.rpm
```

默认路径：

* home - `/usr/share/packetbeat`
* bin - `/usr/share/packetbeat/bin`
* config - `/etc/packetbeat`
* data - `/var/lib/packetbeat`
* logs - `/var/log/packetbeat`

## 运行

* 配置（监控 Cassandra）

```yaml
# 备份
$ mv /etc/packetbeat/{packetbeat.yml,packetbeat.yml.bat}

$ vi /etc/packetbeat/packetbeat.yml
packetbeat.interfaces.device: any
packetbeat.protocols:
- type: cassandra
  ports: [9042]
  #ignored_ops: ["RESULT"]
setup.dashboards.enabled: true
setup.kibana:
  host: "192.168.10.160:5601"
  #username: "kibana"
  #password: "kibana"
output.elasticsearch:
  hosts: ["192.168.10.160:9200"]
  #username: "elastic"
  #password: "elastic"
```

* 启动

```bash
systemctl enable packetbeat
systemctl start packetbeat
systemctl status packetbeat # 状态
journalctl -f -u packetbeat # 日志
```

* 验证

```bash
# Packetbeat 会把数据发送到 Elasticsearch
$ curl http://192.168.10.160:9200/packetbeat*/_search?pretty
```

```sql
$ bin/elasticsearch-sql-cli http://192.168.10.160:9200
sql> SHOW TABLES;
                         name                          |     type
-------------------------------------------------------+---------------
.kibana                                                |ALIAS
.kibana_1                                              |BASE TABLE
packetbeat-6.5.0-2018.11.21                            |BASE TABLE
```

## Kibana dashboard

Packetbeat 为常见协议准备了一些 Dashboard，可以直接导入到 Kibana 里面使用。

http://192.168.10.160:5601/app/kibana#/dashboards?_g=()