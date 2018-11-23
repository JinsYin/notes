# logstash-output-elasticsearch

## 配置

```json
$ vi /etc/logstash/conf.d/pipeline.conf
output {
  elasticsearch {
    hosts => ["http://localhost:9200"]
    index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
    ssl => false
    #user => "elastic"
    #password => "changeme"
  }
}
```

## 参考

* [Elasticsearch output plugin](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-elasticsearch.html)