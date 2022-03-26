# 桌面环境

## 环境依赖

    $sudo pacman -S xorg xorg-xinit dmenu
    # xorg 启动图形界面的基础环境
    # xorg-xinit 启动图形界面的配置文件 xinitrc
    # dmenu 桌面管理器 dwm 的程序启动器

## 终端模拟器 st

    $cd ~/Software
    $git clone https://git.suckless.org/st
    $cd st/
    $nvim config.mk
    	- X11INC=/usr/X11R6/include
    	- X11LIB=/usr/X11R6/lib
    	+ X11INC=/usr/include/X11
    	+ X11LIB=/usr/lib/X11
    $make
    $sudo make install

## 桌面管理器 dwm

    $cd ~/Software
    $git clone https://git.suckless.org/dwm
    $cd dwm/
    $nvim config.mk
    	- X11INC=/usr/X11R6/include
    	- X11LIB=/usr/X11R6/lib
    	+ X11INC=/usr/include/X11
    	+ X11LIB=/usr/lib/X11
    $make
    $sudo make install

## 系统启动后启动 dwm

    $sudo nvim /etc/X11/xinit/xinitrc
    	+ exec dwm
    	# twm &
    	# xclock -geometry 50x50-1+1 &
    	# xterm -geometry 80x50+494+51 &
    	# xterm -geometry 80x20+494-0 &

## 启动桌面管理 dwm

    $startx
    若是报错使用指令查询，对应安装缺少的环境/驱动
    $cat /var/log/Xorg.0.log | grep EE

## 使用 dwm

    [快捷键]
    Shift+Alt+Enter :启动终端
    Alt+[0-9]切换到不同的tag页

## 安装中文输入法 fcitx5

    $sudo pacman -S fcitx5-im fcitx5-chinese-addons fcitx5-pinyin-moegirl
    	# fcitx5-im 包含 fcitx5-config-tools  		设定工具
    					 fcitx5-gtk 	针对gtk应用环境
    					 fcitx5-qt 	针对qt应用环境
    					 fcitx5
    	# fcitx5-chinese-addons 			中文输入法引擎，用于启动中文输入法
    	# fcit5-pinyin-zhwiki 				中文维基百科词库，用于拼音联想
    	# fcitx5-pinyin-moegirl 			中文萌娘百科词库，用于拼音联想，针对动漫，漫画，游戏，二次元领域的热门词汇

## 启动中文输入法环境

    $sudo nvim /etc/X11/xinit/xinitrc
    	在exec dwm的上面加入

    	export INPUT_METHOD=fcitx5
    	export GTK_IM_MODULE=fcitx5
    	export QT_IM_MODULE=fcitx5
    	export XMODIFIERS=\@im=fcitx5
    	export SDL_IM_MODULE=fcitx

    	注意：虽然输入法安装的是fcitx5,但最后一个环境变量没有5
    		  nvim中无法启动一般情况下是\@im没有正确识别，用转移字符\替换“\@im”
