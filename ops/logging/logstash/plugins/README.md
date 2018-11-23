# Logstash 插件

## 内置插件

```bash
$ bin/logstash-plugin list
logstash-codec-cef
logstash-codec-collectd
logstash-codec-dots
logstash-codec-edn
logstash-codec-edn_lines
logstash-codec-es_bulk
logstash-codec-fluent
logstash-codec-graphite
logstash-codec-json # -_-
logstash-codec-json_lines
logstash-codec-line
logstash-codec-msgpack
logstash-codec-multiline
logstash-codec-netflow
logstash-codec-plain
logstash-codec-rubydebug
logstash-filter-aggregate
logstash-filter-anonymize
logstash-filter-cidr
logstash-filter-clone
logstash-filter-csv
logstash-filter-date
logstash-filter-de_dot
logstash-filter-dissect
logstash-filter-dns # -_-
logstash-filter-drop
logstash-filter-elasticsearch
logstash-filter-fingerprint
logstash-filter-geoip
logstash-filter-grok # -_-
logstash-filter-jdbc_static
logstash-filter-jdbc_streaming
logstash-filter-json
logstash-filter-kv
logstash-filter-metrics
logstash-filter-mutate
logstash-filter-ruby
logstash-filter-sleep
logstash-filter-split
logstash-filter-syslog_pri
logstash-filter-throttle
logstash-filter-translate
logstash-filter-truncate
logstash-filter-urldecode
logstash-filter-useragent
logstash-filter-xml
logstash-input-azure_event_hubs
logstash-input-beats # -_-
logstash-input-dead_letter_queue
logstash-input-elasticsearch
logstash-input-exec
logstash-input-file # -_-
logstash-input-ganglia
logstash-input-gelf
logstash-input-generator
logstash-input-graphite
logstash-input-heartbeat
logstash-input-http
logstash-input-http_poller
logstash-input-imap
logstash-input-jdbc
logstash-input-kafka # -_-
logstash-input-pipe
logstash-input-rabbitmq
logstash-input-redis # -_-
logstash-input-s3
logstash-input-snmp
logstash-input-snmptrap
logstash-input-sqs
logstash-input-stdin
logstash-input-syslog
logstash-input-tcp
logstash-input-twitter
logstash-input-udp
logstash-input-unix
logstash-output-cloudwatch
logstash-output-csv
logstash-output-elastic_app_search
logstash-output-elasticsearch # -_-
logstash-output-email
logstash-output-file # -_-
logstash-output-graphite
logstash-output-http
logstash-output-kafka
logstash-output-lumberjack
logstash-output-nagios
logstash-output-null
logstash-output-pagerduty
logstash-output-pipe
logstash-output-rabbitmq
logstash-output-redis
logstash-output-s3 # -_-
logstash-output-sns
logstash-output-sqs
logstash-output-stdout
logstash-output-tcp
logstash-output-udp
logstash-output-webhdfs
logstash-patterns-core
```