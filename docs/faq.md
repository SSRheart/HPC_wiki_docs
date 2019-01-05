# 疑问及解答

1. 我该如何设置我的**环境变量**？或者 我是否可以创建、修改我的`.bashrc`而不影响其它用户？

     远程连接取得的shell属于login-shell。login-shell会读取两类配置文件:

        - `/etc/profile`。 读取系统整体配置，个人用户不需要也不应该对其修改
        - `~/.bash_profile`. `~/.bash_login`, `~/.bashrc`， 这几个文件定义了使用者个人的shell配置。你可以在其中加入对环境变量的修改、自定义shell命令等。

    对环境变量PATH的修改可以在`~/.bashrc`中加入
    `PATH=$PATH:/some/file/location`

2. 如何在我实验室的电脑和服务器之间**传送数据**？

    请查阅[数据传输](linuxBasic/commands.md#数据传输)一节对scp指令的介绍和[远程连接](sshConnection.md)一节。

3. 我是否能够在服务器上**安装软件**?

    出于系统稳定性的考虑，普通用户不能在系统上安装软件(回忆ubuntu上`apt-get install`需要`sudo`执行), 如有安装需求，请和管理员联系。

4. 我的用户目录是否有**空间大小限制**？

    建议用户在`/share/home`下总空间大小在50G以内。对于网络中间输出等临时文件，请将文件写入到`/share/data/yourName`我们将定期查看文件系统中体积较大的目录。 您也可以在根目录下通过`du -h`来查看自己占用的空间大小。

5. 我的**SSH连接**能持续多久，会掉线吗?

     默认保持连接的时间是3分钟。意即如果您在登陆了集群，并且在三分钟之内都没有操作的话，会断开ssh连接，并且出现`卡死`的假象。

     所以我们建议，在您提交完任务/查看任务结果之后，通过`exit`及时退出登录。

6. 什么是**多机版本**的程序，**单机版本**呢？

    多机版本的程序（框架）是指安装或编译过程中选择了多机并行特性、因此支持计算任务在不同主机之间并行执行的程序。
    区别于不支持多机并行的单机版本。

    目前caffe/pytorch/Matlab均为单机版本,支持单机多GPU的计算，不支持跨主机的计算任务。

7. 我忘记了我的**用户名**或**登录密码**怎么办？

    用户名默认一般是你的姓名全拼小写，忘记密码请联系管理员重置。

8. 别人已申请并正在使用的**资源**，我能否再次申请？

    您可以提交申请，但是作业对于同一个资源（CPU线程、GPU）是独占的。除非对方的计算作业结束或被其终止，您的申请将持续等待。
    因此，我们推荐您利用 [/jobs](http://219.217.238.193/jobs) 的信息来避免不必要的排队等待。

9. 自行安装Python虚拟环境或其它情况下遇到`Version GLIBC_2.14 not found`错误. 目前有几个方案，希望大家加以尝试反馈。(此解决方案为Beta版本）

    `GLIBC-2.14`已经编译安装到了`/share/apps/glibc-2.14`.  

    目前推荐方案:  
        修改环境变量。（可以写到PBS脚本模板中）  

        export GLIBC_DIR=/share/apps/glibc-2.14/lib 
        export LD_PRELOAD=$GLIBC_DIR/libc.so.6:$LD_PRELOAD

    * 如果缺失的是其它版本的GLIBC，可以参照脚本自行设置。
    * GLIBC的整体升级工作可能会带来比较大的不确定性，短期内不会做系统层面的整体升级。



10. 如何限制程序计算线程数，以避免过多的上下文切换导致的系统CPU占用过多？  
   大多数框架有按照实际CPU线程数开多线程的趋势，但是在我们申请了其中几个线程的情况下，开过多的线程会导致频繁的上下文切换，十分占用CPU资源，导致自己和他人的程序受到极大的影响。建议按照如下方法根据实际申请的CPU线程数进行限制，以达到更好的性能：
   
    - MATLAB  
     ```
     maxNumCompThreads(num)
     ```
   - PyTorch  
     ```
     torch.set_num_threads(num)
     ```
   - TensorFlow  
     ```
     cpu_config = tf.ConfigProto(intra_op_parallelism_threads = num,
                                 inter_op_parallelism_threads = num,
                                 device_count = {'CPU': num})
     sess = tf.Session(config=cpu_config)
    ```
