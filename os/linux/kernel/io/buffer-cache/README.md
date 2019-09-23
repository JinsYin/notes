# Linux I/O 缓冲

Buffer Cache：缓冲区缓存

![Buffer Cache](.images/buffer-cache-hierarchies.gif)

内核提供了缓存来提高系统性能。

利用局部性原理：

* 当应用程序试图从块设备读取数据时，内核会将块设备中待读取的目标数据及其周围数据都加载到内存中，下次访问时直接从内存中读取（可能是原来的数据，也可能周围的数据）
* 当应用程序试图向块设备写入数据时，内核会先把数据写入到缓存中，等到特定的时候再一同刷新到块设备

由于内核是通过基于 _页_ 的内存映射来实现访问块设备的，因此缓存也是基于页来进行的，故称之为 _页缓存（page cache）_。

## 参考

* [The buffer cacheb](https://www.tldp.org/LDP/sag/html/buffer-cache.html)
