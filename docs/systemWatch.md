# 系统监测

本节列出几种系统监测工具，供查看CPU/GPU/内存等硬件资源占用情况、任务排队情况等。  

## Ganglia
Ganglia 是一个开源监视项目，设计用来监测收集大量节点的系统状态数据,已经编译安装到本集群上。能够收集并展示Master及6个计算节点的资源使用情况。  

普通计算用户可以通过[ganglia主页](http://219.217.238.193/ganglia)来进行观察。 


在ganglia主页的`HPC_cluster Grid > HPC_cluster > [Choose a Node]` 下拉列表中，可以选择具体计算节点或master观察。从计算节点收集的数据包括  

* cpu 占用(system/user/idle)  
* 磁盘空间余量  
* GPU使用率/显存使用率/温度/风扇转速 (仅计算节点)  
* 内存使用率  
* 系统负载(Load)  
* 网络状态  
* 进程统计  

## Torque job Web页面
访问[/jobs](http://219.217.238.193/jobs) 能够看到当前所有任务的统计信息. 

## 常用系统运行状态检测指令

### top 命令

给出实时动态的进程列表和系统状态

参考：[top 使用实例](https://linux.cn/article-2352-1.html)

### ps 命令

显示被选中的系统活跃进程的信息。

例如  
`ps aux | grep yourUserName`
将会列出活跃的属于`yourUserName`用户的进程。

### vmstat 命令
"可以展现给定时间间隔的服务器的状态值,包括服务器的CPU使用率，内存使用，虚拟内存交换情况,IO读写情况"

对于系统进程占用CPU过高、负载异常的时候，top和ps可能不足以定位问题，可以结合`vmstat`命令进一步排查。
