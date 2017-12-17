# caffe

### 路径

caffe 的依赖库源码路径：`/share/package/caffelib_packages` 
 
caffe 的依赖库安装路径：`/share/apps/caffelib`

caffe 的源码和安装路径均为: `/share/package/caffe`

caffe的可执行文件所在的路径是:
`/share/package/caffe/build/tools/caffe`

### 提交 caffe 任务
由于没有指定运行时所需要的库，所以一个简单的pbs文件为
```shell
#PBS -N test_caffe
#PBS -l nodes=1:ppn=16:gpus=8
#PBS -o /home/USERNAME/logs
#PBS -e /home/USERNAME/logs_error
#PBS -q default

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/share/apps/NCCL/lib:/usr/local/cuda/lib64:/share/apps/Opencv-2.4.9/lib:/share/apps/caffelib/lib:/share/apps/MATLAB/R2017a/sys/os/glnxa64

## write your code here
cd YOUR_SCRIPTS_PATH
sh YOUR_SCRIPTS.sh
```

其中:  
`YOUR_SCRIPTS_PATH`指的是你要运行的脚本  
`YOUR_SCRIPTS`所在的路径。

!!! Warning
**请注意，如果您申请的gpu数量与您实际使用的gpu数量不一致，作业会被删除**  
**另外，在涉及到文件中各种路径的地方，建议使用绝对路径而不是相对路径**


更多关于提交作业的内容，请参考[作业系统](../jobs.md).

### pycaffe

pycaffe同样在`/share/package/caffe/python`中

如果您要运行pycaffe，那么一个pbs文件的模板为
```shell
#PBS -N test_caffe
#PBS -l nodes=1:ppn=16:gpus=8
#PBS -o /home/USERNAME/logs
#PBS -e /home/USERNAME/logs_error
#PBS -q default

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/share/apps/NCCL/lib:/usr/local/cuda/lib64:/share/apps/Opencv-2.4.9/lib:/share/apps/caffelib/lib:/share/apps/MATLAB/R2017a/sys/os/glnxa64
export PYTHONHOME=/share/package/caffe/python

## write your code here
cd YOUR_SCRIPTS_PATH
sh YOUR_SCRIPTS.sh
```
