

dnl ***** abbreviations used:
dnl ***** PHB  = Player's Handbook
dnl ***** DMG  = Dungeon Master's Guide
dnl ***** MOM  = Monster Manual
dnl ***** MotW = Masters of the Wild



dnl the following marcos are expected to be defined:
dnl
dnl all class levels, STR, DEX, char_speed_base
dnl proficiencies_weapons, proficiencies_armor, proficiencies_shields
dnl bonus_attack_base, stat_size_attack_mod, stat_size, feat_weapon_finesse



dnl Does argument 1 include argument 2 ?
define(`test_include', `eval(regexp($1, `\<'$2`\>') >= 0)')dnl



dnl
dnl ***** Armor Proficiencies
dnl
dnl
dnl ***** armor: use only the names of the following list !!! other names will not be recognized
dnl
dnl padded leather leather_studded chain_shirt
dnl hide scale_mail chain_mail breastplate
dnl splint_mail banded_mail half_plate full_plate
dnl
dnl ***** added is this name, usable e.g. for bracers of armor, robes of armor
dnl none
dnl
define(`armor_class_light',  padded leather leather_studded chain_shirt)
define(`armor_class_medium', hide scale_mail chain_mail breastplate)
define(`armor_class_heavy',  splint_mail banded_mail half_plate full_plate)
dnl
define(`proficiencies_armor', proficiencies_armor none)
ifelse(eval(level_barbarian    > 0), 1, `define(`proficiencies_armor', proficiencies_armor armor_class_light armor_class_medium)')
ifelse(eval(level_bard         > 0), 1, `define(`proficiencies_armor', proficiencies_armor armor_class_light)')
ifelse(eval(level_cleric       > 0), 1, `define(`proficiencies_armor', proficiencies_armor armor_class_light armor_class_medium armor_class_heavy)')
ifelse(eval(level_druid        > 0), 1, `define(`proficiencies_armor', proficiencies_armor armor_class_light armor_class_medium)')
ifelse(eval(level_fighter      > 0), 1, `define(`proficiencies_armor', proficiencies_armor armor_class_light armor_class_medium armor_class_heavy)')
ifelse(eval(level_paladin      > 0), 1, `define(`proficiencies_armor', proficiencies_armor armor_class_light armor_class_medium armor_class_heavy)')
ifelse(eval(level_ranger       > 0), 1, `define(`proficiencies_armor', proficiencies_armor armor_class_light)')
ifelse(eval(level_rogue        > 0), 1, `define(`proficiencies_armor', proficiencies_armor armor_class_light)')
ifelse(eval(level_divineagent  > 0), 1, `define(`proficiencies_armor', proficiencies_armor armor_class_light armor_class_medium armor_class_heavy)')
ifelse(eval(level_templeraider > 0), 1, `define(`proficiencies_armor', proficiencies_armor armor_class_light armor_class_medium)')
dnl
define(`wear_armor_install', `dnl
define(`armor_type', ifelse($1,none,,test_include(armor_class_light, $1),1,light,test_include(armor_class_medium, $1),1,medium,test_include(armor_class_heavy, $1),1,heavy,`error(unknown armor: $1)'))
define(`armor_name',             $1)
define(`armor_AC_bonus',         eval($2 + ifelse($8,,0,$8)))
define(`armor_limit_max_DEX',    $3)
define(`armor_check_penalty',    ifelse($8,,$4,calc_min(0,eval($4 + 1))))dnl AC bonus zero is treated as masterwork item
define(`armor_limit_speed',      ifelse($6,,0,stat_race,dwarf,0,1))dnl dwarves are not encumbered by medium or heavy armor / load, all others face one step of speed reduction
define(`armor_limit_max_pace',   ifelse($7,,,3))
define(`armor_arcane_failure',   $5)')
dnl ***** following data taken from PHB, table 7-6, p.123
define(`wear_armor_none',            `wear_armor_install(none,            0, , 0, 0, , ,$1)')dnl special, see comment above
define(`wear_armor_padded',          `wear_armor_install(padded,          1,8, 0, 5, , ,$1)')
define(`wear_armor_leather',         `wear_armor_install(leather,         2,6, 0,10, , ,$1)')
define(`wear_armor_leather_studded', `wear_armor_install(leather_studded, 3,5,-1,15, , ,$1)')
define(`wear_armor_chain_shirt',     `wear_armor_install(chain_shirt,     4,4,-2,20, , ,$1)')
define(`wear_armor_hide',            `wear_armor_install(hide,            3,4,-3,20,1, ,$1)')
define(`wear_armor_scale_mail',      `wear_armor_install(scale_mail,      4,3,-4,25,1, ,$1)')
define(`wear_armor_chain_mail',      `wear_armor_install(chain_mail,      5,2,-5,30,1, ,$1)')
define(`wear_armor_breastplate',     `wear_armor_install(breastplate,     5,3,-4,25,1, ,$1)')
define(`wear_armor_splint_mail',     `wear_armor_install(splint_mail,     6,0,-7,40,1,1,$1)')
define(`wear_armor_banded_mail',     `wear_armor_install(banded_mail,     6,1,-6,35,1,1,$1)')
define(`wear_armor_half_plate',      `wear_armor_install(half_plate,      7,0,-7,40,1,1,$1)')
define(`wear_armor_full_plate',      `wear_armor_install(full_plate,      8,1,-6,35,1,1,$1)')
dnl ***** activate armor ...
dnl ***** first initialize, in case no armor is worn at all ...
define(`armor_name',              )
define(`armor_type',              )
define(`armor_AC_bonus',         0)
define(`armor_limit_max_DEX',     )
define(`armor_check_penalty',    0)
define(`armor_limit_speed',       )
define(`armor_limit_max_pace',    )
define(`armor_arcane_failure',   0)
char_armor
define(`bonus_attack_mod_armor', ifelse(test_include(proficiencies_armor, armor_name),1,0,armor_check_penalty))


dnl
dnl ***** Shield Proficiencies
dnl
dnl
dnl ***** shields: use only the names of the following list !!! other names will not be recognized
dnl
dnl buckler light_wooden light_steel heavy_wooden heavy_steel tower
dnl
dnl ***** added is this name, usable e.g. for Ring of Force Shield
dnl none
dnl
define(`shield_class_normal', buckler light_wooden light_steel heavy_wooden heavy_steel)
define(`shield_class_tower',  tower)
dnl
ifelse(eval(level_barbarian > 0), 1, `define(`proficiencies_shields', proficiencies_shields shield_class_normal)')
ifelse(eval(level_bard      > 0), 1, `define(`proficiencies_shields', proficiencies_shields shield_class_normal)')
ifelse(eval(level_cleric    > 0), 1, `define(`proficiencies_shields', proficiencies_shields shield_class_normal)')
ifelse(eval(level_druid     > 0), 1, `define(`proficiencies_shields', proficiencies_shields shield_class_normal)')
ifelse(eval(level_fighter   > 0), 1, `define(`proficiencies_shields', proficiencies_shields shield_class_normal shield_class_tower)')
ifelse(eval(level_paladin   > 0), 1, `define(`proficiencies_shields', proficiencies_shields shield_class_normal)')
ifelse(eval(level_ranger    > 0), 1, `define(`proficiencies_shields', proficiencies_shields shield_class_normal)')
dnl
define(`wear_shield_install', `dnl arguments: name, AC-bonus, max AC-DEX, Check Penalty, Arcane Spell Failure, Speed Limit, Max Pace, additional AC-Bonus
define(`shield_type', ifelse($1,none,,test_include(shield_class_normal, $1),1,normal,test_include(shield_class_tower, $1),1,tower,`error(unknown shield: $1)'))
define(`shield_name',             $1)
define(`shield_AC_bonus',         eval($2 + ifelse($8,,0,$8)))
define(`shield_limit_max_DEX',    $3)
define(`shield_check_penalty',    ifelse($8,,$4,calc_min(0,eval($4 + 1))))dnl AC bonus zero is treated as masterwork item
define(`shield_limit_speed',      0)dnl shields do not reduce speed, cf. PHB, p.122
define(`shield_limit_max_pace',   ifelse($7,,,3))
define(`shield_arcane_failure',   $5)')
dnl ***** following data taken from PHB, table 7-6, p.123
define(`wear_shield_none',            `wear_shield_install(none,            0, ,  0, 0, , ,$1)')dnl special, see comment above
define(`wear_shield_buckler',         `wear_shield_install(buckler,         1, , -1, 5, , ,$1)')
define(`wear_shield_light_wooden',    `wear_shield_install(light_wooden,    1, , -1, 5, , ,$1)')
define(`wear_shield_light_steel',     `wear_shield_install(light_steel,     1, , -1, 5, , ,$1)')
define(`wear_shield_heavy_wooden',    `wear_shield_install(heavy_wooden,    2, , -2,15, , ,$1)')
define(`wear_shield_heavy_steel',     `wear_shield_install(heavy_steel,     2, , -2,15, , ,$1)')
define(`wear_shield_tower',           `wear_shield_install(tower,           4,2,-10,50, , ,$1)')
define(`wear_shield_darkwoodbuckler', `wear_shield_install(buckler,         1, ,  0, 5, , , 0)')
define(`wear_shield_darkwoodshield',  `wear_shield_install(heavy_wooden,    2, ,  0,15, , , 0)')
dnl ***** activate shield ...
dnl ***** first initialize, in case no shield is worn at all ...
define(`shield_name',              )
define(`shield_type',              )
define(`shield_AC_bonus',         0)
define(`shield_limit_max_DEX',     )
define(`shield_check_penalty',    0)
define(`shield_limit_speed',       )
define(`shield_limit_max_pace',    )
define(`shield_arcane_failure',   0)
dnl ***** now apply the shield of the character's choice ...
char_shield
dnl ***** done
define(`bonus_attack_mod_shield', ifelse(test_include(proficiencies_shields, shield_name),1,0,shield_check_penalty))



dnl
dnl ***** Weapon Proficiencies
dnl
dnl
dnl ***** weapons: use only the names of the following list !!! other names will not be recognized
dnl
dnl gauntlet unarmed_strike dagger dagger_punching gauntlet_spiked mace_light sickle club mace_heavy morningstar shortspear
dnl longspear quarterstaff spear crossbow_heavy crossbow_light dart javelin sling axe_throwing hammer_light handaxe kukri
dnl pick_light sap shield_light spiked_armor spiked_shield_light shortsword battleaxe flail longsword pick_heavy rapier
dnl scimitar shield_heavy spiked_shield_heavy trident warhammer falchion glaive greataxe greatclub flail_heavy greatsword
dnl guisarme halberd lance ranseur scythe longbow longbow_composite shortbow shortbow_composite kama nunchaku sai siangham
dnl sword_bastard waraxe_dwarfen whip axe_orc_double chain_spiked flail_dire hammer_gnome_hooked sword_twobladed urgrosh_dwarfen
dnl bola crossbow_hand crossbow_repeating_heavy crossbow_repeating_light net shuriken
dnl
dnl ray
dnl bite claw_talon gore slam_slap sting tail tentacle
dnl

dnl ***** simple weapons according to PHB, p.116f., table 7-5
define(`weapon_class_simple', gauntlet unarmed_strike dagger dagger_punching gauntlet_spiked mace_light sickle club mace_heavy morningstar shortspear longspear quarterstaff spear crossbow_heavy crossbow_light dart javelin sling)

dnl ***** martial weapons according to PHB, p.116f., table 7-5
define(`weapon_class_martial', axe_throwing hammer_light handaxe kukri pick_light sap shield_light spiked_armor spiked_shield_light shortsword battleaxe flail longsword pick_heavy rapier scimitar shield_heavy spiked_shield_heavy trident warhammer falchion glaive greataxe greatclub flail_heavy greatsword guisarme halberd lance ranseur scythe longbow longbow_composite shortbow shortbow_composite)

dnl ***** exotic weapons according to PHB, p.116f., table 7-5
define(`weapon_class_exotic', kama nunchaku sai siangham sword_bastard waraxe_dwarfen whip axe_orc_double chain_spiked flail_dire hammer_gnome_hooked sword_twobladed urgrosh_dwarfen bola crossbow_hand crossbow_repeating_heavy crossbow_repeating_light net shuriken)

dnl ***** unarmed attacks according to PHB, p.116f., table 7-5
define(`weapon_class_unarmed', gauntlet unarmed_strike)

dnl ***** melee weapons according to PHB, p.116f., table 7-5
define(`weapon_class_melee', dagger dagger_punching gauntlet_spiked mace_light sickle club mace_heavy morningstar shortspear longspear quarterstaff spear axe_throwing hammer_light handaxe kukri pick_light sap shield_light spiked_armor spiked_shield_light shortsword battleaxe flail longsword pick_heavy rapier scimitar shield_heavy spiked_shield_heavy trident warhammer falchion glaive greataxe greatclub flail_heavy greatsword guisarme halberd lance ranseur scythe kama nunchaku sai siangham sword_bastard waraxe_dwarfen whip axe_orc_double chain_spiked flail_dire hammer_gnome_hooked sword_twobladed urgrosh_dwarfen)

dnl ***** non-lethal weapons: deal only non lethal damage
dnl according to PHB, p.116f., table 7-5, footnote 3
define(`weapon_class_nonlethal', ifdef(`feat_improved_unarmed_strike',,unarmed_strike) sap whip bola)

dnl ***** the most common, cf. MOM I., p.312
define(`weapon_class_natural', bite claw_talon gore slam_slap sting tail tentacle)

dnl ***** reach weapons: cannot strike adjacent foe
dnl according to PHB, p.116f., table 7-5, footnote 4
dnl and PHB, p.112f.
define(`weapon_class_reach', glaive guisarme lance longspear ranseur chain_spiked whip)

dnl ***** double weapons: both ends of the weapon can be used for striking
dnl according to PHB, p.116f., table 7-5, footnote 5
dnl and PHB, p.113
define(`weapon_class_double', flail_dire urgrosh_dwarfen hammer_gnome_hooked axe_orc_double quarterstaff sword_twobladed)

dnl ***** throwable weapons
dnl according to PHB, p.116f., table 7-5, weapons with range increment
dnl and PHB, p.113
define(`weapon_class_thrown', dagger club shortspear spear dart javelin axe_throwing hammer_light trident shuriken net bola)dnl sai ???

dnl ***** projectile weapons
dnl according to PHB, p.116f., table 7-5, weapons with range increment
dnl and PHB, p.113
define(`weapon_class_projectile', sling shortbow shortbow_composite longbow longbow_composite crossbow_light crossbow_heavy crossbow_hand crossbow_repeating_light crossbow_repeating_heavy)

dnl ***** ranged weapons: cannot be used in melee
dnl according to PHB, p.116f., table 7-5
define(`weapon_class_ranged', weapon_class_projectile dart javelin bola net shuriken)

dnl ***** light weapons according to PHB, p.116f., table 7-5
dnl unarmed strike counts as light weapon
dnl   according to PHB, p.139, section "unarmed strike damage"
dnl   and PHB, p.113, section "light weapons"
define(`weapon_class_light', unarmed_strike dagger dagger_punching gauntlet_spiked mace_light sickle axe_throwing hammer_light handaxe kukri pick_light sap shield_light spiked_armor spiked_shield_light shortsword kama nunchaku sai siangham)

dnl ***** one-handed weapons according to PHB, p.116f., table 7-5
define(`weapon_class_1hd', club mace_heavy morningstar shortspear battleaxe flail longsword pick_heavy rapier scimitar shield_heavy spiked_shield_heavy trident warhammer sword_bastard waraxe_dwarfen whip)

dnl ***** two-handed weapons according to PHB, p.116f., table 7-5
define(`weapon_class_2hd', longspear quarterstaff spear falchion glaive greataxe greatclub flail_heavy greatsword guisarme halberd lance ranseur scythe axe_orc_double chain_spiked flail_dire hammer_gnome_hooked sword_twobladed urgrosh_dwarfen)


dnl ***** add the standard weapon proficiencies of the classes
ifelse(eval(level_barbarian    > 0), 1, `define(`proficiencies_weapons', proficiencies_weapons weapon_class_simple weapon_class_martial)')
ifelse(eval(level_bard         > 0), 1, `define(`proficiencies_weapons', proficiencies_weapons weapon_class_simple longsword rapier sap shortsword shortbow whip)')
ifelse(eval(level_cleric       > 0), 1, `define(`proficiencies_weapons', proficiencies_weapons weapon_class_simple)')
ifelse(eval(level_druid        > 0), 1, `define(`proficiencies_weapons', proficiencies_weapons club dagger dart quarterstaff scimitar sickle shortspear sling spear)')
ifelse(eval(level_fighter      > 0), 1, `define(`proficiencies_weapons', proficiencies_weapons weapon_class_simple weapon_class_martial)')
ifelse(eval(level_monk         > 0), 1, `define(`proficiencies_weapons', proficiencies_weapons unarmed_strike club crossbow_heavy crossbow_light dagger handaxe javelin kama nunchaku quarterstaff sai shuriken siangham sling)')
ifelse(eval(level_paladin      > 0), 1, `define(`proficiencies_weapons', proficiencies_weapons weapon_class_simple weapon_class_martial)')
ifelse(eval(level_ranger       > 0), 1, `define(`proficiencies_weapons', proficiencies_weapons weapon_class_simple weapon_class_martial)')
ifelse(eval(level_rogue        > 0), 1, `define(`proficiencies_weapons', proficiencies_weapons weapon_class_simple crossbow_hand rapier shortbow shortsword)')
ifelse(eval(level_sorcerer     > 0), 1, `define(`proficiencies_weapons', proficiencies_weapons weapon_class_simple)')
ifelse(eval(level_wizard       > 0), 1, `define(`proficiencies_weapons', proficiencies_weapons club dagger crossbow_heavy crossbow_light quarterstaff)')
ifelse(eval(level_divineagent  > 0), 1, `define(`proficiencies_weapons', proficiencies_weapons weapon_class_simple)')
ifelse(eval(level_shadowcaster > 0), 1, `define(`proficiencies_weapons', proficiencies_weapons weapon_class_simple)')
ifelse(eval(level_templeraider > 0), 1, `define(`proficiencies_weapons', proficiencies_weapons weapon_class_simple rapier)')
dnl no proficiencies gained for classes: shifter, horizonwalker


dnl yield the base damage of a given weapon of medium size, the crit range, the crit multiplier, the range increment and the damage type
dnl arguments: weapon name
dnl see PHB, p.116f.
define(`get_weapon_info1', `ifelse(dnl
$1, gauntlet,                 1D3  20 2   -   B Gauntlet, dnl
$1, unarmed_strike,           ifelse(eval(level_monk <= 0),1,1D3,eval(level_monk <= 3),1,1D6,eval(level_monk <= 7),1,1D8,eval(level_monk <= 11),1,1D10,eval(level_monk <= 15),1,2D6,eval(level_monk <= 19),1,2D8,2D10)  20 2   -   B Unarmed Strike, dnl
$1, dagger,                   1D4  19 2  10 P/S Dagger, dnl
$1, dagger_punching,          1D4  20 3   -   P Punching Dagger, dnl
$1, gauntlet_spiked,          1D4  20 2   -   P Spiked Gauntlet, dnl
$1, mace_light,               1D6  20 2   -   B Light Mace, dnl
$1, sickle,                   1D6  20 2   -   S Sickle, dnl
$1, club,                     1D6  20 2  10   B Club, dnl
$1, mace_heavy,               1D8  20 2   -   B Heavy Mace, dnl
$1, morningstar,              1D8  20 2   - B/P Morningstar, dnl
$1, shortspear,               1D6  20 2  20   P Shortspear, dnl
$1, longspear,                1D8  20 3   -   P Longspear, dnl
$1, quarterstaff,             1D6  20 2   -   B Quarterstaff, dnl
$1, spear,                    1D8  20 3  20   P Spear, dnl
$1, crossbow_heavy,           1D10 19 2 120   P Heavy Crossbow, dnl
$1, crossbow_light,           1D8  19 2  80   P Light Crossbow, dnl
$1, dart,                     1D4  20 2  20   P Dart, dnl
$1, javelin,                  1D6  20 2  30   P Javelin, dnl
$1, sling,                    1D4  20 2  50   B Sling, dnl
$1, axe_throwing,             1D6  20 2  10   S Throwing Axe, dnl
$1, hammer_light,             1D4  20 2  20   B Light Hammer, dnl
$1, handaxe,                  1D6  20 3   -   S Handaxe, dnl
$1, kukri,                    1D4  18 2   -   S Kukri, dnl
$1, pick_light,               1D4  20 4   -   P Light Pick, dnl
$1, sap,                      1D6  20 2   -   B Sap, dnl
$1, shortsword,               1D6  19 2   -   P Shortsword, dnl
$1, battleaxe,                1D8  20 3   -   S Battleaxe, dnl
$1, flail,                    1D8  20 2   -   B Flail, dnl
$1, longsword,                1D8  19 2   -   S Longsword, dnl
$1, pick_heavy,               1D6  20 4   -   P Heavy Pick, dnl
$1, rapier,                   1D6  18 2   -   P Rapier, dnl
$1, scimitar,                 1D6  18 2   -   S Scimitar, dnl
$1, trident,                  1D8  20 2  10   P Trident, dnl
$1, warhammer,                1D8  20 3   -   B Warhammer, dnl
$1, falchion,                 2D4  18 2   -   S Falcion, dnl
$1, glaive,                   1D10 20 3   -   S Glaive, dnl
$1, greataxe,                 1D12 20 3   -   S Greataxe, dnl
$1, greatclub,                1D10 20 2   -   B Greatclub, dnl
$1, flail_heavy,              1D10 19 2   -   B Heavy Flail, dnl
$1, greatsword,               2D6  19 2   -   S Greatsword, dnl
$1, guisarme,                 2D4  20 3   -   S Guisarme, dnl
$1, halberd,                  1D10 20 3   - P/S Halberd, dnl
$1, lance,                    1D8  20 3   -   P Lance, dnl
$1, ranseur,                  2D4  20 3   -   P Ranseur, dnl
$1, scythe,                   2D4  20 4   - P/S Scythe, dnl
$1, longbow,                  1D8  20 3 100   P Longbow, dnl
$1, longbow_composite,        1D8  20 3 110   P Composite Longbow, dnl
$1, shortbow,                 1D6  20 3  60   P Shortbow, dnl
$1, shortbow_composite,       1D6  20 3  70   P Composite Shortbow, dnl
$1, kama,                     1D6  20 2   -   S Kama, dnl
$1, nunchaku,                 1D6  20 2   -   B Nunchaku, dnl
$1, sai,                      1D4  20 2  10   B Sai, dnl
$1, siangham,                 1D6  20 2   -   P Siangham, dnl
$1, sword_bastard,            1D10 19 2   -   S Bastardsword, dnl
$1, waraxe_dwarfen,           1D10 20 3   -   S Dwarfen Waraxe, dnl
$1, whip,                     1D3  20 2   -   S Whip, dnl
$1, axe_orc_double,           1D8  20 3   -   S Orc Double Axe, dnl
$1, chain_spiked,             2D4  20 2   -   P Spiked Chain, dnl
$1, flail_dire,               1D8  20 2   -   B Dire Flail, dnl
$1, hammer_gnome_hooked,      1D8  20 3   - B/P Gnome Hooked Hammer, dnl
$1, sword_twobladed,          1D8  19 2   -   S Twobladed Sword, dnl
$1, urgrosh_dwarfen,          1D8  20 3   - S/P Dwarfen Urgosh, dnl
$1, bola,                     1D4  20 2  10   B Bola, dnl
$1, crossbow_hand,            1D4  19 2  30   P Hand Crossbow, dnl
$1, crossbow_repeating_heavy, 1D10 19 2 120   P Heavy Repeating Crossbow, dnl
$1, crossbow_repeating_light, 1D8  19 2  80   P Light Repeating Crossbow, dnl
$1, net,                      -    20 -  10   - Net, dnl
$1, shuriken,                 1D2  20 2  10   P Shuriken, dnl
$1, bite,                     1D6  20 2   - P/S/B Bite, dnl
$1, claw_talon,               1D4  20 2   - P/S Claw, dnl
$1, gore,                     1D6  20 2   -   P Gore, dnl
$1, slam_slap,                1D4  20 2   -   B Slam, dnl
$1, sting,                    1D4  20 2   -   P Sting, dnl
$1, tail,                     1D6  20 2   -   B Tail Slap, dnl
$1, tentacle,                 1D4  20 2   -   B Tentacle, dnl
`error(unknown weapon name <$1> in macro <get_weapon_info1>)')')dnl

dnl to do: Morningstar and Gnome Hooked Hammer deal B *and* P damage, not B *or* P

dnl second attack for double weapons
define(`get_weapon_info2', `ifelse(dnl
$1, quarterstaff,             1D6  20 2   -   B Quarterstaff, dnl
$1, axe_orc_double,           1D8  20 3   -   S Orc Double Axe, dnl
$1, flail_dire,               1D8  20 2   -   B Dire Flail, dnl
$1, hammer_gnome_hooked,      1D6  20 4   - B/P Gnome Hooked Hammer, dnl
$1, sword_twobladed,          1D8  19 2   -   S Twobladed Sword, dnl
$1, urgrosh_dwarfen,          1D6  20 3   - S/P Dwarfen Urgosh, dnl
`error(unknown weapon name <$1> in macro <get_weapon_info2>)')')dnl


dnl set the regular expression that reads the above infomation
dnl result expressions:
dnl   1: damage dice
dnl   2: critical range
dnl   3: critical multiplier
dnl   4: range increment
dnl   5: damage type
dnl   6: weapon name (human readable)
define(`get_weapon_info_regexp', `^\([0-9]D[0-9]+\|-\) +\([0-9][0-9]\) +\([0-9]\|-\) +\([0-9]+\|-\) +\([BPS][/&]?[BPS]?[/&]?[BPS]?\|-\) +\(.+\)$')


dnl translate the given base damage of medium size to that of a given size
dnl arguments: medium size damage, size (possible values (downcase !): fine, deminutive, tiny, small, medium, large, huge, gargantuan, colossal)
dnl see: PHB p.114, p.116f, p.40f (Tables 3-10 and 3-11), 278 (description of Shillelagh-spell for club or quarterstaff)
dnl      MOM I p.291 (Table 4-3), p.304 (description of feat "Improved Natural Attack")
dnl      DMG p.28 (effect of weapon size, Tables 2-2 and 2-3)
define(`translate_damage_by_size', `ifelse(dnl
$2,   colossal,`increase_damage_by_size(increase_damage_by_size(increase_damage_by_size(increase_damage_by_size($1))))', dnl
$2, gargantuan,`increase_damage_by_size(increase_damage_by_size(increase_damage_by_size($1)))', dnl
$2,       huge,`increase_damage_by_size(increase_damage_by_size($1))', dnl
$2,      large,`increase_damage_by_size($1)', dnl
$2,     medium,$1, dnl
$2,      small,`decrease_damage_by_size($1)', dnl
$2,       tiny,`decrease_damage_by_size(decrease_damage_by_size($1))', dnl
$2, deminutive,`decrease_damage_by_size(decrease_damage_by_size(decrease_damage_by_size($1)))', dnl
$2,       fine,`decrease_damage_by_size(decrease_damage_by_size(decrease_damage_by_size(decrease_damage_by_size($1))))', dnl
`error(unknown size type <$2> in macro <translate_damage_by_size>)')')


dnl increase the given damage by one step
define(`increase_damage_by_size', `ifelse(dnl DMG p.28, Table 2-2
$1, 1D2, 1D3, dnl
$1, 1D3, 1D4, dnl
$1, 1D4, 1D6, dnl
$1, 1D6, 1D8, dnl
$1, 1D8, 2D6, dnl
$1, 2D6, 3D6, dnl
$1, 3D6, 4D6, dnl
$1, 4D6, 6D6, dnl
$1, 6D6, 8D6, dnl
$1, 8D6,12D6, dnl
$1,1D10, 2D8, dnl
$1, 2D4, 2D6, dnl
$1, 2D8, 3D8, dnl
$1, 3D8, 4D8, dnl
$1, 4D8, 6D8, dnl
$1, 6D8, 8D8, dnl
$1, 8D8,12D8, dnl
$1,1D12, 3D6, dnl
$1,2D10, 4D8, dnl
`error(unknown damage <$1> in macro <increase_damage_by_size>)')')%


dnl decrease the given damage by one step
define(`decrease_damage_by_size', `ifelse(dnl DMG p.28, Table 2-3
$1,2D10, 2D8, dnl
$1, 2D8, 2D6, dnl
$1, 2D6,1D10, dnl
$1, 2D4, 1D6, dnl
$1,1D12,1D10, dnl
$1,1D10, 1D8, dnl
$1, 1D8, 1D6, dnl
$1, 1D6, 1D4, dnl
$1, 1D4, 1D3, dnl
$1, 1D3, 1D2, dnl
$1, 1D2,   1, dnl
$1,   1,   0, dnl
`error(unknown damage <$1> in macro <decrease_damage_by_size>)')')


define(`bonus_attack_base_mod', eval(bonus_attack_base_mod + dnl
stat_size_attack_mod(stat_size) + dnl
bonus_attack_mod_armor + dnl
bonus_attack_mod_shield + dnl
ifelse(test_include(shield_class_tower, shield_name),1,-2,0) + dnl tower shield modifier according to PHB, p.125
ifdef(`feat_epic_prowess',feat_epic_prowess,0)))dnl


dnl sum up attack boni concerning an attack type, no matter the kind of usage (melee, ranged, etc.)
define(`bonus_attack_weapon_mod', `eval(dnl
ifelse(test_include(proficiencies_weapons,$1),1,0,-4) + dnl
ifdef(`feat_weapon_focus',        `ifelse(test_include(feat_weapon_focus,        $1),1,1,0)',0) + dnl
ifdef(`feat_greater_weapon_focus',`ifelse(test_include(feat_greater_weapon_focus,$1),1,1,0)',0) + dnl
ifdef(`feat_epic_weapon_focus',   `ifelse(test_include(feat_epic_weapon_focus,   $1),1,2,0)',0))')dnl


dnl sum up damage boni concerning an attack type, no matter the kind of usage (melee, ranged, etc.)
define(`bonus_damage_weapon_mod', `eval(dnl
ifdef(`feat_weapon_specialization',        `ifelse(test_include(feat_weapon_specialization,        $1),1,2,0)',0) + dnl
ifdef(`feat_greater_weapon_specialization',`ifelse(test_include(feat_greater_weapon_specialization,$1),1,2,0)',0) + dnl
ifdef(`feat_epic_weapon_specialization',   `ifelse(test_include(feat_epic_weapon_specialization,   $1),1,4,0)',0))')dnl


dnl arguments: weapon name, attack bonus, damage bonus, weapon size, specially built composite bow strength bonus, ammunition, flag, comment, damage dice
dnl
dnl flag argument: string of `o' (show off-hand info for 1h-weapons), `2' (show two-hand info for 1h-weapons), `2' (show secondary natural weapon)
dnl
define(`calc_weapon', `dnl
define(`calc_weapon_specab', translit($8,`A-Z',`a-z'))dnl
\begin{boxedminipage}[t]{\linewidth}
\underline{regexp(get_weapon_info1($1), get_weapon_info_regexp, \\textbf{\6})}: ifelse(regexp(calc_weapon_specab,`\<keen\>'),-1,calc_weapon_specab,regexp(calc_weapon_specab, `^\(.*\)keen\(.*\)$', `\1\2')) %
dnl
dnl ***** melee usage
dnl apply STR to attack roll, except for some weapons with the feat "Weapon Finesse", these use DEX (and apply the check penalty of a shield, PHB, p.102)
dnl apply STR or 150% of STR to damage, if weapon wielded one- or two-handed
ifelse(test_include(weapon_class_melee weapon_class_unarmed weapon_class_natural,$1),1,dnl
`\\  melee (ifelse(test_include(weapon_class_2hd, $1),1,2,1)h): dnl
     emph_sign(eval($2 + bonus_attack_weapon_mod($1) + dnl
			   ifelse(eval(test_include(weapon_class_natural, $1)  &&  ifelse($7,2,1,0)),1,ifdef(`feat_multiattack',-2,-5),0) + dnl
                           ifelse(eval(test_include(weapon_class_light rapier whip chain_spiked, $1)  &&  dnl
                                       ifdef(`feat_weapon_finesse',1,0)),1,calc_max(eval(DEX + shield_check_penalty),STR),STR)))dnl attack bonus
     regexp(get_weapon_info1($1), get_weapon_info_regexp, `dnl
     ifelse(\1,-,(0),dnl
     (translate_damage_by_size(ifelse($9,,\1,$9),$4)`'dnl
`'`'`'emph_sign(eval($3 + dnl
                     bonus_damage_weapon_mod($1) + dnl
                     ifelse(test_include(weapon_class_2hd,$1),1,eval((STR * 3) / 2),STR)),1)) dnl accumulated damage modifiers
                     \\hspace*{0.5ex}\5\\hspace*{0.5ex})dnl damage type
     ifelse(test_include(calc_weapon_specab, keen),1,eval(21 - 2*(21 - \2)),\2)/ifelse(\3,-,--,${}\\times${}\3) dnl critical
     ifelse(test_include(weapon_class_unarmed, $1),1,ifelse(eval(level_monk > 0),1,,ifdef(`feat_improved_unarmed_strike',1,0),1,,non-lethal damage))`'dnl
     ifelse(test_include(weapon_class_reach, $1),1,reach weapon)') % '
)dnl
dnl a one-handed martial can also be wielded in the off hand
ifelse(eval(test_include(weapon_class_melee weapon_class_unarmed,$1) && dnl
            test_include(weapon_class_light weapon_class_1hd,$1) && dnl
            (regexp($7,o) >= 0)),1,dnl
`\\  melee (1h-off): dnl
     emph_sign(eval($2 + bonus_attack_weapon_mod($1) + dnl
                           ifelse(eval(test_include(weapon_class_light rapier whip chain_spiked, $1)  &&  dnl
                                       ifdef(`feat_weapon_finesse',1,0)),1,calc_max(eval(DEX + shield_check_penalty),STR),STR)))dnl attack bonus
     regexp(get_weapon_info1($1), get_weapon_info_regexp, `dnl
     ifelse(\1,-,(0),dnl
     (translate_damage_by_size(\1,$4)`'dnl
`'`'`'emph_sign(eval($3 + dnl
                     bonus_damage_weapon_mod($1) + dnl
                     eval(STR / 2)),1)) dnl accumulated damage modifiers, only half STR, cf. PHB p.134
                     \\hspace*{0.5ex}\5\\hspace*{0.5ex})dnl damage type
     ifelse(test_include(calc_weapon_specab, keen),1,eval(21 - 2*(21 - \2)),\2)/ifelse(\3,-,--,${}\\times${}\3) dnl critical
     ifelse(test_include(weapon_class_unarmed, $1),1,ifelse(eval(level_monk > 0),1,,ifdef(`feat_improved_unarmed_strike',1,0),1,,non-lethal damage))`'dnl
     ifelse(test_include(weapon_class_reach, $1),1,reach weapon)`'dnl
     ifelse(test_include(weapon_class_light, $1),1,light weapon)') % '
)dnl
dnl a one-handed martial can also be wielded two-handed
ifelse(eval(test_include(weapon_class_melee weapon_class_unarmed,$1) && dnl
            test_include(weapon_class_1hd,$1) && dnl
            (regexp($7,2) >= 0)),1,dnl
`\\  melee (2h): dnl
     emph_sign(eval($2 + bonus_attack_weapon_mod($1) + dnl
                           ifelse(eval(test_include(weapon_class_light rapier whip chain_spiked, $1)  &&  dnl
                                       ifdef(`feat_weapon_finesse',1,0)),1,calc_max(eval(DEX + shield_check_penalty),STR),STR)))dnl attack bonus
     regexp(get_weapon_info1($1), get_weapon_info_regexp, `dnl
     ifelse(\1,-,(0),dnl
     (translate_damage_by_size(\1,$4)`'dnl
`'`'`'emph_sign(eval($3 + dnl
                     bonus_damage_weapon_mod($1) + dnl
                     eval((STR * 3) / 2)),1)) dnl accumulated damage modifiers
                     \\hspace*{0.5ex}\5\\hspace*{0.5ex})dnl damage type
     ifelse(test_include(calc_weapon_specab, keen),1,eval(21 - 2*(21 - \2)),\2)/ifelse(\3,-,--,${}\\times${}\3) dnl critical
     ifelse(test_include(weapon_class_unarmed, $1),1,ifelse(eval(level_monk > 0),1,,ifdef(`feat_improved_unarmed_strike',1,0),1,,non-lethal damage))`'dnl
     ifelse(test_include(weapon_class_reach, $1),1,reach weapon)') % '
)dnl ***** end of melee usage
dnl
dnl ***** thrown usage
dnl apply DEX to attack roll
dnl apply STR to damage (PHB, p.113)
dnl maximum throw range is five times the range increment of the weapon, PHB p.134
dnl Far Shot Feat doubles range increment, PHB, p.94
dnl throwing non-throw-weapons not implemented yet, see PHB, p.113
ifelse(test_include(weapon_class_thrown,$1),1,dnl
`\\  ranged: emph_sign(eval(DEX + $2 + bonus_attack_weapon_mod($1))) dnl attack bonus
     regexp(get_weapon_info1($1), get_weapon_info_regexp, `dnl
     ifelse(\1,-,(0),(translate_damage_by_size(\1,$4)`'dnl
`'`'`'emph_sign(eval($3 + dnl
                     bonus_damage_weapon_mod($1) + dnl
                     STR),1)) dnl accumulated damage modifiers
                     \\hspace*{0.5ex}\5\\hspace*{0.5ex})dnl damage type
     ifelse(test_include(calc_weapon_specab, keen),1,eval(21 - 2*(21 - \2)),\2)/ifelse(\3,-,--,${}\\times${}\3) dnl critical
     [eval(\4 * ifdef(`feat_far_shot',2,1))`'\\aps{}/`'eval(\4 * ifdef(`feat_far_shot',2,1) * 5)`'\\aps]') % '
)dnl ***** end of thrown usage
dnl
dnl ***** projectile usage
dnl apply DEX to attack roll
dnl apply STR (bonus and malus) to sling (PHB, p.113,121,134), STR malus to all bows, STR bonus only to specially built composite bows
dnl Far Shot Feat increases range increment by 50%, PHB, p.94
ifelse(test_include(weapon_class_projectile,$1),1,dnl
`\\  ranged: emph_sign(eval(DEX + $2 + bonus_attack_weapon_mod($1))) dnl attack bonus
     regexp(get_weapon_info1($1), get_weapon_info_regexp, `dnl
     ifelse(\1,-,(0),dnl
     (translate_damage_by_size(\1,$4)`'emph_sign(eval(dnl start calculation of damage modifier
         $3 + dnl first weapon bonus
         bonus_damage_weapon_mod($1) + dnl some overall modifiers
         ifelse($1,sling,STR,0) + dnl sling always gets STR-bonus (positive or negative, see comment above)
         ifelse(test_include(shortbow shortbow_composite longbow longbow_composite, $1),0,0,dnl bows get STR-malus, sometimes limited STR-bonus
                ifelse(eval(STR <= 0),1,STR,$5,,0,test_include(shortbow_composite longbow_composite, $1),0,0,`eval(STR < $5)',1,STR,$5))dnl
     ),1)) dnl accumulated damage modifiers
     \\hspace*{0.5ex}\5\\hspace*{0.5ex})dnl damage type
     ifelse(test_include(calc_weapon_specab, keen),1,eval(21 - 2*(21 - \2)),\2)/ifelse(\3,-,--,${}\\times${}\3) dnl critical
     [ifdef(`feat_far_shot',eval(\4 * 3 / 2),\4)`'\\aps{}/`'eval(ifdef(`feat_far_shot',eval(\4 * 3 / 2),\4) * 10)`'\\aps]') dnl
     ammo: $6 % '
)dnl ***** end of projectile usage
\end{boxedminipage}
')


dnl calculate the base damage of a given weapon of a given size
dnl arguments: weapon name, size (possible values (downcase !): medium, small, tiny, large)
dnl see PHB p.114,116f.
define(`calc_damage_base', `ifelse(dnl
get_damage_medium($1),--,--,dnl
regexp(get_damage_medium($1),`/'),-1,dnl
calc_damage_size(get_damage_medium($1),$2),dnl
regexp(get_damage_medium($1),`^\(.*\)/\(.*\)$',`calc_damage_size(\1,$2)`/'calc_damage_size(\2,$2)'))')


dnl calculate the additional damage of a given weapon due to type, strength or whatever
dnl arguments: weapon_name, weapon damage modifier, specially built composite bow STR-bonus
dnl off-hand-usage (only STR / 2 rounded down) of melee weapons not implemented yet, see PHB, p.134, DAMAGE-section
define(`calc_damage_mod', `eval($2 + ifelse(dnl
test_include(shortbow shortbow_composite longbow longbow_composite sling, $1),1,ifelse(eval(STR < 0),1,STR,$3,,0,`eval(STR < $3)',1,STR,$3),dnl
test_include(weapon_class_melee, $1),1,STR,0) + dnl
ifelse(test_include(weapon_class_2hd, $1),1,eval(STR / 2),0)dnl round down, PHB, p.134, DAMAGE-section, see example on Krusk
)')
dnl PHB, p.134 says: for sling add STR bonus
dnl PHB, p.121 sling section says the same
dnl PHB, p.113 section for projectile weapons says: add STR malus to bows and sling, add STR bonus only for slings and specially built composite bows


dnl arguments: weapon name, weapon attack modifier
define(`calc_OB', `eval(stat_size_attack_mod(stat_size) + $2 + bonus_attack_mod_armor + bonus_attack_mod_shield + dnl
ifelse(test_include(shield_class_tower, shield_name),1,-2,0) + dnl PHB, p.125
ifelse(test_include(proficiencies_weapons,   $1),1,0,-4) + dnl
ifelse(test_include(weapon_class_projectile, $1),1,DEX,dnl
ifelse(eval(test_include(weapon_class_light rapier whip chain_spiked, $1)  &&  ifdef(`feat_weapon_finesse',1,0)),1,calc_max(eval(DEX + shield_check_penalty),STR),STR)))')

