# CAP 定理（CAP Theorem）

CAP 定理是分布式系统的基本定理，任何分布式系统最多可以具有以下三个属性/指标中的两个：

* **C**onsistency - 一致性；
* **A**vailability - 可用性；
* **P**artition Toerance - 分区容错性；

## CAP

* 一致性

写操作完成后开始的任何读操作都必须返回值，或后续写操作的结果。

* 可用性

系统中非故障节点收到的每个请求都必须产生相应，即服务器不允许忽略客户端的请求。

* 分区容错性

网络分区允许节点间的任意多条信息丢失。一般来说，分区容错是服务避免的，所以可以认为 CAP 的 **P** 总是成立。

网络将允许丢失从一个节点发送到另一个节点的任意多条信息。

## 分布式系统

## 证明

## 参考

* [CAP 定理的含义](http://www.ruanyifeng.com/blog/2018/07/cap.html)
* [An Illustrated Proof of the CAP Theorem](https://mwhittaker.github.io/blog/an_illustrated_proof_of_the_cap_theorem/)