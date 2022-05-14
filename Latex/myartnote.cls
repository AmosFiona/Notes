%! program =xeLatex

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myartnote}
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
		paperheight = 297 mm,
		paperwidth 	= 210 mm,
		top 				= 20  mm,
		bottom 			= 15  mm,
		left 				= 18  mm,
		right 			= 16  mm
		%width 			= 17 cm,
		%height 			= 24.7 cm,
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

