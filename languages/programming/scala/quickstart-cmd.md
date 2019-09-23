# Scala 命令行入门

# 命令行使用 SCALA 和 SBT

## 先决条件

1. 安装 JDK 1.8（运行 `java -version` 来验证）
2. 安装 SBT

## 创建项目

```sh
$ cd /tmp/scala

# 从 Github 中获取 “hello-world” 模板
$ sbt new scala/hello-world.g8
```

4. 查看项目内容

```sh
$ tree
```

## 运行项目

1. `cd hello-world`
2. 运行 `sbt`，打开 sbt 控制台

## 修改代码

```sh
$ vim src/main/scala/Main.scala

```

## 添加依赖
