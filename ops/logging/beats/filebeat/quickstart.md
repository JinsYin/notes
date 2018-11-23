# Filebeat

Filebeat 是一个轻量级的开源日志文件数据收集器。在需要采集日志数据的服务器上安装好 Filebeat，并指定日志目录或日志文件后，Filebeat 会按行读取日志数据。

## 安装

```bash
ELASTIC_VERSION="6.5.0"

curl -L https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${ELASTIC_VERSION}-x86_64.rpm -o /tmp/filebeat.rpm

rpm -ivh /tmp/filebeat.rpm

rm -f /tmp/filebeat.rpm
```

默认路径：

* home - `/usr/share/filebeat`
* bin - `/usr/share/filebeat/bin`
* config - `/etc/filebeat`
* data - `/var/lib/filebeat`
* logs - `/var/log/filebeat`

## 运行

```bash
systemctl enable filebeat
systemctl start filebeat
systemctl status filebeat # 状态
journalctl -f -u filebeat # 日志
```

## Input types

* Log
* Stdin
* Redis
* UDP
* Docker
* TCP
* Syslog

## 消息格式

Filbeat 会将消息封装成一个 JSON 串，除了原始日志外，还包含一些其他信息：

```json
{  
    "@timestamp":"2018-11-19T01:29:35.495Z",
    "@metadata":{
        "beat":"filebeat",
        "type":"doc",
        "version":"6.5.0",
        "topic":"messages"
    },
    "beat":{
        "version":"6.5.0",
        "name":"ip-199.miner.ew",
        "hostname":"ip-199.miner.ew"
    },
    "source":"/var/log/messages",
    "offset":27882087,
    "message":"Nov 19 09:29:34 ip-199 ethminer: #033[32m  m  #033[35m09:29:34#033[0m#033[30m|#033[34methminer#033[0m  Speed #033[1;36m 31.19#033[0m Mh/s    gpu/0 #033[36m15.64#033[0m  gpu/1 #033[36m15.55#033[0m  [A3674+30:R1+0:F0] Time: 136:28#033[0m",
    "prospector":{
        "type":"log"
    },
    "input":{
        "type":"log"
    },
    "fields":{
        "log_topic":"messages"
    },
    "host":{
        "name":"ip-199.miner.ew"
    }
}
```

## 配置

```bash
$ vi /etc/filebeat/filebeat.yml
filebeat.inputs:
  - type: log
    enabled: true
    paths:
      - /var/log/messages* # 路径和文件名都支持通配符
      - /var/log/*.log
    fields:
      kafka_topic: "messages"
  - type: log
    enabled: true
    paths:
      - /var/log/cassandra/*.log
    fields:
      kafka_topic: "cassandra"

output.kafka:
  enabled: true
  hosts: ["192.168.10.199:9092"]
  topic: '%{[fields.kafka_topic]}' # 使用每个事件的动态 topic 名称
  codec.format:
    string: '%{[host.name]} -- %{[message]}'
  partition.round_robin:
    reachable_only: false
  required_acks: 1
  compression: gzip
  max_message_bytes: 1000000
```