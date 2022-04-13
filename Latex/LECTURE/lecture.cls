\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{course}
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

\DeclareMathSizes{10.5bp}{10.5bp}{6.8pt}{6pt}

% line gap
\RequirePackage[bodytextleadingratio=1.5,restoremathleading=true]{zhlineskip}
\SetMathEnvironmentSinglespace{1.1}

% Page
\RequirePackage{ geometry }
\geometry
	{
		paperheight=29.7cm,
		paperwidth=21cm,
		width=17cm,
		height=25.7cm,
		left=1.8cm,
		right=1.6cm,
		top=1.5cm,
		bottom=2.5cm,
		headsep=3.2em,
	}

% draw Pictures
\RequirePackage{tikz}
\RequirePackage{tikzpagenodes}
	\usetikzlibrary{shapes.callouts}
	\usetikzlibrary{shapes.geometric}
	\usetikzlibrary{positioning}

% Column shape
\newcommand{\columnshapes}[1]
	{%
		\begin{center}
			\begin{tikzpicture}
				\node
					[
						cloud callout,
						cloud puffs 		= 15,
						aspect 					= 4.5,
						cloud puff arc = 120,
						draw,
						text 						= black,
						font 						= \bs \Large,
						shading 				= ball,
						ball color 			= gray!20
					]at (0,0){#1};
			\end{tikzpicture}
		\end{center}%
	}%

% list environments
\RequirePackage{ enumitem }
\setenumerate
	{
		itemsep =0 pt,
		partopsep = 0 pt,
		parsep 	= \parskip,
		topsep = 0 pt
	}
\setenumerate[2]
	{
		align =left,
		label = ({\makebox[0.8 em]{\arrabic*}}),
		labelwidth = 1.7 em,
		labelsep = 0 em,
		leftmargin = 1.7 em
	}

% colors boxder macro
\RequirePackage[most]{tcolorbox}

% Box real-width for needing
\RequirePackage{ varwidth }

% Learnning Objectives Box
\newtcolorbox{LearnningObjectivesBox}
	[1][]
	{
		nobeforeafter,
		valign = center,
		enhanced,
			width 				= 0.495 \textwidth,
			bottom 				= 0 mm,
			colback 			= white,
			colframe 			= gray!70!black,
			sharp corners = east,
			arc is angular,
			arc 					= 2 mm,
			leftrule 			= 0 mm,
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
							\path[fill=gray!70!black]
								([yshift = -1mm, xshift = -1 mm]frame.north west)
								arc[start angle = 0, end angle = 180, radius = 1 mm]
								([yshift = -1mm, xshift = 1 mm]frame.north east)
								arc[start angle = 180, end angle = 0, radius = 1 mm];
							\path[fill = gray!70!black]
								([xshift = -2 mm]frame.north west)
								-- ([xshift = 2 mm]frame.north east)[rounded corners = 1 mm]
								-- ([xshift = 1 mm, yshift = -1 mm]frame.north east)
								-- (frame.south east)
								-- (frame.south west)
								-- ([xshift = -1 mm, yshift = -1 mm]frame.north west)[sharp coners]
								-- cycle;
						},
					interior engine = empty,
				},
			fonttitle = \zihao{4}\bfseries,
			title 		= {学习目标}
			height 		= #1 cm
	}

% LearnningObjectives particularize
\newenvironment{learningtargets}
	{
		\begin{enumerate}
			[
				label = \arabic*.,
				align = left,
				labelindent = 0 em,
				labelwidth  = 1 em,
				labelsep  	= 0 em,
				leftmargin = 1 em
			]\StandardArial
	}
	{
		\end{enumerate}
	}
\setdescription
	{
		itemsep = 0 pt,
		partopsep = 0 pt,
		parsep = \parskip,
		topsep = 0 pt
	}

% Key and Difficulty Box
\newtcolorbox{KeyandDifficultyBox}
	[1][]
	{
		left skip = -1 mm,
		nobeforeafter,
		valign = center,
		enhanced,
			width 				= 0.495 \textwidth,
			bottom 				= 0 mm,
			colback 			= white,
			colframe 			= gray!70!black,
			sharp corners = west,
			arc is angular,
			arc 					= 2 mm,
			rightrule 			= 0 mm,
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
							\path[fill=gray!70!black]
								([yshift = -1mm, xshift = -1 mm]frame.north west)
								arc[start angle = 0, end angle = 180, radius = 1 mm]
								([yshift = -1mm, xshift = 1 mm]frame.north east)
								arc[start angle = 180, end angle = 0, radius = 1 mm];
							\path[fill = gray!70!black]
								([xshift = -2 mm]frame.north west)
								-- ([xshift = 2 mm]frame.north east)[rounded corners = 1 mm]
								-- ([xshift = 1 mm, yshift = -1 mm]frame.north east)
								-- (frame.south east)
								-- (frame.south west)
								-- ([xshift = -1 mm, yshift = -1 mm]frame.north west)[sharp coners]
								-- cycle;
						},
					interior engine = empty,
				},
			fonttitle = \zihao{4}\bfseries,
			title 		= {重点难点}
			height 		= #1 cm
	}

