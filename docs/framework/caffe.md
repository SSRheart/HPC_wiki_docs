# caffe

### 路径

caffe 的依赖库源码路径：`/share/package/caffelib_packages`  
caffe 的依赖库安装路径：`/share/apps/caffelib`  

caffe 的源码和安装路径均为: `/share/apps/caffe`  

caffe的可执行文件所在的路径是:  
`/share/apps/caffe/build/tools/caffe`

### 提交 caffe 任务
由于没有指定运行时所需要的库，所以一个简单的pbs文件为 
```shell
#PBS -N test_caffe
#PBS -l nodes=1:ppn=16:gpus=8
#PBS -o /home/USERNAME/logs
#PBS -e /home/USERNAME/logs_error
#PBS -q default

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/share/apps/NCCL/lib:/usr/local/cuda/lib64:/share/apps/Opencv-2.4.9/lib:/share/apps/caffelib/lib:/share/apps/MATLAB/R2017a/sys/os/glnxa64

cd YOUR_SCRIPTS_PATH
sh YOUR_SCRIPTS.sh
```

其中:  
`YOUR_SCRIPTS_PATH`指的是你要运行的脚本  
`YOUR_SCRIPTS`所在的路径。

**请注意，如果您申请的gpu数量与您实际使用的gpu数量不一致，作业会被删除**

更多关于任务系统的东西，请参考[任务系统](../jobs.md)。

### pycaffe
使用pycaffe，请先激活anaconda虚拟环境`caffe_single`。  

`source activate caffe_single`

你会注意到此时你的命令行开始有`(caffe_single)`字样。
在此环境下，提交计算任务。



