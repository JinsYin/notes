# Go 的安装与配置

## 下载安装

* Linux

```sh
$ wget https://dl.google.com/go/go1.11.11.linux-amd64.tar.gz     # 下载
$ sudo tar -xzvf /tmp/go1.11.11.linux-amd64.tar.gz -C /usr/local # 解压

# 验证
$ go version
```

* macOS

```sh
$ wget https://dl.google.com/go/go1.11.11.darwin-amd64.tar.gz # 下载
$ sudo tar -zxvf go1.11.11.darwin-amd64.tar.gz -C /usr/local  # 解压

# 验证
$ go version
go version go1.11.11 darwin/amd64
```

## 配置环境变量

| 变量名   | 变量值                                                              | 示例                          |
| -------- | ------------------------------------------------------------------- | ----------------------------- |
| `GOROOT` | Go 安装路径                                                         | `export GOROOT=/usr/local/go` |
| `GOPATH` | 工作区路径；相应的源码路径是 `$GOPATH/src`                          | `export GOPATH=~/go`          |
| `GOBIN`  | 可执行程序（`go install`）的安装路径（访问的是 `$GOPATH` 下的项目） | `export GOBIN=$GOPATH/bin`    |

实施配置：

```sh
# Linux/macOS
$ vi ~/.bash_profile # 系统级：/etc/profile
export GOROOT=/usr/local/go
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin:$GOBIN

# 立即生效
$ source ~/.bash_profile
```

验证配置：

```sh
# 验证 GOROOT、GOPATH 和 GOBIN
$ go env GOROOT
$ go env GOPATH
$ go env GOBIN

# 验证 PATH
$ go version
go version go1.11.11 linux/amd64  # Linux
go version go1.11.11 darwin/amd64 # macOS
```

注：

bash -> `~/.bash_profile` / `~/.bashrc`
zsh -> `~/.zshrc`
系统级别 -> `/etc/profile`

## 测试安装

```sh
# 在工作区中创建 src/hello 项目
$ mkdir -p $GOPATH/src/hello
```

```go
$ cd $GOPATH/src/hello
$ vi hello.go
package main

import "fmt"

func main() {
  fmt.Printf("hello, world\n")
}
```

* go build

```sh
$ cd $GOPATH/src/hello

# 构建（项目中可以创建多个 go 源文件，但总共只能定义一个 main() 方法）
$ go build

# 生成了一个同名的可执行二进制文件
$ ls $GOPATH/src/hello
hello  hello.go

# 运行
$ ./hello
hello, world
```

* go install

```sh
$ cd $GOPATH/src/hello

# 安装二进制到工作区的 bin 目录（即 GOBIN）
$ go install

$ ls $GOBIN
dlv     godef   gometalinter  gopkgs    goreturns   guru
gocode  golint  go-outline    gorename  go-symbols  hello # -_-

# 直接执行
$ hello
hello, world

# 移除安装到 GOBIN 的二进制文件
$ go clean -i
```

## 卸载

```sh
# 第一步
$ rm -rf /usr/local/go

# 第二步：移除环境变量
```

## 参考

* [Getting Started](https://golang.org/doc/install)
