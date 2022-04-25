%! program =xeLatex

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lecture}
\LoadClass[fontset=none]{ctexbook}
%\LoadClass{ctexbook}

% Fonts -CN
%RequirePackage{xeCJK}
\setCJKfamilyfont{fsong}{Source Han Serif CN}
\def\StandardArial{\CJKfamily{fsong}}

\setCJKmainfont{Source Han Serif CN}
\setCJKsansfont{Source Han Serif CN}
\setCJKmonofont{Source Han Serif CN}

	\xeCJKsetup{PunctStyle=kaiming}
	%\xeCJKsetup{PunctFamily=zhsong} % setting by xeCJK
	\xeCJKsetup{CJKmath}
	\xeCJKsetup{CheckSingle}


% Fonts -En
\setmainfont{Source Code Pro}
\setsansfont{Source Code Pro}
\setmonofont{Source Code Pro}

% Auto change the end of lines to dot
\defaultfontfeatures{Mapping=fullwidth-stop}

% mathmacro
\RequirePackage{ mathtools }
	\lineskiplimit=5pt
	\lineskip=6pt
\RequirePackage{ amssymb }
	\delimiterfactor=800
\RequirePackage{ empheq }
\RequirePackage{ esvect }

\medmuskip = 3mu plus 1mu minus 2mu
\thinmuskip = 3mu plus 2mu

\DeclareMathSizes{10.5 bp}{10.5 bp}{6.8 pt}{6 pt}

% line gap
\RequirePackage[bodytextleadingratio=1.5,restoremathleading=true]{zhlineskip}
\SetMathEnvironmentSinglespace{1.1}

% Page
\RequirePackage{ geometry }
\geometry
	{
		paperheight = 29.7 cm,
		paperwidth 	= 21 cm,
		width 			= 17 cm,
		height 			= 24.7 cm,
		left 				= 1.8 cm,
		right 			= 1.6 cm,
		top 				= 2.5 cm,
		bottom 			= 2.5 cm,
		headsep 		= 3.2 em,
	}

% colors boxder macro
\RequirePackage{tcolorbox}
	\tcbuselibrary{ most }

% draw Pictures
\RequirePackage{ tikz }
\RequirePackage{ tikzpagenodes }
	\usetikzlibrary{ shapes.callouts }
	\usetikzlibrary{ shapes.geometric }
	\usetikzlibrary{ positioning }

% multicolumn
\RequirePackage{multicol}

% column lines
\RequirePackage[tikz]{multicolrule}
	\usetikzlibrary{calc}
	\usetikzlibrary{decorations.pathmorphing}
\setlength{\columnsep}{2em}
% wavelines
%\SetMCRule{
%		width 			= 0.5 pt,
%		custom-line =
%			{
%				\draw
%					[
%						decorate,
%						decoration = {coil, aspect = 0}
%					](TOP) -- (BOT);
%			}
%	}

% default lines
\SetMCRule{width = 0.5 pt}

% chapter title
\RequirePackage{ etoolbox }

