# logstash-filter-date

## 配置

```json
filter {
    date {
        match => [ "timestamp" , "dd/MMM/yyyy:HH:mm:ss Z" ]
    }
}
```