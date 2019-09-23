# Grafana

## 经验总结

* 对于有些节点有数据，而有些节点没有数据的情况（比如 InfiniBand），不要采用 `Singlestat Panel`，最好采用 `Table Panel` 进行列举
* 短时间内没有变化或变化不大的数据（比如运行时间、内存容量），不要使用 `Graph Panel`，可以使用 `Singlestat Panel` 或 `Table Panel`
