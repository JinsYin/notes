# Cassandra exporter

## 安装

```sh
CASSANDRA_EXPORTER_VERSION="2.0.3"

mkdir -p /etc/prometheus_exporter/cassandra_exporter
mkdir -p /var/lib/prometheus_exporter/cassandra_exporter

curl -L https://raw.githubusercontent.com/criteo/cassandra_exporter/master/config.yml -o /etc/prometheus_exporter/cassandra_exporter/config.yaml

curl -L https://github.com/criteo/cassandra_exporter/releases/download/${CASSANDRA_EXPORTER_VERSION}/cassandra_exporter-${CASSANDRA_EXPORTER_VERSION}-all.jar -o /var/lib/prometheus_exporter/cassandra_exporter/cassandra_exporter-${CASSANDRA_EXPORTER_VERSION}-all.jar

ln -s /var/lib/prometheus_exporter/cassandra_exporter/cassandra_exporter-${CASSANDRA_EXPORTER_VERSION}-all.jar /var/lib/prometheus_exporter/cassandra_exporter/cassandra_exporter.jar
```

## 运行

```ini
$ cat <<EOF > /etc/systemd/system/cassandra_exporter.service
[Unit]
Description=Node Exporter

[Service]
ExecStart=/usr/bin/java -jar /var/lib/prometheus_exporter/cassandra_exporter/cassandra_exporter.jar \
    /etc/prometheus_exporter/cassandra_exporter/config.yaml

[Install]
WantedBy=multi-user.target
EOF
```

```sh
systemctl daemon-reload
systemctl enable cassandra_exporter
systemctl start cassandra_exporter
systemctl status cassandra_exporter
```

```sh
curl -L http://localhost:8080
```

## Grafana dashboard

## 参考

* [github.com/criteo/cassandra_exporter](https://github.com/criteo/cassandra_exporter)
