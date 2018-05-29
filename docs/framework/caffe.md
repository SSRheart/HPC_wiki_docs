# caffe

### 策略

caffe 添加新层后需要整体重新编译，故从18年5月起，更改caffe的使用策略为用户在自己目录下自行编译caffe

### 路径(仅需了解）

caffe 的依赖库安装路径：`/share/apps/caffelib`

公用版caffe 的源码和安装路径均为: `/share/package/caffe` 
(可作为自行编译时Makefile和Makefile.config的参考)


### 编译Caffe
1.  下载Caffe源码到自己的目录，或将`/share/package/caffe` 复制到自己目录。注意后者不是原版caffe

2. 运行：
```shell
# choose a relatively free node and ssh because GPU is needed to compile caffe

ssh node2
module load caffe_basic
module load gcc

cd $YOUR_CAFFE_PATH

# edit Makefile and Makefile.config as you need
# you may want to take /share/package/caffe/Makefile.config as a reference

make all -j32
make pycaffe
```

将`YOUR_CAFFE_PATH/caffe`路径加入到`$PYTHONPATH`, 比如写入`.bashrc`末尾。


### pycaffe

pycaffe接口在`$YOUR_CAFFE_PATH/python`中, 

如果您要运行pycaffe，那么一个pbs文件的模板为
```shell
#PBS -N test_caffe
#PBS -l nodes=1:ppn=16:gpus=8
#PBS -o /home/USERNAME/logs
#PBS -e /home/USERNAME/logs_error
#PBS -q default

# without this line, you may encounter 'caffe: module not found' error
export PYTHONPATH=$YOUR_CAFFE_PATH/python:$PYTHONPATH

# this line provides some configuration to $PATH and $LD_LIBRARY_PATH
module load caffe_basic

## write your code here
cd YOUR_SCRIPTS_PATH
sh YOUR_SCRIPTS.sh

module unload caffe_basic
```

其中:
`YOUR_SCRIPTS_PATH`指的是你要运行的脚本`YOUR_SCRIPTS`所在的路径。

`YOUR_CAFFE_PATH`指的是你目录下`caffe`的路径。如`/home/user1/caffe`

更多关于提交作业的内容，请参考[作业系统](../jobs.md).

!!! Warning
    **请注意，如果您申请的gpu数量与您实际使用的gpu数量不一致，作业会被删除** <br/>




!!! Warning
    caffe程序的命令行参数中，如果带有gpu选项指定使用的gpu，请始终从0开始写起，即使当前0号GPU已经被占用。

    例如：
    当前node1节点gpu0,gpu1已经被占用。现需要继续在node1上提交另外的caffe任务

    * 如果需要申请一个gpu:  
      #PBS -l 申请资源中gpus=1  
      caffe命令行参数 --gpu 0  
 
    * 如果需要申请两个gpu: 
      #PBS -l 申请资源中gpus=2  
      caffe命令行参数 --gpu 0,1  

    注意正如上面提到的，命令行参数请始终从0开始写起。集群任务调度系统能够自行调度实际GPU。



