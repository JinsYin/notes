# logstash-filter-dns

## 配置

```json
filter {
    dns {
        add_field => {"hostname" => "%{host}"}
        action => "replace"
        reverse => ["hostname"]
        add_tag => ["dns_lookup"]
    }
}
```
