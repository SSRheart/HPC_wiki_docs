# python 类框架
## anaconda 虚拟环境
对于python下的框架，使用anaconda分隔为不同的虚拟环境。
目前虚拟环境有：  

* pytorch0.3.0 
* tensorflow

运行`conda env list`可以获得可用的python虚拟环境。


#### 激活环境:
`source activate environment_name`  
需要提交作业时， 如果要激活python虚拟环境，需要指出`activate`的完整路径，也即：
`source /share/apps/anaconda2/bin/activate environment_name`

请看[pytorch 作业脚本](pytorch.md)来进一步了解。 

#### 退出环境
`source deactivate`

#### 查看该环境下已经安装的python库:  
`conda list`
需要安装新python库时，请联系管理员进行操作以便保持各虚拟环境的隔离稳定。

#### 更多anaconda命令
请查阅[参考资料](../refer.md#anaconda).
