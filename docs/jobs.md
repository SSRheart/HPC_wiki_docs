# 作业系统

目前集群上安装使用的是AI MAX管理系统，建议使用方式为，申请交互式开发环境进行上机调试，并编写合适的.sh文件。
之后通过`模型训练-任务训练`功能进行任务提交。


## .sh 文件
在.sh文件中，可以直接按照本地terminal格式进行命令撰写，并通过交互式开发环境调试成功，一个简单的.sh文件如：
```shell
#!/bin/bash
# First line is IMPORTANT to assign the executor!

# virtual disk, recommended for small (<15GB) datasets
mkdir /data
mount -t tmpfs -o size=8G,mode=0755 tmpfs /data/
cp -r /opt/data/common/Datasets/DIV2K /data

cd /opt/data/private/imagenet_classification
source ~/anaconda3/etc/profile.d/conda.sh # this command may be essential to initialize conda env list in child bash process
conda activate th1.5 # select your conda env
python train.py --model vgg19 --dataroot /opt/data/default/common/Datasets/ILSVRC12 # main command
# python train.py --model vgg19 --dataroot /data/DIV2K # main command
conda deactivate
```
**值得注意的是**，其中有创建虚拟硬盘的代码，即开辟一部分内存空间为虚拟硬盘，有利于代码提速以及减小网络I/O。这样可以将main command中的路径替换为虚拟硬盘的路径（为挂载到的路径，在本例中即/data）

## 创建训练任务
在创建任务页面，建议设置便于识别的任务名称，并选择"程序代码入口文件"，即创建的.sh文件，**执行器选择shell，机器学习库选择无，程序参数建议在.sh文件中加入，无需填写"超参数调整"项**。

目前提交任务会报"exitCode=126"的错误，这是由于.sh文件没有可执行权限，需要在创建任务前为.sh文件加上可执行权限。
可以启动一个"4GB RAM:1CPU:0GPU"的交互式开发环境，通过ssh连接并cd到.sh文件（假设名为train.sh）所在的文件夹，执行：
```shell
chmod +x train.sh
```

## 关于OSError
会要求AI MAX工程师修改NFS连接参数，遇到OSError即可重新读/写。下面给出一个处理OSError的示例代码。
```python
import time
from functools import wraps
import torch

# 修饰函数，重新尝试600次，每次间隔1秒钟
# 能对func本身处理，缺点在于无法查看func本身的提示
def loop_until_success(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        for i in range(600):
            try:
                ret = func(*args, **kwargs)
                break
            except OSError:
                time.sleep(1)
        return ret
    return wrapper

# 修改后的print函数及torch.save函数示例
@loop_until_success
def loop_print(*args, **kwargs):
    print(*args, **kwargs)

@loop_until_success
def torch_save(*args, **kwargs):
    torch.save(*args, **kwargs)
```
## 镜像
镜像建议选择 vpc-anaconda，该镜像自带pytorch及tensorflow，也欢迎基于该镜像创建自己的环境。如果镜像有任何问题，请联系管理员。
