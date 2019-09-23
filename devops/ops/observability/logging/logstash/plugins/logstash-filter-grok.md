# logstash-filter-grok

## Grok 语法

```ruby
%{SYNTAX:SEMANTIC}
```

* `SYNTAX` - 匹配值的类型；比如 3.14 可以用 `NUMBER` 类型进行匹配，127.0.0.1 可以使用 `IP` 类型匹配
* `SEMANTIC` - 表示值的变量名

默认情况下，所有语义都保存为字符串。如果您希望转换语义的数据类型，例如将字符串更改为整数，则将其后缀为目标数据类型。例如 `%{NUMBER:num:int}` 将 num 语义从一个字符串转换为一个整数。目前唯一支持的转换是 int 和 float 。

日志记录：

```plain
55.3.244.1 GET /index.html 15824 0.043
```

使用 grok pattern 匹配上面的日志记录：

```plain
%{IP:client} %{WORD:method} %{URIPATHPARAM:request} %{NUMBER:bytes} %{NUMBER:duration}
```

## 自定义类型

## 内置模式

* [grok-patterns](https://github.com/logstash-plugins/logstash-patterns-core/blob/master/patterns/grok-patterns)

## 配置

```json
filter {
  grok {
    match => { "message" => "%{COMBINEDAPACHELOG}"}
  }
}
```

## 示例

* Spark

```json
filter {
  if [type] in ["spark-app","spark-driver", "spark-worker"] {
    grok {
      match => { "message" => [ "\s*%{WORD:level}\s+(?<logtime>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\s+%{JAVACLASS:srcclass}:\s+%{GREEDYDATA:data}", "\s*%{WORD:level}\s+(?<logtime>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\s+%{JAVACLASS:srcclass}(?::\d+)? -\s+%{GREEDYDATA:data}", "\s*%{WORD:level}\s+(?<logtime>\d{2}:\d{2}:\d{2})\s+%{DATA:srcclass}\s+%{GREEDYDATA:data}"] }
      add_field => [ "received_at", "%{@timestamp}" ]
    }
    date {
      match => [ "logtime", "YYYY-MM-dd HH:mm:ss", "HH:mm:ss" ]
    }
  }
}
```
