# TensorBoard

###  介绍
[官网链接](https://www.tensorflow.org/guide/summaries_and_tensorboard)  

###  用法

集群公共虚拟环境中已经安装了tensorboard (对应tensorflow 1.5版本)，能够满足大多数需求，如需要其他版本，请自行建立虚拟环境或联系管理员

集群tensorboard具体方法如下：

```shell
source activate  # 无须加后缀，也可以写 source activate root
tensorboard --logdir /path/to/your/log/file --port port
tensorboard --logdir ./summary --port 8888  # an example
```

然后在本地（要求校内网）用浏览器访问`219.217.238.193:port`

!!!NOTE

port为端口号，tensorboard默认为6006，请尽量选用大于6006的端口

### 如果遇到问题..

服务器上启动tensorboard遇到`local.Error: unsupported locale setting`时，
先执行`export LC_ALL=C` 再启动tensorboard，【或者将`export LC_ALL=C`写入`.bashrc`文件中（如导致其他程序异常，请删除）】

断开连接后手动执行的`export LC_ALL=C`自动失效，如需手动取消，方法是`unset LC_ALL`
