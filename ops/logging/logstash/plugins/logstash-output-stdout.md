# logstash-output-stdout

## 配置

```json
output {
  stdout {
    codec => rubydebug { metadata => true }
  }
}
```