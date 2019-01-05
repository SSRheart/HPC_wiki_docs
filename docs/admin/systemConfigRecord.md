
### 1. 如何添加用户？

```shell
useradd XXXX
passwd XXXX
make -C /var/yp/
```

### 2. 修改用户名
```shell
# change both username and home dir name
usermod -l new_username -m -d /new/home/dir old_username

# you may also want to change the name of the group associated with the user
groupmod -n new_username old_username
```


### 3. Opencv 编译参数
```shell
rm -rf build
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE  \
      -D HAVE_C_WUNDEF:INTERNAL=  \
      -D CMAKE_INSTALL_PREFIX=/share/apps/Opencv-2.4.9 \
      -D BUILD_NEW_PYTHON_SUPPORT=ON \
      -D PYTHON_PACKAGES_PATH=/share/apps/python/python27/lib/python2.7/site-packages/ \
      -D PYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
      -D PYTHON_LIBRARIES=$(python -c "import distutils.sysconfig as sysconfig; import os; print(os.path.join(sysconfig.get_config_var('LIBDIR'), sysconfig.get_config_var('LDLIBRARY')))") ..

make -j16
make install
cd ..
```

### 4. GCC安装与升级
目前高版本的gcc是通过devtoolset来安装的，现在的版本是devtoolset-2，包含了gcc-4.8.2。安装路径是`/opt/rh/devtoolset-2`。

若需要升级或者安装更高版本的GCC，建议通过devtoolset来安装／升级。

由于devtoolset推荐的安装方式需要联网，我们需要在每个计算节点单独安装一次，所以我们采取的是下载rpm包的方式来安装。

现有的devtoolset的安装包在`/share/package/devtoolset`,里面的`install.sh`就是安装升级devtoolset。

如果要升级，那么去网上找对应的rpm包就可以。

安装完成之后，还需要修改对应的`modulefiles`文件，路径在`/share/apps/Modules/modulefiles/gcc`，按照模板重新写一个文件就好。

### 5. 任务一直排队Q的处理
[详细issue讨论](https://github.com/sonack/HPC_wiki_docs/issues/24)  
TLDR:
    
- 使用`ps aux | grep qrun`查看`loop_qrun.sh`脚本进程id
- `kill -9 #process_id` 来停止该脚本
- `nohup sh /home/user/test_pbs/chk_gpu/loop_qrun.sh >/dev/null 2>&1 &` 重启脚本，后台不中断运行

### 6. 所有计算节点并行操作的指令
在master上 运行`pdsh -w node[1-6] command`来在所有6台机器上执行command
