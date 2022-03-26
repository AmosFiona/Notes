# 添加用户

    默认账户为root,密码是安装时更改设定的(示例中为031588u)
    添加权限低的用户避免误操作，先登陆root账户后

## 1.1 新建用户

    $useradd -m -G wheel fiona
    #wheel 是系统自带的一个分组

## 1.2 更改新用户登陆密码

    $passwd fiona

## 1.3 更改新用户的提权权限

    $visudo
    	  ## Uncomment to allow members of group wheel to execute any command
    	- # %wheel ALL=(ALL:ALL) ALL
    	+   %wheel ALL=(ALL:ALL) ALL

## 1.4 切换到新用户

    $su fiona

# 链接网络

## 有线网络

    $ip link
    $ip link set (en5S0) up
    $sudo dhcpcd

## 无线网络

    #iwctl
    $ip link
    $systemctl start iwd 				[仅运行一次即可]
    $systemctl enable iwd 				[仅运行一次即可]
    $iwctl 								[进入联网配置环境]
    	-> device list
    		wlan0
    	-> station wlan0 scan 			[搜寻无线网络]
    	-> station wlan0 get-networks 	[列出可用的无线网络]
    	-> station wlan0 connect ASUS   [链接搜索出来且可用的无线网络名字]
    		input passwd:  				[仅输入一次即可，被存入/var/lib/iwd/中]
    	-> exit

## 联网测试

    $ping www.baidu.com

# 安装显卡驱动

## 查看显卡

    $lspci

## 查看当前使用的显卡

    $lspci | grep VGA

## 安装对应类型的驱动

mesa 是所有开源显卡驱动的基础，一般情况下都需要安装

    $sudo pacman -S mesa

其次依据电脑不同环境按照对应类型选择安装

| 类型 | intel | nvidia             | amd               |
| ---- | ----- | ------------------ | ----------------- | ---------- |
| 开源 |       | nvidia             | x86-video-amdgpu  |
|      |       | nvidia-settings    | vulkan-rdeon      |
|      |       | nvidia-utils       | libva-mesa-driver |
|      |       | lib32-nvidia-utils |                   | mesa-vdpau |
| 闭源 |       | x86=video-nouveau  |                   |

## 初始化显卡环境

    $sudo mkinitcpio -P
    $reboot

# 安装 AUR 软件包管理工具:yay[Jguer/yay.git]

    $mkdir ~/Software
    $cd ~/Software
    $git clone git://aur.archlinux.org/yay.git
    $makepkg -si 	[会提示先安装go语言环境]
    [安装go环境后，会一直失败，多次尝试可以把yay.tar.gz下载下来，其余的被屏蔽]
    [修改go源为Goproxy.cn]
    $go env -w GO111MODULE=on
    $go env -w GOPROXY=https://goproxy.cn,direct
    [源临时生效]
    $export GO111MODULE=on
    $export GOPROXY=https://goproxy.cn
    [源永久生效]
    $echo "export GO111MODULE=on" >> ~/.profile
    $echo "export GOPROXY=https://goproxy.cn,direct" >> ~/.profile
    $source ~/.profile
    [再次尝试安装]
    $makepkg -si

使用方法：yay software_name <tab-tab> 即可搜索 AUR 里面的包裹
安装软件：yay -S software_name

## 安装字体

    查看图标
    https://www.nerdfonts.com/cheat-sheet
    查看emoji
    https://www.unicode.org/emoji/charts/full-emoji-list.html

| 类型   | emoji                  | 中文                                |
| ------ | ---------------------- | ----------------------------------- |
| PACMAN | ttf-joypixels          | wqy-bitmapfont                      |
|        | unicode-emoji          | wqy-microhei                        |
|        | noto-fonts-emoji       | wqy-microhei-lite                   |
|        | ttf-nerd-fonts-symbols | wqy-zenhei                          |
|        |                        | adobe-source-han-sans-cn-fonts      |
|        |                        | adobe-source-han-serif-cn-fonts     |
|        |                        | adobe-source-code-pro-fonts         |
|        | ttf-symbola[AUR]       |                                     |
|        | libxft-bgra-git[AUR]   |                                     |
| ------ | ---------------------- | -------------------------------     |
| 可选   | ttf-linux-libertine    |                                     |
|        | ttf-liberation         |                                     |
|        | ttf-inconsolata        |                                     |
|        | ttf-droid              |                                     |
|        | ttf-iosevka-nerd       |                                     |
|        | ttf-font-awesome       |                                     |
|        | ttf-twemoji-color[AUR] | adobe-source-han-mono-cn-fonts[AUR] |

