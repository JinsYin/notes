# PostgreSQL

## 特征

* NoSQL:
  * JSON
  * JSONB
  * XML
  * HStore
  * 外部数据包装器
* 数据类型：包括文本、任意精度的数值数组、JSON 数据、枚举类型、XML 数据
* 数据仓库：能平滑迁移至同属 PostgreSQL 生态的 GreenPlum，DeepGreen，HAWK 等，使用 FDW 进行 ETL。

## 数据类型

### 货币类型

| 类型    | 大小(B) | 描述     |
| ------- | ------- | -------- |
| `money` | 8       | 货币金额 |

### 几何类型

| 类型      | 大小(B) | 描述                   | 示例              |
| --------- | ------- | ---------------------- |
| `point`   | 16      | 二维点                 | (x,y)             |
| `line`    | 32      | 直线（无限）           | ((x1,y1),(x2,y2)) |
| `lseg`    | 32      | 线段（有限）           | ((x1,y1),(x2,y2)) |
| `box`     | 32      | 矩阵                   | ((x1,y1),(x2,y2)) |
| `path`    | 16+16n  | 闭合路径（类似多边形） | ((x1,y1),...)     |
| `path`    | 16+16n  | 开放路径               | [(x1,y1),...]     |
| `polygon` | 40+16n  | 多边形(与闭合路径相似) | ((x1,y1),...)     |
| `circle`  | 24      | 圆                     | <(x,y),r>         |

### 网络地址类型

PG 支持 IPv4、IPv6、MAC 地址的数据类型。

| 类型    | 大小(B) | 描述                        |
| ------- | ------- | --------------------------- |
| cidr    | 7 or 19 | IPv4 或 IPv6                |
| inet    | 7 or 19 | IPv4 或 IPv6 主机或网络地址 |
| macaddr | 6       | MAC 地址                    |

### XML 类型

将字符串解析成 xml 数据类型：

```sql
XMLPARSE (CONTENT '<head><title>Hello</title></head>')
XMLPARSE (DOCUMENT '<?xml version="1.0"?><a>abc</a>')
```

### JSON 类型

可以存储成 `text` 类型，但 `json` 类型有利于检查每个存储的数值是可用的 JSON 值。

| 实例                                     | 结果                |
| ---------------------------------------- | ------------------- |
| array_to_json('{{1,5},{99,100}}'::int[]) | [[1,5],[99,100]]    |
| row_to_json(row(1,'foo'))                | {"f1":1,"f2":"foo"} |

### 数组类型

支持可变长的多维数组。

```sql
CREATE TABLE student (
    name            text,
    scores          integer[], // 二维 integer 类型
    schedule        text[][]   // 二维 text 类型
);
```

## Extensions

| Extension   | 描述         | Stars |
| ----------- | ------------ | ----- |
| PostGIS     | 存储 GIS     |       |
| TimescaleDB | 存储时间序列 | 8.5k  |

* PostgREST - RESTful API - 14.4k
* graphql-engine - GraphQL API - 16.7k

## Pgcli

自动完成和语法高亮。

```sh
$ pip install -U pgcli

# or

$ sudo apt-get install pgcli # Only on Debian based Linux (e.g. Ubuntu, Mint, etc)
$ brew install pgcli  # Only on macOS
```

## 参考

* [Awesome Postgres](https://github.com/dhamaniasad/awesome-postgres)
