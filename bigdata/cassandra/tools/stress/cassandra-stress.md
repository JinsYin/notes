# Cassandra 压力测试

```sh
$ cassandra-stress help
Usage:      cassandra-stress <command> [options]
Help usage: cassandra-stress help <command>

---Commands---
read                 : Multiple concurrent reads - the cluster must first be populated by a write test
write                : Multiple concurrent writes against the cluster
mixed                : Interleaving of any basic commands, with configurable ratio and distribution - the cluster must first be populated by a write test
counter_write        : Multiple concurrent updates of counters.
counter_read         : Multiple concurrent reads of counters. The cluster must first be populated by a counterwrite test.
user                 : Interleaving of user provided queries, with configurable ratio and distribution
help                 : Print help for a command or option
print                : Inspect the output of a distribution definition
legacy               : Legacy support mode

---Options---
-pop                  : Population distribution and intra-partition visit order
-insert               : Insert specific options relating to various methods for batching and splitting partition updates
-col                  : Column details such as size and count distribution, data generator, names, comparator and if super columns should be used
-rate                 : Thread count, rate limit or automatic mode (default is auto)
-mode                 : Thrift or CQL with options
-errors               : How to handle errors when encountered during stress
-sample               : Specify the number of samples to collect for measuring latency
-schema               : Replication settings, compression, compaction, etc.
-node                 : Nodes to connect to
-log                  : Where to log progress to, and the interval at which to do it
-transport            : Custom transport factories
-port                 : The port to connect to cassandra nodes on
-sendto               : Specify a stress server to send this command to
-tokenrange           : Token range settings
```

## 示例

以 `192.168.100.160` 为测试机：

* 写入 1 亿行

```sh
$ cassandra-stress write n=100000000 -node 192.168.100.200
Results:
op rate                   : 77697 [WRITE:77697]
partition rate            : 77697 [WRITE:77697]
row rate                  : 77697 [WRITE:77697]
latency mean              : 0.4 [WRITE:0.4]
latency median            : 0.3 [WRITE:0.3]
latency 95th percentile   : 0.5 [WRITE:0.5]
latency 99th percentile   : 0.6 [WRITE:0.6]
latency 99.9th percentile : 1.6 [WRITE:1.6]
latency max               : 151.3 [WRITE:151.3]
Total partitions          : 1000000 [WRITE:1000000]
Total errors              : 0 [WRITE:0]
total gc count            : 0
total gc mb               : 0
total gc time (s)         : 0
avg gc time(ms)           : NaN
stdev gc time(ms)         : 0
Total operation time      : 00:00:12
END
```

* 读取 1 亿行

```sh
$ cassandra-stress read n=100000000 -node 192.168.100.200
```

* 持续读取 10 分钟

```sh
$ cassandra-stress read duration=10m -node 192.168.100.200
```

* 持续写入 10 分钟

```sh
$ cassandra-stress write duration=10m -node 192.168.100.200
```

## 参考

* [Cassandra 压力测试](http://zqhxuyuan.github.io/2015/10/15/Cassandra-Stress/)