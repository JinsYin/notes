# owncloud

## 部署

```bash
docker run -d --name owncloud -p 7777:80 -v /opt/owncloud/config:/var/www/html/config owncloud:10.0.9
```

```php
'objectstore' => [
  'class' => 'OCA\ObjectStore\S3',
  'arguments' => [
    // replace with your bucket
    'bucket' => 'owncloud',
    'autocreate' => true,
    'options' => [
      // version and region are required
      'version' => '2006-03-01',
      'region'  => '',
      // replace key, secret and bucket with your credentials
      'credentials' => [
        // replace key and secret with your credentials
        'key'    => 'jjyy',
        'secret' => 'jjyy',
      ],
      // replace the ceph endpoint with your rgw url
      'endpoint' => 'http://192.168.8.220:8080/',
      // Use path style when talking to ceph
      'command.params' => [
        'PathStyle' => true,
      ],
    ],
  ],
],
```

```php
'objectstore_multibucket' => [
   'class' => 'OCA\ObjectStore\S3',
   'arguments' => [
      'autocreate' => true,
      'options' => [
        'version' => '2006-03-01',
        'region'  => '',
        'credentials' => [
          'key' => 'jjyy',
          'secret' => 'jjyy',
        ],
       ],
   ],
],
```

```php
  'objectstore' => array (
    'class' => 'OCA\ObjectStore\S3',
    'arguments' => array (
      // replace with your bucket
      'bucket' => 'owncloud',
      'autocreate' => true,
      'options' => array (
        // version and region are required
        'version' => '2006-03-01',
        'region'  => '',
        // replace key, secret and bucket with your credentials
        'credentials' => array (
          // replace key and secret with your credentials
          'key'    => 'jjyy',
          'secret' => 'jjyy',
        ),
        // replace the ceph endpoint with your rgw url
        'endpoint' => 'http://192.168.8.220:8080/',
        // Use path style when talking to ceph
        'command.params' => array (
          'PathStyle' => true,
        ),
      ),
    ),
  ),
```