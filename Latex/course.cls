\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{course}
%\LoadClass[fontset=none]{ctexbook}
\LoadClass{ctexbook}



% Fonts -CN
%RequirePackage{xeCJK}
\setCJKfamilyfont{fsong}{Source Han Serif CN}
\def\StandardArial{\CJKfamily{fsong}}

	\xeCJKsetup{PunctStyle=kaiming}
	%\xeCJKsetup{PunctFamily=zhsong} % setting by xeCJK
	\xeCJKsetup{CJKmath}
	\xeCJKsetup{CheckSingle}

	%\setCJKmainfont[AutoFakeBold]{WenQuanYi Micro Hei}
%\renewcommand\setCJKmainfont{Source Han Serif CN}

% Auto change the end of lines to dot
\defaultfontfeatures{Mapping=fullwidth-stop}

% Fonts -En
\setmainfont{Source Code Pro}
\setsansfont{Source Code Pro}
\setmonofont{Source Code Pro}
%\setsansfont{B&H LucidaTypewriter:style=Sans}
%\setmonofont{Droid Sans Mono:style=Regular}

% mathmacro
\RequirePackage{ mathtools }
\RequirePackage{ amssymb }
\RequirePackage{ empheq }
\RequirePackage{ esvect }

\DeclareMathSizes{10.5bp}{10.5bp}{6.8pt}{6pt}

% Page
\RequirePackage{geometry}
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
			marginparsep=-13.5em,
			marginparwidth=13em,
			reversemarginpar}

% Marginnote
		%\usepackage{zhbianzhu}
		%\usepackage[noadjust]{marginnote}
		\RequirePackage[noadjust]{marginnote}
		\renewcommand*{\raggedleftmarginnote}{}
		\renewcommand*{\raggedrightmarginnote}{}
		\renewcommand*{\marginfont}{\CTEXindent \kaishu}

% paracolumn
		\RequirePackage{paracol}
		\columnratio{0.3}
		\setlength{\columnsep}{0.5em}
		\setlength{\columnseprule}{0em}
		\footnotelayout{m}

% Pictures
\RequirePackage{graphicx}

% refer numbers
%\RequirePackage{zhshuzi}

% color macro
\RequirePackage{xcolor}

% draw Pictures
\RequirePackage{tikz}
\RequirePackage{tikzpagenodes}

% colors boxder macro
\RequirePackage[most]{tcolorbox}
	% postil
	\newtcolorbox{postil}
	{
		parbox=false,
		before upper=\indent,
		drop fuzzy shadow,
		enhanced,
			boxrule=0.4pt,
			left=5mm,
			right=2mm,
			top=1mm,
			bottom=1mm,
			colback=gray!5,
			colframe=black,
			sharp corners,
			rounded corners=southheast,
			arc is angular,
			arc=3mm,
			overlay=
				{
					\path[fill=gray!20] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
					\path[draw=black,shorten <= -0.05mm,shorten >= -0.05mm ] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
					\path[fill=gray,draw=none](interior.south west) rectangle node [white]{\Huge\bfseries!}([xshift=4mm]interior.north west);
				}
	}

	% Exercise firmware
	\usetikzlibrary{decorations.markings}

	\newtcolorbox{Exercise}
	{
		enhanced,
			breakable,
			sharp corners=all,
			left=1mm,
			width=\textwidth-7mm,
			before skip=1.5em,
			colframe=black,
			colback=gray!5,
			attach boxed title to top left=
				{
					xshift=0mm,
					yshift=0mm
				},
			boxed title style=
				{
					skin=enhancedfirst jigsaw,
					arc=5mm,
					bottom=0mm,
					left=8mm,
					right=18mm,
					top=1mm,
					colback=black,
					colframe=black
				},
			borderline north={4pt}{-4pt}{black},
			title=
				{
					习题\thesection
				},
				fonttitle=\bf\Large,
				parbox=false,
				before upper=\indent,
			overlay=
				{
					\fill
						[
							decorate,
							decoration=
								{
									markings,
									mark = between positions 0.05  and 0.98 step 6mm width
										{
											\node [circle,draw=black]{};
										}
								}
						]
						( [xshift=3mm,yshift=-6mm]frame.north east	)--( [xshift=3mm,yshift=5mm]frame.south east );
						\draw[thick, rounded corners]( [yshift=-2mm]frame.north east )--++(0:6mm)--( [xshift=6mm,yshift=2mm]frame.south east )--++(180:6mm);
						\begin{tcbclipinterior}
							\fill[gray!60](frame.north west) rectangle ( [xshift=1cm]frame.south west );
						\end{tcbclipinterior}

				},
	}

% enviroment for exercise
\tcbset{
	exercise/.style=
		{
			on line,
			top=0mm,
			bottom=0mm,
			boxrule=0mm,
			colback=gray!5,
			fontupper=\bf,
			left=0mm,
			right=0mm
		}
	}
	\newenvironment{exercises}
	{
		\begin{enumerate}
		[
			label =
			{\tcbox[exercise]
				{\makebox[2em]
					{
						\arabic*
					}
				}
			},
			labelindent=0em,
			labelwidth=2em,
			labelsep=0.2em,
			leftmargin=2.2em
		]
	}{\end{enumerate}}


