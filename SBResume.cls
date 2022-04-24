%!TEX TS-program = xelatex
%!TEX encoding = UTF-8 Unicode

% Copyright 2017, Sean Bradly <sb@nsfw.jp> 

%-------------------------------------------------------------------------------
%----- Define this class -------------------------------------------------------

\ProvidesClass{SBResume}[2017/05/04 v1.1.1 Sean Bradly's Resume]
\NeedsTeXFormat{LaTeX2e}

% Inherit options from the article class
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

%-------------------------------------------------------------------------------
%----- Configure external packages ---------------------------------------------

\RequirePackage{array}
\RequirePackage{fontspec}
\RequirePackage{fontawesome}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{xifthen}
\RequirePackage[skins]{tcolorbox}
\RequirePackage[hidelinks,unicode]{hyperref}
\RequirePackage{ulem}
\RequirePackage{longtable}
\RequirePackage{enumitem}
\RequirePackage{amsmath}
\RequirePackage{wrapfig}
\RequirePackage{multicol}
\RequirePackage{tikz}

\usetikzlibrary{shapes.geometric,fit,decorations.pathreplacing}

%\RequirePackage{ragged2e}
%\RequirePackage{etoolbox}
%\RequirePackage{setspace}

\defaultfontfeatures{Ligatures=TeX} % supports embedded unicode characters

\hypersetup{%
  colorlinks=true,
  allcolors=black,
  pdftitle={},
  pdfauthor={},
  pdfsubject={},
  pdfkeywords={}
}

%-------------------------------------------------------------------------------
%----- General Layout ----------------------------------------------------------


\geometry{left=2.5cm, top=.75cm, right=2.5cm, bottom=2.0cm, footskip=.5cm}
\fancyhfoffset{0em}
\fancyhf{}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}
\setlength{\parindent}{0pt}

%-------------------------------------------------------------------------------
%----- Colors ------------------------------------------------------------------

\definecolor{normaltext}{HTML}{000000}
\definecolor{photoborder}{HTML}{112211}
\definecolor{fname}{HTML}{a0a0a0}
\definecolor{lname}{HTML}{303030}
\definecolor{jobtitle}{HTML}{c03030}
\definecolor{location}{HTML}{000000}
%\definecolor{companycolor}{HTML}{2028A0}
%\definecolor{titlecolor}{HTML}{2028A0}
\definecolor{companycolor}{HTML}{000000}
\definecolor{titlecolor}{HTML}{000000}
\definecolor{datecolor}{HTML}{808080}
\definecolor{headingcolor}{HTML}{000000}
\definecolor{headinglinecolor}{HTML}{bbbbbb}
\definecolor{bodycolor}{HTML}{000000}
\definecolor{footercolor}{HTML}{777777}


%-------------------------------------------------------------------------------
%----- Fonts -------------------------------------------------------------------

\newfontfamily\namefont[Path=fonts/]{AlfaSlabOne-Regular}
\newfontfamily\hdgfont[Path=fonts/,
  UprightFont=Roboto-Light,
  ItalicFont=Roboto-ThinItalic,
  BoldFont=Roboto-Bold,
  BoldItalicFont=Roboto-BoldItalic,
]{Roboto-Regular}
\newfontfamily\bodyfont[Path=fonts/,
  ItalicFont=SourceSansPro-Italic,
  BoldFont=SourceSansPro-Bold
]{SourceSansPro-Regular}
\newfontfamily\bodyfontlight[Path=fonts/,
  ItalicFont=SourceSansPro-Italic,
  BoldFont=SourceSansPro-Bold
]{SourceSansPro-Light}

%-------------------------------------------------------------------------------
%----- Commands to define bio info ---------------------------------------------

% Contact info

