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