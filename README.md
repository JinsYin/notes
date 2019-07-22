# 笔记

我们缺的不是知识，而是知识的积累，以及知识的整理方式。

## 技能水平

技能水平与工作年限无关，更多的取决于在项目实战中获得的技术积累和工作经验。

| 水平 | 其他词         | 描述 |
| ---- | -------------- | ---- |
| 了解 | 探索、知道     |      |
| 入门 | 理解           |      |
| 熟悉 | 掌握、经验丰富 |      |
| 熟练 |                |      |
| 精通 |                |      |

| Level      | Description |
| ---------- | ----------- |
| Novice     |             |
| Basic      |             |
| Proficient |             |
| Advance    |             |
| Expert     |             |

<https://www.health.nsw.gov.au/nursing/projects/documents/novice-expert-benner.pdf>

## IT 领域

* 人工智能
* 搜索引擎
* 云计算
* 区块链
* 大数据

最本质的东西是 **基础知识** 和 **核心概念**。

“扎实的功底和过硬的技术，是你职业发展的助力器。”
“看似最枯燥、最基础的东西往往具有最长久的生命力。”

<!--

## 何时 commit

* 有时某些项只有少量改动或少量新增，可以每周更新一次 “大类”（最上层分类），如：`git add databases/ && git commit -m "Databases 周更"`

## 文件模式

Ubuntu 共享访问 macOS 的文件时，Ubuntu 访问到的文件和目录其模式都是 755，而且无法在 Ubuntu 上改变（不影响 macOS 的文件模式），在 Ubuntu 创建文件和目录会导致文件模式更加混乱。

解决办法：

1. 在 macOS 或 Ubuntu 上创建内容（文件或目录）
2. 在 macOS 上统一修改文件和目录的模式
   1. macOS 文件（除目录外）默认模式：644（`find . -type f -exec chmod 644 {} \;`）
   2. macOS 目录默认模式：755（`find . -type d -exec chmod 755 {} \;`）
3. 在 macOS 上提交

## 避免空文件和空目录

```sh
$ find . -empty -type d
$ find . -empty -type f
```

## 删除 .DS_Store 文件

```sh
$ find . -type f -name ".DS_Store" -exec rm {} \;
```

-->