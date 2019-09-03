# pytorch

## 版本

pytorch使用anaconda2安装,有如下版本：

| 虚拟环境 | Python版本 | PyTorch版本 |
| :---: | :---: | :---: |
| pytorch0.3.0       |  2.7.13 | 0.3.0 |
| py36pytorch0.3.1   |  3.6.3 | 0.3.1 |
| py27pytorch0.4.0   |  2.7.15 | 0.4.0 |
| py36pytorch0.4.0   |  3.6.2 | 0.4.0 |
| py3                | 3.6.6 | 1.0.0.dev20181207 |
| py3pytorch1.2.0    | 3.7.3 | 1.2.0 |

带有torchvision

如果已有环境不能满足需要，可以自行建立新环境。个人用户创建的新环境相互独立。
安装方法见[概要](index.md)

!!! Note

    请注意，经测试，PyTorch1.2.0 已经将GLIBC版本需求降为2.14，因此，集群目前可以用PyTorch 1.0 和1.2，个人环境配置方法见[FAQ](../faq.md)第九条方法一（请勿使用方法二，可能会造成`torch.cuda.is_available() >>> False`）
    请先尝试py3pytorch1.2.0环境，如不能满足需求，可自行建立环境或联系管理员安装需要的包

!!! Note

    使用PyTorch提交作业，请注意计算节点资源占用, System部分的CPU占比较高时，推荐在代码内部最开始的地方添加下列语句(其中num是在作业系统中申请的CPU线程数)，避免频繁切换线程造成系统CPU占用过高，影响自己和他人的运行速度。
```Python
torch.set_num_threads(num) # Sets the number of OpenMP threads used for parallelizing CPU operations
```

## 提交作业

```shell
#PBS -N test_pytorch
#PBS -q default
#PBS -l nodes=1:ppn=16:gpus=8
#PBS -o /home/NAME/logs
#PBS -e /home/NAME/err_log

module load conda
source activate pytorch0.3.0

cd YOUR_WORK_DIRECTORY # IMPORTANT
python demo.py
source deactivate
```
更多关于提交作业的内容，请参考[作业系统](../jobs.md)

