# Jupyter

## jupyter 与 ipython

ipython 作为 jupyter 的 kernel 。


## 安装运行

* anaconda 安装

官方建议利用Anaconda安装Jupyter

* pip 安装

```bash
# python3
$ python3 -m pip install --upgrade pip
$ python3 -m pip install jupyter

# python2
$ python -m pip install --upgrade pip
$ python -m pip install jupyter
```

* 运行

```bash
$ mkdir my-notebook && cd my-notebook
$ jupyter notebook
```

访问： `http://localhost:8888`。


## Magic（魔法）

运行 `%lsmagic` 列出所有可用的 magic，使用 `%magic` 查看详细的文档。对于不确定的 magic，输入 `%` 或 `%%` 后按 Tab 键进行自动补全。可以使用 `%` 开始使用 magics 命令运行的单行表达式。或者，您可以使用双%%来运行多行表达式。`%魔法名?` 查看 magic 的详细描述。


%alias  %alias_magic  %autocall  %automagic  %autosave  %bookmark  %cat  %cd  %clear  %colors  %config  %connect_info  %cp  %debug  %dhist  %dirs  %doctest_mode  %ed  %edit  %env  %gui  %hist  %history  %killbgscripts  %ldir  %less  %lf  %lk  %ll  %load  %load_ext  %loadpy  %logoff  %logon  %logstart  %logstate  %logstop  %ls  %lsmagic  %lx  %macro  %magic  %man  %matplotlib  %mkdir  %more  %mv  %notebook  %page  %pastebin  %pdb  %pdef  %pdoc  %pfile  %pinfo  %pinfo2  %popd  %pprint  %precision  %profile  %prun  %psearch  %psource  %pushd  %pwd  %pycat  %pylab  %qtconsole  %quickref  %recall  %rehashx  %reload_ext  %rep  %rerun  %reset  %reset_selective  %rm  %rmdir  %run  %save  %sc  %set_env  %store  %sx  %system  %tb  %time  %timeit  %unalias  %unload_ext  %who  %who_ls  %whos  %xdel  %xmode

### 单行 magic

* `!`: 运行 shell 命令，如：`! pip freeze | grep pandas`
* `%alias`
* `%run`: 执行 python 脚本；执行其他语言脚本可以使用 `!`
* `%load`: 导入外部代码；支持从网络中导入代码，如： %load http://....

### 单元格 magic


* %%!
* %%HTML
* %%SVG
* %%bash
* %%capture
* %%debug
* %%file
* %%html
* %%javascript
* %%js
* %%latex: 把单元格内容渲染成 LaTeX
* %%markdown
* %%perl
* %%prun  %%pypy
* %%python
* %%python2
* %%python3
* %%ruby
* %%script
* %%sh
* %%svg
* %%sx
* %%system
* %%time
* %%timeit
* %%writefile



## 快捷键

* `Ctrl` + `s`: 保存文件
* `Ctrl` + `Enter`: 执行单元格代码
* `Shift` + `Enter`: 执行单元格代码并且移动到下一个单元格
* `Alt` + `Enter`: 执行单元格代码，新建并移动到下一个单元格
* `Tab`: 补全
* `Shift` + `Tab`: 显示函数帮助、命令模式

自定义快捷键：http://nbviewer.jupyter.org/github/ipython/ipython/blob/3.x/examples/Notebook/Custom%20Keyboard%20Shortcuts.ipynb


## 历史输入和输出变量

* `_`: 访问上一次输出
* `__`: 访问上上一次输出
* `_X`: 访问历史第 X 行输出
* `_iX`: 访问历史第 X 行输入；其中小写字母 “i”，代表 “in”。


## 参考

* [Jupyter Notebook](https://github.com/jupyter/notebook)
* [Installing Jupyter](https://jupyter.org/install.html)