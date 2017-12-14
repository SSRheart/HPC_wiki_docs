# pytorch 0.3.0

anaconda2

python2.7

```shell
#PBS -N test_pytorch
#PBS -q default
#PBS -l nodes=1:ppn=12:gpus=8
#PBS -o /home/NAME/logs
#PBS -e /home/NAME/err_log

source /share/apps/anaconda2/bin/activate pytorch0.3.0

cd YOUR_WORK_DIRECTORY # IMPORTANT
python demo.py
source deactivate
```
