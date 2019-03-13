# Graphviz

Graphviz 是 Graph Visualization Software（图形可视化软件）的简称。

## 布局器（Layout）

* dot - 默认布局方式，主要用于有向图
* neato - 基于spring-model(又称force-based)算法
* twopi - 径向布局
* circo - 圆环布局
* fdp - 用于无向图

```bash
$ dot x.dot -Tpng -o x.png
```

```dot
digraph {
    node [shape=plaintext, fontcolor=red, fontsize=18];
    "Pointers:" -> "Values:" -> "Indices:" [color=white];

    node [shape=record, fontcolor=black, fontsize=14, width=4.75, fixedsize=true];
    pointers [label="<f0> A | <f1> A+1 | <f2> A+2 | <f3> A+3 | <f4> A+4 | <f5> A+5", color=white];
    values [label="<f0> A[0] | <f1> A[1] | <f2> A[2] | <f3> A[3] | <f4> A[4] | <f5> A[5]", color=blue, fillcolor=lightblue, style=filled];
    indices [label="0 | 1 | 2 | 3| 4 | 5", color=white];

    { rank=same; "Pointers:"; pointers }
    { rank=same; "Values:"; values }
    { rank=same; "Indices:"; indices }

    edge [color=blue];
    pointers:f0 -> values:f0;
    pointers:f1 -> values:f1;
    pointers:f2 -> values:f2;
    pointers:f3 -> values:f3;
    pointers:f4 -> values:f4;
    pointers:f5 -> values:f5;
}
```

## 用途

* 关系图
* 流程图
* 决策树
* 数据结构
* 代码调用图（Call Graph）
* （编译原理）有限自动机

## 参考

* [Drawing graphs with dot](https://www.graphviz.org/pdf/dotguide.pdf)