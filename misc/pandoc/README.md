# Pandoc

Pandoc 可以将文件在 `markdown`、`html`、`pdf`、`doc`、`docx` 等格式之间相互转换，除了不能从 `pdf` 转换为其他格式。

## 安装

```sh
$ sudo apt-get install pandoc
```

如果 apt-get 安装的 pandoc 功能不齐全，可以如官网上一样先安装 cable，再安装 pandoc

```sh
$ sudo apt-get install cabal-install
$ cabal update
$ cabal install pandoc
```

为了支持 pdf，需要安装 LaTeX

```sh
$ sudo apt-get install texlive-latex-base
$ sudo apt-get install texlive
```

## 使用

* Markdown 转 HTML

```sh
$ pandoc test1.md -f markdown -t html -s -o test1.html
```

* Markdown 转 TeX

```sh
$ pandoc test1.md -f markdown -t latex -s -o test1.tex
```

* Markdown 转 PDF

```sh
$ pandoc test1.md -s -o test1.pdf
```