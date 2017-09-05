import boto
import boto.s3.connection

access_key = 'NO2KQEYVW9UHDT0BCELL'
secret_key = 'PU9YFVWG639g5EBXRHgQg3ISPB2NuAL1QttyRU9k'
conn = boto.connect_s3(
    aws_access_key_id = access_key,
    aws_secret_access_key = secret_key,
    host = '192.168.1.11', port = 7480,
    is_secure=False, calling_format = boto.s3.connection.OrdinaryCallingFormat(),
    )

bucket = conn.create_bucket('my-new-bucket')
for bucket in conn.get_all_buckets():
    print "{name}".format(
        name = bucket.name,
            created = bucket.creation_date,
    )