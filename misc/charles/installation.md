# 安装 Charles

## Ubuntu

```bash
wget -q -O - https://www.charlesproxy.com/packages/apt/PublicKey | sudo apt-key add -
sudo sh -c 'echo deb https://www.charlesproxy.com/packages/apt/ charles-proxy main > /etc/apt/sources.list.d/charles.list'
sudo apt-get update
sudo apt-get install charles-proxy
```

## CentOS

```bash
cat <<EOF > /etc/yum.repos.d/Charles.repo
[charlesproxy]name=Charles Proxy Repository
baseurl=https://www.charlesproxy.com/packages/yum
gpgkey=https://www.charlesproxy.com/packages/yum/PublicKey
EOF

sudo yum install charles-proxy
```

## MacOS

（下载 dmg 文件直接安装）