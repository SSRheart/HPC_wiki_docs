# 作业系统

目前集群上安装使用的是Torque资源管理系统，计算作业的执行通过提交Torque 作业(job)进行。


## 作业脚本
作业脚本用来描述执行计算作业的程序或命令，以及相应的运行参数(参数也可在提交作业时在命令行中指定)

一个示例脚本 `run_job_demo.pbs` 如下:  
```
#PBS -N myjob1
#PBS -o /home/username/myjob1.out
#PBS -e /home/username/myjob1.err
#PBS -l nodes=1:ppn=1:gpus=1
#PBS -r y

cd $PBS_O_WORKDIR  #需要进入到实际代码目录

echo Time is `date` # 打印一些log信息
echo Directory is $PWD
echo This job runs on following nodes:
cat $PBS_NODEFILE
cat $PBS_GPUFILE

./my_proc  # 实际工作程序
```


注意最开始几行`#PBS`中的`#`不是shell脚本中的注释符号， `#PBS`表明本行之后为定义参数。  
申请资源的参数是小写字母`l`

torque可指定的参数及解释:

option | meaning
--- | --- 
`-e` | e(rror), 指定标准错误输出文件。 设置为/dev/null则丢弃错误输出
`-j` | j(oin) 合并系统输出，如果指定为`oe`,则将标准输出stdout和标准错误输出stderr合并为stdout, 
     |           如果指定为`eo`,则将标准错误输出stderr和标准输出stdout合并为stderr 
`-l` | 指定作业使用的节点和CPU、GPU 资源
`-N` | N(ame) 作业名称，应当具有一定标识性
`-o` | o(utput), 指定标准输出文件,设置为/dev/null则丢弃输出
`-q` | 指定排队队列
`-r` | r(erunable) 是否设置作业的`可重复执行`属性为True, 即节点故障的情况下作业是否可以重复执行
`-S` | 指定用来处理作业脚本的程序，一般为shell程序
`-m` | m(ail) 指定何种情况发送邮件（邮件功能暂未开放, 此选项暂时无效)


!!! Note
    如果没有指定标准输出和错误输出文件，在用户提交作业的目录下将会生成`jobname.o${jobid}` 和`jobname.e${jobid}`两个文件来收集这两个信息。

    注意，如果您预料到标准输出/错误输出会很大，建议您减少输出或者将输出丢弃。并将有用的结果在程序中保存到别的文件中去。   
 
!!! Note 
    关于`-l` 的详细说明：

    nodes=X:ppn=Y:gpus=Z  

    nodes=X 指定使用X个节点. 也可以指定nodes=nodeX (X可取1/2/..6)  
    如果使用nodes=nodeX 指定的方式，请先查看[/jobs](http://219.217.238.193/jobs)获得可用节点的信息   
    或者使用本节后面的`pbsnodes -l free`命令，以免造成不必要的排队等待。  

    ppn=Y 指定每个节点使用CPU的数量(processor per node)  
    ppn=Y 的上限为32  

    gpus=Z 指定使用GPU的数量  

    对于不支持多机并行的框架，应选择nodes=1, 且gpus的上限为8. 
    受限于编译支持多机并行特性较为复杂，目前caffe/MATLAB/pytorch采用上述单机多GPU的方式。  

    推荐按照ppn:gpus = 4:1的比例来申请资源, 实际申请数量可以根据当前排队情况和您的程序资源消耗偏向自行斟酌

!!! Note
    计算节点分配到任务后的起始目录为你的`$HOME`目录，如果你的`$HOME`目录下面，某个`projectA`文件夹里面才是你的实际工作代码的话，请参考上面的例子，加入`cd projectA`一行。更多层的目录也是如此。 
    
## 作业提交
使用`qsub`命令提交写好的`psb`脚本文件(submit)：  
`qsub run_job_demo.pbs`    

提交后可能需要十几秒的时间您的作业才会被轮询调度到排队队列中。硬件资源充足的情况下也会如此。

!!! Warning
    如果计算资源充足的情况下，您的计算作业一直不能开始运行，请联系管理员。

## 作业状态查看
### `qstat`
 
一个样例输出：
```
▶ qstat                
Job ID                    Name             User            Time Use S Queue
------------------------- ---------------- --------------- -------- - -----
213.master                 TEST             user                   0 Q default        
214.master                 TEST             user                   0 Q default  
```

各列的含义分别为:
`作业ID， 作业名，  提交作业的用户，    作业已运行时间，    作业状态，  作业队列`


各状态标记(`S`栏)意义：

标记 | 意义
--- | ---
C   | Completed 作业运行后结束
E   | Exiting 作业运行后退出
H   | Held 作业被挂起(让出资源，暂停执行)
Q   | Queued 作业排队中,能够运行或路由
R   | Running 作业运行中
T   | 作业正被移动到新的位置
W   | Waiting 作业正在等待执行时间到来(PBS脚本中 -a 选项可指定作业启动时间)

### qstat 参数
* `qstat job1, job2 ...` 查看多个作业的信息
* `qstat -f jobid` 查看作业ID=`jobid`的作业的详细信息
* `qstat -u userabc` 查看用户名=`userabc`的用户的作业

### qstat 自动刷新
`watch -n 5 qstat` 将每隔5s在终端中自动刷新一次qstat输出
`-n` 后加你希望的刷新秒数

### /jobs页面
请到[系统监测](systemWatch.md)一节继续阅读


## 其它作业命令
### 挂起 qhold
`qhold job1 job2 ...` 将`job1`,`job2`号作业挂起，暂停运行。  
被挂起的作业为`H`状态。

### 恢复 qrls
`qrls job1 job2 ...` 恢复被挂起的`job1`,`job2`号作业，继续运行。
(release )

### 终止 qdel
`qdel job1 job2 ...` 停止`job1`,`job2`号作业执行。
(delete)

### 查看节点 
`pbsnodes`

### 查看空闲节点
`pbsnodes -l free`





