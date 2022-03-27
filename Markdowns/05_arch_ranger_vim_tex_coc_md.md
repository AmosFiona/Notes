# Ranger 终端下的文件管理器

## 安装

```
    $sudo pacman -S ranger ueberzug ffmpegthumbnailer python-pdftotext highlight w3m
    	# ueberzug 预览图片
    	# ffmpegthumbnailer 预览视频文件
    	# python-pdftotext 预览PDF文件
    	# w3m 预览网页
    	# highlight 预览文本时高亮代码语法
```

## 配置增加前面的图标

```
    $ranger --copy-confing=all
    $git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.confing/ranger/plugins/ranger_devicons
    $nvim ~/.zshrc  [~/.bashrc也写入下]
    	export RANGER_LOAD_DEFAULT_RC=FALSE
    $env [检查环境变量是否输入]
    $nvim ~/.confing/ranger/rc.conf
    	default_linemode devicons
```

## 修改预览

```
    $nvim ~/.confing/ranger/rc.conf
    	- set preview_images false
    	- set preview_images_method w3m
    	- set vcs_aware false
    	- set vcs_backend_git disable
    	+ set preview_images true
    	+ set preview_images_method ueberzug   [开启图片预览]
    	+ set vcs_aware true
    	+ set vcs_backend_git enable           [开启git状态标记]
    $nvim ~/.confing/ranger/scop.sh
        ## PDF                      [预览PDF]
        pdf)
            ## Preview as text conversion
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | \
              fmt -w "${PV_WIDTH}" && exit 5
            mutool draw -F txt -i -- "${FILE_PATH}" 1-10 | \
              fmt -w "${PV_WIDTH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;
```

```
        ## PDF
         application/pdf)
             pdftoppm -f 1 -l 1 \
                      -scale-to-x "${DEFAULT_SIZE%x*}" \
                      -scale-to-y -1 \
                      -singlefile \
                      -jpeg -tiffcompression jpeg \
                      -- "${FILE_PATH}" "${IMAGE_CACHE_PATH%.*}" \
                 && exit 6 || exit 1;;
```

```
        ## ePub, MOBI, FB2 (using Calibre)
         application/epub+zip|application/x-mobipocket-ebook|\
         application/x-fictionbook+xml)
             # ePub (using https://github.com/marianosimone/epub-thumbnailer)
             epub-thumbnailer "${FILE_PATH}" "${IMAGE_CACHE_PATH}" \
                 "${DEFAULT_SIZE%x*}" && exit 6
             ebook-meta --get-cover="${IMAGE_CACHE_PATH}" -- "${FILE_PATH}" \
                 >/dev/null && exit 6
             exit 1;;
```

```
        ## Video                            [预览视频]
         video/*)
             # Thumbnail
             ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && exit 6
             exit 1;;
```

```
        ## Video and audio
        video/* | audio/*)
            mediainfo "${FILE_PATH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;

```

# Neovim 配置

## 文件结构

```

    	.
    	├── autoload          [vim-plug插件管理器加载目录]
    	│   └── plug.vim
    	├── coc-settings.json
    	├── Fio-Ultisnips     [存放自定义的补全文件夹]
    	├── init.vim          [nvim打开时加载的配置文件]
    	├── module            [避免init.vim文件过长，进行分类存放加载的配置文件夹]
    	│   ├── base.vim      [基础配置]
    	│   ├── hotkey.vim    [映射配置]
    	│   ├── latex.vim     [latex相关配置]
    	│   ├── markdown.vim  [markdown相关配置]
    	│   ├── plug-configs  [存放各个nvim插件对应的参数变量设定]
    	│   │   ├── coc-extensions.vim
    	│   │   ├── fzf.vim
    	│   │   ├── git.vim
    	│   │   ├── marking.vim
    	│   │   ├── rainbow.vim
    	│   │   └── rnvimr.vim
    	│   └── plug.vim      [nvim插件配置]
    	└── plugged           [从plug.vim中下载并安装的插件源码存放目录]

```

# Latex 配置

## 安装

