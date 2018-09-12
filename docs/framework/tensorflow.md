# tensorflow

## 版本

tensorflow使用anaconda2安装,版本1.3，虚拟环境名为tensorflow, 此环境中python 版本2.7。

如果已有环境不能满足需要，可以自行建立新环境。个人用户创建的新环境相互独立。  
安装方法见[概要](index.md)

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

