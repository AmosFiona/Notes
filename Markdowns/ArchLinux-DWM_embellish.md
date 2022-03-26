# 美化 dwm

## 打补丁增强功能

    $cd ~/Software/dwm/ && mkdir org && mv config.def.h ./org

### alpha 标签兰半透明

    $wget http://dwm.suckless.org/patches/alpha/dwm-alpha-20201019-61bb8b2.diff
    $patch < dwm-alpha-20201019-61bb8b2.diff
    	config.h [提示找不到config.def.h,是因为移动到了新建的org文件夹下，这时指定打入的文件：config.h]
    $sudo make clean install
    $Shift + Alt + q [退出]
    $startx  [看效果]

### autostart 自动运行 shell 脚本

    $wget http://dwm.suckless.org/patches/autostart/dwm-autostart-20210120-cb3f58a.diff
    $patch < dwm-autostart-20210120-cb3f58a.diff
    	The files listed above are looked up in the directories
    	"$XDG_DATA_HOME/dwm", 			/dwm
    	"$HOME/.local/share/dwm",       /home/fiona/.local/share/dwm
    	"$HOME/.dwm" respectively.      /home/fiona/.dwm
    	The first existing directory is used, no matter if it actually contains any file.

    $mkdir ~/.local/share/dwm
    $nvim ~/.local/share/dwm/autostart.sh
    	#! /bin/sh
    	/bin/sh $HOME/.config/dwm/dwm-status-refresh.sh &

    $nvim ~/config/dwm/dwm-status-refresh.sh
    	#!/bin/sh

    	picom -b &

    	/bin/sh $HOME/.config/dwm/wp-autochange.sh &
    	/bin/sh $HOME/.config/dwm/fcitx5.sh &

    	while true
    	do
    		/bin/sh $HOME/.config/dwm/dwm-status.sh
    		sleep 1
    	done
    $nvim ~/.config/dwm/wp-autochange.sh
    	#! /bin/sh

    	while true; do
    		/bin/sh ~/.config/dwm/wp-change.sh
    		sleep 1m
    	done
    $nvim ~/.config/dwm/wp-change.sh
    	#! /bin/sh

    	feh --recursive --bg-fill --randomize ~/Pictures/Wallpaper/*
    $nvim ~/.config/dwm/fcitx5.sh
    	#!/bin/sh

    	sleep 20
    	fcitx5 &
    $nvim ~/.config/dwm-status.sh
    	#!/bin/sh

    	LOC=$(readlink -f "$0")
    	DIR=$(dirname "$LOC")

    	SEP1="["
    	SEP2="]"
    	IDENTIFIER="unicode"

    	dwm_date(){
    	    if [ "$IDENTIFIER" = "unicode" ]; then
    	        printf "📆 %s" "$(date "+%Y年%m月%d日 %H:%M")"
    		    #date '+%Y年%m月%d日 %H:%M'
    	    else
    	        printf "DAT %s" "$(date "+%a %d-%m-%y %T")"
    	    fi
    	}

    	. "$DIR/dwmbar-functions/dwm_battery.sh"
    	. "$DIR/dwmbar-functions/dwm_alsa.sh"
    	. "$DIR/dwmbar-functions/dwm_resources.sh"

    	upperbar=""
    	upperbar="$upperbar$(dwm_resources)"
    	upperbar="$upperbar$(dwm_battery)"
    	upperbar="$upperbar$(dwm_alsa)"
    	upperbar="$upperbar$(dwm_date) "

    	xsetroot -name "$upperbar"
    $nvim ~/.config/dwm/dwmbar-functions/dwm_alsa.sh
    基于https://github.com/joestandring/dwm-bar 更改


    $sudo pacman -S feh picom alsa-utils
    	# feh 图片查看器，壁纸
    	# picom YiShui.git 终端半透明效果
    	# alsa-utils  amixer查询音量

### fullscreen 窗口全屏化

    $wget http://dwm.suckless.org/patches/fullscreen/dwm-fullscreen-6.2.diff

### hide_vacant_tags 只显示有任务的标签页

    $wget http://dwm.suckless.org/patches/hide_vacant_tags/dwm-hide_vacant_tags-6.3.diff

### noboder 标签中若只有一个任务窗口时不显示边界

    $wget http://dwm.suckless.org/patches/noborder/dwm-noborderfloatingfix-6.2.diff

### pertag 允许每个标签使用不同的分布模式[平铺/全屏/浮窗]

    $wget http://dwm.suckless.org/patches/pertag/dwm-pertag-20200914-61bb8b2.diff

### viewontag 将任务窗口移动到某个标签下，用户当前屏幕跟随移动到该标签页

    $wget http://dwm.suckless.org/patches/viewontag/dwm-viewontag-20210312-61bb8b2.diff

### rotatestack 调整数据栈平铺的相对位置(将栈上的窗口切换至 master)

    $wget http://dwm.suckless.org/patches/rotatestack/dwm-rotatestack-20161021-ab9571b.diff

### scratchpad 打开一个悬浮在最前端的窗口

    $wget http://dwm.suckless.org/patches/scratchpad/dwm-scratchpad-6.2.diff

### focus_adjacent_tag 相邻两窗口的相对位置

    $wget http://dwm.suckless.org/patches/focusadjacenttag/dwm-focusadjacenttag-6.3.diff

### vanitygaps 各个窗口间有一个空隙

    $wget http://dwm.suckless.org/patches/vanitygaps/dwm-vanitygaps-20200610-f09418b.diff

### awesomebar 将所有标签下的窗口全部显示在一个标签页下

    $wget http://dwm.suckless.org/patches/awesomebar/dwm-awesomebar-20200829-6.2.diff
