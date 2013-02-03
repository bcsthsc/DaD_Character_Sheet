include(`defaults.m4')dnl ***** first initialize, don't remove this line


dnl ***** abbreviations used:
dnl ***** PHB = Player's Handbook
dnl ***** DMG = Dungeon Master's Guide
dnl ***** MOM = Monster Manual


dnl ***** enter character's name and other information here
dnl ***** sheet will be generated using LaTeX, so make free use of its features
define(`char_name',          `Urivol Ralanodel')
define(`char_height',        `5 1')dnl format `x<space>y' means x feet and y inch
define(`char_weight',        `109')dnl lbs.
define(`char_age',           `142')dnl years
define(`char_hair_color',    `silver')
define(`char_eye_color',     `green')
define(`char_skin_color',    `light')
define(`char_gender',        `male')
define(`char_race',          `Elf')
define(`char_alignment',     `neutral-good')
define(`char_patron_deity',  `Corellon Larethian')
define(`char_turn_polarity', `1')dnl 1 = turn and destroy (good cleric), 0 = rebuke and command (evil cleric)
dnl define(`char_pic',          `urivol.eps')


dnl ***** enter the ability scores here
dnl ***** !!! modifications according to race will automatically be made, (PHB: Table 2-1, p. 12)
define(`STR_score', 11)
define(`DEX_score', 15)
define(`CON_score', 16)
define(`INT_score', 18)
define(`WIS_score', 13)
define(`CHA_score', 14)


dnl ***** show following additional skills
define(`show_craft_bow_making',    1)dnl
define(`show_craft_alchemy',       1)dnl
define(`show_knowledge_arcana',    1)dnl
define(`show_knowledge_engineer',  1)dnl
define(`show_knowledge_dungeon',   1)dnl
define(`show_knowledge_geography', 1)dnl
define(`show_knowledge_history',   1)dnl
define(`show_knowledge_local',     1)dnl
define(`show_knowledge_nature',    1)dnl
define(`show_knowledge_nobility',  1)dnl
define(`show_knowledge_religion',  1)dnl
define(`show_knowledge_planes',    1)dnl
define(`show_prof_scribe',         1)dnl


dnl *****
dnl ***** Level 1: Wizard(1)
dnl *****
dnl
dnl first level of new class, set additional class skills
define(`csl_craft_bow_making',  csl_craft_bow_making wizard)
define(`csl_prof_scribe',       csl_prof_scribe wizard)
dnl select first feat
define(`feat_toughness',                         1)dnl
dnl Wizard bonus feat "Scribe Scroll" is listed automatically
dnl
dnl set languages (see PHB p. 82), Common is listed by default, Elven for Elves too
define(`char_languages', char_languages\komma Draconic\komma Sylvan\komma Gnome\komma Goblin)dnl
dnl
define(`level_wizard',    eval(level_wizard    + 1))
define(`char_HP',         eval(char_HP         + 4))dnl first level ever: max(1D4), DON'T ADD CONSTITUTION-BONUS !!! (this works automatically !)
dnl ***** buy skill ranks for 24 skill points
define(`rank_appraise',            eval(rank_appraise             + 0))dnl
define(`rank_balance',             eval(rank_balance              + 0))dnl
define(`rank_bluff',               eval(rank_bluff                + 0))dnl
define(`rank_climb',               eval(rank_climb                + 0))dnl
define(`rank_concentration',       eval(rank_concentration        + 4))dnl
define(`rank_craft_bow_making',    eval(rank_craft_bow_making     + 2))dnl
define(`rank_decipher_script',     eval(rank_decipher_script      + 4))dnl
define(`rank_diplomacy',           eval(rank_diplomacy            + 0))dnl
define(`rank_disable_device',      eval(rank_disable_device       + 0))dnl
define(`rank_disguise',            eval(rank_disguise             + 0))dnl
define(`rank_escape_artist',       eval(rank_escape_artist        + 0))dnl
define(`rank_forgery',             eval(rank_forgery              + 0))dnl
define(`rank_gather_info',         eval(rank_gather_info          + 0))dnl
define(`rank_handle_animal',       eval(rank_handle_animal        + 0))dnl
define(`rank_heal',                eval(rank_heal                 + 0))dnl
define(`rank_hide',                eval(rank_hide                 + 0))dnl
define(`rank_intimidate',          eval(rank_intimidate           + 0))dnl
define(`rank_jump',                eval(rank_jump                 + 0))dnl
define(`rank_knowledge_arcana',    eval(rank_knowledge_arcana     + 4))dnl
define(`rank_knowledge_engineer',  eval(rank_knowledge_engineer   + 0))dnl
define(`rank_knowledge_dungeon',   eval(rank_knowledge_dungeon    + 0))dnl
define(`rank_knowledge_geography', eval(rank_knowledge_geography  + 2))dnl
define(`rank_knowledge_history',   eval(rank_knowledge_history    + 0))dnl
define(`rank_knowledge_local',     eval(rank_knowledge_local      + 0))dnl
define(`rank_knowledge_nature',    eval(rank_knowledge_nature     + 4))dnl
define(`rank_knowledge_nobility',  eval(rank_knowledge_nobility   + 0))dnl
define(`rank_knowledge_religion',  eval(rank_knowledge_religion   + 0))dnl
define(`rank_knowledge_planes',    eval(rank_knowledge_planes     + 0))dnl
define(`rank_listen',              eval(rank_listen               + 0))dnl
define(`rank_move_silently',       eval(rank_move_silently        + 0))dnl
define(`rank_open_lock',           eval(rank_open_lock            + 0))dnl
define(`rank_prof_scribe',         eval(rank_prof_scribe          + 0))dnl
define(`rank_ride',                eval(rank_ride                 + 0))dnl
define(`rank_search',              eval(rank_search               + 0))dnl
define(`rank_sense_motive',        eval(rank_sense_motive         + 0))dnl
define(`rank_sleight_of_hand',     eval(rank_sleight_of_hand      + 0))dnl
define(`rank_spellcraft',          eval(rank_spellcraft           + 4))dnl
define(`rank_spot',                eval(rank_spot                 + 0))dnl
define(`rank_survival',            eval(rank_survival             + 0))dnl
define(`rank_swim',                eval(rank_swim                 + 0))dnl
define(`rank_tumble',              eval(rank_tumble               + 0))dnl
define(`rank_use_magic_device',    eval(rank_use_magic_device     + 0))dnl
define(`rank_use_rope',            eval(rank_use_rope             + 0))dnl


dnl ***** first adventure
define(`char_EP', eval(char_EP + 1000))dnl assistance for druid Dolan against goblins


dnl *****
dnl ***** Level 2: Wizard(2)
dnl *****
define(`level_wizard',    eval(level_wizard    + 1))
define(`char_HP',         eval(char_HP         + 4))dnl 1D4, DON'T ADD CONSTITUTION-BONUS !!!
dnl ***** buy skill ranks for 6 skill points
define(`rank_concentration',       eval(rank_concentration        + 1))dnl
define(`rank_heal',                eval(rank_heal                 + 1))dnl cross class skill
define(`rank_move_silently',       eval(rank_move_silently        + 2))dnl cross class skill
define(`rank_spellcraft',          eval(rank_spellcraft           + 1))dnl
define(`rank_spot',                eval(rank_spot                 + 1))dnl cross class skill
dnl YYY sum = 10 skill points !!!


dnl ***** investigation of Tordek's death
define(`char_EP', eval(char_EP + 300))dnl fighting the hellhound at Tordek's death place
define(`char_EP', eval(char_EP + 300))dnl fighting the halforc barbarian in Caermouth
define(`char_EP', eval(char_EP + 900))dnl fighting a ghost in the catacombs of Caermouth
define(`char_EP', eval(char_EP + 300))dnl fighting the enemy wizard Ernest
define(`char_EP', eval(char_EP + 500))dnl finished first part of investigation of Tordek's death


dnl *****
dnl ***** Level 3: Wizard(3)
dnl *****
define(`level_wizard',    eval(level_wizard    + 1))
define(`char_HP',         eval(char_HP         + 4))dnl 1D4, DON'T ADD CONSTITUTION-BONUS !!!
dnl ***** select new feat
define(`feat_improved_initiative',               1)
dnl ***** buy skill ranks for 6 skill points
define(`rank_concentration',       eval(rank_concentration        + 1))dnl
define(`rank_knowledge_arcana',    eval(rank_knowledge_arcana     + 1))dnl
define(`rank_knowledge_religion',  eval(rank_knowledge_religion   + 2))dnl
define(`rank_prof_scribe',         eval(rank_prof_scribe          + 1))dnl
define(`rank_spellcraft',          eval(rank_spellcraft           + 1))dnl


dnl ***** search for Tordek's murderer
define(`char_EP', eval(char_EP + 700))dnl fight in the inn "Seaman's Delight" in the city Unthak
define(`char_EP', eval(char_EP + 100))dnl freeing Alysha from slavery in city Unthak
define(`char_EP', eval(char_EP + 100))dnl ? something in the desert ?
define(`char_EP', eval(char_EP + 675))dnl fighting two carion crawlers
define(`char_EP', eval(char_EP + 150))dnl burial of an elfen skeleton
define(`char_EP', eval(char_EP + 675))dnl fighting a colossal centipede
define(`char_EP', eval(char_EP + 300))dnl arrival at the obelisk & the prophecy


dnl *****
dnl ***** Level 4: Wizard(4)
dnl *****
define(`INT_score',       eval(INT_score       + 1))
dnl
define(`level_wizard',    eval(level_wizard    + 1))
define(`char_HP',         eval(char_HP         + 2))dnl 1D4, DON'T ADD CONSTITUTION-BONUS !!!
dnl ***** buy skill ranks for 6 skill points
define(`rank_craft_bow_making',    eval(rank_craft_bow_making     + 1))dnl
define(`rank_disable_device',      eval(rank_disable_device       + 1))dnl cross class skill
define(`rank_spellcraft',          eval(rank_spellcraft           + 1))dnl
define(`rank_survival',            eval(rank_survival             + 1))dnl cross class skill
define(`rank_use_magic_device',    eval(rank_use_magic_device     + 3))dnl cross class skill
dnl YYY sum = 12 skill points !!!


dnl ***** continue the search for Tordek's murderer
define(`char_EP', eval(char_EP + 1150))dnl fighting orcs at the obelisk
define(`char_EP', eval(char_EP +  640))dnl fighting Lolth priestress Elerianda
define(`char_EP', eval(char_EP +  500))dnl arrival in Serador
define(`char_EP', eval(char_EP + 2451))dnl fight against undead (zombies and vampires) in Alysha's home castle
define(`char_EP', eval(char_EP +  300))dnl finishing this sub adventure


dnl *****
dnl ***** Level 5: Wizard(5)
dnl *****
define(`level_wizard',    eval(level_wizard    + 1))
define(`char_HP',         eval(char_HP         + 3))dnl 1D4, DON'T ADD CONSTITUTION-BONUS !!!
dnl ***** select new wizard bonus feat
define(`feat_brew_potion',                       1)
dnl ***** buy skill ranks for 6 skill points
define(`rank_craft_bow_making',    eval(rank_craft_bow_making     + 1))dnl
define(`rank_heal',                eval(rank_heal                 + 1))dnl cross class skill
define(`rank_knowledge_arcana',    eval(rank_knowledge_arcana     + 2))dnl
define(`rank_ride',                eval(rank_ride                 + 2))dnl cross class skill
define(`rank_spellcraft',          eval(rank_spellcraft           + 1))dnl
dnl YYY sum = 10 skill points !!!


dnl ***** continue
define(`char_EP', eval(char_EP + 1030))dnl helping pixies against wyvern
define(`char_EP', eval(char_EP + 1687))dnl journey from orcs to fire-giants: fight against two deinonychi and two roc birds
define(`char_EP', eval(char_EP + 2250))dnl fighting one fire-giant


dnl *****
dnl ***** Level 6: Wizard(6)
dnl *****
define(`level_wizard',    eval(level_wizard    + 1))
define(`char_HP',         eval(char_HP         + 4))dnl 1D4, DON'T ADD CONSTITUTION-BONUS !!!
dnl ***** select new feat
define(`feat_point_blank_shot',                  1)
dnl ***** buy skill ranks for 6 skill points
define(`rank_climb',               eval(rank_climb                + 1))dnl cross class skill
define(`rank_gather_info',         eval(rank_gather_info          + 1))dnl cross class skill
define(`rank_knowledge_arcana',    eval(rank_knowledge_arcana     + 1))dnl
define(`rank_knowledge_geography', eval(rank_knowledge_geography  + 1))dnl
define(`rank_search',              eval(rank_search               + 1))dnl cross class skill
define(`rank_spellcraft',          eval(rank_spellcraft           + 1))dnl
dnl YYY sum = 9 skill points !!!


dnl ***** continue
define(`char_EP', eval(char_EP + 1350))dnl fighting one fire-giant
define(`char_EP', eval(char_EP +  150))dnl fighting some orcs
define(`char_EP', eval(char_EP + 1350))dnl fighting one green slaad
define(`char_EP', eval(char_EP + 2500))dnl finishing this adventure-step and activate the teleporter platform


dnl *****
dnl ***** Level 7: Wizard(7)
dnl *****
define(`level_wizard',    eval(level_wizard    + 1))
define(`char_HP',         eval(char_HP         + 3))dnl 1D4, DON'T ADD CONSTITUTION-BONUS !!!
dnl ***** buy skill ranks for 6 skill points
define(`rank_decipher_script',     eval(rank_decipher_script      + 1))dnl
define(`rank_knowledge_arcana',    eval(rank_knowledge_arcana     + 1))dnl
define(`rank_ride',                eval(rank_ride                 + 1))dnl cross class skill
define(`rank_search',              eval(rank_search               + 1))dnl cross class skill
define(`rank_sense_motive',        eval(rank_sense_motive         + 1))dnl cross class skill
define(`rank_swim',                eval(rank_swim                 + 1))dnl cross class skill
dnl YYY sum = 10 skill points !!!


dnl ***** continue
define(`char_EP', eval(char_EP + 116 + 263 + 263 + 420 + 500))dnl fighting some rats and a rat-king
define(`char_EP', eval(char_EP + 300))dnl finishing this adventure step in Thetys
define(`rank_diplomacy',           eval(rank_diplomacy            + 1))dnl experience at the king's banquet in Eratrea
define(`char_EP', eval(char_EP +  300))dnl finishing this adventure step in Eratrea, leaving for next teleporter place
define(`char_EP', eval(char_EP + 1400))dnl fighting two red slaads in teleporter hall
define(`char_EP', eval(char_EP + 2100))dnl fighting some green slaads
define(`char_EP', eval(char_EP + 3360))dnl fighting some gray and green slaads


dnl *****
dnl ***** Level 8: Wizard(8)
dnl *****
define(`INT_score',       eval(INT_score       + 1))
dnl
define(`level_wizard',    eval(level_wizard    + 1))
define(`char_HP',         eval(char_HP         + 4))dnl 1D4, DON'T ADD CONSTITUTION-BONUS !!!
dnl ***** buy skill ranks for 7 skill points
define(`rank_craft_alchemy',       eval(rank_craft_alchemy        + 1))dnl was: alchemy cross class skill
define(`rank_handle_animal',       eval(rank_handle_animal        + 1))dnl was: animal_empathy cross class skill
define(`rank_knowledge_arcana',    eval(rank_knowledge_arcana     + 1))dnl
define(`rank_move_silently',       eval(rank_move_silently        + 1))dnl cross class skill
define(`rank_sense_motive',        eval(rank_sense_motive         + 1))dnl was: read_lips cross class skill
define(`rank_spellcraft',          eval(rank_spellcraft           + 1))dnl
define(`rank_spot',                eval(rank_spot                 + 1))dnl cross class skill
dnl YYY sum = 12 skill points !!!


dnl ***** continue
define(`char_EP', eval(char_EP +  960))dnl fighting one belilith-demon in teleporter chamber
define(`char_EP', eval(char_EP + 1440))dnl fighting one hezrou-demon below teleporter chamber
define(`char_EP', eval(char_EP + 3200))dnl fighting one red slaad and one wizard below teleporter chamber
define(`char_EP', eval(char_EP +  960))dnl one succubus-daemon: persuit, capture, interrogation, escape-prevention



dnl *****
dnl ***** Level 9: Wizard(9)
dnl *****
define(`level_wizard',    eval(level_wizard    + 1))
define(`char_HP',         eval(char_HP         + 4))dnl 1D4, DON'T ADD CONSTITUTION-BONUS !!!
dnl ***** select new feat
define(`feat_eschew_materials',                  1)
dnl ***** buy skill ranks for 7 skill points
define(`rank_knowledge_arcana',    eval(rank_knowledge_arcana     + 1))dnl
define(`rank_spellcraft',          eval(rank_spellcraft           + 1))dnl
define(`rank_spot',                eval(rank_spot                 + 1))dnl cross class skill
dnl YYY sum = 4 skill points !!!


dnl ***** continue
define(`char_EP', eval(char_EP +  18449))dnl XP with Lvl 11


dnl YYY EP-data from Hazela
dnl
dnl dnl mountains at dwarves
dnl define(`char_EP', eval(char_EP + 5400))dnl fighting one nalfeshnee demon
dnl define(`char_EP', eval(char_EP + 4050))dnl fighting two tattoo-guards and one vrock (in persuit of Halfling monk Lyle Goodbarrel)
dnl define(`char_EP', eval(char_EP + 1500))dnl fighting one fomorian (huge giant)
dnl define(`char_EP', eval(char_EP + 2000))dnl fighting one evil cleric (formerly Jee-Was, now demon lord Graz'zt)
dnl define(`char_EP', eval(char_EP +  400))dnl fighting (no kill) cleric's sorceress Marietta
dnl define(`char_EP', eval(char_EP +  666))dnl dispelling summoned vrock (Hazela and who else ???)
dnl define(`char_EP', eval(char_EP +  600))dnl finishing this adventure step
dnl 
dnl dnl leave dwarves, begin journey through dust desert toward city Narsk
dnl define(`char_EP', eval(char_EP +  438))dnl fighting some ghasts
dnl define(`char_EP', eval(char_EP + 2250))dnl fighting one ghoul flesh golem
dnl define(`char_EP', eval(char_EP + 1500))dnl fighting one fake Wee-Jas priest in Wee-Jas monastry
dnl define(`char_EP', eval(char_EP +  100))dnl liberation of true Wee-Jas statue in monastry
dnl 
dnl dnl ghost city and dungeon of Lich in dust desert
dnl define(`char_EP', eval(char_EP + 2640))dnl fighting two Jariliths
dnl define(`char_EP', eval(char_EP +  440))dnl fighting two Palrethee
dnl define(`char_EP', eval(char_EP + 1980))dnl fighting one Wizard-Lich
dnl define(`char_EP', eval(char_EP +   83))dnl fighting one Jovoc
dnl define(`char_EP', eval(char_EP +  500))dnl finishing the dungeon sub-adventure
dnl individual EP for Urivol for liberation of Zuluth ???
dnl 
dnl dnl city Narsk
dnl define(`char_EP', eval(char_EP +  500))dnl first days in city Narsk: Urivol meets with female novice from magic shop




dnl *****
dnl ***** Level 10: Wizard(10)
dnl *****
define(`level_wizard',    eval(level_wizard    + 1))
define(`char_HP',         eval(char_HP         + 2))dnl 1D4, DON'T ADD CONSTITUTION-BONUS !!!
dnl ***** select new wizard bonus feat
define(`feat_combat_casting',                  1)dnl YYY must be metamagic, item creation, or spell mastery !!!
dnl ***** buy skill ranks for 7 skill points
define(`rank_knowledge_religion',  eval(rank_knowledge_religion  + 1))dnl experience at the king's banquet in Eratrea  YYY ???
define(`rank_listen',              eval(rank_listen              + 1))dnl cross class skill
define(`rank_spot',                eval(rank_spot                + 1))dnl cross class skill
define(`rank_survival',            eval(rank_survival            + 1))dnl cross class skill
define(`char_EP', eval(char_EP +  500))dnl Wee-Jas-Priesterin Surema
define(`char_EP', eval(char_EP +  100))dnl Wee-Jas-Statue wieder aufgestellt


dnl *****
dnl ***** Level 11: Wizard(11)
dnl *****
define(`level_wizard',    eval(level_wizard    + 1))
define(`char_HP',         eval(char_HP         + 3))dnl 1D4, DON'T ADD CONSTITUTION-BONUS !!!
dnl ***** buy skill ranks for 7 skill points
define(`rank_knowledge_geography', eval(rank_knowledge_geography  + 1))dnl +1 funzt nicht :-(  YYY bei mir schon
define(`rank_knowledge_history',   eval(rank_knowledge_history    + 1))dnl
define(`rank_knowledge_nature',    eval(rank_knowledge_nature     + 1))dnl
define(`rank_listen',              eval(rank_listen               + 1))dnl cross class skill
define(`rank_spot',                eval(rank_spot                 + 1))dnl cross class skill
define(`char_EP', eval(char_EP + 2640))dnl Jarilith in Ruinenstadt
define(`char_EP', eval(char_EP + 440))dnl Palrethee in Ruinenstadt
define(`char_EP', eval(char_EP + 2062))dnl Lich+Jovoc in Ruinenstadt
define(`char_EP', eval(char_EP + 500))dnl Befreiung Zuluth
dnl Change from neutral good to neutral
define(`char_EP', eval(char_EP + 500))dnl Wizard-Lich-Dungeon
dnl define(`char_languages', char_languages\komma Marundian (basics))dnl
define(`char_EP', eval(char_EP +  500))dnl Rendezvous mit Nivizin Cilia
define(`char_EP', eval(char_EP + 2970))dnl Wache+Moench im Tempel
define(`char_EP', eval(char_EP + 2640))dnl Otanto
define(`char_EP', eval(char_EP + 1000))dnl Otantos Raum durchsucht

dnl YYY sum = 8 skill points
dnl YYY wegen Knowledge Geography: Hast Du diese Datei in das Verzeichnis "characters" kopiert ?

dnl YYY Wenn ich mich nicht verrechnet habe, hast Du insgesamt 112 skill points eingesetzt.
dnl YYY Es sollten aber nur 88 sein.


dnl *****
dnl ***** Level 12: Wizard(12)
dnl *****
define(`level_wizard',    eval(level_wizard    + 1))
define(`char_HP',         eval(char_HP         + 3))dnl 1D4, DON'T ADD CONSTITUTION-BONUS !!!
dnl ***** select new feat
define(`feat_spell_penetration',               1)
dnl ***** buy skill ranks for 7 skill points
define(`rank_knowledge_engineer',  eval(rank_knowledge_engineer   + 1))dnl 
define(`rank_knowledge_dungeon',   eval(rank_knowledge_dungeon    + 1))dnl
define(`rank_knowledge_local',     eval(rank_knowledge_local      + 1))dnl
define(`rank_knowledge_nobility',  eval(rank_knowledge_nobility   + 1))dnl 
define(`rank_knowledge_planes',    eval(rank_knowledge_planes     + 1))dnl
define(`char_languages', char_languages\komma Marundian)dnl 2 Skillpoints
define(`char_EP', eval(char_EP + 200))dnl Sarnbrink Beweise gegeben
dnl 25.06.2011
define(`char_EP', eval(char_EP + 100))dnl Liros Kampf zugeschaut (Acheron-Ebene)
define(`char_EP', eval(char_EP + 50000))dnl Deck of many things:sun


dnl *****
dnl ***** Level 15: Wizard(15)
dnl *****
define(`level_wizard',    eval(level_wizard    + 3))
define(`char_HP',         eval(char_HP         + 10))dnl 1D4, DON'T ADD CONSTITUTION-BONUS !!!
dnl ***** buy skill ranks for 21 skill points
dnl 15*8=120, 112 skill points bisher verteilt => noch 8 skill points uebrig
define(`rank_knowledge_arcana',    eval(rank_knowledge_arcana     + 2))dnl
define(`rank_knowledge_history',   eval(rank_knowledge_history    + 1))dnl
define(`rank_knowledge_planes',    eval(rank_knowledge_planes     + 1))dnl
define(`rank_spellcraft',          eval(rank_spellcraft           + 2))dnl
define(`rank_tumble',              eval(rank_tumble               + 1))dnl

dnl buy skill ranks and feats for familiar !!!
dnl see file `char_urivol.anm' (skill points and feats list at its end)



dnl *****
dnl ***** Level 16: Wizard(16)
dnl *****
define(`level_wizard',    eval(level_wizard    + 1))
define(`char_HP',         eval(char_HP         + 3))dnl 1D4, DON'T ADD CONSTITUTION-BONUS !!!
dnl ***** select new feat
dnl define(`feat_spell_penetration',               1)
dnl ***** buy skill ranks for 7 skill points
define(`rank_craft_alchemy',       eval(rank_craft_alchemy        + 2))dnl
define(`rank_craft_bow_making',    eval(rank_craft_bow_making     + 1))dnl
define(`rank_knowledge_arcana',    eval(rank_knowledge_arcana     + 1))dnl
define(`rank_knowledge_geography', eval(rank_knowledge_geography  + 1))dnl 
define(`rank_spot',                eval(rank_spot                 + 1))dnl cross class skill
define(`char_EP', eval(char_EP + 300))dnl mit Kadan Schatten in Tethys bekämpft 
define(`char_EP', eval(char_EP + 1800))dnl Onan - Wizard aus Tethys
define(`char_EP', eval(char_EP + 1275))dnl 3 Gardisten: Sensenmann, Schildmann, Frau Fighter
define(`char_EP', eval(char_EP + 333))dnl Tethys
dnl 11./12.11.2011 Kampf gegen Alluviel
define(`char_EP', eval(char_EP + 1000))dnl Fighter + Wizard
define(`char_EP', eval(char_EP + 2133))dnl Alluviel (Schwarzdrache)
define(`char_EP', eval(char_EP + 533))dnl Helfer von Alluviel
define(`char_EP', eval(char_EP + 800))dnl Rogue (Liros Freundin)
define(`char_EP', eval(char_EP + 5000))dnl Befreiung von Tethys
dnl 11.Februar 2012 Leben in Tethys wieder auf den rechten Weg zurück bringen
define(`char_EP', eval(char_EP + 150))dnl Wasserleichenkapitän
dnl 12.05.2012 Halblingsdorf in den Bäumen
define(`char_EP', eval(char_EP + 1200))dnl truly horrible Umberhulk


define(`spells_wizard_0', `
spell_acid_splash
spell_arcane_mark
spell_dancing_lights
spell_daze
spell_detect_magic
spell_detect_poison
spell_disrupt_undead
spell_flare
spell_ghost_sound
spell_light
spell_mage_hand
spell_mending
spell_message
spell_open_close
spell_prestidigitation
spell_ray_of_frost
spell_read_magic
spell_resistance
spell_touch_of_fatigue
')

define(`spells_wizard_1', `
dnl spell_alarm
dnl spell_animate_rope
spell_burning_hands
dnl spell_cause_fear
dnl spell_charm_person
dnl spell_chill_touch
dnl spell_color_spray
dnl spell_comprehend_languages
spell_detect_secret_doors
dnl spell_detect_undead
dnl spell_disguise_self
dnl spell_endure_elements
dnl spell_enlarge_person
spell_feather_fall
spell_grease
dnl spell_hold_portal
dnl spell_hypnotism
spell_identify
dnl spell_jump
spell_mage_armor
spell_magic_missile
spell_mount
dnl spell_obscuring_mist
dnl spell_protection_from_chaos
spell_protection_from_evil
spell_protection_from_good
dnl spell_protection_from_law
spell_shield
spell_shocking_grasp
dnl spell_sleep
spell_summon_monster_1
dnl spell_true_strike
')

define(`spells_wizard_2', `
dnl spell_alter_self
dnl spell_arcane_lock
dnl spell_bears_endurance
dnl spell_blindness_deafness
dnl spell_blur
spell_bulls_strength
spell_cats_grace
dnl spell_command_undead
dnl spell_continual_flame
dnl spell_darkness
spell_darkvision
dnl spell_daze_monster
dnl spell_detect_thoughts
dnl spell_eagles_splendor
dnl spell_flaming_sphere
dnl spell_fog_cloud
dnl spell_foxs_cunning
dnl spell_gust_of_wind
dnl spell_invisibility
spell_knock
spell_melfs_acid_arrow
dnl spell_owls_wisdom
spell_protection_from_arrows
dnl spell_resist_energy
dnl spell_spider_climb
spell_summon_monster_2
dnl spell_summon_swarm
spell_touch_of_idiocy
')

define(`spells_wizard_3', `
dnl spell_arcane_sight
dnl spell_blink
dnl spell_clairaudience_clairvoyance
dnl spell_daylight
dnl spell_deep_slumber
spell_dispel_magic
dnl spell_displacement
spell_fireball
spell_fly
dnl spell_hold_person
spell_invisibility_sphere
dnl spell_nondetection
spell_phantom_steed
dnl spell_protection_from_energy
dnl spell_sleet_storm
spell_summon_monster_3
spell_tongues
spell_water_breathing
dnl spell_wind_wall
')

define(`spells_wizard_4', `
dnl spell_animate_dead
dnl spell_arcane_eye
dnl spell_bestow_curse
dnl spell_charm_monster
dnl spell_confusion
dnl spell_contagion
dnl spell_crushing_despair
dnl spell_detect_scrying
spell_dimension_door
dnl spell_dimensional_anchor
dnl spell_enervation
dnl spell_enlarge_person_mass
spell_fire_shield
dnl spell_fire_trap
dnl spell_ice_storm
spell_invisibility_greater
spell_leomunds_secure_shelter
dnl spell_rainbow_pattern                           !! spell fehlt noch
spell_remove_curse
dnl spell_scrying
spell_shout
dnl spell_stone_shape
dnl spell_stoneskin
dnl spell_summon_monster_4
dnl spell_wall_of_fire
')

define(`spells_wizard_5', `
dnl spell_animal_growth
dnl spell_baleful_polymorph
dnl spell_bigbys_interposing_hand
dnl spell_blight
dnl spell_break_enchantment
dnl spell_cloudkill
dnl spell_cone_of_cold
spell_contact_other_plane
spell_dismissal
spell_dominate_person
dnl spell_dream
spell_hold_monster
dnl spell_mordenkainens_faithful_hound               !! spell fehlt noch
dnl spell_permanency                                 !! spell fehlt noch
spell_sending
spell_summon_monster_5
spell_telekinesis
spell_teleport
dnl spell_transmute_mud_to_rock
dnl spell_transmute_rock_to_mud
dnl spell_wall_of_stone
')

define(`spells_wizard_6', `
dnl spell_acid_fog
dnl spell_analyze_dweomer
dnl spell_antimagic_field
dnl spell_bears_endurance_mass
dnl spell_bigbys_forceful_hand
dnl spell_bulls_strength_mass
dnl spell_cats_grace_mass
spell_chain_lightning
spell_circle_of_death
dnl spell_contingency
dnl spell_control_water
dnl spell_create_undead
dnl spell_disintegrate
spell_dispel_magic_greater
dnl spell_eagles_splendor_mass
dnl spell_foxs_cunning_mass
dnl spell_move_earth
dnl spell_owls_wisdom_mass
spell_summon_monster_6
dnl spell_true_seeing
')

define(`spells_wizard_7', `
dnl spell_control_undead
spell_control_weather
dnl spell_finger_of_death
dnl spell_plain_shift
dnl spell_create_undead_greater
dnl spell_bigbys_forceful_hand
')

define(`spells_wizard_8', `
dnl spell_clone
dnl spell_dimensional_lock
spell_sunburst
')


dnl ***** by cat familiar
define(`show_special_abilities', show_special_abilities\\ +3 Move Silently with familiar within 1 mile`'ifdef(feat_alertness,,\\ +2 Spot and Listen with familiar in arm\aps{}s reach))
define(`CON_scitm',  eval(CON_scitm    +  2))dnl chain with golden amulett with lion-head-engravement (Amulet of Health, DMG, p.246)
define(`INT_scitm',  eval(INT_scitm    +  2))dnl Ioun Stone
define(`mark_move_silently',       1)
define(`mark_spot',                ifdef(`feat_alertness',mark_spot,1))
define(`mark_listen',              ifdef(`feat_alertness',mark_listen,1))



dnl *****
dnl ***** Armor
dnl *****
define(`char_armor',  wear_armor_none(2))dnl bracers of armor (+2 armor AC) will be overwritten by the following
define(`char_armor',  wear_armor_none(4))dnl robe of the neutral mage (+4 armor AC)
define(`AC_deflect',   eval(AC_deflect   +  2))dnl Ring of Protection +2 vom Wee-Jas-Priester


dnl ***** Weapons
define(`weapon_line_char', dnl
weapon_line_dagger(0,0,medium,,)
weapon_line_longsword(0,0,medium,,)
weapon_line_shortbow(1,0,medium,,20))
dnl weapon_line_longbow(2,0,medium,,20))
dnl weapon_line_dagger(0,0,medium,,))       dnl dagger of fire bane

dnl further weapon proficiencies: quarterstaff club rapier longbow longbow_composite shortbow_composite crossbow_heavy crossbow_light


dnl weapon token, attack bonus, damage bonus, weapon size, specially built composite bow strength bonus, ammunition
define(`char_weapons', dnl
calc_weapon(shortbow,1,0,medium,,20)dnl
calc_weapon(longsword,0,0,medium,,)dnl
calc_weapon(dagger,0,0,medium,,)dnl
dnl calc_weapon(longbow,2,0,medium,,20)dnl
dnl calc_weapon(dagger,0,0,medium,,)dnl
)


dnl ***** Wealth
define(`wealth_platinum',   1)
define(`wealth_gold',       1)
define(`wealth_silver',     1)
define(`wealth_copper',     1)

define(`list_cargo', `shortbow, item_multiple(potion, 12)')dnl item_container(5 lbs), arrows

dnl ***** if the following definition is non-zero then include the file "char_xxx.inc" to the end of the character sheet
define(`char_attach_supplement', 1)
dnl ***** if the following definition is non-zero then show a table to convert units to the end of the character sheet
define(`char_attach_units', 0)


include(`calculations.m4')dnl ***** don't remove this line

