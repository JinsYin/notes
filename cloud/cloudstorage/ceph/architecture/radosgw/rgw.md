# rgw

## 资源池

特定于区域的 Pool 名称遵循命名约定：`{zone-name}.pool-name`。

| Pool               | 功能                |
| ------------------ | ------------------- |
| .rgw.root          | region 和 zone 信息 |
| .rgw.control       | 存放 notify 信息    |
| .rgw.log           | 存放日志            |
| .rgw.buckets.index | 存放元数据信息      |
| .rgw.buckets.data  | 存放数据            |