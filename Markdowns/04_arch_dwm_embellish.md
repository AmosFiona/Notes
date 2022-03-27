# 美化 dwm

## 打补丁增强功能

```
    $cd ~/Software/dwm/ && mkdir org && mv config.def.h ./org
```

### alpha 标签兰半透明

```
    $wget http://dwm.suckless.org/patches/alpha/dwm-alpha-20201019-61bb8b2.diff
    $patch < dwm-alpha-20201019-61bb8b2.diff
    	config.h [提示找不到config.def.h,是因为移动到了新建的org文件夹下，这时指定打入的文件：config.h]
    $sudo make clean install
    $Shift + Alt + q [退出]
    $startx  [看效果]
```

### autostart 自动运行 shell 脚本

```
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
```

参考 dwm 官方推荐的 status https://github.com/joestandring/dwm-bar

```
    [$HOME/.config/dwm/dwmbar-functions/dwm_battery.sh ]
    		#!/bin/sh

    		# A dwm_bar function to read the battery level and status
    		# Joe Standring <git@joestandring.com>
    		# GNU GPLv3

    		dwm_battery () {
    		    # Change BAT1 to whatever your battery is identified as. Typically BAT0 or BAT1
    		    CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)
    		    STATUS=$(cat /sys/class/power_supply/BAT0/status)
    			CYCLES=$(cat /sys/class/power_supply/BAT0/cycle_count)

    		    printf "%s" "$SEP1"
    		    if [ "$IDENTIFIER" = "unicode" ]; then
    		        if [ "$STATUS" = "Charging" ]; then
    		            printf "🔌 %s%% %s ♻ %s"  "$CHARGE" "$STATUS" "$CYCLES"
    		        else
    		            printf "🔋 %s%% %s ♻ %s" "$CHARGE" "$STATUS" "$CYCLES"
    		        fi
    		    else
    		        printf "BAT %s%% %s ♻ %s" "$CHARGE" "$STATUS" "$CYCLES"
    		    fi
    		    printf "%s\n" "$SEP2"
    		}

    		dwm_battery


    [$HOME/.config/dwm/dwmbar-functions/dwm_resources.sh ]

    		#!/bin/sh

    		# A dwm_bar function to display information regarding system memory, CPU temperature, and storage
    		# Joe Standring <git@joestandring.com>
    		# GNU GPLv3

    		df_check_location='/home'

    		dwm_resources () {
    			# get all the infos first to avoid high resources usage
    			free_output=$(free -h | grep Mem)
    			df_output=$(df -h $df_check_location | tail -n 1)
    			# Used and total memory
    			MEMUSED=$(echo $free_output | awk '{print $3}')
    			MEMTOT=$(echo $free_output | awk '{print $2}')
    			# CPU temperature
    			CPU=$(top -bn1 | grep Cpu | awk '{print $2}')%
    			#CPU=$(sysctl -n hw.sensors.cpu0.temp0 | cut -d. -f1)
    			# Used and total storage in /home (rounded to 1024B)
    			STOUSED=$(echo $df_output | awk '{print $3}')
    			STOTOT=$(echo $df_output | awk '{print $2}')
    			STOPER=$(echo $df_output | awk '{print $5}')

    			printf "%s" "$SEP1"
    			if [ "$IDENTIFIER" = "unicode" ]; then
    				printf "💻 MEM %s/%s CPU %s STO %s/%s: %s" "$MEMUSED" "$MEMTOT" "$CPU" "$STOUSED" "$STOTOT" "$STOPER"
    			else
    				printf "STA | MEM %s/%s CPU %s STO %s/%s: %s" "$MEMUSED" "$MEMTOT" "$CPU" "$STOUSED" "$STOTOT" "$STOPER"
    			fi
    			printf "%s\n" "$SEP2"
    		}

    		dwm_resources


    [$HOME/.config/dwm/dwmbar-functions/dwm_alsa.sh ]

    		#!/bin/sh

    		# A dwm_bar function to show the master volume of ALSA
    		# Joe Standring <git@joestandring.com>
    		# GNU GPLv3

    		# Dependencies: alsa-utils

    		dwm_alsa () {
    			STATUS=$(amixer sget Master | tail -n1 | sed -r "s/.*\[(.*)\]/\1/")
    		    VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
    		    printf "%s" "$SEP1"
    		    if [ "$IDENTIFIER" = "unicode" ]; then
    		    	if [ "$STATUS" = "off" ]; then
    			            printf "🔇"
    		    	else
    		    		#removed this line becuase it may get confusing
    			        if [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
    			            printf "🔈 %s%%" "$VOL"
    			        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
    			            printf "🔉 %s%%" "$VOL"
    			        else
    			            printf "🔊 %s%%" "$VOL"
    			        fi
    				fi
    		    else
    		    	if [ "$STATUS" = "off" ]; then
    		    		printf "MUTE"
    		    	else
    			        # removed this line because it may get confusing
    			        if [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
    			            printf "VOL %s%%" "$VOL"
    			        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
    			            printf "VOL %s%%" "$VOL"
    			        else
    			            printf "VOL %s%%" "$VOL"
    		        	fi
    		        fi
    		    fi
    		    printf "%s\n" "$SEP2"
    		}

    		dwm_alsa
```

