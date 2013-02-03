% ******************** start of: char_urivol.inc
%
% ***************************************************** Familiar
include(`char_urivol.anm')dnl

%
%
% ***************************************************** Items
\textbf{\underline{Armor, Weapons, Clothes:}} \\
Ring (unadorned, smooth, robust) of ```Protection +4''', 
Ring of Counterspell (Fireball), 
Amulet of Health (Con+2), 
Ioun Stone (Int+2), Pearl of Power (Lvl2,Lvl3), 
Silk Wizard Robe (darkblue), Trousers, 
Bracers of Armor (AC+5), 
Sandal, 
Short Bow +3 \& Quiver, 20 Arrows, 
Long Bow (masterwork), 
Dagger of Firebane, 
Cloak with Sign of Alysha, Ring with Sigil of Alysha,
Serenas Mantle od Spell Resistance,
Robe of the neutral archmage,
Periapt of Wisdom+6,
Headband+6 (Int)

%
% ***************************************************** Potions, etc.
\textbf{\underline{Potions, Oils, Scrolls, Wands, Wondrous Items:}} \\
%Potion of ```XXX'''
Spell Book, 
Bag of Holding II, 
% Scroll of ```Invisibility''' (caster level 3) % from Hazela
%Oil of ```XXX'''
% Ring of ```Protection from Mind-Reading''', 
Wooden Globe of ```Continual Flame''' (p.213)
Crystal ball with ```See invisibility''' (p.253)

Potions, Oils, Scrolls, Wands according to bagpack list

%
% ***************************************************** Spell Components, etc.
\textbf{\underline{Spell Component Pouch:}} \\ % few needed due to feat: Eschew Materials
%Cat Hairs
--

%
% ***************************************************** Normal Items, etc.
\textbf{\underline{Normal Items:}} \\
Backpack (Waterskin, Trail Ration, Flint \& Steel, Chalk, Salt),
Bag (Bedroll, Blanket, Clothes)

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
% ***************************************************** Druid Spells
%\newpage
include(`spells_definitions.m4')dnl

%
% ******************** end of: char_urivol.inc
