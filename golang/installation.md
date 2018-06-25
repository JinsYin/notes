# 安装

```bash
# 下载
$ wget /tmp/go1.10.linux-amd64.tar.gz https://dl.google.com/go/go1.10.linux-amd64.tar.gz

# 解压
$ tar -xzvf /tmp/go1.10.linux-amd64.tar.gz -C /usr/local

# 添加 /usr/local/go/bin 到 PATH 环境变量
$ echo 'export GOROOT=/usr/local/go' >> ~/.bashrc # user-wide（system-wide: /etc/profile）
$ echo 'export PATH=$PATH:$GOROOT/bin' >> ~/.bashrc

$ source ~/.bashrc
$ go version
go version go1.10 linux/amd64
```

* 测试安装

```bash
# 创建 workspace 并设置 GOPATH 环境变量
$ mkdir $HOME/go
$ echo 'export GOPATH=$HOME/go' >> ~/.bashrc && source ~/.bashrc
```

```bash
$ mkdir -p $GOPATH/src/hello && cd $GOPATH/src/hello

$ vi hello.go
package main

import "fmt"

func main() {
  fmt.Printf("hello, world\n")
}
```

```bash
# 构建
$ go build #hello.go

# 生成了一个二进制文件
$ ls $GOPATH/src/hello
hello  hello.go

# 运行
$ ./hello
hello, world
```

## 参考

* [Getting Started](https://golang.org/doc/install)