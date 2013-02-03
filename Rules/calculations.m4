

dnl ***** abbreviations used:
dnl ***** PHB = Player's Handbook
dnl ***** DMG = Dungeon Master's Guide
dnl ***** MOM = Monster Manual
dnl ***** MOW = Masters of the Wild
dnl ***** ELH = Epic Level Handbook


define(`downcase', `translit($1, `ABCDEFGHIJKLMNOPQRSTUVWXYZ', `abcdefghijklmnopqrstuvwxyz')')


dnl
dnl ***** first get information about the chosen race
dnl
include(`races.m4')



dnl ***** calculate the height of the character from feet & inch to cm
define(`calc_height', `regexp($1, ^\([0-9]+\) *\([0-9]+\)$, `eval(((12 * \1 + \2) * 254 + 50) / 100)')')


dnl ***** check and parse alignment
ifelse(char_alignment,LG,,char_alignment,NG,,char_alignment,CG,,char_alignment,LN,,char_alignment,N,,char_alignment,CN,,char_alignment,LE,,char_alignment,NE,,char_alignment,CE,,dnl
downcase(char_alignment),neutral,,dnl
regexp(char_alignment, `^[^-]+ *- *[^-]+$'),-1,`error(unknown alignment: char_alignment)',dnl
regexp(downcase(char_alignment), `^\(.+\) *- *\(.+\)$', dnl
  `ifelse(\1,lawful,,\1,neutral,,\1,chaotic,,`error(unknown alignment component: \1)')ifelse(\2,good,,\2,neutral,,\2,evil,,`error(unknown alignment component: \2)')'))
define(`alignment_LC', ifelse(regexp(downcase(char_alignment),`^\(.+\) *- *.+$', \1),lawful,L,regexp(downcase(char_alignment),`^\(.+\) *- *.+$', \1),chaotic,C,N))
define(`alignment_GE', ifelse(regexp(downcase(char_alignment),`^.+ *- *\(.+\)$', \1),  good,G,regexp(downcase(char_alignment),`^.+ *- *\(.+\)$', \1),   evil,E,N))