% KeyandDifficulties particularize
\newenvironment{learningkeys}
	{
		\begin{description}
			[
				align = left,
				labelindent = 0 em,
				labelwidth  = 3 em,
				labelsep  	= 0 em,
				leftmargin = 1 em,
				font 				= \bf
			]\StandardArial
	}
	{
		\end{description}
	}

% conraposition
\RequirePackage{hlist}

% for choice-questions
\newenvironment{options}[5][4]
	{
		\begin{hlist}
			[
				pre skip=0pt,
				post skip=0pt,
				label=\Alpha{hlist}.,
				pre label=,
				item offset=1.2em,
				col sep=0.5em
			]#1
			\hitem #2
			\hitem #3
			\hitem #4
			\hitem #5
	}
	{
		\end{hlist}
	}

% for choice-questions which has numbers
\newenvironment{options_tag}[5][4]
	{
		\begin{hlist}
			[
				pre skip=0pt,
				post skip=0pt,
				show label=false,
				pre label=,
				item offset=1.2em,
				col sep=0.5em
			]#1
			\hitem #2
			\hitem #3
			\hitem #4
			\hitem #5
	}
	{
		\end{hlist}
	}

% derivative
\RequirePackage{bbding}
\newcounter{derivatives}
\newenvironment{DerivativeExamples}
	{
		\HandPencilLeft \fbox{ \bf\thesubsubsection 对接练习 }
		\begin{enumerate}
			[
				labelindent 	= 0 pt,
				align 				= left,
				labelwidth 		= 1 em,
				labelsep 			= 0 em,
				leftmargin 	= 1 em,
				label = {\bf \arabic*.}
			]
	}
	{
		\end{enumerate}
	}

