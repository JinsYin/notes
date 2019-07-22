# 文件 I/O

* 【4】通用的 I/O 模型
* 【5】深入探究文件 I/O
* 【13】文件 I/O 缓冲

| Characteristic         | R/W       | mmap      | DIO      | AIO/DIO |
| ---------------------- | --------- | --------- | -------- | ------- |
| Cache control          | kernel    | kernel    | user     | user    |
| Copying                | yes       | no        | no       | no      |
| MMU activity           | low       | high      | none     | none    |
| I/O scheduling         | kernel    | kernel    | mixed    | user    |
| Thread scheduling      | kernel    | kernel    | kernel   | user    |
| I/O alignment          | automatic | automatic | manual   | manual  |
| Application complexity | low       | low       | moderate | high    |

## 参考

* [Different I/O Access Methods for Linux, What We Chose for Scylla, and Why](https://www.scylladb.com/2017/10/05/io-access-methods-scylla/)