% enumitem
\RequirePackage{enumitem}
\setenumerate
	{
		itemsep=0pt,
		partopsep=0pt,
		parsep=\parskip,
		topsep=0pt
	}

% list
\RequirePackage{hlist}
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
	}{\end{hlist}}

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
	}{\end{hlist}}

% enviroment for examples
\RequirePackage{fontawesome5}
\newcounter{examplescounter}[section]
\newenvironment{examples}{\refstepcounter{examplescounter}
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
	}{\end{enumerate}}

% enviroment for analysis
\newenvironment{analysis}
	[1]
	{
		\faWifi{\bf #1}\hspace{0.5em}
	}
	{\par}


% chapter Table
\RequirePackage[explicit, indentafter,pagestyles]{titlesec}
\titleformat{\chapter}
	[display]
	{\StandardArial\LARGE\filleft}
	{\CTEXthechapter}{0.2em}
	{\titlerule[2pt]\centering\vspace{0.4em} #1}
	[]


\titleformat{name=\chapter,numberless}
	{\LARGE}
	{}
	{0em}
	{\StandardArial\filleft #1}
	[{\titlerule[2pt]}]


\titleformat{\section}
	{\bf\Large}
	{}
	{0em}
	{\begin{tcolorbox}
			[
				nobeforeafter,
				enhanced,
					sidebyside,
					bicolor,
					colback=black,
					colbacklower=gray!30,
					colupper=white,
					collower=black,
					halign upper=center,
					halign lower=left,
					lefthand width=2cm,
					arc=0mm,
					boxrule=0mm,
					top=1mm,
					bottom=1mm
			]\thesection \tcblower #1
		\end{tcolorbox}
	}
	[]


	\titlespacing*{\section}{0em}{0em}{-2em}
	\titlespacing*{\subsection}{-3.5em}{0em}{0.5em}

\newpagestyle{footer}
	{
		\setfoot[高等数学笔记排版~\rule[-0.4mm]{0.2em}{1em}~\thepage][][]
						{}{}{\ifthechapter{\thepage~\rule[-0.4mm]{0.2em}{1em}~\CTEXthechapter\quad\chaptertitle}{\thepage~\rule[-0.4mm]{0.2em}{1em}~\chaptertitle}}
	}
\pagestyle{footer}

	\renewpagestyle{plain}
	{
		\setfoot[][][]
						{}{}{\ifthechapter{\thepage~\rule[-0.4mm]{0.2em}{1em}~\CTEXthechapter\quad\chaptertitle}{\thepage~\rule[-0.4mm]{0.2em}{1em}~\chaptertitle}}
	}

%
\newcommand{\tk}{\CJKunderline{\hspace*{1.6em}$\blacktriang$\hspace*{1.6em}}}

%
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{makecell}
\RequirePackage{booktabs}
\RequirePackage{hhline}
\RequirePackage{colortbl}

\setlength{\abovetopsep}{0ex}
\setlength{\belowrulesep}{0ex}
\setlength{\aboverulesep}{0ex}
\setlength{\belowbottomsep}{0ex}

\newcolumntype{P}[1]{>{\centering\arraybackslash}p{#1}}
\newcolumntype{Y}{!{\vrule width 0.08em}}

\lineskiplimit=5pt
\lineskip=6pt

\delimiterfactor=800

\newtcbox{\eqmybox}
	{
		on line,
		colback=white,
		colframe=black,
		top=1mm,
		bottom=0mm,
		left=0mm,
		right=0mm,
		arc=3mm,
		boxrule=0pt,
		colback=gray!30
	}


% quote
\RequirePackage[titles]{tocloft}

\renewcommand{\cftdot}{\LARGE$\cdot$}
\renewcommand{\cftdotsep}{0.7}
\renewcommand{\cftchapdotsep}{\cftdotsep}


% multicolumn
\RequirePackage{multicol}
\renewcommand\cfttocprehook{\begin{multicols}{2}}
\renewcommand\cfttocposthook{\end{multicols}}

% line gap
%\usepackage[bodytextleadingratio=1.5,restoremathleading=true]{zhlineskip}
\RequirePackage[bodytextleadingratio=1.5,restoremathleading=true]{zhlineskip}
\SetMathEnvironmentSinglespace{1.1}

\AtBeginDocument
	{
	\begingroup
	\catcode `\:=\active
	\scantokens{\gdef:{\mathpunct{\mbox{: \hspace{-0.18em}}}}}
	\endgroup
	\mathcode `\:="8000
	}


\makeatletter
	\begingroup
	\catcode `\,=\active
	\def\@x@{\def,{\mathpunct{\mbox{, \hspace{-0.18em}}}}}
	\expandafter\endgroup\@x@
	\mathcode`\,="8000
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
% 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
