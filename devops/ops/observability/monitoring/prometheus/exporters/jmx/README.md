# JMX exporter

## Cassandra

```bash
mkdir -p /etc/prometheus/jmx_exporter

cd /etc/prometheus/jmx_exporter

curl -OL https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.3.0/jmx_prometheus_javaagent-0.3.0.jar

curl -OL https://raw.githubusercontent.com/prometheus/jmx_exporter/master/example_configs/cassandra.yml

echo "JVM_OPTS=\"\$JVM_OPTS -javaagent:$PWD/jmx_prometheus_javaagent-0.3.0.jar=7070:$PWD/cassandra.yml\"" >> /etc/cassandra/conf/cassandra-env.sh
```

```bash
$ cat cassandra.yaml
lowercaseOutputName: true
lowercaseOutputLabelNames: true
whitelistObjectNames: [
"org.apache.cassandra.metrics:type=ColumnFamily,name=RangeLatency,*",
"org.apache.cassandra.metrics:type=ColumnFamily,name=LiveSSTableCount,*",
"org.apache.cassandra.metrics:type=ColumnFamily,name=SSTablesPerReadHistogram,*",
"org.apache.cassandra.metrics:type=ColumnFamily,name=SpeculativeRetries,*",
"org.apache.cassandra.metrics:type=ColumnFamily,name=MemtableOnHeapSize,*",
"org.apache.cassandra.metrics:type=ColumnFamily,name=MemtableSwitchCount,*",
"org.apache.cassandra.metrics:type=ColumnFamily,name=MemtableLiveDataSize,*",
"org.apache.cassandra.metrics:type=ColumnFamily,name=MemtableColumnsCount,*",
"org.apache.cassandra.metrics:type=ColumnFamily,name=MemtableOffHeapSize,*",
"org.apache.cassandra.metrics:type=ColumnFamily,name=BloomFilterFalsePositives,*",
"org.apache.cassandra.metrics:type=ColumnFamily,name=BloomFilterFalseRatio,*",
"org.apache.cassandra.metrics:type=ColumnFamily,name=BloomFilterDiskSpaceUsed,*",
"org.apache.cassandra.metrics:type=ColumnFamily,name=BloomFilterOffHeapMemoryUsed,*",
"org.apache.cassandra.metrics:type=ColumnFamily,name=SnapshotsSize,*",
"org.apache.cassandra.metrics:type=ColumnFamily,name=TotalDiskSpaceUsed,*",
"org.apache.cassandra.metrics:type=CQL,name=RegularStatementsExecuted,*",
"org.apache.cassandra.metrics:type=CQL,name=PreparedStatementsExecuted,*",
"org.apache.cassandra.metrics:type=Compaction,name=PendingTasks,*",
"org.apache.cassandra.metrics:type=Compaction,name=CompletedTasks,*",
"org.apache.cassandra.metrics:type=Compaction,name=BytesCompacted,*",
"org.apache.cassandra.metrics:type=Compaction,name=TotalCompactionsCompleted,*",
"org.apache.cassandra.metrics:type=ClientRequest,name=Latency,*",
"org.apache.cassandra.metrics:type=ClientRequest,name=Unavailables,*",
"org.apache.cassandra.metrics:type=ClientRequest,name=Timeouts,*",
"org.apache.cassandra.metrics:type=Storage,name=Exceptions,*",
"org.apache.cassandra.metrics:type=Storage,name=TotalHints,*",
"org.apache.cassandra.metrics:type=Storage,name=TotalHintsInProgress,*",
"org.apache.cassandra.metrics:type=Storage,name=Load,*",
"org.apache.cassandra.metrics:type=Connection,name=TotalTimeouts,*",
"org.apache.cassandra.metrics:type=ThreadPools,name=CompletedTasks,*",
"org.apache.cassandra.metrics:type=ThreadPools,name=PendingTasks,*",
"org.apache.cassandra.metrics:type=ThreadPools,name=ActiveTasks,*",
"org.apache.cassandra.metrics:type=ThreadPools,name=TotalBlockedTasks,*",
"org.apache.cassandra.metrics:type=ThreadPools,name=CurrentlyBlockedTasks,*",
"org.apache.cassandra.metrics:type=DroppedMessage,name=Dropped,*",
"org.apache.cassandra.metrics:type=Cache,scope=KeyCache,name=HitRate,*",
"org.apache.cassandra.metrics:type=Cache,scope=KeyCache,name=Hits,*",
"org.apache.cassandra.metrics:type=Cache,scope=KeyCache,name=Requests,*",
"org.apache.cassandra.metrics:type=Cache,scope=KeyCache,name=Entries,*",
"org.apache.cassandra.metrics:type=Cache,scope=KeyCache,name=Size,*",
#"org.apache.cassandra.metrics:type=Streaming,name=TotalIncomingBytes,*",
#"org.apache.cassandra.metrics:type=Streaming,name=TotalOutgoingBytes,*",
"org.apache.cassandra.metrics:type=Client,name=connectedNativeClients,*",
"org.apache.cassandra.metrics:type=Client,name=connectedThriftClients,*",
"org.apache.cassandra.metrics:type=Table,name=WriteLatency,*",
"org.apache.cassandra.metrics:type=Table,name=ReadLatency,*",
"org.apache.cassandra.net:type=FailureDetector,*",
]
#blacklistObjectNames: ["org.apache.cassandra.metrics:type=ColumnFamily,*"]
rules:
  - pattern: org.apache.cassandra.metrics<type=(Connection|Streaming), scope=(\S*), name=(\S*)><>(Count|Value)
    name: cassandra_$1_$3
    labels:
      address: "$2"
  - pattern: org.apache.cassandra.metrics<type=(ColumnFamily), name=(RangeLatency)><>(Mean)
    name: cassandra_$1_$2_$3
  - pattern: org.apache.cassandra.net<type=(FailureDetector)><>(DownEndpointCount)
    name: cassandra_$1_$2
  - pattern: org.apache.cassandra.metrics<type=(Keyspace), keyspace=(\S*), name=(\S*)><>(Count|Mean|95thPercentile)
    name: cassandra_$1_$3_$4
    labels:
      "$1": "$2"
  - pattern: org.apache.cassandra.metrics<type=(Table), keyspace=(\S*), scope=(\S*), name=(\S*)><>(Count|Mean|95thPercentile)
    name: cassandra_$1_$4_$5
    labels:
      "keyspace": "$2"
      "table": "$3"
  - pattern: org.apache.cassandra.metrics<type=(ClientRequest), scope=(\S*), name=(\S*)><>(Count|Mean|95thPercentile)
    name: cassandra_$1_$3_$4
    labels:
      "type": "$2"
  - pattern: org.apache.cassandra.metrics<type=(\S*)(?:, ((?!scope)\S*)=(\S*))?(?:, scope=(\S*))?,
      name=(\S*)><>(Count|Value)
    name: cassandra_$1_$5
    labels:
      "$1": "$4"
      "$2": "$3"
```

```bash
systemctl daemon-reload
systemctl enable cassandra
systemctl start cassandra
systemctl status cassandra
```

```bash
netstat -tpln | grep 7070
```

注：实际测试发现，在大集群上 `:7070` 压根打不开，或者加载特别慢

## Grafana dashboard

* [5408](https://grafana.com/dashboards/5408)

## 参考

* [Monitoring Cassandra with Prometheus](https://www.robustperception.io/monitoring-cassandra-with-prometheus)