# Graph Easy

## 安装

```sh
# Ubuntu
$ sudo apt-get install libgraph-easy-perl
```

## 实验

* 从左到右

```sh
# [a] <-> [b]
# [a] ==> [b]
# [a] ..> [b]
# [a] - > [b]
# [a] ~~> [b]
# [a] .-> [b]
# [a] <=> [b]
# [a] -- [b]
$ graph-easy <<< '[a]->[b]->[c]->[d]->[e]'

+---+     +---+     +---+     +---+     +---+
| a | --> | b | --> | c | --> | d | --> | e |
+---+     +---+     +---+     +---+     +---+
```

* 分支

```sh
$ graph-easy <<< '[a]->[b]->[c] [b]->[d]->[e]'
$ graph-easy <<< '[a]->[b]->[d]->[e] [b]->[c]'

+---+     +---+     +---+     +---+
| a | --> | b | --> | d | --> | e |
+---+     +---+     +---+     +---+
            |
            |
            v
          +---+
          | c |
          +---+
```

* 闭环

```sh
$ graph-easy <<< '[a]->[b]->[d]->[e] [b]->[c]->[b]'
$ graph-easy <<< '[a]->[b]->[c]->[b]->[d]->[e]'

  +--------------+
  |              v
  |  +---+     +---+     +---+     +---+
  |  | a | --> | b | --> | d | --> | e |
  |  +---+     +---+     +---+     +---+
  |              |
  |              |
  |              v
  |            +---+
  +----------- | c |
               +---+
```

* 合流

```sh
$ graph-easy <<< '[a]->[b]->[c] [d]->[e]->[b]'

+---+     +---+     +---+
| a | --> | b | --> | c |
+---+     +---+     +---+
            ^
            |
            |
+---+     +---+
| d | --> | e |
+---+     +---+
```

```sh
$ graph-easy <<< '[a],[b]->[c]'
$ graph-easy <<< '[a]->[c][b]->[c]'
$ graph-easy <<< '[a]->[c] [b]->[c]'

+---+     +---+     +---+
| a | --> | c | <-- | b |
+---+     +---+     +---+
```

* 流程之间添加文字说明

```sh
$ graph-easy <<< '[a]->[b]- true ->[c]->[d]- FeedBack ->[a]'
$ graph-easy <<< '[a]->[b]->{label:"true";}[c]->[d]->{label:"FeedBack";}[a]'

      FeedBack
  +---------------------------------+
  v                                 |
+---+     +---+  true   +---+     +---+
| a | --> | b | ------> | c | --> | d |
+---+     +---+         +---+     +---+
```

* 虚线框

```sh
$ graph-easy <<< '[a] -> [b]{border:1px dotted black;}'
+---+     .....
| a | --> : b :
+---+     :...:
```

* 从上到下

```sh
$ graph-easy <<< 'graph{flow:south;}[a]->[b]->[c]'

+---+
| a |
+---+
  |
  |
  v
+---+
| b |
+---+
  |
  |
  v
+---+
| c |
+---+
```

* 读文件画流程图

```sh
$ cat flowchart.txt

[Task] -> [Created] -> [Audit 1] -> [Audit 2] -> [Execute Task]
[Audit 1] ..> [Created]
[Audit 2] ..> [Created]
```

```sh
$ graph-easy flowchart.txt

               .................
               v               :
+------+     +---------+     +---------+     +---------+     +--------------+
| Task | --> | Created | --> | Audit 1 | --> | Audit 2 | --> | Execute Task |
+------+     +---------+     +---------+     +---------+     +--------------+
               ^                               :
               .................................
```

* 同上

```sh
$ cat flowchart.txt

[Instapaper] {size: 2,7;}
[RSS(Feedly)] -> [Instapaper]{ origin: RSS(Feedly); offset: 2,0;}
[WeChat] -> [Instapaper]{ origin: WeChat; offset: 2,-6;}
[Website] -> [Instapaper]
[IFTTT]{size: 1,7;}
[Instapaper] -> [Diigo]{ origin: Instapaper; offset: 2,-2;}
[Instapaper] -> [IFTTT]{ origin: Instapaper; offset: 2,0;}
[Instapaper] -> [Evernote]{ origin: Instapaper; offset: 2,2;}
[Webtask(Serverless)]{size: 2,7;}
[IFTTT] -> [Webtask(Serverless)]{ origin: IFTTT; offset: 2,0;}
[Webtask(Serverless)] -> [Github]{ origin: Webtask(Serverless); offset: 2,-2;}
[Webtask(Serverless)] -> [ZenHub]{ origin: Webtask(Serverless); offset: 2,2}
```

```sh
$ graph-easy flowchart.txt

                                         +----------+                                 +--------+
                                 +-----> |  Diigo   |                   +-----------> | Github |
                                 |       +----------+                   |             +--------+
                                 |                                      |
                                 |                                      |
                                 |                                      |
+-------------+     +--------------+     +----------+     +---------------------+
| RSS(Feedly) | --> |              | --> |          | --> |                     |
+-------------+     |  Instapaper  |     |  IFTTT   |     | Webtask(Serverless) |
+-------------+     |              |     |          |     |                     |
|   WeChat    | --> |              |     |          |     |                     | ------+
+-------------+     +--------------+     +----------+     +---------------------+       |
                      ^          |                                                      |
                      |          |                                                      |
                      |          |                                                      v
                    +---------+  |       +----------+                                 +--------+
                    | Website |  +-----> | Evernote |                                 | ZenHub |
                    +---------+          +----------+                                 +--------+
```

## 参考

* [推荐一个制作「ASCII 流程图」工具——Graph Easy](https://juejin.im/post/5a09c43451882535c56c6bbf)
* [Graph::Easy](http://manpages.ubuntu.com/manpages/trusty/man3/Graph::Easy.3pm.html)
* [Perl 模块 Graph::Easy 中文文档](https://github.com/tiann/graph-easy-cn)
* [graph-easy](https://metacpan.org/pod/distribution/Graph-Easy/bin/graph-easy)
* [graph easy 绘制 ascii 简易流程图](https://xuxinkun.github.io/2018/09/03/graph-easy/)
