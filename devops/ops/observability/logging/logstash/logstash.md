# Logstash

当前架构中，Logstash 用作日志处理。

## 安装

```sh
ELASTIC_VERSION="6.5.0"

curl -L https://artifacts.elastic.co/downloads/logstash/logstash-${ELASTIC_VERSION}.rpm -o /tmp/logstash.rpm

rpm -ivh /tmp/logstash.rpm

rm -f /tmp/logstash.rpm
```

默认路径：

* home - `/usr/share/logstash`
* bin - `/usr/share/logstash/bin`
* config - `/etc/logstash`
* data - `/var/lib/logstash`
* logs - `/var/log/logstash`

## 运行

```sh
systemctl enable logstash
systemctl start logstash
systemctl status logstash # 状态
journalctl -f -u logstash # 日志
```

## 配置

```json
$ vi /etc/logstash/conf.d/kafka_logstash.conf
input {
    kafka: {
        bootstrap_servers: ["192.168.10.199:9092"]
    },
    group_id: "logstash",
    topic: "cassandra",
}
```