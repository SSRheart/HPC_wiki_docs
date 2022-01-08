# 集群概况

## 硬件资源
本集群由一个管理、存储节点和7个计算节点组成。本文档中将以`master` 以及 `n001`, `n002` ... `n009` 分别标识。
当前，集群管理系统为[AI MAX](http://www.amaxchina.com/Product/Introduction/AIMAX)。

### Master 节点
Master 节点是集群管理系统的入口。普通计算用户需要在 Master 节点创建计算任务或者交互式开发环境，无需进行与计算节点有关的操作。

Master 节点配置有

Device | Details
--- | ---  ---
CPU | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz  x16
磁盘 (SSD) | 总计约 500 GB，为 AI MAX 系统盘，RAID 1 备份，对用户不可见。
磁盘 (HDD) | 总计约 4 TB，为 AI MAX 存储空间，用于存储镜像等，RAID 1 备份，对用户不可见。
磁盘 (HDD) | 总计约 24 TB，为用户存储空间，RAID 5 容错备份，在任务运行中，访问地址为`/opt/data/common`及`/opt/data/private`。
内存 | 128G

### 计算节点
计算节点负责接受master节点分配调度的任务，进行实际的深度网络训练、测试等工作。

其中，n002,n003,n004,n006,n008，配置有

Device | Details
--- | ---
CPU | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz  x16
GPU | NVIDIA GeForce GTX 1080 Ti x8
磁盘 (SSD) | 500 GB
内存 | 256 GB

n007,n009，配置有

Device | Details
--- | ---
CPU | Intel(R) Xeon(R) CPU 4210 @ 2.20GHz  x20
GPU | NVIDIA GeForce RTX 2080 Ti x8
磁盘 (SSD) | 1000 GB
内存 | 256 GB

## 系统版本
`AI MAX 4.5.0`

## 开发工具栈

* NVIDIA Driver 450.57 (最高支持 cuda 11.0)
* Anaconda
* PyTorch
* Tensorflow
* Caffe

关于实际使用各框架或软件进行训练学习，请继续阅读本文档的[框架](framework/index.md)部分。

## 常用目录
* `/opt/data/common/Datasets` 用于存放各种数据集。该目录仅管理员可以上传，为避免重复上传，请大家将数据上传到自己目录后，告诉管理员移动到公共文件夹。
* **管理员**可在ssh后台，直接通过`mv`命令执行上述操作，common及个人目录地址为`/opt/data/default`