```
    $sudo pacman -S feh picom alsa-utils [以上脚本需要安装的工具/软件]
    	# feh 图片查看器，壁纸
    	# picom YiShui.git 终端半透明效果
    	# alsa-utils  amixer查询音量
```

#### picom

```
    $mkdir $HOME/.config/picom && cd $HOME/.config/picom
    $sudo cp /etc/xdg/picom.conf $HOME/.config/picom
    或者 $cp /usr/share/doc/picom/picom.conf.example $HOME/.config/picom/picom.conf
    $sudo nvim pciom.conf
```

[ Transparency / Opacity ]

| 分类 | 外部应用                               | 终端模拟器               | 输入法弹窗[位于文末 wintypes:中] |
| ---- | -------------------------------------- | ------------------------ | -------------------------------- |
| 参数 | opacity-rule = [                       | inactive-opacity = 0.75; | popup_menu = { opacity = 0.9; }  |
|      | "95:class_g = 'google-chrome-stable'", |                          |                                  |
|      | "85:class_g = 'Chromium'",             |                          |                                  |
|      | "90:class_g = 'st-256color'"           |                          |                                  |
|      | ];                                     |                          |                                  |

#### alsa

```
    $alssmixer  [F6切换后可见控制]
    $ amixer -c 1 scontrols {查看可以控制的选项}
    	Simple mixer control 'Master',0
    	Simple mixer control 'Headphone',0
    	Simple mixer control 'Speaker',0
    	Simple mixer control 'Mic Boost',0
    	Simple mixer control 'Capture',0
    	Simple mixer control 'Auto-Mute Mode',0
    $ aplay -l  [查看设备对应的声卡]
    	**** List of PLAYBACK Hardware Devices ****
    	card 0: Generic [HD-Audio Generic], device 3: HDMI 0 [HDMI 0]
    	  Subdevices: 1/1
    	  Subdevice #0: subdevice #0
    	card 1: Generic_1 [HD-Audio Generic], device 0: ALC294 Analog [ALC294 Analog]
    	  Subdevices: 1/1
    	  Subdevice #0: subdevice #0
    $sudo nvim /etc/asound.conf  [或者用户级别的 $nvim ~/asoundrc]
    	defaults.pcm.card 1
    	defaults.pcm.device 0
    	defaults.ctl.card 1
    [pcm 是决定用来播放音频的设备]
    [ctl 是该声卡能够由控制工具使用，如alsamixer]
    此处解决error：
    	amixer:Uable to find simple control 'Master',0.
```

### fullscreen 窗口全屏化

```
    $wget http://dwm.suckless.org/patches/fullscreen/dwm-fullscreen-6.2.diff
```

### hide_vacant_tags 只显示有任务的标签页

```
    $wget http://dwm.suckless.org/patches/hide_vacant_tags/dwm-hide_vacant_tags-6.3.diff
```

### noboder 标签中若只有一个任务窗口时不显示边界

```
    $wget http://dwm.suckless.org/patches/noborder/dwm-noborderfloatingfix-6.2.diff
```

### pertag 允许每个标签使用不同的分布模式[平铺/全屏/浮窗]

```
    $wget http://dwm.suckless.org/patches/pertag/dwm-pertag-20200914-61bb8b2.diff
```

### viewontag 将任务窗口移动到某个标签下，用户当前屏幕跟随移动到该标签页

```
    $wget http://dwm.suckless.org/patches/viewontag/dwm-viewontag-20210312-61bb8b2.diff
```

