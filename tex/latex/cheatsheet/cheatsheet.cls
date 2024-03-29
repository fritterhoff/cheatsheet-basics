\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cheatsheet}[2019/02/03 Cheatsheet Template]
% !TeX TXS-program:compile = txs:///pdflatex/[--shell-escape]
\LoadClass[fontsize=7pt,a4paper]{scrartcl}


\RequirePackage[english, ngerman]{babel}
\RequirePackage{geometry}
\RequirePackage[utf8]{inputenc}	
\RequirePackage[utf8]{luainputenc}			
\RequirePackage{multicol}			

\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{graphicx}
\RequirePackage{url}
\RequirePackage{breakurl}
\RequirePackage[cache=false]{minted}

\RequirePackage[most,skins]{tcolorbox}
\RequirePackage{multicol}
\RequirePackage{adjustbox}
\RequirePackage{tabularx}
\RequirePackage{colortbl}
\RequirePackage{titlesec}
\RequirePackage{parskip} 
\RequirePackage{fancyhdr}
\RequirePackage{csquotes}
\RequirePackage[backend=biber,maxbibnames=99,sorting=nty,hyperref=true,backref=true]{biblatex}

\RequirePackage[breaklinks,pdfpagelabels,hidelinks]{hyperref}
\hypersetup{pdfpagemode=UseNone,
	pdffitwindow=true,     % window fit to page when opened
}
\RequirePackage{cleveref}
\RequirePackage{siunitx}
\makeatletter
\newcommand{\revisiondate}{\today}
\newcommand{\revision}{Nicht versioniert}
\tcbset{common/.style={colframe={#1!80},  
		colback={white},
		boxed title style={colback=#1!80},
		enhanced jigsaw,
		sharp corners,
		size=small,
		halign=left,
		fonttitle=\bfseries}
	}
\newtcolorbox[auto counter, number within=section]{normbox}[2][]{
	common={gray!90!white}, 
	title=#2,
	#1
}
\newtcolorbox[auto counter, number within=section]{sectionbox}[2][]{
	common={gray!90!white}, 
	title=\subsection{#2},
	#1
}
\newtcolorbox[use counter from=sectionbox]{warningbox}[2][]{
	common={red!90!black}, 
	colback=red!5!white,
	title=#2,
	#1
}  
\newtcolorbox[use counter from=sectionbox]{symbolbox}[1][]{	
	common={orange!90!black},
	colback=orange!5!white,
	#1
}  
\newtcolorbox[use counter from=sectionbox]{hintbox}[2][]{
	common={green!40!black},
	colback=green!4!white,
	title=#2,
	#1
}
\renewcommand{\title}[1]{%
	  \gdef\@title{#1}%
	  \gdef\thetitle{#1}
	  \pdfstringdef{\@pdftitle}{\@title}%
	  \hypersetup{pdftitle=\@pdftitle}%
}
\renewcommand{\maketitle}{
	
	\fancyfoot[C]{ Zusammenfassung - \@title}
	{
			\begin{center}
				\huge{
				\textbf{\thetitle}
			}
			\end{center}
	}
}
\makeatother

\makeatletter
\@addtoreset{section}{part}
\makeatother

\titleformat{\part}{\pagebreak\huge \bfseries}{}{0em}{\huge \bfseries}
\titleformat{\section}{\Large\bfseries}{\thesection .}{0.5em}{}
\titleformat{\subsection}{\large\bfseries}{\thesubsection .}{0.3em}{}
\titleformat{\subsubsection}{\bfseries}{\thesubsubsection .}{0.3em}{}
\titleformat{\paragraph}{\bfseries}{\theparagraph .}{0.2em}{}

\titlespacing{\section}{0em}{1.0em}{0.1em}
\titlespacing{\subsection}{0em}{0.2em}{-0.2em}
\titlespacing{\subsubsection}{0em}{0.2em}{-0.2em}
\titlespacing{\paragraph}{0em}{0em}{-0.3em}

\setlength{\parskip}{1pt}

\RequirePackage{fontspec}
\setmonofont{Fira Code}[
  Contextuals=Alternate  % Activate the calt feature
]
\renewcommand{\familydefault}{\sfdefault}
\renewcommand{\arraystretch}{1.2}

\setlength{\itemindent}{0em}
\setlength\leftmargini{1.7em}
\setlength\itemsep{0em}

\providecommand{\ol}[1]{\ensuremath{\overline{#1}}}							
\providecommand{\bs}[1]{\ensuremath{\boldsymbol{#1}}}						
\providecommand{\Ra}{\ensuremath{\Rightarrow}\,}							
\providecommand{\ra}{\ensuremath{\rightarrow}\,} 							
\providecommand{\la}{\ensuremath{\leftarrow}\,} 								
\providecommand{\lra}{\ensuremath{\longrightarrow}} 						

\graphicspath{ {img/} {images/} }		
\pretolerance=60
\tolerance=2000
\doublehyphendemerits=10000       
\brokenpenalty=10000             
\widowpenalty=9999                
\clubpenalty=9999                
\interdisplaylinepenalty=100
\interfootnotelinepenalty=9999    

\geometry{a4paper,landscape, left=6mm,right=6mm, top=6mm, bottom=5mm,includefoot, footskip=1.7em}
\newcounter{columnnumber}
\setcounter{columnnumber}{4}

\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0.0pt} 
\setlength{\columnseprule}{0.1pt}
\AtBeginDocument{
	\fancyfoot[L]{Stand: \revisiondate \, (\textit{\revision})}
	\fancyfoot[R]{{\color{blue}\href{https://github.com/fritterhoff/sample-cheatsheet}{Vorlage auf GitHub}} - \thepage/\pageref{LastPage}}
	
	\renewcommand\theFancyVerbLine{\footnotesize\arabic{FancyVerbLine}}
	\setminted{numbersep=1px,fontsize=\footnotesize}
	\begin{multicols*}{\value{columnnumber}}
		\raggedcolumns
		\maketitle
}
\AtEndDocument{
    \label{LastPage}
    \end{multicols*}
}