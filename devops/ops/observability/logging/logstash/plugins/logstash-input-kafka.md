# logstash-input-kafka

## 配置

```json
input {
    kafka {
        bootstrap_servers => "localhost:9092" # Kafka Broker 逗号分隔列表
        topics => ["mytopic"] # 默认值是 logstash
        consumer_threads => 1
    }
}
```

## 参考

* [Kafka input plugin](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-kafka.html)