```
    $yay -S texlive-full   [官方没有提供安装包，从用户上传的软件管理库AUR中下载]
    $tex -v  [检查安装后的版本，支持小版本更新，大更新卸载后重新安装，每年4月1日大版本更新]
    $tlmgr update --all   [更新当前版本的texlive]

    $sudo pacman -S zathura zathura-pdf-mupdf xdotool zathura-djvu zathura-cb zathura-ps
    	# zathura-pdf-mupdf 解决打开zathura时提示的错误
    		error： Colud not open plugin directory: /usr/lib/zathura
    		error： unkown file type
    	# xdotool  使zathura支持向前搜索的工具，未安装时候，运行nvim下的：checkhealth可以查看到相关的提示警告
    	# zathura-djvu Djvu支持
    	# zathura-cb  漫画支持
    	# zathura-ps  PostScript支持
    $nvim ~/.config/nvim/module/plug.vim
    	call plug#begin('~/.config/nvim/plugged')

    	" vimtex or[Installed CoC] :CocInstall coc-vimtex for Latex
    	Plug 'lervag/vimtex'
    	Plug 'KeitaNakamura/tex-conceal.vim'
    	"Plug 'wjakob/wjakob.vim' "已经复制tex.vim

    	call plug#end()


    	"lervag/vimtex
    	filetype plugin indent on
    	syntax enable
    	let g:tex_flavor = 'latex'
    	let g:vimtex_view_method = 'zathura'
    	let g:vimtex_compiler_latexmk_engines = {'_':'-xelatex'}
    	let g:vimtex_compiler_latexrun_engines = {'_':'-xelatex'}
    	let g:Tex_CompilerRule_pdf = 'xelatex -synctex=1 --interaction=nonstopmode $*'
    	let g:vimtex_quickfix_mode = 1

    	"KeitaNakamura/tex-conceal.vim
    	set conceallevel=2
    	let g:tex_conceal = 'abdmg'
    $nvim ~/.config/zathura/zathurarc  [修改zathura配色为黑背景,没有该文件则新建]
    	set recolor true
    	set recolor-darkcolor \#dcdccc
    	set recolor-lightcolor \#1f1f1f
    	set selection-clipboard clipboard

```

# Markdown 配置

## 安装

```
    $sudo pacman -S nodejs yarn
    $nvim ~/.config/nvim/module/plug.vim
    	call plug#begin('~/.config/nvim/plugged')

    	" Markdown https://zhuanlan.zhihu.com/p/84773275
    	Plug 'godlygeek/tabular'
    	Plug 'preservim/vim-markdown'
    	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } "sudo pacman -S nodejs yarn
    	Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
    	Plug 'ferrine/md-img-paste.vim' " <leader-p>
    	Plug 'dkarter/bullets.vim'

    	call plug#end()

    	[快捷键参照github上的配置：https://github.com/AmosFiona/nvim]

    	" vim-table-mode
    	let g:table_mode_motion_up_map = '<c-k>'
    	let g:table_mode_motion_down_map = '<c-j>'
    	let g:table_mode_motion_left_map = '<c-h>'
    	let g:table_mode_motion_right_map = '<c-l>'

    	" md-img-paste
    	let file_name = expand('%:t:r')
    	let g:mdip_imgdir = "media/".file_name
    	autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

    	" markdown-preview
    	" specify browser to open preview page
    	" default: ''
    	let g:mkdp_browser = 'chromium'
    	" set to 1, nvim will open the preview window after entering the markdown buffer
    	" default: 0
    	let g:mkdp_auto_start = 0

    	" set to 1, the nvim will auto close current preview window when change
    	" from markdown buffer to another buffer
    	" default: 1
    	let g:mkdp_auto_close = 1

    	" set to 1, the vim will refresh markdown when save the buffer or
    	" leave from insert mode, default 0 is auto refresh markdown as you edit or
    	" move the cursor
    	" default: 0
    	let g:mkdp_refresh_slow = 0

    	" set to 1, the MarkdownPreview command can be use for all files,
    	" by default it can be use in markdown file
    	" default: 0
    	let g:mkdp_command_for_global = 0

    	" set to 1, preview server available to others in your network
    	" by default, the server listens on localhost (127.0.0.1)
    	" default: 0
    	let g:mkdp_open_to_the_world = 0

    	" use custom IP to open preview page
    	" useful when you work in remote vim and preview on local browser
    	" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
    	" default empty
    	let g:mkdp_open_ip = ''


    	" set to 1, echo preview page url in command line when open preview page
    	" default is 0
    	let g:mkdp_echo_preview_url = 0

    	" a custom vim function name to open preview page
    	" this function will receive url as param
    	" default is empty
    	let g:mkdp_browserfunc = ''

    	" options for markdown render
    	" mkit: markdown-it options for render
    	" katex: katex options for math
    	" uml: markdown-it-plantuml options
    	" maid: mermaid options
    	" disable_sync_scroll: if disable sync scroll, default 0
    	" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
    	"   middle: mean the cursor position alway show at the middle of the preview page
    	"   top: mean the vim top viewport alway show at the top of the preview page
    	"   relative: mean the cursor position alway show at the relative positon of the preview page
    	" hide_yaml_meta: if hide yaml metadata, default is 1
    	" sequence_diagrams: js-sequence-diagrams options
    	" content_editable: if enable content editable for preview page, default: v:false
    	" disable_filename: if disable filename header for preview page, default: 0
    	let g:mkdp_preview_options = {
    	    \ 'mkit': {},
    	    \ 'katex': {},
    	    \ 'uml': {},
    	    \ 'maid': {},
    	    \ 'disable_sync_scroll': 0,
    	    \ 'sync_scroll_type': 'middle',
    	    \ 'hide_yaml_meta': 1,
    	    \ 'sequence_diagrams': {},
    	    \ 'flowchart_diagrams': {},
    	    \ 'content_editable': v:false,
    	    \ 'disable_filename': 0
    	    \ }

    	" use a custom markdown style must be absolute path
    	" like '/Users/username/markdown.css' or expand('~/markdown.css')
    	let g:mkdp_markdown_css = ''

    	" use a custom highlight style must absolute path
    	" like '/Users/username/highlight.css' or expand('~/highlight.css')
    	let g:mkdp_highlight_css = ''

    	" use a custom port to start server or random for empty
    	let g:mkdp_port = ''

    	" preview page title
    	" ${name} will be replace with the file name
    	let g:mkdp_page_title = '「${name}」'

    	" recognized filetypes
    	" these filetypes will have MarkdownPreview... commands
    	let g:mkdp_filetypes = ['markdown']


    	" vim-table-mode
    	" noremap <Leader>tm :TableModeToggle<CR>

    	" vim-markdown
    	let g:vim_markdown_no_default_key_mappings = 1
    	let g:vim_markdown_folding_level=6
    	let g:vim_markdown_conceal_code_blocks = 0
    	let g:vim_markdown_folding_style_pythonic = 1
    	let g:vim_markdown_override_foldtext = 0
    	" noremap mt :Toc<CR>:vert res 40<CR>
```

