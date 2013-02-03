include(`defaults.m4')dnl ***** first initialize, don't remove this line


dnl ***** abbreviations used:
dnl ***** PHB = Player's Handbook
dnl ***** DMG = Dungeon Master's Guide
dnl ***** MOM = Monster Manual


dnl ***** enter character's name and other information here
dnl ***** sheet will be generated using LaTeX, so make free use of its features
define(`char_name',         `Helen')
define(`char_height',       `6 1')dnl format `x<space>y' means x feet and y inch
define(`char_weight',       `133')dnl lbs.
define(`char_age',          `17')dnl years
define(`char_hair_color',   `black')
define(`char_eye_color',    `grey')
define(`char_skin_color',   `pale')
define(`char_gender',       `female')
define(`char_race',         `Human')
define(`char_alignment',    `lawful-neutral')
define(`char_patron_deity', `?')
define(`char_pic',          `')
define(`char_picflag',      `0')


dnl ***** enter the ability scores here
dnl ***** !!! modifications according to race will automatically be made, (PHB: Table 2-1, p. 12)
define(`STR_score', 10)
define(`DEX_score', 16)
define(`CON_score', 12)
define(`INT_score', 18)
define(`WIS_score', 14)
define(`CHA_score', 18)


dnl *****
dnl ***** Level 1-6: Shadowcaster(1-6)
dnl *****
dnl
define(`level_shadowcaster',  eval(level_shadowcaster  +  6))
define(`char_HP',             eval(char_HP             + 33))
dnl
dnl ***** select feats and human bonus feat
define(`feat_combat_casting',                    1)
define(`feat_improved_initiative',               1)
dnl    see file rules/default.m4
dnl
dnl ***** increase ability score
define(`INT_score', eval(INT_score + 1))dnl level 4
dnl
dnl ***** set languages, Common is listed by default, see list in PHB, p.82
define(`char_languages', char_languages\komma Draconic\komma Dwarven\komma Elven\komma Goblin)
dnl
dnl ***** first level of new class, set additional class skills
define(`csl_craft_calligraphy', csl_craft_calligraphy shadowcaster)
define(`csl_prof_scribe',       csl_prof_scribe       shadowcaster)
dnl
dnl ***** activate chosen skills in: craft, knowledge and profession
define(`show_craft_calligraphy',       1)
define(`show_knowledge_arcana',        1)
define(`show_knowledge_planes',        1)
define(`show_prof_scribe',             1)
dnl
dnl ***** buy skill ranks for (2 + INT + 1) * 4 = ... skill points
define(`rank_appraise',                eval(rank_appraise                 + 0))
define(`rank_balance',                 eval(rank_balance                  + 0))
define(`rank_bluff',                   eval(rank_bluff                    + 0))
define(`rank_climb',                   eval(rank_climb                    + 0))
define(`rank_concentration',           eval(rank_concentration            + 7))
define(`rank_craft_calligraphy',       eval(rank_craft_calligraphy        + 1))
define(`rank_decipher_script',         eval(rank_decipher_script          + 0))
define(`rank_diplomacy',               eval(rank_diplomacy                + 0))
define(`rank_disable_device',          eval(rank_disable_device           + 0))
define(`rank_disguise',                eval(rank_disguise                 + 0))
define(`rank_escape_artist',           eval(rank_escape_artist            + 0))
define(`rank_forgery',                 eval(rank_forgery                  + 0))
define(`rank_gather_info',             eval(rank_gather_info              + 0))
define(`rank_handle_animal',           eval(rank_handle_animal            + 0))
define(`rank_heal',                    eval(rank_heal                     + 0))
define(`rank_hide',                    eval(rank_hide                     + 7))
define(`rank_intimidate',              eval(rank_intimidate               + 2))
define(`rank_jump',                    eval(rank_jump                     + 0))
define(`rank_knowledge_arcana',        eval(rank_knowledge_arcana         + 6))
define(`rank_knowledge_engineer',      eval(rank_knowledge_engineer       + 0))
define(`rank_knowledge_dungeon',       eval(rank_knowledge_dungeon        + 0))
define(`rank_knowledge_geography',     eval(rank_knowledge_geography      + 0))
define(`rank_knowledge_history',       eval(rank_knowledge_history        + 0))
define(`rank_knowledge_local',         eval(rank_knowledge_local          + 0))
define(`rank_knowledge_nature',        eval(rank_knowledge_nature         + 0))
define(`rank_knowledge_nobility',      eval(rank_knowledge_nobility       + 0))
define(`rank_knowledge_religion',      eval(rank_knowledge_religion       + 0))
define(`rank_knowledge_planes',        eval(rank_knowledge_planes         + 5))
define(`rank_listen',                  eval(rank_listen                   + 1))
define(`rank_move_silently',           eval(rank_move_silently            + 9))
define(`rank_open_lock',               eval(rank_open_lock                + 0))
define(`rank_prof_scribe',             eval(rank_prof_scribe              + 1))
define(`rank_ride',                    eval(rank_ride                     + 0))
define(`rank_search',                  eval(rank_search                   + 0))
define(`rank_sense_motive',            eval(rank_sense_motive             + 0))
define(`rank_sleight_of_hand',         eval(rank_sleight_of_hand          + 0))
define(`rank_spellcraft',              eval(rank_spellcraft               + 6))
define(`rank_spot',                    eval(rank_spot                     + 9))
define(`rank_survival',                eval(rank_survival                 + 0))
define(`rank_swim',                    eval(rank_swim                     + 0))
define(`rank_tumble',                  eval(rank_tumble                   + 0))
define(`rank_use_magic_device',        eval(rank_use_magic_device         + 0))
define(`rank_use_rope',                eval(rank_use_rope                 + 0))

define(`char_EP', eval(char_EP +  300))dnl fight against one displacer beast
define(`char_EP', eval(char_EP +  340))dnl fight against two boars
define(`char_EP', eval(char_EP +   75))dnl fight against four goblins
define(`char_EP', eval(char_EP +  300))dnl finishing this adventure step

define(`char_EP', eval(char_EP + 1425))dnl fight at cave entrance against five bugbears, four worgs and two goblins
define(`char_EP', eval(char_EP + 1000))dnl fight in cave against five bugbears, two worgs and four goblins

define(`char_EP', eval(char_EP + 2057))dnl fight in Lolth temple against four driders
define(`char_EP', eval(char_EP + 3086))dnl fight against Lich
define(`char_EP', eval(char_EP +  533))dnl fight against Shand

define(`char_EP', eval(char_EP + 600))dnl finishing this adventure step
define(`char_EP', eval(char_EP + 600))dnl fighting some wolves

define(`char_EP', eval(char_EP + (375 + 562 + 3)))dnl fighting orcs near Fort Gerim ?
define(`char_EP', eval(char_EP + 7775))dnl scouting mission against orcs and drow: organizing, travel, meeting with ranger, observation, intrusion in drow outpost, fight against two Dread Blossom Swarms and one Chraal




dnl ***** by weasel familiar
define(`show_special_abilities', show_special_abilities\\ +2 Reflex Saves with familiar within 1 mile`'ifdef(feat_alertness,,\\ +2 Spot and Listen with familiar in arm\aps{}s reach))
define(`mark_spot',                ifdef(`feat_alertness',mark_listen,1))
define(`mark_listen',              ifdef(`feat_alertness',mark_listen,1))


define(`char_armor',  wear_armor_leather())dnl Shadow Silk Leather, special abilities below
define(`bonus_item_move_silently',           2)dnl by armor
define(`bonus_item_hide',                    2)dnl by armor


dnl weapon token, attack bonus, damage bonus, weapon size, specially built composite bow strength bonus, ammunition
define(`char_weapons', dnl
calc_weapon(crossbow_light,1,0,medium,,40)dnl
calc_weapon(dagger,0,0,medium,,)dnl
)


dnl ***** Wealth
define(`wealth_platinum',    0)
define(`wealth_gold',       10)
define(`wealth_silver',     10)
define(`wealth_copper',      0)
define(`wealth_gems',         )


dnl ***** Cargo
dnl
dnl see file items.m4
dnl possible macros: item_multiple(item_token, count), item_container(weight), item_unnamed(weight)
dnl

dnl it is not necessary to split the items into these subsets, but I like it that way
define(`helen_backpack', `dnl
backpack, dnl container filled with ...
waterskin, item_multiple(trail_ration, 1), dnl
flint_steel, dnl
bedroll_heavy`'dnl
')

define(`helen_spell_component_pouch', `dnl
item_container(8 oz), dnl spell component pouch, PHB, p.128 (very few ingredients)
item_multiple(gem, 0)dnl
')

define(`helen_portage', `dnl carried by horse or someone else ...
')

dnl ***** now sum the cargo ...
dnl ***** this is the relevant macro, hand to it a comma-separated list
define(`list_cargo', `dnl
dnl ********** worn items **********
outfit_explorer, dnl
dnl ********** attached items **********
helen_spell_component_pouch, dnl
dagger, dnl
crossbow_light, dnl
item_multiple(bolts, 1), dnl Crossbow-Bolts: 10 bolts per weight unit
dnl ********** carried items **********
helen_backpack`'dnl
dnl helen_portage, dnl
')



dnl ***** if the following definition is non-zero then include the file "char_xxx.inc" to the end of the character sheet
define(`char_attach_supplement', 1)
dnl ***** if the following definition is non-zero then show a table to convert units to the end of the character sheet
define(`char_attach_units', 0)


include(`calculations.m4')dnl ***** don't remove this line
