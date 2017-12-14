
### Matlab & Matconvnet的使用说明
Matlab(2017)的安装路径是`/share/apps/MATLAB/R2017a/bin/matlab`

Matconvnet的编译路径是`/share/apps/matconvnet/matconvnet-1.0-beta$(version)`

使用的时候确认自己的matconvnet的版本，然后将matconvnet的路径指向上述目录即可。
这些都是编译好的，您`不再需要`手动编译。

现在Matlab与MatConvNet只支持单机版本，但仍然需要通过openpbs排队系统来提交作业。

#### 如何不用图形界面跑matlab程序

比如您要跑的程序是demo.m，那么您的PBS文件应该是这个样子：
```shell
#PBS -N MATLAB_TEST
#PBS -l nodes=1:ppn=4:gpus=4
#PBS -q default
#PBS -o /home/USERNAME/logs/log
#PBS -e /home/USERNAME/logs/errlog

cd YOUR_M_PATH # YOUR_M_PATH 指的是您的demo.m所在的文件夹
/share/apps/MATLAB/R2017a/bin/matlab -r -nodesktop "demo"
```
然后提交这个任务文件就可以了。
请参考[任务系统](../jobs.md)。

#### MatConvNet版本
-	10: without cudnn supported
-	21: cuda 8.0 + cudnn 5.0
-	23: cuda 8.0 + cudnn 5.0
-	25: cuda 8.0 + cudnn 5.0

若您需要别的版本支持，请联系管理员。
