# torch

### torch版本
torch7

### torch路径


torch源码编译安装路径`/share/apps/torch`
torch库源码路径 `/share/package/torch-packages`

### 提交torch作业

```shell
#PBS -N test_torch
#PBS -q default
#PBS -l nodes=1:ppn=12:gpus=8
#PBS -o /home/NAME/logs
#PBS -e /home/NAME/err_log

module load torch #加载torch环境，必需
cd #your_torch_project_path
th demo.lua

module unload torch #退出torch环境
```
更多关于提交作业的内容，请参考[作业系统](../jobs.md)
