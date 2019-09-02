# phpLDAPadmin

## Docker 部署

```sh
$ docker run -p 6443:443 --env PHPLDAPADMIN_LDAP_HOSTS=ldap.example.com --detach osixia/phpldapadmin:0.7.1
```