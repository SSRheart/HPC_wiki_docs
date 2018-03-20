# pytorch

## 版本

pytorch使用anaconda2安装,有如下版本：  

* 版本0.3.0，虚拟环境名为`pytorch0.3.0`, python=2.7   
* 版本0.3.1，虚拟环境名为`py36pytorch0.3.1`, python=3.6    

带有torchvision


## 提交作业
```shell
#PBS -N test_pytorch
#PBS -q default
#PBS -l nodes=1:ppn=12:gpus=8
#PBS -o /home/NAME/logs
#PBS -e /home/NAME/err_log

source /share/apps/anaconda2/bin/activate pytorch0.3.0

cd YOUR_WORK_DIRECTORY # IMPORTANT
python demo.py
source deactivate
```
更多关于提交作业的内容，请参考[作业系统](../jobs.md)

