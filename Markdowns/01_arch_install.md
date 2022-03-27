# 安装 Arch Linux

## 一、U 盘安装环境启动

1.1 rufus 工具写入 U 盘并插入电脑，进入 BIOS 将 Secure Boot 设定为 Disable
\
1.2 进入 U 盘的 GRUB 引导启动器环境后，按下 e(在读秒结束前)输入

```
    $nomodeset video = 1920x1080<CR>( <CR>表示按下回车键Return，下同)

```

修改分辨率，让字体显示大一些
\
1.3 检测完安装环境后，正是进入安装环境：若是字体还是小，可设定字体

```
    $setfont /usr/share/kbd/consolefonts/LatGrkCyr-12x22.psfu.gz

```

1.4 查看是否支持 UEFI 模式启动

```
    $ls /sys/firmware/efi/efivars

```

如果若是有可以 UEFI 模式进行安装(以 UEFI 模式启动)，否则以兼容 DOS 模式进行安装(传统 MBR 模式启动)
\
1.5 获取网络(U 盘制作时候已经包含基础工具，vim、iwd、iw、iw-tools 及 wpa_supplicant 和 dhcpcd 等工具)

1.5.1 查看联网设备

```
    $ip link

```

若是列出来的只有 Lo,没有 wlan0(无线网卡编号通常为 wlan0,多个无线联网网卡 wlan1,wlan2...),使用有线网络进行安装系统，有线网络编号通常是 en####
\
若有线安装后执行 `$ping www.baidu.com` 查验是否联通互联网，若未通，执行 `$dhcpcd &`

1.5.2 启动无线网卡(假定 wlan0,下同)

```
    $ip link set wlan0 up

```

1.5.3 搜寻可用的无线网络

```
    $iwlist wlan0 scan | grep ESSID

```

1.5.4 生成配置文件

```
    $wpa_passphrase ESSID ESSID_password > internet.conf

```

ESSID 及 ESSID_password 是 1.5.3 步骤搜索出来的无线网络名称及对应的密码
\
查验生成的文件(在终端直接打印文件内容，若有刚写入的无线网络名称及其密码说明正确)

```
    $cat internet.conf

```

1.5.5 链接网络(&表示在后台[隐式]运行)

```
    $wpa_supplicant -c internet.conf -i wlan0 &

```

1.5.6 验证网络

```
    $ping www.baidu.com
```

1.5.7 若 1.5.6 无法 ping 通互联网，执行动态分配 IP 工具即可

```
    $dhcpcd &
```

1.5.8 再次验证网络

```
    $ping www.baidu.com
```

1.6 完成 1.5 网络链接后，同步系统时间

```
    $timedatectl set-ntp true

```

1.7 准备分区
\
1.7.1 查看内存

```
    $free -h

```

1.7.2 查看磁盘

```
    $fdisk -l

	Disk /dev/sda[nvme/mmcb...] 479.1GiB
	……sda-机械盘，nvme-SSD
	Disk /dev/sdb[sda]  14.75GiB
	……若电脑是SSD没有机械硬盘，则U盘编号通常为sda
```

1.7.3 进入想要分区的磁盘(以机械硬盘为例)

```
    $fdisk /dev/sda

```

1.7.4 执行分区指令

```
    $commad(m for help):

```

| UEFI  | MBR                        |
| ----- | -------------------------- |
| g<CR> | o<CR>                      |
| NA    | 新建的分区选择 primary<CR> |

```
    $commad(m for help):n<CR>
    $Partition number(1-4[128], default 1):1<CR>
    $First sector(2048-X):<CR>
    $Last sector +/- sectors or +/- size{K,M,G,T,P}(2048-X):refer to table<CR>
    $Do you want to remove the signature?[Y]:y<CR>

```

| UEFI(假定内存 8G)  | MBR(假定内存 8G)         |
| ------------------ | ------------------------ |
| +512M              | -9G                      |
| 做/boot 引导启动盘 | 做主盘/，减去内存大小+1G |