# CoC 自动补全配置

## 结构目录

```
    	.
    	├── coc
    	│   ├── extensions
    	│   ├── list-extensions-history.json
    	│   ├── list-lists-history.json
    	│   ├── lists
    	│   ├── memos.json
    	│   ├── suggest.txt
    	│   └── ultisnips
    	└── nvim
    	    ├── autoload
    	    │   └── plug.vim
    	    ├── coc-settings.json
    	    ├── Fio-Ultisnips
    	    ├── init.vim
    	    ├── module
    	    │   ├── base.vim
    	    │   ├── hotkey.vim
    	    │   ├── latex.vim
    	    │   ├── markdown.vim
    	    │   ├── plug-configs
    	    │   │   └── coc-extensions.vim
    	    │   └── plug.vim
    	    └── plugged

```

解释说明:\
1.通过 vim-plug 插件管理器安装 coc 自动补全插件：\
coc.vim 是作为 nvim 的插件,如同 vim-plug 一样是一个管理 coc 插件的管理器

2.:CocInstall coc-json coc-tsserver\
coc-extensions 是通过 coc 插件进行安装的 vim 功能插件(常用的代码自动补全)

3.:CocConfig 生成 coc-settings.json 文件\
coc-settings.json 是配置 coc 插件的相关参数开关以及 coc 插件管理

4.此时 vim 下的补全环境工具安装完成但是无法使用，没有告诉 coc 想要自动补全的编程语言是什么.若想在 vim 中获取自动补全需要安装 Language Server Port(LSP)

## 安装

```

    $nvim ~/.config/nvim/module/plug.vim
    	call plug#begin('~/.config/nvim/plugged')

    	"COC.nvim
    	Plug 'neoclide/coc.nvim',{'branch':'release'}

    	call plug#end()
    	source $HOME/.config/nvim/module/plug-configs/coc-extensions.vim

    $nvim ~/.config/nvim/module/plug.vim  -> :CocInfo [检查安装的CoC]
    $nvim ~/.config/nvim/module/plug.vim  -> :CoCInstall coc-json coc-tssever [安装coc所管理的插件或者通过写入自动安装函数:参见coc-extensions.vim]
    $nvim ~/.config/nvim/module/plug.vim  -> :CocConfig [生成配置文件coc-settings.json]
    $nvim ~/.config/nvim/module/plug.vim  -> :checkhealth
    $sudo pacman -S python-pip     [安装pip3]
    $pip --version
    $python3 -m pip install pynvim [解决python3与neovim的provider冲突]
    $sudo pacman -S npm
    $yay clangd		[查询可安装的clangd，官方pacman没有提供 For C/C++/Object-C LSP]
    	5 aur/arduino-language-server-bin 0.6.0-1 (+0 0.00)
    	    An Arduino Language Server based on Clangd to Arduino code autocompletion
    	4 aur/arduino-language-server-git 1:1.0.1-1 (+0 0.00)
    	    An Arduino Language Server based on Clangd to Arduino code autocompletion
    	3 aur/neovim-coc-clangd-git r116.a3650f2-1 (+1 0.01) (Installed: r426.81dcc45-1)
    	    C/C++/ObjC support for coc.nvim (powered by clangd)
    	2 aur/vim-coc-clangd-git r116.a3650f2-1 (+1 0.06)
    	    C/C++/ObjC support for coc.nvim (powered by clangd)
    	1 archlinuxcn/neovim-coc-clangd-git r426.81dcc45-1 (191.9 KiB 1.2 MiB) (Installed)
    	    C/C++/ObjC support for coc.nvim (powered by clangd)
    	==> Packages to install (eg: 1 2 3, 1-3 or ^4)
    	==> 1

```