dnl ***** check school of magic
dnl argument: list of schools of magic
define(`check_magic_school_single', `eval(regexp(Abjr Conj Divn Ench Evoc Ills Necr Trns, `\<$1\>') >= 0)')
define(`check_magic_school', `patsubst($1, `\<\([^ ]*\)\>', `ifelse(check_magic_school_single(\1),0,`error(unknown school of magic: \1)')')')


dnl ***** calculate the maximum / minimum of the given values, empty arguments ignored
define(`calc_max', `ifelse(dnl
$#,0,,dnl
$#,1,``$1'',dnl
$#,2,`ifelse($1,,``$2'',$2,,``$1'',`ifelse(eval($1 > $2),1,`$1',`$2')')',dnl
$1,,`calc_max(shift($@))',dnl
$2,,`calc_max(`$1',shift(shift($@)))',dnl
`calc_max(ifelse($1,,``$2'',$2,,``$1'',`ifelse(eval($1 > $2),1,`$1',`$2')'),shift(shift($@)))'dnl
)')dnl

define(`calc_min', `ifelse(dnl
$#,0,,dnl
$#,1,``$1'',dnl
$#,2,`ifelse($1,,``$2'',$2,,``$1'',`ifelse(eval($1 < $2),1,`$1',`$2')')',dnl
$1,,`calc_min(shift($@))',dnl
$2,,`calc_min(`$1',shift(shift($@)))',dnl
`calc_min(ifelse($1,,``$2'',$2,,``$1'',`ifelse(eval($1 < $2),1,`$1',`$2')'),shift(shift($@)))'dnl
)')dnl


dnl ***** Mittelung beliebig vieler Argumente
define(`average_collect', `ifelse($#, 0, , $#, 1, `ifelse($1,`',0,$1)', `ifelse($1,`',0,$1) + average_collect(shift($@))')')
define(`average_count', `ifelse($#, 0, , $#, 1, `ifelse($1,`',0,1)', `ifelse($1,`',0,1) + average_count(shift($@))')')
define(`average_calc', `ifelse(eval($2 < 1),1,0,`ifelse(eval($1 >= 0),1, eval(($1 + $2 / 2) / $2), eval(($1 - $2 / 2) / $2))')')
define(`average', `average_calc(eval(average_collect($@)), eval(average_count($@)))')


dnl ***** emphasise signs
dnl
dnl lets LaTeX print a longer minus sign or to give a plus sign
dnl arguments: number to evaluate, flag (== 1   =>   produce no output in case of zero)
define(`emph_sign', `ifelse(eval($1 > 0), 1, `+$1', eval($1 < 0), 1, `-$1', ifelse($2,1,,${}\pm${}0))')


dnl ***** don't show zero, instead give back the second argument (empty if undefined)
define(`nz', `ifelse(eval($1 == 0), 1, $2, $1)')


dnl ***** calculate the number of experience points needed for given level
define(`calc_EP', `eval($1 * ($1 - 1) * 500)')


dnl ***** calculate EP penalties due to unbalanced multiclass levels, see PHB, p.60
define(`level_list_component', `ifelse(eval(level_$1 > 0),0,,regexp(favored_class,`\<'$1`\>'),-1,level_$1` ')')
define(`level_list', dnl list all existing and non-favored classes (space-separated)
level_list_component(barbarian)dnl
level_list_component(bard)dnl
level_list_component(cleric)dnl
level_list_component(druid)dnl
level_list_component(fighter)dnl
level_list_component(monk)dnl
level_list_component(paladin)dnl
level_list_component(ranger)dnl
level_list_component(rogue)dnl
level_list_component(sorcerer)dnl
level_list_component(wizard)dnl
level_list_component(divineagent)dnl
level_list_component(horizonwalker)dnl
level_list_component(shadowcaster)dnl
level_list_component(shifter)dnl
level_list_component(templeraider)dnl
level_list_component(rimefirewitch)dnl
level_list_component(outsider))
dnl transform to comma-separated and calculate maximum level
define(`level_max', calc_max(patsubst(regexp(level_list, `^\(.*\) $', `\1'), ` ', `,')))
dnl for races that feature no specific favored class (e.g. human and half-elf) remove the highest level and re-calculate
ifelse(favored_class,any, `define(`level_list', regexp(level_list, `^\(.*\)'\<level_max\> `\(.*\)$', `\1\2'))')
define(`level_max', calc_max(patsubst(regexp(level_list, `^\(.*\) $', `\1'), ` ', `,')))
dnl count all levels that are more than one step below maximum
define(`level_sub_check', `ifelse($#,0,,$1,,,`ifelse(eval($1 < level_max - 1),1,1,0)`+'level_sub_check(shift($@))')')
define(`level_sub_count', eval(level_sub_check(patsubst(regexp(level_list, `^\(.*\) $', `\1'), ` ', `,'))0))


dnl ***** calculate the total level of the character
define(`level_total', eval(dnl
level_barbarian     + dnl
level_bard          + dnl
level_cleric        + dnl
level_druid         + dnl
level_fighter       + dnl
level_monk          + dnl
level_paladin       + dnl
level_ranger        + dnl
level_rogue         + dnl
level_sorcerer      + dnl
level_wizard        + dnl
level_divineagent   + dnl
level_horizonwalker + dnl
level_shadowcaster  + dnl
level_shifter       + dnl
level_templeraider  + dnl
level_rimefirewitch + dnl
level_outsider))

ifdef(`active_epic',,`dnl
define(`level_preepic_barbarian',         level_barbarian)dnl
define(`level_preepic_bard',                   level_bard)dnl
define(`level_preepic_cleric',               level_cleric)dnl
define(`level_preepic_druid',                 level_druid)dnl
define(`level_preepic_fighter',             level_fighter)dnl
define(`level_preepic_monk',                   level_monk)dnl
define(`level_preepic_paladin',             level_paladin)dnl
define(`level_preepic_ranger',               level_ranger)dnl
define(`level_preepic_rogue',                 level_rogue)dnl
define(`level_preepic_sorcerer',           level_sorcerer)dnl
define(`level_preepic_wizard',               level_wizard)dnl
define(`level_preepic_divineagent',     level_divineagent)dnl
define(`level_preepic_horizonwalker', level_horizonwalker)dnl
define(`level_preepic_shadowcaster',   level_shadowcaster)dnl
define(`level_preepic_shifter',             level_shifter)dnl
define(`level_preepic_templeraider',   level_templeraider)dnl
define(`level_preepic_rimefirewitch', level_rimefirewitch)dnl
define(`level_preepic_outsider',           level_outsider)dnl
')

define(`level_epic', eval(dnl
level_total                 - dnl
level_preepic_barbarian     - dnl
level_preepic_bard          - dnl
level_preepic_cleric        - dnl
level_preepic_druid         - dnl
level_preepic_fighter       - dnl
level_preepic_monk          - dnl
level_preepic_paladin       - dnl
level_preepic_ranger        - dnl
level_preepic_rogue         - dnl
level_preepic_sorcerer      - dnl
level_preepic_wizard        - dnl
level_preepic_divineagent   - dnl
level_preepic_horizonwalker - dnl
level_preepic_shadowcaster  - dnl
level_preepic_shifter       - dnl
level_preepic_templeraider  - dnl
level_preepic_rimefirewitch - dnl
level_preepic_outsider))


dnl ***** calculate the ability modifier from its ability score, PHB: Table 1-1, p. 8
define(`calc_ability_mod', `ifelse(eval($1 >= 10), 1, eval(($1 - 10) / 2), eval(($1 - 11) / 2))')
dnl
define(`STR', calc_ability_mod(eval(STR_score + STR_scdam + STR_scitm)))
define(`DEX', calc_ability_mod(eval(DEX_score + DEX_scdam + DEX_scitm)))
define(`CON', calc_ability_mod(eval(CON_score + CON_scdam + CON_scitm)))
define(`INT', calc_ability_mod(eval(INT_score + INT_scdam + INT_scitm)))
define(`WIS', calc_ability_mod(eval(WIS_score + WIS_scdam + WIS_scitm)))
define(`CHA', calc_ability_mod(eval(CHA_score + CHA_scdam + CHA_scitm)))


dnl ***** modify the hitpoints by Constitution modifier
define(`char_HP', eval(char_HP + level_total * CON))


dnl ***** calculate the size modifiers for different occasions
define(`stat_size_hide_mod', `ifelse($1,fine,+16, $1,diminutive,+12, $1,tiny,+8, $1,small,+4, $1,medium,0, $1,large,-4, $1,huge,-8, $1,gargantuan,-12, $1,colossal,-16, `error(unknown size for hide modifier: $1)')')dnl PHB p.76
define(`stat_size_attack_mod', `ifelse($1,fine,+8, $1,diminutive,+4, $1,tiny,+2, $1,small,+1, $1,medium,0, $1,large,-1, $1,huge,-2, $1,gargantuan,-4, $1,colossal,-8, `error(unknown size for attack modifier: $1)')')dnl PHB p.134
define(`stat_size_AC_mod', `stat_size_attack_mod($1)')dnl PHB p.136
define(`stat_size_grapple_mod', `ifelse($1,fine,-16, $1,diminutive,-12, $1,tiny,-8, $1,small,-4, $1,medium,0, $1,large,+4, $1,huge,+8, $1,gargantuan,+12, $1,colossal,+16, `error(unknown size for grapple modifier: $1)')')dnl PHB p.156
define(`stat_size_bullrush_mod', `ifelse($1,fine,-16, $1,diminutive,-12, $1,tiny,-8, $1,small,-4, $1,medium,0, $1,large,+4, $1,huge,+8, $1,gargantuan,+12, $1,colossal,+16, `error(unknown size for bullrush modifier: $1)')')dnl PHB p.154


dnl ***** produce a string of all professions (i.e. classes)
define(`char_professions', regexp(dnl
ifelse(eval(level_barbarian     > 0), 1,      Barbarian(level_barbarian)) dnl
ifelse(eval(level_bard          > 0), 1,           Bard(level_bard)) dnl
ifelse(eval(level_cleric        > 0), 1,         Cleric(level_cleric)) dnl
ifelse(eval(level_druid         > 0), 1,          Druid(level_druid)) dnl
ifelse(eval(level_fighter       > 0), 1,        Fighter(level_fighter)) dnl
ifelse(eval(level_monk          > 0), 1,           Monk(level_monk)) dnl
ifelse(eval(level_paladin       > 0), 1,        Paladin(level_paladin)) dnl
ifelse(eval(level_ranger        > 0), 1,         Ranger(level_ranger)) dnl
ifelse(eval(level_rogue         > 0), 1,          Rogue(level_rogue)) dnl
ifelse(eval(level_sorcerer      > 0), 1,       Sorcerer(level_sorcerer)) dnl
ifelse(eval(level_wizard        > 0), 1,         Wizard(level_wizard)) dnl
ifelse(eval(level_divineagent   > 0), 1,   Divine Agent(level_divineagent)) dnl
ifelse(eval(level_horizonwalker > 0), 1, Horizon Walker(level_horizonwalker)) dnl
ifelse(eval(level_shadowcaster  > 0), 1,   Shadowcaster(level_shadowcaster)) dnl
ifelse(eval(level_shifter       > 0), 1,        Shifter(level_shifter)) dnl
ifelse(eval(level_templeraider  > 0), 1,  Temple Raider(level_templeraider)) dnl
ifelse(eval(level_rimefirewitch > 0), 1, Rimefire Witch(level_rimefirewitch)) dnl
ifelse(eval(level_outsider      > 0), 1,       Outsider(level_outsider)), `^ *\(.*\) *$', `\1'))


dnl ***** calculate base modifiers for saving throws and attack throws, PHB: Table 3-1, p. 22, and the class tables of chapter 3
dnl ***** argument: class level
define(`calc_base_save_poor',   `eval($1 / 3)')dnl
define(`calc_base_save_good',   `ifelse(eval($1 > 0), 1, eval(($1 + 4) / 2), 0)')dnl
define(`calc_base_attack_good', `$1')dnl
define(`calc_base_attack_poor', `eval($1 / 2)')dnl
define(`calc_base_attack_avrg', `eval((calc_base_attack_poor($1) + calc_base_attack_good($1)) / 2)')dnl
dnl
define(`save_fort_base', `eval(dnl ***** Fortitude Saves
calc_base_save_good(    level_preepic_barbarian) + dnl
calc_base_save_poor(         level_preepic_bard) + dnl
calc_base_save_good(       level_preepic_cleric) + dnl
calc_base_save_good(        level_preepic_druid) + dnl
calc_base_save_good(      level_preepic_fighter) + dnl
calc_base_save_good(         level_preepic_monk) + dnl
calc_base_save_good(      level_preepic_paladin) + dnl
calc_base_save_good(       level_preepic_ranger) + dnl
calc_base_save_poor(        level_preepic_rogue) + dnl
calc_base_save_poor(     level_preepic_sorcerer) + dnl
calc_base_save_poor(       level_preepic_wizard) + dnl
calc_base_save_poor(  level_preepic_divineagent) + dnl
calc_base_save_good(level_preepic_horizonwalker) + dnl
calc_base_save_good( level_preepic_shadowcaster) + dnl
calc_base_save_good(      level_preepic_shifter) + dnl
calc_base_save_poor( level_preepic_templeraider) + dnl
calc_base_save_good(level_preepic_rimefirewitch) + dnl
calc_base_save_good(     level_preepic_outsider) + dnl MOM I, p.313
0)')
define(`save_rflx_base', `eval(dnl ***** Reflex Saves
calc_base_save_poor(    level_preepic_barbarian) + dnl
calc_base_save_good(         level_preepic_bard) + dnl
calc_base_save_poor(       level_preepic_cleric) + dnl
calc_base_save_poor(        level_preepic_druid) + dnl
calc_base_save_poor(      level_preepic_fighter) + dnl
calc_base_save_good(         level_preepic_monk) + dnl
calc_base_save_poor(      level_preepic_paladin) + dnl
calc_base_save_good(       level_preepic_ranger) + dnl
calc_base_save_good(        level_preepic_rogue) + dnl
calc_base_save_poor(     level_preepic_sorcerer) + dnl
calc_base_save_poor(       level_preepic_wizard) + dnl
calc_base_save_poor(  level_preepic_divineagent) + dnl
calc_base_save_poor(level_preepic_horizonwalker) + dnl
calc_base_save_poor( level_preepic_shadowcaster) + dnl
calc_base_save_good(      level_preepic_shifter) + dnl
calc_base_save_good( level_preepic_templeraider) + dnl
calc_base_save_poor(level_preepic_rimefirewitch) + dnl
calc_base_save_good(     level_preepic_outsider) + dnl MOM I, p.313
0)')
define(`save_will_base', `eval(dnl ***** Will Saves
calc_base_save_poor(    level_preepic_barbarian) + dnl
calc_base_save_good(         level_preepic_bard) + dnl
calc_base_save_good(       level_preepic_cleric) + dnl
calc_base_save_good(        level_preepic_druid) + dnl
calc_base_save_poor(      level_preepic_fighter) + dnl
calc_base_save_good(         level_preepic_monk) + dnl
calc_base_save_poor(      level_preepic_paladin) + dnl
calc_base_save_poor(       level_preepic_ranger) + dnl
calc_base_save_poor(        level_preepic_rogue) + dnl
calc_base_save_good(     level_preepic_sorcerer) + dnl
calc_base_save_good(       level_preepic_wizard) + dnl
calc_base_save_good(  level_preepic_divineagent) + dnl
calc_base_save_poor(level_preepic_horizonwalker) + dnl
calc_base_save_good( level_preepic_shadowcaster) + dnl
calc_base_save_poor(      level_preepic_shifter) + dnl
calc_base_save_good( level_preepic_templeraider) + dnl
calc_base_save_good(level_preepic_rimefirewitch) + dnl
calc_base_save_good(     level_preepic_outsider) + dnl MOM I, p.313
0)')
define(`bonus_attack_base', `eval(dnl ***** Base Attack Bonus
calc_base_attack_good(    level_preepic_barbarian) + dnl
calc_base_attack_avrg(         level_preepic_bard) + dnl
calc_base_attack_avrg(       level_preepic_cleric) + dnl
calc_base_attack_avrg(        level_preepic_druid) + dnl
calc_base_attack_good(      level_preepic_fighter) + dnl
calc_base_attack_avrg(         level_preepic_monk) + dnl
calc_base_attack_good(      level_preepic_paladin) + dnl
calc_base_attack_good(       level_preepic_ranger) + dnl
calc_base_attack_avrg(        level_preepic_rogue) + dnl
calc_base_attack_poor(     level_preepic_sorcerer) + dnl
calc_base_attack_poor(       level_preepic_wizard) + dnl
calc_base_attack_avrg(  level_preepic_divineagent) + dnl
calc_base_attack_good(level_preepic_horizonwalker) + dnl
calc_base_attack_poor( level_preepic_shadowcaster) + dnl
calc_base_attack_avrg(      level_preepic_shifter) + dnl
calc_base_attack_avrg( level_preepic_templeraider) + dnl
calc_base_attack_poor(level_preepic_rimefirewitch) + dnl
calc_base_attack_good(     level_preepic_outsider) + dnl MOM I, p.313
0)')
define(`save_epic_bonus',   eval( level_epic      / 2))dnl ELH, p.6
define(`bonus_attack_epic', eval((level_epic + 1) / 2))dnl ELH, p.6
define(`save_fort_misc', eval(save_fort_misc + save_epic_bonus))
define(`save_rflx_misc', eval(save_rflx_misc + save_epic_bonus))
define(`save_will_misc', eval(save_will_misc + save_epic_bonus))


dnl ***** prepare to print the base attack bonus, including multiple attacks
dnl arguments: base attack bonus, modifier to all attacks (useful for item boni, monk flurry of blows, epic attack bonus, etc.)
define(`bonus_attack_base_cascade', `emph_sign(eval($1 + $2)){}ifelse(eval($1 > 5),1,`/'`bonus_attack_base_cascade(eval($1 - 5),$2)')')dnl


dnl ***** check, what classes have a given skill as class skill
dnl ***** arguments: macro of skill rank, class name
define(`check_class_skill', `eval((regexp(regexp(`$1', `^rank_\(.*\)', `csl_\1'), `\<'$2`\>') >= 0)  ||  (regexp(regexp(`$1', `^rank_\(.*\)', `csl_\1'), `\<always\>') >= 0))')
define(`list_class_skills', `dnl
ifelse(eval(level_barbarian     > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',     `barbarian'), 1, \x)})dnl
ifelse(eval(level_bard          > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',          `bard'), 1, \x)})dnl
ifelse(eval(level_cleric        > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',        `cleric'), 1, \x)})dnl
ifelse(eval(level_druid         > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',         `druid'), 1, \x)})dnl
ifelse(eval(level_fighter       > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',       `fighter'), 1, \x)})dnl
ifelse(eval(level_monk          > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',          `monk'), 1, \x)})dnl
ifelse(eval(level_paladin       > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',       `paladin'), 1, \x)})dnl
ifelse(eval(level_ranger        > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',        `ranger'), 1, \x)})dnl
ifelse(eval(level_rogue         > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',         `rogue'), 1, \x)})dnl
ifelse(eval(level_sorcerer      > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',      `sorcerer'), 1, \x)})dnl
ifelse(eval(level_wizard        > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',        `wizard'), 1, \x)})dnl
ifelse(eval(level_divineagent   > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',   `divineagent'), 1, \x)})dnl
ifelse(eval(level_horizonwalker > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1', `horizonwalker'), 1, \x)})dnl
ifelse(eval(level_shadowcaster  > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',  `shadowcaster'), 1, \x)})dnl
ifelse(eval(level_shifter       > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',       `shifter'), 1, \x)})dnl
ifelse(eval(level_templeraider  > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',  `templeraider'), 1, \x)})dnl
ifelse(eval(level_rimefirewitch > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1', `rimefirewitch'), 1, \x)})dnl
ifelse(eval(level_outsider      > 0), 1, \makebox[0.75\basewidth]{ifelse(check_class_skill(`$1',      `outsider'), 1, \x)})')


dnl ***** calculate the development points for buying skill ranks
dnl ***** argument: x of the particular class in the formula x + INT, PHB, table 4-1, p.62
dnl
dnl only the permanent ability score counts for this, items yield no improvement
define(`calc_skill_points', `calc_max(1, eval($1 + calc_ability_mod(INT_score) + ifelse(stat_race, human, 1, 0)))')


dnl ***** one line of a skill
dnl ***** arguments: skill name, ability (quoted), skill token (quoted), multiplier for AC-modifier, use untrained flag, flag for non-proficiency penalty
dnl
define(`skill_line', `ifelse(show_$3,1,`dnl
{$1}\hspace*{1ex}dnl
ifelse($5, 1, \rule[0.25ex]{0.4\basewidth}{0.4\basewidth})\dotfill{}dnl
list_class_skills(`rank_$3')\hspace*{1ex}dnl
\makebox[1.5\basewidth][r]{eval(rank_$3)}\hspace*{1ex}dnl
ifelse(flag_show_skill_progression_bar, 0, ,dnl
\makebox[5mm][l]{\rule[0.25ex]{ifelse(eval(rank_$3 > 0), 1, eval(rank_$3 / 5)`.'eval((rank_$3 - (rank_$3 / 5) * 5) * 20)`mm', 0mm)}{0.4\basewidth}}\hspace*{0.5ex})dnl
\makebox[3.0\basewidth]{`$2'}\hspace*{1ex}dnl
\makebox[1.0\basewidth][r]{eval($2)}\hspace*{1ex}dnl
\makebox[1.5\basewidth][r]{ifelse(eval(bonus_$3 + bonus_item_$3 + bonus_skills_global + bonus_skills_global_item),0,,`eval(bonus_$3 + bonus_item_$3 + bonus_skills_global + bonus_skills_global_item)')}\hspace*{1ex}dnl
\makebox[1.5\basewidth][r]{ifelse(eval(($4 == 0) && ($6 == 0)),1,,eval($4 * mod_encumbrance + $6 * (bonus_attack_mod_armor + bonus_attack_mod_shield)))}\hspace*{1ex}dnl
\makebox[2.0\basewidth][r]{ifelse(eval((rank_$3 > 0) || ($5 == 1)),0,`---',emph_sign(eval($2 + rank_$3 + bonus_$3 + bonus_item_$3 + bonus_skills_global + bonus_skills_global_item + ($4 * mod_encumbrance + $6 * (bonus_attack_mod_armor + bonus_attack_mod_shield)))))}\hspace*{0.5ex}dnl
\makebox[0.2\basewidth][r]{ifelse(mark_$3,1,`{\scriptsize !}',`')}\\%', `%')')
dnl
define(`skill_line_head', `dnl
\mbox{}\hfill{\tiny Skill Points:}%
ifelse(eval(level_barbarian     > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',4,4))})dnl   skill points per class given
ifelse(eval(level_bard          > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',4,6))})dnl   in PHB, table 4-1, p.62
ifelse(eval(level_cleric        > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',2,2))})dnl
ifelse(eval(level_druid         > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',4,4))})dnl   and in ELH, p.8-17
ifelse(eval(level_fighter       > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',2,2))})dnl
ifelse(eval(level_monk          > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',4,4))})dnl
ifelse(eval(level_paladin       > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',2,2))})dnl
ifelse(eval(level_ranger        > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',4,6))})dnl
ifelse(eval(level_rogue         > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',8,8))})dnl
ifelse(eval(level_sorcerer      > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',2,2))})dnl
ifelse(eval(level_wizard        > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',2,2))})dnl
ifelse(eval(level_divineagent   > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',4,4))})dnl
ifelse(eval(level_horizonwalker > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',4,4))})dnl   DMG, p.189f.
ifelse(eval(level_shadowcaster  > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',2,2))})dnl
ifelse(eval(level_shifter       > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',4,4))})dnl
ifelse(eval(level_templeraider  > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',4,4))})dnl
ifelse(eval(level_rimefirewitch > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',2,2))})dnl   FRB, p.67ff.
ifelse(eval(level_outsider      > 0), 1, \makebox[0.75\basewidth]{\tiny calc_skill_points(ifdef(`active_epic',8,8))})dnl   MOM I, p.313
\hspace*{1ex}dnl
\makebox[1.5\basewidth]{}\hspace*{1ex}dnl
\makebox[5mm]{}\hspace*{0.5ex}dnl
\makebox[3.0\basewidth]{}\hspace*{1ex}dnl
\makebox[1.0\basewidth]{}\hspace*{1ex}dnl
\makebox[1.5\basewidth]{}\hspace*{1ex}dnl
\makebox[1.5\basewidth]{}\hspace*{1ex}dnl
\makebox[2.0\basewidth]{}\hspace*{0.5ex}dnl
\makebox[0.2\basewidth]{}\\[-1.25ex]dnl
%
\tiny Skill Name \hfill Class-Skills:\normalsize
ifelse(eval(level_barbarian     > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Bbn}\end{sideways}})dnl
ifelse(eval(level_bard          > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Brd}\end{sideways}})dnl
ifelse(eval(level_cleric        > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Clr}\end{sideways}})dnl
ifelse(eval(level_druid         > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Drd}\end{sideways}})dnl
ifelse(eval(level_fighter       > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Ftr}\end{sideways}})dnl
ifelse(eval(level_monk          > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Mnk}\end{sideways}})dnl
ifelse(eval(level_paladin       > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Pal}\end{sideways}})dnl
ifelse(eval(level_ranger        > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Rgr}\end{sideways}})dnl
ifelse(eval(level_rogue         > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Rog}\end{sideways}})dnl
ifelse(eval(level_sorcerer      > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Sor}\end{sideways}})dnl
ifelse(eval(level_wizard        > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Wiz}\end{sideways}})dnl
ifelse(eval(level_divineagent   > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Dag}\end{sideways}})dnl
ifelse(eval(level_horizonwalker > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Hzw}\end{sideways}})dnl
ifelse(eval(level_shadowcaster  > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Shc}\end{sideways}})dnl
ifelse(eval(level_shifter       > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Sft}\end{sideways}})dnl
ifelse(eval(level_templeraider  > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Tpr}\end{sideways}})dnl
ifelse(eval(level_rimefirewitch > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Rfw}\end{sideways}})dnl
ifelse(eval(level_outsider      > 0), 1, \makebox[0.75\basewidth]{\begin{sideways}\makebox[3.2ex][l]{\tiny{}Out}\end{sideways}})dnl
\hspace*{1ex}dnl
\makebox[1.5\basewidth]{\tiny Rank}\hspace*{1ex}dnl
\makebox[5mm]{}\hspace*{0.5ex}dnl
\makebox[3.0\basewidth]{\tiny Ability}\hspace*{1ex}dnl
\makebox[1.0\basewidth]{\tiny Mod.}\hspace*{1ex}dnl
\makebox[1.5\basewidth]{\tiny Misc}\hspace*{1ex}dnl
\makebox[1.5\basewidth]{\tiny Enc.}\hspace*{1ex}dnl
\makebox[2.0\basewidth]{\tiny Sum}\hspace*{0.5ex}dnl
\makebox[0.2\basewidth]{}\\[-0.5ex]dnl
%')


dnl
dnl ***** special class abilities
dnl
dnl abilities shared by several classes (trap sense, summon familiar, wild empathy) are combined at the end of this list
dnl

dnl ********** Barbarian **********
ifelse(eval(level_barbarian >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ Fast Movement (p.25) \done)define(`char_speed_misc_barbarian', 10)')
ifelse(eval(level_barbarian >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ Illiteracy (p.25) ifelse(eval((level_total > level_barbarian)  ||  (rank_negate_illiteracy > 0)),1,(negated)))')
ifelse(eval(level_barbarian >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ Rage (p.25f): dnl
	eval(level_barbarian / 4 + 1)$\times$/day\komma dnl
	eval(3 + CON + ifelse(eval(level_barbarian >= 20), 1, 4, eval(level_barbarian >= 11), 1, 3, 2)) rounds`'dnl
`'`'`'`'ifelse(eval(level_barbarian >= 17), 1, \komma tireless) dnl
	\\ dnl
	\hspace*{1ex} dnl
	emph_sign(ifelse(eval(level_barbarian >= 20), 1, 8, eval(level_barbarian >= 11), 1, 6, 4)) S{}T{}R/C{}O{}N\komma dnl
	emph_sign(ifelse(eval(level_barbarian >= 20), 1, 4, eval(level_barbarian >= 11), 1, 3, 2)) moral Will Saves\komma dnl
	-2 A{}C \\ dnl
	\hspace*{1ex} dnl
	+`'eval(level_total * ifelse(eval(level_barbarian >= 20),1,4,eval(level_barbarian >= 11),1,3,2)) hits points\komma dnl
	+`'ifelse(eval(level_barbarian >= 20),1,4,eval(level_barbarian >= 11),1,3,2) melee\komma dnl
	+`'ifelse(eval(level_barbarian >= 20),1,4,eval(level_barbarian >= 11),1,3,2)`'/+`'ifelse(eval(level_barbarian >= 20),1,6,eval(level_barbarian >= 11),1,4,3) damage (1h/2h)dnl
`'`'`'`'ifdef(`feat_chaotic_rage', `\\ weapons deal +2D6 against lawful opponents'))')
ifelse(eval(level_barbarian >=  2), 1, `define(`spec_uncanny_dodge', eval(spec_uncanny_dodge + 1))define(`spec_uncanny_dodge_level', eval(spec_uncanny_dodge_level + level_barbarian))')
ifelse(eval(level_barbarian >=  3), 1, `define(`spec_trapsense', eval(spec_trapsense  +  (level_barbarian / 3)))')
ifelse(eval(level_barbarian >=  5), 1, `define(`spec_uncanny_dodge', eval(spec_uncanny_dodge + 1))')
ifelse(eval(level_barbarian >=  7), 1, `define(`show_special_abilities', show_special_abilities\\ Damage Reduction (p.26): eval((level_barbarian - 4) / 3)`'/--)')
ifelse(eval(level_barbarian >= 14), 1, `define(`show_special_abilities', show_special_abilities\\ Indomitable Will (p.26))')

dnl ********** Bard **********
define(`rank_perform_maximum', calc_max(rank_perform_act, rank_perform_comedy, rank_perform_dance, rank_perform_keyboard, rank_perform_oratory, rank_perform_percussion, rank_perform_sing, rank_perform_string, rank_perform_wind ))
ifelse(eval(level_bard      >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ Bardic Knowledge (p.28): emph_sign(eval(level_bard + INT + ifelse(eval(rank_knowledge_history >= 5),1,2,0))))')
ifelse(eval(level_bard      >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ Bardic Music (p.29): level_bard`'$\times$/day\\ dnl
\mbox{}\hfill\parbox[t]{0.95\linewidth}{dnl
ifelse(eval(rank_perform_maximum < 3),1,none,dnl
Countersong (Su)\komma dnl
Fascinate (Sp) (eval(1 + (level_bard - 1) / 3) target(s))`'ifelse(eval(level_bard >= 6 && rank_perform_maximum >= 9),1,` '(and ifelse(eval(level_bard >= 18 && rank_perform_maximum >= 21),1, (Mass))`'Suggestion (Sp) (Will Save DC eval(10 + (level_bard / 2) + CHA))))\komma dnl
Inspire Courage (Su) (+eval(1 + (level_bard - 2) / 6) moral)`'dnl
ifelse(eval(level_bard >=  3 && rank_perform_maximum >=  6),1,\komma Inspire Competence (Su))`'dnl
ifelse(eval(level_bard >=  9 && rank_perform_maximum >= 12),1,\komma Inspire Greatness (Su) (eval(1 + (level_bard - 9) / 3) target(s)))`'dnl
ifelse(eval(level_bard >= 12 && rank_perform_maximum >= 15),1,\komma Song of Freedom (Sp))`'dnl
ifelse(eval(level_bard >= 15 && rank_perform_maximum >= 18),1,\komma Inspire Heroics (Su) (eval(1 + (level_bard - 15) / 3) target(s))))})')

dnl ********** Cleric **********
ifelse(eval(level_cleric    >=  1), 1, `ifelse(char_patron_deity_alignment,,,char_patron_deity_alignment,N,,`define(`show_special_abilities', show_special_abilities\\ Aura (p.32): ifelse(index(char_patron_deity_alignment,C),-1,, Chaotic) ifelse(index(char_patron_deity_alignment,L),-1,, Lawful) ifelse(index(char_patron_deity_alignment,E),-1,, Evil) ifelse(index(char_patron_deity_alignment,G),-1,, Good))')')
dnl ifelse(eval(level_cleric    >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ ifelse(char_turn_polarity,1,Turn,Rebuce) Undead (p.33+159))')
dnl Turn / Rebuke is given by resolve-table

dnl ********** Druid **********
ifelse(eval(level_druid     >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ Nature Sense (p.35) \done)')
ifelse(eval(level_druid     >=  1), 1, `define(`bonus_knowledge_nature',    eval(bonus_knowledge_nature    + 2))')dnl nature sense
ifelse(eval(level_druid     >=  1), 1, `define(`bonus_survival',            eval(bonus_survival            + 2))')dnl nature sense
ifelse(eval(level_druid     >=  1), 1, `define(`spec_wild_empathy', eval(spec_wild_empathy + level_druid))')dnl wild empathy is finally processed below
ifelse(eval(level_druid     >=  1), 1, `define(`spec_animal_companion', eval(spec_animal_companion + level_druid))')
ifelse(eval(level_druid     >=  2), 1, `define(`spec_woodland_stride', 1)')dnl processed below
ifelse(eval(level_druid     >=  3), 1, `define(`show_special_abilities', show_special_abilities\\ Trackless Step (p.36))')
ifelse(eval(level_druid     >=  4), 1, `define(`show_special_abilities', show_special_abilities\\ Resist Nature\aps s Lure (p.37))')
ifelse(eval(level_druid     >=  5), 1, `define(`show_special_abilities', show_special_abilities\\ Wild Shape (p.37): dnl
animal`'ifelse(eval(level_druid >= 12), 1, `/plant')\komma dnl
ifelse(eval(level_druid >= 11),1,tiny,small){--}ifelse(eval(level_druid >= 15),1,huge,eval(level_druid >= 8),1,large,medium)\komma dnl
eval(ifelse(eval(level_druid >= 18),1,6,eval(level_druid >= 14),1,5,eval(level_druid >= 10),1,4,eval(level_druid >= 7),1,3,eval(level_druid >= 6),1,2,1) + ifdef(`feat_extra_wild_shape',2 * feat_extra_wild_shape,0))$\times$/day)')
ifelse(eval(level_druid     >= 16), 1, `define(`show_special_abilities', show_special_abilities\\ Wild Shape (p.37): dnl
elemental\komma dnl
small{--}ifelse(eval(level_druid >= 20),1,huge,large)\komma dnl
eval(ifelse(eval(level_druid >= 20),1,3,eval(level_druid >= 18),1,2,1) + ifdef(`feat_extra_wild_shape',feat_extra_wild_shape,0))$\times$/day)')
ifelse(eval(level_druid     >=  9), 1, `define(`show_special_abilities', show_special_abilities\\ Venom Immunity (p.37))')
ifelse(eval(level_druid     >= 13), 1, `define(`show_special_abilities', show_special_abilities\\ A Thousand Faces (p.37))')
ifelse(eval(level_druid     >= 15), 1, `define(`show_special_abilities', show_special_abilities\\ Timeless Body (p.37))')

dnl ********** Monk **********
ifelse(eval(level_monk      >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ AC Bonus (p.40) \done)define(`AC_misc', eval(AC_misc + ifelse(eval(WIS > 0),1,WIS,0) + eval(level_monk / 5)))')
ifelse(eval(level_monk      >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ Flurry of Blows (p.40) \done)')
ifelse(eval(level_monk      >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ Unarmed Strike (p.41) \done)define(`feat_improved_unarmed_strike',1)')
ifelse(eval(level_monk      >=  2), 1, `define(`show_special_abilities', show_special_abilities\\ ifelse(eval(level_monk >= 9),1,Improved )Evasion (p.41`'ifelse(eval(level_monk >= 9),1,f.)))')
ifelse(eval(level_monk      >=  3), 1, `define(`show_special_abilities', show_special_abilities\\ Fast Movement (p.41) \done)define(`char_speed_misc_monk', eval((level_monk / 3) * 10))')
ifelse(eval(level_monk      >=  3), 1, `define(`show_special_abilities', show_special_abilities\\ Still Mind (p.41))')
ifelse(eval(level_monk      >=  4), 1, `define(`show_special_abilities', show_special_abilities\\ Ki Strike (p.41): magical`'ifelse(eval(level_monk >= 10),1,\komma{}lawful)`'ifelse(eval(level_monk >= 16),1,\komma{}adamantine))')
ifelse(eval(level_monk      >=  4), 1, `define(`show_special_abilities', show_special_abilities\\ Slow Fall (p.41): ifelse(eval(level_monk >= 20),1,any distance,eval((level_monk / 2) * 10)\aps))')
ifelse(eval(level_monk      >=  5), 1, `define(`show_special_abilities', show_special_abilities\\ Purity of Body (p.41))')
ifelse(eval(level_monk      >=  7), 1, `define(`show_special_abilities', show_special_abilities\\ Wholeness of the Body (p.42): heal eval(level_monk * 2) hits per day)')
ifelse(eval(level_monk      >= 11), 1, `define(`show_special_abilities', show_special_abilities\\ Diamond Body (p.42))')
ifelse(eval(level_monk      >= 12), 1, `define(`show_special_abilities', show_special_abilities\\ Abundant Step (p.42+221): eval((level_monk / 2) * 40 + 400)\aps\komma{}+`'eval(level_monk / 6) beings)')
ifelse(eval(level_monk      >= 13), 1, `define(`show_special_abilities', show_special_abilities\\ Diamond Soul (p.42) \done)define(`char_spell_resistance', ifelse(char_spell_resistance,--,eval(level_monk + 10),`eval(char_spell_resistance < level_monk + 10)',1,eval(level_monk + 10),char_spell_resistance))')
ifelse(eval(level_monk      >= 15), 1, `define(`show_special_abilities', show_special_abilities\\ Quivering Palm (p.42): Fortitude Save DC eval(10 + level_monk / 2 + WIS))')
ifelse(eval(level_monk      >= 17), 1, `define(`show_special_abilities', show_special_abilities\\ Timeless Body (p.42)\\ Tongue of the Sun and Moon (p.42))')
ifelse(eval(level_monk      >= 19), 1, `define(`show_special_abilities', show_special_abilities\\ Empty Body (p.42))')
ifelse(eval(level_monk      >= 20), 1, `define(`show_special_abilities', show_special_abilities\\ Perfect Self (p.42))')

dnl ********** Paladin **********
ifelse(eval(level_paladin   >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ Aura of Good (p.44)\\ Detect Evil (p.44))')
ifelse(eval(level_paladin   >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ Smite Evil (p.44): calc_min(5, eval(1 + level_paladin / 5))`'$\times$`'/day`'ifelse(eval(CHA > 0),1,\komma +CHA attack)\komma +level_paladin damage)')
ifelse(eval(level_paladin   >=  2), 1, `define(`show_special_abilities', show_special_abilities\\ Divine Grace (p.44) \done)dnl
define(`save_fort_magic', eval(save_fort_magic + ifelse(eval(CHA > 0),1,CHA,0)))dnl
define(`save_rflx_magic', eval(save_rflx_magic + ifelse(eval(CHA > 0),1,CHA,0)))dnl
define(`save_will_magic', eval(save_will_magic + ifelse(eval(CHA > 0),1,CHA,0)))')
ifelse(eval(level_paladin   >=  2), 1, `define(`show_special_abilities', show_special_abilities\\ Lay on Hands (p.44): ifelse(eval(CHA_score >= 12),1,`eval(level_paladin * CHA) hits per day',--))')
ifelse(eval(level_paladin   >=  3), 1, `define(`show_special_abilities', show_special_abilities\\ Aura of Courage (p.44)\\ Divine Health (p.44))')
dnl Turning Undead implemented in sheet.m4
ifelse(eval(level_paladin   >=  5), 1, `define(`show_special_abilities', show_special_abilities\\ Special Mount (p.44))')
ifelse(eval(level_paladin   >=  6), 1, `define(`show_special_abilities', show_special_abilities\\ Remove Disease (p.44): eval((level_paladin - 3) / 3)`'$\times$`'/week)')

dnl ********** Ranger **********
ifelse(eval(level_ranger    >=  1), 1, `define(`feat_track', 1)')dnl bonus feat
ifelse(eval(level_ranger    >=  1), 1, `define(`spec_wild_empathy', eval(spec_wild_empathy + level_ranger))')dnl wild empathy is finally processed below
ifelse(eval(level_ranger    >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ Favored Enemy (p.47))')
ifelse(eval(level_ranger    >=  2), 1, `ifelse(spec_ranger_combat, archery, `define(`feat_rapid_shot', 1)', spec_ranger_combat, two-weapon, `define(`feat_two_weapon_fighting', 1)')')dnl bonus feat
ifelse(eval(level_ranger    >=  3), 1, `define(`feat_endurance', 1)')dnl bonus feat
ifelse(eval(level_ranger    >=  4), 1, `define(`spec_animal_companion', eval(spec_animal_companion + (level_ranger / 2)))')
ifelse(eval(level_ranger    >=  6), 1, `ifelse(spec_ranger_combat, archery, `define(`feat_manyshot', 1)', spec_ranger_combat, two-weapon, `define(`feat_improved_two_weapon_fighting', 1)')')dnl bonus feat
ifelse(eval(level_ranger    >=  7), 1, `define(`spec_woodland_stride', 1)')dnl processed below
ifelse(eval(level_ranger    >=  8), 1, `define(`show_special_abilities', show_special_abilities\\ Swift Tracker (p.48))')
ifelse(eval(level_ranger    >=  9), 1, `define(`spec_evasion', 1)')
ifelse(eval(level_ranger    >= 11), 1, `ifelse(spec_ranger_combat, archery, `define(`feat_improved_precise_shot', 1)', spec_ranger_combat, two-weapon, `define(`feat_greater_two_weapon_fighting', 1)')')dnl bonus feat
ifelse(eval(level_ranger    >= 13), 1, `define(`show_special_abilities', show_special_abilities\\ Camouflage (p.48))')
ifelse(eval(level_ranger    >= 17), 1, `define(`show_special_abilities', show_special_abilities\\ Hide in Plain Sight (p.48))')

dnl ********** Rogue **********
ifelse(eval(level_rogue     >=  1), 1, `define(`spec_sneak_attack', eval(spec_sneak_attack + (level_rogue + 1) / 2))')
ifelse(eval(level_rogue     >=  1), 1, `define(`spec_trapfinding', 1)')
ifelse(eval(level_rogue     >=  2), 1, `define(`spec_evasion', 1)')
ifelse(eval(level_rogue     >=  3), 1, `define(`spec_trapsense', eval(spec_trapsense  +  (level_rogue / 3)))')
ifelse(eval(level_rogue     >=  4), 1, `define(`spec_uncanny_dodge', eval(spec_uncanny_dodge + 1))define(`spec_uncanny_dodge_level', eval(spec_uncanny_dodge_level + level_rogue))')
ifelse(eval(level_rogue     >=  8), 1, `define(`spec_uncanny_dodge', eval(spec_uncanny_dodge + 1))')
ifelse(eval(level_rogue     >= 10), 1, `define(`show_special_abilities', show_special_abilities\\ Special Ability ... (p.50f))')

dnl ********** Wizard **********
ifelse(eval(level_wizard    >=  1), 1, `define(`feat_scribe_scroll', 1)')

dnl ********** Divine Agent **********
ifelse(eval(level_divineagent >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ Granted Domain)')
ifelse(eval(level_divineagent >=  2), 1, `define(`show_special_abilities', show_special_abilities\\ Contact)')
ifelse(eval(level_divineagent >=  3), 1, `define(`show_special_abilities', show_special_abilities\\ Menacing Aura: 20~ft\komma Will DC {level_total})')
ifelse(eval(level_divineagent >=  3), 1, `define(`show_special_abilities', show_special_abilities\\ Godly Gift: eval(level_divineagent / 3))')
ifelse(eval(level_divineagent >=  4), 1, `define(`show_special_abilities', show_special_abilities\\ Altered Appearance)')
ifelse(eval(level_divineagent >=  5), 1, `define(`show_special_abilities', show_special_abilities\\ Commune: 1{}$\times$/week\komma caster level {level_total})')
ifelse(eval(level_divineagent >=  5), 1, `define(`show_special_abilities', show_special_abilities\\ Plane Shift to Deity\aps{}s Plane: 1{}$\times$/day\komma caster level {level_total})')
ifelse(eval(level_divineagent >=  7), 1, `define(`show_special_abilities', show_special_abilities\\ Plane Shift to Any Plane: 1{}$\times$/day\komma caster level {level_total})')
ifelse(eval(level_divineagent >=  8), 1, `define(`show_special_abilities', show_special_abilities\\ Audience: 2{}$\times$/year)')
ifelse(eval(level_divineagent >=  8), 1, `define(`show_special_abilities', show_special_abilities\\ Alignment Shift)')
ifelse(eval(level_divineagent >=  9), 1, `define(`show_special_abilities', show_special_abilities\\ Mystic Union: Outsider\komma Damage Reduction 20/+1)')
ifelse(eval(level_divineagent >= 10), 1, `define(`show_special_abilities', show_special_abilities\\ Gate: 1{}$\times$/day\komma caster level {level_total})')

dnl ********** Horizon Walker **********
ifelse(eval(level_horizonwalker >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ Terrain Mastery)')
ifelse(eval(level_horizonwalker >=  6), 1, `define(`show_special_abilities', show_special_abilities\\ Planar Terrain Mastery)')

dnl ********** Shadowcaster **********
ifelse(eval(level_shadowcaster >=  3), 1, `define(`show_special_abilities', show_special_abilities\\ Umbral Sight (Darkvision ifelse(eval(level_shadowcaster < 11), 1, 30, 60)`'~ft))')
ifelse(eval(level_shadowcaster >=  5), 1, `define(`show_special_abilities', show_special_abilities\\ Sustaining Shadow (eat 1~meal/week))')
ifelse(eval(level_shadowcaster >= 10), 1, `define(`show_special_abilities', show_special_abilities\\ Sustaining Shadow (sleep 1~hour/day))')
ifelse(eval(level_shadowcaster >= 15), 1, `define(`show_special_abilities', show_special_abilities\\ Sustaining Shadow (immune to poison/desease))')
ifelse(eval(level_shadowcaster >= 20), 1, `define(`show_special_abilities', show_special_abilities\\ Sustaining Shadow (no need to breath\komma eat\komma or sleep))')

dnl ********** Shifter **********
ifelse(eval(level_shifter >=  1), 1, `define(`spec_wild_empathy', eval(spec_wild_empathy + level_shifter))')
ifelse(eval(level_shifter >=  1), 1, `define(`show_special_abilities', show_special_abilities\\ Greater Wild Shape: dnl
                                      ifelse(eval(level_shifter >=  6),1,su,sp)\komma dnl
                                      ifelse(eval(level_shifter >= 10),1,1{}$\times$/rnd.\komma unlimited, eval(1 + 2 * ((level_shifter - 1) / 2)){}$\times$/day\komma {level_shifter}~h. each)\\ dnl
                                      \mbox{} \hfill \parbox[b]{0.95\linewidth}{Size: dnl
                                          ifelse(eval(level_shifter < 3),1, small,eval(level_shifter < 5),1, tiny,eval(level_shifter <  9),1,diminutive,      fine) -- dnl
                                          ifelse(eval(level_shifter < 3),1,medium,eval(level_shifter < 7),1,large,eval(level_shifter < 10),1,      huge,gargantuan)\\ dnl
Type: Humanoid`'dnl missing type: Fey
ifelse(eval(level_shifter >= 2),1,\komma Animal\komma Monstrous Humanoid)`'dnl
ifelse(eval(level_shifter >= 3),1,\komma Beast\komma Plant)`'dnl
ifelse(eval(level_shifter >= 4),1,\komma Giant\komma Vermin)`'dnl
ifelse(eval(level_shifter >= 5),1,\komma Magical Beast)`'dnl
ifelse(eval(level_shifter >= 6),1,\komma Aberation\komma Ooze)`'dnl
ifelse(eval(level_shifter >= 7),1,\komma Dragon)`'dnl
ifelse(eval(level_shifter >= 8),1,\komma Undead\komma Incorporeal\komma Construct)`'dnl
ifelse(eval(level_shifter >= 9),1,\komma Elemental\komma Outsider)})')
ifelse(eval(level_shifter >= 10), 1, `define(`show_special_abilities', show_special_abilities\\ Shapechanger Subtype\\ Darkvision 60~ft\\ Age-Less Body)')

dnl ********** Temple Raider of Olidammara **********
ifelse(eval(level_templeraider >=  1), 1, `define(`spec_trapfinding', 1)')
ifelse(eval(level_templeraider >=  2), 1, `define(`spec_sneak_attack', eval(spec_sneak_attack + (level_templeraider + 1) / 3))')
ifelse(eval(level_templeraider >=  3), 1, `define(`spec_uncanny_dodge', eval(spec_uncanny_dodge + 1))define(`spec_uncanny_dodge_level', eval(spec_uncanny_dodge_level + level_templeraider))')
ifelse(eval(level_templeraider >=  4), 1, `define(`show_special_abilities', show_special_abilities\\ Save Bonus \done)dnl
			       	       	   define(`save_fort_misc', eval(save_fort_misc + ifelse(eval(level_templeraider >= 10),1,3,eval(level_templeraider >= 7),1,2,1)))
			       	       	   define(`save_rflx_misc', eval(save_rflx_misc + ifelse(eval(level_templeraider >= 10),1,3,eval(level_templeraider >= 7),1,2,1)))
			       	       	   define(`save_will_misc', eval(save_will_misc + ifelse(eval(level_templeraider >= 10),1,3,eval(level_templeraider >= 7),1,2,1)))')
ifelse(eval(level_templeraider >=  6), 1, `define(`spec_uncanny_dodge', eval(spec_uncanny_dodge + 1))')
ifelse(eval(level_templeraider >=  9), 1, `define(`spec_trapsense', eval(spec_trapsense + 1))')

dnl ********** Rimefire Witch **********
ifelse(eval(level_rimefirewitch >= 1), 1, `define(`show_special_abilities', show_special_abilities\\ Rimefire Bond\\ Detect Minion of Iborighu)')

dnl ********** combined special abilities **********
dnl first some calculations
ifdef(`feat_resistance_energy', `define(`spec_resist_energy', spec_resist_energy patsubst(feat_resistance_energy, `\<\([^ ]+\)\>', `\1_5'))')dnl append energy resistance by according feat
dnl ********** now their listing **********
ifelse(eval((level_sorcerer >= 1) || (level_wizard >= 1)), 1, `define(`show_special_abilities', show_special_abilities\\ Summon Familiar (p.52--54))')
ifelse(eval(spec_animal_companion > 0), 1, `define(`show_special_abilities', show_special_abilities\\ Animal Companion (p.35f.))')
ifelse(eval(spec_evasion          > 0), 1, `define(`show_special_abilities', show_special_abilities\\ Evasion (p.48\komma{}50))')
ifelse(spec_resist_energy,,, `define(`show_special_abilities', show_special_abilities\\ Resist Energy: dnl
  ifelse(regexp(spec_resist_energy,  `\<acid_[0-9]+\>'),-1,,`Acid        eval(0 patsubst(spec_resist_energy, `\<\([^ ]+\)_\([0-9]+\)\>', `ifelse(\1, acid, + \2 )'))') dnl
  ifelse(regexp(spec_resist_energy,  `\<cold_[0-9]+\>'),-1,,`Cold        eval(0 patsubst(spec_resist_energy, `\<\([^ ]+\)_\([0-9]+\)\>', `ifelse(\1, cold, + \2 )'))') dnl
  ifelse(regexp(spec_resist_energy,  `\<elec_[0-9]+\>'),-1,,`Electricity eval(0 patsubst(spec_resist_energy, `\<\([^ ]+\)_\([0-9]+\)\>', `ifelse(\1, elec, + \2 )'))') dnl
  ifelse(regexp(spec_resist_energy,  `\<fire_[0-9]+\>'),-1,,`Fire        eval(0 patsubst(spec_resist_energy, `\<\([^ ]+\)_\([0-9]+\)\>', `ifelse(\1, fire, + \2 )'))') dnl
  ifelse(regexp(spec_resist_energy, `\<sonic_[0-9]+\>'),-1,,`Sonic       eval(0 patsubst(spec_resist_energy, `\<\([^ ]+\)_\([0-9]+\)\>', `ifelse(\1,sonic, + \2 )'))') dnl
)')
ifelse(eval(spec_sneak_attack     > 0), 1, `define(`show_special_abilities', show_special_abilities\\ Sneak Attack (p.50): +`'spec_sneak_attack`'D6)')
ifelse(eval(spec_trapfinding      > 0), 1, `define(`show_special_abilities', show_special_abilities\\ Trapfinding (p.50))')
ifelse(eval(spec_trapsense        > 0), 1, `define(`show_special_abilities', show_special_abilities\\ Trapsense (p.26+50): +`'spec_trapsense)')
ifelse(eval(spec_uncanny_dodge    > 0), 1, `define(`show_special_abilities', show_special_abilities\\ ifelse(eval(spec_uncanny_dodge > 1), 1, Improved )Uncanny Dodge (p.26+50)`'ifelse(eval(spec_uncanny_dodge > 1), 1, ` ': level spec_uncanny_dodge_level))')
ifelse(eval(spec_wild_empathy     > 0), 1, `define(`show_special_abilities', show_special_abilities\\ Wild Empathy (p.35\komma{}47\komma{}71f): emph_sign(eval(spec_wild_empathy + CHA + ifelse(eval(rank_handle_animal >= 5),1,2,0))))')
ifelse(eval(spec_woodland_stride  > 0), 1, `define(`show_special_abilities', show_special_abilities\\ Woodland Stride (p.36\komma{}48))')



dnl
dnl ***** feats
dnl
dnl first the algorithms if possible
dnl sheet notification follows thereafter
dnl
dnl ***** Feats from Players Handbook
ifdef(`feat_acrobatic',                     `define(`bonus_jump', eval(bonus_jump + 2))define(`bonus_tumble', eval(bonus_tumble + 2))')
ifdef(`feat_agile',                         `define(`bonus_balance', eval(bonus_balance + 2))define(`bonus_escape_artist', eval(bonus_escape_artist + 2))')
ifdef(`feat_alertness',                     `define(`bonus_listen', eval(bonus_listen + 2))define(`bonus_spot', eval(bonus_spot + 2))')
ifdef(`feat_animal_affinity',               `define(`bonus_handle_animal', eval(bonus_handle_animal + 2))define(`bonus_ride', eval(bonus_ride + 2))')
ifdef(`feat_armor_proficiency_light',       `define(`proficiencies_armor', proficiencies_armor armor_class_light)')
ifdef(`feat_armor_proficiency_medium',      `define(`proficiencies_armor', proficiencies_armor armor_class_medium)')
ifdef(`feat_armor_proficiency_heavy',       `define(`proficiencies_armor', proficiencies_armor armor_class_heavy)')
ifdef(`feat_athletic',                      `define(`bonus_climb', eval(bonus_climb + 2))define(`bonus_swim', eval(bonus_swim + 2))')
dnl ifdef(`feat_augment_summoning',             `')
dnl ifdef(`feat_blind_fight',                   `')
dnl ifdef(`feat_brew_potion',                   `')
dnl ifdef(`feat_cleave',                        `')
ifdef(`feat_combat_casting',                `define(`mark_concentration', 1)')
dnl ifdef(`feat_combat_expertise',              `')
dnl ifdef(`feat_combat_reflexes',               `')
dnl ifdef(`feat_craft_magic_arms_and_armor',    `')
dnl ifdef(`feat_craft_rod',                     `')
dnl ifdef(`feat_craft_staff',                   `')
dnl ifdef(`feat_craft_wand',                    `')
dnl ifdef(`feat_craft_wondrous_item',           `')
ifdef(`feat_deceitful',                     `define(`bonus_disguise', eval(bonus_disguise + 2))define(`bonus_forgery', eval(bonus_forgery + 2))')
dnl ifdef(`feat_deflect_arrows',                `')
ifdef(`feat_deft_hands',                    `define(`bonus_sleight_of_hand', eval(bonus_sleight_of_hand + 2))define(`bonus_use_rope', eval(bonus_use_rope + 2))')
dnl ifdef(`feat_diehard',                       `')
ifdef(`feat_diligent',                      `define(`bonus_appraise', eval(bonus_appraise + 2))define(`bonus_decipher_script', eval(bonus_decipher_script + 2))')
ifdef(`feat_dodge',                         `define(`AC_dodge', eval(AC_dodge + 1))')
dnl ifdef(`feat_empower_spell',                 `')
dnl ifdef(`feat_endurance',                     `')
dnl ifdef(`feat_enlarge_spell',                 `')
dnl ifdef(`feat_eschew_materials',              `')
ifdef(`feat_exotic_weapon_proficiency',     `define(`proficiencies_weapons', proficiencies_weapons feat_exotic_weapon_proficiency)')
dnl ifdef(`feat_extend_spell',                  `')
dnl ifdef(`feat_extra_turning',                 `')
dnl ifdef(`feat_far_shot',                      `')
dnl ifdef(`feat_forge_ring',                    `')
dnl ifdef(`feat_great_cleave',                  `')
ifdef(`feat_great_fortitude',               `define(`save_fort_misc', eval(save_fort_misc + 2))')
ifdef(`feat_greater_spell_focus',           `check_magic_school(feat_greater_spell_focus)')dnl processed in spell_definitions.m4
dnl ifdef(`feat_greater_spell_penetration',     `')
dnl ifdef(`feat_greater_two_weapon_fighting',   `')
dnl ifdef(`feat_greater_weapon_focus',          `')dnl processed in martial.m4
dnl ifdef(`feat_greater_weapon_specialization', `')dnl processed in martial.m4
dnl ifdef(`feat_heighten_spell',                `')
dnl ifdef(`feat_improved_bull_rush',            `')
dnl ifdef(`feat_improved_counterspell',         `')
dnl ifdef(`feat_improved_critical',             `')
dnl ifdef(`feat_improved_disarm',               `')
dnl ifdef(`feat_improved_feint',                `')
dnl ifdef(`feat_improved_grapple',              `')
ifdef(`feat_improved_initiative',           `define(`init_misc', eval(init_misc + 4))')
dnl ifdef(`feat_improved_overrun',              `')
dnl ifdef(`feat_improved_precise_shot',         `')
dnl ifdef(`feat_improved_shield_bash',          `')
dnl ifdef(`feat_improved_sunder',               `')
dnl ifdef(`feat_improved_trip',                 `')
dnl ifdef(`feat_improved_turning',              `')
dnl ifdef(`feat_improved_two_weapon_fighting',  `')
dnl ifdef(`feat_improved_unarmed_strike',       `')
ifdef(`feat_investigator',                  `define(`bonus_gather_info', eval(bonus_gather_info + 2))define(`bonus_search', eval(bonus_search + 2))')
ifdef(`feat_iron_will',                     `define(`save_will_misc', eval(save_will_misc + 2))')
dnl ifdef(`feat_leadership',                    `')
ifdef(`feat_lightning_reflexes',            `define(`save_rflx_misc', eval(save_rflx_misc + 2))')
ifdef(`feat_magical_aptitude',              `define(`bonus_spellcraft', eval(bonus_spellcraft + 2))define(`bonus_use_magic_device', eval(bonus_use_magic_device + 2))')
dnl ifdef(`feat_manyshot',                      `')
ifdef(`feat_martial_weapon_proficiency',    `define(`proficiencies_weapons', proficiencies_weapons feat_martial_weapon_proficiency)')
dnl ifdef(`feat_maximize_spell',                `')
dnl ifdef(`feat_mobility',                      `')
dnl ifdef(`feat_mounted_archery',               `')
dnl ifdef(`feat_mounted_combat',                `')
dnl ifdef(`feat_natural_spell',                 `')
ifdef(`feat_negotiator',                    `define(`bonus_diplomacy', eval(bonus_diplomacy + 2))define(`bonus_sense_motive', eval(bonus_sense_motive + 2))')
ifdef(`feat_nimble_fingers',                `define(`bonus_disable_device', eval(bonus_disable_device + 2))define(`bonus_open_lock', eval(bonus_open_lock + 2))')
ifdef(`feat_persuasive',                    `define(`bonus_bluff', eval(bonus_bluff + 2))define(`bonus_intimidate', eval(bonus_intimidate + 2))')
dnl ifdef(`feat_point_blank_shot',              `')
dnl ifdef(`feat_power_attack',                  `')
dnl ifdef(`feat_precise_shot',                  `')
dnl ifdef(`feat_quick_draw',                    `')
dnl ifdef(`feat_quicken_spell',                 `')
dnl ifdef(`feat_rapid_reload',                  `')
dnl ifdef(`feat_rapid_shot',                    `')
dnl ifdef(`feat_ride_by_attack',                `')
ifdef(`feat_run',                           `define(`char_speed_max', 5)')
dnl ifdef(`feat_scribe_scroll',                 `')
ifdef(`feat_self_sufficient',               `define(`bonus_heal', eval(bonus_heal + 2))define(`bonus_survival', eval(bonus_survival + 2))')
ifdef(`feat_shield_proficiency',            `define(`proficiencies_shields', proficiencies_shields shield_class_normal)')
dnl ifdef(`feat_shot_on_the_run',               `')
dnl ifdef(`feat_silent_spell',                  `')
ifdef(`feat_simple_weapon_proficiency',     `define(`proficiencies_weapons', proficiencies_weapons weapon_class_simple)')
dnl ifdef(`feat_skill_focus',                   `')
dnl ifdef(`feat_snatch_arrows',                 `')
ifdef(`feat_spell_focus',                   `check_magic_school(feat_spell_focus)')dnl processed in spell_definitions.m4
dnl ifdef(`feat_spell_mastery',                 `')
dnl ifdef(`feat_spell_penetration',             `')
dnl ifdef(`feat_spirited_charge',               `')
dnl ifdef(`feat_spring_attack',                 `')
ifdef(`feat_stealthy',                      `define(`bonus_hide', eval(bonus_hide + 2))define(`bonus_move_silently', eval(bonus_move_silently + 2))')
dnl ifdef(`feat_still_spell',                   `')
dnl ifdef(`feat_stunning_fist',                 `')
ifdef(`feat_toughness',                     `define(`char_HP', eval(char_HP + 3 * feat_toughness))')
ifdef(`feat_tower_shield_proficiency',      `define(`proficiencies_shields', proficiencies_shields shield_class_tower)')
dnl ifdef(`feat_track',                         `')
dnl ifdef(`feat_trample',                       `')
dnl ifdef(`feat_two_weapon_defense',            `')
dnl ifdef(`feat_two_weapon_fighting',           `')
dnl ifdef(`feat_weapon_finesse',                `')dnl processed in martial.m4
dnl ifdef(`feat_weapon_focus',                  `')dnl processed in martial.m4, give a space-separated list of weapon tokens
dnl ifdef(`feat_weapon_specialization',         `')dnl processed in martial.m4, give a space-separated list of weapon tokens
dnl ifdef(`feat_whirlwind_attack',              `')
dnl ifdef(`feat_widen_spell',                   `')

dnl ***** Feats from Masters of the Wild
dnl ifdef(`feat_extra_wild_shape',              `')dnl processed above and in wild_shape.m4
dnl ifdef(`feat_improved_flight',               `')dnl for aerial movement maneuverabilities cf. DMG p.20
dnl ifdef(`feat_resistance_energy',               )dnl processed already above, because this is shown in the special abilities section an can stack with according abilities from other sources

dnl ***** Feats from Monster Manual I
dnl ifdef(`feat_hover',                         `')
dnl ifdef(`feat_wingover',                      `')

dnl ***** Feats from Complete Champion
dnl ifdef(`feat_air_devotion',                     `')
dnl ifdef(`feat_animal_devotion',                  `')
dnl ifdef(`feat_awesome_smite',                    `')
dnl ifdef(`feat_battle_blessing',                  `')
dnl ifdef(`feat_bestial_charge',                   `')
dnl ifdef(`feat_chaos_devotion',                   `')
dnl ifdef(`feat_charnel_miasma',                   `')dnl secondary benefit implemented in spells_definitions.m4
dnl ifdef(`feat_death_devotion',                   `')
dnl ifdef(`feat_destruction_devotion',             `')
dnl ifdef(`feat_earth_devotion',                   `')
dnl ifdef(`feat_elemental_essence',                `')
dnl ifdef(`feat_evil_devotion',                    `')
dnl ifdef(`feat_fire_devotion',                    `')
dnl ifdef(`feat_fragile_construct',                `')
dnl ifdef(`feat_good_devotion',                    `')
dnl ifdef(`feat_great_and_small',                  `')
dnl ifdef(`feat_healing_devotion',                 `')
dnl ifdef(`feat_holy_potency',                     `')
dnl ifdef(`feat_holy_warrior',                     `')dnl secondary benefit implemented in spells_definitions.m4
dnl ifdef(`feat_imbued_healing',                   `')
dnl ifdef(`feat_knowledge_devotion',               `')
dnl ifdef(`feat_law_devotion',                     `')
dnl ifdef(`feat_luck_devotion',                    `')
dnl ifdef(`feat_magic_devotion',                   `')
dnl ifdef(`feat_mitigate_suffering',               `')dnl secondary benefit implemented in spells_definitions.m4
dnl ifdef(`feat_plant_devotion',                   `')
dnl ifdef(`feat_protection_devotion',              `')
dnl ifdef(`feat_protective_ward',                  `')dnl secondary benefit implemented in spells_definitions.m4
dnl ifdef(`feat_retrieve_spell',                   `')
dnl ifdef(`feat_spiritual_counter',                `')
dnl ifdef(`feat_spontaneous_domain',               `')
dnl ifdef(`feat_strength_devotion',                `')
dnl ifdef(`feat_sun_devotion',                     `')
dnl ifdef(`feat_swift_call',                       `')
dnl ifdef(`feat_swift_wild_shape',                 `')
dnl ifdef(`feat_touch_of_healing',                 `')dnl secondary benefit implemented in spells_definitions.m4
dnl ifdef(`feat_travel_devotion',                  `')
dnl ifdef(`feat_trickery_devotion',                `')
dnl ifdef(`feat_umbral_shroud',                    `')
dnl ifdef(`feat_venoms_gift',                      `')
dnl ifdef(`feat_war_devotion',                     `')
dnl ifdef(`feat_water_devotion',                   `')

dnl ***** Feats from Frostburn
dnl ifdef(`feat_cold_endurance',                   `')
dnl ifdef(`feat_cold_focus',                       `')dnl processed in spell_definitions.m4
dnl ifdef(`feat_greater_cold_focus',               `')dnl processed in spell_definitions.m4
dnl ifdef(`feat_improved_cold_endurance',          `')

dnl ***** Feats from Epic Level Handbook
dnl ifdef(`feat_additional_magic_item_space',       `')
ifdef(`feat_armor_skin',                        `define(`AC_nature', eval(AC_nature + 2 * feat_armor_skin))')
dnl ifdef(`feat_augmented_alchemy',                 `')
dnl ifdef(`feat_automatic_quicken_spell',           `')
dnl ifdef(`feat_automatic_silent_spell',            `')
dnl ifdef(`feat_automatic_still_spell',             `')
dnl ifdef(`feat_bane_of_enemies',                   `')
dnl ifdef(`feat_beast_companion',                   `')
dnl ifdef(`feat_beast_wild_shape',                  `')dnl implemented in wild_shape.m4
dnl ifdef(`feat_blinding_speed',                    `')
dnl ifdef(`feat_bonus_domain',                      `')dnl add this to `char_domains' macro, then done in spell_definitions.m4
dnl ifdef(`feat_bulwark_of_defence',                `')
dnl ifdef(`feat_chaotic_rage',                      `')dnl implemented in barbarian rage class feature
dnl ifdef(`feat_colossal_wild_shape',               `')dnl implemented in wild_shape.m4
dnl ifdef(`feat_combat_archery',                    `')
dnl ifdef(`feat_craft_epic_magic_arms_and_armor',   `')
dnl ifdef(`feat_craft_epic_rod',                    `')
dnl ifdef(`feat_craft_epic_staff',                  `')
dnl ifdef(`feat_craft_epic_wondrous_item',          `')
dnl ifdef(`feat_damage_reduction',                  `')
dnl ifdef(`feat_deafening_song',                    `')
dnl ifdef(`feat_death_of_enemies',                  `')
dnl ifdef(`feat_devasting_critical',                `')
dnl ifdef(`feat_dexterous_fortitude',               `')
dnl ifdef(`feat_dexterous_will',                    `')
dnl ifdef(`feat_diminutive_wild_shape',             `')dnl implemented in wild_shape.m4
dnl ifdef(`feat_dire_charge',                       `')
dnl ifdef(`feat_distant_shot',                      `')
dnl ifdef(`feat_dragon_wild_shape',                 `')dnl implemented in wild_shape.m4
dnl ifdef(`feat_efficient_item_creation',           `')
dnl ifdef(`feat_energy_resistance',                 `')
dnl ifdef(`feat_enhance_spell',                     `')
dnl ifdef(`feat_epic_dodge',                        `')
dnl ifdef(`feat_epic_endurance',                    `')
ifdef(`feat_epic_fortitude',                    `define(`save_fort_misc', eval(save_fort_misc + 4))')
dnl ifdef(`feat_epic_inspiration',                  `')
dnl ifdef(`feat_epic_leadership',                   `')
dnl ifdef(`feat_epic_prowess',                      `')dnl implemented in martial.m4
ifdef(`feat_epic_reflexes',                     `define(`save_rflx_misc', eval(save_rflx_misc + 4))')
ifdef(`feat_epic_reputation',                   `define(`bonus_bluff', eval(bonus_bluff + 4))define(`bonus_diplomacy', eval(bonus_diplomacy + 4))define(`bonus_gather_info', eval(bonus_gather_info + 4))define(`bonus_intimidate', eval(bonus_intimidate + 4))define(`bonus_perform_act', eval(bonus_perform_act + 4))define(`bonus_perform_comedy', eval(bonus_perform_comedy + 4))define(`bonus_perform_dance', eval(bonus_perform_dance + 4))define(`bonus_perform_keyboard', eval(bonus_perform_keyboard + 4))define(`bonus_perform_oratory', eval(bonus_perform_oratory + 4))define(`bonus_perform_percussion', eval(bonus_perform_percussion + 4))define(`bonus_perform_sing', eval(bonus_perform_sing + 4))define(`bonus_perform_string', eval(bonus_perform_string + 4))define(`bonus_perform_wind', eval(bonus_perform_wind + 4))')
dnl ifdef(`feat_epic_skill_focus',                  `')
dnl ifdef(`feat_epic_speed',                        `')
dnl ifdef(`feat_epic_spell_focus',                  `')
dnl ifdef(`feat_epic_spell_penetration',            `')
dnl ifdef(`feat_epic_spellcasting',                 `')
ifdef(`feat_epic_toughness',                    `define(`char_HP', eval(char_HP + 20 * feat_epic_toughness))')
dnl ifdef(`feat_epic_weapon_focus',                   )dnl processed in martial.m4, give a space-separated list of weapon tokens
dnl ifdef(`feat_epic_weapon_specialization',        `')dnl processed in martial.m4, give a space-separated list of weapon tokens
ifdef(`feat_epic_will',                         `define(`save_will_misc', eval(save_will_misc + 4))')
dnl ifdef(`feat_exceptional_deflection',            `')
dnl ifdef(`feat_extended_life_span',                `')
dnl ifdef(`feat_familiar_spell',                    `')
dnl ifdef(`feat_fast_healing',                      `')
dnl ifdef(`feat_fine_wild_shape',                   `')
dnl ifdef(`feat_forge_epic_ring',                   `')
dnl ifdef(`feat_gargantuan_wild_shape',             `')dnl implemented in wild_shape.m4
ifdef(`feat_great_charisma',                    `define(`CHA_score', eval(CHA_score + feat_great_charisma))')
ifdef(`feat_great_constitution',                `define(`CON_score', eval(CON_score + feat_great_constitution))')
ifdef(`feat_great_dexterity',                   `define(`DEX_score', eval(DEX_score + feat_great_dexterity))')
ifdef(`feat_great_intelligence',                `define(`INT_score', eval(INT_score + feat_great_intelligence))')
dnl ifdef(`feat_great_smiting',                     `')
ifdef(`feat_great_strength',                    `define(`STR_score', eval(STR_score + feat_great_strength))')
ifdef(`feat_great_wisdom',                      `define(`WIS_score', eval(WIS_score + feat_great_wisdom))')
dnl ifdef(`feat_group_inspiration',                 `')
dnl ifdef(`feat_hindering_song',                    `')
dnl ifdef(`feat_holy_strike',                       `')
dnl ifdef(`feat_ignore_material_components',        `')
dnl ifdef(`feat_improved_alignment_based_casting',  `')
dnl ifdef(`feat_improved_arrow_of_death',           `')
dnl ifdef(`feat_improved_aura_of_courage',          `')
dnl ifdef(`feat_improved_aura_of_despair',          `')
dnl ifdef(`feat_improved_combat_casting',           `')
dnl ifdef(`feat_improved_combat_reflexes',          `')
dnl ifdef(`feat_improved_darkvision',               `')
dnl ifdef(`feat_improved_death_attack',             `')
dnl ifdef(`feat_improved_elemental_wild_shape',     `')dnl implemented in wild_shape.m4
dnl ifdef(`feat_improved_favored_enemy',            `')
dnl ifdef(`feat_improved_heighten_spell',           `')
dnl ifdef(`feat_improved_ki_strike',                `')
dnl ifdef(`feat_improved_low_light_vision',         `')
dnl ifdef(`feat_improved_manifestation',            `')
dnl ifdef(`feat_improved_manyshot',                 `')
dnl ifdef(`feat_improved_metamagic',                `')
dnl ifdef(`feat_improved_sneak_attack',             `')
dnl ifdef(`feat_improved_spell_capacity',             )dnl implemented in spells.m4
dnl ifdef(`feat_improved_spell_resistance',         `')
dnl ifdef(`feat_improved_stunning_fist',            `')
dnl ifdef(`feat_improved_whirlwind_attack',         `')
dnl ifdef(`feat_incite_rage',                       `')
dnl ifdef(`feat_infinite_deflection',               `')
dnl ifdef(`feat_inspire_excellence',                `')
dnl ifdef(`feat_instant_reload',                    `')
dnl ifdef(`feat_intensify_spell',                   `')
dnl ifdef(`feat_keen_strike',                       `')
dnl ifdef(`feat_lasting_inspiration',               `')
dnl ifdef(`feat_legendary_climber',                 `')
dnl ifdef(`feat_legendary_commander',               `')
dnl ifdef(`feat_legendary_leaper',                  `')
dnl ifdef(`feat_legendary_rider',                   `')
dnl ifdef(`feat_legendary_tracker',                 `')
dnl ifdef(`feat_legendary_wrestler',                `')
dnl ifdef(`feat_lingering_damage',                  `')
dnl ifdef(`feat_magical_beast_wild_shape',          `')dnl implemented in wild_shape.m4
dnl ifdef(`feat_master_staff',                      `')
dnl ifdef(`feat_master_wand',                       `')
dnl ifdef(`feat_mobile_defense',                    `')
dnl ifdef(`feat_multispell',                        `')
dnl ifdef(`feat_multiweapon_rend',                  `')
dnl ifdef(`feat_music_of_the_gods',                 `')
dnl ifdef(`feat_negative_energy_burst',             `')
dnl ifdef(`feat_overwhelming_critical',             `')
dnl ifdef(`feat_penetrate_damage_reduction',        `')
dnl ifdef(`feat_perfect_health',                    `')
dnl ifdef(`feat_perfect_multiweapon_fighting',      `')
dnl ifdef(`feat_perfect_two_weapon_fighting',       `')
dnl ifdef(`feat_permanent_emanation',               `')
dnl ifdef(`feat_planar_turning',                    `')
dnl ifdef(`feat_polyglot',                          `')
dnl ifdef(`feat_positive_energy_aura',              `')
dnl ifdef(`feat_ranged_inspiration',                `')
dnl ifdef(`feat_rapid_inspiration',                 `')
dnl ifdef(`feat_reactive_countersong',              `')
dnl ifdef(`feat_reflect_arrows',                    `')
dnl ifdef(`feat_righteous_strike',                  `')
dnl ifdef(`feat_ruinous_rage',                      `')
dnl ifdef(`feat_scribe_epic_scroll',                `')
dnl ifdef(`feat_self_concealment',                  `')
dnl ifdef(`feat_shattering_strike',                 `')
dnl ifdef(`feat_sneak_attack_of_opportunity',       `')
dnl ifdef(`feat_spectral_strike',                   `')
dnl ifdef(`feat_spell_knowledge',                   `')
dnl ifdef(`feat_spell_opportunity',                 `')
dnl ifdef(`feat_spell_stowaway',                    `')
dnl ifdef(`feat_spellcasting_harrier',              `')
dnl ifdef(`feat_spontaneous_domain_access',         `')
dnl ifdef(`feat_spontaneous_spell',                 `')
dnl ifdef(`feat_storm_of_throws',                   `')
dnl ifdef(`feat_superior_initiative',               `')
dnl ifdef(`feat_swarm_of_arrows',                   `')
dnl ifdef(`feat_tenacious_magic',                   `')
dnl ifdef(`feat_terrifying_rage',                   `')
dnl ifdef(`feat_thundering_rage',                   `')
dnl ifdef(`feat_trap_sense',                        `')
dnl ifdef(`feat_two_weapon_rend',                   `')
dnl ifdef(`feat_uncanny_accuracy',                  `')
dnl ifdef(`feat_undead_mastery',                    `')
dnl ifdef(`feat_unholy_strike',                     `')
dnl ifdef(`feat_vermin_wild_shape',                 `')dnl implemented in wild_shape.m4
dnl ifdef(`feat_vorpal_strike',                     `')
dnl ifdef(`feat_widen_aura_of_courage',             `')
dnl ifdef(`feat_widen_aura_of_despair',             `')
dnl ifdef(`feat_zone_of_animation',                 `')
dnl ifdef(`feat_greater_multiweapon_fighting',      `')
dnl ifdef(`feat_improved_multiattack',              `')
dnl ifdef(`feat_improved_flyby_attack',             `')
dnl ifdef(`feat_improved_multiweapon_fighting',     `')


define(`feat_animal_defiance_level', eval(calc_max(level_cleric, level_druid, level_paladin, level_ranger) + ifdef(`feat_improved_turning',1,0)))dnl
ifelse(eval(ifdef(`feat_animal_defiance',1,0)  &&  (feat_animal_defiance_level > 0)),1,`dnl
define(`show_turning_abilities', show_turning_abilities`'ifelse(show_turning_abilities,,,\\ )dnl
\begin{boxedminipage}[t]{\linewidth}
	\underline{\textbf{Turning ifdef(`feat_animal_control', `and Mastering ')Animals:}}\\
	\begin{tabular}[t]{l@{ : }l}
		uses per day        & eval(3 + CHA + (4 * ifdef(`feat_extra_turning',feat_extra_turning,0))) \\
		highest HD affected & apply 1D20{}emph_sign(CHA) to the table below \\dnl perhaps add +2 if Knowledge Nature >= 5 ranks (cf. Knowledge Religion for turning undead, PHB table 4-5, p.66)
		total HD affected   & 2D6+eval(feat_animal_defiance_level + CHA) \\
		ifdef(`feat_animal_control', `highest HD mastered & eval(feat_animal_defiance_level / 2) \\')%
	\end{tabular}
	\\[0.5ex]
	\setlength{\tabcolsep}{0.75\tabcolsep}
	\begin{tabular}[t]{|c||*{ifelse(dnl
eval((feat_animal_defiance_level >= 5) && (1 + CHA <=  0)),1,9,dnl
eval((feat_animal_defiance_level >= 4) && (1 + CHA <=  3)),1,8,dnl
eval((feat_animal_defiance_level >= 3) && (1 + CHA <=  6)),1,7,dnl
eval((feat_animal_defiance_level >= 2) && (1 + CHA <=  9)),1,6,dnl
eval((feat_animal_defiance_level >= 1) && (1 + CHA <= 12)),1,5,4)}{c|}}
 	\hline
	Roll & %
	ifelse(eval((feat_animal_defiance_level >= 5) && (1 + CHA <=  0)),1,$\le${}0 &) %
	ifelse(eval((feat_animal_defiance_level >= 4) && (1 + CHA <=  3)),1,     1-3 &) %
	ifelse(eval((feat_animal_defiance_level >= 3) && (1 + CHA <=  6)),1,     4-6 &) %
	ifelse(eval((feat_animal_defiance_level >= 2) && (1 + CHA <=  9)),1,     7-9 &) %
	ifelse(eval((feat_animal_defiance_level >= 1) && (1 + CHA <= 12)),1,   10-12 &) %
	13-15 & 16-18 & 19-21 & $\ge${}22 \\ \hline
	HD & %
	ifelse(eval((feat_animal_defiance_level >= 5) && (1 + CHA <=  0)),1,eval(feat_animal_defiance_level - 4) &) %
	ifelse(eval((feat_animal_defiance_level >= 4) && (1 + CHA <=  3)),1,eval(feat_animal_defiance_level - 3) &) %
	ifelse(eval((feat_animal_defiance_level >= 3) && (1 + CHA <=  6)),1,eval(feat_animal_defiance_level - 2) &) %
	ifelse(eval((feat_animal_defiance_level >= 2) && (1 + CHA <=  9)),1,eval(feat_animal_defiance_level - 1) &) %
	ifelse(eval((feat_animal_defiance_level >= 1) && (1 + CHA <= 12)),1,eval(feat_animal_defiance_level    ) &) %
	eval(feat_animal_defiance_level + 1) & %
	eval(feat_animal_defiance_level + 2) & %
	eval(feat_animal_defiance_level + 3) & %
	eval(feat_animal_defiance_level + 4) \\
	\hline
  	\end{tabular}
\end{boxedminipage}\\[2ex])')

dnl ***** now the sheet notifications, including a marker if processed completely
ifdef(`feat_acrobatic',                         `define(`show_feats', show_feats\\ Acrobatic (p.89) \done)')
ifdef(`feat_additional_magic_item_space',       `define(`show_feats', show_feats\\ Additional Magic Item Space (ELH p.50))')
ifdef(`feat_agile',                             `define(`show_feats', show_feats\\ Agile (p.89) \done)')
ifdef(`feat_air_devotion',                      `define(`show_feats', show_feats\\ Air Devotion (CPC p.54): +`'calc_min(6, eval(1 + level_total / 4)) ifelse(regexp(char_patron_deity_alignment,`E$'),-1,sacred,profane) AC\komma 50\% miss chance for thrown/projectile)')
ifdef(`feat_alertness',                         `define(`show_feats', show_feats\\ Alertness (p.89) \done)')
ifdef(`feat_animal_affinity',                   `define(`show_feats', show_feats\\ Animal Affinity (p.89) \done)')
ifdef(`feat_animal_control',                    `define(`show_feats', show_feats\\ Animal Control (MOW p.20) \done)')
ifdef(`feat_animal_defiance',                   `define(`show_feats', show_feats\\ Animal Defiance (MOW p.20) \done)')
ifdef(`feat_animal_devotion',                   `define(`show_feats', show_feats\\ Animal Devotion (CPC p.54): +`'calc_min(8, eval(2 * (1 + level_total / 6))) S{}T{}R score or +`'calc_min(30, eval(5 * (1 + level_total / 4))) speed\\ \hspace*{2ex} or fly +`'calc_min(20, eval(5 * (level_total / 5))) speed or 1D3 venomous bite (Fort.~DC~`'eval(10 + level_total / 2 + CHA)))')
ifdef(`feat_arctic_priest',                     `define(`show_feats', show_feats\\ Arctic Priest (FRB p.46))')
ifdef(`feat_armor_skin',                        `define(`show_feats', show_feats\\ Armor Skin (ELH p.50) \done)')
ifdef(`feat_armor_proficiency_light',           `define(`show_feats', show_feats\\ Armor Proficiency (light) (p.89) \done)')
ifdef(`feat_armor_proficiency_medium',          `define(`show_feats', show_feats\\ Armor Proficiency (medium) (p.89) \done)')
ifdef(`feat_armor_proficiency_heavy',           `define(`show_feats', show_feats\\ Armor Proficiency (heavy) (p.89) \done)')
ifdef(`feat_athletic',                          `define(`show_feats', show_feats\\ Athletic (p.89) \done)')
ifdef(`feat_augment_summoning',                 `define(`show_feats', show_feats\\ Augment Summoning (p.89))')
ifdef(`feat_augmented_alchemy',                 `define(`show_feats', show_feats\\ Augmented Alchemy (ELH p.50))')
ifdef(`feat_automatic_quicken_spell',           `define(`show_feats', show_feats\\ Automatic Quicken Spell (ELH p.50))')
ifdef(`feat_automatic_silent_spell',            `define(`show_feats', show_feats\\ Automatic Silent Spell (ELH p.51))')
ifdef(`feat_automatic_still_spell',             `define(`show_feats', show_feats\\ Automatic Still Spell (ELH p.51))')
ifdef(`feat_awesome_smite',                     `define(`show_feats', show_feats\\ Awesome Smite (CPC p.55))')
ifdef(`feat_bane_of_enemies',                   `define(`show_feats', show_feats\\ Bane of Enemies (ELH p.51))')
ifdef(`feat_battle_blessing',                   `define(`show_feats', show_feats\\ Battle Blessing (CPC p.55))')
ifdef(`feat_beast_companion',                   `define(`show_feats', show_feats\\ Beast Companion (ELH p.51))')
ifdef(`feat_beast_wild_shape',                  `define(`show_feats', show_feats\\ Beast Wild Shape (ELH p.51) \done)')
ifdef(`feat_bestial_charge',                    `define(`show_feats', show_feats\\ Bestial Charge (CPC p.56))')
ifdef(`feat_blind_fight',                       `define(`show_feats', show_feats\\ Blind Fighting (p.89))')
ifdef(`feat_blinding_speed',                    `define(`show_feats', show_feats\\ Blinding Speed (ELH p.51))')
ifdef(`feat_bonus_domain',                      `define(`show_feats', show_feats\\ Bonus Domain (ELH p.51))')
ifdef(`feat_brew_potion',                       `define(`show_feats', show_feats\\ Brew Potion (p.89))')
ifdef(`feat_bulwark_of_defence',                `define(`show_feats', show_feats\\ Bulwark of Defence (ELH p.51))')
ifdef(`feat_chaos_devotion',                    `define(`show_feats', show_feats\\ Chaos Devotion (CPC p.56): +1D`'ifelse(eval(level_total >= 15),1,10,eval(level_total >= 10),1,8,6) ifelse(regexp(char_patron_deity_alignment,`E$'),-1,sacred,profane) AC (even) or\\ \hspace*{2ex} attack (odd)\komma reroll each rnd.)')
ifdef(`feat_chaotic_rage',                      `define(`show_feats', show_feats\\ Chaotic Rage (ELH p.51))')
ifdef(`feat_charnel_miasma',                    `define(`show_feats', show_feats\\ Charnel Miasma (CPC p.57))')
ifdef(`feat_cleave',                            `define(`show_feats', show_feats\\ Cleave (p.92))')
ifdef(`feat_cold_endurance',                    `define(`show_feats', show_feats\\ Cold Endurance (FRB p.47))')
ifdef(`feat_cold_focus',                        `define(`show_feats', show_feats\\ Cold Focus (FRB p.47) \done)')
ifdef(`feat_colossal_wild_shape',               `define(`show_feats', show_feats\\ Colossal Wild Shape (ELH p.52) \done)')
ifdef(`feat_combat_archery',                    `define(`show_feats', show_feats\\ Combat Archery (ELH p.52))')
ifdef(`feat_combat_casting',                    `define(`show_feats', show_feats\\ Combat Casting (p.92))')
ifdef(`feat_combat_expertise',                  `define(`show_feats', show_feats\\ Combat Expertise (p.92))')
ifdef(`feat_combat_reflexes',                   `define(`show_feats', show_feats\\ Combat Reflexes (p.92))')
ifdef(`feat_craft_epic_magic_arms_and_armor',   `define(`show_feats', show_feats\\ Craft Epic Magic Arms and Armor (ELH p.52))')
ifdef(`feat_craft_epic_rod',                    `define(`show_feats', show_feats\\ Craft Epic Rod (ELH p.52))')
ifdef(`feat_craft_epic_staff',                  `define(`show_feats', show_feats\\ Craft Epic Staff (ELH p.52))')
ifdef(`feat_craft_epic_wondrous_item',          `define(`show_feats', show_feats\\ Craft Epic Wondrous Item (ELH p.52))')
ifdef(`feat_craft_magic_arms_and_armor',        `define(`show_feats', show_feats\\ Craft Magic Arms and Armor (p.92))')
ifdef(`feat_craft_rod',                         `define(`show_feats', show_feats\\ Craft Rod (p.92))')
ifdef(`feat_craft_staff',                       `define(`show_feats', show_feats\\ Craft Staff (p.92))')
ifdef(`feat_craft_wand',                        `define(`show_feats', show_feats\\ Craft Wand (p.92))')
ifdef(`feat_craft_wondrous_item',               `define(`show_feats', show_feats\\ Craft Wondrous Item (p.92))')
ifdef(`feat_damage_reduction',                  `define(`show_feats', show_feats\\ Damage Reduction (ELH p.52))')
ifdef(`feat_deafening_song',                    `define(`show_feats', show_feats\\ Deafening Song (ELH p.52))')
ifdef(`feat_death_devotion',                    `define(`show_feats', show_feats\\ Death Devotion (CPC p.57): max.~`'calc_max(1, calc_min(5, eval(level_total / 4))) negative levels\komma Fort.~DC eval(10 + level_total / 2 + CHA))')
ifdef(`feat_death_of_enemies',                  `define(`show_feats', show_feats\\ Death of Enemies (ELH p.52))')
ifdef(`feat_deceitful',                         `define(`show_feats', show_feats\\ Deceitful (p.93) \done)')
ifdef(`feat_deflect_arrows',                    `define(`show_feats', show_feats\\ Deflect Arrow (p.93))')
ifdef(`feat_deft_hands',                        `define(`show_feats', show_feats\\ Deft Hands (p.93))')
ifdef(`feat_destruction_devotion',              `define(`show_feats', show_feats\\ Destruction Devotion (CPC p.57): reduce AC by ifelse(eval(level_total >= 10),1,2,1) per hit)')
ifdef(`feat_devasting_critical',                `define(`show_feats', show_feats\\ Devasting Critical (ELH p.53))')
ifdef(`feat_dexterous_fortitude',               `define(`show_feats', show_feats\\ Dexterous Fortitude (ELH p.53))')
ifdef(`feat_dexterous_will',                    `define(`show_feats', show_feats\\ Dexterous Will (ELH p.53))')
ifdef(`feat_diehard',                           `define(`show_feats', show_feats\\ Diehard (p.93))')
ifdef(`feat_diligent',                          `define(`show_feats', show_feats\\ Diligent (p.93) \done)')
ifdef(`feat_diminutive_wild_shape',             `define(`show_feats', show_feats\\ Diminutive Wild Shape (ELH p.53) \done)')
ifdef(`feat_dire_charge',                       `define(`show_feats', show_feats\\ Dire Charge (ELH p.53))')
ifdef(`feat_distant_shot',                      `define(`show_feats', show_feats\\ Distant Shot (ELH p.53))')
ifdef(`feat_dodge',                             `define(`show_feats', show_feats\\ Dodge (p.93) \done)')
ifdef(`feat_dragon_wild_shape',                 `define(`show_feats', show_feats\\ Dragon Wild Shape (ELH p.53) \done)')
ifdef(`feat_earth_devotion',                    `define(`show_feats', show_feats\\ Earth Devotion (CPC p.58))')
ifdef(`feat_efficient_item_creation',           `define(`show_feats', show_feats\\ Efficient Item Creation (ELH p.53))')
ifdef(`feat_elemental_essence',                 `define(`show_feats', show_feats\\ Elemental Essence (CPC p.58))')
ifdef(`feat_empower_mystery',                   `define(`show_feats', show_feats\\ Empower Mystery (ToM p.136))')
ifdef(`feat_empower_spell',                     `define(`show_feats', show_feats\\ Empower Spell (p.93))')
ifdef(`feat_endurance',                         `define(`show_feats', show_feats\\ Endurance (p.93))')
ifdef(`feat_energy_resistance',                 `define(`show_feats', show_feats\\ Energy Resistance (ELH p.53))')
ifdef(`feat_enhance_spell',                     `define(`show_feats', show_feats\\ Enhance Spell (ELH p.53))')
ifdef(`feat_enlarge_mystery',                   `define(`show_feats', show_feats\\ Enlarge Mystery (ToM p.136))')
ifdef(`feat_enlarge_spell',                     `define(`show_feats', show_feats\\ Enlarge Spell (p.94))')
ifdef(`feat_epic_dodge',                        `define(`show_feats', show_feats\\ Epic Dodge (ELH p.54))')
ifdef(`feat_epic_endurance',                    `define(`show_feats', show_feats\\ Epic Endurance (ELH p.54))')
ifdef(`feat_epic_fortitude',                    `define(`show_feats', show_feats\\ Epic Fortitude (ELH p.54) \done)')
ifdef(`feat_epic_inspiration',                  `define(`show_feats', show_feats\\ Epic Inspiration (ELH p.54))')
ifdef(`feat_epic_leadership',                   `define(`show_feats', show_feats\\ Epic Leadership (ELH p.54))')
ifdef(`feat_epic_prowess',                      `define(`show_feats', show_feats\\ Epic Prowess (ELH p.54) \done)')
ifdef(`feat_epic_reflexes',                     `define(`show_feats', show_feats\\ Epic Reflexes (ELH p.54) \done)')
ifdef(`feat_epic_reputation',                   `define(`show_feats', show_feats\\ Epic Reputation (ELH p.54) \done)')
ifdef(`feat_epic_skill_focus',                  `define(`show_feats', show_feats\\ Epic Skill Focus (ELH p.54))')
ifdef(`feat_epic_speed',                        `define(`show_feats', show_feats\\ Epic Speed (ELH p.54))')
ifdef(`feat_epic_spell_focus',                  `define(`show_feats', show_feats\\ Epic Spell Focus (ELH p.54))')
ifdef(`feat_epic_spell_penetration',            `define(`show_feats', show_feats\\ Epic Spell Penetration (ELH p.54))')
ifdef(`feat_epic_spellcasting',                 `define(`show_feats', show_feats\\ Epic Spellcasting (ELH p.55))')
ifdef(`feat_epic_toughness',                    `define(`show_feats', show_feats\\ Epic Toughness (ELH p.55) \done)')
ifdef(`feat_epic_weapon_focus',                 `define(`show_feats', show_feats\\ Epic Weapon Focus (ELH p.55) \done)')
ifdef(`feat_epic_weapon_specialization',        `define(`show_feats', show_feats\\ Epic Weapon Specialization (ELH p.55) \done)')
ifdef(`feat_epic_will',                         `define(`show_feats', show_feats\\ Epic Will (ELH p.55) \done)')
ifdef(`feat_eschew_materials',                  `define(`show_feats', show_feats\\ Eschew Materials (p.94) \done)')
ifdef(`feat_evil_devotion',                     `define(`show_feats', show_feats\\ Evil Devotion (CPC p.58): Damage Reduction calc_min(5, eval(1 + level_total / 5))`'/good)')
ifdef(`feat_exceptional_deflection',            `define(`show_feats', show_feats\\ Exceptional Deflection (ELH p.55))')
ifdef(`feat_exotic_weapon_proficiency',         `define(`show_feats', show_feats\\ Exotic Weapon Proficiency (p.94) \done)')
ifdef(`feat_extend_mystery',                    `define(`show_feats', show_feats\\ Extend Mystery (ToM p.136))')
ifdef(`feat_extend_spell',                      `define(`show_feats', show_feats\\ Extend Spell (p.94))')
ifdef(`feat_extended_life_span',                `define(`show_feats', show_feats\\ Extended Life Span (ELH p.56))')
ifdef(`feat_extra_turning',                     `define(`show_feats', show_feats\\ Extra Turning (p.94) \done)')
ifdef(`feat_extra_wild_shape',                  `define(`show_feats', show_feats\\ Extra Wild Shape (MOW p.22) \done)')
ifdef(`feat_familiar_spell',                    `define(`show_feats', show_feats\\ Familiar Spell (ELH p.56))')
ifdef(`feat_far_shot',                          `define(`show_feats', show_feats\\ Far Shot (p.94) \done)')
ifdef(`feat_fast_healing',                      `define(`show_feats', show_feats\\ Fast Healing (ELH p.56))')
ifdef(`feat_favored_mystery',                   `define(`show_feats', show_feats\\ Favored Mystery (ToM p.136))')
ifdef(`feat_fine_wild_shape',                   `define(`show_feats', show_feats\\ Fine Wild Shape (ELH p.56) \done)')
ifdef(`feat_fire_devotion',                     `define(`show_feats', show_feats\\ Fire Devotion (CPC p.58): deal plus calc_min(7, eval(1 + level_total / 3)) fire\komma Reflex DC eval(10 + level_total + CHA))')
ifdef(`feat_forge_epic_ring',                   `define(`show_feats', show_feats\\ Forge Epic Ring (ELH p.56))')
ifdef(`feat_forge_ring',                        `define(`show_feats', show_feats\\ Forge Ring (p.94))')
ifdef(`feat_fragile_construct',                 `define(`show_feats', show_feats\\ Fragile Construct (CPC p.58))')
ifdef(`feat_gargantuan_wild_shape',             `define(`show_feats', show_feats\\ Gargantuan Wild Shape (ELH p.56) \done)')
ifdef(`feat_good_devotion',                     `define(`show_feats', show_feats\\ Good Devotion (CPC p.58): Damage Reduction calc_min(5, eval(1 + level_total / 5))`'/evil)')
ifdef(`feat_great_and_small',                   `define(`show_feats', show_feats\\ Great and Small (CPC p.59): {level_total}~min.)')
ifdef(`feat_great_charisma',                    `define(`show_feats', show_feats\\ Great Charisma (ELH p.56) \done)')
ifdef(`feat_great_cleave',                      `define(`show_feats', show_feats\\ Great Cleave (p.94))')
ifdef(`feat_great_constitution',                `define(`show_feats', show_feats\\ Great Constitution (ELH p.56) \done)')
ifdef(`feat_great_dexterity',                   `define(`show_feats', show_feats\\ Great Dexterity (ELH p.56) \done)')
ifdef(`feat_great_fortitude',                   `define(`show_feats', show_feats\\ Great Fortitude (p.94) \done)')
ifdef(`feat_great_intelligence',                `define(`show_feats', show_feats\\ Great Intelligence (ELH p.56) \done)')
ifdef(`feat_great_smiting',                     `define(`show_feats', show_feats\\ Great Smiting (ELH p.56))')
ifdef(`feat_great_strength',                    `define(`show_feats', show_feats\\ Great Strength (ELH p.57) \done)')
ifdef(`feat_great_wisdom',                      `define(`show_feats', show_feats\\ Great Wisdom (ELH p.57) \done)')
ifdef(`feat_greater_cold_focus',                `define(`show_feats', show_feats\\ Greater Cold Focus (FRB p.48) \done)')
ifdef(`feat_greater_multiweapon_fighting',      `define(`show_feats', show_feats\\ Greater Multiweapon Fighting (ELH p.69))')
ifdef(`feat_greater_path_focus',                `define(`show_feats', show_feats\\ Greater Path Focus (ToM p.136))')
ifdef(`feat_greater_spell_focus',               `define(`show_feats', show_feats\\ Greater Spell Focus (p.94) \done)')
ifdef(`feat_greater_spell_penetration',         `define(`show_feats', show_feats\\ Greater Spell Penetration (p.94))')
ifdef(`feat_greater_two_weapon_fighting',       `define(`show_feats', show_feats\\ Greater Two Weapon Fighting (p.95))')
ifdef(`feat_greater_weapon_focus',              `define(`show_feats', show_feats\\ Greater Weapon Focus (p.95) \done)')
ifdef(`feat_greater_weapon_specialization',     `define(`show_feats', show_feats\\ Greater Weapon Specialization (p.95) \done)')
ifdef(`feat_group_inspiration',                 `define(`show_feats', show_feats\\ Group Inspiration (ELH p.57))')
ifdef(`feat_healing_devotion',                  `define(`show_feats', show_feats\\ Healing Devotion (CPC p.59): fast healing calc_min(5, eval(1 + level_total / 5)))')
ifdef(`feat_heighten_spell',                    `define(`show_feats', show_feats\\ Heighten Spell (p.95))')
ifdef(`feat_hindering_song',                    `define(`show_feats', show_feats\\ Hindering Song (ELH p.57))')
ifdef(`feat_holy_potency',                      `define(`show_feats', show_feats\\ Holy Potency (CPC p.59): ifelse(char_turn_polarity, 1, Balance of Life and Conduit of Life, Conduit of Death and Touch of Death))')
ifdef(`feat_holy_strike',                       `define(`show_feats', show_feats\\ Holy Strike (ELH p.57))')
ifdef(`feat_holy_warrior',                      `define(`show_feats', show_feats\\ Holy Warrior (CPC p.60))')
ifdef(`feat_hover',                             `define(`show_feats', show_feats\\ Hover (MOM~I p.304))')
ifdef(`feat_ignore_material_components',        `define(`show_feats', show_feats\\ Ignore Material Components (ELH p.57))')
ifdef(`feat_imbued_healing',                    `define(`show_feats', show_feats\\ Imbued Healing (CPC p.60))')
ifdef(`feat_improved_alignment_based_casting',  `define(`show_feats', show_feats\\ Improved Alignment Based Casting (ELH p.57))')
ifdef(`feat_improved_arrow_of_death',           `define(`show_feats', show_feats\\ Improved Arrow of Death (ELH p.57))')
ifdef(`feat_improved_aura_of_courage',          `define(`show_feats', show_feats\\ Improved Aura of Courage (ELH p.57))')
ifdef(`feat_improved_aura_of_despair',          `define(`show_feats', show_feats\\ Improved Aura of Despair (ELH p.57))')
ifdef(`feat_improved_bull_rush',                `define(`show_feats', show_feats\\ Improved Bull Rush (p.95))')
ifdef(`feat_improved_cold_endurance',           `define(`show_feats', show_feats\\ Improved Cold Endurance (FRB p.48))')
ifdef(`feat_improved_combat_casting',           `define(`show_feats', show_feats\\ Improved Combat Casting (ELH p.57))')
ifdef(`feat_improved_combat_reflexes',          `define(`show_feats', show_feats\\ Improved Combat Reflexes (ELH p.57))')
ifdef(`feat_improved_counterspell',             `define(`show_feats', show_feats\\ Improved Counterspell (p.95))')
ifdef(`feat_improved_critical',                 `define(`show_feats', show_feats\\ Improved Critical (p.95))')
ifdef(`feat_improved_darkvision',               `define(`show_feats', show_feats\\ Improved Darkvision (ELH p.58))')
ifdef(`feat_improved_death_attack',             `define(`show_feats', show_feats\\ Improved Death Attack (ELH p.58))')
ifdef(`feat_improved_disarm',                   `define(`show_feats', show_feats\\ Improved Disarm (p.95))')
ifdef(`feat_improved_elemental_wild_shape',     `define(`show_feats', show_feats\\ Improved Elemental Wild Shape (ELH p.58) \done)')
ifdef(`feat_improved_familiar',                 `define(`show_feats', show_feats\\ Improved Familiar (DMG p.200))')
ifdef(`feat_improved_favored_enemy',            `define(`show_feats', show_feats\\ Improved Favored Enemy (ELH p.58))')
ifdef(`feat_improved_feint',                    `define(`show_feats', show_feats\\ Improved Feint (p.95))')
ifdef(`feat_improved_flight',                   `define(`show_feats', show_feats\\ Improved Flight (MOW p.23))')
ifdef(`feat_improved_flyby_attack',             `define(`show_feats', show_feats\\ Improved Flyby Attack (ELH p.70))')
ifdef(`feat_improved_frosty_touch',             `define(`show_feats', show_feats\\ Improved Frosty Touch (FRB p.49))')
ifdef(`feat_improved_grapple',                  `define(`show_feats', show_feats\\ Improved Grapple (p.95))')
ifdef(`feat_improved_heighten_spell',           `define(`show_feats', show_feats\\ Improved Heighten Spell (ELH p.58))')
ifdef(`feat_improved_initiative',               `define(`show_feats', show_feats\\ Improved Initiative (p.96) \done)')
ifdef(`feat_improved_ki_strike',                `define(`show_feats', show_feats\\ Improved Ki Strike (ELH p.58))')
ifdef(`feat_improved_low_light_vision',         `define(`show_feats', show_feats\\ Improved Low Light Vision (ELH p.58))')
ifdef(`feat_improved_manifestation',            `define(`show_feats', show_feats\\ Improved Manifestation (ELH p.58))')
ifdef(`feat_improved_manyshot',                 `define(`show_feats', show_feats\\ Improved Manyshot (ELH p.58))')
ifdef(`feat_improved_metamagic',                `define(`show_feats', show_feats\\ Improved Metamagic (ELH p.59))')
ifdef(`feat_improved_multiattack',              `define(`show_feats', show_feats\\ Improved Multiattack (ELH p.70))')
ifdef(`feat_improved_multiweapon_fighting',     `define(`show_feats', show_feats\\ Improved Multiweapon Fighting (ELH p.70))')
ifdef(`feat_improved_overrun',                  `define(`show_feats', show_feats\\ Improved Overrun (p.96))')
ifdef(`feat_improved_precise_shot',             `define(`show_feats', show_feats\\ Improved Precise Shot (p.96))')
ifdef(`feat_improved_shield_bash',              `define(`show_feats', show_feats\\ Improved Shield Bash (p.96))')
ifdef(`feat_improved_sneak_attack',             `define(`show_feats', show_feats\\ Improved Sneak Attack (ELH p.59))')
ifdef(`feat_improved_spell_capacity',           `define(`show_feats', show_feats\\ Improved Spell Capacity (ELH p.59) \done)')
ifdef(`feat_improved_spell_resistance',         `define(`show_feats', show_feats\\ Improved Spell Resistance (ELH p.60))')
ifdef(`feat_improved_sunder',                   `define(`show_feats', show_feats\\ Improved Sunder (p.96))')
ifdef(`feat_improved_stunning_fist',            `define(`show_feats', show_feats\\ Improved Stunning Fist (ELH p.60))')
ifdef(`feat_improved_trip',                     `define(`show_feats', show_feats\\ Improved Trip (p.96))')
ifdef(`feat_improved_turning',                  `define(`show_feats', show_feats\\ Improved Turning (p.96) \done)')
ifdef(`feat_improved_two_weapon_fighting',      `define(`show_feats', show_feats\\ Improved Two Weapon Fighting (p.96))')
ifdef(`feat_improved_unarmed_strike',           `define(`show_feats', show_feats\\ Improved Unarmed Strike (p.96) \done)')
ifdef(`feat_improved_whirlwind_attack',         `define(`show_feats', show_feats\\ Improved Whirlwind Attack (ELH p.60))')
ifdef(`feat_incite_rage',                       `define(`show_feats', show_feats\\ Incite Rage (ELH p.60))')
ifdef(`feat_infinite_deflection',               `define(`show_feats', show_feats\\ Infinite Deflection (ELH p.61))')
ifdef(`feat_inspire_excellence',                `define(`show_feats', show_feats\\ Inspire Excellence (ELH p.61))')
ifdef(`feat_instant_reload',                    `define(`show_feats', show_feats\\ Instant Reload (ELH p.61))')
ifdef(`feat_intensify_spell',                   `define(`show_feats', show_feats\\ Intensify Spell (ELH p.61))')
ifdef(`feat_investigator',                      `define(`show_feats', show_feats\\ Investigator (p.97) \done)')
ifdef(`feat_iron_will',                         `define(`show_feats', show_feats\\ Iron Will (p.97) \done)')
ifdef(`feat_keen_strike',                       `define(`show_feats', show_feats\\ Keen Strike (ELH p.61))')
ifdef(`feat_knowledge_devotion',                `define(`show_feats', show_feats\\ Knowledge Devotion (CPC p.60))')
ifdef(`feat_lasting_inspiration',               `define(`show_feats', show_feats\\ Lasting Inspiration (ELH p.61))')
ifdef(`feat_law_devotion',                      `define(`show_feats', show_feats\\ Law Devotion (CPC p.61): ifelse(eval(level_total >= 15),1,+7,eval(level_total >= 10),1,+5,+3) ifelse(regexp(char_patron_deity_alignment,`E$'),-1,sacred,profane) attack or AC)')
ifdef(`feat_leadership',                        `define(`show_feats', show_feats\\ Leadership (p.97))')
ifdef(`feat_legendary_climber',                 `define(`show_feats', show_feats\\ Legendary Climber (ELH p.61))')
ifdef(`feat_legendary_commander',               `define(`show_feats', show_feats\\ Legendary Commander (ELH p.62))')
ifdef(`feat_legendary_leaper',                  `define(`show_feats', show_feats\\ Legendary Leaper (ELH p.62))')
ifdef(`feat_legendary_rider',                   `define(`show_feats', show_feats\\ Legendary Rider (ELH p.62))')
ifdef(`feat_legendary_tracker',                 `define(`show_feats', show_feats\\ Legendary Tracker (ELH p.62))')
ifdef(`feat_legendary_wrestler',                `define(`show_feats', show_feats\\ Legendary Wrestler (ELH p.62))')
ifdef(`feat_lightning_reflexes',                `define(`show_feats', show_feats\\ Lightning Reflexes (p.97) \done)')
ifdef(`feat_line_of_shadow',                    `define(`show_feats', show_feats\\ Line Of Shadow (ToM p.136))')
ifdef(`feat_lingering_damage',                  `define(`show_feats', show_feats\\ Lingering Damage (ELH p.62))')
ifdef(`feat_luck_devotion',                     `define(`show_feats', show_feats\\ Luck Devotion (CPC p.61))')
ifdef(`feat_magic_devotion',                    `define(`show_feats', show_feats\\ Magic Devotion (CPC p.61): eval(30 + 5 * (level_total / 2))~ft.~range\komma eval(level_total / 2)`'D6 damage)')
ifdef(`feat_magical_aptitude',                  `define(`show_feats', show_feats\\ Magical Aptitude (p.97) \done)')
ifdef(`feat_magical_beast_wild_shape',          `define(`show_feats', show_feats\\ Magical Beast Wild Shape (ELH p.62) \done)')
ifdef(`feat_manyshot',                          `define(`show_feats', show_feats\\ Manyshot (p.97): arrows/mod.: 2/--4`'ifelse(eval(bonus_attack_base >= 11),1,` or 3/--6')`'ifelse(eval(bonus_attack_base >= 16),1,` or 4/--8'))')
ifdef(`feat_mark_of_hleid',                     `define(`show_feats', show_feats\\ Mark of Hleid (FRB p.49))')
ifdef(`feat_martial_weapon_proficiency',        `define(`show_feats', show_feats\\ Martial Weapon Proficiency (p.97) \done)')
ifdef(`feat_master_staff',                      `define(`show_feats', show_feats\\ Master Staff (ELH p.62))')
ifdef(`feat_master_wand',                       `define(`show_feats', show_feats\\ Master Wand (ELH p.62))')
ifdef(`feat_maximize_mystery',                  `define(`show_feats', show_feats\\ Maximize Mystery (ToM p.136))')
ifdef(`feat_maximize_spell',                    `define(`show_feats', show_feats\\ Maximize Spell (p.97))')
ifdef(`feat_mitigate_suffering',                `define(`show_feats', show_feats\\ Mitigate Suffering (CPC p.61))')
ifdef(`feat_mobile_defense',                    `define(`show_feats', show_feats\\ Mobile Defense (ELH p.63))')
ifdef(`feat_mobility',                          `define(`show_feats', show_feats\\ Mobility (p.98))')
ifdef(`feat_mounted_archery',                   `define(`show_feats', show_feats\\ Mounted Archery (p.98))')
ifdef(`feat_mounted_combat',                    `define(`show_feats', show_feats\\ Mounted Combat (p.98))')
ifdef(`feat_multispell',                        `define(`show_feats', show_feats\\ Multispell (ELH p.63))')
ifdef(`feat_multiweapon_rend',                  `define(`show_feats', show_feats\\ Multiweapon Rend (ELH p.63))')
ifdef(`feat_music_of_the_gods',                 `define(`show_feats', show_feats\\ Music of the Gods (ELH p.63))')
ifdef(`feat_natural_spell',                     `define(`show_feats', show_feats\\ Natural Spell (p.98))')
ifdef(`feat_negative_energy_burst',             `define(`show_feats', show_feats\\ Negative Energy Burst (ELH p.63))')
ifdef(`feat_negotiator',                        `define(`show_feats', show_feats\\ Negotiator (p.98) \done)')
ifdef(`feat_nimble_fingers',                    `define(`show_feats', show_feats\\ Nimble Fingers (p.98) \done)')
ifdef(`feat_nocturnal_caster',                  `define(`show_feats', show_feats\\ Nocturnal Caster (ToM p.137))')
ifdef(`feat_overwhelming_critical',             `define(`show_feats', show_feats\\ Overwhelming Critical (ELH p.63))')
ifdef(`feat_path_focus',                        `define(`show_feats', show_feats\\ Path Focus (ToM p.137))')
ifdef(`feat_penetrate_damage_reduction',        `define(`show_feats', show_feats\\ Penetrate Damage Reduction (ELH p.63))')
ifdef(`feat_perfect_health',                    `define(`show_feats', show_feats\\ Perfect Health (ELH p.63))')
ifdef(`feat_perfect_multiweapon_fighting',      `define(`show_feats', show_feats\\ Perfect Multiweapon Fighting (ELH p.63))')
ifdef(`feat_perfect_two_weapon_fighting',       `define(`show_feats', show_feats\\ Perfect Two Weapon Fighting (ELH p.64))')
ifdef(`feat_permanent_emanation',               `define(`show_feats', show_feats\\ Permanent Emanation (ELH p.64))')
ifdef(`feat_persuasive',                        `define(`show_feats', show_feats\\ Persuasive (p.98) \done)')
ifdef(`feat_planar_turning',                    `define(`show_feats', show_feats\\ Planar Turning (ELH p.64))')
ifdef(`feat_plant_devotion',                    `define(`show_feats', show_feats\\ Plant Devotion (CPC p.61): +2 natural AC\komma ifelse(eval(level_total >= 20)1,100\%, eval(level_total >= 15)1,75\%, eval(level_total >= 10)1,50\%, 25\%) fortification)')
ifdef(`feat_point_blank_shot',                  `define(`show_feats', show_feats\\ Point Blank Shot (p.98))')
ifdef(`feat_polyglot',                          `define(`show_feats', show_feats\\ Polyglot (ELH p.65))')
ifdef(`feat_positive_energy_aura',              `define(`show_feats', show_feats\\ Positive Energy Aura (ELH p.65))')
ifdef(`feat_power_attack',                      `define(`show_feats', show_feats\\ Power Attack (p.98))')
ifdef(`feat_precise_shot',                      `define(`show_feats', show_feats\\ Precise Shot (p.98))')
ifdef(`feat_protection_devotion',               `define(`show_feats', show_feats\\ Protection Devotion (CPC p.61): +`'calc_min(7, eval(2 + level_total / 4)) ifelse(regexp(char_patron_deity_alignment,`E$'),-1,sacred,profane) AC)')
ifdef(`feat_protective_ward',                   `define(`show_feats', show_feats\\ Protective Ward (CPC p.61))')
ifdef(`feat_quick_draw',                        `define(`show_feats', show_feats\\ Quick Draw (p.98))')
ifdef(`feat_quicken_mystery',                   `define(`show_feats', show_feats\\ Quicken Mystery (ToM p.137))')
ifdef(`feat_quicken_spell',                     `define(`show_feats', show_feats\\ Quicken Spell (p.98))')
ifdef(`feat_ranged_inspiration',                `define(`show_feats', show_feats\\ Ranged Inspiration (ELH p.65))')
ifdef(`feat_rapid_inspiration',                 `define(`show_feats', show_feats\\ Rapid Inspiration (ELH p.66))')
ifdef(`feat_rapid_reload',                      `define(`show_feats', show_feats\\ Rapid Reload (p.99))')
ifdef(`feat_rapid_shot',                        `define(`show_feats', show_feats\\ Rapid Shot (p.99))')
ifdef(`feat_reach_mystery',                     `define(`show_feats', show_feats\\ Reach Mystery (ToM p.137))')
ifdef(`feat_reactive_countersong',              `define(`show_feats', show_feats\\ Reactive Countersong (ELH p.66))')
ifdef(`feat_reflect_arrows',                    `define(`show_feats', show_feats\\ Reflect Arrows (ELH p.66))')
ifdef(`feat_resistance_energy',                 `define(`show_feats', show_feats\\ Resistance to Energy (MOW p.25) \done)')
ifdef(`feat_retrieve_spell',                    `define(`show_feats', show_feats\\ Retrieve Spell (CPC p.62))')
ifdef(`feat_ride_by_attack',                    `define(`show_feats', show_feats\\ Ride-By Attack (p.99))')
ifdef(`feat_righteous_strike',                  `define(`show_feats', show_feats\\ Righteous Strike (ELH p.66))')
ifdef(`feat_ruinous_rage',                      `define(`show_feats', show_feats\\ Ruinous Rage (ELH p.66))')
ifdef(`feat_run',                               `define(`show_feats', show_feats\\ Run (p.99) \done)')
ifdef(`feat_scribe_epic_scroll',                `define(`show_feats', show_feats\\ Scribe Epic Scroll (ELH p.66))')
ifdef(`feat_scribe_scroll',                     `define(`show_feats', show_feats\\ Scribe Scroll (p.99))')
ifdef(`feat_self_concealment',                  `define(`show_feats', show_feats\\ Self Concealment (ELH p.66))')
ifdef(`feat_self_sufficient',                   `define(`show_feats', show_feats\\ Self Sufficient (p.100) \done)')
ifdef(`feat_shadow_cast',                       `define(`show_feats', show_feats\\ Shadow Cast (ToM p.137))')
ifdef(`feat_shadow_familiar',                   `define(`show_feats', show_feats\\ Shadow Familiar (ToM p.138))')
ifdef(`feat_shadow_reflection',                 `define(`show_feats', show_feats\\ Shadow Reflection (ToM p.138))')
ifdef(`feat_shadow_vision',                     `define(`show_feats', show_feats\\ Shadow Vision (ToM p.138))')
ifdef(`feat_shattering_strike',                 `define(`show_feats', show_feats\\ Shattering Strike (ELH p.66))')
ifdef(`feat_shield_proficiency',                `define(`show_feats', show_feats\\ Shield Proficiency (p.100) \done)')
ifdef(`feat_shot_on_the_run',                   `define(`show_feats', show_feats\\ Shot on the Run (p.100))')
ifdef(`feat_silent_spell',                      `define(`show_feats', show_feats\\ Silent Spell (p.100) \done)')
ifdef(`feat_simple_weapon_proficiency',         `define(`show_feats', show_feats\\ Simple Weapon Proficiency (p.100) \done)')
ifdef(`feat_skill_focus',                       `define(`show_feats', show_feats\\ Skill Focus (p.100))')
ifdef(`feat_snatch_arrows',                     `define(`show_feats', show_feats\\ Snatch Arrows (p.100))')
ifdef(`feat_sneak_attack_of_opportunity',       `define(`show_feats', show_feats\\ Sneak Attack of Opportunity (ELH p.66))')
ifdef(`feat_spectral_strike',                   `define(`show_feats', show_feats\\ Spectral Strike (ELH p.66))')
ifdef(`feat_spell_focus',                       `define(`show_feats', show_feats\\ Spell Focus (p.100) \done)')
ifdef(`feat_spell_knowledge',                   `define(`show_feats', show_feats\\ Spell Knowledge (ELH p.67))')
ifdef(`feat_spell_mastery',                     `define(`show_feats', show_feats\\ Spell Mastery (p.100))')
ifdef(`feat_spell_opportunity',                 `define(`show_feats', show_feats\\ Spell Opportunity (ELH p.67))')
ifdef(`feat_spell_penetration',                 `define(`show_feats', show_feats\\ Spell Penetration (p.100))')
ifdef(`feat_spell_stowaway',                    `define(`show_feats', show_feats\\ Spell Stowaway (ELH p.67))')
ifdef(`feat_spellcasting_harrier',              `define(`show_feats', show_feats\\ Spellcasting Harrier (ELH p.67))')
ifdef(`feat_spirited_charge',                   `define(`show_feats', show_feats\\ Spirited Charge (p.100))')
ifdef(`feat_spiritual_counter',                 `define(`show_feats', show_feats\\ Spiritual Counter (CPC p.62))')
ifdef(`feat_spontaneous_domain_access',         `define(`show_feats', show_feats\\ Spontaneous Domain Access (ELH p.67))')
ifdef(`feat_spontaneous_domains',               `define(`show_feats', show_feats\\ Spontaneous Domains (CPC p.62))')
ifdef(`feat_spontaneous_spell',                 `define(`show_feats', show_feats\\ Spontaneous Spell (ELH p.67))')
ifdef(`feat_spring_attack',                     `define(`show_feats', show_feats\\ Spring Attack (p.100))')
ifdef(`feat_stealthy',                          `define(`show_feats', show_feats\\ Stealthy (p.101) \done)')
ifdef(`feat_still_mystery',                     `define(`show_feats', show_feats\\ Still Mystery (ToM p.138))')
ifdef(`feat_still_spell',                       `define(`show_feats', show_feats\\ Still Spell (p.101) \done)')
ifdef(`feat_storm_of_throws',                   `define(`show_feats', show_feats\\ Storm of Throws (ELH p.67))')
ifdef(`feat_strength_devotion',                 `define(`show_feats', show_feats\\ Strength Devotion (CPC p.62): adamantine\komma slam deals translate_damage_by_size(ifelse(eval(level_total >= 16),1,2D6, eval(level_total >= 11),1,1D10, eval(level_total >= 6),1,1D8, 1D6), stat_size))')
ifdef(`feat_stunning_fist',                     `define(`show_feats', show_feats\\ Stunning Fist (p.101): eval(((level_total - level_monk) / 4) + level_monk){}$\times$/day\komma Fort.~DC~`'eval(10 + WIS + (level_total / 2)))')
ifdef(`feat_sun_devotion',                      `define(`show_feats', show_feats\\ Sun Devotion (CPC p.62): plus {level_total} ifelse(regexp(char_patron_deity_alignment,`E$'),-1,sacred,profane) damage against undead)')
ifdef(`feat_superior_initiative',               `define(`show_feats', show_feats\\ Superior Initiative (ELH p.67))')
ifdef(`feat_swarm_of_arrows',                   `define(`show_feats', show_feats\\ Swarm of Arrows (ELH p.67))')
ifdef(`feat_swift_call',                        `define(`show_feats', show_feats\\ Swift Call (CPC p.62))')
ifdef(`feat_swift_wild_shape',                  `define(`show_feats', show_feats\\ Swith Wild Shape (CPC p.62))')
ifdef(`feat_tenacious_magic',                   `define(`show_feats', show_feats\\ Tenacious Magic (ELH p.68))')
ifdef(`feat_terrifying_rage',                   `define(`show_feats', show_feats\\ Terrifying Rage (ELH p.68))')
ifdef(`feat_thundering_rage',                   `define(`show_feats', show_feats\\ Thundering Rage (ELH p.68))')
ifdef(`feat_touch_of_healing',                  `define(`show_feats', show_feats\\ Touch of Healing (CPC p.62))')
ifdef(`feat_toughness',                         `define(`show_feats', show_feats\\ Toughness (p.101) \done)')
ifdef(`feat_tower_shield_proficiency',          `define(`show_feats', show_feats\\ Tower Shield Proficiency (p.101) \done)')
ifdef(`feat_track',                             `define(`show_feats', show_feats\\ Track (p.101))')
ifdef(`feat_trample',                           `define(`show_feats', show_feats\\ Trample (p.101))')
ifdef(`feat_trap_sense',                        `define(`show_feats', show_feats\\ Trap Sense (ELH p.68))')
ifdef(`feat_travel_devotion',                   `define(`show_feats', show_feats\\ Travel Devotion (CPC p.62))')
ifdef(`feat_trickery_devotion',                 `define(`show_feats', show_feats\\ Trickery Devotion (CPC p.63))')
ifdef(`feat_two_weapon_defense',                `define(`show_feats', show_feats\\ Two Weapon Defense (p.102))')
ifdef(`feat_two_weapon_fighting',               `define(`show_feats', show_feats\\ Two Weapon Fighting (p.102))')
ifdef(`feat_two_weapon_rend',                   `define(`show_feats', show_feats\\ Two Weapon Rend (ELH p.68))')
ifdef(`feat_umbral_shroud',                     `define(`show_feats', show_feats\\ Umbral Shroud (CPC p.63): +10~ft darkvision)')
ifdef(`feat_uncanny_accuracy',                  `define(`show_feats', show_feats\\ Uncanny Accuracy (ELH p.68))')
ifdef(`feat_undead_mastery',                    `define(`show_feats', show_feats\\ Undead Mastery (ELH p.68))')
ifdef(`feat_unholy_strike',                     `define(`show_feats', show_feats\\ Unholy Strike (ELH p.68))')
ifdef(`feat_unseen_arrow',                      `define(`show_feats', show_feats\\ Unseen Arrow (ToM p.138))')
ifdef(`feat_venoms_gift',                       `define(`show_feats', show_feats\\ Venom\aps{}s Gift (CPC p.63): {level_druid}~rnd.\komma Fort.~DC eval(10 + (level_total / 2) + CON)\komma 1D2/1D2 S{}T{}R)')
ifdef(`feat_vermin_wild_shape',                 `define(`show_feats', show_feats\\ Vermin Wild Shape (ELH p.68) \done)')
ifdef(`feat_vorpal_strike',                     `define(`show_feats', show_feats\\ Vorpal Strike (ELH p.68))')
ifdef(`feat_war_devotion',                      `define(`show_feats', show_feats\\ War Dvotion (CPC p.63): ifelse(eval(level_total >= 15),1, -1 attacks and +5 dodge AC, eval(level_total >= 7),1, -2 attacks and +4 dodge AC, -3 attacks and +3 dodge AC))')
ifdef(`feat_water_devotion',                    `define(`show_feats', show_feats\\ Water Devotion (CPC p.64): summon ifelse(eval(level_total >= 16),1,huge,eval(level_total >= 11),1,large,eval(level_total >= 6),1,medium,small) water elemental)')
ifdef(`feat_weapon_finesse',                    `define(`show_feats', show_feats\\ Weapon Finesse (p.102) \done)')
ifdef(`feat_weapon_focus',                      `define(`show_feats', show_feats\\ Weapon Focus (p.102) \done)')
ifdef(`feat_weapon_specialization',             `define(`show_feats', show_feats\\ Weapon Specialization (p.102) \done)')
ifdef(`feat_whirlwind_attack',                  `define(`show_feats', show_feats\\ Whirlwind Attack (p.102))')
ifdef(`feat_widen_aura_of_courage',             `define(`show_feats', show_feats\\ Widen Aura of Courage (ELH p.69))')
ifdef(`feat_widen_aura_of_despair',             `define(`show_feats', show_feats\\ Widen Aura of Despair (ELH p.69))')
ifdef(`feat_widen_spell',                       `define(`show_feats', show_feats\\ Widen Spell (p.102))')
ifdef(`feat_wingover',                          `define(`show_feats', show_feats\\ Wingover (MOM~I p.304))')
ifdef(`feat_zone_of_animation',                 `define(`show_feats', show_feats\\ Zone of Animation (ELH p.69))')



dnl
dnl ***** skill synergies, PHB, table 4-5, p.66
dnl
ifelse(eval(rank_bluff               >= 5), 1, `define(`bonus_diplomacy', eval(bonus_diplomacy + 2))define(`bonus_intimidate', eval(bonus_intimidate + 2))define(`bonus_sleight_of_hand', eval(bonus_sleight_of_hand + 2))define(`show_skill_synergies', show_skill_synergies\\ +2 Disguise to act in character)define(`mark_disguise', 1)')
ifelse(eval(rank_decipher_script     >= 5), 1, `define(`show_skill_synergies', show_skill_synergies\\ +2 Use Magic Device involving scrolls)define(`mark_use_magic_device', 1)')
ifelse(eval(rank_escape_artist       >= 5), 1, `define(`show_skill_synergies', show_skill_synergies\\ +2 Use Rope involving bindings)define(`mark_use_rope', 1)')
ifelse(eval(rank_handle_animal       >= 5), 1, `define(`bonus_ride', eval(bonus_ride + 2))')dnl bonus for wild empathy included there
ifelse(eval(rank_jump                >= 5), 1, `define(`bonus_tumble', eval(bonus_tumble + 2))')
ifelse(eval(rank_knowledge_arcana    >= 5), 1, `define(`bonus_spellcraft', eval(bonus_spellcraft + 2))')
ifelse(eval(rank_knowledge_engineer  >= 5), 1, `define(`show_skill_synergies', show_skill_synergies\\ +2 Search involving secret doors etc.)define(`mark_search', 1)')
ifelse(eval(rank_knowledge_dungeon   >= 5), 1, `define(`show_skill_synergies', show_skill_synergies\\ +2 Survival underground)define(`mark_survival', 1)')
ifelse(eval(rank_knowledge_geography >= 5), 1, `define(`show_skill_synergies', show_skill_synergies\\ +2 Survival avoid hazards and getting lost)define(`mark_survival', 1)')
dnl Bonus for Bardic Knowledge according to Knowledge History if applied at the Bard Special Ability section
ifelse(eval(rank_knowledge_local     >= 5), 1, `define(`bonus_gather_info', eval(bonus_gather_info + 2))')
ifelse(eval(rank_knowledge_nature    >= 5), 1, `define(`show_skill_synergies', show_skill_synergies\\ +2 Survival in aboveground natural environments)define(`mark_survival', 1)')
ifelse(eval(rank_knowledge_nobility  >= 5), 1, `define(`bonus_diplomacy', eval(bonus_diplomacy + 2))')
ifelse(eval(rank_knowledge_planes    >= 5), 1, `define(`show_skill_synergies', show_skill_synergies\\ +2 Survival on another plane)define(`mark_survival', 1)')
ifelse(eval(rank_search              >= 5), 1, `define(`show_skill_synergies', show_skill_synergies\\ +2 Survival for following tracks)define(`mark_survival', 1)')
ifelse(eval(rank_sense_motive        >= 5), 1, `define(`bonus_diplomacy', eval(bonus_diplomacy + 2))')
ifelse(eval(rank_spellcraft          >= 5), 1, `define(`show_skill_synergies', show_skill_synergies\\ +2 Use Magic Device involving scrolls)define(`mark_use_magic_device', 1)')
ifelse(eval(rank_survival            >= 5), 1, `define(`bonus_knowledge_nature', eval(bonus_knowledge_nature + 2))')
ifelse(eval(rank_tumble              >= 5), 1, `define(`bonus_balance', eval(bonus_balance + 2))define(`bonus_jump', eval(bonus_jump + 2))')
ifelse(eval(rank_use_magic_device    >= 5), 1, `define(`show_skill_synergies', show_skill_synergies\\ +2 Spellcraft concerning spells on scrolls)define(`mark_spellcraft', 1)')
ifelse(eval(rank_use_rope            >= 5), 1, `define(`show_skill_synergies', show_skill_synergies\\ +2 Climb and Escape Artist involving ropes)define(`mark_climb', 1)define(`mark_escape_artist', 1)')



dnl
dnl ***** now the martial component: weapons, armor, shields
dnl
include(`martial.m4')



dnl
dnl ***** now include the items: calculate weight, etc
dnl
include(`items.m4')



dnl ***** helper for speed calculation
dnl reduced speed is two third of the original speed rounded up to next 5-ft unit, cf. DMG, p.20
define(`calc_reduced_speed', `ifelse(eval(($1 % 5) != 0),1, `error(strange speed value: $1)', eval(((($1 / 5) * 2 + 2) / 3) * 5))')


dnl
dnl ***** now calculate the speed stats accounting for limits by weight and armor
dnl
define(`char_speed_misc', eval(char_speed_misc + ifelse(eval(level_monk <= 0),1,0,eval(weight_total > weight_limit_light),1,0,armor_type,,char_speed_misc_monk,0) + ifelse(eval(level_barbarian <= 0),1,0,eval(weight_total > weight_limit_medium),1,0,armor_type,heavy,0,char_speed_misc_barbarian)))
dnl
define(`char_speed_sum', eval(char_speed_base + char_speed_misc))
dnl
define(`char_speed_limit', ifelse(dnl
calc_max(armor_limit_speed, weight_limit_speed), 2, 0,dnl two reduction steps mean: load beyond maximum => cannot move anymore
calc_max(armor_limit_speed, weight_limit_speed), 1, calc_reduced_speed(char_speed_sum), ))
dnl
define(`char_speed', ifelse(char_speed_limit,,char_speed_sum,calc_min(char_speed_sum, char_speed_limit)))
dnl
define(`char_speed_max', ifelse(dnl
armor_limit_max_pace`'X`'weight_limit_max_pace,X,char_speed_max,dnl
armor_limit_max_pace,,weight_limit_max_pace,dnl
weight_limit_max_pace,,armor_limit_max_pace,dnl
eval((0`'weight_limit_max_pace) < (0`'armor_limit_max_pace)),1,weight_limit_max_pace,armor_limit_max_pace))
dnl
define(`AC_DEX_max', calc_min(armor_limit_max_DEX, shield_limit_max_DEX, weight_limit_max_DEX))
dnl
define(`AC_DEX',     ifelse(AC_DEX_max,,DEX, eval((0`'AC_DEX_max) < DEX),1,AC_DEX_max,DEX))
define(`AC_armor',   armor_AC_bonus)
define(`AC_shield',  shield_AC_bonus)
dnl
define(`mod_encumbrance', calc_min(weight_check_penalty, eval(armor_check_penalty + shield_check_penalty)))



dnl
dnl ***** now get macros for spells per day, etc.
dnl
include(`spells.m4')



dnl
dnl ***** include the druid's wild shape ability, if the druid level is sufficiently high
dnl
define(`wild_shape_table', `')
ifelse(eval(level_druid >= 5),1,`include(`wild_shape.m4')')



dnl
dnl ***** finally insert the LaTeX-code for the character sheet
dnl
include(`sheet.m4')

