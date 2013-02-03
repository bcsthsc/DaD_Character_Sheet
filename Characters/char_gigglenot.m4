include(`defaults.m4')dnl ***** first initialize, don't remove this line


dnl ***** abbreviations used:
dnl ***** PHB = Player's Handbook
dnl ***** DMG = Dungeon Master's Guide
dnl ***** MOM = Monster Manual


dnl ***** enter character's name and other information here
dnl ***** sheet will be generated using LaTeX, so make free use of its features
define(`char_name',          `Gigglenot')
define(`char_height',        `3 4')dnl format `x<space>y' means x feet and y inch
define(`char_weight',        `44')dnl lbs.
define(`char_age',           `40')dnl years
define(`char_hair_color',    `')
define(`char_eye_color',     `')
define(`char_skin_color',    `')
define(`char_gender',        `male')
define(`char_race',          `Gnome')
define(`char_alignment',     `chaotic-good')
define(`char_patron_deity',  `Olidammara')
define(`char_domains',       `Luck Trickery')dnl space-separated list
define(`char_turn_polarity', `1')dnl 1 = turn and destroy (good cleric), 0 = rebuke and command (evil cleric)
dnl define(`char_pic',           `hannah.eps')


dnl ***** enter the ability scores here
dnl ***** !!! modifications according to race will be made automatically, (PHB: Table 2-1, p. 12)
define(`STR_score', 10)
define(`DEX_score', 19)
define(`CON_score', 14)
define(`INT_score', 18)
define(`WIS_score', 18)
define(`CHA_score', 12)


dnl ***** show following additional skills
define(`show_knowledge_local',     1)dnl
define(`show_knowledge_arcana',    1)dnl
define(`show_knowledge_geography', 1)dnl
define(`show_knowledge_nature',    1)dnl
define(`show_knowledge_religion',  1)dnl
define(`show_craft_lock_smithing', 1)dnl
define(`show_perform_oratory',     1)dnl


dnl *****
dnl ***** Level 1-6: Rogue(1-6)
dnl *****
dnl
dnl first level of new class, set additional class skills
define(`csl_craft_lock_smithing',     csl_craft_lock_smithing rogue)dnl all_classes
dnl select first feat
define(`feat_weapon_finesse',                    1)
define(`feat_two_weapon_fighting',               1)
define(`feat_stealthy',                          1)
define(`feat_rapid_reload',                      1)
define(`flag_show_two_weapon_mod',               1)
dnl set languages, Common is listed by default, Gnome for Gnomes too
define(`char_languages', char_languages\komma Dwarven\komma Elven\komma Draconic\komma Orc)dnl
dnl
define(`level_rogue',     eval(level_rogue     + 6))
define(`char_HP',         eval(char_HP         + 32))dnl first level ever: max(1D6)

dnl ***** buy 9*12 = 108 skill points (class skills marked with an *)
define(`rank_appraise',            4)dnl *
define(`rank_balance',             0)dnl *
define(`rank_bluff',               1)dnl *
define(`rank_climb',               8)dnl *
define(`rank_concentration',       0)dnl 
define(`rank_decipher_script',     2)dnl *
define(`rank_diplomacy',           3)dnl *
define(`rank_disable_device',      6)dnl *
define(`rank_disguise',            4)dnl *
define(`rank_escape_artist',       2)dnl *
define(`rank_forgery',             0)dnl *
define(`rank_gather_info',         7)dnl *
define(`rank_handle_animal',       0)dnl 
define(`rank_heal',                0)dnl 
define(`rank_hide',                4)dnl *
define(`rank_intimidate',          0)dnl *
define(`rank_jump',                1)dnl *
define(`rank_knowledge_arcana',    2)dnl 
define(`rank_listen',              8)dnl *
define(`rank_move_silently',       5)dnl *
define(`rank_open_lock',           9)dnl *
define(`rank_perform_oratory',     1)dnl *
define(`rank_ride',                0)dnl 
define(`rank_search',              2)dnl *
define(`rank_sense_motive',        0)dnl *
define(`rank_sleight_of_hand',     4)dnl *
define(`rank_spellcraft',          3)dnl 
define(`rank_spot',                9)dnl *
define(`rank_survival',            0)dnl 
define(`rank_swim',                0)dnl *
define(`rank_tumble',              1)dnl *
define(`rank_use_magic_device',    9)dnl *
define(`rank_use_rope',            5)dnl *

define(`bonus_hide',               eval(bonus_hide                + 4))
define(`mark_move_silently',       1)

dnl ***** install some items
define(`char_armor',  wear_armor_leather_studded(1))dnl


dnl weapon token, attack bonus, damage bonus, weapon size, specially built composite bow strength bonus, ammunition
define(`char_weapons', dnl
calc_weapon(crossbow_hand,1,0,small,,10,,)dnl
calc_weapon(dagger,0,0,small,,,o,)dnl
calc_weapon(hammer_gnome_hooked,0,0,small,,,,)dnl
)




dnl *****
dnl ***** Level 7-8: Rogue(7-8)
dnl *****
dnl
define(`DEX_score', eval(DEX_score             + 1))
dnl
define(`level_rogue',     eval(level_rogue     + 2))
define(`char_HP',         eval(char_HP         + 10))dnl first level ever: max(1D6)

dnl ***** buy 24 skill points
define(`rank_appraise',            eval(rank_appraise            + 0))dnl *
define(`rank_balance',             eval(rank_balance             + 0))dnl *
define(`rank_bluff',               eval(rank_bluff               + 0))dnl *
define(`rank_climb',               eval(rank_climb               + 2))dnl *
define(`rank_concentration',       eval(rank_concentration       + 0))dnl 
define(`rank_decipher_script',     eval(rank_decipher_script     + 3))dnl *
define(`rank_diplomacy',           eval(rank_diplomacy           + 1))dnl *
define(`rank_disable_device',      eval(rank_disable_device      + 0))dnl *
define(`rank_disguise',            eval(rank_disguise            + 1))dnl *
define(`rank_escape_artist',       eval(rank_escape_artist       + 0))dnl *
define(`rank_forgery',             eval(rank_forgery             + 0))dnl *
define(`rank_gather_info',         eval(rank_gather_info         + 1))dnl *
define(`rank_handle_animal',       eval(rank_handle_animal       + 0))dnl 
define(`rank_heal',                eval(rank_heal                + 0))dnl 
define(`rank_hide',                eval(rank_hide                + 3))dnl *
define(`rank_intimidate',          eval(rank_intimidate          + 0))dnl *
define(`rank_jump',                eval(rank_jump                + 0))dnl *
define(`rank_knowledge_arcana',    eval(rank_knowledge_arcana    + 1))dnl 
define(`rank_knowledge_geography', eval(rank_knowledge_geography + 1))dnl 
define(`rank_listen',              eval(rank_listen              + 2))dnl *
define(`rank_move_silently',       eval(rank_move_silently       + 0))dnl *
define(`rank_open_lock',           eval(rank_open_lock           + 2))dnl *
define(`rank_perform_oratory',     eval(rank_perform_oratory     + 0))dnl *
define(`rank_ride',                eval(rank_ride                + 1))dnl 
define(`rank_search',              eval(rank_search              + 0))dnl *
define(`rank_sense_motive',        eval(rank_sense_motive        + 0))dnl *
define(`rank_sleight_of_hand',     eval(rank_sleight_of_hand     + 0))dnl *
define(`rank_spellcraft',          eval(rank_spellcraft          + 0))dnl 
define(`rank_spot',                eval(rank_spot                + 2))dnl *
define(`rank_survival',            eval(rank_survival            + 0))dnl 
define(`rank_swim',                eval(rank_swim                + 0))dnl *
define(`rank_tumble',              eval(rank_tumble              + 0))dnl *
define(`rank_use_magic_device',    eval(rank_use_magic_device    + 2))dnl *
define(`rank_use_rope',            eval(rank_use_rope            + 1))dnl *


define(`level_rogue',     eval(level_rogue     + 1))
define(`char_HP',         eval(char_HP         + 5))
define(`feat_point_blank_shot',                   1)
define(`rank_climb',               eval(rank_climb               + 1))
define(`rank_listen',              eval(rank_listen              + 1))
define(`rank_spot',                eval(rank_spot                + 1))
define(`rank_open_lock',           eval(rank_open_lock           + 1))
define(`rank_disable_device',      eval(rank_disable_device      + 1))
define(`rank_craft_lock_smithing', eval(rank_craft_lock_smithing + 1))
define(`rank_search',              eval(rank_search              + 6))

define(`level_templeraider', 1)
define(`char_HP',         eval(char_HP         + 6))
define(`rank_climb',               eval(rank_climb               + 1))dnl *
define(`rank_disable_device',      eval(rank_disable_device      + 2))dnl *
define(`rank_disguise',            eval(rank_disguise            + 1))dnl *
define(`rank_listen',              eval(rank_listen              + 1))dnl *
define(`rank_spot',                eval(rank_spot                + 1))dnl *
define(`rank_use_magic_device',    eval(rank_use_magic_device    + 1))dnl *
define(`rank_use_rope',            eval(rank_use_rope            + 1))dnl *

dnl define(`char_EP',            45404)

define(`level_templeraider', eval(level_templeraider     + 1))
define(`char_HP',         eval(char_HP         + 6))
define(`rank_disable_device',      eval(rank_disable_device      + 1))dnl *
define(`rank_knowledge_religion',  eval(rank_knowledge_religion  + 1))dnl 
define(`rank_spot',                eval(rank_spot                + 1))dnl *
define(`rank_spellcraft',          eval(rank_spellcraft          + 2))dnl 
define(`rank_use_magic_device',    eval(rank_use_magic_device    + 2))dnl *

define(`level_templeraider', eval(level_templeraider     + 1))
define(`char_HP',         eval(char_HP         + 4))
define(`rank_search',              eval(rank_search              + 3))dnl *
define(`rank_survival',            eval(rank_survival            + 1))dnl 
define(`rank_knowledge_religion',  eval(rank_knowledge_religion  + 1))dnl 
define(`rank_hide',                eval(rank_hide                + 1))dnl *

define(`char_EP',            66500)

define(`level_templeraider', eval(level_templeraider     + 1))
define(`char_HP',         eval(char_HP         + 5))
define(`rank_disable_device',      eval(rank_disable_device + 2))dnl *
define(`rank_escape_artist',       eval(rank_escape_artist  + 2))dnl 
define(`rank_tumble',              eval(rank_tumble         + 2))dnl 
define(`rank_use_rope',            eval(rank_use_rope       + 1))dnl *

define(`char_EP', eval(char_EP + 264+192+4896+2500+3250+500))


dnl ***** armor
define(`char_armor',  wear_armor_leather(4))dnl

dnl weapon token, attack bonus, damage bonus, weapon size, specially built composite bow strength bonus, ammunition, flag, comment, damage dice
define(`char_weapons', dnl
calc_weapon(crossbow_hand,4,4,small,,10,,flaming burst,)dnl
calc_weapon(dagger,0,0,small,,,o,)dnl
calc_weapon(hammer_gnome_hooked,0,0,small,,,,)dnl
calc_weapon(rapier,2,2,small,,,,flaming)dnl
)


dnl ***** Wealth
define(`wealth_platinum',   0)
define(`wealth_gold',       0)
define(`wealth_silver',     0)
define(`wealth_copper',     0)


dnl ***** attribute bonus items
dnl
define(`WIS_scitm',  eval(WIS_scitm    +  4))dnl periapt of wisdom
define(`DEX_scitm',  eval(DEX_scitm    +  6))dnl gloves of dexterity

define(`AC_deflect',   eval(AC_deflect   +  2))dnl Ring of Protection +2

dnl ***** Cargo
dnl
dnl possible macros: item_multiple(item_token, count), item_container(weight), item_unnamed(weight), item_size(item_token, size_token)
dnl
define(`item_default_size', small)dnl set default item size

define(`gigglenot_backpack', `dnl
backpack, dnl container filled with ...
waterskin, dnl
grappling_hook, dnl
bedroll_light`'dnl
')

define(`gigglenot_pouch', `dnl
pouch,dnl filled with ...
item_multiple(gem, 0)dnl
')

dnl ***** now sum the cargo ...
define(`list_cargo', `dnl
dnl ********** worn items **********
AT_light_leather, dnl
boots, dnl
dnl ********** attached items **********
dnl gigglenot_pouch, dnl
crossbow_hand, dnl
dagger, dnl
hammer_gnome_hooked, dnl
dnl ********** carried items **********
gigglenot_backpack`'dnl
')


dnl ***** if the following definition is non-zero then include the file "char_xxx.inc" to the end of the character sheet
define(`char_attach_supplement', 1)
dnl ***** if the following definition is non-zero then show a table to convert units to the end of the character sheet
define(`char_attach_units', 0)


include(`calculations.m4')dnl ***** don't remove this line

