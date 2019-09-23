# 部署 Prometheus

## 安装

```sh
PROMETHEUS_VERSION="2.2.1"

rm -rf /tmp/prometheus* && mkdir -p /tmp/prometheus

curl -L https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz -o /tmp/prometheus.tar.gz

tar -zxf /tmp/prometheus.tar.gz -C /tmp/prometheus --strip-component=1

mkdir -p /etc/prometheus
mkdir -p /var/lib/prometheus/data

cp -r /tmp/prometheus/console* /etc/prometheus
cp /tmp/prometheus/prometheus.yml /etc/prometheus/
cp /tmp/prometheus/{prometheus,promtool} /usr/local/bin/

chmod +x /usr/local/bin/{prometheus,promtool}

rm -rf /tmp/prometheus*
```

## 运行

```sh
$ cat <<EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/
Wants=network-online.target
After=network-online.target

[Service]
Restart=on-failure
ExecStart=/usr/local/bin/prometheus \
    --storage.tsdb.path=/var/lib/prometheus \
    --config.file=/etc/prometheus/prometheus.yml \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF
```

```sh
systemctl daemon-reload
systemctl enable prometheus
systemctl start prometheus
systemctl status prometheus
```

```sh
# 验证
$ curl -L http://localhost:9090
```

## 重新加载配置

Prometheus 支持在运行时重新加载配置（`/etc/prometheus/prometheus.yml`），且如果格式不正确是不会被应用的。支持两种方式：

```sh
# 1. 发送 SIGHUP 给 Prometheus 进程
$ killall -HUP prometheus

# 2. 发送 HTTP POST 给 /-/reload 路由（Prometheus 进程需要启用 --web.enable-lifecycle）
$ curl -s -XPOST localhost:9090/-/reload
```
