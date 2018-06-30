# chainer

## 版本

chainer使用anaconda2安装,有如下版本：

* 版本4.2.0，虚拟环境名为`chainer`, python=3.5
    -   cupy, 4.2.0, 支持cuda与cudnn
    -   ChainerCV, 0.10.0



## 提交作业
```shell
#PBS -N test_chainer
#PBS -q default
#PBS -l nodes=1:ppn=12:gpus=8
#PBS -o /home/NAME/logs
#PBS -e /home/NAME/err_log

module load conda
source activate chainer

cd  $PBS_O_WORKDIR # IMPORTANT
python demo.py
source deactivate
```
更多关于提交作业的内容，请参考[作业系统](../jobs.md)

