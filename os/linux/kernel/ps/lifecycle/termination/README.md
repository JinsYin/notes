# 进程终止

1. 将 task_struct 中的 flags 成员设置为 PF_EXITPIDONE
2. x
3. 如果 BSD 的进程记账功能是开启的，调用 `acct_update_integrals()` 函数来输出记账信息
4. 调用 `exit_mm()` 函数释放进程占用的 mm_struct，如果没有别的进程使用它们（即其地址空间没有被共享），就彻底释放它们
5. 调用 `exit_sem()`。如果进程排队等候 IPC 信号，它则离开队列
6.

```c
/*
 * <kernel/exit.c>
 */

/* 永不返回 */
void __noreturn do_exit(long code)
{
	struct task_struct *tsk = current;
	int group_dead;

	profile_task_exit(tsk);
	kcov_task_exit(tsk);

	WARN_ON(blk_needs_flush_plug(tsk));

	if (unlikely(in_interrupt()))
		panic("Aiee, killing interrupt handler!");
	if (unlikely(!tsk->pid))
		panic("Attempted to kill the idle task!");

	/*
	 * If do_exit is called because this processes oopsed, it's possible
	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
	 * continuing. Amongst other possible reasons, this is to prevent
	 * mm_release()->clear_child_tid() from writing to a user-controlled
	 * kernel address.
	 */
	set_fs(USER_DS);

	ptrace_event(PTRACE_EVENT_EXIT, code);

	validate_creds_for_do_exit(tsk);

	/*
	 * We're taking recursive faults here in do_exit. Safest is to just
	 * leave this task alone and wait for reboot.
	 */
	if (unlikely(tsk->flags & PF_EXITING)) {
		pr_alert("Fixing recursive fault but reboot is needed!\n");
		/*
		 * We can do this unlocked here. The futex code uses
		 * this flag just to verify whether the pi state
		 * cleanup has been done or not. In the worst case it
		 * loops once more. We pretend that the cleanup was
		 * done as there is no way to return. Either the
		 * OWNER_DIED bit is set by now or we push the blocked
		 * task into the wait for ever nirwana as well.
		 */
		tsk->flags |= PF_EXITPIDONE;
		set_current_state(TASK_UNINTERRUPTIBLE);

        /*
         * 切换到新的进程
         * 处于 EXIT_ZOMBIE 状态的进程不会再被调度
         */
		schedule();
	}

	exit_signals(tsk);  /* sets PF_EXITING */
	/*
	 * Ensure that all new tsk->pi_lock acquisitions must observe
	 * PF_EXITING. Serializes against futex.c:attach_to_pi_owner().
	 */
	smp_mb();
	/*
	 * Ensure that we must observe the pi_state in exit_mm() ->
	 * mm_release() -> exit_pi_state_list().
	 */
	raw_spin_lock_irq(&tsk->pi_lock);
	raw_spin_unlock_irq(&tsk->pi_lock);

	if (unlikely(in_atomic())) {
		pr_info("note: %s[%d] exited with preempt_count %d\n",
			current->comm, task_pid_nr(current),
			preempt_count());
		preempt_count_set(PREEMPT_ENABLED);
	}

	/* sync mm's RSS info before statistics gathering */
	if (tsk->mm)
		sync_mm_rss(tsk->mm);
	acct_update_integrals(tsk);
	group_dead = atomic_dec_and_test(&tsk->signal->live);
	if (group_dead) {
#ifdef CONFIG_POSIX_TIMERS
		hrtimer_cancel(&tsk->signal->real_timer);
		exit_itimers(tsk->signal);
#endif
		if (tsk->mm)
			setmax_mm_hiwater_rss(&tsk->signal->maxrss, tsk->mm);
	}
	acct_collect(code, group_dead);
	if (group_dead)
		tty_audit_exit();
	audit_free(tsk);

	tsk->exit_code = code;
	taskstats_exit(tsk, group_dead);

	exit_mm();

	if (group_dead)
		acct_process();
	trace_sched_process_exit(tsk);

	exit_sem(tsk);
	exit_shm(tsk);
	exit_files(tsk); /* 递减文件描述符的引用计数，若降为零，则表示没有进程在使用相应的资源，此时可以释放 */
	exit_fs(tsk); /* 递减文件系统数据的引用计数，若降为零，则表示没有进程在使用相应的资源，此时可以释放 */
	if (group_dead)
		disassociate_ctty(1);
	exit_task_namespaces(tsk);
	exit_task_work(tsk);
	exit_thread(tsk);
	exit_umh(tsk);

	/*
	 * Flush inherited counters to the parent - before the parent
	 * gets woken up by child-exit notifications.
	 *
	 * because of cgroup mode, must be called before cgroup_exit()
	 */
	perf_event_exit_task(tsk);

	sched_autogroup_exit_task(tsk);
	cgroup_exit(tsk);

	/*
	 * FIXME: do that only when needed, using sched_exit tracepoint
	 */
	flush_ptrace_hw_breakpoint(tsk);

	exit_tasks_rcu_start();

    /*
     * 向父进程发送信号，给子进程重新找养父，养父为进程组中的其他进程
     * 或 init 进程，并把进程的退出状态（task_struct 结构的 exit_state）
     * 设为 EXIT_ZOMBIE
     */
	exit_notify(tsk, group_dead);

	proc_exit_connector(tsk);
	mpol_put_task_policy(tsk);
#ifdef CONFIG_FUTEX
	if (unlikely(current->pi_state_cache))
		kfree(current->pi_state_cache);
#endif
	/*
	 * Make sure we are holding no locks:
	 */
	debug_check_no_locks_held();
	/*
	 * We can do this unlocked here. The futex code uses this flag
	 * just to verify whether the pi state cleanup has been done
	 * or not. In the worst case it loops once more.
	 */
	tsk->flags |= PF_EXITPIDONE;

	if (tsk->io_context)
		exit_io_context(tsk);

	if (tsk->splice_pipe)
		free_pipe_info(tsk->splice_pipe);

	if (tsk->task_frag.page)
		put_page(tsk->task_frag.page);

	validate_creds_for_do_exit(tsk);

	check_stack_usage();
	preempt_disable();
	if (tsk->nr_dirtied)
		__this_cpu_add(dirty_throttle_leaks, tsk->nr_dirtied);
	exit_rcu();
	exit_tasks_rcu_finish();

	lockdep_free_task(tsk);
	do_task_dead();
}
```

