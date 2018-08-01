# Cassandra 导入数据

## CQL COPY

* 文件格式

```bash
$ head examples/ais.csv -n 2
235103214,1472745528,0,248,0,2955492.000000,51531425.000000,1384229,3498,0.514444,16350,17800,,,1200&0.1&&&&
244630015,1472745528,0,248,5,4528250.000000,51230048.000000,1395045,3292,0.514444,29840,51100,,,0&0.1&&&&
```

* Schema

```sql
cqlsh> CREATE KEYSPACE myspace WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 2};
cqlsh>
cqlsh> CREATE TABLE myspace.mytable()
```

* COPY

```sql
cqlsh> COPY myspace.mytable(unique_id,acquisition_time,target_type,data_source,data_supplier,status,longitude,latitude,area_id,speed,conversion,cog,true_head,power,ext,extend) FROM '/data/ais.csv'
```

## BulkLoad

```bash
$ cqlsh -f schema.cql
```

```bash
$ sstableloader -d <node-ip> data/quote/historical_prices
```

## 参考

* [Import csv to cassandra](http://blog.sws9f.org/nosql/2016/02/11/import-csv-to-cassandra.html)
* [cassandra-bulkload-example](https://github.com/yukim/cassandra-bulkload-example)
* [cassandra-data-loader](https://github.com/larrysu1115/cassandra-data-loader)