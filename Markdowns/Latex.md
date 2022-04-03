# 提纲挈领

## 文档的结构

- 标题 "\title" "\author" "\date" --> "\maketitle"
- 前言/摘要 "abstract 环境" / "\chapter\*"
- 目录 "\tableofcontents"(自动形成，直接调用该命令)
- 正文：篇，章，节，小节，小段... "\chapter" "\section"...
  - 文字、公式
  - 列表：带编号的，不带编号的，带小标题的...
  - 定理、引理、命题、证明、结论
  - 诗歌、引文、程序代码、算法伪码
  - 制表
  - 画图
- 文献(论文)/附录 "\bibliorgraphy" / "\appendix + \chapter" 或者"\section"
- 索引、词汇表 "\printindex"

## 文档类别

大型文档如书籍通常分为三部分

- \frontmatter -> 封面、标题、前言、目录
- \mainmatter -> 正文
- \backmatter -> 附录、索引、词汇表

一般文档：

- \appendix 或者 \appendixs

## 不同类别文档的编写逻辑(Latex)

- 小文档将所有的内容写在同一个目录中
- 大文档分为多个文件，并划分文件目录结构
  - 主文档，给出文档框架结构
  - 按照内容章节划分不同的文件
  - 使用单独的类文件和格式文件设置格式
  - 用小文件隔离复杂的图表

* \documentclass : 读入文档的类文件(.cls) --设定一些独特的模板格式
* \usepackage 读入一个格式文件-宏包(.sty)
* \include 分页，并读入章节文件(.tex)
* \input 读入任意的文件

```
	% language-main.tex
	\documentclass{book}
	\usepackage{makeidx}(需要生成索引)
	\makeindex

	\title{Languages}
	\author{someone}
	\date{}

	\begin{document}

	\frontmatter
	\maketitle
	\tableofcontents

	\mainmatter
	\include{intro}(章节一)
	\include{class}(章节二)

	\backmatter
	\include{appendix}
	\bibliorgraphy{foo}
	\printindex

	\end{document}

	%inro.tex
	\part{Introduction}
		\chapter{Background}

	%class.tex
	\part{Classification}
		\chapter{Natural Language}
		\chapter{Computer Languages}
			\section{Machine Languages}
			\section{High Level Languages}
				\subssection{Compiled Language}
				\subssection{Interpretative Language}
					\subsubsection{Lisp}
						\paragraph{Common Lisp}
						\paragraph{Scheme}
					\subsubsection{Perl}

	%appendix.tex
	\chapter{Appendix}

```

## 基础 Latex

### Latex

```
	\documentclass{article}
	\begin{document}
	Hello world!
	\end{document}

```

### 语法结构

- 命令
  - \cmd{arg1}{arg2}
    - \frac{1}{2}
  - \cmd[opt]{arg1}{arg2}
    - \documentclass[UTF8]{article}(pdflatex 编译器编译中文需要带上编码可选项)
- 环境

  - \begin{env} ... \end{env}
    - 数学公式
      - 独立成行的推荐放入\[ ... \]，不推荐使用旧时代的$$...$$环境
      - 矩阵 \begin{matrix} ...\\ ... \end{matrix}
    - 列表
      - enumerate 编号列表
      - itemize 不编号列表
      - description 有标题列表
    - 自定义的环境，如定理(类文件中定义)
      - \newtheorem{thm(正文引用的名称)}{定理{自动填写这两个字}}[section(按照节的序号自动编号)]
    - 代码环境
      - 单行\verb||
      - 多行\verbatim 环境 \begin{verbatim} ... \end{verbatim}
      - 语法高亮的代码 \begin{lstlisting} ... \end{lstlisting} 需要\usepackage{listings}
      - 语法高亮代码或者调用 minted 宏包(调用 Pygment)
    - 算法结构
      - clrscode (算法导论宏包)
      - algorithm2e
      - algorithmicx 宏包所包含的 algpseudocode 伪代码格式宏包
    - 表格
      - tabular https://www.tablesgenerator.com/latex_tables
      - 单元格处理：multirow(多行单元格合并)、makecell(一行拆成多行的)
      - 长表格：longtable(例如 300 行的数据表一页放不下，需要引入该宏包进行自动排版)、xtab(常用前面的)
      - 表格定宽：xtabular(用的相对少，定宽后一行放不下自动换行)
      - 表线控制：booktabs、diagbox(常用的斜线表头)、arydshln
      - 表列格式：array
      - 综合应用：tabu
    - 插图
      - graphix 宏包提供的\includegraphics 命令
      - \includegraphics[width=2cm]{pkulogo.pdf(放在同文件目录下)}
    - 画图
      - 优先使用外部工具画图，特别是可视化工具，例如一般的矢量图用 Inkscape、Illustrator、PowerPoint(保存为 pdf 格式)，数学图形使用 MATLAB、matplotlib 之类
      - TikZ 现代 Latex 绘图一般基于该绘图宏包
    - 浮动体 \begin{table}\centering ... \end{table}
      - Latex 下的表格，图片都是需要放入一个浮动体让它飘起来(默认是当成一个字符处理，即跟随被编写放入的位置)，
      - 飘起来后再用其他命令将其指定放入目标位置，浮动体有个自动编号的命令\caption{标题}
  - 注释
    - %
  - 自动化工具
    - 理论上需要编译两次，第一次编译把交叉引用的编号或者目录生成放入 aux(引用编号)和.toc(目录)辅助文件里，第二次从 aux 中提取放入到正文
    - hyperref: PDF 的链接与书签宏包，hyperref 会在 PDF 中写入相应的“锚点”代码，方便在其他地方引用。PDF 书签单独放入.out 文件，目录的代码并入.toc 文件，交叉引用的的代码并入.aux 文件
    - Bibtex 参考文献宏包 参考文件管理工具 Jabref
    - 参考文献数据库网站 https://www.acm.org
    - 设置文献格式 选用合适.bst 格式，不同期刊对文献格式要求不同，例如 plainnat,gbt7714-plain(中文推荐)
      - 不按照编号引用排列引用的文献，可以按照作者-年格式排版，使用宏包 natbib
      - 利用 custom-bib 产生定制的格式文件

### 正文文本

- 空格即分开单词，一个换行符等同于一个空格，连续多个空格效果等同于一个空格
- 自然段使用空一行方式进行分段

### 宏包

- amsmath mathtools 是 amsmath 的补充和增强宏包
- siunitx 数字单位的完全解决方案(科学计数法,物理量的大数字间隔，立方米的排版)
- chemformula 化学公式专业宏包代替原来旧有的 mhchem

### 常见错误

| description                                                                                                     |                                                                                                                                                                          |
| --------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| cjkfonts.tex\| \| Package fontspec Warning: Font "WenQuanYi Micro Hei" does not contain requested Script "CJK". | \setCJKmainfont{WenQuanYi Micro Hei}设定的语句，CJK Script 是 OpenType 字体，WQY 字体是 TrueType 字体，实际使用是不影响的，消除该警告可以使用 otf 封装的字体，如思源字体 |
| cjkfonts.tex\|8 error\| Undefined control sequence. 中文 {\LaTex}                                               | 一般情况下是错误使用                                                                                                                                                     |