% textcircled   must be less 999
\newlength\szg
\newcommand\quan[1]
	{
		\settoheight\szg{#1}
		\tikz[baseline]
			{
				\pgfmathparse
					{
						ifthenelse(#1 < 10, 0.9, ifthenelse(#1 < 100, 0.7, 0.45))
					}
				\let\hfs\pgfmathresult
				\node at (0,\szg/2) {\makebox[0.35em][c]{\scalebox{\hfs}[1]{#1}}};
				\draw (0,\szg/2) circle (\szg/2+0.28ex);
			}
	}

\newcommand\fquan[1]
	{
		\settoheight\szg{#1}
		\tikz[baseline]
			{
				\pgfmathparse
					{
						ifthenelse(#1 < 10, 0.9, ifthenelse(#1 < 100, 0.7, 0.45))
					}
				\let\hfs\pgfmathresult
				\node at (0,\szg/2) {\makebox[0.35em][c]{\scalebox{\hfs}[1]{#1}}};
				\draw (-1ex,-0.3ex) rectangle (1ex,1.8ex);
			}
	}

\newcommand\hfquan[1]
	{
		\settoheight\szg{#1}
		\tikz[baseline]
			{
				\pgfmathparse
					{
						ifthenelse(#1 < 10, 0.9, ifthenelse(#1 < 100, 0.6, 0.4))
					}
				\let\hfs\pgfmathresult
				\filldraw[black] (-1ex,-0.3ex) rectangle (1ex,1.8ex);
				\node[white] at (0,\szg/2) {\makebox[0.35em][c]{\scalebox{\hfs}[1]{\plt\textbf{#1}}}};
			}
	}

\newcommand\hquan[1]
	{
		\settoheight\szg{#1}
		\tikz[baseline]
			{
				\pgfmathparse
					{
						ifthenelse(#1 < 10, 0.9, ifthenelse(#1 < 100, 0.6, 0.4))
					}
				\let\hfs\pgfmathresult
				\filldraw (0,\szg/2) circle (\szg/2+0.28ex);
				\node[white] at (0,\szg/2) {\makebox[0.35em][c]{\scalebox{\hfs}[1]{{\textbf{#1}}}}};
			}
	}
\robustify{\quan}
\robustify{\hquan}
\robustify{\fquan}
\robustify{\hfquan}

% contents
\setcounter{secnumdepth}{3}
\RequirePackage[explicit,indentafter,pagestyles]{titlesec}

\newcounter{countchapters}

\newif\ifmulticolsused
\pretocmd{\multicols}{\global\multicolsusedtrue}{}{}
\apptocmd{\endmulticols}{\global\multicolsusedfalse}{}{}

\titleformat{\chapter}[display]
	{	\bfseries \StandardArial \Huge \filleft }
	{ \CTEXthechapter }
	{ 0.2 em }
	{ \titlerule[2 pt] \centering \vspace{0.4 em} #1 }
	[
		\ifnum\value{chapter} > 0
			\addtocontents{toc}
				{
					\protect \begin{multicols}{2}
					\protect \multicolsusedtrue
				}
		\fi
		\stepcounter{countchapters}
	]

	% For title{contents} page 目录排放设定
\titleformat{name=\chapter,numberless}
	{	\Huge }
	{}
	{	0 em }
	{
		\begin{tikzpicture}[remember picture, overlay]
			\draw[line width = 1.2 pt]([xshift = -2 cm,yshift = -3 cm]current page.north east)
			--++ (-5 cm, 0 cm);
			\node at([shift= {(-4.5 cm, -2.5 cm)}]current page.north east){#1};
			\node at([shift= {(-4.5 cm, -3.5 cm)}]current page.north east){Contents};
		\end{tikzpicture}
	}
	[]

\titlespacing*{\chapter}{0 em}{0 em}{1 em}

\pretocmd{\chapter}
	{
		\addtocontents{toc}
			{
				\protect \ifmulticolsused
				\protect \end{multicols}
				\protect \fi
			}
	}{}{}

\AtEndDocument
	{
		\addtocontents{toc}
			{
				\protect \ifmulticolsused
				\protect \end{multicols}
				\protect \fi
			}
	}

\titleformat{\section}
	{	\bf \Large \centering	}
	{	\faBed ~ \thesection	}
	{1 em}
	{ #1 }
	[]

	% TODO:  <29-04-22, Amos-CXW-Fiona> %
%\titleformat{\subsection}


\definecolor{yingluo}{RGB}{212,172,191} % subsubsection + pink!70
\definecolor{chenjiuhong}{RGB}{167,121,121} % Theorems
\definecolor{fengwuhui}{RGB}{220,207,203} % Theorems back !30
\definecolor{kongguyoulan}{RGB}{215,157,164} % header!55 footer!20
\definecolor{jiaotangcheng}{RGB}{188,149,117} % learningkeys!80 learningtargets!80
\definecolor{heikuli}{RGB}{196,122,155} % highlines by tcolorbox on line !10
\definecolor{chahong}{RGB}{208,180,167} % Homework
\definecolor{shanhufen}{RGB}{231,194,216} % analysis

\renewcommand{\thesubsubsection}{题型\arabic{subsubsection}}
\titleformat{\subsubsection}
	{ \bfseries \large }
	{}
	{ 0em }
	{
		\begin{tcolorbox}%
			[
				nobeforeafter,
				width 						= \textwidth - 1 em,
				arc 							= 0 mm,
				left 							= 0.5 mm,
				top 							= 1 mm,
				bottom 						= 1 mm,
				boxrule 					= 0 mm,
				colback 					= yingluo,
				sidebyside,
				sidebyside gap 		= 0.5 mm,
				lefthand ratio 		= 0.2,
				fontupper 				= \color{white},
				enhanced,
					bicolor,
					colbacklower 		= pink!70,
					halign 					= left
			]\thesubsubsection \tcblower #1
		\end{tcolorbox}
	}
	[]

\titlespacing*{\subsubsection}{0 pt}{0 em}{0 em}

% catalog/contents
\setcounter{tocdepth}{3}
\renewcommand{\contentsname}{目 \quad 录}

\RequirePackage[titles]{tocloft}
\renewcommand{\cftdot}{\Large$\cdot$}
\renewcommand{\cftdotsep}{0.9}

\renewcommand{\cftsecpagefont}{\large}
\renewcommand{\cftsecfont}{\large}
\renewcommand{\cftsecindent}{0 em}
\renewcommand{\cftbeforesecskip}{0.3 em}

\renewcommand{\cftsubsecpagefont}{\large}
\renewcommand{\cftsubsecfont}{\large}
\renewcommand{\cftsubsecindent}{2.5 em}
\renewcommand{\cftbeforesubsecskip}{0.3 em}

\renewcommand{\cftsubsubsecfont}{\StandardArial}
\renewcommand{\cftsubsubsecindent}{4.5 em}
\renewcommand{\cftbeforesubsubsecskip}{0.3 em}

% PageStyle for contents
\RequirePackage{titletoc}
\titlecontents{chapter}[1 em]
	{	\large \filcenter }
	{	\bfseries \thecontentslabel	}
	{}
	{}
	[
		{ \titlerule[1 pt] \addvspace{1 em}}
	]

% header footer
\RequirePackage{zhlipsum}
\RequirePackage{calc}

% Logions for  footers
\input{./Logions/logions.tex}
%\newzhlipsum{logion}
%{
%		{what it is1!},
%		{what it is2!},
%		{what it is3!},
%		{what it is13!}
%}

\newpagestyle{math}
	{
		\sethead
		[
			{
				\begin{tikzpicture}[remember picture, overlay]
					\fill[kongguyoulan!55]([yshift = -1 mm]current page header area.south east)
						-- (current page header area.north east)
						--++ (-6 cm, 0)
						-- ([xshift = -7 cm, yshift = -1 mm]current page header area.south east)
						-- cycle;
					\draw[kongguyoulan!55,line width = 1 pt]([yshift = -1 mm]current page header area.south east)
						--([yshift = -1 mm]current page header area.south west);
				\end{tikzpicture}
				\thepage
			}
			][][\color{white}\ifthechapter{\CTEXthechapter\quad\chaptertitle}{\chaptertitle}]
		{
			\begin{tikzpicture}
				[remember picture, overlay]
					\fill[kongguyoulan!55]([yshift = -1 mm]current page header area.south west)
						-- (current page header area.north west)
						--++ (6 cm, 0)
						-- ([xshift = 7 cm, yshift = -1 mm]current page header area.south west)
						-- cycle;
					\draw[kongguyoulan!55,line width = 1 pt]([yshift = -1 mm]current page header area.south west)
						--([yshift = -1 mm]current page header area.south east);
						\end{tikzpicture}
						\color{white}\ifthesection
								{\thesection \quad \sectiontitle}
								{
									\ifthechapter
										{\sectiontitle}
								  	{\chaptertitle}
								}
					}{}{\thepage}

	\setfoot
		[
			笔记重排~\rule[-0.4 mm]{0.2 em}{1 em}~设计 By 芳舒晴
			\ifthechapter
				{
					{
						\begin{tikzpicture}[remember picture, overlay]
						\fill[kongguyoulan!20]
							([yshift = -1.5 cm]current page footer area.south west)
							rectangle (current page footer area.north east);
						\node
							[
								anchor 	= west,
								font 		= \StandardArial
							]	at ([yshift = -2 em ]current page footer area.west)
										{
											\parbox{\textwidth - 5 mm}
												{
													\CTEXindent	\zhlipsum[\thepage][name=logion]
												}
										};
						\end{tikzpicture}
					}
				}
				{}
		][][]
		{
					\begin{tikzpicture}[remember picture, overlay]
						\fill[kongguyoulan!20]
							([yshift = -1.5 cm]current page footer area.south west)
							rectangle (current page footer area.north east);
						\node [ anchor = west,	font = \StandardArial ]
							at ([yshift = -2 em ]current page footer area.west)
							{
								\parbox{\textwidth - 5 mm}
									{
										\CTEXindent \zhlipsum[\thepage][name=logion]
									}
							};
						\end{tikzpicture}
		}{}{}
	}

\pagestyle{math}
\assignpagestyle{\chapter}{empty}


% Column shape specialized training
\newcommand{\specialtraining}[1]
	{
		\begin{center}
			\begin{tikzpicture}
				\node
					[
						cloud callout,
						cloud puffs 		= 15,
						aspect 					= 4.5,
						cloud puff arc 	= 120,
						draw,
						text 						= black,
						font 						= {\bfseries \Large},
						shading 				= ball,
						ball color 			= gray!20
					]at (0,0){#1};
			\end{tikzpicture}
		\end{center}
	}

% list environments
\RequirePackage{ enumitem }
\setenumerate
	{
		itemsep 	= 0 pt,
		partopsep = 0 pt,
		parsep 		= \parskip,
		topsep 		= 0 pt
	}
\setenumerate[2]
	{
		align 			=left,
		label 			= ({\makebox[0.8 em]{\arabic*}}),
		labelwidth 	= 1.7 em,
		labelsep 		= 0 em,
		leftmargin 	= 1.7 em
	}
\setdescription
	{
		itemsep 	= 0 pt,
		partopsep = 0 pt,
		parsep 		= \parskip,
		topsep 		= 0 pt
	}


% Title Box real-width for needing
\RequirePackage{ varwidth }

% Learnning Objectives Box
\newtcolorbox{LearnningObjectivesBox}[1][]
	{
		nobeforeafter,
		valign = center,
		width 				= 0.499 \textwidth,
		bottom 				= 0 mm,
		colback 			= white,
		colframe 			= jiaotangcheng!70,
		sharp corners = east,
		arc is angular,
		arc 					= 2 mm,
		leftrule 			= 0 mm,
		enhanced,
			attach boxed title to top center =
				{
					xshift  = 0.29 cm,
					yshift* = 1 mm - \tcboxedtitleheight
				},
			varwidth boxed title* = -3 cm,
			boxed title style =
				{
					frame code =
						{
							\path[fill=magenta!70!yellow] % title back
								([yshift = -1 mm, xshift = -1 mm]frame.north west)
								arc[start angle = 0, end angle = 180, radius = 1 mm]
								([yshift = -1 mm, xshift = 1 mm]frame.north east)
								arc[start angle = 180, end angle = 0, radius = 1 mm];
							\path[fill = jiaotangcheng!80]  % title front
								([xshift = -2 mm]frame.north west)
								-- ([xshift = 2 mm]frame.north east)[rounded corners = 1 mm]
								-- ([xshift = 1 mm, yshift = -1 mm]frame.north east)
								-- (frame.south east)
								-- (frame.south west)
								-- ([xshift = -1 mm, yshift = -1 mm]frame.north west)[sharp corners]
								-- cycle;
						},
					interior engine = empty,
				},
			fonttitle = \zihao{4}\bfseries,
			title 		= {学习目标},
			height 		= #1 cm
	}

% LearnningObjectives particularize
\newenvironment{learningtargets}
	{
		\begin{enumerate}
			[
				label 			= \arabic*.,
				align 			= left,
				labelindent = 0 em,
				labelwidth  = 1 em,
				labelsep  	= 0 em,
				leftmargin 	= 1 em
			]\StandardArial
	}
	{
		\end{enumerate}
	}

% Key and Difficulty Box
\newtcolorbox{KeyandDifficultyBox}[1][]
	{
		left skip 			= -1 mm,
		nobeforeafter,
		valign 					= center,
		width 				= 0.499 \textwidth,
		bottom 				= 0 mm,
		colback 			= white,
		colframe 			= jiaotangcheng!70,
		sharp corners = west,
		arc is angular,
		arc 					= 2 mm,
		rightrule 		= 0 mm,
		enhanced,
			attach boxed title to top center =
				{
					xshift  = 0.29cm,
					yshift* = 1 mm - \tcboxedtitleheight
				},
			varwidth boxed title* = -3 cm,
			boxed title style =
				{
					frame code =
						{
							\path[fill=magenta!70!yellow] % title back
								([yshift = -1 mm, xshift = -1 mm]frame.north west)
								arc[start angle = 0, end angle = 180, radius = 1 mm]
								([yshift = -1 mm, xshift = 1 mm]frame.north east)
								arc[start angle = 180, end angle = 0, radius = 1 mm];
							\path[fill = jiaotangcheng!80]
								([xshift = -2 mm]frame.north west)
								-- ([xshift = 2 mm]frame.north east)[rounded corners = 1 mm]
								-- ([xshift = 1 mm, yshift = -1 mm]frame.north east)
								-- (frame.south east)
								-- (frame.south west)
								-- ([xshift = -1 mm, yshift = -1 mm]frame.north west)[sharp corners]
								-- cycle;
						},
					interior engine = empty,
				},
			fonttitle = \zihao{4}\bfseries,
			title 		= {重点难点},
			height 		= #1 cm
	}

% KeyandDifficulties particularize
\newenvironment{learningkeys}
	{
		\begin{description}
			[
				align 			= left,
				labelindent = 0 em,
				labelwidth  = 3 em,
				labelsep  	= 0 em,
				leftmargin 	= 1 em,
				font 				= {\bfseries }
			]\StandardArial
	}
	{
		\end{description}
	}

% derivative
\RequirePackage{ bbding }
\newcounter{ derivatives }
\newenvironment{DerivativeExamples}
	{
		\hspace*{-2.5 em}
		\HandPencilLeft \quad \fbox{ \bfseries \thesubsubsection 对接练习 }
		\begin{enumerate}%
			[
				labelindent 	= 0 mm,
				align 				= left,
				labelwidth 		= 1 em,
				labelsep 			= 0 em,
				leftmargin 		= 1 em,
				label 				= {\bfseries \arabic*.}
			]
	}
	{
		\end{enumerate}
	}

% thrm
\newcounter{thrmcounters}[section]
\newtcolorbox{Theorems}
	{
		breakable,
		parbox 				= false,
		left 					= 0 pt,
		top 					= 5 mm,
		right  				= 0 mm,
		bottom 				= 0 mm,
		boxrule 			= 0.5 mm,
		title 				= {\refstepcounter{thrmcounters}定理 \thesection.\thethrmcounters $\blacktriangleright$ },
		%title 				= {\refstepcounter{thrmcounters} 定理 \thethrmcounters $\blacktriangleright$ },
		coltitle      = white,   % title colors
		fonttitle     = {\bfseries \large},
		colframe 			= chenjiuhong,   % rule colors
		colback 			= fengwuhui!30,
		fontupper 		= \indent \StandardArial,
		arc 					= 0 mm,
		enhanced,
			attach boxed title to top left =
				{
					xshift 			= 3 mm,
					yshift 			= -\tcboxedtitleheight/2,
				},
			boxed title style =
				{
					sharp corners = uphill,
					colback 		 	= chenjiuhong, % titlebox colors
					arc 				  = 1 mm,
				}
	}

% generalize
\newtcolorbox{MethodGeneralize}
	{
		breakable,
		parbox 				= false,
		boxrule 			= 0.5 mm,
		title 				= {\bf 方法归纳},
		coltitle      = white,
		left 					= 0 pt,
		top 					= 2 mm,
		bottom 				= 0 mm,
		colframe 			= black,
		colback 			= gray!10,
		colbacktitle  = gray,
		fontupper 		= \indent \StandardArial,
		arc is angular,
		arc 					= 1 mm,
		enhanced,
			attach boxed title to top center =
				{
					yshift 			= -0.25 mm - \tcboxedtitleheight/2,
					yshifttext 	= 2 mm - \tcboxedtitleheight/2
				},
			boxed title style =
				{
					boxrule = 0.5 mm,
					frame code =
						{
							\path[fill=black]
								([xshift = -4 mm]frame.west)
								-- (frame.north west)
								-- (frame.north east)
								-- ([xshift=4mm]frame.east)
								-- (frame.south east)
								-- (frame.south west)
								-- cycle;
						},
					interior code =
						{
							\path[tcb fill interior]
								([xshift = -2 mm]interior.west)
								-- (interior.north west)
								-- (interior.north east)
								-- ([xshift=2mm]interior.east)
								-- (interior.south east)
								-- (interior.south west)
								-- cycle;
						}
				}
	}

\newtcolorbox{Homework}
	{
		breakable,
		parbox 				= false,
		before upper  = \indent,
		boxrule 			= 0 mm,
		title 				= {\bfseries \Large 练习题},
		coltitle      = white,
		left 					= 1 mm,
		right 				= 1 mm,
		bottom 				= 0 mm,
		colback 			= white,
		arc 					= 0 mm,
		enhanced,
			attach boxed title to top left =
				{
					yshift 			= -0.25 mm - \tcboxedtitleheight/2,
					yshifttext 	= 1 mm - \tcboxedtitleheight/2
				},
			boxed title style =
				{
					boxrule 	= 0 mm,
					arc 			= 0 mm,
					top 			= 0 mm,
					bottom 		= 0 mm,
					colback 	= chahong,
					colframe 	= chahong,
					frame code =
						{
							\fill[chahong!20]
								([xshift = 4.5 cm]frame.north west)
								--++ (2.5 cm, 0)
								--++ (0.5 cm, -1 em)
								--++ (-0.5 cm, -1 em)
								--++ (-2.5 cm, 0)
								-- cycle;
							\fill[chahong!50]
								([xshift = 3 cm]frame.north west)
								--++ (2.5 cm, 0)
								--++ (0.5 cm, -1 em)
								--++ (-0.5 cm, -1 em)
								--++ (-2.5 cm, 0)
								-- cycle;
							\fill[chahong!70]
								([xshift = 1.5 cm]frame.north west)
								--++ (2.5 cm, 0)
								--++ (0.5 cm, -1 em)
								--++ (-0.5 cm, -1 em)
								--++ (-2.5 cm, 0)
								-- cycle;
							\fill[chahong]
								(frame.north west)
								--++ (2.5 cm, 0)
								--++ (0.5 cm, -1 em)
								--++ (-0.5 cm, -1 em)
								--++ (-2.5 cm, 0)
								-- cycle;
						},
				},
				borderline north = {1.5 pt}{0 pt}{chahong, dash pattern = on 8 pt off 4 pt},
				borderline south = {1.5 pt}{0 pt}{chahong, dash pattern = on 8 pt off 4 pt},
	}

% Homework
\newenvironment{homeworks}
	{
		\begin{enumerate}%
			[
				labelindent 	= 0 pt,
				align 				= left,
				labelwidth 		= 1.5 em,
				labelsep 			= 0 em,
				leftmargin 	 	= 1.5 em,
				label 				= {\bf \arabic*.},
				series 				= homeworks,
				resume 				= homeworks
			]
	}
	{
		\end{enumerate}
	}

\RequirePackage{ float }

% Pictures
\RequirePackage{ graphicx }

% caption Table
\RequirePackage{ caption }
	\captionsetup
		{
			labelsep 	= quad,
			font 		 	= rm,
			font 			= small,
			aboveskip = 6 pt
		}
	\renewcommand{\thefigure}{\thechapter{}-\arabic{figure}}
	\renewcommand{\thetable}{\thechapter{}-\arabic{table}}
%	\captionsetup[table]{position = above}

% Examples environment
\RequirePackage{fontawesome5}
\newcounter{examplescounter}[section]
\newenvironment{examples}
	{
		\refstepcounter{examplescounter}
		\begin{enumerate}%
		[
			align 			= left,
			labelindent = 0 em,
			label 			=	{	\bfseries \faCogs 例\theexamplescounter },
			labelwidth 	= 3.8 em,
			labelsep  	= 0 mm,
			leftmargin 	= 3.8 em
		]\item
	}
	{\end{enumerate}}

% contraposition
\RequirePackage{hlist}

\RequirePackage{ifthen}

\newif\ifanswer
\newcommand{\answer}[1]
	{
		\ifthenelse{\isodd{#1}}
		{\answertrue}
		{}
	}

\newlength{\lengthA}
\newlength{\lengthB}
\newlength{\lengthC}
\newlength{\lengthD}
\newlength{\lengthE}
%\newlength{\lengthF}
%\newlength{\lengthG}
%\newlength{\lengthH}

\newlength{\lengthHalf}
\newlength{\lengthQuater}
\newlength{\lengthMax}

% chioce
\newcommand{\choiceitem}[6][4]
	{
		\settowidth{\lengthA}{A.~#1~~~}
		\settowidth{\lengthB}{B.~#2~~~}
		\settowidth{\lengthC}{C.~#3~~~}
		\settowidth{\lengthD}{D.~#4~~~}
		\settowidth{\lengthE}{E.~#5~~~}
		\ifthenelse{ \lengthtest{\lengthA > \lengthB} }
			{	\setlength{\lengthMax}{\lengthA} }
			{	\setlength{\lengthMax}{\lengthB} }
		\ifthenelse{ \lengthtest{\lengthMax < \lengthC} }
			{	\setlength{\lengthMax}{\lengthC} }
			{}
		\ifthenelse{ \lengthtest{\lengthMax < \lengthD} }
			{	\setlength{\lengthMax}{\lengthD} }
			{}
		\ifthenelse{ \lengthtest{\lengthMax < \lengthE} }
			{	\setlength{\lengthMax}{\lengthE} }
			{}
		\setlength{\lengthHalf}{0.5\linewidth}
		\setlength{\lengthQuater}{0.25\linewidth}
		\ifthenelse{ \lengthtest{\lengthMax > \lengthHalf} }
			{
				\begin{hlist}%
					[
						pre skip 		= 0 pt,
						post skip 	= 0 pt,
						label 			= \Alph{hlisti}.,
						pre label 	= {},
						item offset = 1.2 em,
						col sep 		= 0.5 em
					]1
					\hitem #2
					\hitem #3
					\hitem #4
					\hitem #5
					\ifnum #1>4
						\hitem #6
					\fi
				\end{hlist}
			}
			{
				\ifthenelse{\lengthMax > \lengthQuater}
					{
						\begin{hlist}%
							[
								pre skip 		= 0 pt,
								post skip 	= 0 pt,
								label 			= \Alph{hlisti}.,
								pre label 	= {},
								item offset = 1.2 em,
								col sep 		= 0.5 em
							]2
							\hitem #2
							\hitem #3
							\hitem #4
							\hitem #5
							\ifnum #1>4
							\hitem #6
							\fi
						\end{hlist}
					}
					{
						\begin{hlist}%
							[
								pre skip 		= 0 pt,
								post skip 	= 0 pt,
								label 			= \Alph{hlisti}.,
								pre label 	= {},
								item offset = 1.2 em,
								col sep 		= 0.5 em
							]4
							\hitem #2
							\hitem #3
							\hitem #4
							\hitem #5
							\ifnum #1>4
							\hitem #6
							\fi
						\end{hlist}
					}
			}
	}
\newcommand{\choicebrackets}[1]
{
	\hfill( \  {
		{
			\ifanswer
				{\makebox[0.4 cm][c]{\textcolor{red}{#1}}}
			\else
				\phantom{\makebox[0.4 cm][c]{#1}}
			\fi
		}\ } )
}

% fillblank
\RequirePackage{xeCJKfntef}
\newcommand{\fillblank}[2][2]
	{
		\CJKunderline{\makebox[1 cm][c]
											{
												\ifanswer
													\textcolor{red}{ #2 }
												\else
													\phantom{ #2 }
												\fi
											}
									}
	}

% src
\newcommand{\refquestionsource}[2]
	{
		\textcolor{blue}{
												\ifanswer
												{(#1年#2)\hspace*{-1 em}}
												\else
													\hspace*{ -1 em }
												\fi
										}
	}

% analysisLines environment
\newtcolorbox{answerlines}[1][]
		{
			invisible,
			breakable,
			colback = white,
			colframe = white,
			height = 1.7cm,
			enhanced,
				overlay =
					{
						\foreach \a in {-1.2, -2.8, -4.4}
						\draw[dashed]([shift={(3.2 em, \a em)}]frame.north west)
							-- ([shift={(0, \a em)}]frame.north east);
						\node(title) at ([shift={(3.8 em, -0.7 em)}]frame.north west){\bfseries #1: };
					}
		}

\newtcolorbox{answerbox}[1][]
						{
							breakable,
							arc 			= 0 mm,
							colback 	= shanhufen!20!white,
							boxrule 	= 0 pt,
							top 			= 6 mm,
							fontupper = \normalsize,
							enhanced,
								overlay unbroken =
									{
										\draw[color = shanhufen, line width = 2 pt]
											([xshift = 2 pt]frame.north west)	-- ([xshift = 2 pt]frame.south west);
										\node(title) at ([xshift = 2 em, yshift = -1 em]frame.north west)
											{ \bfseries {\color{shanhufen} #1} };
									},
								overlay first =
									{
										\draw[color = shanhufen, line width = 2 pt]
											([xshift = 2 pt]frame.north west) -- ([xshift = 2 pt]frame.south west);
										\node(title) at ([xshift = 4.5 pt, yshift = -2 em]frame.north west)
											{ \bfseries {\color{shanhufen} #1} };
									},
								overlay last =
									{
										\draw[color = shanhufen, line width = 2 pt]
											([xshift = 2 pt]frame.north west) -- ([xshift = 2 pt]frame.south west);
									}
						}

% Onekey for analysis, assess and proof
\newenvironment{PROBLEMANSWERS}
	{
		\ifanswer
			\newenvironment{Analysis}
				{ \begin{answerbox}[解析] }
				{ \end{answerbox} }

			\newenvironment{Proof}
				{ \begin{answerbox}[证明] }
				{ \end{answerbox} }

			\newenvironment{Assess}
				{ \begin{answerbox}[评注] }
				{ \end{answerbox} }
		\else
			\newenvironment{Analysis}
				{ \begin{answerlines}[解] }
				{	\end{answerlines} }

			\newenvironment{Proof}
				{ \begin{answerlines}[证] }
				{	\end{answerlines} }

			\newenvironment{Assess}
				{ \begin{answerlines}[注] }
				{	\end{answerlines} }
		\fi
	}
	{}

\newtcbox{\hl}[1][heikuli]
	{
		on line,
		arc 				= 0 pt,
		outer arc 	= 0 pt,
		colback 		= #1!30!white,
		colframe 		= #1!90!black,
		boxsep 			= 0 pt,
		left 				= 1 pt,
		right 			= 1 pt,
		top 				= 1.5 pt,
		bottom 			= 1.5 pt,
		boxrule 		= 0 pt,
		bottomrule 	= 1 pt,
		toprule 		= 1 pt
	}

\AtBeginDocument
	{
		\begingroup
			\catcode `\:=\active
			\scantokens{ \gdef:{ \mathpunct{\mbox{: \hspace{-0.18em}}}} }
		\endgroup
		\mathcode `\:="8000
	}


\makeatletter
	\begingroup
		\catcode `\,=\active
		\def\@x@{\def,{\mathpunct{\mbox{, \hspace{-0.18em}}}}}
		\expandafter
	\endgroup
	\@x@\mathcode`\,="8000
\makeatother


\AtBeginDocument
	{
		\begingroup
			\catcode `\;=\active
			\scantokens
				{
					\gdef;
					{
						\mathpunct
							{
								\mbox{; \hspace{-0.18em}}
							}
					}
				}
		\endgroup
		\mathcode`\;="8000
	}

\endinput
