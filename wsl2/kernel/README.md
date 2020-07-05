# WSL2-Linux-Kernel

* https://github.com/khs1994/WSL2-Linux-Kernel

> 所构建的内核请到 Actions 详情页右上角 Artifacts 下载 [例如(请到最新的构建结果处下载,这里仅仅是示例)](https://github.com/khs1994/WSL2-Linux-Kernel/commit/591f8bd0120ccc4e726f7b9444337a4dc8b8e1dd/checks?check_suite_id=263673284)

如何使用请查看

* https://github.com/khs1994-docker/lnmp/blob/19.03/kubernetes/wsl2/README.KERNEL.md

## .deb

* `/lib/modules/$(uname -r)`
* `/usr/include`
* `/usr/src/linux-headers-$(uname -r)`

## .img

在 Windows `~/.wslconfig` 中配置内核地址

## modules.builtin

* `/lib/modules/$(uname -r)/modules.builtin`

## 新增模块

* nfs
* iscsi

## 内存回收

* https://devblogs.microsoft.com/commandline/memory-reclaim-in-the-windows-subsystem-for-linux-2/

使用官方版本的 [Linux](https://github.com/torvalds/linux) 构建的内核，使用 `memory-reclaim.diff` patch 以启用内存回收功能。
