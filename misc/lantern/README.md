# Lantern

## 下载地址

* [getlantern/lantern](https://www.github.com/getlantern/lantern)

## 删除命令行代理

```sh
$ unset $(env | grep -i 'proxy' | awk -F '=' '{print $1}') && grep -i 'proxy'
```