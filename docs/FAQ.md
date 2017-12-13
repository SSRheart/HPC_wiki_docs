# 疑问及解答

1. 我该如何设置我的环境变量？或者 我是否可以创建、修改我的`.bashrc`而不影响其它用户？  

     远程连接取得的shell属于login-shell。login-shell会读取两类配置文件:  
        
        - `/etc/profile`。 读取系统整体配置，个人用户不需要也不应该对其修改
        - `~/.bash_profile`. `~/.bash_login`, `~/.bashrc`， 这几个文件定义了使用者个人的shell配置。你可以在其中加入对环境变量的修改、自定义shell命令等。
        
    对环境变量PATH的修改可以在`~/.bashrc`中加入  
    `PATH=$PATH:/some/file/location`

2. 如何在我实验室的电脑和服务器之间传送数据？

    请查阅[数据传输](LinuxBasicCommands.md#数据传输)一节。  

3. 我是否能够在服务器上安装软件?  

    出于系统稳定性的考虑，普通用户不能在系统上安装软件(回忆`ubuntu上apt-get install`需要`sudo`执行), 如有安装需求，请和管理员联系。

4. 我的用户目录是否有空间大小限制？  

    考虑中
   





