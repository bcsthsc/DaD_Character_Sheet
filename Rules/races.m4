
define(stat_race, `translit(char_race, `A-Z-', `a-z')')
ifelse(stat_race,human,,stat_race,dwarf,,stat_race,elf,,stat_race,gnome,,stat_race,halfelf,,stat_race,halforc,,stat_race,halfling,,stat_race,uldra,,dnl
stat_race,outsider,,stat_race,aasimar,,stat_race,tiefling,,dnl
`error(unknown race: char_race)')

dnl ***** favorite classes of races
ifelse(stat_race,    human, `define(favored_class,       any)')
ifelse(stat_race,    dwarf, `define(favored_class,   fighter)')
ifelse(stat_race,      elf, `define(favored_class,    wizard)')
ifelse(stat_race,    gnome, `define(favored_class,      bard)')
ifelse(stat_race,  halfelf, `define(favored_class,       any)')
ifelse(stat_race,  halforc, `define(favored_class, barbarian)')
ifelse(stat_race, halfling, `define(favored_class,     rogue)')
ifelse(stat_race, outsider, `define(favored_class,          )')
ifelse(stat_race,  aasimar, `define(favored_class,   paladin)')
ifelse(stat_race, tiefling, `define(favored_class,     rogue)')
ifelse(stat_race,    uldra, `define(favored_class,     druid)')

dnl ***** ability modifiers according to races
ifelse(stat_race,    dwarf, `define(`CON_score', eval(CON_score + 2))define(`CHA_score', eval(CHA_score - 2))')
ifelse(stat_race,      elf, `define(`DEX_score', eval(DEX_score + 2))define(`CON_score', eval(CON_score - 2))')
ifelse(stat_race,    gnome, `define(`CON_score', eval(CON_score + 2))define(`STR_score', eval(STR_score - 2))')
ifelse(stat_race,  halforc, `define(`STR_score', eval(STR_score + 2))define(`CHA_score', eval(CHA_score - 2))define(`INT_score', eval(INT_score - 2))')
ifelse(stat_race, halfling, `define(`DEX_score', eval(DEX_score + 2))define(`STR_score', eval(STR_score - 2))')
ifelse(stat_race,  aasimar, `define(`WIS_score', eval(WIS_score + 2))define(`CHA_score', eval(CHA_score + 2))')
ifelse(stat_race, tiefling, `define(`DEX_score', eval(DEX_score + 2))define(`INT_score', eval(INT_score + 2))define(`CHA_score', eval(CHA_score - 2))')
ifelse(stat_race,    uldra, `define(`WIS_score', eval(WIS_score + 2))define(`CON_score', eval(CON_score + 2))define(`STR_score', eval(STR_score - 2))')
ifelse(eval(INT_score < 3), 1, `define(`INT_score', 3)')dnl intelligence not below three

dnl ***** pace of characters according to races, PHB p.11-20
define(`char_speed_base', ifelse(char_speed_base,0,ifelse(stat_race,dwarf,20, stat_race,gnome,20, stat_race,halfling,20, stat_race,uldra,20, 30),char_speed_base))

dnl ***** sizes of races, PHB p.11-20, and its modifiers: compare Table 8-1, PHB p.134
dnl ***** acceptable tokens: fine, diminutive, tiny, small, medium, large, huge, gargantuan, colossal
define(`stat_size', ifelse(stat_race,gnome,small, stat_race,halfling,small, stat_race,uldra,small, medium))

dnl ***** list all languages, PHB, p.82
dnl Abyssal, Aquan, Auran, Celestial, Common, Draconic, Druidic, Dwarven, Elven, Giant
dnl Gnome, Goblin, Gnoll, Halfling, Ignan, Infernal, Orc, Sylvan, Terran, Undercommon

dnl ***** race dependend special abilities
ifelse(stat_race, human, `define(`char_languages_bonus', Abyssal\komma Aquan\komma Auran\komma Celestial\komma Draconic\komma Dwarven\komma Elven\komma Giant\komma Gnome\komma Goblin\komma Gnoll\komma Halfling\komma Ignan\komma Infernal\komma Orc\komma Sylvan\komma Terran\komma Undercommon)')

ifelse(stat_race, dwarf, `define(`show_special_abilities', show_special_abilities\\ Darkvision (p.14)\\ Stonecunning (p.15)\\ Weapon Familiarity (p.15)\\ Stability: +4 against being bull rushed or tripped (p.15)\\ +2 Saved against Poisons (p.15)\\ +2 Saves agains Spells and Spell-like Effects (p.15)\\ +1 Attack Bonus against Orcs and Half-Orcs (p.15)\\ +4 Dogde AC Bonus against Huge Monsters (p.15)\\ +2 Appraise related to Stone or Metal Items (p.15)\\ +2 Craft related to Stone or Metal (p.15))dnl
define(`char_languages', char_languages\komma Dwarven)dnl
define(`char_languages_bonus', Giant\komma Gnome\komma Goblin\komma Orc\komma Terran\komma Undercommon)')

ifelse(stat_race, elf, `define(`show_special_abilities', show_special_abilities\\ Low Light Vision (p.16)\\ Meditate instead of Sleep (p.15)\\ Immunity to Magical Sleep (p.16)\\ +2 Saves against Enchantment Spells or Effects (p.16)\\ Weapon Proficiencies (p.16) \done\\ Keen Senses (p.16) \done)dnl
define(`char_languages', char_languages\komma Elven)dnl
define(`char_languages_bonus', Draconic\komma Gnoll\komma Gnome\komma Goblin\komma Orc\komma Sylvan)dnl
define(`bonus_listen', eval(bonus_listen + 2))dnl
define(`bonus_search', eval(bonus_search + 2))dnl
define(`bonus_spot',   eval(bonus_spot   + 2))dnl
define(`proficiencies_weapons', proficiencies_weapons longsword rapier longbow longbow_composite shortbow shortbow_composite)')

ifelse(stat_race, gnome, `define(`show_special_abilities', show_special_abilities\\ Low Light Vision (p.17)\\ +2 Saves against Illusions (p.17)\\ +1 DC Saves against Illusions cast by Gnomes (p.17)\\ +1 Attack Bonus against Kobolds and Goblinoids (p.17)\\ +4 AC Dodge Bonus against Creatures of Giant Type (p.17)\\ Speak with Burrowing Mammals\komma 1 minute\komma 1$\times$/day (p.17)ifelse(eval(CHA_score + CHA_scdam + CHA_scitm >= 10),1,\\ 1$\times$/day Dancing Lights\komma Ghost Sound\komma Prestidigitation (p.17)))dnl
define(`char_languages', char_languages\komma Gnome)dnl
define(`char_languages_bonus', Draconic\komma Dwarven\komma Elven\komma Giant\komma Goblin\komma Orc)dnl
define(`bonus_listen',        eval(bonus_listen        + 2))dnl
define(`bonus_craft_alchemy', eval(bonus_craft_alchemy + 2))')

ifelse(stat_race, halfelf, `define(`show_special_abilities', show_special_abilities\\ Low Light Vision (p.18)\\ Immunity to Magical Sleep (p.18)\\ +2 Saves against Enchantment Spells or Effects (p.18)\\ Keen Senses (p.18)\done\\ Social Affinity (p.18)\done)dnl
define(`char_languages', char_languages\komma Elven)dnl
define(`char_languages_bonus', Abyssal\komma Aquan\komma Auran\komma Celestial\komma Draconic\komma Dwarven\komma Giant\komma Gnome\komma Goblin\komma Gnoll\komma Halfling\komma Ignan\komma Infernal\komma Orc\komma Sylvan\komma Terran\komma Undercommon)dnl
define(`bonus_listen',      eval(bonus_listen      + 1))dnl
define(`bonus_search',      eval(bonus_search      + 1))dnl
define(`bonus_spot',        eval(bonus_spot        + 1))dnl
define(`bonus_diplomacy',   eval(bonus_diplomacy   + 2))dnl
define(`bonus_gather_info', eval(bonus_gather_info + 2))')

ifelse(stat_race, halforc, `define(`show_special_abilities', show_special_abilities\\ Darkvision (p.19)\\ Orc Blood (p.19))dnl
define(`char_languages', char_languages\komma Orc)dnl
define(`char_languages_bonus', Abyssal\komma Draconic\komma Giant\komma Goblin\komma Gnoll)')

ifelse(stat_race, outsider, `define(`show_special_abilities', show_special_abilities\\ Darkvision 60~ft (MOM I,p.313))')

ifelse(stat_race, aasimar, `define(`show_special_abilities', show_special_abilities\\ Darkvision 60~ft\\ Daylight 1`'$\times$`'/day)define(`spec_resist_energy', spec_resist_energy acid_5 cold_5 elec_5)define(`char_languages', char_languages\komma Celestial)define(`bonus_spot', eval(bonus_spot + 2))define(`bonus_listen', eval(bonus_listen + 2))define(`char_languages_bonus', Draconic\komma Dwarven\komma Elven\komma Gnome\komma Halfling\komma Sylvan)define(`level_adjustment', eval(level_adjustment + 1))')

ifelse(stat_race, tiefling, `define(`show_special_abilities', show_special_abilities\\ Darkvision 60~ft\\ Darkness 1`'$\times$`'/day)define(`spec_resist_energy', spec_resist_energy cold_5 elec_5 fire_5)define(`char_languages', char_languages\komma Infernal)define(`bonus_bluff', eval(bonus_bluff + 2))define(`bonus_hide', eval(bonus_hide + 2))define(`char_languages_bonus', Draconic\komma Dwarven\komma Elven\komma Gnome\komma Goblin\komma Halfling\komma Orc)define(`level_adjustment', eval(level_adjustment + 1))')

ifelse(stat_race, uldra, `define(`show_special_abilities', show_special_abilities\\ Darkvision 120~ft\\ Low-Light Vision\\ Nature Scholar \done\\ Resistance Cold 5 (ex)\\ Frosty Touch (su)\\ Fey Blood\\ 3{}$\times$/day Ray of Frost (sp)\\ 1{}$\times$/day Speak with Animals (sp)\\ 1{}$\times$/day Touch of Fatigue (sp))define(`csl_knowledge_nature', csl_knowledge_nature always)define(`csl_speak_language', csl_speak_language always)define(`bonus_knowledge_nature', eval(bonus_knowledge_nature + 2))define(`level_adjustment', eval(level_adjustment + 1))define(`char_languages', char_languages\komma Sylvan)define(`char_languages_bonus', Abyssal\komma Aquan\komma Auran\komma Celestial\komma Draconic\komma Dwarven\komma Elven\komma Giant\komma Gnome\komma Goblin\komma Gnoll\komma Halfling\komma Ignan\komma Infernal\komma Orc\komma Terran\komma Undercommon)')
