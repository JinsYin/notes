# 脚本

```sh
# 文件权限
find . -type f -not -path .git -exec chmod 644 {} \;
find . -type d -not -path .git -exec chmod 755 {} \;

# 添加新行（Git 所需）
find . -type f -name "*.md" -not -path .git -exec sed -i -e '$a\' {} \;    # Linux
find . -type f -name "*.md" -not -path .git -exec sed -i '' -e '$a\' {} \; # macOS

# 删除 .DS_Store 文件
find . -type f -not -path .git -name ".DS_Store" -exec rm {} \;
```