% generalize
\newtcolorbox{MethodGeneralize}
	{
		enhanced,
			breakable,
			boxrule 			= 0.5 mm,
			title 				= {\bf 方法归纳},
			left 					= 0 pt,
			top 					= 2 mm,
			bottom 				= 0 mm,
			colframe 			= black,
			parbox 				= false,
			fontupper 		= \indent \StandardArial,
			arc is angular,
			arc 					= 1 mm,
			colback 			= gray!10,
			colbacktitle  = gray,
			coltitle      = white,
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

% Homework
\newcounter{HomeWorks}
\newenvironment{homeworks}
	{
		\begin{enumerate}
			[
				labelindent 	= 0 pt,
				align 				= left,
				labelwidth 		= 1.5 em,
				labelsep 			= 0 em,
				leftmargin 	= 1.5 em,
				label = {\bf \arabic*.}
				series 				= homeworks,
				resume 				= homeworks
			]
	}
	{
		\end{enumerate}
	}

% multicolumn
\RequirePackage{multicol}

% column lines
\RequirePackage[tikz]{multicolrule}
\usetikzlibrary{calc}
\usetikzlibrary{decorations.pathmorphing}
\setlength{\columnsep}{2em}
\SetMCRule{width = 0.5 pt,
		custom-line =
			{
				\draw
					[
						decorate,
						decoration = {coil, aspect = 0}
					](TOP)--(BOT);
			}
	}

\RequirePackage{float}

% Pictures
\RequirePackage{graphicx}

% caption Table
\RequirePackage{caption}
	\captionsetup
		{
			labelsep = quad,
			font = rm,
			font = small,
			aboveskip = 6 pt
		}
	\renewcommand{\thefigure}{\thechapter{}-\arabic{figure}}
	\renewcommand{\thetable}{\thechapter{}-\arabic{table}}
%	\captionsetup[table]{position = above}

% chapter title
\RequirePackage{fontawesome5}
\RequirePackage{etoolbox}
\setcounter{secnumdepth}{3}

\RequirePackage[explicit,indentafter,pagestyles]{titlesec}

\newcounter{countchapters}

\newif\ifmulticolsused
\pretocmd{\multicols}{\global\multicolsusedtrue}{}{}
\apptocmd{\endmulticols}{\global\multicolsusedfalse}{}{}

\titleformat{\chapter}
	{
		\Huge\bfseries
	}
	{
	}
	{
		0 em
	}
	{
		\begin{tikzpicture}[remember picture, overlay]
			\fill[gray!30]
				(current page.north west)[rounded corners = 3 cm]
				--++ (1 cm,-4 cm)[rounded corners = 0 cm]
				-- ([yshift=-4cm]current page.north east) -- (current page.north east)
				-- cycle;
			\node
				[
					circular sector,
					circular sector angle = 100,
					shape border rotate = 90,
					fill = gray!70,
					right,
					text=white,
					font = \bf\huge,
					inner sep =20 pt
				] at ([shift={(2cm,-2cm)}]current page.west){\CTEXthechapter};
			\node
				[
					font = \bf\huge,
					inner sep =20 pt,
					anchor = west
				]at([shift={(10cm,-2.5cm)}]current page.west){#1};
		\end{tikzpicture}
	}
	[
		\ifnum\value{chapter} > 0
			\addtocontents{toc}
				{
					\protect\begin{multicols}{2}
					\protect\multicolsusedtrue
				}
		\fi
		\stepcounter{countchapters}
	]

\titleformat{name=\chapter,numberless}
	{
		\Huge\bfseries
	}
	{
	}
	{
		0em
	}
	{
		\begin{tikzpicture}[remember picture, overlay]
			\draw[line width = 1.2 pt]
				([yshift=-3cm]current page.north east) --++ (-6cm,0);
			\node at ([shift={(-4.5cm,-2.5cm)}]current page.north east){#1};
			\node at ([shift={(-4.5cm,-3.5cm)}]current page.north east){Contents};
		\end{tikzpicture}
	}
	[]

\titlespacing*{\chapter}{0em}{0em}{1em}
\pretocmd{\chapter}
	{
		\addtocontents{toc}
			{
				\protect\ifmulticolsused
				\protect\end{multicols}
				\protect\fi
			}{}{}
		\AtEndDoucument
			{
				\addtocontents{toc}
					{
						\protect\ifmulticolsused
						\protect\end{multicols}
						\protect\fi
					}
	}

\titleformat{\section}
	{
		\bf\Large\centering
	}
	{
		\faBook~\thesection
	}
	{
		1em
	}
	{
		\begin{tcolorbox}
			[
				nobeforeafter,
				width = 0.5\textwidth - 1em,
				arc=0mm,
				enhanced,
					bicolor,
					lefthand ratio = 0.17,
					sidebyside,
					sidebyside gap = 1 mm
					colback=gray!79!black,
					colbacklower=gray!20,
					left = 0.5mm,
					font upper=\color{white},
					halign=left,
					boxrule=0mm,
					top=1mm,
					bottom=1mm
			]\thesubsubsection \tcblower #1
		\end{tcolorbox}
	}
	[]

\titlespacing*{\subsubsection}{0pt}{0em}{0em}

% catalog/contents
\setcounter{tocdepth}{3}
\renewcommand{\contentsname}{目 \quad 录}

\RequirePackage[titles]{tocloft}
\renewcommand{cftdot}{\Large$\cdot$}
\renewcommand{cftdotsep}{0.9}

\renewcommand{cftsecpagefont}{\large}
\renewcommand{cftsecfont}{\large}
\renewcommand{cftsecindent}{0em}
\renewcommand{cftbeforesecskip}{0.3em}

\renewcommand{cftsubsecpagefont}{\large}
\renewcommand{cftsubsecfont}{\large}
\renewcommand{cftsubsecindent}{2.5em}
\renewcommand{cftbeforesubsecskip}{0.3em}

\renewcommand{cftsubsubsecfont}{\StandardArial}
\renewcommand{cftsubsecindent}{2.3em}
\renewcommand{cftbeforesubsecskip}{3em}

\RequirePackage{titletoc}
\titlecontents{chapter}[1em]
	{
		\large\filcenter
	}
	{
		\bf\thecountentslabel
	}
	{}
	{}
	[
		{\titlerule[1pt]\addvspace{1em}}
	]

% header footer
\RequirePackage{zhlipsum}
\RequirePackage{calc}

\newzhlipsum{logion}
	{
		{},
		{},
	}

\newpagestyle{math}
	{
		\sethead
		[
			\begin{tikzpicture}
				[remember picture, overlay]
				\draw([xshift = 1.5 cm, yshift = 1cm]current page header area.south west)
					-- ([xshfit = 1.5 cm]current page header area.south west)
					--++ (7cm , 0 );
				\node
					[
						anchor =south west,
						rectangle callout,
						callout relative pointer = {(-25:0.5)},
						inner sep = 1 em,
						fill = gray,
						text = white,
						font = \sf\large
						]	at (current page header area.south west){\thepage};
				\node[anchor = west]  at ([xshift = 1.6 cm, yshift = 0.3 cm]current page header area.south west){导学学案}；
			\end{tikzpicture}
		][][]
		{
			\begin{tikzpicture}
				[remember picture, overlay]
				\draw([xshift = 1.5 cm, yshift = 1cm]current page header area.south east)
					-- ([xshfit = -1.5 cm]current page header area.south east)
				--++ (7cm , 0);
				\node
					[
						anchor =south east,
						rectangle callout,
						callout relative pointer = {(-155:0.5)},
						inner sep = 1 em,
						fill = gray,
						text = white,
						font = \sf\large
						]	at (current page header area.south east){\thepage};
						\node[anchor = east]  at ([xshift = -1.6 cm, yshift = 0.3 cm]current page header area.south east)
							{
								\ifthechapter{CTEXthechapter~\thechaptertitle}
								{\chaptertitile}
							}；
						\end{tikzpicture}
					}{}{}

	\setfoot
		[
			\ifthechapter
				{
					\begin{tikzpicture}
						[remember picture, overlay]
						\fill[gray!20]([yshift = -1.5 cm]current page footer area.south west)
							rectangle(current page footer area.north east);
						\node
							[
								anchor = west,
								font = \StandardArial
							]	at ([yshift = -2 em ]current page footer area.west)
										{
											\parbox{\textwidth - 5 mm}
												{\CTEXindent\zhlipsum[\thepage][name=derviates]}
										};
						\end{tikzpicture}
					}{}
		][][]
		{
					\begin{tikzpicture}
						[remember picture, overlay]
						\fill[gray!20]([yshift = -1.5 cm]current page footer area.south west)
							rectangle(current page footer area.north east);
						\node
							[
								anchor = west,
								font = \StandardArial
							]	at ([yshift = -2 em ]current page footer area.west)
										{
											\parbox{\textwidth - 5 mm}
												{\CTEXindent\zhlipsum[\thepage][name=derviates]}
										};
						\end{tikzpicture}
		}{}{}
	}

\pagestyle{math}
\assignpagestyle{\chapter}{empty}


% Examples environment
\RequirePackage{fontawesome5}
\newcounter{examplescounter}[section]
\newenvironment{examples}
	{
		\refstepcounter{examplescounter}
		\begin{enumerate}
		[
			align=left,
			labelindent=0em,
			label =
			{
				\bf\faCogs 例{\theexamplescounter}
			},
			labelwidth=3.8em,
			labelsep=0mm,
			leftmargin=3.8em
		]\item
	}
	{\end{enumerate}}

% Analysis environment
\tcbset
	{
		analysisstyle/.style =
		{
			breakable,
			enhanced,
				colback = white,
				colframe = white,
				height = 1.7cm,
				overlay =
					{
						\foreach \a in {-1.2, -2.8, -4.4}
						\draw[dashed]([shift={(3.2em, \a em)}]frame.north west){\bf 解: };
				}
		}
	}

% prove environment
\tcbset
	{
		provestyle/.style =
		{
			breakable,
			enhanced,
				colback = white,
				colframe = white,
				height = 1.7cm,
				overlay =
					{
						\foreach \a in {-1.2, -2.8, -4.4}
						\draw[dashed]([shift={(3.2em, \a em)}]frame.north west)
							--([shift={(0 , \a em)}]frame.north east);
						\node at ([shift = {(3.8em, -0.7em)}]frame.north west){\bf 证: };
				}
		}
	}

% preview environment fill bank
% TODO:  <10-04-22, Amos-CXW-Fiona> %

% assess environment
\newenvironment{assess}
{
	\begin{tcolorbox}
		[
			parbox = false,
			before upper = \indent,
			fontupper = \StandardArial,
			breakable,
			colback = white,
			colframe = black,
			leftrule = 1.5pt,
			rightrule = 0mm,
			bottomrule = 0mm,
			toprule = 0mm,
			arc = 0mm,
			top = 0mm,
			bottom = 0mm,
			left =0mm,
			right = 0mm
			]{\bf 点评}~
	}
	{\end{enumerate}\par}


\newcommand{\fillbankexercise}{\CJKunderline{\hspace*{3.5em}}}
\newcommand{\choiceexercise}{\hfill(\qquad)}
