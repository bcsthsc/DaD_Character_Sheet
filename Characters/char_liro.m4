include(`defaults.m4')dnl ***** first initialize, don't remove this line


dnl ***** abbreviations used:
dnl ***** PHB = Player's Handbook
dnl ***** DMG = Dungeon Master's Guide
dnl ***** MOM = Monster Manual


dnl ***** enter character's name and other information here
dnl ***** sheet will be generated using LaTeX, so make free use of its features
define(`char_name',          `Liro')
define(`char_height',        `6 2')dnl format `x<space>y' means x feet and y inch
define(`char_weight',        `140')dnl lbs.
define(`char_age',           `18')dnl years
define(`char_hair_color',    `')
define(`char_eye_color',     `')
define(`char_skin_color',    `')
define(`char_gender',        `male')
define(`char_race',          `Human')
define(`char_alignment',     `lawful-neutral')
define(`char_patron_deity',  `Ilmater')
define(`char_turn_polarity', `1')dnl 1 = turn and destroy (good cleric), 0 = rebuke and command (evil cleric)
dnl define(`char_pic',           `liro.eps')


dnl ***** enter the ability scores here
dnl ***** !!! modifications according to race will automatically be made, (PHB: Table 2-1, p. 12)
define(`STR_score', 10)
define(`DEX_score', 18)
define(`CON_score', 14)
define(`INT_score', 14)
define(`WIS_score', 16)
define(`CHA_score',  8)


dnl ***** show following additional skills
define(`show_craft_calligraphy',   1)
define(`show_knowledge_arcana',    1)
dnl define(`show_knowledge_engineer',  0)
dnl define(`show_knowledge_dungeon',   0)
dnl define(`show_knowledge_geography', 0)
dnl define(`show_knowledge_history',   0)
dnl define(`show_knowledge_local',     0)
define(`show_knowledge_nature',    1)
dnl define(`show_knowledge_nobility',  0)
define(`show_knowledge_religion',  1)
dnl define(`show_knowledge_planes',    0)
define(`show_prof_herbalist',      1)
define(`show_perform_oratory',     1)


dnl *****
dnl ***** Level 1: Monk(1)
dnl *****
dnl
dnl first level of new class, set additional class skills
define(`csl_craft_calligraphy',      csl_craft_calligraphy monk)
define(`csl_prof_herbalist',         csl_prof_herbalist monk)
define(`csl_perform_oratory',        csl_perform_oratory monk)
dnl select first feat and human bonus feat
dnl set languages, Common is listed by default
define(`char_languages', char_languages\komma Elven\komma Drow)dnl
dnl
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 8))dnl first level ever: max(1D8)
dnl Level one option feat:
define(`feat_stunning_fist', 1)
dnl ***** buy skill points
define(`rank_appraise',            eval(rank_appraise            + 0))
define(`rank_balance',             eval(rank_balance             + 0))
define(`rank_bluff',               eval(rank_bluff               + 0))
define(`rank_climb',               eval(rank_climb               + 0))
define(`rank_concentration',       eval(rank_concentration       + 0))
define(`rank_craft_calligraphy',   eval(rank_craft_calligraphy   + 0))
define(`rank_decipher_script',     eval(rank_decipher_script     + 0))
define(`rank_diplomacy',           eval(rank_diplomacy           + 0))
define(`rank_disable_device',      eval(rank_disable_device      + 0))
define(`rank_disguise',            eval(rank_disguise            + 0))
define(`rank_escape_artist',       eval(rank_escape_artist       + 0))
define(`rank_forgery',             eval(rank_forgery             + 0))
define(`rank_gather_info',         eval(rank_gather_info         + 0))
define(`rank_handle_animal',       eval(rank_handle_animal       + 0))
define(`rank_heal',                eval(rank_heal                + 0))
define(`rank_hide',                eval(rank_hide                + 0))
define(`rank_intimidate',          eval(rank_intimidate          + 0))
define(`rank_jump',                eval(rank_jump                + 0))
define(`rank_knowledge_arcana',    eval(rank_knowledge_arcana    + 0))
define(`rank_knowledge_nature',    eval(rank_knowledge_nature    + 0))
define(`rank_knowledge_religion',  eval(rank_knowledge_religion  + 0))
define(`rank_listen',              eval(rank_listen              + 0))
define(`rank_move_silently',       eval(rank_move_silently       + 0))
define(`rank_open_lock',           eval(rank_open_lock           + 0))
define(`rank_perform_oratory',     eval(rank_perform_oratory     + 0))
define(`rank_prof_herbalist',      eval(rank_prof_herbalist      + 0))
define(`rank_ride',                eval(rank_ride                + 0))
define(`rank_search',              eval(rank_search              + 0))
define(`rank_sense_motive',        eval(rank_sense_motive        + 0))
define(`rank_sleight_of_hand',     eval(rank_sleight_of_hand     + 0))
define(`rank_spellcraft',          eval(rank_spellcraft          + 0))
define(`rank_spot',                eval(rank_spot                + 0))
define(`rank_survival',            eval(rank_survival            + 0))
define(`rank_swim',                eval(rank_swim                + 0))
define(`rank_tumble',              eval(rank_tumble              + 0))
define(`rank_use_magic_device',    eval(rank_use_magic_device    + 0))
define(`rank_use_rope',            eval(rank_use_rope            + 0))

dnl ***** first adventure
define(`char_EP', eval(char_EP + 1000))dnl assistance for druid Dolan against goblins


dnl *****
dnl ***** Level 2: Monk(2)
dnl *****
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 6))dnl 1D8
dnl ***** buy skill points
dnl Level two option feat:
define(`feat_combat_reflexes', 1)


dnl ***** investigation of Tordek's death
define(`char_EP', eval(char_EP +  300))dnl fighting the hellhound at Tordek's death place
define(`char_EP', eval(char_EP +  300))dnl fighting the halforc barbarian in Caermouth
define(`char_EP', eval(char_EP + 1000))dnl fighting a ghost in the catacombs of Caermouth
define(`char_EP', eval(char_EP +  900))dnl fighting a ghost in the catacombs of Caermouth
define(`char_EP', eval(char_EP +  300))dnl fighting the enemy wizard Ernest
define(`char_EP', eval(char_EP +  500))dnl finished first part of investigation of Tordek's death


dnl *****
dnl ***** Level 3: Monk(3)
dnl *****
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 6))dnl 1D8
dnl ***** select new feat
define(`feat_weapon_finesse', 1)
dnl ***** buy skill points


dnl ***** search for Tordek's murderer
define(`char_EP', eval(char_EP + 700))dnl fight in the inn "Seaman's Delight" in the city Unthak
define(`char_EP', eval(char_EP + 100))dnl freeing Alysha from slavery in city Unthak
define(`char_EP', eval(char_EP + 100))dnl ? something in the desert ?
define(`char_EP', eval(char_EP + 675))dnl fighting two carion crawlers
define(`char_EP', eval(char_EP + 150))dnl burial of an elfen skeleton
define(`char_EP', eval(char_EP + 675))dnl fighting a colossal centipede
define(`char_EP', eval(char_EP + 300))dnl arrival at the obelisk & the prophecy


dnl *****
dnl ***** Level 4: Monk(4)
dnl *****
define(`DEX_score',       eval(DEX_score       + 1))
dnl
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 3))dnl 1D8
dnl ***** buy skill points


dnl ***** continue the search for Tordek's murderer
define(`char_EP', eval(char_EP + 1150))dnl fighting orcs at the obelisk
define(`char_EP', eval(char_EP +  640))dnl fighting Lolth priestress Elerianda
define(`char_EP', eval(char_EP +  500))dnl arrival in Serador
define(`char_EP', eval(char_EP +  200))dnl help for female elf trader against two dirger
define(`char_EP', eval(char_EP + 2451))dnl fight against undead (zombies and vampires) in Alysha's home castle
define(`char_EP', eval(char_EP +  300))dnl finishing this sub adventure


dnl *****
dnl ***** Level 5: Monk(5)
dnl *****
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 7))dnl 1D8
dnl ***** buy skill points


define(`char_EP', eval(char_EP + 1030))dnl helping pixies against wyvern
define(`char_EP', eval(char_EP + 1687))dnl journey from orcs to fire-giants: fight against two deinonychi and two roc birds
define(`char_EP', eval(char_EP + 2250))dnl fighting one fire-giant


dnl *****
dnl ***** Level 6: Monk(6)
dnl *****
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 7))dnl 1D8
dnl ***** select new feat
define(`feat_dodge', 1)
define(`feat_improved_disarm', 1)
dnl ***** buy skill points


define(`char_EP', eval(char_EP + 1350))dnl fighting one fire-giant
define(`char_EP', eval(char_EP +  150))dnl fighting some orcs
define(`char_EP', eval(char_EP + 1350))dnl fighting one green slaad
define(`char_EP', eval(char_EP + 2500))dnl finishing this adventure-step and activate the teleporter platform


dnl *****
dnl ***** Level 7: Monk(7)
dnl *****
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 4))dnl 1D8
dnl ***** buy skill points


define(`char_EP', eval(char_EP + 116 + 263 + 263 + 420 + 500))dnl fighting some rats and a rat-king in Thetys
define(`char_EP', eval(char_EP + 300))dnl finishing this adventure step in Thetys
define(`char_EP', eval(char_EP +    0))dnl ??? Liro fights in the tavern
define(`rank_diplomacy',           eval(rank_diplomacy            + 1))dnl experience at the king's banquet in Eratrea
define(`char_EP', eval(char_EP +  300))dnl finishing this adventure step in Eratrea, leaving for next teleporter place
define(`char_EP', eval(char_EP + 1400))dnl fighting two red slaads in teleporter hall
define(`char_EP', eval(char_EP + 2100))dnl fighting some green slaads
define(`char_EP', eval(char_EP + 3360))dnl fighting some gray and green slaads


dnl *****
dnl ***** Level 8: Monk(8)
dnl *****
define(`DEX_score',       eval(DEX_score       + 1))
dnl
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 4))dnl 1D8
dnl ***** buy skill points


define(`char_EP', eval(char_EP +  960))dnl fighting one belilith-demon in teleporter chamber
define(`char_EP', eval(char_EP + 1440))dnl fighting one hezrou-demon below teleporter chamber
define(`char_EP', eval(char_EP + 3200))dnl fighting one red slaad and one wizard below teleporter chamber
define(`char_EP', eval(char_EP +  960))dnl one succubus-daemon: persuit, capture, interrogation, escape-prevention


dnl *****
dnl ***** Level 9: Monk(9)
dnl *****
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 4))dnl 1D8
dnl ***** select new feat
dnl ***** buy skill points

define(`char_EP', eval(char_EP + 5400))dnl fighting one Fomorian
define(`char_EP', eval(char_EP + 4050))dnl fighting one Soldat + Vrock



dnl *****
dnl ***** Level 10: Monk(10)
dnl *****
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 8))dnl 1D8
dnl ***** select new feat
dnl ***** buy skill points

define(`rank_appraise',            eval(rank_appraise            + 0))
define(`rank_balance',             eval(rank_balance             + 8))
define(`rank_bluff',               eval(rank_bluff               + 0))
define(`rank_climb',               eval(rank_climb               + 10))
define(`rank_concentration',       eval(rank_concentration       + 0))
define(`rank_craft_calligraphy',   eval(rank_craft_calligraphy   + 0))
define(`rank_decipher_script',     eval(rank_decipher_script     + 0))
define(`rank_diplomacy',           eval(rank_diplomacy           + 1))
define(`rank_disable_device',      eval(rank_disable_device      + 0))
define(`rank_disguise',            eval(rank_disguise            + 0))
define(`rank_escape_artist',       eval(rank_escape_artist       + 2))
define(`rank_forgery',             eval(rank_forgery             + 0))
define(`rank_gather_info',         eval(rank_gather_info         + 0))
define(`rank_handle_animal',       eval(rank_handle_animal       + 0))
define(`rank_heal',                eval(rank_heal                + 0))
define(`rank_hide',                eval(rank_hide                + 6))
define(`rank_intimidate',          eval(rank_intimidate          + 0))
define(`rank_jump',                eval(rank_jump                + 2))
define(`rank_knowledge_arcana',    eval(rank_knowledge_arcana    + 1))
define(`rank_knowledge_nature',    eval(rank_knowledge_nature    + 0))
define(`rank_knowledge_religion',  eval(rank_knowledge_religion  + 2))
define(`rank_listen',              eval(rank_listen              + 8))
define(`rank_move_silently',       eval(rank_move_silently       + 6))
define(`rank_open_lock',           eval(rank_open_lock           + 0))
define(`rank_perform_oratory',     eval(rank_perform_oratory     + 1))
define(`rank_prof_herbalist',      eval(rank_prof_herbalist      + 1))
define(`rank_ride',                eval(rank_ride                + 1))
define(`rank_search',              eval(rank_search              + 0))
define(`rank_sense_motive',        eval(rank_sense_motive        + 1))
define(`rank_sleight_of_hand',     eval(rank_sleight_of_hand     + 0))
define(`rank_spellcraft',          eval(rank_spellcraft          + 0))
define(`rank_spot',                eval(rank_spot                + 11))
define(`rank_survival',            eval(rank_survival            + 1))
define(`rank_swim',                eval(rank_swim                + 4))
define(`rank_tumble',              eval(rank_tumble              + 11))
define(`rank_use_magic_device',    eval(rank_use_magic_device    + 0))
define(`rank_use_rope',            eval(rank_use_rope            + 0))

define(`feat_mobility', 1)


dnl *****
dnl ***** Level 11: Monk(11)
dnl *****
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 7))dnl 1D8
dnl ***** select new feat
dnl ***** buy skill points

define(`rank_balance',             eval(rank_balance             + 1))
define(`rank_craft_calligraphy',   eval(rank_craft_calligraphy   + 1))
define(`rank_diplomacy',           eval(rank_diplomacy           + 1))
define(`rank_knowledge_religion',  eval(rank_knowledge_religion  + 1))
define(`rank_listen',              eval(rank_listen              + 1))
define(`rank_sense_motive',        eval(rank_sense_motive        + 1))
define(`rank_spot',                eval(rank_spot                + 1))

define(`char_EP', eval(char_EP + 3666))dnl vrock
define(`char_EP', eval(char_EP + 438))dnl ghouls + ghasts
define(`char_EP', eval(char_EP + 2550))dnl ghoul flesh golem
define(`char_EP', eval(char_EP + 1600))dnl cleric kill + bonus xp


dnl define(`level_monk',      20)dnl this is for testing the monk-class algorithms

dnl *****
dnl ***** Level 12: Monk(12)
dnl *****
define(`DEX_score',       eval(DEX_score       + 1))
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 8))dnl 1D8
dnl ***** select new feat
define(`feat_spring_attack', 1)
dnl ***** buy skill points

define(`rank_balance',             eval(rank_balance             + 1))
define(`rank_climb',               eval(rank_climb               + 1))
define(`rank_hide',                eval(rank_hide                + 1))
define(`rank_listen',              eval(rank_listen              + 1))
define(`rank_move_silently',       eval(rank_move_silently       + 1))
define(`rank_spot',                eval(rank_spot                + 1))
define(`rank_tumble',              eval(rank_tumble              + 1))

define(`char_EP', eval(char_EP + 1100)) dnl Bone Naga
define(`char_EP', eval(char_EP + 2640)) dnl jarilith
define(`char_EP', eval(char_EP + 440))  dnl 
define(`char_EP', eval(char_EP + 500))  dnl 
define(`char_EP', eval(char_EP + 83))   dnl 
define(`char_EP', eval(char_EP + 1980)) dnl
define(`char_EP', eval(char_EP + 3300)) dnl
define(`char_EP', eval(char_EP + 3300)) dnl


dnl define(`level_monk',      20)dnl this is for testing the monk-class algorithms

dnl *****
dnl ***** Level 13: Monk(13)
dnl *****
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 8))dnl 1D8
dnl ***** select new feat
define(`feat_diamond_soul', 1)
dnl ***** buy skill points

define(`rank_balance',             eval(rank_balance             + 1))
define(`rank_climb',               eval(rank_climb               + 1))
define(`rank_diplomacy',           eval(rank_hide                + 1))
define(`rank_listen',              eval(rank_listen              + 1))
define(`rank_knowledge_religion',  eval(rank_knowledge_religion  + 1))
define(`rank_spot',                eval(rank_spot                + 1))
define(`rank_tumble',              eval(rank_tumble              + 1))

define(`char_EP', eval(char_EP + 4520)) dnl
define(`char_EP', eval(char_EP + 4320)) dnl 
define(`char_EP', eval(char_EP + 3720)) dnl 
define(`char_EP', eval(char_EP + 720))  dnl 
define(`char_EP', eval(char_EP + 720))  dnl 
define(`char_EP', eval(char_EP + 720))   dnl 


dnl *****
dnl ***** Level 14: Monk(14)
dnl *****
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 4))dnl 1D8
dnl ***** select new feat
define(`feat_diamond_soul', 1)
dnl ***** buy skill points

dnl define(`rank_balance',             eval(rank_balance             + 1))
define(`rank_climb',               eval(rank_climb               + 1))
define(`rank_diplomacy',           eval(rank_hide                + 2))
dnl define(`rank_listen',              eval(rank_listen              + 1))
define(`rank_knowledge_religion',  eval(rank_knowledge_religion  + 1))
define(`rank_spot',                eval(rank_spot                + 1))
dnl define(`rank_tumble',              eval(rank_tumble              + 1))
define(`rank_use_rope',            eval(rank_use_rope            + 1))
define(`rank_move_silently',       eval(rank_move_silently       + 1))

dnl from stone of good luck
define(`bonus_skills_global_item',      1)
define(`save_fort_item', 1)
define(`save_rflx_item', 1)
define(`save_will_item', 1)


define(`char_EP', eval(char_EP + 1300))  dnl
define(`char_EP', eval(char_EP + 975))   dnl 
define(`char_EP', eval(char_EP + 5200))  dnl 
define(`char_EP', eval(char_EP + 216))   dnl 
define(`char_EP', eval(char_EP + 1300))  dnl 
define(`char_EP', eval(char_EP + 1733))  dnl
define(`char_EP', eval(char_EP + 735))   dnl 
define(`char_EP', eval(char_EP + 262))   dnl

define(`char_EP', eval(char_EP + 2100))  dnl
define(`char_EP', eval(char_EP + 266))   dnl
define(`char_EP', eval(char_EP + 300))   dnl
define(`char_EP', eval(char_EP + 200))   dnl
define(`char_EP', eval(char_EP + 2520))  dnl
define(`char_EP', eval(char_EP + 10640)) dnl L20 Fighter


dnl *****
dnl ***** Level 15: Monk(15)
dnl *****
define(`level_monk',      eval(level_monk      + 1))
define(`char_HP',         eval(char_HP         + 8))dnl 1D8  TBD!
dnl ***** select new feat
dnl ***** buy skill points

dnl define(`rank_balance',             eval(rank_balance             + 1))
define(`rank_bluff',               eval(rank_bluff               + 1))
define(`rank_spellcraft',           eval(rank_spellcraft         + 1))
dnl define(`rank_listen',              eval(rank_listen              + 1))
define(`rank_knowledge_religion',  eval(rank_knowledge_religion  + 1))
define(`rank_spot',                eval(rank_spot                + 1))
dnl define(`rank_tumble',              eval(rank_tumble              + 1))
define(`rank_perform_dancing',            eval(rank_perform_dancing            + 1))



dnl *****
dnl ***** Armor
dnl *****
define(`char_armor',  wear_armor_none(7))dnl bracers of armor (+6 armor AC) + monks belt(+1 AC)

dnl *****
dnl ***** armor: none
dnl *****

define(`AC_deflect',   eval(AC_deflect   +  5))dnl Ring of Protection +5
define(`STR_scitm',    eval(STR_scitm    +  2))dnl by Ioun stone
define(`DEX_scitm',    eval(DEX_scitm    +  4))dnl by Gloves of Dexterity +4
define(`WIS_scitm',    eval(WIS_scitm    +  4))dnl by Periapt of Wisdom +4

dnl ***** Weapons
define(`weapon_line_char', dnl
weapon_line_unarmed_strike(0,0,medium,,)
dnl weapon_line_quarterstaff(0,0,medium,,)
weapon_line_sling(0,0,medium,0,20)
weapon_line_nunchaku(2,2,medium,,))


dnl weapon token, attack bonus, damage bonus, weapon size, specially built composite bow strength bonus, ammunition
define(`char_weapons', dnl
calc_weapon(unarmed_strike,0,0,medium,,,,)dnl
calc_weapon(sling,0,0,medium,,20,,)dnl
calc_weapon(nunchaku,2,2,medium,,,o,of shock +1D6 on command)dnl
calc_weapon(nunchaku,1,1,medium,,,,Viscious Nunchaku: +2D6\komma +1D6 Backfire)dnl
calc_weapon(nunchaku,3,3,medium,,,,of frost)dnl
calc_weapon(kama,4,4,medium,,,,axiomatic vivcious shocking burst)dnl
)


dnl ***** Wealth
define(`wealth_platinum',   0)
define(`wealth_gold',       0)
define(`wealth_silver',     0)
define(`wealth_copper',     0)

define(`list_cargo', `item_multiple(nunchaku, 3), item_multiple(potion, 2)')dnl item_container(5 lbs), shortbow, arrows


dnl ***** if the following definition is non-zero then include the file "char_xxx.inc" to the end of the character sheet
define(`char_attach_supplement', 1)
dnl ***** if the following definition is non-zero then show a table to convert units to the end of the character sheet
define(`char_attach_units', 0)


include(`calculations.m4')dnl ***** don't remove this line

