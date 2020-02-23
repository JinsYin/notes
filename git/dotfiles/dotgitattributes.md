---
---
# .gitattributes

`~/.gitconfig`:

```ini
# 将二进制 PDF 转换为可读文本的过滤器
[diff "pdfconv"]
    textconv=pdftohtml -stdout # brew install pdftohtml
```

仓库根目录下创建 `.gitattributes`

```txt
*.pdf diff=pdfconv  // 将相应的文件模式与 pdfconv 过滤器进行关联
```
