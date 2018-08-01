# Cassandra 压力测试

```bash
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