# Mount Namespace

Linux 内核支持针对每个进程的挂载命名空间（mount namespace），意味着每个进程都可能拥有属于自己的一组文件系统挂载点，因此进程视角下的单根目录层级彼此会有所不同。

进程的文件系统挂载点，见 `/proc/[pid]/mounts`
系统的文件系统挂载点，见 `/proc/mounts`