# tensorflow

## 版本

tensorflow使用anaconda2安装,版本1.3，虚拟环境名为tensorflow, 此环境中python 版本2.7。

如果已有环境不能满足需要，可以自行建立新环境。个人用户创建的新环境相互独立。  
安装方法见[概要](index.md)


!!! Note

    使用Tensorflow提交作业，请注意计算节点资源占用, System部分的CPU占比较高时，推荐在代码内部将创建session的语句修改为下列语句(其中num是在作业系统中申请的CPU线程数)，避免频繁切换线程造成系统CPU占用过高，影响自己和他人的运行速度。
```Python
cpu_config = tf.ConfigProto(intra_op_parallelism_threads = num, inter_op_parallelism_threads = num, device_count = {'CPU': num})
sess = tf.Session(config=cpu_config)
```

## 提交作业
```shell
#PBS -N test_pytorch
#PBS -q default
#PBS -l nodes=1:ppn=12:gpus=8
#PBS -o /home/NAME/logs
#PBS -e /home/NAME/err_log

module load conda
source activate tensorflow

cd YOUR_WORK_DIRECTORY # IMPORTANT
python demo.py
source deactivate
```
更多关于提交作业的内容，请参考[作业系统](../jobs.md)

