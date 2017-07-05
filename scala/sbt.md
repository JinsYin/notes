# SBT

SBT 同样也是使用的 Maven 的[中心仓库](https://search.maven.org/)，默认的本地存储路径是 ` ~/.ivy2`。

## 定义依赖

```sbt
libraryDependencies += groupID % artifactID % revision
```

OR

```sbt
libraryDependencies ++= Seq(
	groupID % artifactID % revision,
	groupID % otherID % otherRevision
)
```

## 打包

* 命令行

```bash
$ sbt package
```

* IDEA IDE