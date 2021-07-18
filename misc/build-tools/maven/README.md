# Maven

## 标准目录结构

```sh
$ tree .

```

## POM 节点

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.easipass.bigdata</groupId>
    <artifactId>realtime-computation</artifactId>
    <version>0.0.1</version>
    <packaging>jar</packaging>
</project>
```

| POM 节点       | 必需？ | 描述                                       |
| -------------- | ------ | ------------------------------------------ |
| `project`      | Yes    | 根节点                                     |
| `modelVersion` | Yes    | 4.0.0                                      |
| `groupId`      | Yes    | 项目组的唯一标识，如 “com.company.bigdata” |
| `artifactId`   | Yes    | 项目的唯一标识，如 “stream-processing”     |
| `version`      | Yes    | 项目的版本号，如 “0.0.1”                   |

`groupId:artifactId:version` 唯一标识一个项目。
