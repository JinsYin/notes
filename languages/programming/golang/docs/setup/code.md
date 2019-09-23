# How to Write Go Code

## 代码组织结构

* 通常所有代码放在一个 _工作区（workspace）_
* 工作区包含多个版本控制的 _仓库（repository）_
* 每个仓库包含一个或多个 _包（package）_
* 每个包包含一个或多个在同一目录的 Go 源码文件
* 包的路径决定了其 _导入路径（import path）_

> 不同于其他编程环境，Go 的每一个项目都有一个单独的工作区，工作区和版本控制仓库紧密相连

## 工作区

工作区（Workspace）包含两个子目录：

| 子目录 | 描述                       |
| ------ | -------------------------- |
| `src`  | 包含一个或多个版本控制仓库 |
| `bin`  | 包含一个或多个可执行命令   |

```sh
$ tree $GOPATH
bin/
    hello                          # command executable
    outyet                         # command executable
src/
    github.com/golang/example/
        .git/                      # Git repository metadata
        hello/
            hello.go               # command source
        outyet/
            main.go                # command source
            main_test.go           # test source
        stringutil/
            reverse.go             # package source
            reverse_test.go        # test source
    golang.org/x/image/
        .git/                      # Git repository metadata
        bmp/
            reader.go              # package source
            writer.go              # package source
    ... (many more repositories and packages omitted) ...
```

## 导入路径（import path）

## 参考

* [How to Write Go Code](https://golang.org/doc/code.html)
