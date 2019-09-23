# GIT-MV

转移或重命名一个文件、目录或软连接

## 重命名文件

（假设要将 `README` 重命名为 `README.md`）

方法一：

`git mv README README.md`

方法二：

1. `mv README README.md`
2. `git rm README`
3. `git add README.md`

方法三：

1. `mv README README.md`
2. `git add README README.md`