\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\location}[1]{\def\@location{#1}}
\newcommand*{\jobtitle}[1]{\def\@jobtitle{#1}}
\newcommand*{\phonenumber}[1]{\def\@phonenumber{#1}}
\newcommand*{\emailaddr}[1]{\def\@emailaddr{#1}}

% Optional social-media account info
\newcommand*{\homepage}[1]{\def\@homepage{#1}}
\newcommand*{\github}[1]{\def\@github{#1}}
\newcommand*{\linkedin}[1]{\def\@linkedin{#1}}

% Define photo ID
% Usage: \photo[circle|rectangle,edge|noedge,left|right]{<path-to-image>}
\newcommand*{\headshot}[1]{\def\@headshot{#1}}


%-------------------------------------------------------------------------------
%----- Cover letter data ------------------- -----------------------------------
\newcommand*{\companyname}[1]{\def\@companyname{#1}}
\newcommand*{\companyaddr}[1]{\def\@companyaddr{#1}}
\newcommand*{\letterdate}[1]{\def\@letterdate{#1}}
\newcommand*{\letteropen}[1]{\def\@letteropen{#1}}
\newcommand*{\letterclose}[1]{\def\@letterclose{#1}}
\newcommand*{\letterattach}[1]{\def\@letterattach{#1}}
\newcommand*{\lettertitle}[1]{\def\@lettertitle{#1}}

%-------------------------------------------------------------------------------
%----- Commands to output common-format info -----------------------------------

\newcommand{\insertname}{\@firstname\ \@lastname}
\newcommand{\insertlocation}{\@location}

\newcommand{\insertheadshot}{%
    \ifthenelse{\isundefined{\@headshot}}{}{
      \newlength{\photodim}
      \setlength{\photodim}{0.8cm}
      \begin{tikzpicture}%
        \node[ellipse, draw, minimum width=1.1cm, minimum height = 3.7cm, inner sep=\photodim, fill overzoom image=\@headshot] () {};
      \end{tikzpicture}
    }
}

%-------------------------------------------------------------------------------
%----- Commands to output document structures ----------------------------------

\newcommand*{\lhfnamestyle}[1]{{\hdgfont\fontsize{36pt}{1em}\color{fname}{\textup{#1}}}}
\newcommand*{\lhlnamestyle}[1]{{\hdgfont\fontsize{36pt}{1em}\color{lname}{\textbf{#1}}}}
\newcommand*{\lhnamestyle}[1]{#1}
\newcommand{\lhcontactstyle}{\hdgfont\fontsize{5.80pt}{1em}\scshape}
\newcommand{\lhcontactsep}{\quad\textbar\quad}
\newcommand*{\lhlocstyle}[1]{{\hdgfont\fontsize{7.0pt}{1em}\textit{\scshape#1}}}
\newcommand*{\lhtitlestyle}[1]{{\hdgfont\fontsize{8.40pt}{1em}\color{jobtitle}\textbf{#1}}}

\newcommand{\makeletterhead}{
  \lhnamestyle{
    \lhfnamestyle{\@firstname}
    \lhlnamestyle{\@lastname}
  }\\
  {
    \lhcontactstyle
    \href{mailto:\@emailaddr}{\faEnvelopeO\ \@emailaddr}
    \lhcontactsep
    \href{https://www.linkedin.com/in/\@linkedin}{\faLinkedinSquare\ \@linkedin}
    \lhcontactsep
    \href{https://github.com/\@github}{\faGitSquare\ \@github}
    \lhcontactsep
    \faMobile\ \@phonenumber
  }\\
  {\color{location}$\vcenter{\hbox{\rule{4.8cm}{0.2pt}}}$\ \lhlocstyle{\@location}}\\
  {\vspace{0.1pt}}
  \lhtitlestyle{\@jobtitle}\\
}

\newcommand{\makeheader}{\begin{center}\makeletterhead\end{center}}

\newcommand*{\ltrecipstyle}[1]{{\hdgfont\color{companycolor}\fontsize{16pt}{1em}\textbf{#1}}}
\newcommand*{\ltdatestyle}[1]{{\bodyfont\color{datecolor}#1}}
\newcommand*{\ltaddrstyle}[1]{{\bodyfont\color{datecolor}\fontsize{6pt}{1em}\small{#1}}}
\newcommand*{\ltstyle}[1]{{
    \hdgfont\color{titlecolor}\fontsize{16pt}{1em}\uline{\textbf{#1}}
}}

\newcommand*{\makelettertitle}{%
  \vspace{2cm}

  \ltrecipstyle{\@companyname} \hfill \ltdatestyle{\@letterdate}\par
  \vspace{0.15cm}
  \ltaddrstyle{\@companyaddr}\par
  
  \begin{flushright}
    \ltstyle{\@lettertitle}
  \end{flushright}
  
}

\newcommand*{\lettersection}[1]{
  {
    \vspace{0.3cm}
    \hdgfont
    \noindent
    \color{headingcolor}
    \fontsize{14pt}{1em}
    \textbf{\textit{#1}}
    \color{headinglinecolor}
    \leaders\hbox{ \rule[0.5em]{1pt}{1pt} }\hfill
    \vspace{0.15cm}
  }\par
}

\newcommand*{\letterbodystyle}{
  \bodyfont
  \fontsize{8pt}{1em}
  \color{bodycolor}
}  

\newcommand*{\makeletterclosing}[1]{
  {
    \letterbodystyle
    \vspace{0.3cm}
    \noindent\@letterclose
    
    \vspace{1.5cm}
    \hfill#1
  }
}

\newcommand*{\letterfooterstyle}[1] {
  \bodyfontlight
  \color{footercolor}
  \fontsize{5pt}{1em}
  \textit{#1}
}

\newenvironment{letterbody}[1]
               {
                 \letterbodystyle
                 \setlength\parindent{12pt}
                 \setlength{\parskip}{0.2cm}
                 \noindent#1\par
               }
               {
               }

\newcommand*{\makeletterfooter}[1]{
  \fancyfoot{}
  \fancyfoot[C]{\letterfooterstyle{#1}}
}


\newenvironment{resume}{%
  \bodyfont
}{%
}

\newenvironment{resumeitemize}{%
  \begin{itemize}
    \setlength\itemsep{-0.25em}
    \setlist{nosep}
}{%
  \end{itemize}
}
\newenvironment{resumemultiitem}{%
  \begin{multicols}{2}
  \begin{itemize}
    \setlength\itemsep{-0.35em}
    \setlist{nosep}
}{%
  \end{itemize}
  \end{multicols}
}
\newenvironment{resumeitemize2}{%
  \begin{itemize}
    \setlength\itemsep{-0.15em}
    \setlist{nosep}
}{%
  \end{itemize}
}

\newlength{\residewidth}
\newlength{\remainwidth}
\setlength{\residewidth}{0.20\textwidth}
\setlength{\remainwidth}{0.80\textwidth}

\newcommand{\resumeentry}[5]{
  \begin{minipage}[t]{\residewidth}%
%    \hdgfont\uline{#1}\par
%    
    #2
  \end{minipage}
  \begin{minipage}[t]{\remainwidth}
    \hdgfont\textbf{\uline{#3}}%
    \hfill%
    {\footnotesize\textbf{#4 • \textit{#1}}}\\
    \footnotesize{\bodyfont#5\vspace{\parsep}}
  \end{minipage}
  \vspace{.25cm}
}
\newcommand*{\resumeentryheading}[1]{\vspace*{-0.1cm}{\quad\quad\hdgfont\footnotesize{\textbf{\uline{#1}}}}\vspace*{-0.35cm}}

\def\Vrulefill#1#2{
  \leaders%
  \vtop{\hsize=.0025in\vskip#1#2}%
  \hfill%
}
\newcommand*\ruleline[1]{%
  \par%
  \noindent%
  \raisebox{.8ex}{%
    \makebox[\linewidth]{%
      \hrulefill%
      \hspace{1ex}%
      \raisebox{-.8ex}{#1}%
      \hspace{1ex}%
      \hrulefill%
    }%
  }%
}

% \newcommand*{\resumeentryheading}[1]{\hdgfont\footnotesize{\textbf{\uline{#1}}}}
\newcommand*{\resumesection}[1]{
  {
    \vspace{0.25cm}
    % \noindent
    %\Vrulefill{-.05in}{\textbf{\_}}
    \hdgfont
    \color{headingcolor}
    \ruleline{\large{\textbf{#1}}}
    %\Vrulefill{-.05in}{\textbf{\_}}
    % \vspace{0.35cm}
  }\par
}

\newenvironment{resumetext}{%
  \fontsize{10pt}{1em}
  \bodyfont
}{%

}
