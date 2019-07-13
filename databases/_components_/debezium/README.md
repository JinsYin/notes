# Debezium

Debezium 是一个开源的 CDC（Change Data Capture） 分布式系统，旨在监听和捕获各种数据库的变化（增删改成），最终以流的方式统一发送到 Kafka 。

## CDC

CDC 即 Change Data Capture，译为 “变更数据捕获” 或 “变化数据捕获”，意思就是监听和捕获数据库的变更（增删改查等），并将变更数据按发生的顺序统一存储以供后续使用，比如写入消息中间件以供其他应用程序订阅和消费。

## 支持的数据库

* mongodb
* mysql
* postgres
* sqlserver

## 参考

* [Debezium](https://debezium.io)
* [github.com/debezium/debezium](https://github.com/debezium/debezium)
* [你知道 Change Data Capture 是什么吗？](https://farer.org/2018/07/27/change-data-capture/)