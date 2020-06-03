# Java 客户端

由于 Oracle 的权限问题，Maven 官方仓库不再更新 Oralce JDBC Driver 。

## 自制 Maven 依赖包

1. 前往 <https://www.oracle.com/database/technologies/appdev/jdbc-downloads.html>，选择与服务器端一致的 Oracle 版本（本例选择的是 `12.2,12.1`），点击进入后下载 JDBC 驱动（本例下载的是 `ojdbc8.jar`）。

2. 安装 JDBC 驱动到 Maven 本地仓库（`~/.m2/repository`）

```sh
$ mvn install:install-file
-Dfile=ojdbc8.jar
-DgroupId=com.oracle
-DartifactId=ojdbc8
-Dversion=12.2.0.1
-Dpackaging=jar
```

3. 项目的 `pom.xml` 中引用

```sh
<dependencies>
    <dependency>
        <groupId>com.oracle</groupId>
        <artifactId>ojdbc8</artifactId>
        <version>12.2.0.1</version>
    </dependency>
</dependencies>
```