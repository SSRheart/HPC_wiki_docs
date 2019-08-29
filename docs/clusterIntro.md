# 集群概况

## 硬件资源
本集群由6个计算节点和一个管理、存储节点组成。本文档中将以`node1`, `node2` ... `node6` 以及 `master` 分别标识。

### 计算节点
计算节点负责接受master节点分配调度的任务，进行实际的深度网络训练、测试等工作。

在每个计算节点上，配置有

Device | Details
--- | ---
CPU | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz  x16
GPU | NVIDIA GeForce GTX 1080 Ti x8
磁盘 (SSD) | 500G，可用约400G
磁盘 (HDD) | 2T，挂载目录为`/dataset`
内存| 125G

### Master 节点
Master 节点是用户远程连接的入口节点。普通计算用户只需在master上提交计算程序，保存网络模型等操作，无需进行与计算节点有关的操作。

Master 节点配置有

Device | Details
--- | ---  ---
CPU | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz  x16
GPU | NVIDIA Geforece GT 710 x1 (with CUDA10)
磁盘 (HDD) | 总可用约3.6T，挂载目录为`/share`
磁盘 (HDD) | 总可用约7.3T，挂载目录为`/share/data`
内存| 125G


## 系统版本
`Red Hat Enterprise Linux Server release 6.8 (Santiago)`

## 开发工具栈

* NVIDIA Driver 430.14
* CUDA(cuDNN) 8.0(5.0.5), 9.0(7.2.1), 10.0(7.5.1)
* Torque资源管理系统 6.0.2
* MATLAB R2017a
* Opencv 2.4.9
* Anaconda
* PyTorch
* Tensorflow
* Caffe
* Torch

底层依赖

* gcc,g++ 4.4.7(default), 4.8.2, 5.3.1
* cmake 2.8

截止目前，已经完成pytorch，caffe, Matlab 等框架或软件的安装。
关于实际使用各框架或软件进行训练学习，请继续阅读本文档的[框架](framework/index.md)部分。

## 常用目录
* /share/Dataset 用于存放各种数据集。为了避免重复占用空间，请将用到的数据集统一放到这个目录下，请勿重复添加
* /share/apps 主要程序安装目录
* /share/packages 主要安装包下载目录、源码编译目录
* /share/data 用于存放个人数据，请勿过多占用/share目录（即个人目录），容易造成任务停止工作
