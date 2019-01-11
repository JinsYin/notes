# Elasticsearch 入门

## 安装

```bash
ELASTIC_VERSION="6.5.0"

curl -L https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTIC_VERSION}.rpm -o /tmp/elasticsearch.rpm

rpm -ivh /tmp/elasticsearch.rpm && rm -f /tmp/elasticsearch.rpm
```

默认路径：

* home - `/usr/share/elasticsearch`
* bin - `/usr/share/elasticsearch/bin`
* config - `/etc/elasticsearch`
* data - `/var/lib/elasticsearch`
* logs - `/var/log/elasticsearch`

## 运行（单机）

* 配置

```bash
sed -i 's|#network.host.*|network.host: 192.168.10.160|g' /etc/elasticsearch/elasticsearch.yml # 0.0.0.0
sed -i 's|#http.port.*|http.port: 9200|g' /etc/elasticsearch/elasticsearch.yml
```

<!--
设置密码：

```bash
$ bin/elasticsearch-setup-passwords interactive
``` -->

* 启动

```bash
systemctl enable elasticsearch
systemctl start elasticsearch
systemctl status elasticsearch # 状态
journalctl -f -u elasticsearch # 日志
```

## 验证

* HTTP GET

```bash
$ curl http://192.168.10.160:9200
{
  "name" : "BwbAcqQ",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "nDwQpmE7RSeoSL32eXIIdw",
  "version" : {
    "number" : "6.5.0",
    "build_flavor" : "default",
    "build_type" : "rpm",
    "build_hash" : "816e6f6",
    "build_date" : "2018-11-09T18:58:36.352602Z",
    "build_snapshot" : false,
    "lucene_version" : "7.5.0",
    "minimum_wire_compatibility_version" : "5.6.0",
    "minimum_index_compatibility_version" : "5.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

* SQL

```sql
$ bin/elasticsearch-sql-cli http://192.168.10.160:9200
sql> SHOW TABLES;
         name          |     type
-----------------------+---------------
.kibana                |ALIAS
.kibana_1              |BASE TABLE
kibana_sample_data_logs|BASE TABLE
```