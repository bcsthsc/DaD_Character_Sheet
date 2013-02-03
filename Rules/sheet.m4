\documentclass[a4paper]{article}

\usepackage[isolatin]{inputenc}
\usepackage{german}
\usepackage{tabularx}
\usepackage{supertabular}
\usepackage{longtable}
\usepackage{epsfig}
\usepackage{boxedminipage}
\usepackage{multicol}
\usepackage[dvips]{color}
\usepackage{rotating}

\newlength{\randbreite}
\setlength{\randbreite}{0.75cm}
\newlength{\bundbreite}
\setlength{\bundbreite}{0.5cm}

\setlength{\oddsidemargin}{-1in}                % ein Zoll ist Standard
\addtolength{\oddsidemargin}{\randbreite}
\addtolength{\oddsidemargin}{\bundbreite}
\setlength{\evensidemargin}{-1in}               % dito
\addtolength{\evensidemargin}{\randbreite}
\setlength{\textwidth}{\paperwidth}             % Gesamtbereite DIN A4 ist 21.0cm
\addtolength{\textwidth}{-2.0\randbreite}       % und rechnen ...
\addtolength{\textwidth}{-\bundbreite}

\setlength{\topmargin}{-1in}
\addtolength{\topmargin}{\randbreite}
\setlength{\topskip}{0cm}
\addtolength{\headheight}{1.0ex}
\setlength{\headsep}{2.0ex}                     % Abstand Kopf -> 1.Textzeile
\setlength{\textheight}{\paperheight}           % und jetzt rechnen ... Höhe DIN A4 (29.7cm) abzüglich der bisherigen Maße
\addtolength{\textheight}{-1in}                 % ein Zoll ist Standardrand
\addtolength{\textheight}{-\topmargin}
\addtolength{\textheight}{-\headheight}
\addtolength{\textheight}{-\headsep}
\addtolength{\textheight}{-\randbreite}         % unteren Rand lassen
\setlength{\footskip}{6ex}

\setlength{\parindent}{0mm}                     % keine Einrückung der ersten Zeile eines Absatzes
\setlength{\parskip}{1ex}                       % Absatzabstand (war einmal 0.21cm)
\setlength{\tabcolsep}{0.75ex}
\setlength{\columnsep}{2ex}			% Abstand der Spalten in der multicol-Umgebung
\setlength{\columnseprule}{0.0pt}		% Dicke der Linien zwischen den Spalten in der multicol-Umgebung
\setlength{\fboxrule}{1.0pt}			% Dicke der Rahmen-Linien in der boxedminipage-Umgebung
\setlength{\arrayrulewidth}{1.0pt}		% Dicke der Linien in Tabellen


\usepackage{fancyhdr}
\pagestyle{fancyplain}
\lhead{\sffamily \textbf{char_name}}
\chead{\sffamily Dungeons \& Dragons Character-Record Sheet}
\rhead{\sffamily {\tiny (\today)} page \thepage{} of \pageref{ref_last_page}}
\lfoot{} \cfoot{} \rfoot{}


\newlength{\circwidth}
\settowidth{\circwidth}{O}
\renewcommand{\o}{\makebox[1.025\circwidth]{O}}

\newlength{\basewidth}
\settowidth{\basewidth}{X}

\newlength{\charpicwidth}
\newlength{\charpicheight}
\newlength{\charpicraise}
\newlength{\hitpointwidth}
\newlength{\spelllinewidth}
\newlength{\spelllineindent}

\setlength{\spelllineindent}{4ex}
\setlength{\spelllinewidth}{\textwidth}
\addtolength{\spelllinewidth}{-\spelllineindent}

