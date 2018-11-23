# Node exporter

## 防火墙

```bash
systemctl stop firewalld
systemctl disable firewalld
```

## 安装

```bash
NODE_EXPORTER_VERSION="0.16.0"

rm -rf /tmp/node_exporter* && mkdir -p /tmp/node_exporter

curl -L https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz -o /tmp/node_exporter.tar.gz

tar -zxf /tmp/node_exporter.tar.gz -C /tmp/node_exporter --strip-component=1

cp /tmp/node_exporter/node_exporter /usr/local/bin/

chmod +x /usr/local/bin/node_exporter
```

## 运行

* 配置

```ini
$ cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter

[Service]
EnvironmentFile=/etc/sysconfig/node_exporter
ExecStart=/usr/local/bin/node_exporter $OPTIONS

[Install]
WantedBy=multi-user.target
EOF
```

```bash
$ cat <<EOF > /etc/sysconfig/node_exporter
OPTIONS="--collector.textfile.directory /var/lib/node_exporter/textfile_collector"
EOF
```

```bash
chmod 664 /etc/systemd/system/node_exporter.service
mkdir -p /var/lib/node_exporter/textfile_collector
```

* 启动

```bash
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
systemctl status node_exporter
```

* 验证

```bash
$ netstat -tpln | grep 9100
tcp6    0   0   :::9100     :::*    LISTEN      11882/node_exporter
```

```bash
$ curl http://localhost:9100/metrics
go_gc_duration_seconds{quantile="0"} 0.000198341
...
```