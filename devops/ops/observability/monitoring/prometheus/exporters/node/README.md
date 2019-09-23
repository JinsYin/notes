# Node exporter

## 防火墙

```sh
systemctl stop firewalld
systemctl disable firewalld
```

## 安装

```sh
NODE_EXPORTER_VERSION="0.17.0"

rm -rf /tmp/node-exporter* && mkdir -p /tmp/node-exporter

curl -L https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz -o /tmp/node-exporter.tar.gz

tar -zxf /tmp/node-exporter.tar.gz -C /tmp/node-exporter --strip-component=1

cp /tmp/node-exporter/node_exporter /usr/local/bin/node-exporter

chmod +x /usr/local/bin/node-exporter
```

## 运行

* 配置

```ini
$ cat <<EOF > /etc/systemd/system/node-exporter.service
[Unit]
Description=Node Exporter

[Service]
EnvironmentFile=/etc/sysconfig/node-exporter
ExecStart=/usr/local/bin/node-exporter $OPTIONS

[Install]
WantedBy=multi-user.target
EOF
```

```sh
$ cat <<EOF > /etc/sysconfig/node-exporter
OPTIONS="--collector.textfile.directory /var/lib/node-exporter/textfile-collector"
EOF
```

```sh
chmod 664 /etc/systemd/system/node-exporter.service
mkdir -p /var/lib/node-exporter/textfile-collector
```

* 启动

```sh
systemctl daemon-reload
systemctl enable node-exporter
systemctl start node-exporter
systemctl status node-exporter
```

* 验证

```sh
$ netstat -tpln | grep 9100
tcp6    0   0   :::9100     :::*    LISTEN      11882/node_exporter
```

```sh
$ curl http://localhost:9100/metrics
go_gc_duration_seconds{quantile="0"} 0.000198341
...
```
