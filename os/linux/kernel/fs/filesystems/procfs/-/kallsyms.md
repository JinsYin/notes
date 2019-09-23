# /proc/kallsyms

提供了内核所有符号的内存地址

## 示例

```sh
$ cat /proc/kallsyms | head -n 10
0000000000000000 A irq_stack_union
0000000000000000 A __per_cpu_start
0000000000000000 A __per_cpu_user_mapped_start
0000000000004000 A vector_irq
0000000000004800 A unsafe_stack_register_backup
0000000000004840 A cpu_debug_store
00000000000048c0 A cpu_tss
0000000000007000 A exception_stacks
000000000000c000 A gdt_page
000000000000d000 A espfix_waddr
```
