# 主存储

## S3

### 一个 Bucket

```php
'objectstore' => [
    'class' => 'OC\\Files\\ObjectStore\\S3',
    'arguments' => [
        'bucket' => 'abc',
        'key' => '123',
        'secret' => 'abc',
        'hostname' => 'localhost',
        'port' => '4567',
        'use_ssl' => false,
        'use_path_style' => 'true',
    ],
],
```

```php
$ vi /opt/nextcloud/config/config.php
<?php
$CONFIG = array (
  // 'datadirectory' => '/var/www/html/data',
  // 删除默认的 'datadirectory' 存储方式，换成期望的存储方式
  ......
  'objectstore' => array(
    'class' => 'OC\\Files\\ObjectStore\\S3',
    'arguments' => array(
      'bucket' => 'nextcloud',
      'autocreate' => true,
      'key'    => 'jjyy',
      'secret' => 'jjyy',
      'hostname' => '192.168.8.220',
      'port' => 8080,
      'use_ssl' => false,
      'region' => 'optional',
      // required for some non amazon s3 implementations
      'use_path_style' => true
    ),
  ),
  ......
);
```

### 多个 Bucket（每个用户一个 Bucket）

```php
'objectstore_multibucket' => [
    'class' => 'OC\\Files\\ObjectStore\\S3',
    'arguments' => [
        'bucket' => 'abc',
        'num_buckets' => 64,
        'key' => 'jjyy',
        'secret' => 'jjyy',
        'hostname' => '192.168.8.220',
        'port' => '8080',
        'use_ssl' => false,
        'use_path_style' => 'true',
    ],
],
```

```php
  'objectstore_multibucket' => array(
    'class' => 'OC\\Files\\ObjectStore\\S3',
    'arguments' => array(
        'num_buckets' => 64,:%:
        'bucket' => 'nextcloud_',
        'key' => 'jjyy',
        'secret' => 'jjyy',
        'hostname' => '192.168.8.220',
        'port' => '8080',
        'use_ssl' => false,
        'use_path_style' => 'true',
    ),
  ),
```

```php
$CONFIG = array (
  // 'datadirectory' => '/var/www/html/data',
  // 删除默认的 'datadirectory' 存储方式，换成期望的存储方式
  ......
  'objectstore_multibucket' => array(
    'class' => 'Object\\Storage\\Backend\\Class',
    'arguments' => array(
      // optional, defaults to 64
      'num_buckets' => 64,
      // will be prefixed by an integer in the range from 0 to (num_nuckets-1)
      'bucket' => 'nextcloud_',
      'autocreate' => true,
      'key'    => 'jjyy',
      'secret' => 'jjyy',
      'hostname' => '192.168.8.220',
      'port' => 8080,
      'use_ssl' => false,
      'region' => 'optional',
      // required for some non amazon s3 implementations
      'use_path_style' => true
    ),
  ),
  ...
);
```

## 删除 Bucket

```bash
s3cmd rm s3://nextcloud --recursive --force
s3cmd rb s3://nextcloud
```

## 参考

* [nextcloud/server - How to test S3 primary storage](https://github.com/nextcloud/server/wiki/How-to-test-S3-primary-storage)
* [Using Amazon S3 'autocreate => true' is not working](https://github.com/nextcloud/server/issues/6289)