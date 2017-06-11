# FileSystem Shell

FileSystem(FS) shell 集成了 HDFS，以及 Hadoop 支持的文件系统，Local FS, HFTP FS, S3 FS等。

FS shell 需要传递像 `scheme://authority/path` 的 URIs 参数，HDFS 的 scheme 为 `hdfs`，Local FS 的 scheme 为 `file`。

如果在配置文件指定了 `fs.defaultFS` 为 `hdfs://namenodehost`，可以将 `hdfs://namenodehost/parent/child` 简写为 `/parent/child`。

```bash
$ bin/hdfs fs <args>
```

## appendToFile

`appendToFile` 追加本地文件或标准输入（stdin）到 HDFS

```bash
$ hdfs dfs -appendToFile localfile1 localfile2 /user/hadoop/hadoopfile # 支持多个输入，/user/hadoop/hadoopfile 不需要事先创建好
$ hdfs dfs -appendToFile - /user/hadoop/hadoopfile # 从 stdin 中读取输入（CTRL + C 结束输入）
```

## cat

`cat` 输出文件内容到标准输出（stdout）。

```bash
$ hdfs dfs -cat /user/hadoop/hadoopfile
```

## checksum

`checksum` 返回文件的 checksum 信息。

```bash
$ hdfs dfs -checksum /user/hadoop/hadoop/hadoopfile
```

## chgrp

`chgrp`  改变文件、目录的归属组，默认组：supergroup。

```bash
$ hdfs dfs -chgrp (-R) GROUP URI [URI ...]
$ hdfs dfs -chgrp -R root /usr # 改变 /usr 及子目录的组
```

## chmod

`chmod` 改变文件、目录的权限。

```bash
$ hdfs dfs -chmod (-R) [MODE] URI [URI ...]
$ hdfs dfs -chmod -R 777 /user/hadoop # 改变目录及子目录的权限
$ hdfs dfs -chmod 640 /user/hadoop/hadoopfile # 改变文件的权限
```

## chown

`chown` 改变文件的所有者。

```bash
$ hdfs dfs -chown (-R) [OWNER][:[GROUP]] URI [URI ]
$ hdfs dfs -chown -R root:root /user/hadoop
$ hdfs dfs -chown root:root /user/hadoop/hadoopfile
```

## copyFromLocal

`copyFromLocal` 拷贝本地文件到 HDFS。类似 `put`，不同的是 copyFromLocal 的源被限制为一个本地文件。

```bash
$ hdfs dfs -copyFromLocal <localsrc> URI
$ hdfs dfs -copyFromLocal ./README.md /README.md
$ hdfs dfs -copyFromLocal ./README.md /user/hadoop # 拷贝到 /user/hadoop 目录
```

## copyToLocal

`copyToLocal` 拷贝 HDFS 文件到本地。类似 `get`，不同的是 copyToLocal 的目标被限制为一个本地文件。

```bash
$ hdfs dfs -copyToLocal URI <localdst>
$ hdfs dfs -copyToLocal /user/hadoop/hadoopfile ./hadoopfile
```

## count

`count` 输出对应路径的目录数、文件数、字节数。
-count -q：输出 QUOTA, REMAINING_QUATA, SPACE_QUOTA, REMAINING_SPACE_QUOTA, DIR_COUNT, FILE_COUNT, CONTENT_SIZE, PATHNAME。

```bash
$ hdfs dfs -count [-q] [-h] <paths> # -h 人类可读
```

## cp

`cp` 从　HDFS 拷贝文件到 HDFS，不支持本地。

```bash
$ hdfs dfs -cp [-f] [-p | -p[topax]] URI [URI ...] <dest>
$ hdfs dfs -cp -f /user/hadoop/hadoopfile1 /user/hadoop/hadoopfile2 # -f: 如果 hadoopfile2 存在会被覆写
```

## df

`df` 查看剩余空间。

```bash
$ hdfs dfs -df [-h] URI [URI ...]
$ hdfs dfs -df -h /
```

## du

`du` 查看文件、目录的大小（单位：字节）。

```
$ hdfs dfs -du [-s] [-h] URI [URI ...]
$ hdfs dfs -du -h /user
```

