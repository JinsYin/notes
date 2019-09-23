# OpenLDAP

OpenLDAP默认以Berkeley DB作为后端数据库

## 参考

* [OpenLDAP 部署及管理维护](https://www.cnblogs.com/37Y37/p/9315945.html)
* [使用 PAM 集成 OpenLDAP 实现 Linux 统一管理系统用户](https://www.ibm.com/developerworks/cn/linux/1406_liulz_pamopenldap/)

## 操作



## PHPldapAdmin

```sh
$ docker run -p 6443:443 --env PHPLDAPADMIN_LDAP_HOSTS=ldap.example.com --detach osixia/phpldapadmin:0.7.1
```

## 参考

* [Shared Address Book (LDAP)](http://www.brennan.id.au/20-Shared_Address_Book_LDAP.html)

* [Openshift openldap dockerfile](https://github.com/openshift/origin/tree/master/images/openldap)
* [osixia/openldap Dockerfile](https://github.com/osixia/docker-openldap)
* [Kubernetes Authenticating](https://kubernetes.io/docs/admin/authentication/)

* [OpenLDAP 初识](https://blog.mallux.me/2017/03/03/openldap/)
