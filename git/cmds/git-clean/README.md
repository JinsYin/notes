# GIT-CLEAN

从工作区移除未追踪的文件

## 用例

`git clean`    // fatal: clean.requireForce defaults to true and neither -i, -n, nor -f given; refusing to clean
`git clean -n` // "dry run"（演习）：显示哪些 unstracked 文件将会被删除（不包括 unstracked 目录），但实际不会将其删除
`git clean -f` // 删除所有 unstracked 文件（不包括 unstracked 目录），即删除 `git clean -n` 显示的文件
`git clean -xn` // 显示哪些 unstracked 文件和 ignored 文件将会被删除，但实际不会将其删除
`git clean -dn` // 显示哪些 unstracked 文件和目录将会被删除，但实际不会将其删除
`git clean -xdn`
`git clean -df` // 删除所有 unstracked 文件和目录，即删除 `git clean -dn` 显示的文件和目录
`git clean -xf` // 删除所有 unstracked 文件、 ignored 文件，以及 .gitignore 文件
`git clean -xdf`
