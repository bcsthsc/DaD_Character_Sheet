
dnl ***** this file deals with the druid's wild shape ability

dnl
dnl abbreviations:
dnl   PHB: Player Hand Book
dnl   MoM: Monster Manual I
dnl   ELH: Epic Level Handbook
dnl   SST: Sandstorm
dnl   FRB: Frostburn
dnl   MOW: Masters of the Wild
dnl



dnl ***** determine accessible types and sizes of creatures according to druid level, PHB, table 3-8, p.35 and p.37
define(`wild_shape_accessible_type', animal dinosaur dire ifelse(eval(level_druid >= 12),1,plant) ifelse(eval(level_druid >= 16),1,elemental))dnl

define(`wild_shape_accessible_size1',dnl
  ifelse(eval((level_druid >= 11)  &&  ifdef(feat_diminutive_wild_shape,1,0)  &&  ifdef(feat_fine_wild_shape,1,0)),1, fine) dnl
  ifelse(eval((level_druid >= 11)  &&  ifdef(feat_diminutive_wild_shape,1,0)),1, diminutive) dnl
  ifelse(eval( level_druid >= 11),1, tiny) dnl
  small dnl
  medium dnl
  ifelse(eval( level_druid >=  8),1,large) dnl
  ifelse(eval( level_druid >= 15),1, huge) dnl
  ifelse(eval((level_druid >= 15)  &&  ifdef(feat_gargantuan_wild_shape,1,0)),1, gargantuan) dnl
  ifelse(eval((level_druid >= 15)  &&  ifdef(feat_gargantuan_wild_shape,1,0)  &&  ifdef(feat_colossal_wild_shape,1,0)),1, colossal) dnl
)dnl
define(`wild_shape_accessible_size2', ifelse(eval(level_druid >= 16),1,small medium large) ifelse(eval(level_druid >= 20),1,huge))dnl

define(`wild_shape_accessible_size_animal',       wild_shape_accessible_size1)
define(`wild_shape_accessible_size_beast',        wild_shape_accessible_size1)
define(`wild_shape_accessible_size_dinosaur',     wild_shape_accessible_size1)
define(`wild_shape_accessible_size_dire',         wild_shape_accessible_size1)
define(`wild_shape_accessible_size_dragon',       wild_shape_accessible_size1)
define(`wild_shape_accessible_size_plant',        wild_shape_accessible_size1)
define(`wild_shape_accessible_size_elemental',    wild_shape_accessible_size2)
define(`wild_shape_accessible_size_el_creature',  wild_shape_accessible_size1)
define(`wild_shape_accessible_size_magbeast',     wild_shape_accessible_size1)
define(`wild_shape_accessible_size_vermin',       wild_shape_accessible_size1)
define(`level_wild_shape_spec_DC',             level_druid)dnl base save DCs against special abilities on druid level only not on total character level

dnl ***** template for initialization
define(`wild_shape_init', `dnl
define(`wild_shape_balance',        0)dnl
define(`wild_shape_climb',          0)dnl
define(`wild_shape_escape_artist',  0)dnl
define(`wild_shape_hide',           0)dnl
define(`wild_shape_jump',           0)dnl
define(`wild_shape_listen',         0)dnl
define(`wild_shape_move_silently',  0)dnl
define(`wild_shape_spot',           0)dnl
define(`wild_shape_swim',           0)dnl
define(`wild_shape_survival',       0)dnl
define(`wild_shape_tumble',         0)dnl
dnl
define(`wild_shape_climb_by_DEX', 0)dnl
define(`wild_shape_jump_by_DEX',  0)dnl
define(`wild_shape_swim_by_DEX',  0)dnl
dnl
define(`wild_shape_mark_balance',       0)dnl
define(`wild_shape_mark_climb',         0)dnl
define(`wild_shape_mark_escape_artist', 0)dnl
define(`wild_shape_mark_hide',          0)dnl
define(`wild_shape_mark_jump',          0)dnl
define(`wild_shape_mark_listen',        0)dnl
define(`wild_shape_mark_move_silently', 0)dnl
define(`wild_shape_mark_spot',          0)dnl
define(`wild_shape_mark_swim',          0)dnl
define(`wild_shape_mark_survival',      0)dnl
define(`wild_shape_mark_tumble',        0)dnl
dnl
define(`wild_shape_feat_agile',      0)dnl
define(`wild_shape_feat_alertness',  0)dnl
define(`wild_shape_feat_initiative', 0)dnl
define(`wild_shape_feat_stealthy',   0)dnl
define(`wild_shape_feat_toughness',  0)dnl
dnl
define(`wild_shape_spec_DC',          )')


dnl ***** Initialize for the upcomming table entries
define(`wild_shape_table_entries', `%')dnl


dnl ***** This is the calculation template *****
define(`wild_shape_compute', `dnl
dnl
define(`wild_shape_STR', calc_ability_mod(wild_shape_STR_score + STR_scdam))dnl apply ability damages, but no item modifiers
define(`wild_shape_DEX', calc_ability_mod(wild_shape_DEX_score + DEX_scdam))dnl
define(`wild_shape_CON', calc_ability_mod(wild_shape_CON_score + CON_scdam))dnl
define(`wild_shape_INT', calc_ability_mod(           INT_score + INT_scdam))dnl
define(`wild_shape_WIS', calc_ability_mod(           WIS_score + WIS_scdam))dnl
define(`wild_shape_CHA', calc_ability_mod(           CHA_score + CHA_scdam))dnl
dnl
dnl check the access to type and size of creature
define(`wild_shape_accessible_final', eval(dnl
(level_druid >= 5)  &&  dnl
(level_druid >= wild_shape_hd)  &&  dnl
(regexp(wild_shape_accessible_type, `\<'wild_shape_type`\>') >= 0)  &&  dnl
(!wild_shape_show_known_only  ||  wild_shape_known)  &&  (dnl
ifelse(wild_shape_type,     animal, (regexp(wild_shape_accessible_size_animal,      `\<'wild_shape_size`\>') >= 0), 0)  ||  dnl
ifelse(wild_shape_type,   dinosaur, (regexp(wild_shape_accessible_size_dinosaur,    `\<'wild_shape_size`\>') >= 0), 0)  ||  dnl
ifelse(wild_shape_type,       dire, (regexp(wild_shape_accessible_size_dire,        `\<'wild_shape_size`\>') >= 0), 0)  ||  dnl
ifelse(wild_shape_type,      plant, (regexp(wild_shape_accessible_size_plant,       `\<'wild_shape_size`\>') >= 0), 0)  ||  dnl
ifelse(wild_shape_type,  elemental, (regexp(wild_shape_accessible_size_elemental,   `\<'wild_shape_size`\>') >= 0), 0)  ||  dnl
ifelse(wild_shape_type,      beast, (regexp(wild_shape_accessible_size_beast,       `\<'wild_shape_size`\>') >= 0  &&  ifdef(`feat_beast_wild_shape',              1,0)), 0)  ||  dnl
ifelse(wild_shape_type,     dragon, (regexp(wild_shape_accessible_size_dragon,      `\<'wild_shape_size`\>') >= 0  &&  ifdef(`feat_dragon_wild_shape',             1,0)), 0)  ||  dnl
ifelse(wild_shape_type, elcreature, (regexp(wild_shape_accessible_size_el_creature, `\<'wild_shape_size`\>') >= 0  &&  ifdef(`feat_improved_elemental_wild_shape', 1,0)), 0)  ||  dnl
ifelse(wild_shape_type,   magbeast, (regexp(wild_shape_accessible_size_magbeast,    `\<'wild_shape_size`\>') >= 0  &&  ifdef(`feat_magical_beast_wild_shape',      1,0)), 0)  ||  dnl
ifelse(wild_shape_type,     vermin, (regexp(wild_shape_accessible_size_vermin,      `\<'wild_shape_size`\>') >= 0  &&  ifdef(`feat_vermin_wild_shape',             1,0)), 0)      dnl
)))dnl
dnl
define(`wild_shape_table_entries', wild_shape_table_entries ifelse(wild_shape_accessible_final,0,,`
ifelse(wild_shape_show_known_only,1,,`\makebox[1ex][r]{ifelse(wild_shape_known,1,\mbox{$\scriptscriptstyle \surd$})} & ')dnl wild shape learned ?
dnl
wild_shape_name & dnl shape name
dnl
wild_shape_page & dnl page in Monster Manual
dnl
emph_sign(eval(level_total * (wild_shape_CON - CON) + 3 * (wild_shape_feat_toughness - ifdef(`feat_toughness',feat_toughness,0)))) & dnl hit point adjustment
emph_sign(eval(bonus_attack_base - calc_base_attack_avrg(wild_shape_hd))) & dnl difference of base attack bonus of character and animal
dnl
eval(wild_shape_DEX + calc_max(ifdef(`feat_improved_initiative',4,0),ifelse(wild_shape_feat_initiative,1,4,0))) & dnl initiative
dnl
eval(save_fort_base + wild_shape_CON + save_fort_misc) & dnl
eval(save_rflx_base + wild_shape_DEX + save_rflx_misc) & dnl Will Save is listed seperately because it is independent of shape
dnl
dnl now the skills ...
emph_sign(eval(wild_shape_DEX + rank_balance + bonus_balance + bonus_skills_global + wild_shape_balance + ifelse(wild_shape_feat_agile,0,0,ifdef(`feat_agile',0,2))))dnl
\makebox[0.05\basewidth][l]{ifelse(wild_shape_mark_balance,1,{$\scriptstyle {}^{\ast}$},)} & dnl
dnl
emph_sign(eval(ifelse(wild_shape_climb_by_DEX,1,wild_shape_DEX,wild_shape_STR) + rank_climb + bonus_climb + bonus_skills_global + wild_shape_climb))dnl
\makebox[0.05\basewidth][l]{ifelse(wild_shape_mark_climb,1,{$\scriptstyle {}^{\ast}$},)} & dnl
dnl
emph_sign(eval(wild_shape_CON + rank_concentration + bonus_concentration + bonus_skills_global)) & dnl
dnl
emph_sign(eval(wild_shape_DEX + rank_escape_artist + bonus_escape_artist + bonus_skills_global + wild_shape_escape_artist + ifelse(wild_shape_feat_agile,0,0,ifdef(`feat_agile',0,2))))dnl
\makebox[0.05\basewidth][l]{ifelse(wild_shape_mark_escape_artist,1,{$\scriptstyle {}^{\ast}$},)} & dnl
dnl
emph_sign(eval(wild_shape_DEX + rank_hide + bonus_hide + bonus_skills_global + wild_shape_hide + ifelse(wild_shape_feat_stealthy,0,0,ifdef(`feat_stealthy',0,2)) + stat_size_hide_mod(wild_shape_size)))dnl
\makebox[0.05\basewidth][l]{ifelse(wild_shape_mark_hide,1,{$\scriptstyle {}^{\ast}$},)} & dnl
dnl
emph_sign(eval(ifelse(wild_shape_jump_by_DEX,1,wild_shape_DEX,wild_shape_STR) + rank_jump + bonus_jump + bonus_skills_global + wild_shape_jump))dnl
\makebox[0.05\basewidth][l]{ifelse(wild_shape_mark_jump,1,{$\scriptstyle {}^{\ast}$},)} & dnl
dnl
emph_sign(eval(wild_shape_WIS + rank_listen + bonus_listen + bonus_skills_global + wild_shape_listen + ifelse(wild_shape_feat_alertness,0,0,ifdef(`feat_alertness',0,2))))dnl
\makebox[0.05\basewidth][l]{ifelse(wild_shape_mark_listen,1,{$\scriptstyle {}^{\ast}$},)} & dnl
dnl
emph_sign(eval(wild_shape_DEX + rank_move_silently + bonus_move_silently + bonus_skills_global + wild_shape_move_silently + ifelse(wild_shape_feat_stealthy,0,0,ifdef(`feat_stealthy',0,2))))dnl
\makebox[0.05\basewidth][l]{ifelse(wild_shape_mark_move_silently,1,{$\scriptstyle {}^{\ast}$},)} & dnl
dnl
emph_sign(eval(wild_shape_WIS + rank_spot + bonus_spot + bonus_skills_global + wild_shape_spot + ifelse(wild_shape_feat_alertness,0,0,ifdef(`feat_alertness',0,2))))dnl
\makebox[0.05\basewidth][l]{ifelse(wild_shape_mark_spot,1,{$\scriptstyle {}^{\ast}$},)} & dnl
dnl
emph_sign(eval(ifelse(wild_shape_swim_by_DEX,1,wild_shape_DEX,wild_shape_STR) + rank_swim + bonus_swim + bonus_skills_global + wild_shape_swim))dnl
\makebox[0.05\basewidth][l]{ifelse(wild_shape_mark_swim,1,{$\scriptstyle {}^{\ast}$},)} & dnl
dnl
emph_sign(eval(wild_shape_WIS + rank_survival + bonus_survival + bonus_skills_global + wild_shape_survival))dnl
\makebox[0.05\basewidth][l]{ifelse(wild_shape_mark_survival,1,{$\scriptstyle {}^{\ast}$},)} & dnl
dnl
dnl emph_sign(eval(wild_shape_DEX + rank_tumble + bonus_tumble + bonus_skills_global + wild_shape_tumble))dnl
dnl \makebox[0.05\basewidth][l]{ifelse(wild_shape_mark_tumble,1,{$\scriptstyle {}^{\ast}$},)} & dnl
dnl
ifelse(wild_shape_spec_DC,,--,wild_shape_spec_DC)dnl
\\ \hline %'))')%







dnl ***************
dnl ***** Ape *****
dnl ***************
define(`wild_shape_name', Ape)dnl
define(`wild_shape_page', 268)dnl
define(`wild_shape_known', wild_shape_known_ape)
dnl
wild_shape_init
define(`wild_shape_hd', 4)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 21)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 14)dnl
dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ******************
dnl ***** Baboon *****
dnl ******************
define(`wild_shape_name', Baboon)dnl
define(`wild_shape_page', 268)dnl
define(`wild_shape_known', wild_shape_known_baboon)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 15)dnl
define(`wild_shape_DEX_score', 14)dnl
define(`wild_shape_CON_score', 12)dnl
dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ******************
dnl ***** Badger *****
dnl ******************
define(`wild_shape_name', Badger)dnl
define(`wild_shape_page', 268)dnl
define(`wild_shape_known', wild_shape_known_badger)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score',  8)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_escape_artist', eval(wild_shape_escape_artist +  4))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_agile',      1)dnl Korrektur MoM, p.329
define(`wild_shape_feats', `Track')dnl
dnl
wild_shape_compute



dnl ***************
dnl ***** Bat *****
dnl ***************
define(`wild_shape_name', Bat)dnl
define(`wild_shape_page', 268)dnl
define(`wild_shape_known', wild_shape_known_bat)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', diminutive)dnl accessible only via epic feat
dnl
define(`wild_shape_STR_score',  1)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_mark_listen',        1)dnl
define(`wild_shape_mark_spot',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Blindsense 20\aps')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Black Bear *****
dnl **********************
define(`wild_shape_name', Black Bear)dnl
define(`wild_shape_page', 269)dnl
define(`wild_shape_known', wild_shape_known_bear_black)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 19)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  4))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Endurance\komma Run')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Brown Bear *****
dnl **********************
define(`wild_shape_name', Brown Bear)dnl
define(`wild_shape_page', 269)dnl
define(`wild_shape_known', wild_shape_known_bear_brown)
dnl
wild_shape_init
define(`wild_shape_hd', 6)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 27)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 19)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  4))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Endurance\komma Run\komma Track')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Polar Bear *****
dnl **********************
define(`wild_shape_name', Polar Bear)dnl
define(`wild_shape_page', 269)dnl
define(`wild_shape_known', wild_shape_known_bear_polar)
dnl
wild_shape_init
define(`wild_shape_hd', 8)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 27)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 19)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Endurance\komma Run\komma Track')dnl
dnl
wild_shape_compute



dnl *****************
dnl ***** Bison *****
dnl *****************
define(`wild_shape_name', Bison)dnl
define(`wild_shape_page', 269)dnl
define(`wild_shape_known', wild_shape_known_bison)
dnl
wild_shape_init
define(`wild_shape_hd', 5)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 22)dnl
define(`wild_shape_DEX_score', 10)dnl
define(`wild_shape_CON_score', 16)dnl
dnl
dnl Stampede not possible for a single bison, so no Save DC given
dnl define(`wild_shape_spec_DC', `eval(10 + wild_shape_STR + (level_wild_shape_spec_DC / 2))')dnl Stampede
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl ****************
dnl ***** Boar *****
dnl ****************
define(`wild_shape_name', Boar)dnl
define(`wild_shape_page', 270)dnl
define(`wild_shape_known', wild_shape_known_boar)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 15)dnl
define(`wild_shape_DEX_score', 10)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl *****************
dnl ***** Camel *****
dnl *****************
define(`wild_shape_name', Dromedary)dnl category according to description text and SST, p.192
define(`wild_shape_page', 270)dnl
define(`wild_shape_known', wild_shape_known_dromedary)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 18)dnl
define(`wild_shape_DEX_score', 16)dnl
define(`wild_shape_CON_score', 14)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent\komma Sure Feet')dnl Sure Feet, cf. SST, p.192
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl ***************
dnl ***** Cat *****
dnl ***************
define(`wild_shape_name', Cat)dnl
define(`wild_shape_page', 270)dnl
define(`wild_shape_known', wild_shape_known_cat)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', tiny)dnl
dnl
define(`wild_shape_STR_score',  3)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  4))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_jump',          eval(wild_shape_jump          +  8))dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  4))dnl
define(`wild_shape_climb_by_DEX',       1)dnl
define(`wild_shape_jump_by_DEX',        1)dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_stealthy',   1)dnl Korrektur MoM, p.329
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl *******************
dnl ***** Cheetah *****
dnl *******************
define(`wild_shape_name', Cheetah)dnl
define(`wild_shape_page', 271)dnl
define(`wild_shape_known', wild_shape_known_cheetah)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 16)dnl
define(`wild_shape_DEX_score', 19)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent\komma Sprint')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Crocodile *****
dnl *********************
define(`wild_shape_name', Crocodile)dnl
define(`wild_shape_page', 271)dnl
define(`wild_shape_known', wild_shape_known_crocodile)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 19)dnl
define(`wild_shape_DEX_score', 12)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  3))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_hide',          1)dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Hold Breath')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ***************************
dnl ***** Giant Crocodile *****
dnl ***************************
define(`wild_shape_name', Giant Crocodile)dnl
define(`wild_shape_page', 271)dnl
define(`wild_shape_known', wild_shape_known_crocodile_giant)
dnl
wild_shape_init
define(`wild_shape_hd', 7)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 27)dnl
define(`wild_shape_DEX_score', 12)dnl
define(`wild_shape_CON_score', 19)dnl
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  3))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_hide',          1)dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Hold Breath')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl ***************
dnl ***** Dog *****
dnl ***************
define(`wild_shape_name', Dog)dnl
define(`wild_shape_page', 271)dnl
define(`wild_shape_known', wild_shape_known_dog)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score', 13)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_jump',          eval(wild_shape_jump          +  4))dnl
define(`wild_shape_mark_survival',      1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Track')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Riding Dog *****
dnl **********************
define(`wild_shape_name', Riding Dog)dnl
define(`wild_shape_page', 272)dnl
define(`wild_shape_known', wild_shape_known_dog_riding)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 15)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_jump',          eval(wild_shape_jump          +  4))dnl
define(`wild_shape_mark_survival',      1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Track')dnl
dnl
wild_shape_compute



dnl ******************
dnl ***** Donkey *****
dnl ******************
define(`wild_shape_name', Donkey)dnl
define(`wild_shape_page', 272)dnl
define(`wild_shape_known', wild_shape_known_donkey)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 10)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 12)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  2))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl *****************
dnl ***** Eagle *****
dnl *****************
define(`wild_shape_name', Eagle)dnl
define(`wild_shape_page', 272)dnl
define(`wild_shape_known', wild_shape_known_eagle)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score', 10)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 12)dnl
dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  8))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision')dnl
define(`wild_shape_feat_alertness',  1)dnl Korrektur MoM, p.329
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ********************
dnl ***** Elephant *****
dnl ********************
define(`wild_shape_name', Elephant)dnl
define(`wild_shape_page', 272)dnl
define(`wild_shape_known', wild_shape_known_elephant)
dnl
wild_shape_init
define(`wild_shape_hd', 11)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 30)dnl
define(`wild_shape_DEX_score', 10)dnl
define(`wild_shape_CON_score', 21)dnl
dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  3))dnl Skill Focus (Listen)
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_STR + (level_wild_shape_spec_DC / 2))')dnl Trample
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance\komma Iron Will')dnl
dnl
wild_shape_compute



dnl ****************
dnl ***** Hawk *****
dnl ****************
define(`wild_shape_name', Hawk)dnl
define(`wild_shape_page', 273)dnl
define(`wild_shape_known', wild_shape_known_hawk)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', tiny)dnl
dnl
define(`wild_shape_STR_score',  6)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  8))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision')dnl
define(`wild_shape_feat_alertness',  1)dnl Korrektur MoM, p.329
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Heavy Horse *****
dnl ***********************
define(`wild_shape_name', Heavy Horse)dnl
define(`wild_shape_page', 273)dnl
define(`wild_shape_known', wild_shape_known_horse_heavy)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 16)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Endurance\komma Run')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Light Horse *****
dnl ***********************
define(`wild_shape_name', Light Horse)dnl
define(`wild_shape_page', 273)dnl
define(`wild_shape_known', wild_shape_known_horse_light)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 14)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Endurance\komma Run')dnl
dnl
wild_shape_compute



dnl **************************
dnl ***** Heavy Warhorse *****
dnl **************************
define(`wild_shape_name', Heavy Warhorse)dnl
define(`wild_shape_page', 273)dnl
define(`wild_shape_known', wild_shape_known_horse_heavy_war)
dnl
wild_shape_init
define(`wild_shape_hd', 4)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 18)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Endurance\komma Run')dnl
dnl
wild_shape_compute



dnl **************************
dnl ***** Light Warhorse *****
dnl **************************
define(`wild_shape_name', Light Warhorse)dnl
define(`wild_shape_page', 274)dnl
define(`wild_shape_known', wild_shape_known_horse_light_war)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 16)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Endurance\komma Run')dnl
dnl
wild_shape_compute



dnl *****************
dnl ***** Hyena *****
dnl *****************
define(`wild_shape_name', Hyena)dnl
define(`wild_shape_page', 274)dnl
define(`wild_shape_known', wild_shape_known_hyena)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 14)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl *******************
dnl ***** Leopard *****
dnl *******************
define(`wild_shape_name', Leopard)dnl
define(`wild_shape_page', 274)dnl
define(`wild_shape_known', wild_shape_known_leopard)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 16)dnl
define(`wild_shape_DEX_score', 19)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_jump',          eval(wild_shape_jump          +  8))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  4))dnl
define(`wild_shape_mark_climb',         1)dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ****************
dnl ***** Lion *****
dnl ****************
define(`wild_shape_name', Lion)dnl
define(`wild_shape_page', 274)dnl
define(`wild_shape_known', wild_shape_known_lion)
dnl
wild_shape_init
define(`wild_shape_hd', 5)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 21)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  4))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  4))dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Run')dnl
dnl
wild_shape_compute



dnl ******************
dnl ***** Lizard *****
dnl ******************
define(`wild_shape_name', Lizard)dnl
define(`wild_shape_page', 275)dnl
define(`wild_shape_known', wild_shape_known_lizard)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', tiny)dnl
dnl
define(`wild_shape_STR_score',  3)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
define(`wild_shape_climb_by_DEX', 1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision')dnl
define(`wild_shape_feat_stealthy',   1)dnl Korrektur MoM, p.329
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl **************************
dnl ***** Monitor Lizard *****
dnl **************************
define(`wild_shape_name', Monitor Lizard)dnl
define(`wild_shape_page', 275)dnl
define(`wild_shape_known', wild_shape_known_lizard_monitor)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 17)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_hide',          1)dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Great Fortitude')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Manta Ray *****
dnl *********************
define(`wild_shape_name', Manta Ray)dnl
define(`wild_shape_page', 275)dnl
define(`wild_shape_known', wild_shape_known_mantaray)
dnl
wild_shape_init
define(`wild_shape_hd', 4)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 15)dnl
define(`wild_shape_DEX_score', 11)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl ******************
dnl ***** Monkey *****
dnl ******************
define(`wild_shape_name', Monkey)dnl
define(`wild_shape_page', 276)dnl
define(`wild_shape_known', wild_shape_known_monkey)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', tiny)dnl
dnl
define(`wild_shape_STR_score',  3)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
define(`wild_shape_climb_by_DEX', 1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_agile',      1)dnl Korrektur MoM, p.329
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ****************
dnl ***** Mule *****
dnl ****************
define(`wild_shape_name', Mule)dnl
define(`wild_shape_page', 276)dnl
define(`wild_shape_known', wild_shape_known_mule)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 16)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl *******************
dnl ***** Octopus *****
dnl *******************
define(`wild_shape_name', Octopus)dnl
define(`wild_shape_page', 276)dnl
define(`wild_shape_known', wild_shape_known_octopus)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score', 12)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 11)dnl
dnl
define(`wild_shape_escape_artist', eval(wild_shape_escape_artist + 10))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Ink Cloud\komma Jet')dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl *************************
dnl ***** Giant Octopus *****
dnl *************************
define(`wild_shape_name', Giant Octopus)dnl
define(`wild_shape_page', 276)dnl
define(`wild_shape_known', wild_shape_known_octopus_giant)
dnl
wild_shape_init
define(`wild_shape_hd', 8)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 20)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_escape_artist', eval(wild_shape_escape_artist + 10))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  3))dnl Skill Focus (Hide)
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Ink Cloud\komma Jet')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ***************
dnl ***** Owl *****
dnl ***************
define(`wild_shape_name', Owl)dnl
define(`wild_shape_page', 277)dnl
define(`wild_shape_known', wild_shape_known_owl)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', tiny)dnl
dnl
define(`wild_shape_STR_score',  4)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  8))dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently + 14))dnl
define(`wild_shape_mark_spot',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision')dnl
define(`wild_shape_feat_alertness',  1)dnl Korrektur MoM, p.329
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ****************
dnl ***** Pony *****
dnl ****************
define(`wild_shape_name', Pony)dnl
define(`wild_shape_page', 277)dnl
define(`wild_shape_known', wild_shape_known_pony)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 13)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 12)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl ********************
dnl ***** War Pony *****
dnl ********************
define(`wild_shape_name', War Pony)dnl
define(`wild_shape_page', 277)dnl
define(`wild_shape_known', wild_shape_known_pony_war)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 15)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 14)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl ********************
dnl ***** Porpoise *****
dnl ********************
define(`wild_shape_name', Porpoise)dnl
define(`wild_shape_page', 278)dnl
define(`wild_shape_known', wild_shape_known_porpoise)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 11)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_listen',        1)dnl
define(`wild_shape_mark_spot',          1)dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Blindsight 120\aps\komma Low-Light Vision\komma Hold Breath')dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ***************
dnl ***** Rat *****
dnl ***************
define(`wild_shape_name', Rat)dnl
define(`wild_shape_page', 278)dnl
define(`wild_shape_known', wild_shape_known_rat)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', tiny)dnl
dnl
define(`wild_shape_STR_score',  2)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
define(`wild_shape_mark_swim',          1)dnl
define(`wild_shape_climb_by_DEX', 1)dnl
define(`wild_shape_swim_by_DEX',  1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_stealthy',   1)dnl Korrektur MoM, p.329
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl *****************
dnl ***** Raven *****
dnl *****************
define(`wild_shape_name', Raven)dnl
define(`wild_shape_page', 278)dnl
define(`wild_shape_known', wild_shape_known_raven)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', tiny)dnl
dnl
define(`wild_shape_STR_score',  1)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision')dnl
define(`wild_shape_feat_alertness',  1)dnl Korrektur MoM, p.329
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Rhinoceros *****
dnl **********************
define(`wild_shape_name', Rhinoceros)dnl
define(`wild_shape_page', 278)dnl
define(`wild_shape_known', wild_shape_known_rhinoceros)
dnl
wild_shape_init
define(`wild_shape_hd', 8)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 26)dnl
define(`wild_shape_DEX_score', 10)dnl
define(`wild_shape_CON_score', 21)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl ***************
dnl ***** Roc *****
dnl ***************
define(`wild_shape_name', Roc)dnl
define(`wild_shape_page', 215)dnl
define(`wild_shape_known', wild_shape_known_roc)
dnl
wild_shape_init
define(`wild_shape_hd', 18)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', gargantuan)dnl accessible only via epic feat
dnl
define(`wild_shape_STR_score', 34)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 24)dnl
dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision')dnl
define(`wild_shape_feat_alertness',  1)dnl Korrektur MoM, p.329
define(`wild_shape_feats', `Flyby-Attack\komma Iron Will\komma Power Attack\komma Snatch\komma Wingover')dnl
dnl
wild_shape_compute



dnl ************************
dnl ***** Medium Shark *****
dnl ************************
define(`wild_shape_name', Medium Shark)dnl
define(`wild_shape_page', 279)dnl
define(`wild_shape_known', wild_shape_known_shark_medium)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 13)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Blindsense 30\aps\komma Keen Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Large Shark *****
dnl ***********************
define(`wild_shape_name', Large Shark)dnl
define(`wild_shape_page', 279)dnl
define(`wild_shape_known', wild_shape_known_shark_large)
dnl
wild_shape_init
define(`wild_shape_hd', 7)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 17)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Blindsense 30\aps\komma Keen Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `Great Fortitude')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Huge Shark *****
dnl **********************
define(`wild_shape_name', Huge Shark)dnl
define(`wild_shape_page', 279)dnl
define(`wild_shape_known', wild_shape_known_shark_huge)
dnl
wild_shape_init
define(`wild_shape_hd', 10)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 21)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Blindsense 30\aps\komma Keen Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `Great Fortitude\komma Iron Will')dnl
dnl
wild_shape_compute



dnl *****************************
dnl ***** Constrictor Snake *****
dnl *****************************
define(`wild_shape_name', Constrictor)dnl
define(`wild_shape_page', 279)dnl
define(`wild_shape_known', wild_shape_known_constrictor_snake)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 17)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ***********************************
dnl ***** Giant Constrictor Snake *****
dnl ***********************************
define(`wild_shape_name', Giant Constrictor)dnl
define(`wild_shape_page', 280)dnl
define(`wild_shape_known', wild_shape_known_constrictor_snake_giant)
dnl
wild_shape_init
define(`wild_shape_hd', 11)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 25)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  3))dnl Skill Focus: Hide
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Tiny Viper *****
dnl **********************
define(`wild_shape_name', Tiny Viper)dnl
define(`wild_shape_page', 279)dnl
define(`wild_shape_known', wild_shape_known_viper_tiny)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', tiny)dnl
dnl
define(`wild_shape_STR_score',  4)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 11)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
define(`wild_shape_mark_swim',          1)dnl
define(`wild_shape_climb_by_DEX',   1)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_CON + (level_wild_shape_spec_DC / 2))')dnl Poison
dnl
define(`wild_shape_special_abilities', `Scent')dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Small Viper *****
dnl ***********************
define(`wild_shape_name', Small Viper)dnl
define(`wild_shape_page', 279)dnl
define(`wild_shape_known', wild_shape_known_viper_small)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score',  6)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 11)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
define(`wild_shape_mark_swim',          1)dnl
define(`wild_shape_climb_by_DEX',   1)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_CON + (level_wild_shape_spec_DC / 2))')dnl Poison
dnl
define(`wild_shape_special_abilities', `Scent')dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ************************
dnl ***** Medium Viper *****
dnl ************************
define(`wild_shape_name', Medium Viper)dnl
define(`wild_shape_page', 279)dnl
define(`wild_shape_known', wild_shape_known_viper_medium)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score',  8)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 11)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
define(`wild_shape_mark_swim',          1)dnl
define(`wild_shape_climb_by_DEX',   1)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_CON + (level_wild_shape_spec_DC / 2))')dnl Poison
dnl
define(`wild_shape_special_abilities', `Scent')dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Large Viper *****
dnl ***********************
define(`wild_shape_name', Large Viper)dnl
define(`wild_shape_page', 279)dnl
define(`wild_shape_known', wild_shape_known_viper_large)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 10)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 11)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
define(`wild_shape_mark_swim',          1)dnl
define(`wild_shape_climb_by_DEX',   1)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_CON + (level_wild_shape_spec_DC / 2))')dnl Poison
dnl
define(`wild_shape_special_abilities', `Scent')dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Huge Viper *****
dnl **********************
define(`wild_shape_name', Huge Viper)dnl
define(`wild_shape_page', 279)dnl
define(`wild_shape_known', wild_shape_known_viper_huge)
dnl
wild_shape_init
define(`wild_shape_hd', 6)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 16)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_CON + (level_wild_shape_spec_DC / 2))')dnl Poison
dnl
define(`wild_shape_special_abilities', `Scent')dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `Run')dnl
dnl
wild_shape_compute



dnl *****************
dnl ***** Squid *****
dnl *****************
define(`wild_shape_name', Squid)dnl
define(`wild_shape_page', 281)dnl
define(`wild_shape_known', wild_shape_known_squid)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 14)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 11)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Ink Cloud\komma Jet')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Giant Squid *****
dnl ***********************
define(`wild_shape_name', Giant Squid)dnl
define(`wild_shape_page', 281)dnl
define(`wild_shape_known', wild_shape_known_squid_giant)
dnl
wild_shape_init
define(`wild_shape_hd', 12)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 26)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Ink Cloud\komma Jet')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  2)dnl
define(`wild_shape_feats', `Endurance\komma Diehard')dnl
dnl
wild_shape_compute



dnl *****************
dnl ***** Tiger *****
dnl *****************
define(`wild_shape_name', Tiger)dnl
define(`wild_shape_page', 281)dnl
define(`wild_shape_known', wild_shape_known_tiger)
dnl
wild_shape_init
define(`wild_shape_hd', 6)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 23)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  4))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  4))dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ****************
dnl ***** Toad *****
dnl ****************
define(`wild_shape_name', Toad)dnl
define(`wild_shape_page', 282)dnl
define(`wild_shape_known', wild_shape_known_toad)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', diminutive)dnl accessible only via epic feat
dnl
define(`wild_shape_STR_score',  1)dnl
define(`wild_shape_DEX_score', 12)dnl
define(`wild_shape_CON_score', 11)dnl
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Amphibious')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ******************
dnl ***** Weasel *****
dnl ******************
define(`wild_shape_name', Weasel)dnl
define(`wild_shape_page', 282)dnl
define(`wild_shape_known', wild_shape_known_weasel)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', tiny)dnl
dnl
define(`wild_shape_STR_score',  3)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  4))dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_climb_by_DEX', 1)dnl
define(`wild_shape_mark_climb',         1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_agile',      1)dnl Korrektur MoM, p.329
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ************************
dnl ***** Baleen Whale *****
dnl ************************
define(`wild_shape_name', Baleen Whale)dnl
define(`wild_shape_page', 282)dnl
define(`wild_shape_known', wild_shape_known_whale_baleen)
dnl
wild_shape_init
define(`wild_shape_hd', 12)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', gargantuan)dnl accessible only via epic feat
dnl
define(`wild_shape_STR_score', 35)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 22)dnl
dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_listen',        1)dnl
define(`wild_shape_mark_spot',          1)dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Blindsight 120\aps\komma Low-Light Vision\komma Hold Breath')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  2)dnl
define(`wild_shape_feats', `Endurance\komma Diehard')dnl
dnl
wild_shape_compute



dnl **************************
dnl ***** Cachalot Whale *****
dnl **************************
define(`wild_shape_name', Cachalot Whale)dnl
define(`wild_shape_page', 283)dnl
define(`wild_shape_known', wild_shape_known_whale_cachalot)
dnl
wild_shape_init
define(`wild_shape_hd', 12)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', gargantuan)dnl accessible only via epic feat
dnl
define(`wild_shape_STR_score', 35)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 24)dnl
dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_listen',        1)dnl
define(`wild_shape_mark_spot',          1)dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Blindsight 120\aps\komma Low-Light Vision\komma Hold Breath')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feats', `Endurance\komma Diehard')dnl
dnl
wild_shape_compute



dnl ****************
dnl ***** Orca *****
dnl ****************
define(`wild_shape_name', Orca)dnl
define(`wild_shape_page', 283)dnl
define(`wild_shape_known', wild_shape_known_whale_orca)
dnl
wild_shape_init
define(`wild_shape_hd', 9)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 27)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 21)dnl
dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_listen',        1)dnl
define(`wild_shape_mark_spot',          1)dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Blindsight 120\aps\komma Low-Light Vision\komma Hold Breath')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feats', `Endurance\komma Run')dnl
dnl
wild_shape_compute



dnl ****************
dnl ***** Wolf *****
dnl ****************
define(`wild_shape_name', Wolf)dnl
define(`wild_shape_page', 283)dnl
define(`wild_shape_known', wild_shape_known_wolf)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 13)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_mark_survival',      1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Track')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Wolverine *****
dnl *********************
define(`wild_shape_name', Wolverine)dnl
define(`wild_shape_page', 283)dnl
define(`wild_shape_known', wild_shape_known_wolverine)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 14)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 19)dnl
dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feats', `Track')dnl
dnl
wild_shape_compute



dnl ******************** The Dinosaurs ********************



dnl ***********************
dnl ***** Deinonychus *****
dnl ***********************
define(`wild_shape_name', Deinonychus)dnl
define(`wild_shape_page', 60)dnl
define(`wild_shape_known', wild_shape_known_dino_deinonychus)
dnl
wild_shape_init
define(`wild_shape_hd', 4)dnl
define(`wild_shape_type', dinosaur)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 19)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 19)dnl
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  8))dnl
define(`wild_shape_jump',          eval(wild_shape_jump          +  8))dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  8))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  8))dnl
define(`wild_shape_survival',      eval(wild_shape_survival      +  8))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Run\komma Track')dnl
dnl
wild_shape_compute



dnl ************************
dnl ***** Elasmosaurus *****
dnl ************************
define(`wild_shape_name', Elasmosaurus)dnl
define(`wild_shape_page', 60)dnl
define(`wild_shape_known', wild_shape_known_dino_elasmosaurus)
dnl
wild_shape_init
define(`wild_shape_hd', 10)dnl
define(`wild_shape_type', dinosaur)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 26)dnl
define(`wild_shape_DEX_score', 14)dnl
define(`wild_shape_CON_score', 22)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl sonst passt es nicht
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_toughness', 2)dnl
define(`wild_shape_feats', `Dodge\komma Great Fortitude')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Megaraptor *****
dnl **********************
define(`wild_shape_name', Megaraptor)dnl
define(`wild_shape_page', 60)dnl
define(`wild_shape_known', wild_shape_known_dino_megaraptor)
dnl
wild_shape_init
define(`wild_shape_hd', 8)dnl
define(`wild_shape_type', dinosaur)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 21)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 21)dnl
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  8))dnl
define(`wild_shape_jump',          eval(wild_shape_jump          +  8))dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  8))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  8))dnl
define(`wild_shape_survival',      eval(wild_shape_survival      +  8))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_toughness', 1)dnl
define(`wild_shape_feats', `Run\komma Track')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Triceratops *****
dnl ***********************
define(`wild_shape_name', Triceratops)dnl
define(`wild_shape_page', 61)dnl
define(`wild_shape_known', wild_shape_known_dino_triceratops)
dnl
wild_shape_init
define(`wild_shape_hd', 16)dnl
define(`wild_shape_type', dinosaur)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 30)dnl
define(`wild_shape_DEX_score',  9)dnl
define(`wild_shape_CON_score', 25)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_STR + (level_wild_shape_spec_DC / 2))')dnl Trample
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  4)dnl
define(`wild_shape_feats', `Great Fortitude')dnl
dnl
wild_shape_compute



dnl *************************
dnl ***** Tyrannosaurus *****
dnl *************************
define(`wild_shape_name', Tyrannosaurus)dnl
define(`wild_shape_page', 61)dnl
define(`wild_shape_known', wild_shape_known_dino_tyrannosaurus)
dnl
wild_shape_init
define(`wild_shape_hd', 18)dnl
define(`wild_shape_type', dinosaur)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 28)dnl
define(`wild_shape_DEX_score', 12)dnl
define(`wild_shape_CON_score', 21)dnl
dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  2))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  2))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  3)dnl
define(`wild_shape_feats', `Run\komma Track')dnl
dnl
wild_shape_compute



dnl ******************** The Dire Animals ********************
dnl dire animals seem to recieve good will base save boni
dnl well, this doesn't matter, as base save boni are taken from the druid anyway



dnl ********************
dnl ***** Dire Ape *****
dnl ********************
define(`wild_shape_name', Dire Ape)dnl
define(`wild_shape_page', 62)dnl
define(`wild_shape_known', wild_shape_known_dire_ape)
dnl
wild_shape_init
define(`wild_shape_hd', 5)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 22)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 14)dnl
dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Dire Badger *****
dnl ***********************
define(`wild_shape_name', Dire Badger)dnl
define(`wild_shape_page', 62)dnl
define(`wild_shape_known', wild_shape_known_dire_badger)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 14)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 19)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feats', `Track')dnl
dnl
wild_shape_compute



dnl ********************
dnl ***** Dire Bat *****
dnl ********************
define(`wild_shape_name', Dire Bat)dnl
define(`wild_shape_page', 62)dnl
define(`wild_shape_known', wild_shape_known_dire_bat)
dnl
wild_shape_init
define(`wild_shape_hd', 4)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 17)dnl
define(`wild_shape_DEX_score', 22)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_mark_listen',        1)dnl
define(`wild_shape_mark_spot',          1)dnl
dnl
define(`wild_shape_special_abilities', `Blindsense 40\aps')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_stealthy',   1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Dire Bear *****
dnl *********************
define(`wild_shape_name', Dire Bear)dnl
define(`wild_shape_page', 63)dnl
define(`wild_shape_known', wild_shape_known_dire_bear)
dnl
wild_shape_init
define(`wild_shape_hd', 12)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 31)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 19)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  2))dnl sonst passt es nicht mit den skill points
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feats', `Endurance\komma Run')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Dire Boar *****
dnl *********************
define(`wild_shape_name', Dire Boar)dnl
define(`wild_shape_page', 63)dnl
define(`wild_shape_known', wild_shape_known_dire_boar)
dnl
wild_shape_init
define(`wild_shape_hd', 7)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 27)dnl
define(`wild_shape_DEX_score', 10)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance\komma Iron Will')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Dire Lion *****
dnl *********************
define(`wild_shape_name', Dire Lion)dnl
define(`wild_shape_page', 63)dnl
define(`wild_shape_known', wild_shape_known_dire_lion)
dnl
wild_shape_init
define(`wild_shape_hd', 8)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 25)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  4))dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Run')dnl
dnl
wild_shape_compute



dnl ********************
dnl ***** Dire Rat *****
dnl ********************
define(`wild_shape_name', Dire Rat)dnl
define(`wild_shape_page', 64)dnl
define(`wild_shape_known', wild_shape_known_dire_rat)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score', 10)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 12)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_climb_by_DEX', 1)dnl
define(`wild_shape_swim_by_DEX',  1)dnl
define(`wild_shape_mark_climb',         1)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_CON + (level_wild_shape_spec_DC / 2))')dnl Disease
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance\komma Iron Will')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Dire Shark *****
dnl **********************
define(`wild_shape_name', Dire Shark)dnl
define(`wild_shape_page', 64)dnl
define(`wild_shape_known', wild_shape_known_dire_shark)
dnl
wild_shape_init
define(`wild_shape_hd', 18)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 23)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Keen Scent')dnl
define(`wild_shape_feat_toughness', 4)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Dire Tiger *****
dnl **********************
define(`wild_shape_name', Dire Tiger)dnl
define(`wild_shape_page', 65)dnl
define(`wild_shape_known', wild_shape_known_dire_tiger)
dnl
wild_shape_init
define(`wild_shape_hd', 16)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 27)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  4))dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_stealthy',   1)dnl
define(`wild_shape_feats', `Run')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Dire Weasel *****
dnl ***********************
define(`wild_shape_name', Dire Weasel)dnl
define(`wild_shape_page', 65)dnl
define(`wild_shape_known', wild_shape_known_dire_weasel)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 14)dnl
define(`wild_shape_DEX_score', 19)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_stealthy',   1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Dire Wolf *****
dnl *********************
define(`wild_shape_name', Dire Wolf)dnl
define(`wild_shape_page', 65)dnl
define(`wild_shape_known', wild_shape_known_dire_wolf)
dnl
wild_shape_init
define(`wild_shape_hd', 6)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 25)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  2))dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  2))dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  2))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  2))dnl
define(`wild_shape_mark_survival',      1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Run\komma Track')dnl
dnl
wild_shape_compute



dnl **************************
dnl ***** Dire Wolverine *****
dnl **************************
define(`wild_shape_name', Dire Wolverine)dnl
define(`wild_shape_page', 66)dnl
define(`wild_shape_known', wild_shape_known_dire_wolverine)
dnl
wild_shape_init
define(`wild_shape_hd', 5)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 22)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 19)dnl
dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_mark_climb',         1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feats', `Track')dnl
dnl
wild_shape_compute



dnl ******************** The Plants ********************

dnl not included: Assassin Vine (MoM p.20), Shrieker (MoM p.113), Violet Fungus (MoM p.113)



dnl **************************
dnl ***** Phantom Fungus *****
dnl **************************
define(`wild_shape_name', Phantom Fungus)dnl
define(`wild_shape_page', 207)dnl
define(`wild_shape_known', wild_shape_known_plant_phantom_fungus)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', plant)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 14)dnl
define(`wild_shape_DEX_score', 10)dnl
define(`wild_shape_CON_score', 16)dnl
dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  5))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Plant Traits\komma Greater Invisibility')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ***************************
dnl ***** Shambling Mound *****
dnl ***************************
define(`wild_shape_name', Shambling Mound)dnl
define(`wild_shape_page', 222)dnl
define(`wild_shape_known', wild_shape_known_plant_shambling_mound)
dnl
wild_shape_init
define(`wild_shape_hd', 8)dnl
define(`wild_shape_type', plant)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 21)dnl
define(`wild_shape_DEX_score', 10)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  4))dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Low-Light Vision\komma Plant Traits\komma Immunity to Electricity\komma Resistance to Fire 10')dnl
define(`wild_shape_feats', `Iron Will\komma Power Attack')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Tendriculos *****
dnl ***********************
define(`wild_shape_name', Tendriculos)dnl
define(`wild_shape_page', 241)dnl
define(`wild_shape_known', wild_shape_known_plant_tendriculos)
dnl
wild_shape_init
define(`wild_shape_hd', 9)dnl
define(`wild_shape_type', plant)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 28)dnl
define(`wild_shape_DEX_score',  9)dnl
define(`wild_shape_CON_score', 22)dnl
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl sonst passt es nicht
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Plant Traits\komma Regeneration 10')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_stealthy',   1)dnl
define(`wild_shape_feats', `Iron Will\komma Power Attack')dnl
dnl
wild_shape_compute



dnl ******************
dnl ***** Treant *****
dnl ******************
define(`wild_shape_name', Treant)dnl
define(`wild_shape_page', 244)dnl
define(`wild_shape_known', wild_shape_known_plant_treant)
dnl
wild_shape_init
define(`wild_shape_hd', 7)dnl
define(`wild_shape_type', plant)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 29)dnl
define(`wild_shape_DEX_score',  8)dnl
define(`wild_shape_CON_score', 21)dnl
dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Plant Traits\komma Vulnerability to Fire\komma Damage Reduction 10/Slashing')dnl
define(`wild_shape_feats', `Improved Sunder\komma Iron Will\komma Power Attack')dnl
dnl
wild_shape_compute



dnl ******************** The Elementals ********************



dnl *********************************
dnl ***** Elemental, Air, small *****
dnl *********************************
define(`wild_shape_name', Small Air Elem.)dnl
define(`wild_shape_page', 95)dnl
define(`wild_shape_known', wild_shape_known_elemental_air_small)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score', 10)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Elemental Traits')dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `Flyby Attack')dnl
dnl
wild_shape_compute



dnl **********************************
dnl ***** Elemental, Air, medium *****
dnl **********************************
define(`wild_shape_name', Medium Air Elem.)dnl
define(`wild_shape_page', 95)dnl
define(`wild_shape_known', wild_shape_known_elemental_air_medium)
dnl
wild_shape_init
define(`wild_shape_hd', 4)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 12)dnl
define(`wild_shape_DEX_score', 21)dnl
define(`wild_shape_CON_score', 14)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Elemental Traits')dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `Dodge\komma Flyby Attack')dnl
dnl
wild_shape_compute



dnl *********************************
dnl ***** Elemental, Air, large *****
dnl *********************************
define(`wild_shape_name', Large Air Elem.)dnl
define(`wild_shape_page', 95)dnl
define(`wild_shape_known', wild_shape_known_elemental_air_large)
dnl
wild_shape_init
define(`wild_shape_hd', 8)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 14)dnl
define(`wild_shape_DEX_score', 25)dnl
define(`wild_shape_CON_score', 16)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Elemental Traits\komma Damage Reduction 5/--')dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `Combat Reflexes\komma Dodge\komma Flyby Attack')dnl
dnl
wild_shape_compute



dnl ********************************
dnl ***** Elemental, Air, huge *****
dnl ********************************
define(`wild_shape_name', Huge Air Elem.)dnl
define(`wild_shape_page', 95)dnl
define(`wild_shape_known', wild_shape_known_elemental_air_huge)
dnl
wild_shape_init
define(`wild_shape_hd', 16)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 18)dnl
define(`wild_shape_DEX_score', 29)dnl
define(`wild_shape_CON_score', 18)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Elemental Traits\komma Damage Reduction 5/--')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `Combat Reflexes\komma Dodge\komma Flyby Attack\komma Mobility\komma Spring Attack')dnl
dnl
wild_shape_compute



dnl ***********************************
dnl ***** Elemental, Earth, small *****
dnl ***********************************
define(`wild_shape_name', Small Earth Elem.)dnl
define(`wild_shape_page', 97)dnl
define(`wild_shape_known', wild_shape_known_elemental_earth_small)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score', 17)dnl
define(`wild_shape_DEX_score',  8)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Earth Glide\komma Elemental Traits')dnl
define(`wild_shape_feats', `Power Attack')dnl
dnl
wild_shape_compute



dnl ************************************
dnl ***** Elemental, Earth, medium *****
dnl ************************************
define(`wild_shape_name', Medium Earth Elem.)dnl
define(`wild_shape_page', 97)dnl
define(`wild_shape_known', wild_shape_known_elemental_earth_medium)
dnl
wild_shape_init
define(`wild_shape_hd', 4)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 21)dnl
define(`wild_shape_DEX_score',  8)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Earth Glide\komma Elemental Traits')dnl
define(`wild_shape_feats', `Cleave\komma Power Attack')dnl
dnl
wild_shape_compute



dnl ***********************************
dnl ***** Elemental, Earth, large *****
dnl ***********************************
define(`wild_shape_name', Large Earth Elem.)dnl
define(`wild_shape_page', 97)dnl
define(`wild_shape_known', wild_shape_known_elemental_earth_large)
dnl
wild_shape_init
define(`wild_shape_hd', 8)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 25)dnl
define(`wild_shape_DEX_score',  8)dnl
define(`wild_shape_CON_score', 19)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Earth Glide\komma Elemental Traits\komma Damage Reduction 5/--')dnl
define(`wild_shape_feats', `Cleave\komma Great Cleave\komma Power Attack')dnl
dnl
wild_shape_compute



dnl **********************************
dnl ***** Elemental, Earth, huge *****
dnl **********************************
define(`wild_shape_name', Huge Earth Elem.)dnl
define(`wild_shape_page', 97)dnl
define(`wild_shape_known', wild_shape_known_elemental_earth_huge)
dnl
wild_shape_init
define(`wild_shape_hd', 16)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 29)dnl
define(`wild_shape_DEX_score',  8)dnl
define(`wild_shape_CON_score', 21)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Earth Glide\komma Elemental Traits\komma Damage Reduction 5/--')dnl
define(`wild_shape_feats', `Awesome Blow\komma Cleave\komma Great Cleave\komma Improved Bull Rush\komma Iron Will\komma Power Attack')dnl
dnl
wild_shape_compute



dnl **********************************
dnl ***** Elemental, Fire, small *****
dnl **********************************
define(`wild_shape_name', Small Fire Elem.)dnl
define(`wild_shape_page', 98)dnl
define(`wild_shape_known', wild_shape_known_elemental_fire_small)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score', 10)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Elemental Traits\komma Immunity to Fire\komma Vulnerability to Cold')dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `Dodge')dnl
dnl
wild_shape_compute



dnl ***********************************
dnl ***** Elemental, Fire, medium *****
dnl ***********************************
define(`wild_shape_name', Medium Fire Elem.)dnl
define(`wild_shape_page', 98)dnl
define(`wild_shape_known', wild_shape_known_elemental_fire_medium)
dnl
wild_shape_init
define(`wild_shape_hd', 4)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 12)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 14)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Elemental Traits\komma Immunity to Fire\komma Vulnerability to Cold')dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `Dodge\komma Mobility')dnl
dnl
wild_shape_compute



dnl **********************************
dnl ***** Elemental, Fire, large *****
dnl **********************************
define(`wild_shape_name', Large Fire Elem.)dnl
define(`wild_shape_page', 98)dnl
define(`wild_shape_known', wild_shape_known_elemental_fire_large)
dnl
wild_shape_init
define(`wild_shape_hd', 8)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 14)dnl
define(`wild_shape_DEX_score', 21)dnl
define(`wild_shape_CON_score', 16)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Elemental Traits\komma Immunity to Fire\komma Vulnerability to Cold\komma Damage Reduction 5/--')dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `Dodge\komma Mobility\komma Spring Attack')dnl
dnl
wild_shape_compute



dnl *********************************
dnl ***** Elemental, Fire, huge *****
dnl *********************************
define(`wild_shape_name', Huge Fire Elem.)dnl
define(`wild_shape_page', 98)dnl
define(`wild_shape_known', wild_shape_known_elemental_fire_huge)
dnl
wild_shape_init
define(`wild_shape_hd', 16)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 18)dnl
define(`wild_shape_DEX_score', 25)dnl
define(`wild_shape_CON_score', 18)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Elemental Traits\komma Immunity to Fire\komma Vulnerability to Cold\komma Damage Reduction 5/--')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `Combat Reflexes\komma Dodge\komma Mobility\komma Spring Attack\komma Iron Will')dnl
dnl
wild_shape_compute



dnl ***********************************
dnl ***** Elemental, Water, small *****
dnl ***********************************
define(`wild_shape_name', Small Water Elem.)dnl
define(`wild_shape_page', 98)dnl
define(`wild_shape_known', wild_shape_known_elemental_water_small)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score', 14)dnl
define(`wild_shape_DEX_score', 10)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Elemental Traits')dnl
define(`wild_shape_feats', `Power Attack')dnl
dnl
wild_shape_compute



dnl ************************************
dnl ***** Elemental, Water, medium *****
dnl ************************************
define(`wild_shape_name', Medium Water Elem.)dnl
define(`wild_shape_page', 98)dnl
define(`wild_shape_known', wild_shape_known_elemental_water_medium)
dnl
wild_shape_init
define(`wild_shape_hd', 4)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 16)dnl
define(`wild_shape_DEX_score', 12)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Elemental Traits')dnl
define(`wild_shape_feats', `Cleave\komma Power Attack')dnl
dnl
wild_shape_compute



dnl ***********************************
dnl ***** Elemental, Water, large *****
dnl ***********************************
define(`wild_shape_name', Large Water Elem.)dnl
define(`wild_shape_page', 98)dnl
define(`wild_shape_known', wild_shape_known_elemental_water_large)
dnl
wild_shape_init
define(`wild_shape_hd', 8)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 20)dnl
define(`wild_shape_DEX_score', 14)dnl
define(`wild_shape_CON_score', 19)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Elemental Traits\komma Damage Reduction 5/--')dnl
define(`wild_shape_feats', `Cleave\komma Great Cleave\komma Power Attack')dnl
dnl
wild_shape_compute



dnl **********************************
dnl ***** Elemental, Water, huge *****
dnl **********************************
define(`wild_shape_name', Huge Water Elem.)dnl
define(`wild_shape_page', 98)dnl
define(`wild_shape_known', wild_shape_known_elemental_water_huge)
dnl
wild_shape_init
define(`wild_shape_hd', 16)dnl
define(`wild_shape_type', elemental)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 24)dnl
define(`wild_shape_DEX_score', 18)dnl
define(`wild_shape_CON_score', 21)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Elemental Traits\komma Damage Reduction 5/--')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Cleave\komma Great Cleave\komma Power Attack\komma Improved Bull Rush\komma Iron Will')dnl
dnl
wild_shape_compute



dnl ******************** The Elemental Creatures ********************

dnl not included yet: Belker



dnl *****************************
dnl ***** Invisible Stalker *****
dnl *****************************
define(`wild_shape_name', Invisible Stalker)dnl
define(`wild_shape_page', 160)dnl
define(`wild_shape_known', wild_shape_known_elcreature_invisiblestalker)
dnl
wild_shape_init
define(`wild_shape_hd',   8)dnl
define(`wild_shape_type', elcreature)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 18)dnl
define(`wild_shape_DEX_score', 19)dnl
define(`wild_shape_CON_score', 14)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Elemental Traits\komma Natural Invisibility\komma Improved Tracking')dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `Combat Reflexes')dnl
dnl
wild_shape_compute



dnl *******************
dnl ***** Thoqqua *****
dnl *******************
define(`wild_shape_name', Thoqqua)dnl
define(`wild_shape_page', 242)dnl
define(`wild_shape_known', wild_shape_known_elcreature_thoqqua)
dnl
wild_shape_init
define(`wild_shape_hd',   3)dnl
define(`wild_shape_type', elcreature)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 15)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Tremorsense 60\aps\komma Elemental Traits\komma Immunity to Fire\komma Vulnerability to Cold')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ******************** The Dragons ********************

dnl not included: 



dnl ************************
dnl ***** Pseudodragon *****
dnl ************************
define(`wild_shape_name', Pseudodragon)dnl
define(`wild_shape_page', 210)dnl
define(`wild_shape_known', wild_shape_known_dragon_pseudodragon)
dnl
wild_shape_init
define(`wild_shape_hd',   2)dnl
define(`wild_shape_type', dragon)dnl
define(`wild_shape_size', tiny)dnl
dnl
define(`wild_shape_STR_score',  6)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Darkvision 60\aps\komma Blindsense 60\aps\komma Telepathy 60\aps\komma Spell Resistance 19\komma Immunity to Sleep and Paralysis')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ******************** Creatures from Sandstorm Rulebook ********************



dnl *****************
dnl ***** Camel *****
dnl *****************
define(`wild_shape_name', Camel)dnl this is the two-humped version, for one-humped (=dromedary) see Monster Manual I, p.270
define(`wild_shape_page', 193)dnl
define(`wild_shape_known', wild_shape_known_camel)
dnl
wild_shape_init
define(`wild_shape_hd', 3)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 18)dnl
define(`wild_shape_DEX_score', 16)dnl
define(`wild_shape_CON_score', 16)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent\komma Sure Feet')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl *****************
dnl ***** Camel *****
dnl *****************
define(`wild_shape_name', Camel\komma War)dnl
define(`wild_shape_page', 193)dnl
define(`wild_shape_known', wild_shape_known_camel_war)
dnl
wild_shape_init
define(`wild_shape_hd', 4)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 18)dnl
define(`wild_shape_DEX_score', 16)dnl
define(`wild_shape_CON_score', 18)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent\komma Sure Feet')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl ************************
dnl ***** Hippopotamus *****
dnl ************************
define(`wild_shape_name', Hippopotamus)dnl
define(`wild_shape_page', 193)dnl
define(`wild_shape_known', wild_shape_known_hippopotamus)
dnl
wild_shape_init
define(`wild_shape_hd', 8)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 24)dnl
define(`wild_shape_DEX_score',  9)dnl
define(`wild_shape_CON_score', 20)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Hold Breath\komma Scent')dnl
define(`wild_shape_feats', `Improved Bull Rush\komma Improved Overrun\komma Power Attack')dnl
dnl
wild_shape_compute



dnl *************************
dnl ***** Horned Lizard *****
dnl *************************
define(`wild_shape_name', Horned Lizard)dnl
define(`wild_shape_page', 194)dnl
define(`wild_shape_known', wild_shape_known_horned_lizard)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', tiny)dnl
dnl
define(`wild_shape_STR_score',  7)dnl
define(`wild_shape_DEX_score', 12)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_CON + (level_wild_shape_spec_DC / 2))')dnl Blood Squirt
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Spines')dnl
define(`wild_shape_feat_alertness',  1)dnl
dnl
wild_shape_compute



dnl ******************
dnl ***** Serval *****
dnl ******************
define(`wild_shape_name', Serval)dnl
define(`wild_shape_page', 194)dnl
define(`wild_shape_known', wild_shape_known_serval)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score', 12)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  4))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  4))dnl
define(`wild_shape_jump',          eval(wild_shape_jump          +  8))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  8))dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  4))dnl
define(`wild_shape_mark_hide',          1)dnl
define(`wild_shape_jump_by_DEX',        1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl treat as bonus feat, similar to several other animals who don't fulfill the prerequisites for Weapon Finesse
dnl
wild_shape_compute



dnl *******************
dnl ***** Vulture *****
dnl *******************
define(`wild_shape_name', Vulture)dnl
define(`wild_shape_page', 195)dnl
define(`wild_shape_known', wild_shape_known_vulture)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score',  8)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_survival',      eval(wild_shape_survival      +  4))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent\komma Resistance to Disease')dnl
dnl
wild_shape_compute



dnl *******************************
dnl ***** Giant Banded Lizard *****
dnl *******************************
define(`wild_shape_name', Giant Banded Lizard)dnl
define(`wild_shape_page', 164)dnl
define(`wild_shape_known', wild_shape_known_giant_banded_lizard)
dnl
wild_shape_init
define(`wild_shape_hd', 10)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 28)dnl
define(`wild_shape_DEX_score', 10)dnl
define(`wild_shape_CON_score', 23)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_CON + (level_wild_shape_spec_DC / 2))')dnl Poison
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Cleave\komma Improved Overrun\komma Power Attack')dnl
dnl
wild_shape_compute



dnl *************************
dnl ***** Protoceratops *****
dnl *************************
define(`wild_shape_name', Protoceratops)dnl
define(`wild_shape_page', 147)dnl
define(`wild_shape_known', wild_shape_known_dino_protoceratops)
dnl
wild_shape_init
define(`wild_shape_hd',   5)dnl
define(`wild_shape_type', dinosaur)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 16)dnl
define(`wild_shape_DEX_score', 11)dnl
define(`wild_shape_CON_score', 19)dnl
dnl
define(`wild_shape_survival',      eval(wild_shape_survival      +  4))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Diprotodon *****
dnl **********************
define(`wild_shape_name', Diprotodon)dnl
define(`wild_shape_page', 148)dnl
define(`wild_shape_known', wild_shape_known_dino_diprotodon)
dnl
wild_shape_init
define(`wild_shape_hd',   9)dnl
define(`wild_shape_type', dinosaur)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 27)dnl
define(`wild_shape_DEX_score', 10)dnl
define(`wild_shape_CON_score', 18)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Iron Will\komma Run')dnl
dnl
wild_shape_compute



dnl *****************************
dnl ***** Dire Hippopotamus *****
dnl *****************************
define(`wild_shape_name', Dire Hippopotamus)dnl
define(`wild_shape_page', 149)dnl
define(`wild_shape_known', wild_shape_known_dire_hippopotamus)
dnl
wild_shape_init
define(`wild_shape_hd', 18)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 34)dnl
define(`wild_shape_DEX_score',  6)dnl
define(`wild_shape_CON_score', 25)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Hold Breath\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Die Hard\komma Endurance\komma Improved Bull Rush\komma Improved Critical\komma Improved Overrun\komma Power Attack')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Dire Jackal *****
dnl ***********************
define(`wild_shape_name', Dire Jackal)dnl
define(`wild_shape_page', 150)dnl
define(`wild_shape_known', wild_shape_known_dire_jackal)
dnl
wild_shape_init
define(`wild_shape_hd', 4)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 20)dnl
define(`wild_shape_DEX_score', 14)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_jump',          eval(wild_shape_jump          +  4))dnl
define(`wild_shape_mark_survival',      1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Track')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Dire Puma *****
dnl *********************
define(`wild_shape_name', Dire Puma)dnl
define(`wild_shape_page', 150)dnl
define(`wild_shape_known', wild_shape_known_dire_puma)
dnl
wild_shape_init
define(`wild_shape_hd', 6)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 20)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score', 19)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_jump',          eval(wild_shape_jump          +  8))dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  4))dnl
define(`wild_shape_mark_climb',         1)dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Track')dnl
dnl
wild_shape_compute



dnl *************************
dnl ***** Dire Tortoise *****
dnl *************************
define(`wild_shape_name', Dire Tortoise)dnl
define(`wild_shape_page', 151)dnl
define(`wild_shape_known', wild_shape_known_dire_tortoise)
dnl
wild_shape_init
define(`wild_shape_hd', 14)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 26)dnl
define(`wild_shape_DEX_score',  6)dnl
define(`wild_shape_CON_score', 25)dnl
dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl ************************
dnl ***** Dire Vulture *****
dnl ************************
define(`wild_shape_name', Dire Vulture)dnl
define(`wild_shape_page', 152)dnl
define(`wild_shape_known', wild_shape_known_dire_vulture)
dnl
wild_shape_init
define(`wild_shape_hd', 6)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 16)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 25)dnl really !!!
dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_survival',      eval(wild_shape_survival      +  4))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent\komma Resistance to Disease')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Flyby Attack\komma Track')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Ironthorn *****
dnl *********************
define(`wild_shape_name', Ironthorn)dnl
define(`wild_shape_page', 166)dnl
define(`wild_shape_known', wild_shape_known_plant_ironthorn)
dnl
wild_shape_init
define(`wild_shape_hd', 9)dnl
define(`wild_shape_type', plant)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 17)dnl
define(`wild_shape_DEX_score', 10)dnl
define(`wild_shape_CON_score', 25)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + 2 + wild_shape_CON + (level_wild_shape_spec_DC / 2))')dnl Poison, +2 by ability focus feat
dnl
define(`wild_shape_special_abilities', `Blindsight 60\aps \komma Plant Traits\komma Damage Reduction 5/Bludgeoning or Slashing')dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feats', `Heat Endurance\komma Improved Heat Endurance')dnl
dnl
wild_shape_compute



dnl ****************************
dnl ***** Porcupine Cactus *****
dnl ****************************
dnl
dnl This is a passive plant, cannot use it as wild shape



dnl ****************************
dnl ***** Saguaro Sentinel *****
dnl ****************************
define(`wild_shape_name', Saguaro Sentinel)dnl
define(`wild_shape_page', 181)dnl
define(`wild_shape_known', wild_shape_known_plant_saguaro_sentinel)
dnl
wild_shape_init
define(`wild_shape_hd', 12)dnl
define(`wild_shape_type', plant)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 33)dnl
define(`wild_shape_DEX_score',  8)dnl
define(`wild_shape_CON_score', 25)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_STR + (level_wild_shape_spec_DC / 2))')dnl Trample
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Plant Traits\komma Damage Reduction 10/Piercing\komma Tough Flesh')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Awesome Blow\komma Improved Bull Rush\komma Power Attack')dnl
dnl
wild_shape_compute



dnl **************************
dnl ***** Tumbling Mound *****
dnl **************************
define(`wild_shape_name', Tumbling Mound)dnl
define(`wild_shape_page', 191)dnl
define(`wild_shape_known', wild_shape_known_plant_tumbling_mound)
dnl
wild_shape_init
define(`wild_shape_hd', 6)dnl
define(`wild_shape_type', plant)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 16)dnl
define(`wild_shape_DEX_score', 12)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Low-Light Vision\komma Plant Traits\komma Resistance to Fire 10')dnl
define(`wild_shape_feats', `Improved Overrun\komma Power Attack\komma Track')dnl
dnl
wild_shape_compute



dnl ******************** Creatures from Frostburn Rulebook ********************



dnl *******************
dnl ***** Caribou *****
dnl *******************
define(`wild_shape_name', Caribou)dnl
define(`wild_shape_page', 164)dnl
define(`wild_shape_known', wild_shape_known_caribou)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 13)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 12)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Arctic Fox *****
dnl **********************
define(`wild_shape_name', Arctic Fox)dnl
define(`wild_shape_page', 165)dnl
define(`wild_shape_known', wild_shape_known_arctic_fox)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score',  6)dnl
define(`wild_shape_DEX_score', 17)dnl
define(`wild_shape_CON_score',  8)dnl
dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Sea Otter *****
dnl *********************
define(`wild_shape_name', Sea Otter)dnl
define(`wild_shape_page', 165)dnl
define(`wild_shape_known', wild_shape_known_sea_otter)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 12)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Hold Breath')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl *******************
dnl ***** Penguin *****
dnl *******************
define(`wild_shape_name', Penguin)dnl
define(`wild_shape_page', 166)dnl
define(`wild_shape_known', wild_shape_known_penguin)
dnl
wild_shape_init
define(`wild_shape_hd', 1)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', tiny)dnl
dnl
define(`wild_shape_STR_score',  2)dnl
define(`wild_shape_DEX_score',  9)dnl
define(`wild_shape_CON_score', 10)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Hold Breath')dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl ****************
dnl ***** Seal *****
dnl ****************
define(`wild_shape_name', Seal)dnl
define(`wild_shape_page', 166)dnl
define(`wild_shape_known', wild_shape_known_seal)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 13)dnl
define(`wild_shape_DEX_score', 15)dnl
define(`wild_shape_CON_score', 14)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Hold Breath')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl ******************
dnl ***** Walrus *****
dnl ******************
define(`wild_shape_name', Walrus)dnl
define(`wild_shape_page', 166)dnl
define(`wild_shape_known', wild_shape_known_walrus)
dnl
wild_shape_init
define(`wild_shape_hd', 5)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 17)dnl
define(`wild_shape_DEX_score',  9)dnl
define(`wild_shape_CON_score', 12)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Hold Breath')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance')dnl
dnl
wild_shape_compute



dnl ***************************
dnl ***** Dire Polar Bear *****
dnl ***************************
define(`wild_shape_name', Dire Polar Bear)dnl
define(`wild_shape_page', 115)dnl
define(`wild_shape_known', wild_shape_known_dire_bear_polar)
dnl
wild_shape_init
define(`wild_shape_hd', 18)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 39)dnl
define(`wild_shape_DEX_score', 11)dnl
define(`wild_shape_CON_score', 23)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  2)dnl
define(`wild_shape_feats', `Endurance\komma Run\komma Track')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Glyptodon *****
dnl *********************
define(`wild_shape_name', Glyptodon)dnl
define(`wild_shape_page', 116)dnl
define(`wild_shape_known', wild_shape_known_glyptodon)
dnl
wild_shape_init
define(`wild_shape_hd', 10)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 20)dnl
define(`wild_shape_DEX_score',  8)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_STR + (level_wild_shape_spec_DC / 2))')dnl Trample
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Damage Reduction 5/Piercing')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feats', `Endurance\komma Power Attack')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Megaloceros *****
dnl ***********************
define(`wild_shape_name', Megaloceros)dnl
define(`wild_shape_page', 117)dnl
define(`wild_shape_known', wild_shape_known_megaloceros)
dnl
wild_shape_init
define(`wild_shape_hd', 6)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 20)dnl
define(`wild_shape_DEX_score', 12)dnl
define(`wild_shape_CON_score', 16)dnl
dnl
dnl Stampede not possible for a single Megaloceros, so no Save DC given
dnl define(`wild_shape_spec_DC', `eval(10 + wild_shape_STR + (level_wild_shape_spec_DC / 2))')dnl Stampede
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance\komma Run')dnl
dnl
wild_shape_compute



dnl ********************
dnl ***** Smilodon *****
dnl ********************
define(`wild_shape_name', Smilodon)dnl Saber-Tooth-Tiger
define(`wild_shape_page', 118)dnl
define(`wild_shape_known', wild_shape_known_smilodon)
dnl
wild_shape_init
define(`wild_shape_hd', 9)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 24)dnl
define(`wild_shape_DEX_score', 14)dnl
define(`wild_shape_CON_score', 16)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  4))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_move_silently', eval(wild_shape_move_silently +  4))dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Dodge\komma Mobility\komma Spring Attack')dnl
dnl
wild_shape_compute



dnl **************************
dnl ***** Woolly Mammoth *****
dnl **************************
define(`wild_shape_name', Woolly Mammoth)dnl
define(`wild_shape_page', 119)dnl
define(`wild_shape_known', wild_shape_known_woolly_mammoth)
dnl
wild_shape_init
define(`wild_shape_hd', 14)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 34)dnl
define(`wild_shape_DEX_score',  8)dnl
define(`wild_shape_CON_score', 25)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_STR + (level_wild_shape_spec_DC / 2))')dnl Trample
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance\komma Improved Bull Rush\komma Power Attack')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Zeuglodon *****
dnl *********************
define(`wild_shape_name', Zeuglodon)dnl
define(`wild_shape_page', 120)dnl
define(`wild_shape_known', wild_shape_known_zeuglodon)
dnl
wild_shape_init
define(`wild_shape_hd', 15)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', gargantuan)dnl accessible only via epic feat
dnl
define(`wild_shape_STR_score', 38)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 28)dnl
dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_listen',        1)dnl
define(`wild_shape_mark_spot',          1)dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Blindsight 120\aps\komma Low-Light Vision\komma Hold Breath')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feats', `Endurance\komma Diehard\komma Iron Will')dnl
dnl
wild_shape_compute



dnl ******************** Creatures from Rulebook Masters of the Wild ********************



dnl *********************
dnl ***** Dire Toad *****
dnl *********************
define(`wild_shape_name', Dire Toad)dnl
define(`wild_shape_page', 37)dnl
define(`wild_shape_known', wild_shape_known_dire_toad)
dnl
wild_shape_init
define(`wild_shape_hd', 4)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score',  6)dnl
define(`wild_shape_DEX_score', 14)dnl
define(`wild_shape_CON_score', 14)dnl
dnl
dnl the sums of the skills are really strange, o.k. just implement the given racial skill boni
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_jump',          eval(wild_shape_jump          +  8))dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_CON + (level_wild_shape_spec_DC / 2))')dnl Poison
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Amphibious')dnl amphibious is added by me because it is expected as for a normal toad
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Dire Hawk *****
dnl *********************
define(`wild_shape_name', Dire Hawk)dnl
define(`wild_shape_page', 37)dnl
define(`wild_shape_known', wild_shape_known_dire_hawk)
dnl
wild_shape_init
define(`wild_shape_hd', 5)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 12)dnl
define(`wild_shape_DEX_score', 22)dnl
define(`wild_shape_CON_score', 14)dnl
dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  8))dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision')dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Dire Snake *****
dnl **********************
define(`wild_shape_name', Dire Snake)dnl
define(`wild_shape_page', 37)dnl
define(`wild_shape_known', wild_shape_known_dire_snake)
dnl
wild_shape_init
define(`wild_shape_hd', 7)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 22)dnl
define(`wild_shape_DEX_score', 20)dnl
define(`wild_shape_CON_score', 16)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  8))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  4))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  4))dnl
define(`wild_shape_climb_by_DEX',   1)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_CON + (level_wild_shape_spec_DC / 2))')dnl Poison
dnl
define(`wild_shape_special_abilities', `Scent')dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Dire Horse *****
dnl **********************
define(`wild_shape_name', Dire Horse)dnl
define(`wild_shape_page', 38)dnl
define(`wild_shape_known', wild_shape_known_dire_horse)
dnl
wild_shape_init
define(`wild_shape_hd', 8)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 22)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 22)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Endurance\komma Run')dnl one further feat possible
dnl
wild_shape_compute



dnl ********************
dnl ***** Dire Elk *****
dnl ********************
define(`wild_shape_name', Dire Elf)dnl
define(`wild_shape_page', 38)dnl
define(`wild_shape_known', wild_shape_known_dire_elk)
dnl
wild_shape_init
define(`wild_shape_hd', 12)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 24)dnl
define(`wild_shape_DEX_score', 11)dnl
define(`wild_shape_CON_score', 20)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_STR + (level_wild_shape_spec_DC / 2))')dnl Trample
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Endurance')dnl four further feats possible
dnl
wild_shape_compute



dnl *************************
dnl ***** Dire Elephant *****
dnl *************************
define(`wild_shape_name', Dire Elephant)dnl
define(`wild_shape_page', 38)dnl
define(`wild_shape_known', wild_shape_known_dire_elephant)
dnl
wild_shape_init
define(`wild_shape_hd', 20)dnl
define(`wild_shape_type', dire)dnl
define(`wild_shape_size', gargantuan)dnl accessible only via epic feat
dnl
define(`wild_shape_STR_score', 40)dnl
define(`wild_shape_DEX_score', 10)dnl
define(`wild_shape_CON_score', 30)dnl
dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  3))dnl Skill Focus (Listen)
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_STR + (level_wild_shape_spec_DC / 2))')dnl Trample
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Endurance\komma Iron Will')dnl taken from Elephant, five further feats possible
dnl
wild_shape_compute



dnl ******************** Creatures from Monster Manual III Rulebook ********************



dnl ********************
dnl ***** Mastodon *****
dnl ********************
define(`wild_shape_name', Mastodon)dnl
define(`wild_shape_page', 101)dnl
define(`wild_shape_known', wild_shape_known_mastodon)
dnl
wild_shape_init
define(`wild_shape_hd', 15)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 32)dnl
define(`wild_shape_DEX_score', 11)dnl
define(`wild_shape_CON_score', 23)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_STR + (level_wild_shape_spec_DC / 2))')dnl Trample
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  1)dnl
define(`wild_shape_feats', `Endurance\komma Iron Will')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Sea Tiger *****
dnl *********************
define(`wild_shape_name', Sea Tiger)dnl
define(`wild_shape_page', 147)dnl
define(`wild_shape_known', wild_shape_known_sea_tiger)
dnl
wild_shape_init
define(`wild_shape_hd', 10)dnl
define(`wild_shape_type', animal)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 19)dnl
define(`wild_shape_DEX_score', 13)dnl
define(`wild_shape_CON_score', 17)dnl
dnl
define(`wild_shape_swim',          eval(wild_shape_swim          +  8))dnl
define(`wild_shape_mark_swim',          1)dnl
dnl
define(`wild_shape_special_abilities', `Blindsight 120\aps\komma Low-Light Vision\komma Hold Breath')dnl
define(`wild_shape_feats', `Endurance\komma Improved Bull Rush\komma Power Attack\komma Run')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Battletitan *****
dnl ***********************
define(`wild_shape_name', Battletitan)dnl
define(`wild_shape_page', 38)dnl
define(`wild_shape_known', wild_shape_known_dino_battletitan)
dnl
wild_shape_init
define(`wild_shape_hd', 36)dnl
define(`wild_shape_type', dinosaur)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 42)dnl
define(`wild_shape_DEX_score', 11)dnl
define(`wild_shape_CON_score', 29)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_initiative', 1)dnl
define(`wild_shape_feats', `Cleave\komma Improved Overrun\komma Iron Will\komma Lightning Reflexes\komma Power Attack\komma Run')dnl
dnl
wild_shape_compute



dnl ************************
dnl ***** Bloodstriker *****
dnl ************************
define(`wild_shape_name', Bloodstriker)dnl
define(`wild_shape_page', 39)dnl
define(`wild_shape_known', wild_shape_known_dino_bloodstriker)
dnl
wild_shape_init
define(`wild_shape_hd', 9)dnl
define(`wild_shape_type', dinosaur)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 22)dnl
define(`wild_shape_DEX_score', 11)dnl
define(`wild_shape_CON_score', 21)dnl
dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_toughness',  3)dnl
define(`wild_shape_feats', `Powerful Charge')dnl
dnl
wild_shape_compute



dnl **********************
dnl ***** Fleshraker *****
dnl **********************
define(`wild_shape_name', Fleshraker)dnl
define(`wild_shape_page', 40)dnl
define(`wild_shape_known', wild_shape_known_dino_fleshraker)
dnl
wild_shape_init
define(`wild_shape_hd', 4)dnl
define(`wild_shape_type', dinosaur)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 17)dnl
define(`wild_shape_DEX_score', 19)dnl
define(`wild_shape_CON_score', 15)dnl
dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  8))dnl
define(`wild_shape_jump',          eval(wild_shape_jump          +  6))dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_CON + (level_wild_shape_spec_DC / 2))')dnl Poison
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Track')dnl
dnl
wild_shape_compute



dnl **************************
dnl ***** Swindlespitter *****
dnl **************************
define(`wild_shape_name', Swindlespitter)dnl
define(`wild_shape_page', 41)dnl
define(`wild_shape_known', wild_shape_known_dino_swindlespitter)
dnl
wild_shape_init
define(`wild_shape_hd', 2)dnl
define(`wild_shape_type', dinosaur)dnl
define(`wild_shape_size', small)dnl
dnl
define(`wild_shape_STR_score',  9)dnl
define(`wild_shape_DEX_score', 21)dnl
define(`wild_shape_CON_score', 13)dnl
dnl
define(`wild_shape_listen',        eval(wild_shape_listen        +  2))dnl
define(`wild_shape_spot',          eval(wild_shape_spot          +  2))dnl
define(`wild_shape_mark_hide',          1)dnl
define(`wild_shape_mark_move_silently', 1)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_CON + (level_wild_shape_spec_DC / 2))')dnl Poison Spray
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Scent')dnl
define(`wild_shape_feats', `Run\komma Track')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Battlebriar *****
dnl ***********************
define(`wild_shape_name', Battlebriar)dnl
define(`wild_shape_page', 14)dnl
define(`wild_shape_known', wild_shape_known_plant_battlebriar)
dnl
wild_shape_init
define(`wild_shape_hd', 25)dnl
define(`wild_shape_type', plant)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 32)dnl
define(`wild_shape_DEX_score',  6)dnl
define(`wild_shape_CON_score', 27)dnl
dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_STR + (level_wild_shape_spec_DC / 2))')dnl Trample
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Low-Light Vision\komma Plant Traits\komma Resistance to Electricity 20\komma Resistance to Fire 20\komma Thorn Field')dnl
define(`wild_shape_feats', `Awesome Blow\komme Cleave\komma Great Cleave\komma Improved Bull Rush\komma Iron Will\komma Power Attack')dnl
dnl
wild_shape_compute



dnl ******************************
dnl ***** Lesser Battlebriar *****
dnl ******************************
define(`wild_shape_name', Lesser Battlebriar)dnl
define(`wild_shape_page', 15)dnl
define(`wild_shape_known', wild_shape_known_plant_battlebriar_lesser)
dnl
wild_shape_init
define(`wild_shape_hd', 12)dnl
define(`wild_shape_type', plant)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 23)dnl
define(`wild_shape_DEX_score',  6)dnl
define(`wild_shape_CON_score', 22)dnl
dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_STR + (level_wild_shape_spec_DC / 2))')dnl Trample
dnl
define(`wild_shape_special_abilities', `Darkvision 60\aps\komma Low-Light Vision\komma Plant Traits\komma Resistance to Electricity 10\komma Resistance to Fire 10\komma Thorn Field')dnl
define(`wild_shape_feats', `Cleave\komma Improved Bull Rush\komma Power Attack')dnl
dnl
wild_shape_compute



dnl ***********************
dnl ***** Night Twist *****
dnl ***********************
define(`wild_shape_name', Night Twist)dnl
define(`wild_shape_page', 110)dnl
define(`wild_shape_known', wild_shape_known_plant_night_twist)
dnl
wild_shape_init
define(`wild_shape_hd', 15)dnl
define(`wild_shape_type', plant)dnl
define(`wild_shape_size', large)dnl
dnl
define(`wild_shape_STR_score', 39)dnl
define(`wild_shape_DEX_score',  6)dnl
define(`wild_shape_CON_score', 29)dnl
dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_CHA + (level_wild_shape_spec_DC / 2))')dnl Death Curse and Despair Song
dnl
define(`wild_shape_special_abilities', `Damage Reduction 10/slashing\komma Low-Light Vision\komma Plant Traits\komma Unholy Grace\komma Vulnerability to Fire')dnl
define(`wild_shape_feats', `Blind Fight\komma Diehard\komma Endurance\komma Improved Sunder\komma Iron Will\komma Power Attack')dnl
dnl
wild_shape_compute



dnl *******************************
dnl ***** Ancient Night Twist *****
dnl *******************************
define(`wild_shape_name', Ancient Night Twist)dnl
define(`wild_shape_page', 111)dnl
define(`wild_shape_known', wild_shape_known_plant_night_twist_ancient)
dnl
wild_shape_init
define(`wild_shape_hd', 25)dnl
define(`wild_shape_type', plant)dnl
define(`wild_shape_size', huge)dnl
dnl
define(`wild_shape_STR_score', 45)dnl
define(`wild_shape_DEX_score',  6)dnl
define(`wild_shape_CON_score', 34)dnl
dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_CHA + (level_wild_shape_spec_DC / 2))')dnl Death Curse and Despair Song
dnl
define(`wild_shape_special_abilities', `Damage Reduction 15/slashing\komma Low-Light Vision\komma Plant Traits\komma Unholy Grace\komma Vulnerability to Fire')dnl
define(`wild_shape_feats', `Blind Fight\komma Diehard\komma Endurance\komma Improved Sunder\komma Iron Will\komma Power Attack')dnl
dnl
wild_shape_compute



dnl ************************
dnl ***** Plague Brush *****
dnl ************************
define(`wild_shape_name', Plague Brush)dnl
define(`wild_shape_page', 124)dnl
define(`wild_shape_known', wild_shape_known_plant_plague_brush)
dnl
wild_shape_init
define(`wild_shape_hd', 31)dnl
define(`wild_shape_type', plant)dnl
define(`wild_shape_size', colossal)dnl accessible only via epic feat
dnl
define(`wild_shape_STR_score', 35)dnl
define(`wild_shape_DEX_score', 10)dnl
define(`wild_shape_CON_score', 26)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + wild_shape_STR + (level_wild_shape_spec_DC / 2))')dnl Trample
dnl
define(`wild_shape_special_abilities', `Airy\komma Low-Light Vision\komma Plant Traits')dnl
define(`wild_shape_feats', `')dnl
dnl
wild_shape_compute



dnl *********************
dnl ***** Wood Woad *****
dnl *********************
define(`wild_shape_name', Wood Woad)dnl
define(`wild_shape_page', 196)dnl
define(`wild_shape_known', wild_shape_known_plant_wood_woad)
dnl
wild_shape_init
define(`wild_shape_hd', 8)dnl
define(`wild_shape_type', plant)dnl
define(`wild_shape_size', medium)dnl
dnl
define(`wild_shape_STR_score', 17)dnl
define(`wild_shape_DEX_score', 12)dnl
define(`wild_shape_CON_score', 16)dnl
dnl
define(`wild_shape_balance',       eval(wild_shape_balance       +  4))dnl
define(`wild_shape_climb',         eval(wild_shape_climb         +  8))dnl
define(`wild_shape_hide',          eval(wild_shape_hide          +  4))dnl
define(`wild_shape_mark_climb',         1)dnl
define(`wild_shape_mark_hide',          1)dnl
dnl
define(`wild_shape_spec_DC', `eval(10 + 2 + wild_shape_WIS)')dnl Warp Wood, spell-like ability of level 2 spell
dnl
define(`wild_shape_special_abilities', `Low-Light Vision\komma Plant Traits\komma Treewalk\komma Vulnerability to Fire')dnl
define(`wild_shape_feat_alertness',  1)dnl
define(`wild_shape_feat_stealthy',   1)dnl
define(`wild_shape_feats', `Lightning Reflexes\komma Track')dnl
dnl
wild_shape_compute



dnl Woodlings (p.197-199) are also possible, but they are creatures with the Woodling-Template, so they must be entered individually





define(`wild_shape_table', `
\newpage
%
\textbf{\underline{Wild Shape}:}\\[1ex]
%
\begin{tabular}{|c|c||c||c||c|c|c||*{9}{c|}}
\hline
\multicolumn{2}{|c||}{uses per day} & duration & heal    & \multicolumn{3}{c||}{modifier change} & \multicolumn{9}{c|}{loose bonus spells} \\
normal & elemental                  & per use  & per use & I{}N{}T & W{}I{}S & C{}H{}A           & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 \\ \hline
eval(ifelse(eval(level_druid>=18),1,6,eval(level_druid>=14),1,5,eval(level_druid>=10),1,4,eval(level_druid>=7),1,3,eval(level_druid>=6),1,2,1) + dnl
     ifdef(`feat_extra_wild_shape',2 * feat_extra_wild_shape,0)) & %
ifelse(eval(level_druid < 16),1,--,eval(ifelse(eval(level_druid>=20),1,3,eval(level_druid>=18),1,2,1) + ifdef(`feat_extra_wild_shape',feat_extra_wild_shape,0))) & %
level_druid hours & %
level_total HP & %
dnl S{}T{}R emph_sign(eval(calc_ability_mod(STR_score + STR_scdam) - STR))
dnl D{}E{}X emph_sign(eval(calc_ability_mod(DEX_score + DEX_scdam) - DEX))
dnl C{}O{}N emph_sign(eval(calc_ability_mod(CON_score + CON_scdam) - CON))
emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) - INT)) & %
emph_sign(eval(calc_ability_mod(WIS_score + WIS_scdam) - WIS)) & %
emph_sign(eval(calc_ability_mod(CHA_score + CHA_scdam) - CHA)) & %
%
ifelse(eval(level_druid< 1),1,--,eval(calc_bonus_spell_calc(1,eval(WIS_score+WIS_scdam+WIS_scitm))-calc_bonus_spell_calc(1,eval(WIS_score+WIS_scdam))))&%
ifelse(eval(level_druid< 3),1,--,eval(calc_bonus_spell_calc(2,eval(WIS_score+WIS_scdam+WIS_scitm))-calc_bonus_spell_calc(2,eval(WIS_score+WIS_scdam))))&%
ifelse(eval(level_druid< 5),1,--,eval(calc_bonus_spell_calc(3,eval(WIS_score+WIS_scdam+WIS_scitm))-calc_bonus_spell_calc(3,eval(WIS_score+WIS_scdam))))&%
ifelse(eval(level_druid< 7),1,--,eval(calc_bonus_spell_calc(4,eval(WIS_score+WIS_scdam+WIS_scitm))-calc_bonus_spell_calc(4,eval(WIS_score+WIS_scdam))))&%
ifelse(eval(level_druid< 9),1,--,eval(calc_bonus_spell_calc(5,eval(WIS_score+WIS_scdam+WIS_scitm))-calc_bonus_spell_calc(5,eval(WIS_score+WIS_scdam))))&%
ifelse(eval(level_druid<11),1,--,eval(calc_bonus_spell_calc(6,eval(WIS_score+WIS_scdam+WIS_scitm))-calc_bonus_spell_calc(6,eval(WIS_score+WIS_scdam))))&%
ifelse(eval(level_druid<13),1,--,eval(calc_bonus_spell_calc(7,eval(WIS_score+WIS_scdam+WIS_scitm))-calc_bonus_spell_calc(7,eval(WIS_score+WIS_scdam))))&%
ifelse(eval(level_druid<15),1,--,eval(calc_bonus_spell_calc(8,eval(WIS_score+WIS_scdam+WIS_scitm))-calc_bonus_spell_calc(8,eval(WIS_score+WIS_scdam))))&%
ifelse(eval(level_druid<17),1,--,eval(calc_bonus_spell_calc(9,eval(WIS_score+WIS_scdam+WIS_scitm))-calc_bonus_spell_calc(9,eval(WIS_score+WIS_scdam))))%
\\ \hline
\end{tabular}\\[1ex]
%
define(`wild_shape_count_knowledge', eval(dnl
(show_knowledge_arcana    != 0) + dnl
(show_knowledge_engineer  != 0) + dnl
(show_knowledge_dungeon   != 0) + dnl
(show_knowledge_geography != 0) + dnl
(show_knowledge_history   != 0) + dnl
(show_knowledge_local     != 0) + dnl
(show_knowledge_nature    != 0) + dnl
(show_knowledge_nobility  != 0) + dnl
(show_knowledge_religion  != 0) + dnl
(show_knowledge_planes    != 0)))dnl
define(`wild_shape_count_profession', eval(dnl
(show_prof_farmer         != 0) + dnl
(show_prof_herbalist      != 0) + dnl
(show_prof_herder         != 0) + dnl
(show_prof_hunter         != 0)))dnl
\small
\begin{tabular}{|c||*{eval(12 + wild_shape_count_knowledge + wild_shape_count_profession)}{r|}}
\hline
% & \multicolumn{eval(12 + wild_shape_count_knowledge + wild_shape_count_profession)}{c|}{Skills} \\ \hline
%
\shortstack{Will\\Save} & 
\multicolumn{1}{c|}{\shortstack{Apr\\ais}} & 
\multicolumn{1}{c|}{\shortstack{Bl\\uff}} & 
\multicolumn{1}{c|}{\shortstack{Dcf\\Scr}} & 
\multicolumn{1}{c|}{\shortstack{Dpl\\mcy}} & 
\multicolumn{1}{c|}{\shortstack{Dis\\gs}} & 
\multicolumn{1}{c|}{\shortstack{Hndl\\Anm}} & 
\multicolumn{1}{c|}{\shortstack{He\\al}} & 
\multicolumn{1}{c|}{\shortstack{Int\\mid}} & 
ifelse(eval(show_knowledge_arcana    != 0), 1, \multicolumn{1}{c|}{\shortstack{Knw\\Arc}} & )dnl
ifelse(eval(show_knowledge_engineer  != 0), 1, \multicolumn{1}{c|}{\shortstack{Knw\\Eng}} & )dnl
ifelse(eval(show_knowledge_dungeon   != 0), 1, \multicolumn{1}{c|}{\shortstack{Knw\\Dgn}} & )dnl
ifelse(eval(show_knowledge_geography != 0), 1, \multicolumn{1}{c|}{\shortstack{Knw\\Geo}} & )dnl
ifelse(eval(show_knowledge_history   != 0), 1, \multicolumn{1}{c|}{\shortstack{Knw\\Hst}} & )dnl
ifelse(eval(show_knowledge_local     != 0), 1, \multicolumn{1}{c|}{\shortstack{Knw\\Loc}} & )dnl
ifelse(eval(show_knowledge_nature    != 0), 1, \multicolumn{1}{c|}{\shortstack{Knw\\Nat}} & )dnl
ifelse(eval(show_knowledge_nobility  != 0), 1, \multicolumn{1}{c|}{\shortstack{Knw\\Nob}} & )dnl
ifelse(eval(show_knowledge_religion  != 0), 1, \multicolumn{1}{c|}{\shortstack{Knw\\Rlg}} & )dnl
ifelse(eval(show_knowledge_planes    != 0), 1, \multicolumn{1}{c|}{\shortstack{Knw\\Pln}} & )dnl
ifelse(eval(show_prof_farmer         != 0), 1, \multicolumn{1}{c|}{\shortstack{Prf\\Frm}} & )dnl
ifelse(eval(show_prof_herbalist      != 0), 1, \multicolumn{1}{c|}{\shortstack{Prf\\Hrb}} & )dnl
ifelse(eval(show_prof_herder         != 0), 1, \multicolumn{1}{c|}{\shortstack{Prf\\Hrd}} & )dnl
ifelse(eval(show_prof_hunter         != 0), 1, \multicolumn{1}{c|}{\shortstack{Prf\\Hnt}} & )dnl
\multicolumn{1}{c|}{\shortstack{Sr\\ch}} & 
\multicolumn{1}{c|}{\shortstack{Sns\\Mtv}} & 
\multicolumn{1}{c|}{\shortstack{Spl\\crft}} \\
\hline
eval(save_will_base + calc_ability_mod(WIS_score + WIS_scdam) + save_will_misc) & 
emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) + rank_appraise        + bonus_appraise        + bonus_skills_global     )) & 
emph_sign(eval(calc_ability_mod(CHA_score + CHA_scdam) + rank_bluff           + bonus_bluff           + bonus_skills_global     )) & 
emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) + rank_decipher_script + bonus_decipher_script + bonus_skills_global     )) & 
emph_sign(eval(calc_ability_mod(CHA_score + CHA_scdam) + rank_diplomacy       + bonus_diplomacy       + bonus_skills_global     )) & 
emph_sign(eval(calc_ability_mod(CHA_score + CHA_scdam) + rank_disguise        + bonus_disguise        + bonus_skills_global + 10)) & 
emph_sign(eval(calc_ability_mod(CHA_score + CHA_scdam) + rank_handle_animal   + bonus_handle_animal   + bonus_skills_global     )) & 
emph_sign(eval(calc_ability_mod(WIS_score + WIS_scdam) + rank_heal            + bonus_heal            + bonus_skills_global     )) & 
emph_sign(eval(calc_ability_mod(CHA_score + CHA_scdam) + rank_intimidate      + bonus_intimidate      + bonus_skills_global     )) & 
ifelse(eval(show_knowledge_arcana    !=0), 1, `emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) + rank_knowledge_arcana    + bonus_knowledge_arcana    + bonus_skills_global))' & )dnl
ifelse(eval(show_knowledge_engineer  !=0), 1, `emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) + rank_knowledge_engineer  + bonus_knowledge_engineer  + bonus_skills_global))' & )dnl
ifelse(eval(show_knowledge_dungeon   !=0), 1, `emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) + rank_knowledge_dungeon   + bonus_knowledge_dungeon   + bonus_skills_global))' & )dnl
ifelse(eval(show_knowledge_geography !=0), 1, `emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) + rank_knowledge_geography + bonus_knowledge_geography + bonus_skills_global))' & )dnl
ifelse(eval(show_knowledge_history   !=0), 1, `emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) + rank_knowledge_history   + bonus_knowledge_history   + bonus_skills_global))' & )dnl
ifelse(eval(show_knowledge_local     !=0), 1, `emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) + rank_knowledge_local     + bonus_knowledge_local     + bonus_skills_global))' & )dnl
ifelse(eval(show_knowledge_nature    !=0), 1, `emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) + rank_knowledge_nature    + bonus_knowledge_nature    + bonus_skills_global))' & )dnl
ifelse(eval(show_knowledge_nobility  !=0), 1, `emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) + rank_knowledge_nobility  + bonus_knowledge_nobility  + bonus_skills_global))' & )dnl
ifelse(eval(show_knowledge_religion  !=0), 1, `emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) + rank_knowledge_religion  + bonus_knowledge_religion  + bonus_skills_global))' & )dnl
ifelse(eval(show_knowledge_planes    !=0), 1, `emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) + rank_knowledge_planes    + bonus_knowledge_planes    + bonus_skills_global))' & )dnl
ifelse(eval(show_prof_farmer         !=0), 1, `emph_sign(eval(calc_ability_mod(WIS_score + WIS_scdam) + rank_prof_farmer         + bonus_prof_farmer         + bonus_skills_global))' & )dnl
ifelse(eval(show_prof_herbalist      !=0), 1, `emph_sign(eval(calc_ability_mod(WIS_score + WIS_scdam) + rank_prof_herbalist      + bonus_prof_herbalist      + bonus_skills_global))' & )dnl
ifelse(eval(show_prof_herder         !=0), 1, `emph_sign(eval(calc_ability_mod(WIS_score + WIS_scdam) + rank_prof_herder         + bonus_prof_herder         + bonus_skills_global))' & )dnl
ifelse(eval(show_prof_hunter         !=0), 1, `emph_sign(eval(calc_ability_mod(WIS_score + WIS_scdam) + rank_prof_hunter         + bonus_prof_hunter         + bonus_skills_global))' & )dnl
emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) + rank_search          + bonus_search          + bonus_skills_global     )) &
emph_sign(eval(calc_ability_mod(WIS_score + WIS_scdam) + rank_sense_motive    + bonus_sense_motive    + bonus_skills_global     )) &
emph_sign(eval(calc_ability_mod(INT_score + INT_scdam) + rank_spellcraft      + bonus_spellcraft      + bonus_skills_global     )) \\
\hline
\end{tabular}\\[1ex]
\normalsize
%
wild_shape_individuals`'ifelse(wild_shape_individuals,,,[1ex]) %
%
\small
%
\tablehead{\hline
\multicolumn{ifelse(wild_shape_show_known_only,1,5,6)}{|c||}{} & \multicolumn{2}{c||}{Saves} & \multicolumn{11}{c||}{Skills} & \\ \hline
ifelse(wild_shape_show_known_only,1,,` & ')dnl
Shape & 
\shortstack{pa\\ge} & 
\shortstack{$\Delta$\\HP} & 
\shortstack{$\Delta$\\OB} & 
\shortstack{In\\it} & 
\shortstack{Fo\\rt} & 
\shortstack{Rf\\lx} & 
\multicolumn{1}{c|}{\shortstack{Bal\\anc}} &
\multicolumn{1}{c|}{\shortstack{Cli\\mb}} &
\multicolumn{1}{c|}{\shortstack{Co\\nc}} &
\multicolumn{1}{c|}{\shortstack{Esc\\Art}} &
\multicolumn{1}{c|}{\shortstack{Hi\\de}} &
\multicolumn{1}{c|}{\shortstack{Ju\\mp}} &
\multicolumn{1}{c|}{\shortstack{Lis\\ten}} &
\multicolumn{1}{c|}{\shortstack{Mv\\Slnt}} &
\multicolumn{1}{c|}{\shortstack{Sp\\ot}} &
\multicolumn{1}{c|}{\shortstack{Sw\\im}} &
\multicolumn{1}{c||}{\shortstack{Sur\\viv}} &
dnl \multicolumn{1}{c||}{\shortstack{Tm\\ble}} &
\shortstack{Sv\\DC} \\ \hline \hline}%
%
\tabletail{\hline}%
\tablelasttail{}%
%
\begin{supertabular}{|ifelse(wild_shape_show_known_only,1,,`r@{\hspace*{0.5mm}}')l|r|r|r|r||c|c||*{11}{r|}|c|}
wild_shape_table_entries
\end{supertabular}')

