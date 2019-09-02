# Dockerfile 指令

## ADD 和 COPY

`ADD` 可以下载远程文件，以及自动解压 *.tar.gz 压缩包。

## ARG 指令

`ARG` 类似于 `ENV`，不同的是 `ARG` 在镜像构建的时候可以通过命令行参数 `--build-arg` 进行修改，`ENV` 可以在运行容器时通过 `--env|-e` 参考进行修改。

* Dockerfile

```ini
ARG HADOOP_TARBALL=http://www.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
```

* 构建镜像

```sh
docker build -f Dockerfile -t dockerce/hadoop:2.7.3 --build-arg HADOOP_TARBALL=hadoop-2.7.3.tar.gz .
```

## 4、CMD 指令（设置container启动时执行的操作）[设置指令]

用于容器启动时的指定操作，可以是自定义脚本或命令，只执行一次，多个默认执行最后一个。

指令有三种格式：

| 格式                                   | 描述                                                                |
| -------------------------------------- | ------------------------------------------------------------------- |
| `CMD ["executable","param1","param2"]` | （like an exec）运行一个脚本或可执行文件并传递一些参数（首选）      |
| `CMD command param1 param2`            | （as a shell）直接执行 shell 命令，默认以 `/bin/sh -c` 执行         |
| `CMD ["param1","param2"]`              | （as default parameters to ENTRYPOINT）作为 `ENTRYPOINT` 的默认参数 |

> 无论使用哪种格式，只要容器传递了参数都会覆盖 CMD，比如 `docker run -it --rm testimage:0.1 P1 P2 P3`

## ENTRYPOINT 指令（设置container启动时执行的操作）[设置指令]

指定容器启动时执行的命令，若多次设置只执行最后一次。

ENTRYPOINT翻译为"进入点"，它的功能可以让容器表现得像一个可执行程序一样。

例子：ENTRYPOINT ["/bin/echo"] ，那么docker build出来的镜像以后的容器功能就像一个/bin/echo程序，docker run -it imageecho "this is a test"，就会输出对应的字符串。这个imageecho镜像对应的容器表现出来的功能就像一个echo程序一样。

指令有两种格式：

* ENTRYPOINT ["executable", "param1", "param2"] (like an exec, the preferred form)
    * 和CMD配合使用，CMD则作为完整命令的参数部分，ENTRYPOINT以JSON格式指定执行的命令部分。CMD可以为ENTRYPOINT提供可变参数，不需要变动的参数可以写在ENTRYPOINT里面。
    * 例子：
    ENTRYPOINT ["/usr/bin/ls","-a"]
    CMD ["-l"]

* ENTRYPOINT command param1 param2 (as a shell)

独自使用，即和CMD类似，如果CMD也是个完整命令[CMD command param1 param2 (as a shell) ]，那么会相互覆盖，只执行最后一个CMD或ENTRYPOINT。
例子：ENTRYPOINT ls -l

## ADD & wget & curl

使用 `ADD` 和 `wget` 下载文件时，每次 `docker build` 都会重新下载一次，但 `curl` 不会。

## 参考

* [Dockerfile 使用说明](https://www.huweihuang.com/article/docker/dockerfile-usage/)