```
    #For UEFI(分区1：/boot)
    $commad(m for help):n<CR>
    $Partition number(1-4[128], default 1):1<CR>
    $First sector(2048-X):<CR>
    $Last sector +/- sectors or +/- size{K,M,G,T,P}(2048-X):refer to table<CR>
    $Do you want to remove the signature?[Y]:y<CR>

    #For MBR(分区1：/)
    $commad(m for help):n<CR>
    $Partition number(1-4[128], default 1):1<CR>
    $First sector(2048-X):<CR>
    $Last sector +/- sectors or +/- size{K,M,G,T,P}(2048-X):-9G<CR>
    $Do you want to remove the signature?[Y]:y<CR>
```

| 类型   | UEFI  | 说明                      | MBR    | 说明                       |
| ------ | ----- | ------------------------- | ------ | -------------------------- |
| 分区 1 | /boot | 引导分区=512M             | /      | 根目录=扣除(内存大小+1GiB) |
| 分区 2 | /     | 根目录=扣除内存大小       | /swap  | 交换区(虚拟内存)=内存大小  |
| 分区 3 | /swap | 交换区(虚拟内存)=内存大小 | 空留区 | 空余部分自动写入引导       |

```
    #For UEFI(分区3：/swap)
    $commad(m for help):n<CR>
    $Partition number(2-4[128], default 2):3<CR>
    $First sector(1050624-X,default 1050624):<CR>
    $Last sector +/- sectors or +/- size{K,M,G,T,P}(1050624-X):refer to table<CR>
    $Do you want to remove the signature?[Y]:y<CR>

    #For MBR(分区2：/swap)
    $commad(m for help):n<CR>
    $Partition number(2-4[128], default 2):2<CR>
    $First sector(1050624-X,default 1050624):<CR>
    $Last sector +/- sectors or +/- size{K,M,G,T,P}(1050624-X):-1G<CR>
    $Do you want to remove the signature?[Y]:y<CR>

    #For UEFI(分区2：/)
    $commad(m for help):n<CR>
    $Partition number(2,4[4-128], default 2):<CR>
    $First sector(yyyyyyyyy-X,default yyyyyyyyy):<CR>
    $Last sector +/- sectors or +/- size{K,M,G,T,P}(yyyyyyyyy-X):-8G<CR>
    $Do you want to remove the signature?[Y]:y<CR>

    #For MBR
    $commad(m for help):n<CR>
    $Partition number(2-4[128], default 2):2<CR>
    $First sector(1050624-X,default 1050624):<CR>
    $Last sector +/- sectors or +/- size{K,M,G,T,P}(1050624-X):-1G<CR>
    $Do you want to remove the signature?[Y]:y<CR>

```

1.7.5 查看分区状况

```
    $commad(m for help):p<CR>

```

1.7.6 写入刚分区方案

```
    $commad(m for help):w<CR>
    descrip /dev structures
```

1.7.6 设定各分区的格式

| 分区列表 | UEFI 格式      | 指令                       | MBR 格式  | 指令                 |
| -------- | -------------- | -------------------------- | --------- | -------------------- |
| 分区 1   | /boot -> FAT32 | $mkfs.fat -F32 /dev/sda*1* | / -> ext4 | $mkfs.ext4 /dev/sda1 |
| 分区 2   | / -> ext4      | $mkfs.ext4 /dev/sda2       | /swap     | 见 1.7.7             |
| 分区 3   | /swap          | 见 1.7.7                   | -         | -                    |

1.7.7 设定 swap 分区

```
    #For UEFI
    $mkswap /dev/sda3

    #For MBR
    $mkswap /dev/sda2

```

1.7.8 打开 swap 分区

```
    #For UEFI
    $swapon /dev/sda3

    #For MBR
    $swapon /dev/sda2

```

## 二、准备安装 ArchLinux

2.1 配置 pacman

```
    $vim /etc/pacman.conf
      #UseSyslog
    - #Color
    + color
      #NoProgressBar
    "[:w<]CR>保存后，接着搜索[/core]<CR>,光标移动到mirrorlist,按下[gf]跳转到该文件"
    在文件首行添加中国镜像源,国内的源是http,镜像是mirrors
    Sever=http://mirrors.aliyun.com/archlinux/$repo/os/$bash
    Sever=http://mirrors.163.com/archlinux/$repo/os/$bash
    Sever=http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$bash

```

2.2 挂载根目录(/)分区到安装目录下

