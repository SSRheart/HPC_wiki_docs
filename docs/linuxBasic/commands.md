# Linux 基础命令
*本节由CastellanLiu贡献*

## 获取帮助
一般情况下，linux命令会有`-h` 或者`--help`选项输出最基本的提示信息。  
对于系统命令，可以使用`man`获得帮助。

举例，想要快速了解`make`命令的参数，可以通过  
`make -h` 或`make --help` 以及`man make`

除此之外，可以通过网站[Linux命令大全](http://man.linuxde.net/)了解更多相关命令

## 文件及目录操作

### 显示文件和目录

```shell
ls	  # 显示当前目录下的文件和目录
ls -l # 等价于 ll, 显示当前目录下的文件和目录,并给出其属性和权限
ls -a # 显示当前目录下的全部文件和目录(包含隐藏文件和目录)
```

###切换目录
```shell
cd # 进入 ~/ 目录
cd .. # 进入上级目录
cd MYPATH # 进入MYPATH, MYPATH可以是绝对路径,也可以是相对路径
```

###创建文件或目录
```shell
echo "some containt" >> filename # 在filename末尾添加内容,若filename不存在,则新建该文件,适合新建较少内容的文件或添加少量内容
touch filename  # 如果filename不存在,则创建,否则不做操作
mkdir directory # 创建名为directory的文件夹
```

###创建软连接
```shell
ln -s src dst # 创建dst到src的软连接，使用dst，会指向src
ln -s /usr/local/cuda-8.0 /usr/local/cuda # 相当于快捷方式，也相当于域名解析(cuda是域名，cuda-8.0是IP地址)
ln -s /usr/local/cuda-9.0 /usr/local/cuda # 更换版本，但调用路径不变
```

###复制、移动和删除
```shell
cp [-OPT] src dst 
#文件复制命令，OPT可以是-r(src及其子文件、子目录，r是递归的意思),-f(强制执行),-rf，src可以是目录或文件，dst可以是目录(则拷贝到dst目录下)或目录+文件名(这种情况必须是拷贝单个文件，则拷贝到该目录下并改名)

cp hello.py myfold/hello_world.py
#举例，将当前目录下的hello.py文件拷贝到myfold文件夹下并改名为hello_world.py

mv [-OPT] src dst #移动命令
rm [-OPT] src #删除命令
```

###更改文件或目录权限
```shell
chmod [OPT] file # OPT 可以是+R(添加可读权限),+W(可写),+X(可执行)
chmod 777 file # 增加文件读,写和可执行权限
```

###显示当前路径
```shell
pwd   # 显示当前目录的完整路径
```
###在命令行中显示某文件内容
```shell
cat filename
cat filename | more # 显示文件的第一屏,按空格翻页,按回车向下滚动一行,按q退出
tac filename # 按行倒序显示文件内容
```
## 压缩与解压缩
本文档仅列出最常用的.zip和.tar.gz(.tgz)的压缩解压命令，详细命令可参见[Linux命令大全 - 文件压缩与解压](http://man.linuxde.net/sub/%E6%96%87%E4%BB%B6%E5%8E%8B%E7%BC%A9%E4%B8%8E%E8%A7%A3%E5%8E%8B)

###压缩 

```shell
tar -zcvf filename.tar.gz(filename.tgz) PATH # 用gzip压缩为tar包，PATH可以是文件或目录
zip  -r filename.zip PATH # 压缩为zip包
```

###解压
  
```shell
tar -zxvf filename.tar.gz(filename.tgz) # 将 filename.tar.gz 或 filename.tgz 解压到当前目录
unzip filename.zip # 在当前目录下解压zip包
unzip -n filename.zip -d /tmp # 将filename.zip在指定目录/tmp下解压缩，如果已有相同的文件存在，不覆盖原先的文件。
```
## 数据传输
使用scp命令，从本地传输到服务器和从服务器传输到本地的用法基本一致，只需在scp命令中按照
`scp [-r]  source destination` 的顺序书写即可。

以本地数据传输到服务器为例：
```shell
scp localeFile yourName@219.217.238.193:/yourServerHome`
scp -r localeDirectory yourName@219.217.238.193:/yourServerHome`
```