## 删除进程描述符

调用完 `do_exit()` 之后，尽管线程已经僵死不能再运行，但系统仍然保留了它的进程描述符。这样做可以让系统有办法在子进程终结时仍能获得它的信息，因此将进程终止时所需的清理工作和进程描述符的删除分开执行。在父进程获得已终结的子进程的信息后，或者通知内核它并不关注那些信息后，子进程的 task_struct 结构才被释放。

`wait()` 函数族都是通过唯一的一个系统调用 `wait4()` 来实现的。它的标准动作是挂起调用它的进程，直到其中的一个子进程退出，此时函数会返回该子进程的 PID 。此外，调用该函数时提供的指针会包含子函数退出时的退出代码。

当最终需要释放进程描述符时，`release_task()` 会被调用，其完成以下工作：

```c
/*
 * <kernel/exit.c>
 */

void release_task(struct task_struct *p)
{
	struct task_struct *leader;
	int zap_leader;
repeat:
	/* don't need to get the RCU readlock here - the process is dead and
	 * can't be modifying its own credentials. But shut RCU-lockdep up */
	rcu_read_lock();
	atomic_dec(&__task_cred(p)->user->processes);
	rcu_read_unlock();

	proc_flush_task(p);
	cgroup_release(p);

	write_lock_irq(&tasklist_lock);
	ptrace_release_task(p);

    /*
     * 1. 调用了 _unhash_process()，后者又调用了 detack_pid() 从 pidhash 上
     * 删除该进程
     * 2. 从任务列表中删除该进程
     * 3. 释放当前僵尸进程所使用的所有剩余资源，并进行最终统计和记录
     */
	__exit_signal(p);

	/*
	 * If we are the last non-leader member of the thread
	 * group, and the leader is zombie, then notify the
	 * group leader's parent process. (if it wants notification.)
	 */
	zap_leader = 0;
	leader = p->group_leader;
	if (leader != p && thread_group_empty(leader)
			&& leader->exit_state == EXIT_ZOMBIE) {
		/*
		 * If we were the last child thread and the leader has
		 * exited already, and the leader's parent ignores SIGCHLD,
		 * then we are the one who should release the leader.
		 */
		zap_leader = do_notify_parent(leader, leader->exit_signal);
		if (zap_leader)
			leader->exit_state = EXIT_DEAD; /**/
	}

	write_unlock_irq(&tasklist_lock);
	release_thread(p); /**/
	call_rcu(&p->rcu, delayed_put_task_struct);

	p = leader;
	if (unlikely(zap_leader))
		goto repeat;
}
```

## 孤儿进程

如果父进程在子进程之前退出，必须有机制来确保子进程能够找到一个新的父进程，否则孤儿进程会在退出时永远处于僵尸状态。解决办法是给子进程在当前线程组中找一个线程作为父进程，如果不行，就让 init 进程做它们的父进程。在 `do_exit()` 中会调用 `exit_notify()`，该函数会调用 `forget_origin_parent()`，而后者会调用 `find_new_reaper()` 来执行寻父过程：

```c
/*
 * <kernel/exit.c>
 *
 * When we die, we re-parent all our children, and try to:
 * 1. give them to another thread in our thread group, if such a member exists
 * 2. give it to the first ancestor process which prctl'd itself as a
 *    child_subreaper for its children (like a service manager)
 * 3. give it to the init process (PID 1) in our pid namespace
 */
static struct task_struct *find_new_reaper(struct task_struct *father,
					   struct task_struct *child_reaper)
{
	struct task_struct *thread, *reaper;

	thread = find_alive_thread(father);
	if (thread)
		return thread;

	if (father->signal->has_child_subreaper) {
		unsigned int ns_level = task_pid(father)->level;
		/*
		 * Find the first ->is_child_subreaper ancestor in our pid_ns.
		 * We can't check reaper != child_reaper to ensure we do not
		 * cross the namespaces, the exiting parent could be injected
		 * by setns() + fork().
		 * We check pid->level, this is slightly more efficient than
		 * task_active_pid_ns(reaper) != task_active_pid_ns(father).
		 */
		for (reaper = father->real_parent;
		     task_pid(reaper)->level == ns_level;
		     reaper = reaper->real_parent) {
			if (reaper == &init_task)
				break;
			if (!reaper->signal->is_child_subreaper)
				continue;
			thread = find_alive_thread(reaper);
			if (thread)
				return thread;
		}
	}

	return child_reaper;
}
```