### rotatestack 调整数据栈平铺的相对位置(将栈上的窗口切换至 master)

```
    $wget http://dwm.suckless.org/patches/rotatestack/dwm-rotatestack-20161021-ab9571b.diff
```

### scratchpad 打开一个悬浮在最前端的窗口

```
    $wget http://dwm.suckless.org/patches/scratchpad/dwm-scratchpad-6.2.diff
```

### focus_adjacent_tag 相邻两窗口的相对位置

```
    $wget http://dwm.suckless.org/patches/focusadjacenttag/dwm-focusadjacenttag-6.3.diff
```

### vanitygaps 各个窗口间有一个空隙

```
    $wget http://dwm.suckless.org/patches/vanitygaps/dwm-vanitygaps-20200610-f09418b.diff
```

### awesomebar 将所有标签下的窗口全部显示在一个标签页下

```
    $wget http://dwm.suckless.org/patches/awesomebar/dwm-awesomebar-20200829-6.2.diff
```

### 添加彩色图表(emoji)

```
    $yay -S libxft-bgra-git [安装libxft-bgra替代系统已安装的libxft,避免状态栏加载emoji时崩溃]
    $sudo pacman -S ttf-joypixels
    $fc-list | grep "joy"   [查找emoji图标字体的名称]
    	/usr/share/fonts/joypixels/JoyPixels.ttf: JoyPixels:style=Regular
    $ fc-list | grep "Source Code Pro"
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-BlackIt.otf: Source Code Pro,Source Code Pro Black:style=Black Italic,Italic
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-LightIt.otf: Source Code Pro,Source Code Pro Light:style=Light Italic,Italic
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-Bold.otf: Source Code Pro:style=Bold
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-Regular.otf: Source Code Pro:style=Regular
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-Medium.otf: Source Code Pro,Source Code Pro Medium:style=Medium,Regular
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-MediumIt.otf: Source Code Pro,Source Code Pro Medium:style=Medium Italic,Italic
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-Light.otf: Source Code Pro,Source Code Pro Light:style=Light,Regular
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-Black.otf: Source Code Pro,Source Code Pro Black:style=Black,Regular
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-ExtraLight.otf: Source Code Pro,Source Code Pro ExtraLight:style=ExtraLight,Regular
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-BoldIt.otf: Source Code Pro:style=Bold Italic
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-ExtraLightIt.otf: Source Code Pro,Source Code Pro ExtraLight:style=ExtraLight Italic,Italic
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-SemiboldIt.otf: Source Code Pro,Source Code Pro Semibold:style=Semibold Italic,Italic
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-It.otf: Source Code Pro:style=Italic
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-Semibold.otf: Source Code Pro,Source Code Pro Semibold:style=Semibold,Regular
    $ fc-list | grep "WenQuanYi"
    	/usr/share/fonts/wenquanyi/wenquanyi_11pt.pcf: WenQuanYi WenQuanYi Bitmap Song:style=Regular
    	/usr/share/fonts/wenquanyi/wenquanyi_12pt.pcf: WenQuanYi WenQuanYi Bitmap Song:style=Regular
    	/usr/share/fonts/wenquanyi/wenquanyi_10pt.pcf: WenQuanYi WenQuanYi Bitmap Song:style=Regular
    	/usr/share/fonts/wenquanyi/wqy-zenhei/wqy-zenhei.ttc: WenQuanYi Zen Hei Mono,文泉驛等寬正黑,文泉驿等宽正黑:style=Regular
    	/usr/share/fonts/wenquanyi/wqy-microhei/wqy-microhei.ttc: WenQuanYi Micro Hei,文泉驛微米黑,文泉驿微米黑:style=Regular
    	/usr/share/fonts/wenquanyi/wenquanyi_9pt.pcf: WenQuanYi WenQuanYi Bitmap Song:style=Regular
    	/usr/share/fonts/wenquanyi/wqy-zenhei/wqy-zenhei.ttc: WenQuanYi Zen Hei Sharp,文泉驛點陣正黑,文泉驿点阵正黑:style=Regular
    	/usr/share/fonts/wenquanyi/wqy-microhei/wqy-microhei.ttc: WenQuanYi Micro Hei Mono,文泉驛等寬微米黑,文泉驿等宽微米黑:style=Regular
    	/usr/share/fonts/wenquanyi/wqy-microhei-lite/wqy-microhei-lite.ttc: WenQuanYi Micro Hei Light,文泉驛微米黑,文泉驿微米黑:style=Light
    	/usr/share/fonts/wenquanyi/wqy-microhei-lite/wqy-microhei-lite.ttc: WenQuanYi Micro Hei Mono Light,文泉驛等寬微米黑,文泉驿等宽微米黑:style=Light
    	/usr/share/fonts/wenquanyi/wqy-zenhei/wqy-zenhei.ttc: WenQuanYi Zen Hei,文泉驛正黑,文泉驿正黑:style=Regular
    	/usr/share/fonts/wenquanyi/wenquanyi_13px.pcf: WenQuanYi WenQuanYi Bitmap Song:style=Regular
    [使用的字体:使得中文字体得到正常显示且与英文字号相匹配，同种字号大小，中英文及emoji图标大小各不相同，通过设定更改令三者大小协调]

    	/usr/share/fonts/wenquanyi/wqy-microhei/wqy-microhei.ttc: WenQuanYi Micro Hei,文泉驛微米黑,文泉驿微米黑:style=Regular
    	/usr/share/fonts/adobe-source-code-pro/SourceCodePro-Regular.otf: Source Code Pro:style=Regular
    	/usr/share/fonts/joypixels/JoyPixels.ttf: JoyPixels:style=Regular

    $nvim ~/Software/dwm/config.h
    	static const char *fonts[]          = { "Source Code Pro:size=18",                                                      /* for terminal display, fonts: adobe-source-code-pro-fonts */
    	                                        "WenQuanYi Micro Hei:size=18:type=Regular:antialias=true:autohint=true",        /* for Simpled Chinese, fonts: wqy-microhei */
    	                                        "JoyPixels:pixelsize=20:type=Regular:antialias=true:autohint=true",             /* for status icons, fonts: ttf-joypixels */
    	                                        "Symbols Nerd Font:pixelsize=20:type=2048-em:antialias=true:autohint:true"      /* for tag icons, fonts: ttf-nerd-fonts-symbols */
    	                                      };
    	static const char dmenufont[]       = "Source Code Pro:size=12";
    	static const char *tags[] = { " 1", " 2", " 3", " 4", " 5", " 6", " 7", " 8", " 9" };
    	/* Looking " https://www.nerdfonts.com/cheat-sheet " for icons */
    $cd ~/Software/dwm/ && grep iscol * [取消禁止颜色]
    $ grep iscol *
    	drw.c:  FcBool iscol;
    	drw.c:  if(FcPatternGetBool(xfont->pattern, FC_COLOR, 0, &iscol) == FcResultMatch && iscol) {
    	grep: org: Is a directory
    	grep: patches: Is a directory
    $nvim drw.c
    	- 	FcBool iscol;
    	-	if(FcPatternGetBool(xfont->pattern, FC_COLOR, 0, &iscol) == FcResultMatch && iscol) {
    	-		XftFontClose(drw->dpy, xfont);
    	-		return NULL;
    	-	}
    	+ /*
    	+ *	FcBool iscol;
            + *	if(FcPatternGetBool(xfont->pattern, FC_COLOR, 0, &iscol) == FcResultMatch && iscol) {
    	+ *		XftFontClose(drw->dpy, xfont);
    	+ *		return NULL;
    	+ *	}
    	+ */
    $sudo make clean install
```

### st 美化

#### alpha 半透明

```
    $wget http://st.suckless.org/patches/alpha/st-alpha-20220206-0.8.5.diff
```

#### anysize

```
    $wget http://st.suckless.org/patches/anysize/st-anysize-0.8.4.diff
```

#### dracula

```
    $wget http://st.suckless.org/patches/dracula/st-dracula-0.8.2.diff
```

#### scrollback

```
    [1]$wget http://st.suckless.org/patches/scrollback/st-scrollback-20210507-4536f46.diff
    [2]$wget http://st.suckless.org/patches/scrollback/st-scrollback-mouse-20220127-2c5edf2.diff
    [3]$wget http://st.suckless.org/patches/scrollback/st-scrollback-mouse-altscreen-20220127-2c5edf2.diff
```

#### hidecursor

```
    $wget http://st.suckless.org/patches/hidecursor/st-hidecursor-0.8.3.diff
```

#### copycurl

```
    $wget http://st.suckless.org/patches/copyurl/st-copyurl-20220217-0.8.5.diff
```
