# KafkaMultiTopics

多个 topic 的落盘测试


## 集群信息

集群   | 主机
----- | -----
spark | 192.168.1.121 192.168.1.122 192.168.1.124 192.168.1.126
kafka | 192.168.1.121 192.168.1.122 192.168.1.126


## 使用指南

第一步：进入文件夹 cd /tmp/spark-submit/multiTopics
第二步：更改 topics.txt 设置需要消费的 topic，每一行是一个 topic
第三步：执行./submit-multi-topics-collect.sh
要是做测试的话，可以采用 MultiTopicsTest.java 发送多 topic 的数据


## 注意事项

由于 kafkaMultiTopics 会不断执行，因而当程序启动后，就会一直在后台执行。具体的执行记录会被写入到 nohup.out 里面。

停止进程：

```bash
$ kill $(ps -ef | grep spark-submit)
```
