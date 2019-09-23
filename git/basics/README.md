# Git 基础

* [版本控制](version-control.md)
* [安装 Git](installation.md)

![Git flow](../../.images/git-guide.png)

* Workspace：工作区
* Index / Stage：暂存区
* Repository：本地仓库/本地数据库
* Remote：远程仓库

<!--
工作目录 - working directory / working tree / worktree
暂存区 - staging area / staging directory / index / staging index
版本库 - commit history / repository / commit tree
储藏区 - stash
-->

## 三种状态 & 三个工作区域

* 已提交（**committed**） - 表示数据已安全保存到本地数据库中
* 已修改（**modified**） - 表示修改了文件，但还未保存到本地数据库
* 已暂存（**staged**） - 表示对一个已修改文件的当前版本做了标记，使之包含在下次提交的快照中

由此引入 Git 项目的三个工作区域的概念：**工作目录（working tree）**、**暂存区（staging area）** 以及 **Git 仓库（Git directory）**。

![工作区域](.images/git-areas.png)

Git 仓库目录是 Git 用来保存项目的元数据和对象数据库的地方。从其他计算机克隆仓库时，拷贝的就是这里的数据。

工作目录是对项目的某个版本独立提取出来的内容。工作目录是对项目的某个版本独立提取出来的内容。 这些从 Git 仓库的压缩数据库中提取出来的文件，放在磁盘上供你使用或修改。

暂存区域是一个文件，保存了下次将提交的文件列表信息，一般在 Git 仓库目录中。 有时候也被称作`‘索引’'，不过一般说法还是叫暂存区域。
