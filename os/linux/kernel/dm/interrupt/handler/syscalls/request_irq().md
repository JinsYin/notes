# request_irq() - 注册中断处理程序

中断处理程序是硬件驱动程序的一个部分，每个设备都有与之相关联的驱动程序，如果设备使用了中断，那么相应的驱动程序就必须注册一个中断处理程序。在注册过程中，内核会在 `/proc/irq/` 目录中创建一个与中断对应的项。

对硬件驱动程序注册中断处理程序，是为了响应并处理来自硬件的中断 —— 调用相应的中断处理程序。

## 定义

设备驱动程序可以通过 request_irq() 函数注册一个中断处理程序，并激活给定的中断线，以处理中断：

```c
/*
 * <include/linux/interrupt.h>
 */

typedef irqreturn_t (*irq_handler_t)(int, void *);

/*
 * 分配一条给定的中断线
 * Return 成功返回 0，错误返回非 0
 */
static inline int __must_check
request_irq(unsigned int irq,
            irq_handler_t handler,
            unsigned long flags,
	        const char *name,
            void *dev)
{
	return request_threaded_irq(irq, handler, NULL, flags, name, dev);
}
```

| 参数    | 描述                                                                                                               |
| ------- | ------------------------------------------------------------------------------------------------------------------ |
| irq     | 将要分配的中断值                                                                                                   |
| handler | 一个指针，指向处理该中断的中断处理程序                                                                             |
| flags   | 可以是 0，或者一个或多个标志的位掩码                                                                               |
| name    | 中断设备的 ASCII 文本表示；PC 机上键盘中断对应的值为 “keyboard”                                                    |
| dev     | 共享中断线时所指定的唯一标识（cookie）；当注销中断处理程序时，对于共享的中断线，dev 可以区分究竟是哪个中断处理程序 |

## 中断处理程序标志

request_irq() 中 flags 参数的取值：

```c
#define IRQF_SHARED		0x00000080
#define IRQF_PROBE_SHARED	0x00000100
#define __IRQF_TIMER		0x00000200
#define IRQF_PERCPU		0x00000400
#define IRQF_NOBALANCING	0x00000800
#define IRQF_IRQPOLL		0x00001000
#define IRQF_ONESHOT		0x00002000
#define IRQF_NO_SUSPEND		0x00004000
#define IRQF_FORCE_RESUME	0x00008000
#define IRQF_NO_THREAD		0x00010000
#define IRQF_EARLY_RESUME	0x00020000
#define IRQF_COND_SUSPEND	0x00040000

#define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
```

## 注意

request_irq() 函数可能会睡眠，所以不能在中断上下文中其他不允许阻塞的代码中调用该函数。