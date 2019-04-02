# Dot 语言

Dot 语言用于定义图形（Graph），但不提供渲染图形的工具。Graphviz 中的 `dot` 程序可以用来渲染图形。

## 无向图（Undirected graphs）

```dot
// 图名和分号可选
graph G {
    a -- b -- c;
    b -- d;
}
```

## 有向图（Directed graphs）

```dot
digraph G {
    a -> b -> c;
    b -> d
}
```

## 属性（Attributes）

```dot
graph G {
    // 图形大小
    size="2,2";

    // 改变节点（node）的 label
    a [label="Foo"];

    // 节点的形状
    b [shape=box];

    // 边的颜色
    a -- b -- c [color=blue];

    // 边属性
    b -- d [style=dotted, type=s];
}
```

## 注释（Comments）

```plain
// 单行注释

/*
多
行
注
释
*/

# 单行注释
```

## 示例

```dot
digraph g {
    node [shape = record,height=.1];
    node0[label = "<f0> |<f1> G|<f2> "];
    node1[label = "<f0> |<f1> E|<f2> "];
    node2[label = "<f0> |<f1> B|<f2> "];
    node3[label = "<f0> |<f1> F|<f2> "];
    node4[label = "<f0> |<f1> R|<f2> "];
    node5[label = "<f0> |<f1> H|<f2> "];
    node6[label = "<f0> |<f1> Y|<f2> "];
    node7[label = "<f0> |<f1> A|<f2> "];
    node8[label = "<f0> |<f1> C|<f2> "];
    "node0":f2 -> "node4":f1;
    "node0":f0 -> "node1":f1;
    "node1":f0 -> "node2":f1;
    "node1":f2 -> "node3":f1;
    "node2":f2 -> "node8":f1;
    "node2":f0 -> "node7":f1;
    "node4":f2 -> "node6":f1;
    "node4":f0 -> "node5":f1;
}
```

```dot
digraph st2{
    fontname = "Verdana";
    fontsize = 10;
    rankdir=TB;

node [fontname = "Verdana", fontsize = 10, color="skyblue", shape="record"];

edge [fontname = "Verdana", fontsize = 10, color="crimson", style="solid"];

st_hash_type [label="{<head>st_hash_type|(*compare)|(*hash)}"];
st_table_entry [label="{<head>st_table_entry|hash|key|record|<next>next}"];
st_table [label="{st_table|<type>type|num_bins|num_entries|<bins>bins}"];

st_table:bins -> st_table_entry:head;
st_table:type -> st_hash_type:head;
st_table_entry:next -> st_table_entry:head [style="dashed", color="forestgreen"];
}
```

## 参考

* [DOT (graph description language)](https://en.wikipedia.org/wiki/DOT_(graph_description_language))