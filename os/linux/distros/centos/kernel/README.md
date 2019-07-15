# CentOS 内核

## 相关软件包

| Package            | Description |
| ------------------ | ----------- |
| `kernel`           |             |
| `kernel-devel`     |             |
| `kernel-PAE`       |             |
| `kernel-PAE-devel` |             |
| `kernel-doc`       |             |
| `kernel-headers`   |             |
| `kernel-xen`       |             |
| `kernel-xen-devel` |             |

kernel — Contains the kernel for multi-processor systems. For x86 system, only the first 4GB of RAM is used. As such, x86 systems with over 4GB of RAM should use the kernel-PAE.

kernel-devel — Contains the kernel headers and makefiles sufficient to build modules against the kernel package.

kernel-PAE (only for i686 systems) — This package offers the following key configuration options (in addition to the options already enabled for the kernel package):

Support for over 4GB of RAM (up to 64GB for the x86)

PAE (Physical Address Extension) or 3-level paging on x86 processors that support PAE

4GB/4GB split: 4GB of virtual address space for the kernel and almost 4GB for each user process on x86 systems

kernel-PAE-devel — Contains the kernel headers and makefiles required to build modules against the kernel-PAE package

kernel-doc — Contains documentation files from the kernel source. Various portions of the Linux kernel and the device drivers shipped with it are documented in these files. Installation of this package provides a reference to the options that can be passed to Linux kernel modules at load time.

By default, these files are placed in the /usr/share/doc/kernel-doc-<version>/ directory.

kernel-headers — Includes the C header files that specify the interface between the Linux kernel and userspace libraries and programs. The header files define structures and constants that are needed for building most standard programs.

kernel-xen — Includes a version of the Linux kernel which is needed to run Virtualization.

kernel-xen-devel — Contains the kernel headers and makefiles required to build modules against the kernel-xen package

> https://www.centos.org/docs/5/html/Deployment_Guide-en-US/ch-kernel.html