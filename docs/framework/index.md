# python 类框架
## anaconda 虚拟环境
对于python下的框架，使用anaconda分隔为不同的虚拟环境。
目前公共的虚拟环境有：

* pytorch0.3.0
* py36pytorch0.3.1
* tensorflow

运行`conda env list`可以获得可用的python虚拟环境。


#### 激活环境:
`source activate environment_name`

需要提交作业时， 如果要激活python虚拟环境，需要指出`activate`的完整路径，也即：
`source /share/apps/anaconda2/bin/activate environment_name`
另一种方式是先将conda的路径添加到环境变量中，然后再激活，

`module load conda`,
`source activate environment_name`

请看[pytorch 作业脚本](pytorch.md)来进一步了解。

#### 退出环境
`source deactivate`

#### 查看该环境下已经安装的python库:
`conda list`

#### 安装环境
如果公用虚拟环境不能满足使用需要，希望建立新的虚拟环境：

-   如果预计安装后可以与其他人共享，可以联系管理员安装

-   如果只是自己短期使用，可以自行安装。
    例子：`/share/apps/anaconda2/bin/conda create -n aNewEnv python=3.6`
    自行安装的conda库位置在`/home/YOURNAME/.conda/envs/aNewEnv`

#### 更多anaconda命令
请查阅[参考资料](../refer.md#anaconda).
