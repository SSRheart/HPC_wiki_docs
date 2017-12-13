# 任务系统

目前集群上安装使用的是Torque资源管理系统，计算任务的执行通过提交Torque 作业(job)进行。


## 作业脚本
作业脚本用来描述执行计算任务的程序或命令，以及相应的运行参数(参数也可在提交作业时在命令行中指定)

一个示例脚本 `run_job_demo.pbs` 如下:  
```
#PBS -N myjob1
#PBS -o /home/username/myjob1.out
#PBS -e /home/username/myjob1.err
#PBS -l nodes=1:ppn=1:gpus=1
#PBS -r y
cd $PBS_O_WORKDIR
echo Time is `date`
echo Directory is $PWD
echo This job runs on following nodes:
cat $PBS_NODEFILE
cat $PBS_GPUFILE
./my_proc
```


注意这里的`#`不是shell脚本中的注释符号， `#PBS`表明本行之后为定义参数。  


torque可指定的参数及解释:

option | meaning
--- | --- 
`-e` | e(rror), 指定标准错误输出文件。 /dev/null 丢弃输出
`-j` | j(oin) 合并系统输出，如果指定为`oe`,则将标准输出stdout和标准错误输出stderr合并为stdout, 
     |           如果指定为`eo`,则将标准错误输出stderr和标准输出stdout合并为stderr, 
`-l` | 指定作业使用的节点和CPU、GPU 资源
`-m` | m(ail) 指定何种情况发送邮件
`-N` | N(ame) 作业名称，应当具有一定标识性。  
`-o` | o(utput), 指定标准输出文件。 /dev/null 丢弃输出
`-q` | 指定排队队列
`-r` | r(erunable) 是否设置作业的`可重复执行`属性为True, 即节点故障的情况下任务是否可以重复执行
`-S` | 指定用来处理作业脚本的程序，一般为shell

  
关于`-l` 的详细说明：
```
   nodes=X:ppn=Y:gpus=Z  
   nodes=X 指定使用X个节点. 也可以指定nodes=nodeX (X可取1..6)  
   ppn=Y 指定每个节点使用CPU的数量(processor per node)  
   gpus=Z 指定使用GPU的数量  
```

## 作业提交
使用`qsub`命令提交写好的`psb`脚本文件(submit)：  
`qsub run_job_demo.pbs`    

## 作业状态查看
`qstat`
 
一个样例输出：
```
▶ qstat                
Job ID                    Name             User            Time Use S Queue
------------------------- ---------------- --------------- -------- - -----
213.master                 TEST             user                   0 Q default        
214.master                 TEST             user                   0 Q default  
```

各状态标记：

标记 | 意义
--- | ---
C   | Completed 任务运行后结束
E   | Exiting 任务运行后退出
H   | Held 任务被挂起
Q   | Queued 任务排队中,能够运行或路由
R   | Running 任务运行中
T   | 任务正被移动到新的位置

W   | Waiting 任务正在等待执行时间到来(PBS脚本中 -a 选项可指定任务启动时间)


## 其它作业命令
### 挂起 qhold
`qhold 127` 将127号作业挂起，暂停运行。  
被挂起的作业为`H`状态。

### 恢复 qrls
`qrls 127` 恢复被挂起的127号作业，继续运行。
(release )

### 终止 qdel
`del 127` 停止127号作业执行。
(delete)

### 查看节点 
`pbsnodes`

### 查看空闲节点
`pbsnodes -l free`





