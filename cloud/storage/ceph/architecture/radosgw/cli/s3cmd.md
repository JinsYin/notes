# s3cmd - 管理 S3 的命令行客户端

## 安装

```bash
# 直接下载二进制
$ google-chrome https://github.com/s3tools/s3cmd/releases

# 安装或更新到最新版（推荐）
$ pip install -U s3cmd

# Debian/Ubuntu（版本旧）
$ apt-get install s3cmd

# RHEL/CentOS（版本旧）
$ yum install s3cmd
```

```bash
# 检查
$ s3cmd --version
s3cmd version 2.0.2
```

## 客户端配置

通过命令行进行基本配置：

```bash
# 确保可以成功访问 S3
$ s3cmd --configure
  Access Key: jjyy
  Secret Key: jjyy
  Default Region: US
  S3 Endpoint: 192.168.8.220:8080
  DNS-style bucket+hostname:port template for accessing a bucket: 192.168.8.220:8080
  Encryption password:
  Path to GPG program: /usr/bin/gpg
  Use HTTPS protocol: False
  HTTP Proxy server name:
  HTTP Proxy server port: 0
```

通过配置文件进行详细配置：

```bash
$ vi $HOME/.s3cfg
[default]
access_key = jjyy
access_token =
add_encoding_exts =
add_headers =
bucket_location = US
ca_certs_file =
cache_file =
check_ssl_certificate = True
check_ssl_hostname = True
cloudfront_host = cloudfront.amazonaws.com
default_mime_type = binary/octet-stream
delay_updates = False
delete_after = False
delete_after_fetch = False
delete_removed = False
dry_run = False
enable_multipart = True
encrypt = False
expiry_date =
expiry_days =
expiry_prefix =
follow_symlinks = False
force = False
get_continue = False
gpg_command = /usr/bin/gpg
gpg_decrypt = %(gpg_command)s -d --verbose --no-use-agent --batch --yes --passphrase-fd %(passphrase_fd)s -o %(output_file)s %(input_file)s
gpg_encrypt = %(gpg_command)s -c --verbose --no-use-agent --batch --yes --passphrase-fd %(passphrase_fd)s -o %(output_file)s %(input_file)s
gpg_passphrase =
guess_mime_type = True
host_base = 192.168.8.220:8080
host_bucket = 192.168.8.220:8080
human_readable_sizes = False
invalidate_default_index_on_cf = False
invalidate_default_index_root_on_cf = True
invalidate_on_cf = False
kms_key =
limit = -1
limitrate = 0
list_md5 = False
log_target_prefix =
long_listing = False
max_delete = -1
mime_type =
multipart_chunk_size_mb = 15
multipart_max_chunks = 10000
preserve_attrs = True
progress_meter = True
proxy_host =
proxy_port = 0
put_continue = False
recursive = False
recv_chunk = 65536
server_side_encryption = False
signature_v2 = False
signurl_use_https = False
simpledb_host = sdb.amazonaws.com
skip_existing = False
socket_timeout = 300
stats = False
stop_on_error = False
storage_class =
urlencoding_mode = normal
use_http_expect = False
use_https = False
use_mime_magic = True
verbosity = WARNING
website_endpoint = http://%(bucket)s.s3-website-%(location)s.amazonaws.com/
website_error =
website_index = index.html
```

## 管理 S3 资源

```bash
# 创建一个名为 "buckup" 的 Bucket
$ s3cmd mb s3://backup
Bucket 's3://backup/' created

# 查看所有 Bucket
$ s3cmd ls
2018-06-27 10:24  s3://backup

# 上传文件（Object）到 "backup" Bucket
$ s3cmd put README.md s3://backup
upload: 'README.md' -> 's3://backup/README.md'  [1 of 1]

# 查看 "backup" Bucket 下的所有文件
$ s3cmd ls s3://backup
2018-07-13 03:09    687   s3://backup/README.md

# 下载 Object
$ s3cmd get s3://backup/README.md

# 删除 Bucket（如果有数据需先：s3cmd rm s3://backup --recursive --force）
$ s3cmd rb s3://backup
```

## GUI

* [S3 Browser](http://s3browser.com/) - 仅支持 Windows