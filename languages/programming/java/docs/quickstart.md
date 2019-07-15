# Java 快速入门

## Hello world

* 代码（`Hello.java`）

```java
// 文件名必须和 public class 类名相同，且一个文件只能有个一个 public class 类
public class Hello {
    public static void main(String args[]) {
        System.out.println("Hello, world");
    }
}
```

* 编译

```sh
$ javac Hello.java

$ ls
Hello.class  Hello.java
```

* 运行（由 JVM 解释执行 + JIT 编译高频字节码为机器码）

```sh
$ java Hello # 没有文件扩展名
Hello, world
```