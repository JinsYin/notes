# GIT-RESET

`git add <paths>` 和 `git reset <paths>` 是两个相反的操作，而 `git commit` 则提交暂存区的快照到版本库

## 用法

```sh
git reset [-q] [<tree-ish>] [--] <paths>... # ① 撤销暂存区
git reset (--patch | -p) [<tree-ish>] [--] [<paths>...] # ②
git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>] # ③ 回滚历史
```

## 式 ①

将暂存区的所有 <paths> 重置为 <tree-ish> 时的状态（这不会影响工作区或当前分支），并将暂存区 <paths> 的修改放回到工作区。

* `git reset <paths>` = `git reset -- <paths>` = `git reset HEAD -- <paths>`
* 意味着 `git reset <paths>` 与 `git add <paths>` 是两个相反的操作
* 此命令相当于 `git restore [--source=<tree-ish>] --staged <paths>...`

## 式 ②

## 式 ③

以下都可以回滚到历史提交，但有所不同：

| 子命令                                                  | 是否重置工作区（删除工作区改动） | 是否重置暂存区（撤销 `git add`） |
| ------------------------------------------------------- | -------------------------------- | -------------------------------- |
| `git reset --soft [<commit>]`                           | No                               | No                               |
| `git reset --mixed [<commit>]` / `git reset [<commit>]` | No                               | Yes                              |
| `git reset --hard [<commit>]`                           | Yes                              | Yes                              |

注：如果上述三个命令不提供具体的文件名，将重置所有，否则将重置具体的文件。

## 用例

* `git reset [HEAD] [--] [<paths>...]`      // 撤销暂存区文件的更改（快照），并使暂存区文件的状态与 HEAD 保持一致，相当于撤销 `git add [<paths>...]`

## `git reset --hard` 误操作后如何恢复工作区

以下操作只能恢复执行过 `git add` 操作的 Git 对象，对于没有执行过该操作的对象无能为力。

1. 查询前 10 次 Git 对象

```sh
$ find .git/objects -type f | xargs ls -lt | sed 10q
-r--r--r-- 1 yin yin     25119  1月 21 15:44 .git/objects/dd/cd84c64958bc5c42ee63f53bf47ee79e058cc5
-r--r--r-- 1 yin yin       120  1月 21 15:44 .git/objects/1e/76912a7aef5e6151a5d59b73c834d60577bdd7
-r--r--r-- 1 yin yin        54  1月 21 15:44 .git/objects/1e/a5907733b5db088d42be5953c5ca4cb844fe69
-r--r--r-- 1 yin yin       104  1月 21 15:44 .git/objects/25/076c5104aaa47e260e54031efcf254108f3201
-r--r--r-- 1 yin yin        54  1月 21 15:44 .git/objects/63/4b8a1188c3b1f90c9c690cc21433b48fd6755e
-r--r--r-- 1 yin yin        60  1月 21 15:44 .git/objects/7a/79ea64c675170efd0cc985ec573e32bee765c5
-r--r--r-- 1 yin yin       737  1月 21 15:44 .git/objects/7a/ed33ecfc8ac1161cfc00145a42307b8a552c49
-r--r--r-- 1 yin yin       152  1月 21 15:44 .git/objects/7e/cd053f8e49a821360961d142689b39c1cffa71
-r--r--r-- 1 yin yin       238  1月 21 15:44 .git/objects/c1/e72f553de27452532939bfad64598d498df801
-r--r--r-- 1 yin yin        65  1月 21 15:44 .git/objects/2e/14ac9551a2b122c4293bb3185bec90b9f6dde6
```

2. 判断 Git 对象的类型

```sh
# SHA 值取自上一命令的最后两个路径 dd/cd84c64958bc5c42ee63f53bf47ee79e058cc5 （也可以只取一部分，如：ddcd84）
$ git cat-file -t ddcd84c64958bc5c42ee63f53bf47ee79e058cc5
blob

# 树（tree）对象可以引用一个或多个块（blob）对象或其他 tree 对象，每个 blob 对象对应一个文件
$ git cat-file -t 1e76912a7aef5e6151a5d59b73c834d60577bdd7
tree
```

3. 查看树的内容

```sh
# 如果是 tree 类型的对象
$ git ls-tree 1e76912a7aef5e6151a5d59b73c834d60577bdd7
100644 blob 5d24bd7030066f9860a440eb64ea889654353ee2    README.md
100644 blob b77b483d5ff120961d7860599baa63941d1272e7    bridge.md
100644 blob c0353930f6e99afc97c3b54f776f9f62a2215558    l2-switch.md
```

4. 查看 blob 对象的内容

```sh
# 确保 SHA 值对应的类型是 blob 而不是 tree、commit 或 tag（结果可能是文本，也可能是图片等二进制文件）
$ git cat-file blob 5d24bd7030066f9860a440eb64ea889654353ee2 # > x.md
$ git cat-file blob ddcd84c64958bc5c42ee63f53bf47ee79e058cc5 # > x.png
```

## 参考

* [查看 Git 对象](https://www.kancloud.cn/thinkphp/git-community-book/40847)
* [恢复 git reset --hard 删除的文件](https://blog.csdn.net/w47_csdn/article/details/82701947)
