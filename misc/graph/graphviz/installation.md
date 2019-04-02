# 安装

## Ubuntu

```bash
echo <<EOF >> /etc/apt/sources.list
deb http://security.ubuntu.com/ubuntu lucid-security main
deb http://cz.archive.ubuntu.com/ubuntu lucid main
EOF
```

```bash
$ sudo apt-get update
$ sudo apt-get install -y graphviz
```