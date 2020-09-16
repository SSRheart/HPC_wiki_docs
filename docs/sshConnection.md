# 远程连接到服务器

HPC服务器只能在校园网登录, 集群地址是[vpc.ac.cn]()，ip是`219.217.238.193`.

要连接到服务器，用户需要有已经在服务器创建好的账户和其对应密码
如还未创建账户，请联系系统管理员。

用户无法直接通过ssh连接到集群，但是可以在集群管理页面创建交互式开发环境，并通过ssh连接到该环境。

以下假定用户`root`使用密码`passwd`连接到交互式开发环境，且系统分配端口为25001，介绍基本登录指令和使用`ssh-copy-id`的免密码登录方法
默认登录后的目录在`/root`，需要注意的是，因所在计算节点重启等问题，导致交互式环境发生重置后，除`/opt/data`目录外，其余目录均会被清空。


## *nix 环境(Ubuntu, macOS, centos)
在终端中输入`ssh -p 25001 root@vpc.ac.cn`
出现输入密码的提示后，输入相应密码即可

## Windows 环境
Windows下需要使用连接工具进行连接。
可以选择的连接工具包括[MobaXterm](https://mobaxterm.mobatek.net/)、[PuTTY](http://www.putty.org/)等
其中MobaXterm支持文件拖拽上传。

使用MobaXterm 建立一个session来保存连接信息。
![使用MobaXterm连接](img/login.jpeg)

不同的连接工具连接方式可能略有不同，但一般情况下配置好服务器IP和用户，进行连接，输入密码即可。


## 免密码登录
默认情况下，SSH每次连接都需要密码。通过以下步骤可以省去这一步骤。
(部分Windows 环境下的连接工具可能不支持这里的命令，欢迎大家尝试和反馈各工具的使用体验来帮助我们推荐更好的工具）

-1. 执行`ssh-keygen -t rsa`
将会输出：
```
Generating public/private rsa key pair.
Enter file in which to save the key (/home/abc/.ssh/id_rsa): 　[输入想要保存的文件名，否则使用默认文件名。]
Enter passphrase (empty for no passphrase): 　　[输入你之前提交的远程主机登录密码]
Enter same passphrase again: 　　[再次输入上一密码]
Your identification has been saved in /home/abc/.ssh/id_rsa.
Your public key has been saved in /home/abc/.ssh/id_rsa.pub.  (根据之前输入的文件名,实际文件会有不同)
The key fingerprint is:
e1:dc:ab:ae:b6:19:b0:19:74:d5:fe:57:3f:32:b4:d0 matrix@vivid
The key's randomart image is:
+---[RSA 4096]----+
| .. |
| . . |
| . . .. . |
| . . o o.. E .|
| o S ..o ...|
| = ..+...|
| o . . .o .|
| .o . |
| .++o |
+-----------------+
```

-2. 继续执行`ssh-copy-id root@vpc.ac.cn`
这一步骤将SSH公钥保存到服务器。



## 账号与密码
账号申请、重置密码等，请联系管理员操作。

# 传送文件
建议使用FileZilla进行文件传输，地址、用户名、密码栏分别输入vpc.ac.cn及个人账户、密码，端口栏可留空或填写为21，即可访问个人目录。