# TensorBoard

###  介绍
[官网链接](https://www.tensorflow.org/guide/summaries_and_tensorboard)  

###  安装

假定你服务器端的Python虚拟环境名为`pyEnv`，首先需要在服务器终端中进行以下操作：

    source activate pyEnv
    
    # tensorflow is needed
    # conda install tensorflow

    # tensorboardX is needed if using PyTorch
    # conda install tensorboardx

    tensorboard --logdir=yourLogDir/

然后在你本地终端中运行：  
    
    ssh -L 16006:127.0.0.1:6006 yourUserName@219.217.238.193

最后在本地浏览器中打开:
    
    localhost:16006/

就可以看到服务器上的Summary信息了


### 如果遇到问题..

服务器上启动tensorboard遇到`local.Error: unsupported locale setting`时，
先执行`export LC_ALL=C` 再启动tensorboard
