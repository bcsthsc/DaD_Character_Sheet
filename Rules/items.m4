

dnl ***** abbreviations used:
dnl ***** PHB  = Player's Handbook
dnl ***** DMG  = Dungeon Master's Guide
dnl ***** MOM  = Monster Manual
dnl ***** MotW = Masters of the Wild



dnl
dnl weight calculations will be done on the basis of 1/100 g
dnl other weight units will be translated automatically
dnl
dnl just remember:
dnl
dnl  1 lb    = 453.6  g
dnl  1 oz    =  28.35 g
dnl  1 carat =   0.20 g
dnl
dnl that means: 1 lb = 16 oz
dnl
dnl the following unit codes are recognized and translated (downcase !) (cr = abbreviation for carat):
dnl   kg, g, lbs, oz, cr
dnl

dnl
dnl ***** state the weight of different objects
dnl

dnl ***** coins, PHB, p.112
define(`item_weight_coin_platinum',               9  g)dnl
define(`item_weight_coin_gold',                   9  g)dnl
define(`item_weight_coin_silver',                 9  g)dnl
define(`item_weight_coin_copper',                 9  g)dnl
define(`item_weight_gem',                        50 cr)dnl

dnl ***** weapons, PHB, p.116f.
define(`item_weight_gauntlet',                  1 lbs)dnl
define(`item_weight_dagger',                    1 lbs)dnl
define(`item_weight_dagger_punching',           1 lbs)dnl
define(`item_weight_gauntlet_spiked',           1 lbs)dnl
define(`item_weight_mace_light',                4 lbs)dnl
define(`item_weight_sickle',                    2 lbs)dnl
define(`item_weight_club',                      3 lbs)dnl
define(`item_weight_mace_heavy',                8 lbs)dnl
define(`item_weight_morningstar',               6 lbs)dnl
define(`item_weight_shortspear',                3 lbs)dnl
define(`item_weight_longspear',                 9 lbs)dnl
define(`item_weight_quarterstaff',              4 lbs)dnl
define(`item_weight_spear',                     6 lbs)dnl
define(`item_weight_crossbow_heavy',            8 lbs)dnl
define(`item_weight_crossbow_light',            4 lbs)dnl
define(`item_weight_dart',                      8  oz)dnl
define(`item_weight_javelin',                   2 lbs)dnl
define(`item_weight_sling',                     4  oz)dnl
define(`item_weight_axe_throwing',              2 lbs)dnl
define(`item_weight_hammer_light',              2 lbs)dnl
define(`item_weight_handaxe',                   3 lbs)dnl
define(`item_weight_kukri',                     2 lbs)dnl
define(`item_weight_pick_light',                3 lbs)dnl
define(`item_weight_sap',                       2 lbs)dnl
define(`item_weight_shortsword',                2 lbs)dnl
define(`item_weight_battleaxe',                 6 lbs)dnl
define(`item_weight_flail',                     5 lbs)dnl
define(`item_weight_longsword',                 4 lbs)dnl
define(`item_weight_pick_heavy',                6 lbs)dnl
define(`item_weight_rapier',                    2 lbs)dnl
define(`item_weight_scimitar',                  4 lbs)dnl
define(`item_weight_trident',                   4 lbs)dnl
define(`item_weight_warhammer',                 5 lbs)dnl
define(`item_weight_falchion',                  8 lbs)dnl
define(`item_weight_glaive',                   10 lbs)dnl
define(`item_weight_greataxe',                 12 lbs)dnl
define(`item_weight_greatclub',                 8 lbs)dnl
define(`item_weight_flail_heavy',              10 lbs)dnl
define(`item_weight_greatsword',                8 lbs)dnl
define(`item_weight_guisarme',                 12 lbs)dnl
define(`item_weight_halberd',                  12 lbs)dnl
define(`item_weight_lance',                    10 lbs)dnl
define(`item_weight_ranseur',                  12 lbs)dnl
define(`item_weight_scythe',                   10 lbs)dnl
define(`item_weight_longbow',                   3 lbs)dnl
define(`item_weight_longbow_composite',         3 lbs)dnl
define(`item_weight_shortbow',                  2 lbs)dnl
define(`item_weight_shortbow_composite',        2 lbs)dnl
define(`item_weight_kama',                      2 lbs)dnl
define(`item_weight_nunchaku',                  2 lbs)dnl
define(`item_weight_sai',                       1 lbs)dnl
define(`item_weight_siangham',                  1 lbs)dnl
define(`item_weight_sword_bastard',             6 lbs)dnl
define(`item_weight_waraxe_dwarfen',            8 lbs)dnl
define(`item_weight_whip',                      2 lbs)dnl
define(`item_weight_axe_orc_double',           15 lbs)dnl
define(`item_weight_chain_spiked',             10 lbs)dnl
define(`item_weight_flail_dire',               10 lbs)dnl
define(`item_weight_hammer_gnome_hooked',       6 lbs)dnl
define(`item_weight_sword_twobladed',          10 lbs)dnl
define(`item_weight_urgrosh_dwarfen',          12 lbs)dnl
define(`item_weight_bola',                      2 lbs)dnl
define(`item_weight_crossbow_hand',             2 lbs)dnl
define(`item_weight_crossbow_repeating_heavy', 12 lbs)dnl
define(`item_weight_crossbow_repeating_light',  6 lbs)dnl
define(`item_weight_net',                       6 lbs)dnl
define(`item_weight_shuriken',                  8  oz)dnl
dnl
define(`item_weight_arrows',                    3 lbs)dnl 20 pieces for any type of bow
define(`item_weight_bolts',                     1 lbs)dnl 10 pieces for any non-repeating type of crossbow, 5 pieces for repeating type
define(`item_weight_bullets',                   5 lbs)dnl 10 pieces for sling

dnl ***** armor, PHB, p.123
define(`item_weight_AT_light_padded',          10 lbs)dnl
define(`item_weight_AT_light_leather',         15 lbs)dnl
define(`item_weight_AT_light_leather_studded', 20 lbs)dnl
define(`item_weight_AT_light_chain_shirt',     25 lbs)dnl
define(`item_weight_AT_medium_hide',           25 lbs)dnl
define(`item_weight_AT_medium_scale_mail',     30 lbs)dnl
define(`item_weight_AT_medium_chain_mail',     40 lbs)dnl
define(`item_weight_AT_medium_breastplate',    30 lbs)dnl
define(`item_weight_AT_heavy_splint_mail',     45 lbs)dnl
define(`item_weight_AT_heavy_banded_mail',     35 lbs)dnl
define(`item_weight_AT_heavy_half_plate',      50 lbs)dnl
define(`item_weight_AT_heavy_full_plate',      50 lbs)dnl
dnl
define(`item_weight_shield_buckler',            5 lbs)dnl
define(`item_weight_shield_light_wood',         5 lbs)dnl
define(`item_weight_shield_light_steel',        6 lbs)dnl
define(`item_weight_shield_heavy_wood',        10 lbs)dnl
define(`item_weight_shield_heavy_steel',       15 lbs)dnl
define(`item_weight_shield_tower',             45 lbs)dnl
define(`item_weight_shield_darkwoodbuckler',   40  oz)dnl
define(`item_weight_shield_darkwoodshield',     5 lbs)dnl
dnl
define(`item_weight_spikes_armor',             50 lbs)dnl
define(`item_weight_spikes_shield',             5 lbs)dnl

dnl ***** accessoirs
define(`item_weight_backpack',         40  oz)dnl empty !!!
define(`item_weight_barrel',           20 lbs)dnl
define(`item_weight_bedroll_light',     5 lbs)dnl
define(`item_weight_bedroll_heavy',    10 lbs)dnl
define(`item_weight_blanket_light',     2 lbs)dnl
define(`item_weight_blanket_heavy',     5 lbs)dnl
define(`item_weight_boots',            56  oz)dnl
define(`item_weight_brush',             4  oz)dnl
define(`item_weight_caltrops',          2 lbs)dnl 5 pieces
define(`item_weight_candle',            4  oz)dnl
define(`item_weight_case',              1 lbs)dnl
define(`item_weight_cask',              5 lbs)dnl
define(`item_weight_chain_10ft',        9 lbs)dnl
define(`item_weight_chalk',             4  oz)dnl 10 pieces
define(`item_weight_charcoal',          1 lbs)dnl
define(`item_weight_chisel',            1 lbs)dnl
define(`item_weight_cloak',            40  oz)dnl
define(`item_weight_climbing_pick',     2 lbs)dnl
define(`item_weight_climbers_kit',      5 lbs)dnl
define(`item_weight_coat',              7 lbs)dnl
define(`item_weight_fire_start_bow',    8  oz)dnl
define(`item_weight_flint_steel',       8  oz)dnl
define(`item_weight_framepack',        56  oz)dnl
define(`item_weight_gloves',            8  oz)dnl
define(`item_weight_grappling_hook',    1 lbs)dnl
define(`item_weight_hammer',            1 lbs)dnl
define(`item_weight_hammock',          40  oz)dnl
define(`item_weight_harness',           4 lbs)dnl
define(`item_weight_hat',               1 lbs)dnl
define(`item_weight_hood',              8  oz)dnl
define(`item_weight_ink',               4  oz)dnl
define(`item_weight_ladder_10ft',      15 lbs)dnl
define(`item_weight_lantern',          24  oz)dnl
define(`item_weight_lock_pick_kit',     8  oz)dnl
define(`item_weight_mirror',            8  oz)dnl
define(`item_weight_nails',             8  oz)dnl 20 pieces
define(`item_weight_oar',              72  oz)dnl
define(`item_weight_oil_flask',         1 lbs)dnl
define(`item_weight_padded_undercoat',  3 lbs)dnl
define(`item_weight_paddle',            3 lbs)dnl
define(`item_weight_padlock',           1 lbs)dnl
define(`item_weight_pants',            24  oz)dnl
define(`item_weight_paper',             4  oz)dnl 10 pieces
define(`item_weight_parchment',         4  oz)dnl 10 pieces
define(`item_weight_pegs',              2 lbs)dnl 10 pieces
define(`item_weight_pitons',           40  oz)dnl 10 pieces
define(`item_weight_plank',            12 lbs)dnl
define(`item_weight_pole',              8 lbs)dnl
define(`item_weight_pot',              40  oz)dnl
define(`item_weight_pouch',             8  oz)dnl belt pouch
define(`item_weight_quill_pens',        4  oz)dnl 10 pieces
define(`item_weight_quiver',            8  oz)dnl
define(`item_weight_rope_50ft',        88  oz)dnl
define(`item_weight_rope_50ft_sup',     3 lbs)dnl
define(`item_weight_sack',             40  oz)dnl
define(`item_weight_saddle',           11 lbs)dnl
define(`item_weight_saddle_bag',        5 lbs)dnl
define(`item_weight_saw',              40  oz)dnl
define(`item_weight_scabbard_1h',       1 lbs)dnl
define(`item_weight_scabbard_2h',      24  oz)dnl
define(`item_weight_shirt',             1 lbs)dnl
define(`item_weight_spade',             4 lbs)dnl
define(`item_weight_sundial',           1 lbs)dnl
define(`item_weight_surcoat',          24  oz)dnl
define(`item_weight_tarp',              4 lbs)dnl
define(`item_weight_tent',              9 lbs)dnl
define(`item_weight_tinderbox',         4  oz)dnl
define(`item_weight_torch',             1 lbs)dnl
define(`item_weight_vial',              4  oz)dnl
define(`item_weight_weapon_belt',       1 lbs)dnl
define(`item_weight_wedge_staying',     1 lbs)dnl
define(`item_weight_wedge_spiltting',   3 lbs)dnl
define(`item_weight_wire_100ft',        3 lbs)dnl
define(`item_weight_whetstone',         8  oz)dnl
define(`item_weight_whistle',           8  oz)dnl

dnl ***** clothing
define(`item_weight_outfit_artisan',       4 lbs)dnl
define(`item_weight_outfit_cleric',        6 lbs)dnl
define(`item_weight_outfit_cold_weather',  7 lbs)dnl
define(`item_weight_outfit_courtier',      6 lbs)dnl
define(`item_weight_outfit_entertainer',   4 lbs)dnl
define(`item_weight_outfit_explorer',      8 lbs)dnl
define(`item_weight_outfit_monk',          2 lbs)dnl
define(`item_weight_outfit_noble',        10 lbs)dnl
define(`item_weight_outfit_peasant',       2 lbs)dnl
define(`item_weight_outfit_royal',        15 lbs)dnl
define(`item_weight_outfit_scholar',       6 lbs)dnl
define(`item_weight_outfit_traveller',     5 lbs)dnl

dnl ***** misc items
define(`item_weight_potion',            1  oz)dnl DMG, p.229
define(`item_weight_oil',               1  oz)dnl DMG, p.229
define(`item_weight_rune_paper',       20   g)dnl
define(`item_weight_scroll',            1  oz)dnl
define(`item_weight_wand',              1  oz)dnl DMG, p.245
define(`item_weight_rod',               5 lbs)dnl DMG, p.233
define(`item_weight_staff',             5 lbs)dnl DMG, p.243
define(`item_weight_ring',             10   g)dnl
define(`item_weight_herb',              8   g)dnl
define(`item_weight_goodberry',         5   g)dnl
define(`item_weight_spellbook',         3 lbs)dnl

define(`item_weight_trail_ration',      1 lbs)dnl 1 day
define(`item_weight_greatbread',        4 lbs)dnl 1 week, preserved
define(`item_weight_waybread',          4 lbs)dnl 1 month, preserved
define(`item_weight_knife_fork_spoon',  6  oz)dnl
define(`item_weight_waterskin',         4 lbs)dnl


dnl ***** template
dnl define(`item_weight_',                  0 lbs)dnl



dnl
dnl ***** transform weight to 1/100 g and sum up ...
dnl
define(`resolve_weight_unit', `ifelse(dnl
eval(regexp($1, `\<lbs$') >= 0), 1, eval( 45360 * regexp($1, `^\([0-9]+\)', \1)),dnl
eval(regexp($1,  `\<oz$') >= 0), 1, eval(  2835 * regexp($1, `^\([0-9]+\)', \1)),dnl
eval(regexp($1,  `\<cr$') >= 0), 1, eval(    20 * regexp($1, `^\([0-9]+\)', \1)),dnl
eval(regexp($1,  `\<kg$') >= 0), 1, eval(100000 * regexp($1, `^\([0-9]+\)', \1)),dnl
eval(regexp($1,   `\<g$') >= 0), 1, eval(   100 * regexp($1, `^\([0-9]+\)', \1)),dnl
dnl eval(regexp($1, `^[0123456789]*$') >= 0), 1, $1, dnl
`error(unknown weight measure: $1)')')dnl
dnl
define(`resolve_weight_size', `ifelse(dnl
$2,medium,     `resolve_weight_unit($1)',dnl
$2, small,`eval(resolve_weight_unit($1) / 2)',dnl
`error(unknown item size: $2)')')dnl
dnl
define(`calc_weight', `ifelse($2,,`resolve_weight_size($1,item_default_size)',`resolve_weight_size($1,$2)')')
dnl
define(`item_container', `resolve_weight_unit($1)')dnl
define(`item_unnamed',   `resolve_weight_unit($1)')dnl
define(`item_multiple',  `eval(calc_weight(item_weight_$1) * $2)')
define(`item_size',      `calc_weight(item_weight_$1, $2)')
dnl
dnl arguments: bag's own weight, bag's maximum hold weight, list of items
define(`item_bag_of_holding', `dnl
  define(`item_bag_self',     resolve_weight_unit($1))dnl
  define(`item_bag_hold_max', resolve_weight_unit($2))dnl
  define(`item_bag_hold',     sum_weight(shift(shift($@))))dnl
  define(`item_bag_gauge',    eval(item_bag_hold * 100 / item_bag_hold_max))dnl
  ifelse(eval(item_bag_hold <= item_bag_hold_max),1, item_bag_self, eval(item_bag_hold - item_bag_hold_max + item_bag_self))dnl
')
dnl
define(`item_coins',     `eval(dnl
calc_weight(item_weight_coin_platinum) * $1 + dnl
calc_weight(item_weight_coin_gold)     * $2 + dnl
calc_weight(item_weight_coin_silver)   * $3 + dnl
calc_weight(item_weight_coin_copper)   * $4)')dnl
dnl
define(`sum_weight', `ifelse($1,`',0,dnl
eval(regexp($1, `^ *[0-9]+$') >= 0), 1, `eval($1 + sum_weight(shift($@)))',dnl
`eval(calc_weight(item_weight_$1) + sum_weight(shift($@)))')')dnl


dnl
dnl ***** calculate the boundaries of the load categories, PHB, p.162
dnl
define(`calc_load_max', `ifelse(dnl
eval($1 <=  0), 1, 0, dnl
eval($1 <= 10), 1, eval($1 * 10), dnl
$1, 11, 115, dnl
$1, 12, 130, dnl
$1, 13, 150, dnl
$1, 14, 175, dnl
$1, 15, 200, dnl
$1, 16, 230, dnl
$1, 17, 260, dnl
$1, 18, 300, dnl
$1, 19, 350, dnl
$1, 20, 400, dnl
`eval(4 * calc_load_max(eval($1 - 10)))')')
dnl
define(`resolve_load_max_size', `ifelse(dnl cf. PHB, p.162
stat_size,  colossal,`eval( resolve_weight_unit($1) * 16     )',dnl
stat_size,gargantuan,`eval( resolve_weight_unit($1) *  8     )',dnl
stat_size,      huge,`eval( resolve_weight_unit($1) *  4     )',dnl
stat_size,     large,`eval( resolve_weight_unit($1) *  2     )',dnl
stat_size,    medium,`eval( resolve_weight_unit($1)          )',dnl
stat_size,     small,`eval((resolve_weight_unit($1) *  3) / 4)',dnl
stat_size,      tiny,`eval( resolve_weight_unit($1)       / 2)',dnl
stat_size,diminutive,`eval( resolve_weight_unit($1)       / 4)',dnl
stat_size,      fine,`eval( resolve_weight_unit($1)       / 8)',dnl
`error(unknown character size: stat_size)')')dnl
dnl
define(`weight_limit_max',    resolve_load_max_size(calc_load_max(eval(STR_score + STR_scdam + STR_scitm)) lbs))
define(`weight_limit_medium', eval(weight_limit_max * 2 / 3))
define(`weight_limit_light',  eval(weight_limit_max     / 3))


dnl
dnl ***** now calculation the total weight and compare with the weight limits
dnl
define(`weight_total', sum_weight(list_cargo))
dnl
define(`weight_limit_max_DEX', ifelse(dnl cf. PHB, p.162
eval(weight_total > weight_limit_max),   1, 0,dnl
eval(weight_total > weight_limit_medium),1, 1,dnl
eval(weight_total > weight_limit_light), 1, 3,))
dnl
define(`weight_check_penalty', ifelse(dnl
eval(weight_total > weight_limit_max),   1,-20,dnl
eval(weight_total > weight_limit_medium),1, -6,dnl
eval(weight_total > weight_limit_light), 1, -3,0))
dnl
define(`weight_limit_speed', ifelse(dnl
eval(weight_total > weight_limit_max),   1,2,dnl cannot move anymore if loaded beyond maximum
stat_race,dwarf,0,dnl dwarves are not emcumbered by medium or heavy armor or load
eval(weight_total > weight_limit_light), 1,1,dnl medium or heavy load encumbers by one step
0))dnl otherwise no reduction
dnl
define(`weight_limit_max_pace', ifelse(dnl
eval(weight_total > weight_limit_max),   1,0,dnl
eval(weight_total > weight_limit_medium),1,3,dnl
eval(weight_total > weight_limit_light), 1,4,))
