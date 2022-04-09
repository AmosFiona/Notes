\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{examinations}
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
		paperheight = 26 cm,
		paperwidth 	= 18.4 cm,
		left 				= 2 cm,
		right 			= 2 cm,
		top 				= 1.5 cm,
		bottom 			= 2 cm,
		headsep 		= 10 pt,
	}

% display pagenumber
\RequirePackage{ lastpage }

% draw Pictures
\RequirePackage{ tikz }
\RequirePackage{ tikzpagenodes }
	\usetikzlibrary{ shapes.callouts }
	\usetikzlibrary{ shapes.geometric }
	\usetikzlibrary{ positioning }

% Footer
\RequirePackage[pagestyles]{titlesec}

\newpagestyle{examination}
	{
		\setfoot
			{}
			{\bfseries 数学试题 第 {\thepage} 页 (共~{\pageref{LastPage}}~页) }
			{}
	}
\pagestyle{examination}

% list environments
\RequirePackage{ enumitem }
\setenumerate
	{
		itemsep 	= 0 pt,
		partopsep = 0 pt,
		parsep 		= \parskip,
		topsep 		= 0 pt
	}
\setenumerate[1]
	{
		align 			= left,
		label 			= {\bfseries \arabic*}.,
		labelwidth 	= 1.5 em,
		labelsep 		= 0.1 em,
		leftmargin 	= 1.6 em,
		resume
	}
\setenumerate[2]
	{
		align 			= left,
		label				= {\arabic*}.,
		labelwidth 	= 2.2 em,
		labelsep 		= 0.2 em,
		leftmargin 	= 2.4 em
	}
\setenumerate[3]
	{
		align 			= left,
		label				= {\arabic*}.,
		labelwidth 	= 2.2 em,
		labelsep 		= 0.1 em,
		leftmargin 	= 2.4 em
	}
%\setdescription
%	{
%		itemsep 	= 0 pt,
%		partopsep = 0 pt,
%		parsep 		= \parskip,
%		topsep 		= 0 pt
%	}
\setdescription[1]
	{
		itemsep 		= 0 pt,
		partopsep 	= 0 pt,
		parsep 			= \parskip,
		topsep 			= 0 pt,
		align 			= left,
		labelindent	= 0 em,
		labelwidth 	= 2 em,
		labelsep 		= 0 em,
		leftmargin 	= 2 em
	}

% conraposition
\RequirePackage{hlist}

% for choice-questions
\newenvironment{options}[5][4]
	{
		\begin{hlist}%
			[
				pre skip 		= 0 pt,
				post skip 	= 0 pt,
				label 			= \Alpha {hlisti}.,
				pre label 	=,
				item offset = 1.2 em,
				col sep 		= 0.5 em
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
\newenvironment{optionstag}[5][4]
	{
		\begin{hlist}%
			[
				pre skip 		= 0 pt,
				post skip 	= 0 pt,
				show label 	= false,
				pre label 	=,
				item offset = 1.2 em,
				col sep 		= 0.5 em
			]#1
			\hitem #2
			\hitem #3
			\hitem #4
			\hitem #5
	}
	{
		\end{hlist}
	}

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


\RequirePackage{ wrapfig }

\newcommand{\fillbankexercise}{\CJKunderline{\hspace*{3.5em}}}
\newcommand{\choiceexercise}{\hfill(\qquad)}

% tabular enviroment
\RequirePackage{ array }
	\newcolumntype{P}[1]{>{\centering\arraybackslash}p{#1}}

\RequirePackage{ makecell }
\RequirePackage{ multirow }

\RequirePackage{ booktabs }
	\setlength{\abovetopsep}{0ex}
	\setlength{\belowrulesep}{0ex}
	\setlength{\aboverulesep}{0ex}
	\setlength{\belowbottomsep}{0ex}
	\newcolumntype{Y}{!{\vrule width 0.08em}}

\RequirePackage{ hhline }
\RequirePackage{ colortbl }

\newenvironment{volumeheaders}
	{
		{\bfseries 绝密 $\bigstar$ 启用前}
		\begin{center}
			\zihao{3}
	}
	{
			\\
			\zihao{-2} {\bfseries 数 \quad 学 }%
		\end{center}
	}

\newcommand{\examattention}[1]
	{
		\bfseries 注意事项:
		\par
		1. 答卷前，考生务必将自己的姓名、准考证号等填写在答题卡和试卷指定的位置上.\par
		2. 回答选择题时，选出每个小题答案后，用铅笔把答题卡上对应题目的答案标号涂黑，如需改动，用橡皮擦干净后，再选涂其他答案标号，回答非选择题时，讲答案写在答题卡上，写在本试卷上无效.\par
		3. 考试结束后，将本试卷和答题卡一并交回.\par
		\vspace{#1}
	}

% Singlechoice
\newcommand{\singlechoice}
	{
		\begin{description}
			\item[一、] {\bfseries 选择题：本题共8小题，每小题5分，共40分.在每小题给出的四个选项中，只有一项时符合题目要求的.}
		\end{description}
	}

% Multiplechoice
\newcommand{\multiplechoice}
	{
		\begin{description}
			\item[二、] {\bfseries 多项选择题：本题共4小题，每小题5分，共20分.在每小题给出的四个选项中，有多项时符合题目要求.全部选对的得5分，部分选对的得3分，有选错的得0分.}
		\end{description}
	}

% Fill blank
\newcommand{\fillblank}
	{
		\begin{description}
			\item[三、] {\bfseries 填空题：本题共4小题，每小题5分，共20分.}
		\end{description}
	}

% Explanation
\newcommand{\explanation}
	{
		\begin{description}
			\item[四、] {\bfseries 解答题：本题共6小题，共70分.解答应写出文字说明、证明过程或演算步骤.}
		\end{description}
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
	\@x@ \mathcode`\,="8000
\makeatother


\AtBeginDocument
	{
		\begingroup
			\catcode `\;=\active
			\scantokens{\gdef;{\mathpunct{\mbox{;\hspace{-0.18em}}}}}
		\endgroup
		\mathcode`\;="8000
	}

\endinput
