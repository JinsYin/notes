# Jekyll 入门

## 安装环境

### 安装 Ruby

Jekyll 要求 **Ruby > 2.4.0**，如果 macOS 系统的 Ruby 版本可能低于要求的版本，必须要安装新版本。

* macOS

```sh
$ brew install ruby

# 配置
$ echo "export PATH=/usr/local/opt/ruby/bin:$PATH" >> ~/.zshrc # or: ~/.bashrc

$ source ~/.zshrc # or: ~/.bashrc

$ which ruby
/usr/local/opt/ruby/bin/ruby

$ ruby -v
ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-darwin18]

$ gem -v
3.0.6
```

* Ubuntu

```sh
$ sudo apt-get install ruby-full build-essential zlib1g-dev
```

### 安装 jekyll 和 bundler

```sh
# MacOS Mojave (10.14)
$ sudo gem install bundler
$ sudo gem install -n /usr/local/bin/ jekyll
```