## find

`find` 查找正则匹配的文件。

```bash
$ hdfs dfs -find <path> ... <expression> ...
$ hdfs dfs -find / -name test.md # 区分大小写
$ hdfs dfs -find / -iname test.md # 不区分大小写
```

## get

`get` 从 HDFS 拷贝文件到本地。

```bash
$ hdfs dfs -get <src> <localdst>
$ hdfs dfs -get /user/hadoop/hadoopfile
$ hdfs dfs -get /user/hadoop/hadoopfile hdfsfile # 重命名
```

## ls

`ls` 列出文件和目录。

```bash
$ hdfs dfs -ls (-h) (-R) / # 列举根目录文件，-R：含子目录
$ hdfs dfs -ls /README.txt
-rw-r--r--   1 root supergroup       1366 2017-01-01 00:00 /README.txt
（从左到右依次是：文件权限，副本数, 文件所有者，文件所有者所在组，文件大小<单位：字节>，创建时间，文件）
```

## mkdir

`mkdir` 创建目录。

```bash
$ hdfs dfs -mkdir [-p] <paths>
$ hdfs dfs -mkdir -p /user/hadoop/hive
```

## mv

`mv` 从　HDFS 移动文件到 HDFS，不支持本地。

```bash
$ hdfs dfs -mv URI [URI ...] <dest>
$ hdfs dfs -mv /user/hadoop/file1 /user/hadoop/file2
```

## put

`put` 上传一个或多个本地文件或者标准输入到　HDFS。

```bash
$ hdfs dfs -put <localsrc> ... <dst>
$ hdfs dfs -put localfile /user/hadoop/hadoopfile
$ hdfs dfs -put localfile1 localfile2 /user/hadoop/
$ hdfs dfs -put - /user/hadoop/hadoopfile
```

## rm

`rm` 删除　HDFS 中的文件或目录。

```bash
$ hdfs dfs -rm [-f] [-r |-R] [-skipTrash] URI [URI ...]
$ hdfs dfs -rm /user/hadoop/hadoopfile
$ hdfs dfs -rm -r /user/hadoop # 删除目录及其所有子内容，-r == -R
```

## rmdir

`rmdir` 删除 HDFS 的目录。

```bash
$ hdfs dfs -rmdir [--ignore-fail-on-non-empty] URI [URI ...]
$ hdfs dfs -rmdir /user/hadoop
```

## setrep

`setrep` 修改文件的副本数。

```bash
$ hdfs dfs -setrep [-R] [-w] <numReplicas> <path>
$ hdfs dfs -setrep -R 2 /usr/hadoop # 修改副本数
$ hdfs dfs -D dfs.replication=1 -put test.txt /user/hadoop # 上传文件并指定副本数
```

## stat

`stat` 打印文件、目录的描述信息。

```bash
$ hdfs dfs -stat [format] <path> ...
$ hdfs dfs -stat "%F %u:%g %b %y %n" /user/hadoop/hadoopfile
```

## tail

`tail` 输出文件的最后 1KB 到标准输出。

```bash
$ hdfs dfs -tail [-f] URI
$ hdfs dfs -tail -f /user/hadoop/hadoopfile
```

## test

`test` 测试。

```bash
# -d: f the path is a directory, return 0.
# -e: if the path exists, return 0.
# -f: if the path is a file, return 0.
# -s: if the path is not empty, return 0.
# -z: if the file is zero length, return 0.
$ hdfs dfs -test -[defsz] URI
```

## text

```bash
$ hdfs dfs -text <src>
$ hdfs dfs -text /user/hadoop/hadoopfile
```

## touchz

`touchz` 创建一个空文件。

```bash
$ hdfs dfs -touchz URI [URI ...]
$ hdfs dfs -touchz /user/hadoop/hadoopfile
```

## truncate

`truncate` 截取文件为指定长度（单位：字节）
```bash
$ hdfs dfs -truncate [-w] <length> <paths>
$ hdfs dfs -truncate -w 55 /user/hadoop/file1
```

## 参考文章
> http://hadoop.apache.org/docs/r2.7.2/hadoop-project-dist/hadoop-common/FileSystemShell.html