| UEFI                  | MBR                    |
| --------------------- | ---------------------- |
| $mount /dev/sda2 /mnt | $/mount /dev/sda1 /mnt |

2.3 查验挂载

```
    $ls /mnt
    	lost+found

```

2.4 创建引导分区

```
    $mkdir /mnt/boot

```

2.5 挂载引导分区(仅 UEFI 模式需要)

```
    $mount /dev/sda1 /mnt/boot
    #MBR模式会将引导安装到空留的1G空间中,实际上仅使用几Kb

```

2.6 安装 ArchLinux

```
    $pacstrap /mnt base linux linux-firmware
    # base ->基础
    # linux->内核
    # linux-firmware -> 连接应用与硬件的中间层环境

```

若是安装下载内核后只有 kb 或者不足 100MB,需要停止 reflector 服务

```
	$systemctl stop reflector.service
	$reflector --country China --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

```

2.7 配置系统

2.7.1 生成 fstab 文件(UUID 卷标)

```
    $genfstab -U /mnt >> /mnt/etc/fstab

```

2.7.2 切换到新安装的系统环境内

```
    $arch-chroot /mnt

```

2.7.3 设置时区

```
    $ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

```

2.7.4 同步时钟

```
    $hwclock --systohc --utc
```

2.7.5 安装文本编译器

```
    $pacman -S neovim

```

2.7.6 设定系统语言

```
    $nvim /etc/locale.gen
    [/en_US]
    - #en_US.UTF-8 UTF-8
    + en_US.UTF-8 UTF-8

```

2.7.7 生成系统主语言配置信息

```
    $locale-gen

```

2.7.8 设定系统主显示的默认语言

```
    $nvim /etc/locale.conf
    	LANG=en_US.UTF-8

```

### **2.8 生成主机名字**

```
    $nvim /etc/hostname
    	CXW
```

2.9 配置联网

```
    $nvim /etc/hosts
    	127.0.0.1 	localhost
    	::1 		localhost
    	127.0.1.1 	CXW.localdomain 	CXW

```

### **2.10 修改 root 账户密码**

```
    $passwd
    	031588u
```

### 3. 安装并配置引导启动器 Grub

3.1 创建引导启动器文件夹

```
    $mkdir /boot/grub

```

3.2 安装引导启动器 grub

```
    #For UEFI
    $pacman -S grub intel-ucode amd-ucode os-probber efibootmgr

    #For MBR
    $pacman -S grub intel-ucode amd-ucode os-probber
    # grub 			引导启动程序
    # intel-ucode 	intel驱动环境工具
    # amd-ucode 	amd驱动环境工具
    # os-probber 	多系统引导器
    # efibootmgr 	efi引导管理器

```

3.3 确认 CPU 架构(x86/arm/others...)

```
    $uname -m
    	x86_64
```

3.4 安装引导

```
    #For UEFI
    $grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch_grub --recheck
    #For MBR
    $grub-install --target=i386-pc /dev/sda
    	“注意：此处欲挂载安装的是整个磁盘，末尾没有序号，使用上面分区方案中那个未分区的1G空间来安装写入grub

```

3.5 编译生成引导器配置文件

```
    $grub-mkconfig -o /boot/grub/grub.cfg

```

3.6 查验/boot 和/boot/grub 下的文件，要有 x86_64-efi 及刚生成的引导启动脚本：grub.cfg,且此文件打开需要有内容

4. 开机后自动启动网络链接配置(ID 通过 ip link 获取，例如 en5S0)

```
   $systemctl enable dhcpcd@ID_device(en5S0).service
	$systemctl enable dhcpcd@ID_device(wlan0).service

```

5. 安装网络工具

```
   $pacman -S iwd dhcpcd
```

6. 安装编译环境

```
   $pacman -S vi zsh base-devel wget man git

```

7. 安装结束后退出

```
   $exit

```

8. 关停网络

```
   $killall wpa_supplicant dhcpcd

```

9. 卸载系统盘

```
   $umount -R /mnt

```

10. 重启拔掉 U 盘

```
    $reboot

```

备注：进入系统后，默认的管理员账户为 root,密码是 2.10 步骤设定的密码(本文案例密码：031588u)
