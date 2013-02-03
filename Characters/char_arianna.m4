include(`defaults.m4')dnl ***** first initialize, don't remove this line


dnl ***** abbreviations used:
dnl ***** PHB = Player's Handbook
dnl ***** DMG = Dungeon Master's Guide
dnl ***** MOM = Monster Manual


dnl ***** enter character's name and other information here
dnl ***** sheet will be generated using LaTeX, so make free use of its features
define(`char_name',          `Arianna')
define(`char_height',        `5 5')dnl format `x<space>y' means x feet and y inch
define(`char_weight',        `160')dnl lbs.
define(`char_age',           `19')dnl years
define(`char_hair_color',    `?')
define(`char_eye_color',     `?')
define(`char_skin_color',    `?')
define(`char_gender',        `female')
define(`char_race',          `Tiefling')
define(`char_alignment',     `lawful-neutral')
define(`char_patron_deity',  `?')
define(`char_pic',           `')
define(`char_picflag',       `0')


dnl ***** enter the ability scores here
dnl ***** !!! modifications according to race will be made automatically, (PHB: Table 2-1, p. 12)
define(`STR_score', 10)
define(`DEX_score', 10)
define(`CON_score', 10)
define(`INT_score', 10)
define(`WIS_score', 10)
define(`CHA_score', 10)


define(`show_craft_weapon_smithing', 1)
define(`show_knowledge_geography',   1)
define(`show_knowledge_local',       1)


dnl *****
dnl ***** Level 1: Fighter(1)
dnl *****
dnl
dnl first level of new class, set additional class skills
define(`csl_craft_weapon_smithing',  csl_craft_weapon_smithing fighter)
dnl
dnl ***** select first feat and fighter bonus feat
define(`feat_combat_expertise',                  1)
define(`feat_dodge',                             1)
dnl
dnl ***** set languages, Common is listed by default
define(`char_languages', char_languages\komma Dwarfen)dnl
dnl
define(`level_fighter',   eval(level_fighter   +  1))
define(`char_HP',         eval(char_HP         + 10))dnl first level ever: max(1D10)
dnl
dnl ***** buy (2 + INT) * 4 = ... skill points
define(`rank_balance',               eval(rank_balance               + 0))dnl
define(`rank_climb',                 eval(rank_climb                 + 0))dnl class skill
define(`rank_craft_weapon_smithing', eval(rank_craft_weapon_smithing + 0))dnl class skill
define(`rank_gather_info',           eval(rank_gather_info           + 0))dnl
define(`rank_handle_animal',         eval(rank_handle_animal         + 0))dnl class skill
define(`rank_hide',                  eval(rank_hide                  + 0))dnl
define(`rank_intimidate',            eval(rank_intimidate            + 0))dnl class skill
define(`rank_jump',                  eval(rank_jump                  + 0))dnl class skill
define(`rank_knowledge_geography',   eval(rank_knowledge_geography   + 0))dnl
define(`rank_knowledge_local',       eval(rank_knowledge_local       + 0))dnl
define(`rank_listen',                eval(rank_listen                + 0))dnl
define(`rank_ride',                  eval(rank_ride                  + 0))dnl class skill
define(`rank_search',                eval(rank_search                + 0))dnl
define(`rank_sense_motive',          eval(rank_sense_motive          + 0))dnl
define(`rank_spot',                  eval(rank_spot                  + 0))dnl
define(`rank_survival',              eval(rank_survival              + 0))dnl
define(`rank_swim',                  eval(rank_swim                  + 0))dnl class skill

define(`char_EP', eval(char_EP +  300))dnl fight against one displacer beast
define(`char_EP', eval(char_EP +  340))dnl fight against two boars
define(`char_EP', eval(char_EP +   75))dnl fight against four goblins
define(`char_EP', eval(char_EP +  300))dnl finishing this adventure step



dnl *****
dnl ***** Level 2: Fighter(2)
dnl *****
dnl
define(`level_fighter',   eval(level_fighter   +  1))
define(`char_HP',         eval(char_HP         + 10))dnl 1D10
dnl
dnl ***** select fighter bonus feat
dnl
dnl ***** buy (2 + INT) = ... skill points
define(`rank_handle_animal',         eval(rank_handle_animal         + 0))dnl class skill
define(`rank_intimidate',            eval(rank_intimidate            + 0))dnl class skill
define(`rank_jump',                  eval(rank_jump                  + 0))dnl class skill
define(`rank_ride',                  eval(rank_ride                  + 0))dnl class skill

define(`char_EP', eval(char_EP + 1425))dnl fight at cave entrance against five bugbears, four worgs and two goblins
define(`char_EP', eval(char_EP + 1000))dnl fight in cave against five bugbears, two worgs and four goblins



dnl ***** install some items
define(`char_armor',  wear_armor_full_plate(0))dnl for other armor tokens see file rules/martial.m4
define(`char_shield', wear_shield_heavy_steel(0))dnl dito


dnl weapon token, attack bonus, damage bonus, weapon size, specially built composite bow strength bonus, ammunition
define(`char_weapons', `dnl
dnl calc_weapon(mace_heavy,0,0,medium,,,2,)dnl
dnl calc_weapon(warhammer,1,1,medium,,,2,)dnl
dnl calc_weapon(axe_throwing,0,0,medium,,,,)dnl
calc_weapon(longsword,0,0,medium,,,2,)dnl
dnl calc_weapon(greatsword,1,1,medium,,,,)dnl
dnl calc_weapon(spear,0,0,medium,,,,)dnl
dnl calc_weapon(lance,1,0,medium,,,,)dnl
calc_weapon(longbow,0,0,medium,,20,,)dnl
')dnl


dnl ***** Wealth
define(`wealth_platinum',   0)
define(`wealth_gold',      10)
define(`wealth_silver',    10)
define(`wealth_copper',     0)


dnl ***** Cargo
dnl
dnl possible macros: item_multiple(item_token, count), item_container(weight), item_unnamed(weight)
dnl

define(`arianna_backpack', `dnl
bedroll_heavy, dnl
backpack, dnl container filled with ...
waterskin, item_multiple(trail_ration, 2), dnl
whetstone`'dnl
')

dnl ***** now sum the cargo ...
define(`list_cargo', `dnl
dnl ********** worn items **********
AT_heavy_full_plate, dnl
dnl ********** attached items **********
longsword, dnl
dnl ********** carried items **********
shield_heavy_steel, dnl
longbow, dnl
item_multiple(arrows, 1), dnl
arianna_backpack`'dnl
')


dnl ***** if the following definition is non-zero then include the file "char_xxx.inc" to the end of the character sheet
define(`char_attach_supplement', 1)
dnl ***** if the following definition is non-zero then show a table to convert units to the end of the character sheet
define(`char_attach_units', 0)


include(`calculations.m4')dnl ***** don't remove this line

