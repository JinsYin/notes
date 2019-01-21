# Journal

## 日志盘大小

* <https://www.reddit.com/r/ceph/comments/5qho09/journal_disk_size/>

<!--
The journal size should be at least twice the product of the expected drive speed multiplied by filestore max sync interval.
-->

计算公式：`OSD 盘的吞吐量（单位：MB/s）` × `filestore max sync interval（约 40s）` × 2