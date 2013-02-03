% ******************** start of: char_gigglenot.inc
%

%
%
% ***************************************************** Items
\newpage
\textbf{\underline{Armor, Weapons, Clothes:}} \\
Leather Armor,
Dagger +3,
Rapier Flaming +2 +1D6 Fire Damage,
Hand Crossbow, Bolts 28, 
Gnome Hooked Hammer, 
Whetstone, 
Periapt of Wisdom +4, 
Gloves of Dexterity +2, 
Eversmoking Bottle,
Circlet of Persuation,
Circlet of Blasting Dmg 40 1/Day,
Ring of Jumping +5,
Cloak of Elvenkind,
Ring of Mind Shielding (Gruppe)

%
% ***************************************************** Potions, etc.
\textbf{\underline{Potions, Oils, Scrolls, Wands, Wondrous Items:}} \\
Scroll of ```Invisilibity'''\\
Scroll of ```Darkness''' arcane x2\\
Potion of ```Levitate'''\\
Wand of ```Hold Person''' x44\\
Wand of Melfs Acid Arrow''' x8\\
Wand of ```Cats Grace''' DC20 arcane x21\\
Wand of ```Cure Moderate Wounds''' divine x17

%
%Potion of ```XXX''',
%
%Oil of ```XXX''',
%
%Scroll of ```XXX''',
%
%Wand of ```XXX'''

%
% ***************************************************** Normal Items, etc.
\textbf{\underline{Normal Items:}} \\
Backpack (Waterskin, 2 Trail Rations, Flint \& Steel, Tinderbox, Heavy Bedroll)\\
Boots of Elvenkind\\
Rope 20ft\\
Magnifying Glass\\
Thiefs Tools\\
Good Lock\\
Signal Horn

%
% ***************************************************** Normal Items, etc.
% \textbf{\underline{Gems:}} \\

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
\end{tabularx}


%
% ***************************************************** Add Spell Table
%\newpage
include(`spells_definitions.m4')dnl

%
% ******************** end of: char_gigglenot.inc
