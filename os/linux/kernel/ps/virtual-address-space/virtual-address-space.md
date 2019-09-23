# 进程虚拟地址空间（进程内存布局）

![进程虚拟地址空间](.images/process-vas.png)

| -     | 描述                                             |
| ----- | ------------------------------------------------ |
| Stack | 包含临时数据，例如方法、函数、返回地址和局部变量 |
| Heap  | 运行时为进程动态分配的内存                       |
| Data  | 包含全局变量和静态变量                           |
| Text  | 程序计数器的值和处理器寄存器的内容表示的当前活动 |

每个进程所分配到的内存由多个部分组成，每个部分称为一个 _段（segment）_（进程虚拟内存的逻辑划分）。

| 段（Segment）                                 | 区域或区域内容                                    | 描述                                                                                                                                                                                                                                        |
| --------------------------------------------- | ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 文本段（text segment）/代码段（code segment） | 进程运行时由 CPU 直接执行的程序机器指令（机器码） | * 文本段具有只读属性，以防止进程通过错误指针意外修改自身指令 <br> * 因为多个进程可以同时运行同一程序，所以又将文本段设为可共享，一份程序代码的拷贝可以映射到所有这些进程的虚拟地址空间中 <br> * 进程运行前就已分配完成                      |
| 数据段（data segment）/已初始化数据段         | 显式初始化的全局变量和静态变量                    | 当程序加载到内存时，从可执行文件中读取这些变量的值                                                                                                                                                                                          |
| bss 段（bss segment）/未初始化数据段          | 未进行显式初始化的全局变量和静态变量              | 在程序启动之前，系统将 BSS（Block Started by Symbol）段所有内存初始化为 0 <br> * 区分数据段和 BSS 段，是因为程序在磁盘上存储时没有必要为未经初始化的变量分配空间，只需记录为 BSS 段的位置及所需大小，直到运行时再由程序加载器来分配这一空间 |
| 栈（stack）                                   | 由栈帧（stack frame）组成的可以动态伸缩的段       | 系统会为每个当前调用的函数分配一个栈帧；栈帧中存储了函数的局部变量（即自动变量）、实参和返回值                                                                                                                                              |
| 堆（heap）                                    | 进程运行时为变量动态分配的内存区域                | * 堆顶端称为 program break  <br> * `malloc()`/`free()` 等系统调用可在堆上动态伸缩内存                                                                                                                                                       |

各个进程的地址空间完全独立，并不会意识到彼此的存在。

## BSS 段

为了效率，BSS 段的未初始化变量被匿名映射到 ”零页“。

## 数据结构

