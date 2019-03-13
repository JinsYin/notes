# Graphviz

Graphviz 是 Graph Visualization Software（图形可视化软件）的简称。

## 安装

```bash
echo <<EOF >> /etc/apt/sources.list
deb http://security.ubuntu.com/ubuntu lucid-security main
deb http://cz.archive.ubuntu.com/ubuntu lucid main
EOF
```

```bash
$ sudo apt-get update
$ sudo apt-get install -y graphviz
```

## 布局器

* dot - 默认布局方式，主要用于有向图
* neato - 基于spring-model(又称force-based)算法
* twopi - 径向布局
* circo - 圆环布局
* fdp - 用于无向图