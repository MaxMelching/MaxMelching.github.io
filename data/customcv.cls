%% start of file `moderncv.cls'.
%% Original author: Alessandro Plasmati
% 
% Modified in 2024 by Max Melching
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License version 1.3c,
% available at http://www.latex-project.org/lppl/.



\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{customcv}[2024/11/17 v1.0 A custom CV class.]

% -- Set the default theme color
\newcommand{\customcv@themecolor}{black}

% NOTE: using classicthesis here already throws error, for some reason

\RequirePackage{xkeyval}
\DeclareOptionX{themecolor}[black]{\renewcommand{\customcv@themecolor}{#1}}
\ProcessOptionsX

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}

% -- Process the options to apply any changes
\ProcessOptions\relax

% -- Load the base class with all other options
\LoadClassWithOptions{scrartcl}

% -- Use the custom theme color to define the actual color
\AtEndOfClass{
  \RequirePackage[nochapters]{classicthesis}
  \RequirePackage{xcolor}
  \definecolor{themecolor}{named}{\customcv@themecolor}
}


% \RequirePackage{xcolor}
% \definecolor{Black}{named}{black}
% -- Trying to test if we can get things done without classicthesis



%----------------------------------------------------------------------------------------
%	PACKAGES AND OTHER DOCUMENT CONFIGURATIONS
%----------------------------------------------------------------------------------------

% \RequirePackage{subfiles}

\RequirePackage[nochapters]{classicthesis} % Use the classicthesis style for the style of the document
\RequirePackage[LabelsAligned]{currvita} % Use the currvita style for the layout of the document -> pass option NoDate to omit date; but I see why it makes sense, for things like present


% -- Trying to get bfseries + scshape to work
% \RequirePackage{mathpazo}
\RequirePackage[T1]{fontenc}
\RequirePackage{tgpagella}  % Wow, makes huge difference! Many more fonts available, e.g. bf+sc
% \DeclareFontShape{T1}{lmr}{b}{sc}{<->ssub*cmr/bx/sc}{}
% \DeclareFontShape{T1}{lmr}{bx}{sc}{<->ssub*cmr/bx/sc}{}



\reversemarginpar % Move the margin to the left of the page 

% \newcommand{\MarginText}[1]{\marginpar{\raggedleft\itshape\small#1}} % New command defining the margin text style
\newcommand{\MarginText}[1]{%
\marginpar{%
\centering%
\itshape%
\small%
#1%
}} % New command defining the margin text style
% \newcommand{\MarginText}[1]{\marginpar{\raggedright\itshape\small#1}} % New command defining the margin text style
% -- Hmmm the alignment I choose does not matter, is aligned automatically to the right


% \newlength{\margintextwidth} % Correct value set below
% % \newcommand{\MarginText}[1]{\par\hspace*{-\margintextwidth}{\centering\itshape\small#1}\hspace*{0\margintextwidth}} % New command defining the margin text style
% \newcommand{\MarginText}[1]{\par\hspace*{-\margintextwidth}\parbox[c]{\margintextwidth}{\itshape\small#1}} % New command defining the margin text style
% -- Custom definition is not really successful, falling back to classicthesis one




% \RequirePackage[right=1in]{geometry}  % Must be here to have effect, but effect it has is unexpected
% \RequirePackage[scale=0.5]{geometry} % Reduce document margins
% \newlength{\leftmargin}
% \setlength{\leftmargin}{2in}
% \RequirePackage[left=\leftmargin,right=1.5in,top=1in,bottom=1in]{geometry} % Margins set by eye test
% -- Ah, \leftmargin is set automatically
% \RequirePackage[left=2in,right=1.5in,top=1in,bottom=1in]{geometry} % Margins set by eye test
% \RequirePackage[left=2.1in,right=1.25in,top=1in,bottom=1in]{geometry} % Margins set by eye test
% -- HAS TO BE DONE BELOW!

\renewcommand{\cvheadingfont}{\LARGE\bfseries\color{themecolor}} % Font color of your name at the top

\RequirePackage{hyperref} % Required for adding links and customizing them
\hypersetup{colorlinks, breaklinks, urlcolor=themecolor, linkcolor=themecolor} % Set link colors



% \newlength{\datebox}\settowidth{\datebox}{Summer -- Winter} % Set the width of the date box in each block
\newlength{\datebox}\settowidth{\datebox}{\itshape\small00/0000 -- 00/0000} % Set the width of the date box in each block


% -- Handle indents
\newlength{\entryindent}
\newlength{\infoindent}
\newlength{\descriptionindent}
\newlength{\headindent}
\newlength{\subheadindent}

\setlength{\entryindent}{0pt}
\setlength{\infoindent}{0pt}
\setlength{\descriptionindent}{0pt}
\setlength{\headindent}{0pt}
\setlength{\subheadindent}{0pt}


\newcommand{\NewEntry}[3]{%
    \par%
    \noindent\hangindent=\entryindent\hangafter=0%
    % \textit{#1}\hfill#3%
    % \MarginText{#2}\textit{#1}\hfill#3%
    % \MarginText{#2}\raggedright\textit{#1}\hfill#3%
    % \MarginText{#2}\raggedleft\textit{#1}\hfill#3%
    \ifthenelse{\isempty{#3}}{\MarginText{#2}\raggedright\textit{#1}}{\MarginText{#2}\raggedleft\textit{#1}\hfill#3}% Only this works. I do not understand why, but I also don't really care -> maybe related to margin definition by either classicthesis or currvita, so perhaps some weird interplay coming from that
    \par%
} % Define a command for each new block - change spacing and font sizes here: #1 is the date in left margin, #2 is the italic description field and #3 is the position/employer/location field


\newcommand{\Info}[2]{%
    \par%
    \noindent\hangindent=\infoindent\hangafter=0%
    \parbox{0.33\textwidth}{\textit{#1}}#2%
    \vspace{-0.5\parskip}\par%
} % Entry with no date, also no hfill
% -- We also make effective parskip half of what the value at time of use is, looks better. \par ensures this is applied no matter if new paragraph is started in code or not



% -- NOTE that any additional spaces between arguments in the definitions will lead to things being off!!!



% \newlength{\descriptionwidth}
% \setlength{\descriptionwidth}{\textwidth}

% \newcommand{\Description}[1]{\par\noindent\hangindent=0em\hangafter=0\normalsize#1\par}
% \newcommand{\Description}[1]{\par\noindent\hangindent=0em\hangafter=0\normalsize\raggedright#1\par}

\RequirePackage{xifthen}
% \newlength{\defaultparskip}
% \setlength{\defaultparskip}{\parskip}
% -- Idea was to avoid roundoff errors for arbitrary values, but does not really work (changing parskip seems to change defaultparskip too)

\newcommand{\Description}[2][]{%
    \setlength{\parskip}{0.5\parskip}%
    % \setlength{\parskip}{0.5\defaultparskip}\par%
    \par%
    \noindent\hangindent=\descriptionindent\hangafter=0\normalsize%
    \ifthenelse{\isempty{#1}}{}{\MarginText{#1}}%
    \raggedright#2%
    \par\setlength{\parskip}{2\parskip}%
    % \par\setlength{\parskip}{\defaultparskip}%
} % Allows to put optional date in here



% -- Fancy box for head, stolen from section of moderncvstyleclassic
\newlength{\headboxwidth}
% \setlength{\headboxwidth}{0.25\textwidth}
\setlength{\headboxwidth}{\datebox}
\newlength{\headboxheight}
\setlength{\headboxheight}{1ex}
\newlength{\baseletterheight}
\settoheight{\baseletterheight}{{\Large\scshape o}}  % Choose font from head here
\newlength{\separatorcolumnwidth}
% \setlength{\separatorcolumnwidth}{0.025\textwidth}
\setlength{\separatorcolumnwidth}{2em}


\RequirePackage{contour}
\contourlength{0pt}% Thickness of contour

\newcommand{\head}[1]{
    \par% Make sure new paragraph is started
    \vspace*{1em}% Spacing between different headings
    \noindent\hangindent=\headindent\hangafter=0%
    \hspace{-\headboxwidth}\hspace{-\separatorcolumnwidth}% Spacing adjustments
    \parbox[t]{\datebox}{\raisebox{0.25\baseletterheight}{\color{themecolor}\rule{\headboxwidth}{\headboxheight}}}% Colored ruler on left side
    \hspace{\separatorcolumnwidth}%
    {\Large\scshape\bfseries% Unfortunately, pagella has no fat + smallcaps
     \color{themecolor}%
     % \color{themecolor!92!black}%
     #1
    }% Actual text
    \par%
} % This seems to work. Looked at how NewEntry does things
% -> maybe don't raise box at all? Also, I kind of think box height 0.5\baseletterheight instead of 1ex would make more sense, but this looks really good. So we just use this one
% \newcommand{\head}[1]{\hspace{-\headboxwidth}\hspace{-\separatorcolumnwidth}\parbox[t]{\datebox}{\raisebox{0.5\baseletterheight}{\color{themecolor}\rule{\headboxwidth}{0.95ex}}}\hspace{1.5em}\hspace{\separatorcolumnwidth}\noindent\hangindent=1em\hangafter=0{\Large\color{Black}\textsc{#1}}\vspace{0.5em}} % Not working, but was just testing


% -- Now adjust leftmargin, taking bpx into account
\setlength{\leftmargin}{0.75in} % Between left end and beginning of the colored boxes
\addtolength{\leftmargin}{\headboxwidth}
\addtolength{\leftmargin}{\separatorcolumnwidth}
% \addtolength{\leftmargin}{1em}

% \addtolength{\margintextwidth}{\headboxwidth}
% \addtolength{\margintextwidth}{\separatorcolumnwidth}

% -- Very important to apply geometry, otherwise setting leftmargin has no impact
% \RequirePackage[left=2.1in,right=1.25in,top=1in,bottom=1in]{geometry} % Margins set by eye test
\RequirePackage[left=\leftmargin,right=1in,top=1in,bottom=1in]{geometry} % Margins set by eye test



\newcommand{\subhead}[1]{
    \par% Make sure new paragraph is started
    % \vspace{0.5\parskip}% Additional spacing between different headings
    \noindent\hangindent=\subheadindent\hangafter=0%
    {%
    % \spacedlowsmallcaps{#1}
    \slshape\spacedlowsmallcaps{#1}
    % \color{themecolor}\spacedlowsmallcaps{#1}%
    % \contour{black}{\textcolor{themecolor}{\spacedlowsmallcaps{#1}}}%
    }%
    % \vspace*{-0.33\parskip}% Does not make things better
    \par%
}


% \renewcommand{\emph}{%
\newcommand{\subsubhead}[1]{%
    % \textbf{#1}%
    \textbf{\textsc{#1}}%
}



\RequirePackage{csquotes}


\RequirePackage{xcolor}
\def\showtodos{true}
\newcommand{\hidetodos}[0]{\def\showtodos{false}}
\newcommand{\todo}[1]{\ifthenelse{\equal{\showtodos}{true}}{\fcolorbox{white}{red!42}{\textit{\textbf{TODO:}} #1}}{}}

%----------------------------------------------------------------------------------------
