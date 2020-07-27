# 作业系统

目前集群上安装使用的是AI MAX管理系统，建议使用方式为，申请交互式开发环境进行上机调试，并编写合适的.sh文件。
之后通过`模型训练-任务训练`功能进行任务提交。


## .sh 文件
在.sh文件中，可以直接按照本地terminal格式进行命令撰写，并通过交互式开发环境调试成功，一个简单的.sh文件如：
```shell
#!/bin/bash  # IMPORTANT! Assign the executor!
cd /opt/data/private/imagenet_classification
source ~/anaconda3/etc/profile.d/conda.sh # this command may be essential to initialize conda env list in child bash process
conda activate th1.5 # select your conda env
python train.py --model vgg19 --dataroot /opt/data/default/common/Datasets/ILSVRC12 # main command
conda deactivate th1.5
```

## 创建训练任务
在创建任务页面，建议设置便于识别的任务名称，并选择"程序代码入口文件"，即创建的.sh文件，执行器选择shell，机器学习库选择无，程序参数建议在.sh文件中加入，无需填写"超参数调整"项。

镜像建议选择 vpc-anaconda，该镜像自带pytorch及tensorflow，也欢迎基于该镜像创建自己的环境。如果镜像有任何问题，请联系管理员。
