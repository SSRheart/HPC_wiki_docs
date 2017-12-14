# pytorch

## 版本

pytorch使用anaconda安装，虚拟环境名为pytorch0.3.0。 版本0.3.0.  
带有torchvision


## 提交作业
```shell
#PBS -N pytorch_test                                       
#PBS -l nodes=1:ppn=4:gpus=4                               
#PBS -q default                                            
#PBS -o /home/USERNAME/logs/log                            
#PBS -e /home/USERNAME/logs/errlog                         
                                                           
cd startup_py_PATH #程序入口startup.py文件的路径
source /share/apps/anaconda2/bin/activate pytorch0.3.0        
python startup.py

```
更多关于提交作业的内容，请参考[作业系统](http://127.0.0.1:8000/jobs/)


 
