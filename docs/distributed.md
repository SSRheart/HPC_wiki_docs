# 分布式训练

## 概述
由于模型训练batch size或者训练时长的约束，有时我们会需要进行多卡甚至多机多卡进行分布式训练，以更快地完成任务训练。其中，单机多卡任务只需要机器学习框架本身即可完成，但是多机多卡训练依赖于训练框架本身包含的分布式训练组件或者额外的分布式任务系统来提供支持。AI MAX集群当前默认提供基于Horovod的分布式框架以完成Tensorflow/PyTorch的分布式训练。此外，在交互式开发中，由于每个实例本质上就可以构成一个可以自由配置环境的计算节点，因此可以更灵活地选择自己用起来最习惯的分布式框架完成多机多卡的训练从而加速训练任务。下面以PyTorch和Horovod为例，介绍一下如何将现有的训练代码迁移到Horovod分布式框架。

## 基本定义
world size: 分布式任务中计算硬件的总数，一般以单个GPU或者CPU作为单位计数（例如2机/单机4卡，world size为8）。
rank: 分布式任务中每个计算硬件的编号（例如单机多卡或者多机多卡的话就是给每个GPU编号）。rank编号范围为0到world_size-1。
local rank: 在每个计算节点中，每个计算硬件的编号。编号范围为0到节点计算硬件数-1。
all reduce: 将每个GPU中的变量值归并，并将归并后的值返回到每个GPU上。
gather: 将每个GPU中的变量值归并，集中到GPU 0上。

## 修改你的训练代码
走通流程时我基于自己正在进行的实验进行配置，因此我在走通流程环节选用了[SwAV](https://github.com/facebookresearch/swav)，在迁移过程中，我选用了[Horovod example](https://github.com/horovod/horovod/tree/master/examples)作为参考来辅助迁移过程。下面将陈述完整的修改流程。

首先是需要初始化horovod的分布式环境。
```python
import horovod.torch as hvd
hvd.init()
torch.cuda.set_device(hvd.local_rank())
```
init之后其实就可以在程序中获取每个进程（或者说对应的每个GPU）的rank信息了。初始化分布式环境完成。

对于Dataset部分无需做出改变，但是由于是分布式环境，所以一个分布式的sampler是必需的，其中DistributedSampler会根据数据所在rank自动划分数据块去获取batch。同时对于dataloader，也需要使用分布式sampler来进行数据batch的调度。
```python
sampler = torch.utils.data.distributed.DistributedSampler(train_dataset, num_replicas=hvd.size(), rank=hvd.rank())
train_loader = torch.utils.data.DataLoader(
        train_dataset,
        sampler=sampler,
        batch_size=args.batch_size,
        num_workers=args.workers,
        pin_memory=True, # 是否使用pin_memory有待商榷，实际经验速度不一定能提高
        drop_last=True
    )
```
然后就是常规的构造model和optimizer的流程，对于以往的单机模型，直接操作即可，但如果你的model是用DistributedDataParallel构造过的，请去掉这一步，这一步和horovod相冲突。对于optimizer，由于gradient等信息也是需要同步的，所以此处需要用horovod自己的DistributedOptimizer去包裹一下，这样操作和horovod的设计原理有关。需要注意的是，NVIDIA的apex也包含一些组件，可以扩展现有的PyTorch Optimizer，但是horovod并不能识别，所以请按照PyTorch的标准调用现有optimizer或者自己实现。
```python
model = resnet_models.__dict__[args.arch](
        normalize=True,
        hidden_mlp=2048 if args.arch == "resnet50" else 2048 * int(args.arch[-1]),
        output_dim=args.feat_dim,
        nmb_prototypes=args.nmb_prototypes,
    )
# copy model to GPU
model = model.cuda()
optimizer = LARS(model.parameters(), lr=args.base_lr, momentum=args.momentum, weight_decay=args.wd)
# Horovod: (optional) compression algorithm.
compression = hvd.Compression.fp16 if args.fp16_allreduce else hvd.Compression.none
# Horovod: wrap optimizer with DistributedOptimizer.
optimizer = hvd.DistributedOptimizer(
        optimizer, named_parameters=model.named_parameters(),
        compression=compression,
        backward_passes_per_step=args.batches_per_allreduce,
        op=hvd.Adasum if args.use_adasum else hvd.Average)
```
最后一步，在开始训练流程前设置model和optimizer
的broadcast，可以理解为同步参数的意思。
```python
# Horovod: broadcast parameters & optimizer state.
hvd.broadcast_parameters(model.state_dict(), root_rank=0)
hvd.broadcast_optimizer_state(optimizer, root_rank=0)
```
其他的和原有的训练代码相同，不需要做额外的改变，只需要针对相应的位置做all reduce或者all gather即可。

## 交互式开发部分
由于交互式开发中的实例本身就是计算节点，所以我们可以先申请需要的GPU资源，然后手动配置环境。
对于两节点合计四GPU的计算资源，如果要在上面执行Horovod+PyTorch的训练程序，大致原理是这样的。

![](https://i.loli.net/2020/08/01/SE4eimkO7t5bdUs.png)

根据这个，我们需要在每个实例上配置：PyTorch环境，SSH及SSH Keys，NCCL2，OpenMPI，Horovod。
PyTorch环境，可以直接使用VPC的镜像来替代，只需要额外配置自己需要的package即可。
#### SSH & SSH Keys
OpenSSH在实例上已有安装，所以只需要创建SSH Key即可。由于在实例间只需要构造SSH免密连接来在多个机器上启动多个进程，所以需要将创建好的公钥直接导入authorized_keys文件，然后在所有节点均保存一份相同的公钥/私钥/授权的key，可以通过创建镜像直接部署到所有实例，也可以通过私有数据路径中转。
```shell
ssh-keygen -t rsa
cp .ssh/id_rsa.pub .ssh/authorized_keys
# create snapshot and restore to all instances
```
#### NCCL
GPU间通信依赖于NCCL，这一步配置较简单，只需要用apt安装即可
```shell
apt install libnccl2 libnccl-dev
```

#### OpenMPI
OpenMPI是Horovod能够进行分布式任务维护的基础，可以视为是Horovod的后端，Horovod的指令也可以和MPI的指令兼容。配置方法如下。
```shell
wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.4.tar.gz
tar -xvf openmpi-4.0.4.tar.gz
cd openmpi-4.0.4
./configure --prefix=/usr/local && make all install
```

#### Horovod
```shell
HOROVOD_GPU_OPERATIONS=NCCL pip install horovod
```

#### 获取实例的IP
Horovod需要知道计算节点的地址来调度所有训练进程，所以需要有个办法获知实例的IP。此处需要安装net-tools来获取Ubuntu的网络状态。
```shell
apt install net-tools
ifconfig -a
```

#### 创建与部署镜像
这一步在集群首页用网页操作就行，不再赘述。

#### 执行
因为是交互式开发，所以执行流程完全可以照搬单机提交任务训练里的shell去写script。由于训练程序已经改造成Horovod相关的代码了，所以需要在主要command前加上horovodrun -np $gpu_num -H IP1:$gpu_num1,IP2:gpu_num2... python ...

## 任务训练部分（coming soon）
截至最后一次整理该文档时，没有更多的GPU资源来调试任务训练部分，所以该部分内容将在稍后进行补充。
