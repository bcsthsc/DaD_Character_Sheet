include(`defaults.m4')dnl ***** first initialize, don't remove this line


dnl ***** abbreviations used:
dnl ***** PHB = Player's Handbook
dnl ***** DMG = Dungeon Master's Guide
dnl ***** MOM = Monster Manual
dnl ***** MOP = Manual of the Planes
dnl ***** CPC = Complete Champion


dnl ***** enter character's name and other information here
dnl ***** sheet will be generated using LaTeX, so make free use of its features
define(`char_name',                   `Hannah')
define(`char_height',                 `5 9')dnl format `x<space>y' means x feet and y inch
define(`char_weight',                 `167')dnl lbs.
define(`char_age',                    `25')dnl years
define(`char_hair_color',             `blonde')
define(`char_eye_color',              `grey')
define(`char_skin_color',             `fair')
define(`char_gender',                 `female')
define(`char_race',                   `Human')
define(`char_alignment',              `chaotic-neutral')
define(`char_patron_deity',           `Uthgar (Red Tiger)')
define(`char_patron_deity_alignment', `CN')
define(`char_domains',                `Strength War')
define(`char_turn_polarity',          `1')dnl 1 = turn and destroy (good cleric), otherwise rebuke and command (evil cleric)
define(`char_pic',                    `')
define(`char_picflag',                `0')


dnl ***** enter the ability scores here
dnl ***** !!! modifications according to race will be made automatically, (PHB: Table 2-1, p. 12)
define(`STR_score', 18)
define(`DEX_score', 10)
define(`CON_score', 14)
define(`INT_score', 12)
define(`WIS_score', 18)
define(`CHA_score', 16)


dnl ***** set additional class skills and skills to show up in the sheet
define(`csl_craft_ship_making', csl_craft_ship_making cleric)dnl chosen craft
define(`csl_prof_sailor',       csl_prof_sailor       cleric)dnl chosen profession
define(`show_knowledge_arcana',        1)
define(`show_knowledge_geography',     1)
define(`show_knowledge_history',       1)
define(`show_knowledge_nature',        1)
define(`show_knowledge_planes',        1)
define(`show_knowledge_religion',      1)
define(`show_craft_ship_making',       1)
define(`show_prof_sailor',             1)
dnl ***** some skills can be used only trained, maybe do not show them to save space on the character sheet
define(`show_decipher_script',         1)
define(`show_disable_device',          1)
define(`show_handle_animal',           1)
define(`show_open_lock',               1)
define(`show_sleight_of_hand',         1)
define(`show_tumble',                  1)
define(`show_use_magic_device',        1)


dnl ***** select feats and human bonus feat
define(`feat_combat_casting',                    1)
define(`feat_endurance',                         1)
define(`feat_improved_initiative',               1)
define(`feat_power_attack',                      1)
define(`feat_war_devotion',                      1)

dnl ***** improve ability scores
define(`WIS_score',       eval(WIS_score       + 1))dnl level 4
define(`WIS_score',       eval(WIS_score       + 1))dnl level 8

dnl ***** initialize favored weapon of Uthgar: Battleaxe (in case of War Domain: weapon proficiency and weapon focus)
define(`proficiencies_weapons', proficiencies_weapons battleaxe)
define(`feat_weapon_focus',     battleaxe)

dnl ***** set languages, Common is listed by default
define(`char_languages', char_languages\komma Infernal)

dnl ***** set experience points, class level(s) and hit points
define(`char_EP', 52464)
define(`level_cleric',    eval(level_cleric    + 10))
define(`char_HP',                                68)dnl hit points WITHOUT (!) CON-bonus

dnl ***** buy skill points: 12 * 4 = 48
dnl ***** skills marked with an asterisk * are class skills
define(`rank_concentration',       eval(rank_concentration        + 13))dnl *
define(`rank_craft_ship_making',   eval(rank_craft_ship_making    +  1))dnl *
define(`rank_diplomacy',           eval(rank_diplomacy            +  2))dnl *
define(`rank_handle_animal',       eval(rank_handle_animal        +  0))dnl 
define(`rank_heal',                eval(rank_heal                 +  1))dnl *
define(`rank_knowledge_arcana',    eval(rank_knowledge_arcana     +  2))dnl *
define(`rank_knowledge_geography', eval(rank_knowledge_geography  +  0))dnl 
define(`rank_knowledge_history',   eval(rank_knowledge_history    +  2))dnl *
define(`rank_knowledge_nature',    eval(rank_knowledge_nature     +  0))dnl 
define(`rank_knowledge_religion',  eval(rank_knowledge_religion   + 13))dnl *
define(`rank_knowledge_planes',    eval(rank_knowledge_planes     +  4))dnl *
define(`rank_listen',              eval(rank_listen               +  1))dnl 
define(`rank_prof_sailor',         eval(rank_prof_sailor          +  1))dnl *
define(`rank_ride',                eval(rank_ride                 +  0))dnl 
define(`rank_sense_motive',        eval(rank_sense_motive         +  0))dnl 
define(`rank_spellcraft',          eval(rank_spellcraft           +  5))dnl *
define(`rank_spot',                eval(rank_spot                 +  2))dnl 
define(`rank_survival',            eval(rank_survival             +  1))dnl 
define(`rank_swim',                eval(rank_swim                 +  0))dnl 


dnl ***** install some items
define(`char_armor',  wear_armor_breastplate(4))dnl Breastplate +4, special abilities below
define(`char_shield', wear_shield_heavy_steel(4))dnl Heavy Steel Shield +4

define(`WIS_scitm',  eval(WIS_scitm    +  4))dnl Periapt of Wisdom +4
define(`CHA_scitm',  eval(CHA_scitm    +  2))dnl Cloak of Charisma +2
define(`AC_deflect', eval(AC_deflect   +  3))dnl Ring of Protection +3
define(`bonus_item_escape_artist',           eval(bonus_item_escape_artist            + 10))dnl Suit of Armor is Improved Slick ...
define(`bonus_item_hide',                    eval(bonus_item_hide                     + 10))dnl ... and Improved Shadow

dnl Turn Undead +2 comes automatically when Knowledge Religion reaches rank 5
dnl evtl. Divine Agent prestige class

dnl weapon token, attack bonus, damage bonus, weapon size, specially built composite bow strength bonus, ammunition, flag, comment, damage dice
define(`char_weapons', dnl
calc_weapon(battleaxe,3,3,medium,,,2,Shocking,)dnl
calc_weapon(battleaxe,0,0,medium,,,2,Silver,)dnl
)


dnl ***** Wealth
define(`wealth_platinum',   10221)
define(`wealth_gold',       3)
define(`wealth_silver',     0)
define(`wealth_copper',     0)


dnl ***** Cargo
dnl
dnl possible macros: item_multiple(item_token, count), item_container(weight), item_unnamed(weight)
dnl

define(`hannah_backpack', `dnl
backpack, dnl container filled with ...
waterskin, item_multiple(trail_ration, 2), dnl
tinderbox, dnl
whetstone, dnl
bedroll_heavy`'dnl
')

define(`hannah_spell_component_pouch', `dnl
item_container(8 oz), dnl spell component pouch, PHB, p.128 (very few ingredients)
item_multiple(gem, 0)dnl
')

define(`hannah_portage', `dnl
item_unnamed(2 lbs)`'dnl Fishing Set
')

dnl ***** now sum the cargo ...
define(`list_cargo', `dnl
dnl ********** worn items **********
AT_medium_breastplate, dnl
shield_heavy_steel, dnl
gloves, dnl
boots, dnl
dnl ********** attached items **********
hannah_spell_component_pouch, dnl
battleaxe, dnl
dnl ********** carried items **********
hannah_backpack, dnl
hannah_portage`'dnl
')


dnl ***** if the following definition is non-zero then include the file "char_xxx.inc" to the end of the character sheet
define(`char_attach_supplement', 1)
dnl ***** if the following definition is non-zero then show a table to convert units to the end of the character sheet
define(`char_attach_units', 0)


include(`calculations.m4')dnl ***** don't remove this line

