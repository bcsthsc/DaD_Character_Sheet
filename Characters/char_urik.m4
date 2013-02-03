include(`defaults.m4')dnl ***** first initialize, don't remove this line


dnl ***** abbreviations used:
dnl ***** PHB = Player's Handbook
dnl ***** DMG = Dungeon Master's Guide
dnl ***** MOM = Monster Manual


dnl ***** enter character's name and other information here
dnl ***** sheet will be generated using LaTeX, so make free use of its features
define(`char_name',          `Urik Ringart')
define(`char_height',        `4 3')dnl format `x<space>y' means x feet and y inch
define(`char_weight',        `178')dnl lbs.
define(`char_age',           `58')dnl years
define(`char_hair_color',    `?')
define(`char_eye_color',     `?')
define(`char_skin_color',    `?')
define(`char_gender',        `male')
define(`char_race',          `Dwarf')
define(`char_alignment',     `chaotic-good')
define(`char_patron_deity',  `Haela Brightaxe')
define(`char_turn_polarity', `1')dnl 1 = turn and destroy (good cleric), 0 = rebuke and command (evil cleric)
dnl define(`char_pic',           `')


dnl ***** enter the ability scores here
dnl ***** !!! modifications according to race will be made automatically, (PHB: Table 2-1, p. 12)
define(`STR_score', 18)
define(`DEX_score', 11)
define(`CON_score', 16)
define(`INT_score', 14)
define(`WIS_score', 10)
define(`CHA_score', 10)


dnl ***** show following additional skills
define(`rank_craft_stone_masonry',    0)dnl class skill
define(`rank_knowledge_dungeon',      0)dnl
define(`rank_knowledge_geography',    0)dnl
define(`rank_knowledge_nature',       0)dnl
define(`rank_knowledge_history',      0)dnl
define(`rank_knowledge_religion',     0)dnl


dnl *****
dnl ***** Level 1: Fighter(1)
dnl *****
dnl
dnl first level of new class, set additional class skills
define(`csl_craft_stone_masonry',    csl_craft_stone_masonry   fighter)
dnl select first feat and fighter bonus feat
dnl set languages, Common is listed by default, Dwarven for Dwarves too
define(`char_languages', char_languages\komma Undercommon\komma Gnom)dnl
dnl
define(`level_fighter',   eval(level_fighter   +  1))
define(`char_HP',         eval(char_HP         + 10))dnl first level ever: max(1D10)
dnl ***** buy skills
define(`rank_climb',                 eval(rank_climb                 + 2))dnl class skill
define(`rank_handle_animal',         eval(rank_handle_animal         + 2))dnl class skill
define(`rank_hide',                  eval(rank_hide                  + 0))dnl
define(`rank_intimidate',            eval(rank_intimidate            + 2))dnl class skill
define(`rank_jump',                  eval(rank_jump                  + 2))dnl class skill
define(`rank_ride',                  eval(rank_ride                  + 2))dnl class skill
define(`rank_spot',                  eval(rank_spot                  + 1))dnl
define(`rank_survival',              eval(rank_survival              + 1))dnl
define(`rank_swim',                  eval(rank_swim                  + 2))dnl class skill

define(`char_EP', eval(char_EP + 1000))dnl fight against followers of Warlord Nagorn


dnl *****
dnl ***** Level 2: Fighter(2)
dnl *****
dnl
dnl select fighter bonus feat
dnl
define(`level_fighter',   eval(level_fighter   +  1))
define(`char_HP',         eval(char_HP         +  7))dnl 1D10
dnl ***** buy skills

define(`char_EP', eval(char_EP +  540))dnl fight against two boars
define(`char_EP', eval(char_EP + 1080))dnl fight against four guards of Warlord Nagorn
define(`char_EP', eval(char_EP +  200))dnl finishing this adventure-step
define(`char_EP', eval(char_EP + 1440))dnl fight against three scouts of Warlord Nagorn


dnl *****
dnl ***** Level 3: Fighter(3)
dnl *****
dnl
dnl select feat
dnl
define(`level_fighter',   eval(level_fighter   +  1))
define(`char_HP',         eval(char_HP         +  7))dnl 1D10
dnl ***** buy skills for Level 2 and 3

define(`rank_climb',                 eval(rank_climb                 + 1))dnl class skill
define(`rank_handle_animal',         eval(rank_handle_animal         + 1))dnl class skill
define(`rank_heal',                  eval(rank_heal                  + 1))dnl
define(`rank_listen',                eval(rank_listen                + 1))dnl
define(`rank_move_silently',         eval(rank_move_silently         + 1))dnl class skill
define(`rank_sense_motive',          eval(rank_sense_motive          + 1))dnl
define(`rank_survival',              eval(rank_survival              + 1))dnl
define(`rank_use_rope',              eval(rank_use_rope              + 1))dnl class skill

define(`char_EP', eval(char_EP +  600))dnl fight in village "Fliederbusch"
define(`char_EP', eval(char_EP +  800))dnl finishing this adventure-step
define(`char_EP', eval(char_EP +  675))dnl fight against a patrol of Warlord Nagorn
define(`char_EP', eval(char_EP +  900))dnl fight against a patrol of Warlord Nagorn


dnl *****
dnl ***** Level 4: Fighter(4)
dnl *****
define(`level_fighter',   eval(level_fighter   +  1))
define(`char_HP',         eval(char_HP         +  9))dnl 1D10
dnl improve one ability score
define(`STR_score',       eval(STR_score       + 1))
dnl select fighter bonus feat
dnl ***** buy skills
define(`rank_listen',                eval(rank_listen                + 1))dnl
define(`rank_spot',                  eval(rank_spot                  + 1))dnl

dnl *****
dnl ***** Level 5: Fighter(5)
dnl *****
dnl
define(`level_fighter',   eval(level_fighter   +  1))
define(`char_HP',         eval(char_HP         +  5))dnl 1D10
dnl select fighter bonus feat
dnl ***** buy skills
define(`rank_listen',                eval(rank_listen                + 1))dnl
define(`rank_spot',                  eval(rank_spot                  + 1))dnl

dnl *****
dnl ***** Level 6: Fighter(6)
dnl *****
dnl
define(`level_fighter',   eval(level_fighter   +  1))
define(`char_HP',         eval(char_HP         +  7))dnl 1D10
dnl select fighter bonus feat
dnl ***** buy skills

define(`rank_listen',                eval(rank_listen                + 1))dnl
define(`rank_knowledge_dungeon',     eval(rank_knowledge_dungeon     + 1))dnl
define(`rank_spot',                  eval(rank_spot                  + 1))dnl


dnl *****
dnl ***** Level 7: Fighter(4)
dnl *****
define(`level_fighter',   eval(level_fighter   +  1))
define(`char_HP',         eval(char_HP         +  7))dnl 1D10
dnl select fighter bonus feat



dnl *****
dnl ***** Level 8: Fighter(4)
dnl *****
define(`level_fighter',   eval(level_fighter   +  1))
define(`char_HP',         eval(char_HP         +  9))dnl 1D10
dnl improve one ability score
define(`STR_score',       eval(STR_score       + 1))
dnl select fighter bonus feat
dnl ***** buy skills for level 7 and 8
define(`rank_craft_stone_masonry',   eval(rank_craft_stone_masonry   + 1))dnl class skill
define(`rank_handle_animal',         eval(rank_handle_animal         + 1))dnl class skill
define(`rank_knowledge_history',     eval(rank_knowledge_history     + 1))dnl
define(`rank_knowledge_religion',    eval(rank_knowledge_religion    + 1))dnl
define(`rank_use_magic_device',      eval(rank_use_magic_device      + 1))dnl



dnl ***** install some items
define(`char_armor',  wear_armor_chain_shirt(0))dnl
define(`char_shield', wear_shield_heavy_wooden(0))dnl
dnl define(`AC_deflect', eval(AC_deflect   +  1))dnl Ring of Protection +1


dnl weapon token, attack bonus, damage bonus, weapon size, specially built composite bow strength bonus, ammunition
define(`char_weapons', `dnl
calc_weapon(battleaxe,0,0,medium,,,2,)dnl
calc_weapon(axe_throwing,0,0,medium,,,,)dnl
')dnl


dnl ***** Wealth
define(`wealth_platinum',   0)
define(`wealth_gold',       0)
define(`wealth_silver',     0)
define(`wealth_copper',     0)


dnl ***** Cargo
dnl
dnl possible macros: item_multiple(item_token, count), item_container(weight), item_unnamed(weight), item_size(item_token, size_token)
dnl

define(`urik_backpack', `dnl
backpack, dnl attached too ... and filled with ...
bedroll_heavy, dnl
waterskin, item_multiple(trail_ration, 2), dnl
item_container(4 oz), dnl container: salt, flint and steel
tinderbox, dnl
whetstone`'dnl
')

define(`urik_belt', `dnl
pouch, dnl filled with ...
item_multiple(gem, 0)dnl
')

dnl ***** now sum the cargo ...
define(`list_cargo', `dnl
dnl ********** worn items **********
AT_light_chain_shirt, dnl
item_unnamed(7 lbs), dnl cold weather outfit
dnl ********** attached items **********
urik_belt, dnl
warhammer, dnl
dnl ********** carried items **********
shield_heavy_wood, dnl
urik_backpack`'dnl
')


dnl ***** if the following definition is non-zero then include the file "char_xxx.inc" to the end of the character sheet
define(`char_attach_supplement', 1)
dnl ***** if the following definition is non-zero then show a table to convert units to the end of the character sheet
define(`char_attach_units', 0)


include(`calculations.m4')dnl ***** don't remove this line

