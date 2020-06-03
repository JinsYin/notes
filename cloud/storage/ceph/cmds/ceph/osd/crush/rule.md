# ceph osd crush rule

## ls

## dump

## tree

```sh
$ ceph osd crush tree
ID CLASS WEIGHT  TYPE NAME
-1       0.29279 root default
-3       0.09760     host ip-192-168-1-172
 0   ssd 0.04880         osd.0
 1   ssd 0.04880         osd.1
-5       0.09760     host ip-192-168-1-173
 2   ssd 0.04880         osd.2
 4   ssd 0.04880         osd.4
-7       0.09760     host ip-192-168-1-174
 3   ssd 0.04880         osd.3
 5   ssd 0.04880         osd.5
```
