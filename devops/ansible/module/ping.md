# ping 模块

## 用法

## 示例

```sh
$ ansible all -m ping
192.168.10.207 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "comment": null,
    "exclusive": false,
    "follow": false,
    "key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTd/nQTDSWnl0dCFTLky2CoZEx4VfgPGOhXs9BslaWdoYlYDjuD2xgtB9TbZCT/wiBiyyDcwdzjW+jYIhkSDkDLNtJXzVJLsb2n/obEpEXxOaC1UeVosU1HjR2Su7ho6ZQBGIZKZZsreYaHFb9XsUNGpgWFoStG+kMiTldNUbVE0/wj6Z84qZNWRn3wEw//2drcFiFlBZH8/tq2Iolh913ntLf0RChDpk/om+ne4sLW5G7WRxwCJZUvwsgPgn5kf1gY6Ok0o2/UYyNam6LvMexSSakEC1dvY8qVzvdRYVFvE48xlN93iY04Bu3W2qg9HogFbTq/gZ8drkCv8kIhg89 root@ip-111.kvm.ew",
    "key_options": null,
    "keyfile": "/root/.ssh/authorized_keys",
    "manage_dir": true,
    "path": null,
    "state": "present",
    "user": "root",
    "validate_certs": true
}
```
