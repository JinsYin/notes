# playbook

`site.yml`:

```yaml
---
# Defines deployment design and assigns role to server groups

- hosts:
  - mons
  - osds
  - mdss
  - rgws
  - mgrs
  - clients
  #- nfss
  #- restapis
  #- rbdmirrors
  #- iscsigws
  #- iscsi-gws # for backward compatibility only!

  # 其余的没变
```