# 添加中国源

    $sudo nvim /etc/pacman.conf 	[末尾加入]
    	+ [archlinuxcn]
    	+ SigLevel=Never
    	+ Server=http://mirrors.aliyun.com/archlinuxcn/$arch
    $sudo pacman -Syyu   [更新系统]

# 更换 SHELL 为 zsh 并安装 oh-my-zsh 配置

    $sudo pacman -S zsh
    $mkdir ~/oh-my-zsh
    $cd ~/oh-my-zsh
    $wget https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh
    $chmod +x install.sh [添加运行权限]
    [更改默认安装源为gitee.com]
    $nvim install.sh
    	  # Default settings
    	  zsh=${zsh:~/.oh-my-zsh}
    	- REPO=${REPO:-oh-my-zsh/ohmyzsh}
    	- REMOTE=${REMOTE:-https://github.com/${REPO}.git}
    	+ REPO=${REPO:-mirrors/ohmyzsh}
    	+ REMOTE=${REMOTE:-https://gitee.com/${REPO}.git}
    	  BRANCH=${BRANCH:-master}
    $./install.sh

## 通过 oh-my-zsh 修改 zsh 主题

    $nvim ~/.zsh
    	- ZSH_THEME="robbyrussell"
    	+ ZSH_THEME="ys"
    	- plugins=(git)
    	+ plugins=(git zsh-syntax-highlighting zsh-autosuggestions) [语法高亮，补全历史记录]
    	+ source ~/.bash_profile [文末加入]
    $source ~/.zshrc
    $git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    $git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    $source ~/.zshrc

## shell 默认 bash 切换为 zsh

    $echo $SHELL
    	/bin/bash

    #首先查看当前系统可用的shell
    $cat /etc/shells
    	# Pathnames of valid login shells.
    	# See shells(5) for details.

    	/bin/sh
    	/bin/bash
    	/bin/zsh
    	/usr/bin/zsh
    	/usr/bin/git-shell
    #修改默认的shell为zsh
    $chsh -s /bin/zsh
    	Changing shell for fiona.
    	Shell changed.

    #查看修改是否成功
    $cat /etc/passwd
    	root:x:0:0::/root:/bin/bash
    	bin:x:1:1::/:/usr/bin/nologin
    	daemon:x:2:2::/:/usr/bin/nologin
    	mail:x:8:12::/var/spool/mail:/usr/bin/nologin
    	ftp:x:14:11::/srv/ftp:/usr/bin/nologin
    	http:x:33:33::/srv/http:/usr/bin/nologin
    	nobody:x:65534:65534:Nobody:/:/usr/bin/nologin
    	dbus:x:81:81:System Message Bus:/:/usr/bin/nologin
    	systemd-coredump:x:981:981:systemd Core Dumper:/:/usr/bin/nologin
    	systemd-network:x:980:980:systemd Network Management:/:/usr/bin/nologin
    	systemd-oom:x:979:979:systemd Userspace OOM Killer:/:/usr/bin/nologin
    	systemd-journal-remote:x:978:978:systemd Journal Remote:/:/usr/bin/nologin
    	systemd-resolve:x:977:977:systemd Resolver:/:/usr/bin/nologin
    	systemd-timesync:x:976:976:systemd Time Synchronization:/:/usr/bin/nologin
    	tss:x:975:975:tss user for tpm2:/:/usr/bin/nologin
    	uuidd:x:68:68::/:/usr/bin/nologin
    	dhcpcd:x:974:974:dhcpcd privilege separation:/:/usr/bin/nologin
    	fiona:x:1000:1000::/home/fiona:/usr/bin/zsh
    	avahi:x:973:973:Avahi mDNS/DNS-SD daemon:/:/usr/bin/nologin
    	git:x:972:972:git daemon user:/:/usr/bin/git-shell
    	nvidia-persistenced:x:143:143:NVIDIA Persistence Daemon:/:/usr/bin/nologin

## 电源管理优化

    $sudo pacman -S tlp tlp-rdw
    #TODO descripe the research
    <++>
