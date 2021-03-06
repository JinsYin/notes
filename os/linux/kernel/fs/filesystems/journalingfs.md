# 日志文件系统

## 设计模式

| 设计模式           | 描述                                                   | 优缺点                                                                       | 奔溃场景                             |
| ------------------ | ------------------------------------------------------ | ---------------------------------------------------------------------------- | ------------------------------------ |
| writeback          | 只有元数据被记录到日志，而数据写入磁盘文件系统         | 保证了元数据的一致性，但可能导致数据丢失                                     | 元数据写入之后、数据写入之前系统奔溃 |
| ordered            | 只将元数据记录到日志，前提是数据已经写入了磁盘文件系统 | 可以保证系统奔溃后日志和文件系统的一致性，缺点是不能最大限度地保证数据不丢失 | 数据写入之后、元数据写入之前系统奔溃 |
| data（writeahead） | 将元数据和数据都记录到日志                             | 可以最大限度地防止数据丢失，但由于数据写入了两次，性能下降                   |                                      |

## 日志提交策略

| 日志提交策略 | 描述                                                     |
| ------------ | -------------------------------------------------------- |
| 超时提交     | 当规定时间到达后，自动同步日志数据到存储设备             |
| 满时提交     | 当日志存储空间达到一定上限后，自动同步日志数据到存储设备 |

主流日志文件系统一般会同时启用这两种策略，以最大程度地保证数据安全和一致性。