```c
struct mm_struct {
	struct {
		struct vm_area_struct *mmap;		/* list of VMAs */
		struct rb_root mm_rb;
		u64 vmacache_seqnum;                   /* per-thread vmacache */
#ifdef CONFIG_MMU
		unsigned long (*get_unmapped_area) (struct file *filp,
				unsigned long addr, unsigned long len,
				unsigned long pgoff, unsigned long flags);
#endif
		unsigned long mmap_base;	/* base of mmap area */
		unsigned long mmap_legacy_base;	/* base of mmap area in bottom-up allocations */
#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
		/* Base adresses for compatible mmap() */
		unsigned long mmap_compat_base;
		unsigned long mmap_compat_legacy_base;
#endif
		unsigned long task_size;	/* size of task vm space */
		unsigned long highest_vm_end;	/* highest vma end address */
		pgd_t * pgd;

		/**
		 * @mm_users: The number of users including userspace.
		 *
		 * Use mmget()/mmget_not_zero()/mmput() to modify. When this
		 * drops to 0 (i.e. when the task exits and there are no other
		 * temporary reference holders), we also release a reference on
		 * @mm_count (which may then free the &struct mm_struct if
		 * @mm_count also drops to 0).
		 */
		atomic_t mm_users;

		/**
		 * @mm_count: The number of references to &struct mm_struct
		 * (@mm_users count as 1).
		 *
		 * Use mmgrab()/mmdrop() to modify. When this drops to 0, the
		 * &struct mm_struct is freed.
		 */
		atomic_t mm_count;

#ifdef CONFIG_MMU
		atomic_long_t pgtables_bytes;	/* PTE page table pages */
#endif
		int map_count;			/* number of VMAs */

		spinlock_t page_table_lock; /* Protects page tables and some
					     * counters
					     */
		struct rw_semaphore mmap_sem;

		struct list_head mmlist; /* List of maybe swapped mm's.	These
					  * are globally strung together off
					  * init_mm.mmlist, and are protected
					  * by mmlist_lock
					  */


		unsigned long hiwater_rss; /* High-watermark of RSS usage */
		unsigned long hiwater_vm;  /* High-water virtual memory usage */

		unsigned long total_vm;	   /* Total pages mapped */
		unsigned long locked_vm;   /* Pages that have PG_mlocked set */
		atomic64_t    pinned_vm;   /* Refcount permanently increased */
		unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
		unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
		unsigned long stack_vm;	   /* VM_STACK */
		unsigned long def_flags;

		spinlock_t arg_lock; /* protect the below fields */
		unsigned long start_code, end_code, start_data, end_data;
		unsigned long start_brk, brk, start_stack;
		unsigned long arg_start, arg_end, env_start, env_end;

		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */

		/*
		 * Special counters, in some configurations protected by the
		 * page_table_lock, in other configurations by being atomic.
		 */
		struct mm_rss_stat rss_stat;

		struct linux_binfmt *binfmt;

		/* Architecture-specific MM context */
		mm_context_t context;

		unsigned long flags; /* Must use atomic bitops to access */

		struct core_state *core_state; /* coredumping support */
#ifdef CONFIG_MEMBARRIER
		atomic_t membarrier_state;
#endif
#ifdef CONFIG_AIO
		spinlock_t			ioctx_lock;
		struct kioctx_table __rcu	*ioctx_table;
#endif
#ifdef CONFIG_MEMCG
		/*
		 * "owner" points to a task that is regarded as the canonical
		 * user/owner of this mm. All of the following must be true in
		 * order for it to be changed:
		 *
		 * current == mm->owner
		 * current->mm != mm
		 * new_owner->mm == mm
		 * new_owner->alloc_lock is held
		 */
		struct task_struct __rcu *owner;
#endif
		struct user_namespace *user_ns;

		/* store ref to file /proc/<pid>/exe symlink points to */
		struct file __rcu *exe_file;
#ifdef CONFIG_MMU_NOTIFIER
		struct mmu_notifier_mm *mmu_notifier_mm;
#endif
#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
		pgtable_t pmd_huge_pte; /* protected by page_table_lock */
#endif
#ifdef CONFIG_NUMA_BALANCING
		/*
		 * numa_next_scan is the next time that the PTEs will be marked
		 * pte_numa. NUMA hinting faults will gather statistics and
		 * migrate pages to new nodes if necessary.
		 */
		unsigned long numa_next_scan;

		/* Restart point for scanning and setting pte_numa */
		unsigned long numa_scan_offset;

		/* numa_scan_seq prevents two threads setting pte_numa */
		int numa_scan_seq;
#endif
		/*
		 * An operation with batched TLB flushing is going on. Anything
		 * that can move process memory needs to flush the TLB when
		 * moving a PROT_NONE or PROT_NUMA mapped page.
		 */
		atomic_t tlb_flush_pending;
#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
		/* See flush_tlb_batched_pending() */
		bool tlb_flush_batched;
#endif
		struct uprobes_state uprobes_state;
#ifdef CONFIG_HUGETLB_PAGE
		atomic_long_t hugetlb_usage;
#endif
		struct work_struct async_put_work;

#if IS_ENABLED(CONFIG_HMM)
		/* HMM needs to track a few things per mm */
		struct hmm *hmm;
#endif
	} __randomize_layout;

	/*
	 * The mm_cpumask needs to be at the end of mm_struct, because it
	 * is dynamically sized based on nr_cpu_ids.
	 */
	unsigned long cpu_bitmap[];
};
```

## 示例

* `size` 命令

`size` 命令可以查看二进制可执行文件的文本段（text）、已初始化数据段（data）、未初始化数据段（bss）的大小

```sh
$ size /bin/ls
   text	   data	    bss	    dec	    hex	filename
 105182	   2044	   3424	 110650	  1b03a	/bin/ls
```

* 解释说明 C 程序中各个变量属于哪个段

```c
#include <stdio.h>
#include <stdlib.h>

char globBuf[65536];          // bss 段
int primes[] = {2, 3, 5, 7};  // data 段

static int square(int x)      // 在 square() 函数的栈帧中被分配
{
    int result;               // 在 square() 函数的栈帧中被分配

    result = x * x;
    return result;            // 通过寄存器传递的返回值
}

static void doCalc(int val)   // 在 doCalc() 函数的栈帧中被分配
{
    printf("The square of %d is %d\n", val, square(val));

    if (val < 1000) {
        int t;                // 在 doCalc() 函数的栈帧中被分配

        t = val * val * val;
        printf("The cube of %d is %d\n", val, t);
    }
}

int main(int argc, char *argv[])  // 在 main() 函数的栈帧中被分配
{
    static int key = 9973;    // data 段
    static char mbuf[102400]; // bss 段
    char *p;                  // 在 main() 函数的栈帧中被分配

    p = malloc(1024);         // 指向 heap 段中的内存

    doCalc(key);

    exit(EXIT_SUCCESS);
}
```

## 参考

* [进程地址空间](https://github.com/freelancer-leon/notes/blob/master/kernel/mm/mm-1-process_addr_spc.md)
