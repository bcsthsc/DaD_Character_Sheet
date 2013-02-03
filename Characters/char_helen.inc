% ******************** start of file: char_helen.inc
%
%
% add familiar
include(`char_helen.anm')
%
%
% ***************************************************** Items
\textbf{\underline{Armor, Weapons, Clothes:}} \\
Dagger, Light Crossbow \& Bolts (20 normal), 
Explorer\aps s Outfit


%
% ***************************************************** Spell Components, etc.
\textbf{\underline{Spell Component Pouch:}} \\
--

%
% ***************************************************** Potions, etc.
\textbf{\underline{Potions, Oils, Ring, Rods, Scrolls, Wands, Wondrous Items:}} \\
--

%
% ***************************************************** Items
\textbf{\underline{Normal Items:}} \\
Backpack (waterskin, 2 daily rations, bedroll, flint \& steel, chalk)


%
% ***************************************************** Wealth
\begin{tabularx}{\textwidth}{|l|X|}
\multicolumn{2}{l}{\textbf{Wealth:}%
\hfill
Platinum \hspace*{1ex} $\stackrel{\mbox{\tiny 1:10}}{\longrightarrow}$ \hspace*{1ex}%
Gold     \hspace*{1ex} $\stackrel{\mbox{\tiny 1:10}}{\longrightarrow}$ \hspace*{1ex}%
Silver   \hspace*{1ex} $\stackrel{\mbox{\tiny 1:10}}{\longrightarrow}$ \hspace*{1ex}%
Copper   \hspace*{1cm}1 coin = 1/50 lbs. $\approx$ 9 g}\\
\hline
Platinum & wealth_platinum \\ \hline
Gold     & wealth_gold     \\ \hline
Silver   & wealth_silver   \\ \hline
Copper   & wealth_copper   \\ \hline
Gems     & wealth_gems     \\ \hline
\end{tabularx}


%
% ***************************************************** Add Spell Table
%\newpage
dnl Sorry, Shadowcaster spell rules are not implemented yet
dnl include(`spells_definitions.m4')dnl

%
% ******************** end of file: char_helen.inc
