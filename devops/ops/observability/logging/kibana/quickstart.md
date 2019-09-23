# Kibana 入门

## 安装

```sh
ELASTIC_VERSION="6.5.0"

curl -L https://artifacts.elastic.co/downloads/kibana/kibana-${ELASTIC_VERSION}-x86_64.rpm -o /tmp/kibana.rpm

rpm -ivh /tmp/kibana.rpm && rm -f /tmp/kibana.rpm
```

默认路径：

* home - `/usr/share/kibana`
* bin - `/usr/share/kibana/bin`
* config - `/etc/kibana`
* data - `/var/lib/kibana`
* logs - `/var/log/kibana`

## 运行

* 修改配置

```sh
# 服务端口
sed -i "s|#server.port: 5601|server.port: 5601|g" /etc/kibana/kibana.yml

# 监听的网络接口（0.0.0.0）
sed -i 's|#server.host: "localhost"|server.host: "192.168.10.160"|g' /etc/kibana/kibana.yml

# 配置需要连接的 Elasticsearch 实例
sed -i 's|#elasticsearch.url.*|elasticsearch.url: "http://192.168.10.160:9200"|g' /etc/kibana/kibana.yml
```

* 启动服务

（需要先运行 Elaticsearch）

```sh
systemctl enable kibana
systemctl start kibana
systemctl status kibana # 状态
journalctl -f -u kibana # 日志
```

验证：

```sh
# 正常情况响应为空，否则响应 "Kibana server is not ready yet"
$ curl http://192.168.10.160:5601
```
