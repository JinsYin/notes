# Magic（魔法）

运行 `%lsmagic` 列出所有可用的 magic，使用 `%magic` 查看详细的文档。对于不确定的 magic，输入 `%` 或 `%%` 后按 Tab 键进行自动补全。可以使用 `%` 开始使用 magics 命令运行的单行表达式。或者，您可以使用双%%来运行多行表达式。`%魔法名?` 查看 magic 的详细描述。

%alias  %alias_magic  %autocall  %automagic  %autosave  %bookmark  %cat  %cd  %clear  %colors  %config  %connect_info  %cp  %debug  %dhist  %dirs  %doctest_mode  %ed  %edit  %env  %gui  %hist  %history  %killbgscripts  %ldir  %less  %lf  %lk  %ll  %load  %load_ext  %loadpy  %logoff  %logon  %logstart  %logstate  %logstop  %ls  %lsmagic  %lx  %macro  %magic  %man  %matplotlib  %mkdir  %more  %mv  %notebook  %page  %pastebin  %pdb  %pdef  %pdoc  %pfile  %pinfo  %pinfo2  %popd  %pprint  %precision  %profile  %prun  %psearch  %psource  %pushd  %pwd  %pycat  %pylab  %qtconsole  %quickref  %recall  %rehashx  %reload_ext  %rep  %rerun  %reset  %reset_selective  %rm  %rmdir  %run  %save  %sc  %set_env  %store  %sx  %system  %tb  %time  %timeit  %unalias  %unload_ext  %who  %who_ls  %whos  %xdel  %xmode

## 单行 Magic

* `!`: 运行 shell 命令，如：`! pip freeze | grep pandas`
* `%alias`
* `%run`: 执行 python 脚本；执行其他语言脚本可以使用 `!`
* `%load`: 导入外部代码；支持从网络中导入代码，如： `%load http://....`

## 单元格 Magic

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