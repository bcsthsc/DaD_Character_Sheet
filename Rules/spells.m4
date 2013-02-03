

dnl ***** abbreviations used:
dnl ***** PHB  = Player's Handbook
dnl ***** DMG  = Dungeon Master's Guide
dnl ***** MOM  = Monster Manual
dnl ***** MotW = Masters of the Wild
dnl ***** SAS  = Song and Silence



dnl the following marcos are expected to be defined:
dnl
dnl all class levels


dnl ***** calculate number of spells per day per class
dnl ***** argument always: desired spell level

dnl ***** PHB, Table 3-4, p.27
define(`calc_standard_bard', `ifelse(dnl
eval(level_bard < 1), 1, -1,dnl
$1, 0, ifelse(eval(level_bard <  1), 1, -1, level_bard,  1, 2, eval(level_bard <= 13), 1, 3, 4),dnl
$1, 1, ifelse(eval(level_bard <  2), 1, -1, level_bard,  2, 0, level_bard,  3, 1, level_bard, 4, 2, eval(level_bard <= 14), 1, 3, 4),dnl
$1, 2, ifelse(eval(level_bard <  4), 1, -1, level_bard,  4, 0, level_bard,  5, 1, eval(level_bard <= 7), 1, 2, eval(level_bard <= 15), 1, 3, 4),dnl
$1, 3, ifelse(eval(level_bard <  7), 1, -1, level_bard,  7, 0, level_bard,  8, 1, eval(level_bard <= 10), 1, 2, eval(level_bard <= 16), 1, 3, 4),dnl
$1, 4, ifelse(eval(level_bard < 10), 1, -1, level_bard, 10, 0, level_bard, 11, 1, eval(level_bard <= 13), 1, 2, eval(level_bard <= 17), 1, 3, 4),dnl
$1, 5, ifelse(eval(level_bard < 13), 1, -1, level_bard, 13, 0, level_bard, 14, 1, eval(level_bard <= 16), 1, 2, eval(level_bard <= 18), 1, 3, 4),dnl
$1, 6, ifelse(eval(level_bard < 16), 1, -1, level_bard, 16, 0, level_bard, 17, 1, level_bard, 18, 2, level_bard, 19, 3, 4),dnl
-1)')

dnl ***** PHB, Table 3-6, p.31
dnl ***** domain spell not included
define(`calc_standard_cleric', `ifelse(dnl
eval(level_cleric < 1), 1, -1,dnl
$1,0,ifelse(                           level_cleric, 1,3,eval(level_cleric<= 3),1,4,eval(level_cleric<= 6),1,5,6),dnl
$1,1,ifelse(                           level_cleric, 1,1,eval(level_cleric<= 3),1,2,eval(level_cleric<= 6),1,3,eval(level_cleric<=10),1,4,5),dnl
$1,2,ifelse(eval(level_cleric< 3),1,-1,level_cleric, 3,1,eval(level_cleric<= 5),1,2,eval(level_cleric<= 8),1,3,eval(level_cleric<=12),1,4,5),dnl
$1,3,ifelse(eval(level_cleric< 5),1,-1,level_cleric, 5,1,eval(level_cleric<= 7),1,2,eval(level_cleric<=10),1,3,eval(level_cleric<=14),1,4,5),dnl
$1,4,ifelse(eval(level_cleric< 7),1,-1,level_cleric, 7,1,eval(level_cleric<= 9),1,2,eval(level_cleric<=12),1,3,eval(level_cleric<=16),1,4,5),dnl
$1,5,ifelse(eval(level_cleric< 9),1,-1,level_cleric, 9,1,eval(level_cleric<=11),1,2,eval(level_cleric<=14),1,3,eval(level_cleric<=18),1,4,5),dnl
$1,6,ifelse(eval(level_cleric<11),1,-1,level_cleric,11,1,eval(level_cleric<=13),1,2,eval(level_cleric<=16),1,3,4),dnl
$1,7,ifelse(eval(level_cleric<13),1,-1,level_cleric,13,1,eval(level_cleric<=15),1,2,eval(level_cleric<=18),1,3,4),dnl
$1,8,ifelse(eval(level_cleric<15),1,-1,level_cleric,15,1,eval(level_cleric<=17),1,2,eval(level_cleric<=19),1,3,4),dnl
$1,9,ifelse(eval(level_cleric<17),1,-1,level_cleric,17,1, level_cleric,18,2, level_cleric,19,3,4),dnl
-1)')

dnl ***** PHB, Table 3-8, p.35
define(`calc_standard_druid', `ifelse(dnl
eval(level_druid < 1), 1, -1,dnl
$1,0,ifelse(                          level_druid, 1,3,eval(level_druid<= 3),1,4,eval(level_druid<= 6),1,5,6),dnl
$1,1,ifelse(                          level_druid, 1,1,eval(level_druid<= 3),1,2,eval(level_druid<= 6),1,3,eval(level_druid<=10),1,4,5),dnl
$1,2,ifelse(eval(level_druid< 3),1,-1,level_druid, 3,1,eval(level_druid<= 5),1,2,eval(level_druid<= 8),1,3,eval(level_druid<=12),1,4,5),dnl
$1,3,ifelse(eval(level_druid< 5),1,-1,level_druid, 5,1,eval(level_druid<= 7),1,2,eval(level_druid<=10),1,3,eval(level_druid<=14),1,4,5),dnl
$1,4,ifelse(eval(level_druid< 7),1,-1,level_druid, 7,1,eval(level_druid<= 9),1,2,eval(level_druid<=12),1,3,eval(level_druid<=16),1,4,5),dnl
$1,5,ifelse(eval(level_druid< 9),1,-1,level_druid, 9,1,eval(level_druid<=11),1,2,eval(level_druid<=14),1,3,eval(level_druid<=18),1,4,5),dnl
$1,6,ifelse(eval(level_druid<11),1,-1,level_druid,11,1,eval(level_druid<=13),1,2,eval(level_druid<=16),1,3,4),dnl
$1,7,ifelse(eval(level_druid<13),1,-1,level_druid,13,1,eval(level_druid<=15),1,2,eval(level_druid<=18),1,3,4),dnl
$1,8,ifelse(eval(level_druid<15),1,-1,level_druid,15,1,eval(level_druid<=17),1,2,eval(level_druid<=19),1,3,4),dnl
$1,9,ifelse(eval(level_druid<17),1,-1,level_druid,17,1, level_druid,18,2, level_druid,19,3,4),dnl
-1)')

dnl ***** PHB, Table 3-12, p.43
define(`calc_standard_paladin', `ifelse(dnl
eval(level_paladin < 1), 1, -1,dnl
$1,1,ifelse(eval(level_paladin< 4),1,-1, eval(level_paladin<=5),1,0, eval(level_paladin<=13),1,1, eval(level_paladin<=17),1,2, 3),dnl
$1,2,ifelse(eval(level_paladin< 8),1,-1, eval(level_paladin<=9),1,0, eval(level_paladin<=15),1,1, eval(level_paladin<=18),1,2, 3),dnl
$1,3,ifelse(eval(level_paladin<11),1,-1, level_paladin,11,0, eval(level_paladin<=16),1,1, eval(level_paladin<=18),1,2, 3),dnl
$1,4,ifelse(eval(level_paladin<14),1,-1, level_paladin,14,0, eval(level_paladin<=18),1,1, level_paladin,19,2, 3),dnl
-1)')

dnl ***** PHB, Table 3-13, p.46
define(`calc_standard_ranger', `ifelse(dnl
eval(level_ranger < 1), 1, -1,dnl
$1,1,ifelse(eval(level_ranger< 4),1,-1, eval(level_ranger<=5),1,0, eval(level_ranger<=13),1,1, eval(level_ranger<=17),1,2, 3),dnl
$1,2,ifelse(eval(level_ranger< 8),1,-1, eval(level_ranger<=9),1,0, eval(level_ranger<=15),1,1, eval(level_ranger<=18),1,2, 3),dnl
$1,3,ifelse(eval(level_ranger<11),1,-1, level_ranger,11,0, eval(level_ranger<=16),1,1, eval(level_ranger<=18),1,2, 3),dnl
$1,4,ifelse(eval(level_ranger<14),1,-1, level_ranger,14,0, eval(level_ranger<=18),1,1, level_ranger,19,2, 3),dnl
-1)')

dnl ***** PHB, Table 3-16, p.52
dnl this is the table for spells per day
dnl the table of known spells follows later in this file
define(`calc_standard_sorcerer', `ifelse(dnl
eval(level_sorcerer < 1), 1, -1,dnl
$1,0,ifelse(level_sorcerer, 1, 5, 6),dnl
$1,1,ifelse(level_sorcerer, 1, 3, level_sorcerer, 2, 4, level_sorcerer, 3, 5, 6),dnl
eval(($1 > 1)  &&  ($1 < 9)), 1, ifelse(dnl
eval(level_sorcerer <  $1 * 2    ), 1, -1,dnl
eval(level_sorcerer == $1 * 2    ), 1,  3,dnl
eval(level_sorcerer == $1 * 2 + 1), 1,  4,dnl
eval(level_sorcerer == $1 * 2 + 2), 1,  5, 6),dnl
$1,9,ifelse(eval(level_sorcerer < 18),1,-1, level_sorcerer,18,3, level_sorcerer,19,4, 6),dnl
-1)')

dnl ***** PHB, Table 3-88, p.55
define(`calc_standard_wizard', `ifelse(dnl
eval(level_wizard < 1), 1, -1,dnl
$1,0,ifelse(level_wizard, 1, 3, 4),dnl
eval(($1 > 0)  &&  ($1 <= 7)), 1, ifelse(dnl
eval(level_wizard  < $1 * 2 - 1), 1, -1,dnl
eval(level_wizard == $1 * 2 - 1), 1,  1,dnl
eval(level_wizard <= $1 * 2 + 1), 1,  2,dnl
eval(level_wizard <= $1 * 2 + 4), 1,  3, 4),dnl
$1, 8, ifelse(eval(level_wizard < 15), 1, -1, level_wizard, 15, 1, eval(level_wizard <= 17), 1, 2, eval(level_wizard <= 19), 1, 3, 4),dnl
$1, 9, ifelse(eval(level_wizard < 17), 1, -1, level_wizard, 17, 1, level_wizard, 18, 2, level_wizard, 19, 3, 4),dnl
-1)')

dnl ***** SAS, Table 1-7, p.17
define(`calc_standard_templeraider', `ifelse(dnl
eval(level_templeraider < 1), 1, -1,dnl
$1,1,ifelse(eval(level_templeraider < 1),1,-1, level_templeraider, 1,0, eval(level_templeraider <=  6),1,1, 2),dnl
$1,2,ifelse(eval(level_templeraider < 3),1,-1, level_templeraider, 3,0, eval(level_templeraider <=  8),1,1, 2),dnl
$1,3,ifelse(eval(level_templeraider < 5),1,-1, level_templeraider, 5,0, eval(level_templeraider <= 10),1,1, 2),dnl
$1,4,ifelse(eval(level_templeraider < 7),1,-1, level_templeraider, 7,0, 1),dnl
-1)')


dnl ***** calculate number of spells per day, PHB: several tables
dnl ***** arguments: class, spell level in question
define(`calc_standard_spells', `ifelse(dnl
eval(ifelse(dnl first check, if the primary ability is high enough for the asked spell level
$1,       wizard, eval(INT_score + INT_scdam + INT_scitm),dnl
$1,       cleric, eval(WIS_score + WIS_scdam + WIS_scitm),dnl
$1,        druid, eval(WIS_score + WIS_scdam + WIS_scitm),dnl
$1,      paladin, eval(WIS_score + WIS_scdam + WIS_scitm),dnl
$1,       ranger, eval(WIS_score + WIS_scdam + WIS_scitm),dnl
$1, templeraider, eval(WIS_score + WIS_scdam + WIS_scitm),dnl
$1,     sorcerer, eval(CHA_score + CHA_scdam + CHA_scitm),dnl
$1,         bard, eval(CHA_score + CHA_scdam + CHA_scitm),0) < 10 + $2), 1, 0,dnl o.k., now calculate ...
$1,         bard, calc_standard_bard($2),dnl
$1,       cleric, calc_standard_cleric($2),dnl
$1,        druid, calc_standard_druid($2),dnl
$1,      paladin, calc_standard_paladin($2),dnl
$1,       ranger, calc_standard_ranger($2),dnl
$1,     sorcerer, calc_standard_sorcerer($2),dnl
$1,       wizard, calc_standard_wizard($2),dnl
$1, templeraider, calc_standard_templeraider($2),dnl following is the default value for wrong arguments given ...
0)')


dnl ***** calculate the number of additional spell slots by the epic feat: Improved Spell Capacity
dnl ***** arguments: class, spell level in question
define(`calc_improved_capacity_sub', `patsubst(feat_improved_spell_capacity, `\<\([^ ]+\)\>', `ifelse(\1,$1_$2,1,)')')
define(`calc_improved_capacity', `ifdef(`feat_improved_spell_capacity',`eval(patsubst(0 calc_improved_capacity_sub($1, $2), `\> +\<', `+'))',0)')


dnl ***** calculate bonus spells by abilities, PHB: Table 1-1, p. 8
dnl ***** arguments: spell level in question, ability score
define(`calc_bonus_spell_calc', `ifelse(dnl
$1, 0, 0,dnl level zero spell never receive bonus spells
eval($2 < 10), 1, 0,dnl ability too low for spells
eval($1 >= 1), 1, eval(($2 - (2 * $1) - 2) / 8),dnl
`error(argument of spell level ($1) out of range when calculating bonus spells)')')
dnl
dnl ***** arguments: class, spell level in question
define(`calc_bonus_spells', `ifelse(dnl
$1,       wizard, calc_bonus_spell_calc($2, eval(INT_score + INT_scdam + INT_scitm)),dnl
$1,       cleric, calc_bonus_spell_calc($2, eval(WIS_score + WIS_scdam + WIS_scitm)),dnl
$1,        druid, calc_bonus_spell_calc($2, eval(WIS_score + WIS_scdam + WIS_scitm)),dnl
$1,      paladin, calc_bonus_spell_calc($2, eval(WIS_score + WIS_scdam + WIS_scitm)),dnl
$1,       ranger, calc_bonus_spell_calc($2, eval(WIS_score + WIS_scdam + WIS_scitm)),dnl
$1, templeraider, calc_bonus_spell_calc($2, eval(WIS_score + WIS_scdam + WIS_scitm)),dnl
$1,     sorcerer, calc_bonus_spell_calc($2, eval(CHA_score + CHA_scdam + CHA_scitm)),dnl
$1,         bard, calc_bonus_spell_calc($2, eval(CHA_score + CHA_scdam + CHA_scitm)),dnl
0)')


dnl ***** now calculate all spells per day
dnl ***** for a cleric don't include its domain bonus spell
dnl ***** arguments: class, spell level in question
define(`calc_spells_per_day', `ifelse(calc_standard_spells($1, $2), -1, `ifelse(calc_improved_capacity($1, $2),0,0,`eval(calc_bonus_spells($1, $2) + calc_improved_capacity($1, $2))')', `eval(calc_standard_spells($1, $2) + calc_bonus_spells($1, $2) + calc_improved_capacity($1, $2))')')


dnl ***** some classes know a limited number of spells at each level
dnl ***** these classes are: bard, sorcerer
dnl ***** argument: spell level in question
dnl
dnl ***** PHB, Table 3-5, p.28
define(`known_spells_bard', `ifelse(dnl
eval(eval(CHA_score + CHA_scdam + CHA_scitm) < 10 + $1), 1, 0,dnl
eval(level_bard < 1), 1, 0,dnl
$1,0,ifelse(level_bard,1,4,level_bard,2,5,6),dnl
$1,1,ifelse(eval(level_bard< 2),1,0,level_bard, 2,2,eval(level_bard<= 4),1,3,eval(level_bard<=15),1,4,5),dnl
$1,2,ifelse(eval(level_bard< 4),1,0,level_bard, 4,2,eval(level_bard<= 6),1,3,eval(level_bard<=16),1,4,5),dnl
$1,3,ifelse(eval(level_bard< 7),1,0,level_bard, 7,2,eval(level_bard<= 9),1,3,eval(level_bard<=17),1,4,5),dnl
$1,4,ifelse(eval(level_bard<10),1,0,level_bard,10,2,eval(level_bard<=12),1,3,eval(level_bard<=18),1,4,5),dnl
$1,5,ifelse(eval(level_bard<13),1,0,level_bard,13,2,eval(level_bard<=15),1,3,eval(level_bard<=19),1,4,5),dnl
$1,6,ifelse(eval(level_bard<16),1,0,level_bard,16,2,eval(level_bard<=18),1,3,4),dnl
`error(argument of spell level ($1) out of range when calculating known spells for bard)')')

dnl ***** PHB, Table 3-17, p.54
define(`known_spells_sorcerer', `ifelse(dnl
eval(eval(CHA_score + CHA_scdam + CHA_scitm) < 10 + $1), 1, 0,dnl
eval(level_sorcerer < 1), 1, 0,dnl
$1,0,ifelse(level_sorcerer,1,4,eval(level_sorcerer<=3),1,5,eval(level_sorcerer<=5),1,6,eval(level_sorcerer<=7),1,7,eval(level_sorcerer<=9),1,8,9),dnl
$1,1,ifelse(eval(level_sorcerer<= 2),1,2,eval(level_sorcerer<=4),1,3,eval(level_sorcerer<=6),1,4,5),dnl
$1,2,ifelse(eval(level_sorcerer<= 3),1,0,level_sorcerer, 4,1,eval(level_sorcerer<= 6),1,2,eval(level_sorcerer<= 8),1,3,eval(level_sorcerer<=10),1,4,5),dnl
$1,3,ifelse(eval(level_sorcerer<= 5),1,0,level_sorcerer, 6,1,eval(level_sorcerer<= 8),1,2,eval(level_sorcerer<=10),1,3,4),dnl
$1,4,ifelse(eval(level_sorcerer<= 7),1,0,level_sorcerer, 8,1,eval(level_sorcerer<=10),1,2,eval(level_sorcerer<=12),1,3,4),dnl
$1,5,ifelse(eval(level_sorcerer<= 9),1,0,level_sorcerer,10,1,eval(level_sorcerer<=12),1,2,eval(level_sorcerer<=14),1,3,4),dnl
$1,6,ifelse(eval(level_sorcerer<=11),1,0,level_sorcerer,12,1,eval(level_sorcerer<=14),1,2,3),dnl
$1,7,ifelse(eval(level_sorcerer<=13),1,0,level_sorcerer,14,1,eval(level_sorcerer<=16),1,2,3),dnl
$1,8,ifelse(eval(level_sorcerer<=15),1,0,level_sorcerer,16,1,eval(level_sorcerer<=18),1,2,3),dnl
$1,9,ifelse(eval(level_sorcerer<=17),1,0,level_sorcerer,18,1,level_sorcerer,19,2,3),dnl
`error(argument of spell level ($1) out of range when calculating known spells for sorcerer)')')
