## 整机配置

| 配件 | 型号 |
| :---: | :---: |
| CPU | i7-10700K |
| 内存 | 64GB |
| 主板 | 华硕 Prime Z490-P (有两个输出) |
| SSD | 三星PM981A 512GB |
| HDD | 希捷 4TB |
| 显示器 | Dell D2421H 23.8英寸 |

## 电脑设置（已由供货商完成）
- 使用UEFI模式安装windows 10专业版系统（版本20H1），系统盘大小200GB，4T机械硬盘分为4个1TB分区，用户名为user，不设密码。`（如需双系统，可使用SSD剩余空间安装，参考下面的安装Ubuntu过程。）`
- BIOS设置项
    - **非常重要**  存储设置为AHCI，不要使用raid（该版本bios默认为raid），否则会导致ubuntu无法安装
    - 显示设备选择`芯片自带显示`
    - 打开Intel虚拟化
    - 启动-安全启动菜单下，操作系统类型选其他，密钥管理里选择清除安全启动密钥

## 安装Ubuntu过程（以Ubuntu 20.04为例，其他版本应该类似）
- 建议使用rufus制作启动盘，选择UEFI模式
- 正常安装系统，建议`/boot`分区1GB，`/`分区50GB，`/home`分区200GB，启动引导安装位置选择`/boot`分区，以上均在SSD，建议在机械硬盘存放代码等数据，`/home`分区只安装anaconda等
- 如果没有显卡，则到此为止，无需执行后续步骤；如果加装nvidia显卡，建议参考下列步骤完成操作
- 安装完成后进入系统，更新内核并重启后，执行以下操作
    - 首先安装部分软件，后续需要使用，命令为`sudo apt install vim gcc g++ make cmake build-essential libglvnd-dev`
    - `$ sudo vim /etc/modprob.d/blacklist.conf`
        在最后加入两行，即`blacklist nouveau`以及`options nouveau modeset=0`
    - `$ sudo vim /lib/modprob.d/blacklist-nvidia.conf` （创建）
        内容包含两行，即`blacklist nvidia-drm`以及`alias nvidia-drm off`
    - 此处可能需要`sudo update-initramfs -u`更新内核设定，然后重启，使对nouveau的禁用生效，可以用`lsmod | grep nouveau`验证，如果没有输出即为禁用成功
    - 正常安装显卡驱动，命令为`sudo bash NVIDIA_xxx.run`，中间会提示一些问题，比如要求安装`gcc`、`make`，以及安装32bit驱动时要求的`libglvnd`（注意的是，安装的是`libglvnd-dev`，上面预安装的包含该项），如果提示X server正在运行，可以`sudo service gdm3 stop`，然后按`Ctrl+Alt+F2`进入命令行安装，安装完成后重启即可，如果还有问题，再执行一次`sudo update-initramfs -u`应该就行了