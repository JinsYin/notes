# Maven

Maven 是一个项目构建工具，负责管理项目依赖。当添加依赖的时候，会首先从本地（默认路径：`~/.m2`）查找依赖，如果没有相应的依赖会从远程[中心仓库](https://search.maven.org/)自动下载依赖的 jar 包和/或源码包到本地。

## 打包

```bash
$ mvn clean dist
``