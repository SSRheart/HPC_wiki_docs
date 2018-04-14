
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
