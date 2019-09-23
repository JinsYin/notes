# GIT-DIFF

Show changes between commits, commit and working tree, etc（比较三个工作区域中两两之间的文件差异）

## 用法

```sh
git diff [<options>] [<commit>] [--] [<path>...]
git diff [<options>] --cached [<commit>] [--] [<path>...]
git diff [<options>] <commit> <commit> [--] [<path>...]
git diff [<options>] <blob> <blob>
git diff [<options>] --no-index [--] <path> <path>
```

## 命令详解

| 参数                                                        | 描述                                           |
| ----------------------------------------------------------- | ---------------------------------------------- |
| `git diff [--options] [--] [<path>...]`                     | 比较工作区和暂存区之间 某些/所有 文件的差异    |
| `git diff [--options] --cached [<commit>] [--] [<path>...]` | 比较暂存区和 Git 仓库之间 某些/所有 文件的差异 |
| `git diff [--options] <commit> [--] [<path>...]`            | 比较工作区和 Git 仓库之间 某些/所有 文件的差异 |

## 用例

* `git diff` // 对比工作区所有文件相对于暂存区所做的更改
* `git diff [--] <path>...` // 对比工作区某些文件相对于暂存区所做的更改
* `git diff <commit> <commit> -- <path>...` // 对比两个提交或两个分支之间某些文件的差异（后一个相对于前一个）
* `git diff --cached HEAD [<paths>]`/ `git diff --staged [paths]` // 比较暂存区文件与版本库文件之间的差异
* `git diff HEAD -- [<paths>]` // 比较工作区文件与版本库文件之间的差异
* `git diff --name-only SHA1 SHA2` // 只对比文件名称
* `git diff stash@{0} otherbranch@{0}`

## 区域

```sh
diff --git a/diff_test.txt b/diff_test.txt // comparison input
index 6b0c6cf..b37e70a 100644              // metadata
--- a/diff_test.txt                        // Markers for changes
+++ b/diff_test.txt                        // Markers for changes
@@ -1 +1 @@                                // Diff chunks
-this is a git diff test example           // Diff chunks
+this is a diff example                    // Diff chunks
```

## 实验一 · 比较暂存区与最近一次提交的差异

```sh
git init e1 && cd e1

echo "Web" > README.md && git add . && git commit -m 'Web'
echo "<html></html>" > index.html && git add . && git commit -m 'Home page'

echo "# Web" > README.md && git add .
echo "<html>123</html>" > index.html && git add .
```

```sh
$ git status
modified:   README.md
```

```diff
# 最近一次提交相对于暂存区做了哪些修改
# 缺省 HEAD 时默认是 HEAD，缺省 README.md 时默认是比较所有文件
$ git diff --cached [HEAD] [README.md]
diff --git a/README.md b/README.md
index eae45af..76912a2 100644
--- a/README.md
+++ b/README.md
@@ -1 +1 @@
-Web
+# Web
```
