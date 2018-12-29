# 指标

| Metrics                     | 含义                               |
| --------------------------- | ---------------------------------- |
| node_filesystem_avail_bytes | 非 root 用户可以使用的文件系统空间 |
| node_filesystem_free_bytes  | root 用户可以使用的文件系统空间    |

```latex
available = free - reserved filesystem blocks(for root)
```

## 参考

* [Free space vs Available Space](https://github.com/prometheus/node_exporter/issues/269)