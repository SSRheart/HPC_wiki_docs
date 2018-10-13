
### Matlab & Matconvnet的使用说明
Matlab(R2017a)的安装路径是`/share/apps/MATLAB/R2017a/bin/matlab`

Matconvnet的编译路径是`/share/apps/matconvnet/matconvnet-1.0-beta$(version)`

使用的时候确认自己的matconvnet的版本，然后将matconvnet的路径指向上述目录即可。
这些都是编译好的，您`不再需要`手动编译。

现在Matlab与MatConvNet只支持单机版本，但仍然需要通过openpbs排队系统来提交作业。

#### 如何不用图形界面跑Matlab程序
服务器端没有桌面环境，运行方式与桌面环境下有所不同。

比如您要跑的程序是demo.m，那么您的PBS文件应该是这个样子：
```shell
#PBS -N MATLAB_TEST
#PBS -l nodes=1:ppn=4:gpus=4
#PBS -q default
#PBS -o /home/USERNAME/logs/log
#PBS -e /home/USERNAME/logs/errlog

module load MATLAB/R2017a
cd YOUR_M_PATH # YOUR_M_PATH 指的是您的demo.m所在的文件夹
matlab -r -nodesktop "demo"

module unload MATLAB/R2017a
```
然后提交这个任务文件就可以了。
请参考[任务系统](../jobs.md)。

#### MatConvNet版本
-	10: without cudnn supported
-	21: cuda 8.0 + cudnn 5.0
-	23: cuda 8.0 + cudnn 5.0
-	25: cuda 8.0 + cudnn 5.0

若您需要别的版本支持，请联系管理员。

### 关于Matlab的多线程
目前系统并未限制用户可以申请的线程数量，但在使用Matlab编程时，如果你使用了过多线程，可能会导致系统负载过高。具体表现为系统负载飙红，CPU占用上system 系统进程占用了很大比例，这种情况下就提示你可能线程设置过多。

要使用单线程的Matlab，样例运行语句如`maltab -r -nodesktop -singleCompThread "demo"`。

建议使用限制计算线程数的命令，即将`maxNumCompThreads(num)`添加到程序文件。

`maxNumCompThreads`命令[官方说明](https://ww2.mathworks.cn/help/matlab/ref/maxnumcompthreads.html;jsessionid=f3459476d47b9090b40068db3ef4)如下：
```matlab
N = maxNumCompThreads      % 返回计算线程的当前最大数目 N
LASTN = maxNumCompThreads(N)     % 将计算线程的最大数目设置为 N，并返回计算线程的上一个最大数目 LASTN
LASTN = maxNumCompThreads('automatic')     % 使用 MATLAB 软件确定为最合适的量来设置计算线程的最大数目。此外，还会返回计算线程的上一个最大数目 LASTN
```
当前，计算线程的最大数目等于计算机上的计算内核的数目。