\newcommand{\x}{\makebox[1em]{$\scriptscriptstyle \times$}}
\newcommand{\n}{\makebox[1em]{$\scriptscriptstyle \circ$}}
\newcommand{\e}{\makebox[1em]{$\scriptscriptstyle \cdot$}}
\newcommand{\komma}{, }
\newcommand{\aps}{'}
%\newenvironment{sideways}{\tiny}{\normalsize}
\newcommand{\done}{\mbox{$\scriptscriptstyle (\surd)$}}
%\newcommand{\tabcenter}[1]{\mbox{}\hfill{}#1{}\hfill{}\mbox{}}
\newcolumntype{Y}{>{\centering\arraybackslash}X}

\definecolor{shade}{gray}{0.5}

\begin{document}
\fontfamily{cmss}\selectfont
%
% ************************************************************* Name, EP, Level, etc...
%\begin{minipage}[t]{4.5cm}
\begin{tabular}[t]{|l@{ : }l|}
\hline
Name          & \textbf{char_name} \\
Race          & char_race \\
Gender        & char_gender \\
Age           & char_age years \\
Size          & stat_size \\
Height        & regexp(char_height, ^\([0-9]+\) *\([0-9]+\)$, \1)'regexp(char_height, ^\([0-9]+\) *\([0-9]+\)$, \2)'' (calc_height(char_height) cm) \\
Weight        & char_weight lbs.~(regexp(char_weight, ^\([0-9]+\), `eval((\1 * 4536 + 5000) / 10000) kg')) \\
Hair Color    & char_hair_color \\
Eye Color     & char_eye_color \\
Skin Color    & char_skin_color \\ \hline \hline
Alignment     & char_alignment \\
Deity         & char_patron_deity \\
Domains       & char_domains \\
\hline
\end{tabular}
%\end{minipage}
%
\hfill
%
\begin{minipage}[t]{6cm}%
%\epsfig{width=5.0cm,file=./dnd_logo.eps}
%
\mbox{} \hfill%
\begin{tabularx}{5.9cm}[t]{|Y|c|c@{ }c|c|}
\hline
\textbf{Abilities} & Abbr. & \multicolumn{2}{c|}{Score} & Mod.\\
\hline
Strength     & \textbf{`STR'} & STR_score & emph_sign(eval(STR_scdam + STR_scitm), 1) & emph_sign(STR) \\
Dexterity    & \textbf{`DEX'} & DEX_score & emph_sign(eval(DEX_scdam + DEX_scitm), 1) & emph_sign(DEX) \\
Constitution & \textbf{`CON'} & CON_score & emph_sign(eval(CON_scdam + CON_scitm), 1) & emph_sign(CON) \\
Intelligence & \textbf{`INT'} & INT_score & emph_sign(eval(INT_scdam + INT_scitm), 1) & emph_sign(INT) \\
Wisdom       & \textbf{`WIS'} & WIS_score & emph_sign(eval(WIS_scdam + WIS_scitm), 1) & emph_sign(WIS) \\
Charisma     & \textbf{`CHA'} & CHA_score & emph_sign(eval(CHA_scdam + CHA_scitm), 1) & emph_sign(CHA) \\
\hline
\end{tabularx}%
\hfill \mbox{}%
%
\\[1ex]
%
\mbox{} \hfill \makebox[5.9cm]{%
ifelse(eval(ifdef(`char_pic',1,0) && char_picflag),1,`dnl
\setlength{\charpicheight}{16.0ex}dnl
\setlength{\charpicraise}{\charpicheight}dnl
\addtolength{\charpicraise}{-2.55ex}dnl
define(`char_pic_command', `\epsfig{file=./char_`'char_pic,height=\charpicheight}')dnl
\settowidth{\charpicwidth}{char_pic_command}dnl
\raisebox{-\charpicraise}{char_pic_command}dnl
\hspace*{1ex}')%
%
\setlength{\hitpointwidth}{5.9cm}%
ifelse(eval(ifdef(`char_pic',1,0) && char_picflag),1,`\addtolength{\hitpointwidth}{-\charpicwidth}\addtolength{\hitpointwidth}{-1ex}')%
\framebox[\hitpointwidth][l]{\parbox[t]{2.0cm}{\underline{\textbf{Hit Points:}}\\[0.5ex] char_HP\\[6.7ex] \mbox{}}}%
} \hfill \mbox{}%
\end{minipage}
%
\hfill
%
\begin{minipage}[t]{4.5cm}
\begin{tabularx}{4.5cm}[t]{|c||Y|Y|Y|}
\hline
\textbf{Saves} & Fort & Rflx & Will \\ \hline
Base    & save_fort_base  & save_rflx_base  & save_will_base  \\
Ability & CON             & DEX             & WIS             \\
Magic   & save_fort_magic & save_rflx_magic & save_will_magic \\
Misc    & eval(save_fort_misc + save_fort_item) &
          eval(save_rflx_misc + save_rflx_item) &
          eval(save_will_misc + save_will_item)  \\
\hline
Sum     & eval(save_fort_base + CON + save_fort_magic + save_fort_misc + save_fort_item) &
          eval(save_rflx_base + DEX + save_rflx_magic + save_rflx_misc + save_rflx_item) &
          eval(save_will_base + WIS + save_will_magic + save_will_misc + save_will_item) \\
\hline
\end{tabularx}
%
\\[1ex]
%
\begin{tabularx}{2.2cm}[t]{|Y|r|}
\hline
\multicolumn{2}{|c|}{\textbf{Speed}}\\
\hline
Base  & char_speed_base\aps\\
Misc  & char_speed_misc\aps\\
\hline
Limit & ifelse(char_speed_limit,,--,char_speed_limit\aps)\\
\hline \hline
Speed & char_speed\aps\\
\hline
Max   & $\times$char_speed_max\\
\hline
\end{tabularx}%
%
\hfill%
%
\begin{tabularx}{1.9cm}[t]{|Y|r|}
\hline
\multicolumn{2}{|c|}{\textbf{Initiative}}\\
\hline
D{}E{}X & DEX\\
Misc    & init_misc\\
\hline
Sum     & \makebox[1em][r]{eval(DEX + init_misc)}\\
\hline \hline
\multicolumn{2}{|c|}{\textbf{Sp.Resist.}}\\
\hline
\multicolumn{2}{|c|}{char_spell_resistance}\\
\hline
\end{tabularx}%
\end{minipage}
%
\hfill
%
\begin{tabular}[t]{|c|r|}
\hline
\multicolumn{2}{|c|}{\textbf{AC}} \\ 
\hline
Base    & 10         \\
Armor   & AC_armor   \\
Shield  & AC_shield  \\
D{}E{}X & AC_DEX     \\% it's not purely DEX, because this can be lowered by armor and load, PHB p.122ff. and 161ff.
Size    & eval(stat_size_AC_mod(stat_size)) \\
Natural & AC_nature  \\
Deflect & AC_deflect \\
Dodge   & AC_dodge   \\
Misc    & AC_misc    \\
\hline
Sum     & eval(10 + AC_armor + AC_shield + AC_DEX + stat_size_AC_mod(stat_size) + AC_nature + AC_deflect + AC_dodge + AC_misc)\\
\hline \hline
Touch   & eval(10                        + AC_DEX + stat_size_AC_mod(stat_size)             + AC_deflect + AC_dodge + AC_misc)\\
Flat    & eval(10 + AC_armor + AC_shield          + stat_size_AC_mod(stat_size) + AC_nature + AC_deflect            + AC_misc)\\
\hline
\end{tabular}

\begin{boxedminipage}[t]{\textwidth}
ifelse(show_special_notes,,,show_special_notes \\[0.5ex])%
%
Experience Points: char_EP{}ifelse(level_sub_count,0,,\hspace*{1cm}(--eval(20 * level_sub_count)\%))\\[0.5ex]
%
Level: level_total{}ifelse(eval(char_EP >= calc_EP(eval(level_total + level_adjustment + 1))), 1, `+') dnl
ifelse(level_adjustment,0,,\hspace*{3ex} ECL: eval(level_total + level_adjustment)) dnl
\hspace*{3ex} Classes: char_professions
\end{boxedminipage}
%
\begin{multicols}{2}
\begin{boxedminipage}[t]{\linewidth}
skill_line_head
skill_line(Appraise,                  `INT', `appraise',                0, 1, 0)
skill_line(Balance,                   `DEX', `balance',                 1, 1, 1)
skill_line(Bluff,                     `CHA', `bluff',                   0, 1, 0)
skill_line(Climb,                     `STR', `climb',                   1, 1, 1)
skill_line(Concentration,             `CON', `concentration',           0, 1, 0)
skill_line(Craft (Alchemy),           `INT', `craft_alchemy',           0, 1, 0)
skill_line(Craft (Armor Smithing),    `INT', `craft_armor_smithing',    0, 1, 0)
skill_line(Craft (Basket Weaving),    `INT', `craft_basket_weaving',    0, 1, 0)
skill_line(Craft (Book Binding),      `INT', `craft_book_binding',      0, 1, 0)
skill_line(Craft (Bow Making),        `INT', `craft_bow_making',        0, 1, 0)
skill_line(Craft (Blacksmithing),     `INT', `craft_blacksmithing',     0, 1, 0)
skill_line(Craft (Calligraphy),       `INT', `craft_calligraphy',       0, 1, 0)
skill_line(Craft (Carpentry),         `INT', `craft_carpentry',         0, 1, 0)
skill_line(Craft (Cobbling),          `INT', `craft_cobbling',          0, 1, 0)
skill_line(Craft (Gem Cutting),       `INT', `craft_gem_cutting',       0, 1, 0)
skill_line(Craft (Instrument Making), `INT', `craft_instrument_making', 0, 1, 0)
skill_line(Craft (Leather Working),   `INT', `craft_leather_working',   0, 1, 0)
skill_line(Craft (Lock Smithing),     `INT', `craft_lock_smithing',     0, 1, 0)
skill_line(Craft (Painting),          `INT', `craft_painting',          0, 1, 0)
skill_line(Craft (Pottery),           `INT', `craft_pottery',           0, 1, 0)
skill_line(Craft (Sculpting),         `INT', `craft_sculpting',         0, 1, 0)
skill_line(Craft (Ship Making),       `INT', `craft_ship_making',       0, 1, 0)
skill_line(Craft (Stone Masonry),     `INT', `craft_stone_masonry',     0, 1, 0)
skill_line(Craft (Toy Making),        `INT', `craft_toy_making',        0, 1, 0)
skill_line(Craft (Trap Making),       `INT', `craft_trap_making',       0, 1, 0)
skill_line(Craft (Weapon Smithing),   `INT', `craft_weapon_smithing',   0, 1, 0)
skill_line(Craft (Weaving),           `INT', `craft_weaving',           0, 1, 0)
skill_line(Craft (Woodworking),       `INT', `craft_woodworking',       0, 1, 0)
skill_line(Decipher Script,         `INT', `decipher_script',       0, 0, 0)
skill_line(Diplomacy,               `CHA', `diplomacy',             0, 1, 0)
skill_line(Disable Device,          `INT', `disable_device',        0, 0, 0)
skill_line(Disguise,                `CHA', `disguise',              0, 1, 0)
skill_line(Escape Artist,           `DEX', `escape_artist',         1, 1, 1)
skill_line(Forgery,                 `INT', `forgery',               0, 1, 0)
skill_line(Gather Information,      `CHA', `gather_info',           0, 1, 0)
skill_line(Handle Animal,           `CHA', `handle_animal',         0, 0, 0)
skill_line(Heal,                    `WIS', `heal',                  0, 1, 0)
skill_line(Hide,                    `DEX', `hide',                  1, 1, 1)
skill_line(Intimidate,              `CHA', `intimidate',            0, 1, 0)
skill_line(Jump,                    `STR', `jump',                  1, 1, 1)
skill_line(Knowledge (Arcana),      `INT', `knowledge_arcana',      0, 0, 0)
skill_line(Knowledge (Engineer),    `INT', `knowledge_engineer',    0, 0, 0)
skill_line(Knowledge (Dungeon),     `INT', `knowledge_dungeon',     0, 0, 0)
skill_line(Knowledge (Geography),   `INT', `knowledge_geography',   0, 0, 0)
skill_line(Knowledge (History),     `INT', `knowledge_history',     0, 0, 0)
skill_line(Knowledge (Local),       `INT', `knowledge_local',       0, 0, 0)
skill_line(Knowledge (Nature),      `INT', `knowledge_nature',      0, 0, 0)
skill_line(Knowledge (Nobility),    `INT', `knowledge_nobility',    0, 0, 0)
skill_line(Knowledge (Religion),    `INT', `knowledge_religion',    0, 0, 0)
skill_line(Knowledge (Planes),      `INT', `knowledge_planes',      0, 0, 0)
skill_line(Listen,                  `WIS', `listen',                0, 1, 0)
skill_line(Move Silently,           `DEX', `move_silently',         1, 1, 1)
skill_line(Open Lock,               `DEX', `open_lock',             0, 0, 1)
skill_line(Perform (Act),           `CHA', `perform_act',           0, 0, 0)
skill_line(Perform (Comedy),        `CHA', `perform_comedy',        0, 0, 0)
skill_line(Perform (Dance),         `CHA', `perform_dance',         0, 0, 0)
skill_line(Perform (Keyboard),      `CHA', `perform_keyboard',      0, 0, 0)
skill_line(Perform (Oratory),       `CHA', `perform_oratory',       0, 0, 0)
skill_line(Perform (Percussion),    `CHA', `perform_percussion',    0, 0, 0)
skill_line(Perform (Sing),          `CHA', `perform_sing',          0, 0, 0)
skill_line(Perform (String),        `CHA', `perform_string',        0, 0, 0)
skill_line(Perform (Wind),          `CHA', `perform_wind',          0, 0, 0)
skill_line(Profession (Apothecary), `WIS', `prof_apothecary',       0, 0, 0)
skill_line(Profession (Bookkeeper), `WIS', `prof_bookkeeper',       0, 0, 0)
skill_line(Profession (Cook),       `WIS', `prof_cook',             0, 0, 0)
skill_line(Profession (Counselor),  `WIS', `prof_counselor',        0, 0, 0)
skill_line(Profession (Herbalist),  `WIS', `prof_herbalist',        0, 0, 0)
skill_line(Profession (Hunter),     `WIS', `prof_hunter',           0, 0, 0)
skill_line(Profession (Innkeeper),  `WIS', `prof_innkeeper',        0, 0, 0)
skill_line(Profession (Librarian),  `WIS', `prof_librarian',        0, 0, 0)
skill_line(Profession (Merchant),   `WIS', `prof_merchant',         0, 0, 0)
skill_line(Profession (Sailor),     `WIS', `prof_sailor',           0, 0, 0)
skill_line(Profession (Scribe),     `WIS', `prof_scribe',           0, 0, 0)
skill_line(Ride,                    `DEX', `ride',                  0, 1, 1)
skill_line(Search,                  `INT', `search',                0, 1, 0)
skill_line(Sense Motive,            `WIS', `sense_motive',          0, 1, 0)
skill_line(Sleight of Hand,         `DEX', `sleight_of_hand',       1, 0, 1)
skill_line(Spellcraft,              `INT', `spellcraft',            0, 0, 0)
skill_line(Spot,                    `WIS', `spot',                  0, 1, 0)
skill_line(Survival,                `WIS', `survival',              0, 1, 0)
skill_line(Swim,                    `STR', `swim',                  2, 1, 1)
skill_line(Tumble,                  `DEX', `tumble',                1, 0, 1)
skill_line(Use Magic Device,        `CHA', `use_magic_device',      0, 0, 0)
skill_line(Use Rope,                `DEX', `use_rope',              0, 1, 1)
{\scriptsize (Maximum ranks for class and cross-class skills: eval(level_total + 3) and eval((level_total + 3) / 2))}
\end{boxedminipage}

%\hfill

%\begin{minipage}[t]{0.48\textwidth}
%
\begin{tabularx}{\linewidth}[t]{|c||Y||Y|Y|Y|}
\hline
\textbf{Load Statistics} & current & light & medium & heavy \\ \hline
lbs. & %
       eval(weight_total        / 45360) & %
$\le${}eval(weight_limit_light  / 45360) & %
$\le${}eval(weight_limit_medium / 45360) & %
$\le${}eval(weight_limit_max    / 45360) \\ \hline
\end{tabularx}\\[1ex]
dnl spell-info %
dnl spell-info % ***** the spell data ...
dnl spell-info %
dnl spell-info \small% avoid overfull lines
dnl spell-info %
dnl spell-info ifelse(eval(level_bard > 0), 1, dnl
dnl spell-info   \begin{tabular}[t]{|l|*{7}{c}|}
dnl spell-info   \hline
dnl spell-info   \multicolumn{8}{|l|}{\textbf{Bard Spells}\hfill Spell Failure: arcane_error\%} \\
dnl spell-info   \hline
dnl spell-info   spell level & 0 & 1 & 2 & 3 & 4 & 5 & 6 \\
dnl spell-info   \hline
dnl spell-info   spells per day & nz(calc_spells_per_day(bard, 0),--) & nz(calc_spells_per_day(bard, 1),--) & nz(calc_spells_per_day(bard, 2),--) & nz(calc_spells_per_day(bard, 3),--) & nz(calc_spells_per_day(bard, 4),--) & nz(calc_spells_per_day(bard, 5),--) & nz(calc_spells_per_day(bard, 6),--) \\
dnl spell-info %  \hline
dnl spell-info   known spells & ifelse(calc_spells_per_day(bard,0),0,--,known_spells_bard(0)) & ifelse(calc_spells_per_day(bard,1),0,--,known_spells_bard(1)) & ifelse(calc_spells_per_day(bard,2),0,--,known_spells_bard(2)) & ifelse(calc_spells_per_day(bard,3),0,--,known_spells_bard(3)) & ifelse(calc_spells_per_day(bard,4),0,--,known_spells_bard(4)) & ifelse(calc_spells_per_day(bard,5),0,--,known_spells_bard(5)) & ifelse(calc_spells_per_day(bard,6),0,--,known_spells_bard(6)) \\
dnl spell-info %  \hline
dnl spell-info   save DC & eval(10 + CHA) & eval(11 + CHA) & eval(12 + CHA) & eval(13 + CHA) & eval(14 + CHA) & eval(15 + CHA) & eval(16 + CHA) \\
dnl spell-info   \hline
dnl spell-info \end{tabular}\\[2ex])%
dnl spell-info %
dnl spell-info ifelse(eval(level_cleric > 0), 1, dnl
dnl spell-info   \begin{tabular}[t]{|l|*{10}{c}|}
dnl spell-info   \hline
dnl spell-info   \multicolumn{11}{|l|}{\textbf{Cleric Spells}} \\
dnl spell-info   \hline
dnl spell-info   spell level & 0 & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 \\
dnl spell-info   \hline
dnl spell-info   spells per day & nz(calc_spells_per_day(cleric, 0),--) & nz(calc_spells_per_day(cleric, 1),--) & nz(calc_spells_per_day(cleric, 2),--) & nz(calc_spells_per_day(cleric, 3),--) & nz(calc_spells_per_day(cleric, 4),--) & nz(calc_spells_per_day(cleric, 5),--) & nz(calc_spells_per_day(cleric, 6),--) & nz(calc_spells_per_day(cleric, 7),--) & nz(calc_spells_per_day(cleric, 8),--) & nz(calc_spells_per_day(cleric, 9),--) \\
dnl spell-info %  \hline
dnl spell-info   domain spells per day & -- & ifelse(eval(calc_spells_per_day(cleric, 1) > 0),1,1,--) & ifelse(eval(calc_spells_per_day(cleric, 2) > 0),1,1,--) & ifelse(eval(calc_spells_per_day(cleric, 3) > 0),1,1,--) & ifelse(eval(calc_spells_per_day(cleric, 4) > 0),1,1,--) & ifelse(eval(calc_spells_per_day(cleric, 5) > 0),1,1,--) & ifelse(eval(calc_spells_per_day(cleric, 6) > 0),1,1,--) & ifelse(eval(calc_spells_per_day(cleric, 7) > 0),1,1,--) & ifelse(eval(calc_spells_per_day(cleric, 8) > 0),1,1,--) & ifelse(eval(calc_spells_per_day(cleric, 9) > 0),1,1,--) \\
dnl spell-info %  \hline
dnl spell-info   save DC & eval(10 + WIS) & eval(11 + WIS) & eval(12 + WIS) & eval(13 + WIS) & eval(14 + WIS) & eval(15 + WIS) & eval(16 + WIS) & eval(17 + WIS) & eval(18 + WIS) & eval(19 + WIS) \\
dnl spell-info   \hline
dnl spell-info \end{tabular}\\[2ex])%
dnl spell-info %
dnl spell-info ifelse(eval(level_druid > 0), 1, dnl
dnl spell-info { \normalsize
dnl spell-info   \begin{tabular}[t]{|l|*{10}{c}|}
dnl spell-info   \hline
dnl spell-info   \multicolumn{11}{|l|}{\textbf{Druid Spells}} \\
dnl spell-info   \hline
dnl spell-info   spell level & 0 & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 \\
dnl spell-info   \hline
dnl spell-info   spells per day & nz(calc_spells_per_day(druid, 0),--) & nz(calc_spells_per_day(druid, 1),--) & nz(calc_spells_per_day(druid, 2),--) & nz(calc_spells_per_day(druid, 3),--) & nz(calc_spells_per_day(druid, 4),--) & nz(calc_spells_per_day(druid, 5),--) & nz(calc_spells_per_day(druid, 6),--) & nz(calc_spells_per_day(druid, 7),--) & nz(calc_spells_per_day(druid, 8),--) & nz(calc_spells_per_day(druid, 9),--) \\
dnl spell-info %  \hline
dnl spell-info   save DC & eval(10 + WIS) & eval(11 + WIS) & eval(12 + WIS) & eval(13 + WIS) & eval(14 + WIS) & eval(15 + WIS) & eval(16 + WIS) & eval(17 + WIS) & eval(18 + WIS) & eval(19 + WIS) \\
dnl spell-info   \hline
dnl spell-info \end{tabular}}\\[2ex])%
dnl spell-info %
dnl spell-info ifelse(eval(level_paladin > 0), 1, dnl
dnl spell-info   \begin{tabular}[t]{|l|*{4}{c}|}
dnl spell-info   \hline
dnl spell-info   \multicolumn{5}{|l|}{\textbf{Paladin Spells}} \\
dnl spell-info   \hline
dnl spell-info   spell level & 1 & 2 & 3 & 4 \\
dnl spell-info   \hline
dnl spell-info   spells per day & nz(calc_spells_per_day(paladin,1),--) & nz(calc_spells_per_day(paladin,2),--) & nz(calc_spells_per_day(paladin,3),--) & nz(calc_spells_per_day(paladin,4),--) \\
dnl spell-info %  \hline
dnl spell-info   save DC & eval(11 + WIS) & eval(12 + WIS) & eval(13 + WIS) & eval(14 + WIS) \\
dnl spell-info   \hline
dnl spell-info \end{tabular}\\[2ex])%
dnl spell-info %
dnl spell-info ifelse(eval(level_ranger > 0), 1, dnl
dnl spell-info   \begin{tabular}[t]{|l|*{4}{c}|}
dnl spell-info   \hline
dnl spell-info   \multicolumn{5}{|l|}{\textbf{Ranger Spells}} \\
dnl spell-info   \hline
dnl spell-info   spell level & 1 & 2 & 3 & 4 \\
dnl spell-info   \hline
dnl spell-info   spells per day & nz(calc_spells_per_day(ranger,1),--) & nz(calc_spells_per_day(ranger,2),--) & nz(calc_spells_per_day(ranger,3),--) & nz(calc_spells_per_day(ranger,4),--) \\
dnl spell-info   \hline
dnl spell-info   save DC & eval(11 + WIS) & eval(12 + WIS) & eval(13 + WIS) & eval(14 + WIS) \\
dnl spell-info   \hline
dnl spell-info \end{tabular}\\[2ex])%
dnl spell-info %
dnl spell-info ifelse(eval(level_sorcerer > 0), 1, dnl
dnl spell-info   \begin{tabular}[t]{|l|*{10}{c}|}
dnl spell-info   \hline
dnl spell-info   \multicolumn{11}{|l|}{\textbf{Sorcerer Spells}\hfill Spell Failure: arcane_error\%} \\
dnl spell-info   \hline
dnl spell-info   spell level & 0 & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 \\
dnl spell-info   \hline
dnl spell-info   spells per day & nz(calc_spells_per_day(sorcerer, 0),--) & nz(calc_spells_per_day(sorcerer, 1),--) & nz(calc_spells_per_day(sorcerer, 2),--) & nz(calc_spells_per_day(sorcerer, 3),--) & nz(calc_spells_per_day(sorcerer, 4),--) & nz(calc_spells_per_day(sorcerer, 5),--) & nz(calc_spells_per_day(sorcerer, 6),--) & nz(calc_spells_per_day(sorcerer, 7),--) & nz(calc_spells_per_day(sorcerer, 8),--) & nz(calc_spells_per_day(sorcerer, 9),--) \\
dnl spell-info %  \hline
dnl spell-info   known spells & nz(known_spells_sorcerer(0),--) & nz(known_spells_sorcerer(1),--) & nz(known_spells_sorcerer(2),--) & nz(known_spells_sorcerer(3),--) & nz(known_spells_sorcerer(4),--) & nz(known_spells_sorcerer(5),--) & nz(known_spells_sorcerer(6),--) & nz(known_spells_sorcerer(7),--) & nz(known_spells_sorcerer(8),--) & nz(known_spells_sorcerer(9),--) \\
dnl spell-info %  \hline
dnl spell-info   save DC & eval(10 + CHA) & eval(11 + CHA) & eval(12 + CHA) & eval(13 + CHA) & eval(14 + CHA) & eval(15 + CHA) & eval(16 + CHA) & eval(17 + CHA) & eval(18 + CHA) & eval(19 + CHA) \\
dnl spell-info   \hline
dnl spell-info \end{tabular}\\[2ex])%
dnl spell-info %
dnl spell-info ifelse(eval(level_wizard > 0), 1, dnl
dnl spell-info   \begin{tabular}[t]{|l|*{10}{c}|}
dnl spell-info   \hline
dnl spell-info   \multicolumn{11}{|l|}{\textbf{Wizard Spells}\hfill Spell Failure: arcane_error\%} \\
dnl spell-info   \hline
dnl spell-info   spell level & 0 & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 \\
dnl spell-info   \hline
dnl spell-info   spells per day & nz(calc_spells_per_day(wizard, 0),--) & nz(calc_spells_per_day(wizard, 1),--) & nz(calc_spells_per_day(wizard, 2),--) & nz(calc_spells_per_day(wizard, 3),--) & nz(calc_spells_per_day(wizard, 4),--) & nz(calc_spells_per_day(wizard, 5),--) & nz(calc_spells_per_day(wizard, 6),--) & nz(calc_spells_per_day(wizard, 7),--) & nz(calc_spells_per_day(wizard, 8),--) & nz(calc_spells_per_day(wizard, 9),--) \\
dnl spell-info   save DC & eval(10 + INT) & eval(11 + INT) & eval(12 + INT) & eval(13 + INT) & eval(14 + INT) & eval(15 + INT) & eval(16 + INT) & eval(17 + INT) & eval(18 + INT) & eval(19 + INT) \\
dnl spell-info   \hline
dnl spell-info \end{tabular}\\[2ex])%
dnl spell-info \normalsize
%
ifelse(eval((level_cleric > 0)  ||  (level_paladin > 3)), 1, `dnl
define(`turning_level', eval(calc_max(level_cleric, eval(level_paladin - 3)) + ifdef(`feat_improved_turning',1,0)))dnl
define(`turning_CHA', eval(CHA + ifelse(eval(rank_knowledge_religion >= 5),1,2,0)))dnl
\begin{boxedminipage}[t]{\linewidth}
	\underline{\textbf{ifelse(char_turn_polarity,1,Turn and Destroy,Rebuke and Command) Undead:}}\hspace*{0.5cm}{\tiny (PHB p.159f.)}\\
	\begin{tabular}[t]{l@{ : }l}
		uses per day        & eval(3 + CHA + (4 * ifdef(`feat_extra_turning',feat_extra_turning,0))) \\
		range / aiming      & 60~ft, closest first, need li{}ne of effect \\
		highest HD affected & apply 1D20{}emph_sign(turning_CHA) to table below \\
		total HD affected   & 2D6+eval(turning_level + CHA) \\
		highest HD ifelse(char_turn_polarity,1,destroyed,commanded) & eval(turning_level / 2) \\
	\end{tabular}
	\\[0.5ex]
%	\setlength{\tabcolsep}{0.75\tabcolsep}
	\begin{tabular}[t]{|c||*{ifelse(dnl
eval((turning_level >= 5) && (1 + turning_CHA <=  0)),1,9,dnl
eval((turning_level >= 4) && (1 + turning_CHA <=  3)),1,8,dnl
eval((turning_level >= 3) && (1 + turning_CHA <=  6)),1,7,dnl
eval((turning_level >= 2) && (1 + turning_CHA <=  9)),1,6,dnl
eval((turning_level >= 1) && (1 + turning_CHA <= 12)),1,5,4)}{c|}}
 	\hline
	Roll & %
	ifelse(eval((turning_level >= 5) && (1 + turning_CHA <=  0)),1,$\le${}0 &) %
	ifelse(eval((turning_level >= 4) && (1 + turning_CHA <=  3)),1,ifelse(eval((turning_level >= 5) && (1 + turning_CHA <=  0)),1, 1-3 ,$\le${}3 ) &) %
	ifelse(eval((turning_level >= 3) && (1 + turning_CHA <=  6)),1,ifelse(eval((turning_level >= 4) && (1 + turning_CHA <=  3)),1, 4-6 ,$\le${}6 ) &) %
	ifelse(eval((turning_level >= 2) && (1 + turning_CHA <=  9)),1,ifelse(eval((turning_level >= 3) && (1 + turning_CHA <=  6)),1, 7-9 ,$\le${}9 ) &) %
	ifelse(eval((turning_level >= 1) && (1 + turning_CHA <= 12)),1,ifelse(eval((turning_level >= 2) && (1 + turning_CHA <=  9)),1,10-12,$\le${}12) &) %
	                                                               ifelse(eval((turning_level >= 1) && (1 + turning_CHA <= 12)),1,13-15,$\le${}15) &  %
	16-18 & 19-21 & $\ge${}22 \\ \hline
	HD & %
	ifelse(eval((turning_level >= 5) && (1 + turning_CHA <=  0)),1,eval(turning_level - 4) &) %
	ifelse(eval((turning_level >= 4) && (1 + turning_CHA <=  3)),1,eval(turning_level - 3) &) %
	ifelse(eval((turning_level >= 3) && (1 + turning_CHA <=  6)),1,eval(turning_level - 2) &) %
	ifelse(eval((turning_level >= 2) && (1 + turning_CHA <=  9)),1,eval(turning_level - 1) &) %
	ifelse(eval((turning_level >= 1) && (1 + turning_CHA <= 12)),1,eval(turning_level    ) &) %
	eval(turning_level + 1) & %
	eval(turning_level + 2) & %
	eval(turning_level + 3) & %
	eval(turning_level + 4) \\
	\hline
  	\end{tabular}
\end{boxedminipage}\\[2ex]')%
%
ifelse(show_turning_abilities,,, show_turning_abilities)%
%
ifelse(show_special_abilities,,, \textbf{\underline{Special Abilities}:}show_special_abilities\\[1ex])%
%
ifelse(show_feats,,, \textbf{\underline{Feats}:}show_feats\\[1ex])%
%
ifelse(show_skill_synergies,,, \textbf{\underline{Skill Synergies}:} (manual attention only)show_skill_synergies\\[1ex])%
%
\textbf{\underline{Languages}:}\\ char_languages\\[1ex]
%
\begin{boxedminipage}[t]{\linewidth}
\textbf{\underline{Attack Boni}:} \\
\makebox[ifelse(eval(level_monk > 0),1,20,12)ex][l]{Base Normal}: bonus_attack_base_cascade(bonus_attack_base, eval(bonus_attack_base_mod + bonus_attack_epic))%
ifelse(eval(level_monk > 0),1,`dnl
define(`flurry_of_blows_mod', ifelse(eval(level_monk <= 4),1,-2,eval(level_monk <= 8),1,-1,0))dnl
\\{}\makebox[20ex][l]{Base Flurry of Blows}: %
                                 emph_sign(eval(bonus_attack_base + bonus_attack_base_mod + flurry_of_blows_mod + bonus_attack_epic))`/'dnl
ifelse(eval(level_monk >= 11),1, emph_sign(eval(bonus_attack_base + bonus_attack_base_mod + flurry_of_blows_mod + bonus_attack_epic))`/')dnl
bonus_attack_base_cascade(bonus_attack_base, eval(bonus_attack_base_mod + flurry_of_blows_mod + bonus_attack_epic))')%
ifelse(flag_show_two_weapon_mod,1,dnl
\\[0.5ex] %
\textbf{\underline{Two-Weapon-Modifiers}:} \\ % PHB p.160
\makebox[21ex][l]{off-hand weapon light}: %
    primary \makebox[1.5em][r]{ifdef(`feat_two_weapon_fighting',--2,--4)}\komma \hspace*{2ex} %
    off     \makebox[1.5em][r]{ifdef(`feat_two_weapon_fighting',--2,--8)}\\
\makebox[21ex][l]{otherwise}: %
    primary \makebox[1.5em][r]{ifdef(`feat_two_weapon_fighting',--4,--6)}\komma \hspace*{2ex} %
    off     \makebox[1.5em][r]{ifdef(`feat_two_weapon_fighting',--4,--10)})%
\end{boxedminipage}
\\[1ex]
char_weapons
%\end{minipage}
\end{multicols}
%

%
ifelse(char_attach_supplement,0,,`include(`char_'char_filename`.inc')')%
ifelse(eval(level_druid >= 5),1,`wild_shape_table')%
%
%
ifelse(char_attach_units,0,,`dnl
\vfill
\begin{tabular}[t]{|r@{ }l|r@{ }l|}
\hline
\multicolumn{4}{|c|}{Units} \\
\hline \hline
1 & inch        & 2.54    & cm \\
1 & foot        & 0.3048  & m \\
1 & mile        & 1.609   & km \\
\hline
1 & square inch & 6.4516  & cm${}^2$ \\
1 & square foot & 0.0929  & m${}^2$ \\
1 & square mile & 2.5889  & km${}^2$ \\
\hline
1 & cubic inch  & 16.39   & cm${}^3$ \\
1 & cubic foot  & 0.02832 & m${}^3$ \\
\hline
1 & ounce       & 28.35   & g \\
1 & pound       & 0.4536  & kg \\
\hline
T & ${}^\circ$F & $\frac{5}{9} \left( T - 32 \right)$ & ${}^\circ$C \\
T & ${}^\circ$C & $\left( \frac{9}{5} T \right) + 32$ & ${}^\circ$F \\
\hline
1 & gallon (US)	& 3.785	  & l \\
1 & gallon (UK)	& 4.546	  & l \\
1 & fluid ounce	& 28.41	  & cm${}^3$ \\
\hline
\end{tabular}')%
%
\mbox{}
\label{ref_last_page}
\end{document}
