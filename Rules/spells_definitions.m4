

dnl ***** abbreviations used for rulebooks are given in file defaults.m4


dnl register information about spells
dnl
dnl description: cone shape and emanation: PHB, p.175


define(`chosen_domains', downcase(char_domains))


dnl special components:
dnl   CF : Coldfire
dnl   FF : Frostfell Environment
dnl   R  : Ritual
define(`process_material_component', `ifelse(dnl
regexp($1,`^A'),0,`ifelse(type_caster,A,`process_material_component(regexp($1, `^A\(.*\)$', `\1'))')',dnl some (material) components are only necessary for arcane casters
regexp($1,`^ME'),0,`regexp($1,^ME( *\(.*\)),`M:eval(\1)')',dnl expensive material component
regexp($1,`^FE'),0,`regexp($1,^FE( *\(.*\)),`F`'ifelse(eval(\1),0,!)')',dnl expensive focus
regexp($1,`^DC'),0,`regexp($1,^DC( *\(.*\)),`DC:\1')',dnl DC for casting epic spells
$1,DF,`ifelse(type_caster,D,DF,)',dnl divine focus does only have to show up for divine spell users
$1,M,`ifdef(`feat_eschew_materials',,M)',dnl leave out simple material component by feat
$1,V,`ifdef(`feat_silent_spell',v,V)',dnl show downcased V if verbal component can be omitted by feat
$1,S,`ifdef(`feat_still_spell',s,S)',dnl show downcased S if somatic component can be omitted by feat
$1)')


dnl Abbreviations
dnl
dnl Schools (and Sub-Schools) of Magic:
dnl     Abjr
dnl     Conj (Call,Crea,Heal,Summ,Tele)
dnl     Divn (Scry)
dnl     Ench (Chrm,Comp)
dnl     Evoc
dnl     Ills (Figm,Glam,Patt,Phan,Shdw)
dnl     Necr
dnl     Trns
dnl     Univ
dnl
dnl Descriptors
dnl     Acid Air Chaos Cold Dark Death Earth Elec Evil Fear Fire Force Good Lang Law Light Mind Sonic Water
dnl     Planar (c.f. MOP, p.32 f.)
dnl     Varies (e.g. for alignments)

dnl arguments: Name of Spell, Name and Page of Rulebook, School of Magic, Sub-School of Magic, Descriptors, Component List, Casting Time, Range, Duration, Area of Effect, Description
define(`spell_line', `dnl
dnl
define(`level_caster', eval(level_caster_base + dnl the caster level may be subject to several modification ...
ifelse(eval((regexp(chosen_domains,      `\<good\>') >= 0)  &&  (regexp($5,  `\<Good\>') >= 0)              ),1,1,0) + dnl Clerics with Good domain cast spells with Good descriptor at +1 caster level
ifelse(eval((regexp(chosen_domains,      `\<evil\>') >= 0)  &&  (regexp($5,  `\<Evil\>') >= 0)              ),1,1,0) + dnl same for other alignment domains
ifelse(eval((regexp(chosen_domains,       `\<law\>') >= 0)  &&  (regexp($5,   `\<Law\>') >= 0)              ),1,1,0) + dnl
ifelse(eval((regexp(chosen_domains,     `\<chaos\>') >= 0)  &&  (regexp($5, `\<Chaos\>') >= 0)              ),1,1,0) + dnl
ifelse(eval((regexp(chosen_domains,   `\<healing\>') >= 0)  &&  ifelse($3,Conj,1,0)  &&  ifelse($4,Heal,1,0)),1,1,0) + dnl Clerics with Healing domain cast healing spells at +1 caster level
ifelse(eval((regexp(chosen_domains, `\<knowledge\>') >= 0)  &&  ifelse($3,Divn,1,0)                         ),1,1,0) + dnl Clerics with Knowledge domain cast divination spells at +1 caster level
ifelse(eval(ifdef(`feat_charnel_miasma',    1,0)  &&  (regexp($5, `\<Death\>') >= 0)              ),1,1,0) + dnl some Reserve Feat secondary benefits
ifelse(eval(ifdef(`feat_holy_warrior',      1,0)  &&  (regexp($5, `\<Force\>') >= 0)              ),1,1,0) + dnl
ifelse(eval(ifdef(`feat_mitigate_suffering',1,0)  &&  ifelse($3,Conj,1,0)  &&  ifelse($4,Heal,1,0)),1,1,0) + dnl
ifelse(eval(ifdef(`feat_protective_ward',   1,0)  &&  ifelse($3,Abjr,1,0)                         ),1,1,0) + dnl
ifelse(eval(ifdef(`feat_touch_of_healing',  1,0)  &&  ifelse($3,Conj,1,0)  &&  ifelse($4,Heal,1,0)),1,1,0)   dnl
))dnl
dnl
define(`DC_mod', eval(eval(regexp(        feat_spell_focus, `\<$3\>') >= 0) + dnl check if Spell Focus Feat selected for given school
                      eval(regexp(feat_greater_spell_focus, `\<$3\>') >= 0) + dnl
                      eval(ifdef(`feat_cold_focus',        1,0)  &&  (regexp($5,`\<Cold\>') >= 0)) + dnl boost spells with cold descriptor by (Greater) Cold Focus Feat
                      eval(ifdef(`feat_greater_cold_focus',1,0)  &&  (regexp($5,`\<Cold\>') >= 0))))dnl
dnl
define(`material_components', patsubst($6, `\<\([^ ]+\)\>', `process_material_component(\1)'))dnl
dnl
dnl now start printing with LaTeX ...
\mbox{}\hspace*{\spelllineindent}\parbox[t]{\spelllinewidth}{\setlength{\parindent}{-\spelllineindent}dnl
\textbf{ifelse(eval(dnl
(ifelse(alignment_LC,C,1,0)  &&  (regexp($5,   `\<Law\>') >= 0)) || dnl chaotic aligned caster cannot use lawful spells
(ifelse(alignment_LC,L,1,0)  &&  (regexp($5, `\<Chaos\>') >= 0)) || dnl same for other opposing alignments
(ifelse(alignment_GE,G,1,0)  &&  (regexp($5,  `\<Evil\>') >= 0)) || dnl
(ifelse(alignment_GE,E,1,0)  &&  (regexp($5,  `\<Good\>') >= 0)) || dnl
(regexp(material_components,M:0) >= 0) || dnl check missing material component
(regexp(material_components,F!)  >= 0) dnl check missing focus
),0,$1,\textcolor{shade}{$1})} dnl Spell Name (eventually shaded if spell (currently) unusable)
{\tiny ($2)} dnl Handbook and Page
\textbf{C:} patsubst(material_components, `\> +\<', `,') dnl Components
ifelse($7,,,`\textbf{T:} $7') dnl Casting Time
ifelse($8,,,`\textbf{R:} $8`'ifelse(regexp(`$8',`^range_\(.+\)$',`ifelse(\1,close,0,\1,medium,0,\1,long,0,-1)'),0,`ifdef(`feat_enlarge_spell',`${}^{1}{}$',)',)') dnl Range
ifelse($9,,,`\textbf{D:} $9') dnl Duration
ifelse($10,,,`\textbf{A:} $10') dnl Area of Effect
ifelse(eval(DC_mod != 0),1,`\textbf{DC:} emph_sign(DC_mod)') dnl save DC modifier according to (Greater) Spell Focus Feat and similar effects
ifelse(`$11',,,`\textbf{E:} $11')`'dnl Description of Effect
{}\rule[-0.75ex]{0mm}{0.75ex}}\\')


dnl Arguments:
dnl   class name token
dnl   human-readable class name
dnl   spell level
dnl   ability modifier
define(`spell_headline', `\framebox[\textwidth][l]{\textbf{$2 Spells Level $3:}\hspace*{2cm}calc_spells_per_day($1,$3)`'ifelse($1,cleric,ifelse($3,0,,+1),$1,templeraider,+1) per day\hspace*{2cm}DC eval(10 + $3 + $4)`'ifelse($1,sorcerer,\hspace*{2cm}known_spells_sorcerer($3) spells known,$1,bard,\hspace*{2cm}known_spells_bard($3) spells known,)`'\hfill ifelse(type_caster, A, Spell Failure: arcane_error\%, \mbox{})}\\
spells_$1_$3')


dnl Epic Feat "Improved Spell Capacity" can grant spell slots at levels above the maximum possible for a spell casting class
dnl Arguments:
dnl   class name token
dnl   human-readable class name
dnl   1st spell level above the usual class maximum
dnl   ability modifier
define(`spells_above_max_level', `ifelse(regexp(feat_improved_spell_capacity, `$1_$3'),-1, %,`spell_headline($1, $2, $3, $4)
spells_above_max_level($1, $2, eval($3 + 1), $4)')')



define(`range_you',          `you')dnl
define(`range_touch',        `T')dnl
define(`range_close',        `eval( 25 +  5 * (level_caster / 2))~ft')dnl
define(`range_medium',       `eval(100 + 10 *  level_caster     )~ft')dnl
define(`range_long',         `eval(400 + 40 *  level_caster     )~ft')dnl
define(`duration_permanent', `P')
define(`attack_touch_melee',  emph_sign(eval(bonus_attack_base + bonus_attack_epic + stat_size_attack_mod(stat_size) + ifdef(`feat_weapon_finesse', `ifelse(eval(DEX >= STR),1,DEX,STR)', STR))))dnl
define(`attack_touch_ranged', emph_sign(eval(bonus_attack_base + bonus_attack_epic + stat_size_attack_mod(stat_size) + DEX)))dnl



dnl spells from the Players Handbook

define(`spell_acid_fog', `spell_line(`Acid Fog',
	PHB 196, Conj, Crea, Acid, V S AM DF,, `range_medium', `{level_caster}~rnd.', `20-ft radius 20-ft height spread',
	`fog slows\komma obscures sight and deals 2D6 acid damage')')
define(`spell_acid_splash', `spell_line(`Acid Splash',
	PHB 196, Conj, Crea, Acid, V S,, `range_close',,,
	`attack_touch_ranged ranged touch attack deals 1D3 acid damage')')
define(`spell_aid', `spell_line(`Aid',
	PHB 196, Ench, Comp, Mind, V S DF,, `range_touch', `{level_caster}~min.',,
	`+1 moral on attacks and saves against fear, 1D8+calc_min(level_caster,10) temporary hits')')
define(`spell_air_walk', `spell_line(`Air Walk',
	PHB 196, Trns,, Air, V S DF,, `range_touch', `eval(level_caster * 10)~min.',,
	`walk through air up to 45 degree angle')')
define(`spell_alarm', `spell_line(`Alarm',
	PHB 197, Abjr,,, V S AF DF,, `range_close', `eval(level_caster * 2)~h.', `20-ft radius emanation',
	`mental or audible alarm when area is entered')')
define(`spell_align_weapon', `spell_line(`Align Weapon',
	PHB 197, Trns,, Varies, V S DF,, `range_touch', `{level_caster}~min.',,
	`imbue one weapon (not natural attack) with alignment')')
define(`spell_alter_self', `spell_line(`Alter Self',
	PHB 197, Trns,,, V S,, `range_you', `eval(level_caster * 10)~min.~D',,
	`target form: same type, within one size category, max.~`'calc_min(level_caster,5)~HD\komma gain some qualities')')
define(`spell_analyze_dweomer', `spell_line(`Analyze Dweomer',
	PHB 197, Divn,,, V S FE(spellfocus_analyze_dweomer),, `range_close', `{level_caster}~rnd.~D',,
	`discern all spells and magical properties within one creature or object per round')')
define(`spell_animal_growth', `spell_line(`Animal Growth',
	PHB 198, Trns,,, V S,, `range_medium', `{level_caster}~min.',,
	`eval(level_caster / 2) animals grow by one size category (MOM~I p.291)')')
define(`spell_animal_messenger', `spell_line(`Animal Messenger',
	PHB 198, Ench, Comp, Mind, V S M,, `range_close', `{level_caster}~d.',,
	`tiny animal')')
define(`spell_animal_shapes', `spell_line(`Animal Shapes',
	PHB 198, Trns,,, V S DF,, `range_close', `{level_caster}~h.~D',,
	`{level_caster} willing targets polymorph into the same kind of animal of HD: the lower of calc_min(level_caster,20) or the target subject\aps s HD')')
define(`spell_animal_trance', `spell_line(`Animal Trance',
	PHB 198, Ench, Comp, Mind Sonic, V S,, `range_close', `C',,
	`2D6 HD of animals or magical beasts with {I}{N}{T} 1 or 2')')
define(`spell_animate_dead', `spell_line(`Animate Dead',
	PHB 198, Necr,, Evil, V S ME(spellmaterial_animate_dead),, `range_touch',,,
	`raise up to eval(level_caster * 2)~HD of skeletons or zombies')')
define(`spell_animate_objects', `spell_line(`Animate Objects',
	PHB 199, Trns,,, V S,, `range_medium', `{level_caster}~rnd.',,
	`animate {level_caster} up to small size objects\komma medium size counts as two\komma etc.')')
define(`spell_animate_plants', `spell_line(`Animate Plants',
	PHB 199, Trns,,, V,, `range_close', `varies',,
	`eval(level_caster / 3) up to large size plants (huge size count as two\komma etc.) animate for {level_caster}~rnd. or all plants in range entangle for {level_caster}~h.')')
define(`spell_animate_rope', `spell_line(`Animate Rope',
	PHB 199, Trns,,, V S,, `range_medium', `{level_caster}~rnd.',,
	`control up to eval(50 + 5 * level_caster)~ft length and 1 inch diameter (variable by ratio)')')
define(`spell_antilife_shell', `spell_line(`Antilife Shell',
	PHB 199, Abjr,,, V S DF, `1~rnd.', `', `eval(level_caster * 10)~min.~D', `10~ft radius emanation mobile centered on you',
	`prevent living creatures from entering')')
define(`spell_antimagic_field', `spell_line(`Antimagic Field',
	PHB 200, Abjr,,, V S AM DF,, `', `eval(level_caster * 10)~min.~D', `10-ft radius emanation mobile centered on you',
	`supress magic')')
define(`spell_antipathy', `spell_line(`Antipathy',
	PHB 200, Ench, Comp, Mind, V S AM DF, `1~h.', `range_close', `eval(level_caster * 2)~h.~D', `one object or eval(level_caster * 1000) cb.ft area',
	`repel specific creatures')')
define(`spell_antiplant_shell', `spell_line(`Antiplant Shell',
	PHB 200, Abjr,,, V S DF,, `', `eval(level_caster * 10)~min.~D', `10-ft radius emanation mobile centered on you',
	`hedge out plant creatures and animated plants')')
define(`spell_arcane_eye', `spell_line(`Arcane Eye',
	PHB 200, Divn, Scry,, V S M, `10~min.', `$\infty$', `{level_caster}~min.~CD',,
	`recieve visual information from magical sensor\komma move up to 30~ft per round')')
define(`spell_arcane_lock', `spell_line(`Arcane Lock',
	PHB 200, Abjr,,, V S ME(spellmaterial_arcane_lock),, `range_touch', `duration_permanent',,
	`lock one door\komma chest or portal\komma you can pass freely')')
define(`spell_arcane_mark', `spell_line(`Arcane Mark',
	PHB 201, Univ,,, V S,, `0~ft', `duration_permanent',,
	`inscribe visible or invisible mark onto surface')')
define(`spell_arcane_sight', `spell_line(`Arcane Sight',
	PHB 201, Divn,,, V S,, `range_you', `{level_caster}~min.~D',,
	`see magical auras within 120~ft\komma can learn more info')')
define(`spell_arcane_sight_greater', `spell_line(`Arcane Sight\komma Greater',
	PHB 201, Divn,,, V S,, `range_you', `{level_caster}~min.~D',,
	`see magical auras within 120~ft\komma automatically learn active spells or effects\komma can learn more info')')
define(`spell_astral_projection', `spell_line(`Astral Projection',
	PHB 201, Necr,, Planar, V S ME(spellmaterial_astral_projection), `30~min.', `range_touch', `varies',,
	`you and eval(level_caster / 2) targets spiritually travel to the Astral Plane and can therefrom reach any other plane forming new bodies')')
define(`spell_atonement', `spell_line(`Atonement',
	PHB 201, Abjr,,, V S M FE(spellfocus_atonement) DF XP, `1~h.', `range_touch',,,
	`remove burden of alignment offending deeds from subject or offer alignment change')')
define(`spell_augury', `spell_line(`Augury',
	PHB 202, Divn,,, V S ME(spellmaterial_augury) FE(spellfocus_augury), `1~min.', `range_you',,,
	`eval(70 + calc_min(level_caster,20))\% chance to recieve information about consequences (within $\approx${}1/2~h.) of some intended action')')
define(`spell_awaken', `spell_line(`Awaken',
	PHB 202, Trns,,, V S DF XP, `24~h.', `range_touch',,,
	`raise animal or tree to sentience')')
define(`spell_baleful_polymorph', `spell_line(`Baleful Polymorph',
	PHB 202, Trns,,, V S,, `range_close', `duration_permanent',,
	`turns one creature into animal\komma eventually changes special abilities too')')
define(`spell_bane', `spell_line(`Bane',
	PHB 203, Ench, Comp, Fear Mind, V S DF,, `', `{level_caster}~min.', `50-ft radius burst centered on you',
	`enemies take -1 on attack rolls and saves against fear')')
define(`spell_banishment', `spell_line(`Banishment',
	PHB 203, Abjr,, Planar, V S AF,, `range_close',,,
	`up to eval(level_caster * 2)~HD of extraplanar creatures are sent home')')
define(`spell_barkskin', `spell_line(`Barkskin',
	PHB 203, Trns,,, V S DF,, `range_touch', `eval(level_caster * 10)~min.',,
	`+calc_min(eval(2 + ((calc_max(level_caster, 3) - 3) / 3)), 5) natural armor bonus')')
define(`spell_bears_endurance', `spell_line(`Bear\aps{}s Endurance',
	PHB 203, Trns,,, V S DF,, `range_touch', `{level_caster}~min.',,
	`+4 C{}O{}N score')')
define(`spell_bears_endurance_mass', `spell_line(`Bear\aps{}s Endurance\komma Mass',
	PHB 203, Trns,,, V S DF,, `range_close', `{level_caster}~min.',,
	`+4 C{}O{}N score for {level_caster} targets')')
define(`spell_bestow_curse', `spell_line(`Bestow Curse',
	PHB 203, Necr,,, V S,, `range_touch', `duration_permanent',,
	`-6 to one ability score \textbf{or} -4 to all attack rolls\komma saves\komma ability checks and skill checks \textbf{or} 50\% of no action each turn')')
define(`spell_bigbys_clenched_fist', `spell_line(`Bigby\aps s Clenched Fist',
	PHB 203, Evoc,, Force, V S AF DF,, `range_medium', `{level_caster}~rnd.~D',,
	`large hand keeps one foe at bay and pushes him or slams')')
define(`spell_bigbys_crushing_hand', `spell_line(`Bigby\aps s Crushing Hand',
	PHB 203, Evoc,, Force, V S AM AF DF,, `range_medium', `{level_caster}~rnd.~D',,
	`large hand keeps one foe at bay and pushes or grapples or crushes him')')
define(`spell_bigbys_forceful_hand', `spell_line(`Bigby\aps s Forceful Hand',
	PHB 204, Evoc,, Force, V S F,, `range_medium', `{level_caster}~rnd.~D',,
	`large hand keeps one foe at bay and pushes him')')
define(`spell_bigbys_grasping_hand', `spell_line(`Bigby\aps s Grasping Hand',
	PHB 204, Evoc,, Force, V S AF DF,, `range_medium', `{level_caster}~rnd.~D',,
	`large hand keeps one foe at bay and pushes or grapples him')')
define(`spell_bigbys_interposing_hand', `spell_line(`Bigby\aps s Interposing Hand',
	PHB 204, Evoc,, Force, V S F,, `range_medium', `{level_caster}~rnd.~D',,
	`large hand keeps one foe at bay')')
define(`spell_binding', `spell_line(`Binding',
	PHB 204, Ench, Comp, Mind, V S ME(spellmaterial_binding), `1~min.', `range_close', `varies~D',,
	`hold one living creature')')
define(`spell_blade_barrier', `spell_line(`Blade Barrier',
	PHB 205, Evoc,, Force, V S, `range_medium', `{level_caster}~min.~D', `eval(level_caster * 20)~ft long wall or eval(5 * (level_caster / 2))~ft radius ring, 20~ft high',
	`wall or ring of blades of force deal calc_min(level_caster,15)`'D6')')
define(`spell_blasphemy', `spell_line(`Blasphemy',
	PHB 205, Evoc,, Evil Sonic Planar, V,, `',, `40~ft radius spread centered on you',
	`any nonevil creature is cumulatively dazed ($\le${level_caster}~HD)\komma weakened ($\le${eval(level_caster - 1)}~HD)\komma paralyzed ($\le${eval(level_caster - 5)}~HD) and killed ($\le${eval(level_caster - 10)}~HD) and extraplanar creatures are banished')')
define(`spell_bless', `spell_line(`Bless',
	PHB 205, Ench, Comp, Mind, V S DF,, `', `{level_caster}~min.', `50-ft radius burst centered on you',
	`you \& allies gain +1 moral on attacks and saves against fear')')
define(`spell_bless_water', `spell_line(`Bless Water',
	PHB 205, Trns,, Good, V S ME(spellmaterial_bless_water), `1~min.', `range_touch',,,
	`create 1 flask of holy water')')
define(`spell_bless_weapon', `spell_line(`Bless Weapon',
	PHB 205, Trns,,, V S,, `range_touch', `{level_caster}~min.',,
	`weapon treated as +1 and good against damage reduction and criticals always succeed')')
define(`spell_blight', `spell_line(`Blight',
	PHB 206, Necr,,, V S DF,, `range_touch',,,
	`wither plant or deal calc_min(level_caster, 15)`'D6 damage to plant creature')')
define(`spell_blindness_deafness', `spell_line(`Blindness / Deafness',
	PHB 206, Necr,,, V,, `range_medium', `duration_permanent~D',,
	`render one living creature blinded or deafened')')
define(`spell_blink', `spell_line(`Blink',
	PHB 206, Trns,, Planar, V S,, `range_you', `{level_caster}~rnd.~D',,
	`you blink between the Material Plane and the Ethereal Plane\komma gain miss chances and more')')
define(`spell_blur', `spell_line(`Blur',
	PHB 206, Ills, Glam,, V,, `range_touch', `{level_caster}~min.~D',,
	`gain concealment (20\% miss chance)')')
define(`spell_break_enchantment', `spell_line(`Break Enchantment',
	PHB 207, Abjr,,, V S, `1~min.', `range_close',,,
	`free {level_caster} targets from enchantments, transmutations and curses, check: 1D20+calc_min(level_caster,15)')')
define(`spell_bulls_strength', `spell_line(`Bull\aps{}s Strength',
	PHB 207, Trns,,, V S AM DF,, `range_touch', `{level_caster}~min.',,
	`+4 S{}T{}R score')')
define(`spell_bulls_strength_mass', `spell_line(`Bull\aps{}s Strength\komma Mass',
	PHB 207, Trns,,, V S AM DF,, `range_close', `{level_caster}~min.',,
	`+4 S{}T{}R score for {level_caster} targets')')
define(`spell_burning_hands', `spell_line(`Burning Hands',
	PHB 207, Evoc,, Fire, V S,, `',, `15-ft cone shaped burst originating from you',
	`deal calc_min(level_caster,5)`'D4 fire damage')')
define(`spell_call_lightning', `spell_line(`Call Lightning',
	PHB 207, Evoc,, Elec, V S, `1~rnd.', `range_medium', `{level_caster}~min.', `5~ft wide and 30~ft high vertical lines',
	`calc_min(level_caster, 10) bolts\komma 3D6 electricity damage')')
define(`spell_call_lightning_storm', `spell_line(`Call Lightning Storm',
	PHB 207, Evoc,, Elec, V S, `1~rnd.', `range_long', `{level_caster}~min.', `5~ft wide and 30~ft high vertical lines',
	`calc_min(level_caster, 15) bolts\komma 5D6 electricity damage')')
define(`spell_calm_animals', `spell_line(`Calm Animals',
	PHB 207, Ench, Comp, Mind, V S,, `range_close', `{level_caster}~min.',,
	`2D4+{level_caster} HD of animals of same kind')')
define(`spell_calm_emotions', `spell_line(`Calm Emotions',
	PHB 207, Ench, Comp, Mind, V S DF,, `range_medium', `C~(max.~{level_caster}~rnd.)~D', `20-ft radius spread',
	`creatures are calmed\komma suppress: spell-granted moral boni\komma bardic-inspired courage\komma barbarian rage\komma fear and confusion')')
define(`spell_cats_grace', `spell_line(`Cat\aps{}s Grace',
	PHB 208, Trns,,, V S M,, `range_touch', `{level_caster}~min.',,
	`+4 D{}E{}X score')')
define(`spell_cats_grace_mass', `spell_line(`Cat\aps{}s Grace\komma Mass',
	PHB 208, Trns,,, V S M,, `range_close', `{level_caster}~min.',,
	`+4 D{}E{}X score for {level_caster} targets')')
define(`spell_cause_fear', `spell_line(`Cause Fear',
	PHB 208, Necr,, Fear Mind, V S,, `range_close', `varies',,
	`1 living target ($\le${}5~HD) frightened (1D4~rnd.) or shaken (1~rnd.)')')
define(`spell_chain_lightning', `spell_line(`Chain Lightning',
	PHB 208, Evoc,, Elec, V S F,, `range_long',,,
	`one primary target takes calc_min(level_caster,20)`'D6\komma up to calc_min(level_caster,20) secondary targets (30~ft from primary) each take half this amount')')
define(`spell_changestaff', `spell_line(`Changestaff',
	PHB 208, Trns,,, V S FE(spellfocus_changestaff), `1~rnd.', `range_touch', `{level_caster}~h.~D',,
	`prepared quarterstaff turns into huge treant')')
define(`spell_chaos_hammer', `spell_line(`Chaos Hammer',
	PHB 208, Evoc,, Chaos, V S,, `range_medium', `varies', `20-ft radius burst',
	`deal calc_min(eval(level_caster / 2),5)`'D8 to lawful creatures (calc_min(level_caster,10)`'D6 to lawful outsiders) and slow them for 1D6 rounds\komma creatures neutral on the law-chaos-axis take half damage and are not slowed')')
define(`spell_charm_animal', `spell_line(`Charm Animal',
	PHB 208, Ench, Chrm, Mind, V S,, `range_close', `{level_caster}~h.',,
	`one animal gains friendly attitude')')
define(`spell_charm_monster', `spell_line(`Charm Monster',
	PHB 209, Ench, Chrm, Mind, V S,, `range_close', `{level_caster}~d.',,
	`one living creature gains friendly attitude')')
define(`spell_charm_monster_mass', `spell_line(`Charm Monster\komma Mass',
	PHB 209, Ench, Chrm, Mind, V,, `range_close', `{level_caster}~d.',,
	`eval(level_caster * 2)~HD of living creatures (always at least one creature) gain friendly attitude')')
define(`spell_charm_person', `spell_line(`Charm Person',
	PHB 209, Ench, Chrm, Mind, V S,, `range_close', `{level_caster}~h.',,
	`one humanoid creature gains friendly attitude')')
define(`spell_chill_metal', `spell_line(`Chill Metal',
	PHB 209, Trns,, Cold, V S DF,, `range_close', `7~rnd.',,
	`metal of eval(level_caster / 2) creatures or eval(level_caster * 25)~lbs.~deal cold damage upon touch')')
define(`spell_chill_touch', `spell_line(`Chill Touch',
	PHB 209, Necr,,, V S,, `range_touch',,,
	`attack_touch_melee melee touch ({level_caster} attacks) deals 1D6 damage and 1 strength damage\komma undead instead flee for 1D4+{level_caster}~rnd.')')
define(`spell_circle_of_death', `spell_line(`Circle of Death',
	PHB 209, Necr,, Death, V S ME(spellmaterial_circle_of_death),, `range_medium',, `40-ft radius burst',
	`slay calc_min(level_caster,20)`'D4 HD of living creatures with less than 9~HD')')
define(`spell_clairaudience_clairvoyance', `spell_line(`Clairaudience / Clairvoyance',
	PHB 209, Divn, Scry,, V S AF DF, `10~min.', `range_long', `{level_caster}~min.~D',,
	`hear \textbf{or} see from designated immobile point\komma can rotate sight')')
define(`spell_cloak_of_chaos', `spell_line(`Cloak of Chaos',
	PHB 210, Abjr,, Chaos, V S FE(spellfocus_cloak_of_chaos),, `', `{level_caster}~rnd.~D', `20-ft radius burst centered on you',
	`protect {level_caster} targets: +4 deflect AC\komma +4 saves\komma SR 25 against lawful spells and spells from lawful creatures\komma block mental influence\komma confusion against melee-attacking lawful creature')')
define(`spell_clone', `spell_line(`Clone',
	PHB 210, Necr,,, V S ME(spellmaterial_clone) FE(spellfocus_clone), `10~min.', `0~ft',,,
	`create duplicate of creature')')
define(`spell_cloudkill', `spell_line(`Cloudkill',
	PHB 210, Conj, Crea,, V S,, `range_medium', `{level_caster}~min.', `20~ft radius\komma 20~ft high cloud spread',
	`poisonous cloud moves 10~ft/rnd away\komma slay or deal 1D4 CON damage per round in cloud\komma according to target HD')')
define(`spell_color_spray', `spell_line(`Color Spray',
	PHB 210, Ills, Patt, Mind, V S M,, `',, `15-ft cone shaped burst originating from you',
	`cumulatively stun for 1~rnd.\komma blind ($\le${}4~HD) for 1D4 rnd.~and knock unconscious ($\le${}2~HD) for 2D4~rnd.')')
define(`spell_command', `spell_line(`Command',
	PHB 211, Ench, Comp, Lang Mind, V,, `range_close', `1~rnd.',,
	`give one living target one command of these: approach\komma drop\komma fall\komma flee or halt')')
define(`spell_command_greater', `spell_line(`Command\komma Greater',
	PHB 211, Ench, Comp, Lang Mind, V,, `range_close', `{level_caster}~rnd.',,
	`give {level_caster} living target one same command of these: approach\komma drop\komma fall\komma flee or halt')')
define(`spell_command_plants', `spell_line(`Command Plants',
	PHB 211, Trns,,, V,, `range_close', `{level_caster}~d.', `30-ft distance',
	`eval(level_caster * 2)`'HD of plant creatures gain friendly attitude')')
define(`spell_command_undead', `spell_line(`Command Undead',
	PHB 211, Necr,,, V S M,, `range_close', `{level_caster}~d.',,
	`one undead creature gains friendly attitude')')
define(`spell_commune', `spell_line(`Commune',
	PHB 211, Divn,, Planar, V S ME(spellmaterial_commune) DF XP, `10~min.', `range_you', `{level_caster}~rnd.',,
	`ask {level_caster} yes-no-questions to deity')')
define(`spell_commune_with_nature', `spell_line(`Commune with Nature',
	PHB 211, Divn,,, V S, `10~min.', `range_you',, `outdoor: {level_caster}~miles radius\komma underground: eval(level_caster * 100)~ft radius centered on you',
	`gain knowledge of three facts about surrounding nature')')
define(`spell_comprehend_languages', `spell_line(`Comprehend Languages',
	PHB 212, Divn,,, V S AM DF,, `range_you', `eval(level_caster * 10)~min.',,
	`must touch speaker or writing\komma listen and read only')')
define(`spell_cone_of_cold', `spell_line(`Cone of Cold',
	PHB 212, Evoc,, Cold, V S AM DF,, `',, `60-ft cone shaped burst originating from you',
	`deal calc_min(level_caster,15)`'D6 cold damage')')
define(`spell_confusion', `spell_line(`Confusion',
	PHB 212, Ench, Comp, Mind, V S AM DF,, `range_medium', `{level_caster}~rnd.', `15-ft radius burst',
	`confuse all creatures within area\komma roll each round for taken action')')
define(`spell_confusion_lesser', `spell_line(`Confusion\komma Lesser', dnl changed component DF to AM
	PHB 212, Ench, Comp, Mind, V S AM,, `range_close', `1~rnd.',,
	`confuse one living creature\komma roll for taken action')')
define(`spell_consecrate', `spell_line(`Consecrate',
	PHB 212, Evoc,, Good, V S ME(spellmaterial_consecrate) DF,, `range_close', `eval(level_caster * 2)~h.', `20-ft radius emanation',
	`bless area\komma +3 turn undead\komma -1 for undead\komma no undead creation or summoning')')
define(`spell_contact_other_plane', `spell_line(`Contact other Plane',
	PHB 212, Divn,, Planar, V, `10~min.', `range_you', `C',,
	`send your mind to retrieve answers from beings\komma max.~eval(level_caster / 2) questions')')
define(`spell_contagion', `spell_line(`Contagion',
	PHB 213, Necr,, Evil, V S,, `range_touch',,,
	`inflict living creature with desease')')
define(`spell_contingency', `spell_line(`Contingency',
	PHB 213, Evoc,,, V S M FE(spellfocus_contingency), `{}$\ge${}10~min.', `range_you', `{level_caster}~d.~D until used',,
	`store one up to calc_min(eval(level_caster / 3),6) level spell at you\komma set activation conditions')')
define(`spell_continual_flame', `spell_line(`Continual Flame',
	PHB 213, Evoc,, Light, V S ME(spellmaterial_continual_flame),, `range_touch', `duration_permanent',,
	`heatless flame radiates light like a torch')')
define(`spell_control_plants', `spell_line(`Control Plants',
	PHB 213, Trns,,, V S DF,, `range_close', `{level_caster}~min.', `30-ft distance',
	`control up to eval(level_caster * 2)~HD of plants creatures')')
define(`spell_control_undead', `spell_line(`Control Undead',
	PHB 214, Necr,,, V S M,, `range_close', `{level_caster}~min.', `30-ft distance',
	`control up to eval(level_caster * 2)~HD of undead')')
define(`spell_control_water', `spell_line(`Control Water',
	PHB 214, Trns,, Water, V S AM DF,, `range_long', `eval(level_caster * 10)~min.~D', `eval(level_caster * 10)~ft{ }$\times${ }`'eval(level_caster * 10)~ft area (S)',
	`raise or lower body of water by eval(level_caster * 2)~ft')')
define(`spell_control_weather', `spell_line(`Control Weather',
	PHB 214, Trns,,, V S, `10~min.',, `ifelse(token_caster,druid,2{}$\times${})`'4D12~h.', `ifelse(token_caster,druid,3,2)`'~mile radius stationary circle centered on you',
	`set weather conditions (takes another 10~min.) fitting the current season')')
define(`spell_control_winds', `spell_line(`Control Winds',
	PHB 214, Trns,, Air, V S,, `eval(level_caster * 40)~ft', `eval(level_caster * 10)~min.', `eval(level_caster * 40)~ft radius\komma 40~ft high cylinder\komma stationary',
	`alter wind by up to $\pm${}eval(level_caster / 3) levels\komma cf.~DMG p.95')')
define(`spell_create_food_water', `spell_line(`Create Food and Water',
	PHB 214, Conj, Crea,, V S, `10~min.', `range_close', `24~h.',,
	`food and water for eval(level_caster * 3) humans or {level_caster} horses')')
define(`spell_create_greater_undead', `spell_line(`Create Greater Undead',
	PHB 215, Necr,, Evil, V S ME(spellmaterial_create_greater_undead), `1~h.', `range_close',,,
	`create one Shadow`'ifelse(eval(level_caster >= 16),1,` or Wraith')`'ifelse(eval(level_caster >= 18),1,` or Spectre')`'ifelse(eval(level_caster >= 20),1,` or Devourer')')')
define(`spell_create_undead', `spell_line(`Create Undead',
	PHB 215, Necr,, Evil, V S ME(spellmaterial_create_undead), `1~h.', `range_close',,,
	`create one Ghoul`'ifelse(eval(level_caster >= 12),1,` or Ghast')`'ifelse(eval(level_caster >= 15),1,` or Mummy')`'ifelse(eval(level_caster >= 18),1,` or Mohrg')')')
define(`spell_create_water', `spell_line(`Create Water',
	PHB 215, Conj, Crea, Water, V S,, `range_close',,,
	`create eval(level_caster * 2) gallons of clear water')')
define(`spell_creeping_doom', `spell_line(`Creeping Doom',
	PHB 215, Conj, Summ,, V S, `1~rnd.', `range_close', `{level_caster}~min.',,
	`summon calc_min(eval(level_caster / 2),10) centipede swarms\komma control range: 100~ft\komma cf.~MOM~I p.238')')
define(`spell_crushing_despair', `spell_line(`Crushing Despair',
	PHB 215, Ench, Comp, Mind, V S M,,, `{level_caster}~min.', `30-ft cone shaped burst originating from you',
	`all creatures within area suffer -2 on attacks\komma saves\komma ability checks\komma skill checks and weapon damage rolls')')
define(`spell_cure_critical_wounds', `spell_line(`Cure Critical Wounds',
	PHB 215, Conj, Heal,, V S,, `range_touch',,,
	`heal 4D8+{calc_min(level_caster, 20)} points of damage')')
define(`spell_cure_critical_wounds_mass', `spell_line(`Cure Critical Wounds\komma Mass',
	PHB 215, Conj, Heal,, V S,, `range_close',, `30~ft distance',
	`heal 4D8+{calc_min(level_caster, 40)} points of damage for {level_caster} targets')')
define(`spell_cure_light_wounds', `spell_line(`Cure Light Wounds',
	PHB 215, Conj, Heal,, V S,, `range_touch',,,
	`heal 1D8+{calc_min(level_caster, 5)} points of damage')')
define(`spell_cure_light_wounds_mass', `spell_line(`Cure Light Wounds\komma Mass',
	PHB 216, Conj, Heal,, V S,, `range_close',, `30~ft distance',
	`heal 1D8+{calc_min(level_caster, 25)} points of damage for {level_caster} targets')')
define(`spell_cure_minor_wound', `spell_line(`Cure Minor Wound',
	PHB 216, Conj, Heal,, V S,, `range_touch',,,
	`heal 1 point of damage')')
define(`spell_cure_moderate_wounds', `spell_line(`Cure Moderate Wounds',
	PHB 216, Conj, Heal,, V S,, `range_touch',,,
	`heal 2D8+{calc_min(level_caster, 10)} points of damage')')
define(`spell_cure_moderate_wounds_mass', `spell_line(`Cure Moderate Wounds\komma Mass',
	PHB 216, Conj, Heal,, V S,, `range_close',, `30~ft distance',
	`heal 2D8+{calc_min(level_caster, 30)} points of damage for {level_caster} targets')')
define(`spell_cure_serious_wounds', `spell_line(`Cure Serious Wounds',
	PHB 216, Conj, Heal,, V S,, `range_touch',,,
	`heal 3D8+{calc_min(level_caster, 15)} points of damage')')
define(`spell_cure_serious_wounds_mass', `spell_line(`Cure Serious Wounds\komma Mass',
	PHB 216, Conj, Heal,, V S,, `range_close',, `30~ft distance',
	`heal 3D8+{calc_min(level_caster, 35)} points of damage for {level_caster} targets')')
define(`spell_curse_water', `spell_line(`Curse Water',
	PHB 216, Necr,, Evil, V S ME(spellmaterial_curse_water), `1~min.', `range_touch',,,
	`create 1 flask of unholy water')')



define(`spell_dancing_lights', `spell_line(`Dancing Lights',
	PHB 216, Evoc,, Light, V S,, `range_medium', `1~min.~D', `10-ft radius',
	`create four torch-like or one human-shaped light(s)')')
define(`spell_darkness', `spell_line(`Darkness',
	PHB 216, Evoc,, Dark, V AM DF,, `range_touch', `eval(level_caster * 10)~min.~D',,
	`20~ft radius around touched point, within concealment $\Rightarrow$ miss chance 20\%')')
define(`spell_darkvision', `spell_line(`Darkvision',
	PHB 216, Trns,,, V S M,, `range_touch', `{level_caster}~h.',,
	`target gains 60~ft range darkvision')')
define(`spell_daylight', `spell_line(`Daylight',
	PHB 216, Evoc,, Light, V S,, `range_touch', `eval(level_caster * 10)~min.~D',,
	`60~ft radius full-day illumination and further 60~ft dim light')')
define(`spell_daze', `spell_line(`Daze',
	PHB 217, Ench, Comp, Mind, V S M,, `range_close', `1~rnd.',,
	`one humanoid target of 4~HD or less takes no action')')
define(`spell_daze_monster', `spell_line(`Daze Monster',
	PHB 217, Ench, Comp, Mind, V S M,, `range_medium', `1~rnd.',,
	`one living target of 6~HD or less takes no action')')
define(`spell_death_knell', `spell_line(`Death Knell',
	PHB 217, Necr,, Death Evil, V S,, `range_touch', `10 min.~/ HD of creature',,
	`kill dying creature\komma gain 1D8 temp.~hits\komma +2 S{}T{}R and +1 caster level')')
define(`spell_death_ward', `spell_line(`Death Ward',
	PHB 217, Necr,,, V S DF,, `range_touch', `{level_caster}~min.',,
	`immune to death spells\komma magical death effects\komma energy drain and negative energy effects')')
define(`spell_deathwatch', `spell_line(`Deathwatch',
	PHB 217, Necr,, Evil, V S,, `range_you', `eval(level_caster * 10)~min.', `30~ft cone-shaped emanation',
	`discern near-death conditions of creatures')')
define(`spell_deep_slumber', `spell_line(`Deep Slumber',
	PHB 217, Ench, Comp, Mind, V S M, `1~rnd.', `range_close', `{level_caster}~min.',,
	`living creatures of together up to 10~HD in 10-ft radius burst')')
define(`spell_deeper_darkness', `spell_line(`Deeper Darkness',
	PHB 217, Evoc,, Dark, V AM DF,, `range_touch', `{level_caster}~d.~D',,
	`60~ft radius around touched point, within concealment $\Rightarrow$ miss chance 20\%')')
define(`spell_delay_poison', `spell_line(`Delay Poison',
	PHB 217, Conj, Heal,, V S DF,, `range_touch', `{level_caster}~h.',,
	`postpone effects of all poisons')')
define(`spell_delayed_blast_fireball', `spell_line(`Delayed Blast Fireball',
	PHB 217, Evoc,, Fire, V S M,, `range_long', `up to 5~rnd.',,
	`20-ft radius spread deals calc_min(level_caster,20)`'D6 fire damage')')
define(`spell_demand', `spell_line(`Demand',
	PHB 217, Ench, Comp, Mind, V S AM DF, `10~min.', `$\infty$', `1~rnd.',,
	`send 25-words-message plus possible suggestion to one familiar target, answer possible')')
define(`spell_desecrate', `spell_line(`Desecrate',
	PHB 218, Evoc,, Evil, V S ME(spellmaterial_desecrate) DF,, `range_close', `eval(level_caster * 2)~h.',,
	`curses a 20-ft radius emanation, -3 turn undead, +1 for undead, +1 hit per HD for undead created or summoned')')
define(`spell_destruction', `spell_line(`Destruction',
	PHB 218, Necr,, Death, V S FE(spellfocus_destruction),, `range_close',,,
	`one creature is killed (bodily remains consumed) or takes 10D6 damage')')
define(`spell_detect_animal_or_plants', `spell_line(`Detect Animals or Plants',
	PHB 218, Divn,,, V S,, `range_you', `eval(level_caster * 10)~min.~CD', `range_long cone shaped emanation',
	`detect particular kind of animals or plants\komma their number and condition')')
define(`spell_detect_chaos', `spell_line(`Detect Chaos',
	PHB 218, Divn,,, V S DF,, `range_you', `eval(level_caster * 10)~min.~CD', `60-ft cone shaped emanation',
	`detect chaotic auras and their power')')
define(`spell_detect_evil', `spell_line(`Detect Evil',
	PHB 218, Divn,,, V S DF,, `range_you', `eval(level_caster * 10)~min.~CD', `60-ft cone shaped emanation',
	`detect evil auras and their power')')
define(`spell_detect_good', `spell_line(`Detect Good',
	PHB 219, Divn,,, V S DF,, `range_you', `eval(level_caster * 10)~min.~CD', `60-ft cone shaped emanation',
	`detect good auras and their power')')
define(`spell_detect_law', `spell_line(`Detect Law',
	PHB 219, Divn,,, V S DF,, `range_you', `eval(level_caster * 10)~min.~CD', `60-ft cone shaped emanation',
	`detect lawful auras and their power')')
define(`spell_detect_magic', `spell_line(`Detect Magic',
	PHB 219, Divn,,, V S,, `range_you', `{level_caster}~min.~CD', `60-ft cone shaped emanation',
	`detect magic auras\komma their power and school of magic')')
define(`spell_detect_poison', `spell_line(`Detect Poison',
	PHB 219, Divn,,, V S,, `range_close',, `one creature\komma object or 5-ft cube',
	`check for poison and its type')')
define(`spell_detect_scrying', `spell_line(`Detect Scrying',
	PHB 219, Divn,,, V S M,, `range_you', `24~h.',,
	`learn about scrying against you\komma within 40~ft know origin automatically\komma beyond opposed level checks')')
define(`spell_detect_secret_doors', `spell_line(`Detect Secret Doors',
	PHB 220, Divn,,, V S,, `range_you', `{level_caster}~min.~CD', `60-ft cone shaped emanation',
	`detect passages hidden by design')')
define(`spell_detect_snares_and_pits', `spell_line(`Detect Snares and Pits',
	PHB 220, Divn,,, V S,, `range_you', `eval(level_caster * 10)~min.~CD', `60~ft cone shaped emanation',
	`detect simple pits\komma deadfalls and snares including according natural hazards')')
define(`spell_detect_thoughts', `spell_line(`Detect Thoughts',
	PHB 220, Divn,, Mind, V S AF DF,, `range_you', `{level_caster}~min.~CD', `60-ft cone shaped emanation',
	`detect surface thoughts and the associated intelligence')')
define(`spell_detect_undead', `spell_line(`Detect Undead',
	PHB 220, Divn,,, V S AM DF,, `range_you', `{level_caster}~min.~CD', `60-ft cone shaped emanation',
	`detect auras of undead and their power')')
define(`spell_dictum', `spell_line(`Dictum',
	PHB 220, Evoc,, Law Sonic Planar, V,, `',, `40~ft radius spread centered you',
	`any nonlawful creature is cumulatively deafened ($\le${level_caster}~HD)\komma slowed ($\le${eval(level_caster - 1)}~HD)\komma paralyzed ($\le${eval(level_caster - 5)}~HD) and killed ($\le${eval(level_caster - 10)}~HD) and extraplanar creatures are banished')')
define(`spell_dimension_door', `spell_line(`Dimension Door',
	PHB 221, Conj, Tele, Planar, V,, `range_you',,,
	`you and eval(level_caster / 3) touched creatures plus gear travel range_long')')
define(`spell_dimensional_anchor', `spell_line(`Dimensional Anchor',
	PHB 221, Abjr,, Planar, V S,, `range_medium', `{level_caster}~min.',,
	`one target (attack_touch_ranged ranged touch attack) cannot travel extradimensionally')')
define(`spell_dimensional_lock', `spell_line(`Dimensional Lock',
	PHB 221, Abjr,,, V S,, `range_medium', `{level_caster}~d.',,
	`block extradimensional travel (into and out) within 20-ft radius emanation')')
define(`spell_diminish_plants', `spell_line(`Diminish Plants',
	PHB 221, Trns,,, V S DF,,,,`100-ft radius within range_long or 1/2 mile around you',
	`shrink and untangle or reduce year-productivity to 1/3')')
define(`spell_discern_lies', `spell_line(`Discern Lies',
	PHB 221, Divn,,, V S DF,, `range_close', `{level_caster}~rnd.~C',,
	`can check one target per round')')
define(`spell_discern_location', `spell_line(`Discern Location',
	PHB 222, Divn,,, V S DF, `10~min.', `$\infty$',,,
	`locate one creature (once seen or possess item from it) or object (once touched)')')
define(`spell_disguise_self', `spell_line(`Disguise Self',
	PHB 222, Ills, Glam,, V S,, `range_you', `eval(level_caster * 10)~min.~D',,
	`you and all equipment, 1~ft size difference, keep body type')')
define(`spell_disintegrate', `spell_line(`Disintegrate',
	PHB 222, Trns,,, V S AM DF,, `range_medium',,,
	`attack_touch_ranged ranged touch attack, creature takes calc_min(eval(level_caster * 2),40)`'D6 or 5D6 damage (disintegrated at $\le${}0 hits), object looses 10 cb.~ft')')
define(`spell_dismissal', `spell_line(`Dismissal',
	PHB 222, Abjr,, Planar, V S DF,, `range_close',,,
	`banish one extraplanar creature, modify spell-DC by plus {level_caster} and minus HD of target')')
define(`spell_dispel_chaos', `spell_line(`Dispel Chaos',
	PHB 222, Abjr,, Law, V S DF,, `range_you', `{level_caster}~rnd. until used',,
	`+4 deflect AC against chaotic creatures, discharge to banish or dispel chaos once')')
define(`spell_dispel_evil', `spell_line(`Dispel Evil',
	PHB 222, Abjr,, Good, V S DF,, `range_you', `{level_caster}~rnd. until used',,
	`+4 deflect AC against evil creatures, discharge to banish or dispel evil once')')
define(`spell_dispel_good', `spell_line(`Dispel Good',
	PHB 222, Abjr,, Evil, V S DF,, `range_you', `{level_caster}~rnd. until used',,
	`+4 deflect AC against good creatures, discharge to banish or dispel good once')')
define(`spell_dispel_law', `spell_line(`Dispel Law',
	PHB 223, Abjr,, Chaos, V S DF,, `range_you', `{level_caster}~rnd. until used',,
	`+4 deflect AC against lawful creatures, discharge to banish or dispel law once')')
define(`spell_dispel_magic', `spell_line(`Dispel Magic',
	PHB 223, Abjr,,, V S,, `range_medium',,,
	`caster, creature, object, 20-ft radius burst, check: 1D20+calc_min(level_caster, 10)')')
define(`spell_dispel_magic_greater', `spell_line(`Dispel Magic\komma Greater',
	PHB 223, Abjr,,, V S,, `range_medium',,,
	`caster, creature, object, 20-ft radius burst, check: 1D20+calc_min(level_caster, 20)')')
define(`spell_displacement', `spell_line(`Displacement',
	PHB 223, Ills, Glam,, V M,, `range_touch', `{level_caster}~rnd.~D',,
	`gain 50\% miss chance')')
define(`spell_disrupt_undead', `spell_line(`Disrupt Undead',
	PHB 223, Necr,,, V S,, `range_close',,,
	`attack_touch_ranged ranged touch attack to deal 1D6 to one undead')')
define(`spell_disrupting_weapon', `spell_line(`Disrupting Weapon',
	PHB 223, Trns,,, V S,, `range_touch', `{level_caster}~rnd.',,
	`melee weapon destroys undead of $\le${level_caster}~HD at failed will save')')
define(`spell_divination', `spell_line(`Divination',
	PHB 224, Divn,,, V S ME(spellmaterial_divination), `10~min.', `range_you',,,
	`you gain a short answer to one question')')
define(`spell_divine_favor', `spell_line(`Divine Favor',
	PHB 224, Evoc,,, V S DF,, `range_you', `1~min.',,
	`gain +`'calc_max(1, calc_min(6, eval(level_caster / 3))) on attacks and weapon damage rolls')')
define(`spell_divine_power', `spell_line(`Divine Power',
	PHB 224, Evoc,,, V S DF,, `range_you', `{level_caster}~rnd.',,
	`bonus_attack_base_cascade(level_total, 0) base attack bonus, +6 strength score, {level_caster}~temporary hits')')
define(`spell_dominate_animal', `spell_line(`Dominate Animal',
	PHB 224, Ench, Comp, Mind, V S, `1~rnd.', `range_close', `{level_caster}~rnd.',,
	`mental link to one animal, give simple commands')')
define(`spell_dominate_monster', `spell_line(`Dominate Monster',
	PHB 224, Ench, Comp, Mind, V S, `1~rnd.', `range_close', `{level_caster}~d.',,
	`telepathic link to one creature, give simple or (by language) detailed commands, upon concentration receive preprocessed sensory input')')
define(`spell_dominate_person', `spell_line(`Dominate Person',
	PHB 224, Ench, Comp, Mind, V S, `1~rnd.', `range_close', `{level_caster}~d.',,
	`telepathic link to one humanoid, give simple or (by language) detailed commands, upon concentration receive preprocessed sensory input')')
define(`spell_doom', `spell_line(`Doom',
	PHB 225, Necr,, Fear Mind, V S DF,, `range_medium', `{level_caster}~min.',,
	`one living creature becomes shaken')')
define(`spell_drawmijs_instant_summons', `spell_line(`Drawmij\aps s Instant Summons',
	PHB 225, Conj, Summ,, V S ME(spellmaterial_drawmijs_instant_summons),, `$\infty$', `until used',,
	`call one prepared item to you')')
define(`spell_dream', `spell_line(`Dream',
	PHB 225, Ills, Phan, Mind, V S, `1~min.', `$\infty$', `until sent',,
	`you or one living creature touched delivers a dream-message')')
define(`spell_eagles_splendor', `spell_line(`Eagle\aps s Splendor',
	PHB 225, Trns,,, V S AM DF,, `range_touch', `{level_caster}~min.',,
	`+4 C{}H{}A score')')
define(`spell_eagles_splendor_mass', `spell_line(`Eagle\aps s Splendor\komma Mass',
	PHB 225, Trns,,, V S AM DF,, `range_close', `{level_caster}~min.',,
	`+4 C{}H{}A score for {level_caster} targets')')
define(`spell_earthquake', `spell_line(`Earthquake',
	PHB 225, Evoc,, Earth, V S DF,, `range_long', `1~rnd.',,
	`80~ft radius spread')')
define(`spell_elemental_swarm', `spell_line(`Elemental Swarm',
	PHB 226, Conj, Summ, Planar Varies, V S, `10~min.', `range_medium', `eval(level_caster * 10)~min.',,
	`2D4 large, 1D4 huge and 1 elder elemental(s) of one kind')')
define(`spell_endure_elements', `spell_line(`Endure Elements',
	PHB 226, Abjr,,, V S,, `range_touch', `24~h.',,
	`exist comfortably within temperature -50 to 140{}${}^{\circ}$F (-45 to 60{}${}^{\circ}$C)')')
define(`spell_energy_drain', `spell_line(`Energy Drain',
	PHB 226, Necr,,, V S,, `range_close', `varies',,
	`attack_touch_ranged ranged touch attack causes 2D4 negative levels, possibly permanent')')
define(`spell_enervation', `spell_line(`Enervation',
	PHB 226, Necr,,, V S,, `range_close', `calc_min(level_caster, 15)~h.',,
	`attack_touch_ranged ranged touch attack causes 1D4 negative levels')')
define(`spell_enlarge_person', `spell_line(`Enlarge Person',
	PHB 226, Trns,,, V S M, `1~rnd.', `range_close', `{level_caster}~min.~D',,
	`humanoid target raises one size category, +2 strength, -2 dexterity, -1 attacks and AC')')
define(`spell_enlarge_person_mass', `spell_line(`Enlarge Person\komma Mass',
	PHB 227, Trns,,, V S M, `1~rnd.', `range_close', `{level_caster}~min.~D',,
	`{level_caster} humanoid targets raise one size category, +2 strength, -2 dexterity, -1 attacks and AC')')
define(`spell_entangle', `spell_line(`Entangle',
	PHB 227, Trns,,, V S DF,, `range_long', `{level_caster}~min.~D', `plants in 40~ft radius spread',
	`creatures get entangled and are slowed to half speed')')
define(`spell_enthrall', `spell_line(`Enthrall',
	PHB 227, Ench, Chrm, Lang Mind Sonic, V S, `1~rnd.', `range_medium', `max.~1~h.',,
	`while you speek/sing +1D3 rounds all targets pay attention\komma gain better attitude')')
define(`spell_entropic_shield', `spell_line(`Entropic Shield',
	PHB 227, Abjr,,, V S,, `range_you', `{level_caster}~min.~D',,
	`aiming ranged attacks against you have 20\% miss chance')')
define(`spell_erase', `spell_line(`Erase',
	PHB 227, Trns,,, V S,, `range_close',,,
	`erase mundane or magical (caster level check) writings')')
define(`spell_ethereal_jaunt', `spell_line(`Ethereal Jaunt',
	PHB 227, Trns,, Planar, V S,, `range_you', `{level_caster}~rnd.~D',,
	`you and your gear travel to Ethereal Plane\komma can act there')')
define(`spell_etherealness', `spell_line(`Etherealness',
	PHB 228, Trns,, Planar, V S,, `range_touch', `{level_caster}~min.~D',,
	`you plus eval(level_caster / 3) creatures and all gear travel to Ethereal Plane, can act there')')
define(`spell_evards_black_tentacles', `spell_line(`Evard\aps{}s Black Tentacles',
	PHB 228, Conj, Crea,, V S M,, `range_medium', `{level_caster}~rnd.~D',,
	`within 20-ft radius spread large tentacles grapple (+eval(level_caster + 4 + 4) / 1D6+4) all targets')')dnl further +4 attack bonus for large size grappling, but what about the -1 size modifier ???
define(`spell_expeditious_retreat', `spell_line(`Expeditious Retreat',
	PHB 228, Trns,,, V S,, `range_you', `{level_caster}~min.~D',,
	`+30 ft base land speed, improve jumping accordingly')')
define(`spell_explosive_runes', `spell_line(`Explosive Runes',
	PHB 228, Abjr,, Force Planar, V S,, `range_touch', `until used',,
	`runes protect object, deal 6D6 if used unallowed')')
define(`spell_eyebite', `spell_line(`Eyebite',
	PHB 228, Necr,, Evil, V S,, `range_close', `eval(level_caster / 3)`'~rnd.',,
	`one living target per round: sickened and panicked (HD$\le${}9) and comatosed (HD$\le${}4)')')
define(`spell_fabricate', `spell_line(`Fabricate',
	PHB 229, Trns,,, V S ME(spellmaterial_fabricate), `varies', `range_close',,,
	`convert up to eval(10 * level_caster)~cu.ft (1/10 for minerals) of one-sort raw material into some object')')
define(`spell_faerie_fire', `spell_line(`Faerie Fire',
	PHB 229, Evoc,, Light, V S DF,, `range_long', `{level_caster}~min.~D', `5~ft radius burst',
	`negate concealment by normal darkness\komma blur\komma invisibility etc.')')
define(`spell_false_life', `spell_line(`False Life',
	PHB 229, Necr,,, V S M,, `range_you', `{level_caster}~h.',,
	`gain 1D10+calc_min(10, level_caster) temporary hitpoints')')
define(`spell_false_vision', `spell_line(`False Vision',
	PHB 229, Ills, Glam,, V S ME(spellmaterial_false_vision),, `range_touch', `{level_caster}~h.~D',,
	`foil scrying spells targetting 40-ft radius emanation')')
define(`spell_fear', `spell_line(`Fear',
	PHB 229, Necr,, Fear Mind, V S M,, `30~ft', `varies',,
	`creatures within cone-shaped burst become panicked ({level_caster}~rnd.) or shaken (1~rnd.)')')
define(`spell_feather_fall', `spell_line(`Feather Fall',
	PHB 229, Trns,,, V, `1~free action', `range_close', `{level_caster}~rnd.',,
	`{level_caster}~medium or smaller sized creatures or objects, until landed')')
define(`spell_feeblemind', `spell_line(`Feeblemind',
	PHB 229, Ench, Comp, Mind, V S M,, `range_medium',,,
	`one creature\aps{}s I{}N{}T and C{}H{}A drop to 1')')
define(`spell_find_path', `spell_line(`Find the Path', 
	PHB 230, Divn,,, V S F, `3~rnd.', `range_touch', `eval(level_caster * 10)~min.',,
	`know way to a specified \textbf{location}')')
define(`spell_find_traps', `spell_line(`Find Traps',
	PHB 230, Divn,,, V S,, `range_you', `{level_caster}~min.',,
	`search for traps (effectively granting the according rogue ability)\komma +`'calc_min(10, eval(level_caster / 2)) insight bonus')')
define(`spell_finger_of_death', `spell_line(`Finger of Death',
	PHB 230, Necr,, Death, V S,, `range_close',,,
	`one living creature dies or takes 3D6+calc_min(level_caster,25) damage')')
define(`spell_fire_seeds', `spell_line(`Fire Seeds',
	PHB 230, Conj, Crea, Fire, V S M,, `range_touch', `eval(level_caster * 10)~min.~until used',,
	`four acorns (thrown\komma deal distributed calc_min(20, level_caster)`'D6 fire plus splash) \textbf{or} eight holly berries (placed\komma deal 1D8+{level_caster} fire in 5~ft~radius burst upon command)')')
define(`spell_fire_shield', `spell_line(`Fire Shield',
	PHB 230, Evoc,, Varies, V S AM DF,, `range_you', `{level_caster}~rnd.~D',,
	`fire or cold flames (10~ft illumination) deal 1D6+calc_min(level_caster,15) to melee attackers and halve damage from opposite element')')
define(`spell_fire_storm', `spell_line(`Fire Storm',
	PHB 231, Evoc,, Fire, V S, `1~rnd.', `range_medium',,,
	`eval(level_caster * 2) 10-ft-cubes, deal calc_min(level_caster,20)`'D6 fire damage, targets excludable')')
define(`spell_fire_trap', `spell_line(`Fire Trap',
	PHB 231, Abjr,, Fire, V S ME(spellmaterial_fire_trap), `10~min.', `range_touch', `until used',,
	`1D4+{level_caster} fire damage')')
define(`spell_fireball', `spell_line(`Fireball',
	PHB 231, Evoc,, Fire, V S M,, `range_long',,,
	`20-ft radius spread deals calc_min(level_caster,10)`'D6 fire damage')')
define(`spell_flame_arrow', `spell_line(`Flame Arrow',
	PHB 231, Trns,, Fire, V S M,, `range_close', `eval(10 * level_caster)~min.',,
	`50 projectiles deal +1D6 fire')')
define(`spell_flame_blade', `spell_line(`Flame Blade',
	PHB 231, Evoc,, Fire, V S DF,, `range_you', `{level_caster}~min.~D',,
	`{attack_touch_melee} melee touch attack, 1D8+calc_min(eval(level_caster / 2),10) fire damage')')
define(`spell_flame_strike', `spell_line(`Flame Strike',
	PHB 231, Evoc,, Fire, V S DF,, `range_medium',,,
	`10~ft radius, 40~ft high, calc_min(level_caster, 15)`'D6 damage (fire / divine)')')
define(`spell_flaming_sphere', `spell_line(`Flaming Sphere',
	PHB 232, Evoc,, Fire, V S AM DF,, `range_medium', `{level_caster}~rnd.',,
	`5~ft diameter sphere, 30~ft speed, 2D6 fire damage')')
define(`spell_flare', `spell_line(`Flare',
	PHB 232, Evoc,, Light, V,, `range_close',,,
	`burst of light dazzles single creature for 1~min.')')
define(`spell_flesh_to_stone', `spell_line(`Flesh to Stone',
	PHB 232, Trns,,, V S M,, `range_medium',,,
	`one creature of flesh is turned into a stone statue')')
define(`spell_fly', `spell_line(`Fly',
	PHB 232, Trns,,, V S AF DF,, `range_touch', `{level_caster}~min.',,
	`speed 60~ft (40~ft with medium or heavy encumbrance), good maneuverability')')
define(`spell_fog_cloud', `spell_line(`Fog Cloud',
	PHB 232, Conj, Crea,, V S,, `range_medium', `eval(level_caster * 10)~min.', `20~ft radius\komma 20~ft high spread',
	`fog obscures sight beyond 5~ft')')
define(`spell_forbiddance', `spell_line(`Forbiddance',
	PHB 232, Abjr,, Planar, V S ME(spellmaterial_forbiddance) DF, `6~rnd.', `range_medium', `duration_permanent',,
	`seals {level_caster} 60-ft cubes against planar travel accross its border and damage entering creatures of opposite alignment')')
define(`spell_forcecage', `spell_line(`Forcecage',
	PHB 233, Evoc,, Force Planar, V S ME(spellmaterial_forcecage),, `range_close', `eval(2 * level_caster)~h.~D',,
	`created 20-ft cube with bars or 10-ft cbre with walls imprisons creatures at target area')')
define(`spell_foresight', `spell_line(`Foresight',
	PHB 233, Divn,,, V S AM DF,, `range_touch', `eval(level_caster * 10)~min.',,
	`warns from immediate danger')')
define(`spell_foxs_cunning', `spell_line(`Fox\aps{}s Cunning',
	PHB 233, Trns,,, V S AM DF,, `range_touch', `{level_caster}~min.',,
	`+4 I{}N{}T score')')
define(`spell_foxs_cunning_mass', `spell_line(`Fox\aps{}s Cunning\komma Mass',
	PHB 233, Trns,,, V S AM DF,, `range_close', `{level_caster}~min.',,
	`+4 I{}N{}T score for {level_caster} targets')')
define(`spell_freedom', `spell_line(`Freedom',
	PHB 233, Abjr,,, V S,, `range_close',,,
	`one creature is released from binding spells and effects')')
define(`spell_freedom_movement', `spell_line(`Freedom of Movement',
	PHB 233, Abjr,,, V S M DF,, `range_touch', `eval(level_caster * 10)~min.',,
	`act normally under movement impeding spells and effects, including underwater')')
define(`spell_gaseous_form', `spell_line(`Gaseous Form',
	PHB 234, Trns,,, S AM DF,, `range_touch', `eval(2 * level_caster)~min.~D',,
	`subject and gear become misty, gain damage reduction 10/magic, immunity to poisons and criticals, fly speed 10~ft')')
define(`spell_gate', `spell_line(`Gate',
	PHB 234, Conj, Varies, Planar, V S XP,, `range_medium', `varies',,
	`open portal to another plane, can travel through \textbf{or} call creatures')')
define(`spell_geas', `spell_line(`Geas',
	PHB 234, Ench, Comp, Lang Mind, V, `10~min.', `range_close', `{level_caster}~d.',,
	`one living creature must follow one command')')
define(`spell_geas_lesser', `spell_line(`Geas\komma Lesser',
	PHB 235, Ench, Comp, Lang Mind, V, `1~rnd.', `range_close', `{level_caster}~d.',,
	`one living creature ($\le${}7 HD) must follow one command')')
define(`spell_gentle_repose', `spell_line(`Gentle Repose',
	PHB 235, Necr,,, V S AM DF,, `range_touch', `{level_caster}~day',,
	`preserve one corpse (or parts) from decay')')
define(`spell_ghost_sound', `spell_line(`Ghost Sound',
	PHB 235, Ills, Figm,, V S M,, `range_close', `{level_caster}~rnd.~D',,
	`produce sound as much as calc_min(eval(level_caster * 4),20) humans')')
define(`spell_ghoul_touch', `spell_line(`Ghoul Touch', 
	PHB 235, Necr,,, V S M,, `range_touch', `1D6+2~rnd.',,
	`attack_touch_melee melee touch attack paralyzes living humanoid and sickens those within 10-ft radius spread')')
define(`spell_giant_vermin', `spell_line(`Giant Vermin',
	PHB 235, Trns,,, V S DF,, `range_close', `{level_caster}~min.',,
	`3 centipedes \textbf{or} 2 spiders \textbf{or} 1 scorpion (MOM~I~p.286ff) grow ifelse(eval(level_caster <= 9),1,medium,eval(level_caster <= 13),1,large,eval(level_caster <= 17),1,huge,eval(level_caster <= 19),1,gargantuan,colossal)')')
define(`spell_glibness', `spell_line(`Glibness',
	PHB 235, Trns,,, S,, `range_you', `eval(10 * level_caster)~min.~D',,
	`+30 Bluff checks convincing others of the truth of your words\komma protect from divinations')')
define(`spell_glitterdust', `spell_line(`Glitterdust',
	PHB 236, Conj, Crea,, V S M,, `range_medium', `{level_caster}~rnd.',,
	`cover 10-ft radius spread with golden dust, blind and outline')')
define(`spell_globe_of_invulnerability', `spell_line(`Globe of Invulnerability',
	PHB 236, Abjr,,, V S M,, `0~ft', `{level_caster}~rnd.~D',,
	`immobile 10-ft radius emanation excludes all spell effects $\le${}4th level')')
define(`spell_globe_of_invulnerability_lesser', `spell_line(`Globe of Invulnerability\komma Lesser',
	PHB 236, Abjr,,, V S M,, `0~ft', `{level_caster}~rnd.~D',,
	`immobile 10-ft radius emanation excludes all spell effects $\le${}3rd level')')
define(`spell_glyph_of_warding', `spell_line(`Glyph of Warding',
	PHB 236, Abjr,,, V S ME(spellmaterial_glyph_of_warding), `10~min.', `range_touch', `until activated',,
	`ward object or eval(5 * level_caster)~sq.ft, set trigger, activate as blast (calc_min(5, eval(level_caster / 2))`'D8) or stored spell $\le${}3rd level')')
define(`spell_glyph_of_warding_greater', `spell_line(`Glyph of Warding\komma Greater',
	PHB 237, Abjr,,, V S ME(spellmaterial_glyph_of_warding_greater), `10~min.', `range_touch', `until activated',,
	`ward object or eval(5 * level_caster)~sq.ft, set trigger, activate as blast (calc_min(10, eval(level_caster / 2))`'D8) or stored spell $\le${}6th level')')
define(`spell_goodberry', `spell_line(`Goodberry',
	PHB 237, Trns,,, V S DF,, `range_touch', `{level_caster}~d.',,
	`2D4 berries each provide a normal meal and heal 1 point of damage')')
define(`spell_good_hope', `spell_line(`Good Hope',
	PHB 237, Ench, Comp, Mind, V S,, `range_medium', `{level_caster}~min.',,
	`{level_caster} living creatures gain +2 moral saves, attacks, damage and ability and skill checks')')
define(`spell_grease', `spell_line(`Grease',
	PHB 237, Conj, Crea,, V S M,, `range_close', `{level_caster}~rnd.~D',,
	`one object or 10-ft.~square, DC 10 balance for movements')')
define(`spell_guards_and_wards', `spell_line(`Guards and Wards',
	PHB 237, Abjr,,, V S M F, `30~min.', `within area', `eval(2 * level_caster)~h.~D',,
	`ward eval(200 * level_caster)~sq.ft by: Fog, Arcane Lock, Web, Confusion, Lost Doors, etc.')')
define(`spell_guidance', `spell_line(`Guidance',
	PHB 238, Divn,,, V S,, `range_touch', `1~min.',,
	`gain single +1 on attack, save or check')')
define(`spell_gust_of_wind', `spell_line(`Gust of Wind',
	PHB 238, Evoc,, Air, V S,, `60~ft', `1~rnd.',,
	`li{}ne shaped emanation, cf.~DMG p.95: severe wind')')
define(`spell_hallow', `spell_line(`Hallow',
	PHB 238, Evoc,, Good, V S ME(spellmaterial_hallow) DF, `24~h.', `range_touch',,,
	`40~ft radius emanation from point touched')')
define(`spell_hallucinatory_terrain', `spell_line(`Hallucinatory Terrain',
	PHB 238, Ills, Glam,, V S M, `10~min.', `range_long', `eval(2 * level_caster)~h.~D',,
	`change natural terrain character (visual\komma audible\komma olfactory) within {level_caster} 30-ft cubes')')
define(`spell_halt_undead', `spell_line(`Halt Undead',
	PHB 238, Necr,,, V S M,, `range_medium', `{level_caster}~rnd.',,
	`immobilize up to 3 undead')')
define(`spell_harm', `spell_line(`Harm',
	PHB 239, Necr,,, V S,, `range_touch',,,
	`deal calc_min(eval(level_caster * 10),150) points of damage')')
define(`spell_haste', `spell_line(`Haste',
	PHB 239, Trns,,, V S M,, `range_close', `{level_caster}~rnd.',,
	`{level_caster}~targets gain: one extra attack, +1 attacks, +1 dodge AC, +1 Reflex Saves, +30~ft speed')')
define(`spell_heal', `spell_line(`Heal',
	PHB 239, Conj, Heal,, V S,, `range_touch',,,
	`cure calc_min(eval(level_caster * 10),150) hits and heal several injuries and afflictions')')
define(`spell_heal_mass', `spell_line(`Heal\komma Mass',
	PHB 239, Conj, Heal,, V S,, `range_close',,,
	`cure calc_min(eval(level_caster * 10),250) hits and heal several injuries and afflictions for {level_caster} creatures')')
define(`spell_heal_mount', `spell_line(`Heal Mount',
	PHB 239, Conj, Heal,, V S,, `range_touch',,,
	`cure calc_min(eval(level_caster * 10),150) hits and heal several injuries and afflictions for paladin\aps{}s mount')')
define(`spell_heat_metal', `spell_line(`Heat Metal',
	PHB 239, Trns,, Fire, V S DF,, `range_close', `7~rnd.',,
	`metal of eval(level_caster / 2) creatures or eval(level_caster * 25)~lbs.')')
define(`spell_helping_hand', `spell_line(`Helping Hand',
	PHB 239, Evoc,,, V S DF,, `5~mi.', `{level_caster}~h.',,
	`ghostly hand searches creature and guides it to you')')
define(`spell_heroes_feast', `spell_line(`Heroes\aps{} Feast',
	PHB 240, Conj, Crea,, V S DF, `10~min.', `range_close', `1~h.',,
	`meal cures diseases, sickness and nausea and provides for 12~h.~immunity to poison and fear, 1D8+calc_min(10, eval(level_caster / 2)) temporary hits, +1 moral attack rolls and Will Saves')')
define(`spell_heroism', `spell_line(`Heroism',
	PHB 240, Ench, Comp, Mind, V S,, `range_touch', `eval(level_caster * 10)~min.',,
	`one target gains +2 moral bonus on: attack rolls, saves, skills')')
define(`spell_heroism_greater', `spell_line(`Heroism\komma Greater',
	PHB 240, Ench, Comp, Mind, V S,, `range_touch', `{level_caster}~min.',,
	`one target gains +4 moral bonus on: attack rolls, saves, skills, gains immunity to fear and calc_min(level_caster,20) temporary hits')')
define(`spell_hide_from_animals', `spell_line(`Hide from Animals',
	PHB 241, Abjr,,, S DF,, `range_touch', `eval(level_caster * 10)~min.~D',,
	`hide {level_caster} creature`'ifelse(level_caster,1,,s) from all kinds of animal\aps{}s perception')')
define(`spell_hide_from_undead', `spell_line(`Hide from Undead',
	PHB 241, Abjr,,, V S DF,, `range_touch', `eval(level_caster * 10)~min.~D',,
	`hide {level_caster} creature`'ifelse(level_caster,1,,s) from all kinds of undead\aps{}s perception')')
define(`spell_hold_animal', `spell_line(`Hold Animal',
	PHB 241, Ench, Comp, Mind, V S,, `range_medium', `{level_caster}~rnd.~D',,
	`one animal is paralyzed')')
define(`spell_hold_monster', `spell_line(`Hold Monster',
	PHB 241, Ench, Comp, Mind, V S AM DF,, `range_medium', `{level_caster}~rnd.~D',,
	`one living creature is paralyzed')')
define(`spell_hold_monster_mass', `spell_line(`Hold Monster\komma Mass',
	PHB 241, Ench, Comp, Mind, V S M,, `range_medium', `{level_caster}~rnd.~D',,
	`living creatures within 30~ft are paralyzed')')
define(`spell_hold_person', `spell_line(`Hold Person',
	PHB 241, Ench, Comp, Mind, V S AF DF,, `range_medium', `{level_caster}~rnd.~D',,
	`one humanoid creature is paralyzed')')
define(`spell_hold_person_mass', `spell_line(`Hold Person\komma Mass',
	PHB 241, Ench, Comp, Mind, V S F,, `range_medium', `{level_caster}~rnd.~D',,
	`humanoid creatures within 30~ft are paralyzed')')
define(`spell_hold_portal', `spell_line(`Hold Portal',
	PHB 241, Abjr,,, V,, `range_medium', `{level_caster}~min.~D',,
	`keep shut one portal up to eval(level_caster * 20)~sq.ft')')
define(`spell_holy_aura', `spell_line(`Holy Aura',
	PHB 241, Abjr,, Good, V S FE(spellfocus_holy_aura),, `', `{level_caster}~rnd.~D', `20-ft radius burst centered on you',
	`{level_caster} creatures gain: +4 deflect AC, +4 saves, spell resistance 25 against evil, block possession and mental influence, attacking evil creatures are blinded')')
define(`spell_holy_smite', `spell_line(`Holy Smite', 
	PHB 241, Evoc,, Good, V S,, `range_medium',,,
	`within 20-ft radius burst deal calc_min(5, eval(level_caster / 2))`'D8 to evil creatures (neutral half) and blind 1~rnd.')')
define(`spell_holy_sword', `spell_line(`Holy Sword',
	PHB 242, Evoc,, Good, V S,, `range_touch', `{level_caster}~rnd.',,
	`melee weapon becomes +5 holy and emits magic circle against evil')')
define(`spell_holy_word', `spell_line(`Holy Word',
	PHB 242, Evoc,, Good Sonic Planar, V,, `',, `40~ft radius spread centered on you',
	`any nongood creature is cumulatively deafened ($\le${level_caster}~HD)\komma blinded ($\le${eval(level_caster - 1)}~HD)\komma paralyzed ($\le${eval(level_caster - 5)}~HD) and killed ($\le${eval(level_caster - 10)}~HD) and extraplanar creatures are banished')')
define(`spell_horrid_wilting', `spell_line(`Horrid Wilting',
	PHB 242, Necr,,, V S AM DF,, `range_long',,,
	`deal calc_min(20, level_caster)`'D6 to living creatures, calc_min(20, level_caster)`'D8 to water elementals and plant creatures')')
define(`spell_hypnotic_pattern', `spell_line(`Hypnotic Pattern',
	PHB 242, Ills, Patt, Mind, `ifelse(token_caster,bard,V ,)`'S M',, `range_medium', `C + 2~rnd.',,
	`2D4+calc_min(10, level_caster) total HD of targets within 10-ft radius spread become fascinated')')
define(`spell_hypnotism', `spell_line(`Hypnotism',
	PHB 242, Ench, Comp, Mind, V S, `1~rnd.', `range_close', `2D4 rnd.~D',,
	`2D4 HD of creatures change attitude: two steps more friendly')')
define(`spell_ice_storm', `spell_line(`Ice Storm',
	PHB 243, Evoc,, Cold, V S AM DF,, `range_long', `1~rnd.', `20-ft radius\komma 40-ft high cylinder',
	`3D6 bludgeoning\komma 2D6 cold\komma -4~listen\komma half speed')')
define(`spell_identify', `spell_line(`Identify',
	PHB 243, Divn,,, V S AME(spellmaterial_identify) DF, `1~h.', `range_touch',,,
	`determine all magic properties of one item (but not artefact)')')
define(`spell_illusory_script', `spell_line(`Illusory Script',
	PHB 243, Ills, Phan, Mind, V S ME(spellmaterial_illusory_script), `{}$\ge${}1~min.', `range_touch', `{level_caster}~d.~D',,
	`impose suggestion on unauthorized readers')')
define(`spell_illusory_wall', `spell_line(`Illusory Wall',
	PHB 243, Ills, Figm,, V S,, `range_close', `duration_permanent', `10-ft $\times$ 10-ft wall',
	`create wall\komma floor\komma ceiling or similar surface')')
define(`spell_imbue_with_spell_ability', `spell_line(`Imbue with Spell Ability',
	PHB 243, Evoc,,, V S DF, `10~min.', `range_touch', `until discharged',,
	`transfer some of your prepared spells to another creature')')
define(`spell_implosion', `spell_line(`Implosion',
	PHB 243, Evoc,,, V S,, `range_close', `C up to 4 rnds.',,
	`kill one corporeal creature per round')')
define(`spell_imprisonment', `spell_line(`Imprisonment',
	PHB 244, Abjr,,, V S,, `range_touch',,,
	`imprison one creature in stasis within earth')')
define(`spell_incendiary_cloud', `spell_line(`Incendiary Cloud',
	PHB 244, Conj, Crea, Fire, V S,, `range_medium', `{level_caster}~rnd.', `20-ft radius\komma 20-ft high cloud',
	`deal 4D6 fire each round in cloud\komma cloud moves 10~ft/rnd.~or 60~ft/rnd.~by concentration')')
define(`spell_inflict_critical_wounds', `spell_line(`Inflict Critical Wounds',
	PHB 244, Necr,,, V S,, `range_touch',,,
	`deal 4D8+{calc_min(level_caster, 20)} points of damage')')
define(`spell_inflict_critical_wounds_mass', `spell_line(`Inflict Critical Wounds\komma Mass',
	PHB 244, Necr,,, V S,, `range_close',,,
	`deal 4D8+{calc_min(level_caster, 40)} points of damage for {level_caster} targets')')
define(`spell_inflict_light_wounds', `spell_line(`Inflict Light Wounds',
	PHB 244, Necr,,, V S,, `range_touch',,,
	`deal 1D8+{calc_min(level_caster, 5)} points of damage')')
define(`spell_inflict_light_wounds_mass', `spell_line(`Inflict Light Wounds\komma Mass',
	PHB 244, Necr,,, V S,, `range_close',,,
	`deal 1D8+{calc_min(level_caster, 25)} points of damage for {level_caster} targets')')
define(`spell_inflict_minor_wound', `spell_line(`Inflict Minor Wound',
	PHB 244, Necr,,, V S,, `range_touch',,,
	`deal 1 point of damage')')
define(`spell_inflict_moderate_wounds', `spell_line(`Inflict Moderate Wounds',
	PHB 244, Necr,,, V S,, `range_touch',,,
	`deal 2D8+{calc_min(level_caster, 10)} points of damage')')
define(`spell_inflict_moderate_wounds_mass', `spell_line(`Inflict Moderate Wounds\komma Mass',
	PHB 244, Necr,,, V S,, `range_close',,,
	`deal 2D8+{calc_min(level_caster, 30)} points of damage for {level_caster} targets')')
define(`spell_inflict_serious_wounds', `spell_line(`Inflict Serious Wounds',
	PHB 244, Necr,,, V S,, `range_touch',,,
	`deal 3D8+{calc_min(level_caster, 15)} points of damage')')
define(`spell_inflict_serious_wounds_mass', `spell_line(`Inflict Serious Wounds\komma Mass',
	PHB 244, Necr,,, V S,, `range_close',,,
	`deal 3D8+{calc_min(level_caster, 35)} points of damage for {level_caster} targets')')
define(`spell_insanity', `spell_line(`Insanity',
	PHB 244, Ench, Comp, Mind, V S,, `range_medium',,,
	`one living creature is confused permanently')')
define(`spell_insect_plague', `spell_line(`Insect Plague',
	PHB 244, Conj, Summ,, V S DF, `1~rnd.', `range_long', `{level_caster}~min.',,
	`calc_min(eval(level_caster / 3), 6) adjacent locust swarms (MOM~I p.239)')')
define(`spell_invisibility', `spell_line(`Invisibility',
	PHB 245, Ills, Glam,, V S AM DF,, `range_touch', `{level_caster}~min.~D',,
	`target and its gear (within 10~ft) or object (eval(level_caster * 100)~lbs.) becomes invisible, any attack ends spell')')
define(`spell_invisibility_greater', `spell_line(`Invisibility\komma Greater',
	PHB 245, Ills, Glam,, V S,, `range_touch', `{level_caster}~rnd.~D',,
	`target and its gear (within 10~ft) or object (eval(level_caster * 100)~lbs.) becomes invisible')')
define(`spell_invisibility_mass', `spell_line(`Invisibility\komma Mass',
	PHB 245, Ills, Glam,, V S AM,, `range_long', `{level_caster}~min.~D',,
	`within 180~ft all targets and its gear (within 10~ft) become invisible, any attack ends spell for all targets')')
define(`spell_invisibility_purge', `spell_line(`Invisibility Purge',
	PHB 245, Evoc,, Planar, V S,, `range_you', `{level_caster}~min.~D',,
	`negate invisibility effects within eval(level_caster * 5)~ft of you')')
define(`spell_invisibility_sphere', `spell_line(`Invisibility Sphere',
	PHB 245, Ills, Glam,, V S M,, `range_touch', `{level_caster}~min.~D',,
	`target or object (eval(level_caster * 100)~lbs.) and creatures within 10~ft of target become invisible, any attack ends effect')')
define(`spell_iron_body', `spell_line(`Iron Body',
	PHB 245, Trns,,, V S AM DF,, `range_you', `{level_caster}~min.~D',,
	`your body becomes iron\komma you gain damage reduction 15/adamantine and several imunities\komma +6 S{}T{}R\komma -6 D{}E{}X\komma 50\% arcane spell failure\komma -8 check penalty')')
define(`spell_ironwood', `spell_line(`Ironwood',
	PHB 246, Trns,,, V S M, `1~min./lb.', `range_touch', `{level_caster}~d.~D',,
	`turns eval(level_caster * 5)~lbs.~of wood as hard as steel, or half that amount at +1')')
define(`spell_jump', `spell_line(`Jump',
	PHB 246, Trns,,, V S M,, `range_touch', `{level_caster}~min.~D',,
	`ifelse(eval(level_caster >= 9),1,+30,eval(level_caster >= 5),1,+20,+10) on jump checks')')
define(`spell_keen_edge', `spell_line(`Keen Edge',
	PHB 246, Trns,,, V S,, `range_close', `eval(10 * level_caster)~min.',,
	`double critical threat range of one melee weapon or 50 projectile (piercing or slashing)')')
define(`spell_knock', `spell_line(`Knock',
	PHB 246, Trns,,, V,, `range_medium',,,
	`open two lock mechanisms of door (eval(level_caster * 10)~sq-ft.), box or chest')')
define(`spell_know_direction', `spell_line(`Know Direction',
	PHB 246, Divn,,, V S,, `range_you',,,
	`you discern north')')
define(`spell_legend_lore', `spell_line(`Legend Lore',
	PHB 246, Divn,,, V S ME(spellmaterial_legend_lore) FE(spellfocus_legend_lore), `varies', `range_you',,,
	`learn about one important person\komma place or object')')
define(`spell_leomunds_secret_chest', `spell_line(`Leomund\aps{}s Secret Chest',
	PHB 247, Conj, Summ, Planar, V S FE(spellfocus_leomunds_secret_chest), `10~min.', `range_touch', `until discharged\komma max.~60~d.',,
	`hide chest with up to {level_caster}~cb-ft of material on the Ethereal Plane')')
define(`spell_leomunds_secure_shelter', `spell_line(`Leomund\aps{}s Secure Shelter',
	PHB 247, Conj, Crea,, V S M F, `10~min.', `range_close', `eval(level_caster * 2)~h.~D', `20~sq-ft',
	`create cottage from surrounding material\komma including unseen servant')')
define(`spell_leomunds_tiny_hut', `spell_line(`Leomund\aps{}s Tiny Hut',
	PHB 247, Evoc,, Force Planar, V S M,, `20~ft', `eval(2 * level_caster)~h.~D',,
	`20-ft radius sphere protects from elemental conditions')')
define(`spell_leomunds_trap', `spell_line(`Leomund\aps{}s Trap',
	PHB 247, Ills, Glam,, V S ME(spellmaterial_leomunds_trap),, `range_touch', `permanent~D',,
	`lets mechanism seem trapped')')
define(`spell_levitate', `spell_line(`Levitate',
	PHB 248, Trns,,, V S F,, `range_close', `{level_caster}~min.~D',,
	`target creature or object (eval(100 * level_caster)~lbs.) can move up/down\komma speed: 20~ft')')
define(`spell_light', `spell_line(`Light',
	PHB 248, Evoc,, Light, V DF,, `range_touch', `eval(level_caster * 10)~min.~D',,
	`one object\komma 20~ft radius torch-like illumination')')
define(`spell_lightning_bolt', `spell_line(`Lightning Bolt',
	PHB 248, Evoc,, Elec, V S M,, `120~ft',, `120-ft li{}ne',
	`deal calc_min(10, level_caster)`'D6')')
define(`spell_limited_wish', `spell_line(`Limited Wish',
	PHB 248, Univ,,, V S XP,, `varies', `varies',,
	`duplicate spell or (un)do effect')')
define(`spell_liveoak', `spell_line(`Liveoak',
	PHB 248, Trns,,, V S, `10~min.', `range_touch', `{level_caster}~d.~D',,
	`turns one huge oak into treant')')
define(`spell_locate_creature', `spell_line(`Locate Creature',
	PHB 249, Divn,,, V S M,, `range_you', `eval(10 * level_caster)~min.', `range_long circle centered on you',
	`sense direction of nearest well-known creature')')
define(`spell_locate_object', `spell_line(`Locate Object',
	PHB 249, Divn,,, V S AF DF,, `range_you', `{level_caster}~min.', `range_long circle centered on you',
	`sense direction of nearest well-known or clearly visualized object')')
define(`spell_longstrider', `spell_line(`Longstrider',
	PHB 249, Trns,,, V S M,, `range_you', `{level_caster}~h.~D',,
	`+10~ft base land speed')')
define(`spell_lullaby', `spell_line(`Lullaby',
	PHB 249, Ench, Comp, Mind, V S,, `range_medium', `C + {level_caster}~rnd.~D', `10-ft radius burst',
	`living creatures become drowsy\komma -5 Listen and Spot\komma -2 Will against Sleep')')
define(`spell_mage_armor', `spell_line(`Mage Armor',
	PHB 249, Conj, Crea, Force Planar, V S F,, `range_touch', `{level_caster}~h.~D',,
	`target gains +4 armor bonus to AC, unencumbering')')
define(`spell_mage_hand', `spell_line(`Mage Hand',
	PHB 249, Trns,,, V S,, `range_close', `C',,
	`move one nonmagical object up to 5~lbs.')')
define(`spell_magic_circle_against_chaos', `spell_line(`Magic Circle against Chaos',
	PHB 249, Abjr,, Law Planar, V S AM DF,, `range_touch', `eval(level_caster * 10)~min.',,
	`+2 deflect AC\komma +2 resistance saves against chaotic sources, prevent possession, suppress mental control, prevent contact from chaotic summoned creatures, or bind one nonlawful called creature')')
define(`spell_magic_circle_against_evil', `spell_line(`Magic Circle against Evil',
	PHB 249, Abjr,, Good Planar, V S AM DF,, `range_touch', `eval(level_caster * 10)~min.',,
	`+2 deflect AC\komma +2 resistance saves against evil sources, prevent possession, suppress mental control, prevent contact from non-good summoned creatures, or bind one nongood called creature')')
define(`spell_magic_circle_against_good', `spell_line(`Magic Circle against Good',
	PHB 250, Abjr,, Evil Planar, V S AM DF,, `range_touch', `eval(level_caster * 10)~min.',,
	`+2 deflect AC\komma +2 resistance saves against good sources, prevent possession, suppress mental control, prevent contact from good summoned creatures, or bind one nonevil called creature')')
define(`spell_magic_circle_against_law', `spell_line(`Magic Circle against Law',
	PHB 250, Abjr,, Chaos Planar, V S AM DF,, `range_touch', `eval(level_caster * 10)~min.',,
	`+2 deflect AC\komma +2 resistance saves against lawful sources, prevent possession, suppress mental control, prevent contact from lawful summoned creatures, or bind one nonchaotic called creature')')
define(`spell_magic_fang', `spell_line(`Magic Fang',
	PHB 250, Trns,,, V S DF,, `range_touch', `{level_caster}~min.',,
	`+1 attack and damage \textbf{one} natural weapon')')
define(`spell_magic_fang_greater', `spell_line(`Magic Fang\komma Greater',
	PHB 250, Trns,,, V S DF,, `range_close', `{level_caster}~h.',,
	`+`'calc_min(eval(level_caster / 4), 5) attack and damage \textbf{one} natural weapon or +1 all')')
define(`spell_magic_jar', `spell_line(`Magic Jar',
	PHB 250, Necr,,, V S FE(spellfocus_magic_jar),, `range_medium', `until return\komma max.~1~h.',,
	`transfer your soul via jar to other bodies')')
define(`spell_magic_missile', `spell_line(`Magic Missile',
	PHB 251, Evoc,, Force Planar, V S,, `range_medium',,,
	`ifelse(eval(level_caster < 3),1,1 missile deals 1D4+1,calc_min(eval((level_caster + 1) / 2),5) missiles deal 1D4+1 each\komma can target independently within 15~ft)')')
define(`spell_magic_mouth', `spell_line(`Magic Mouth',
	PHB 251, Ills, Glam,, V S ME(spellmaterial_magic_mouth),, `range_close', `until activated',,
	`deliver up to 25-word-message upon visual and audible trigger')')
define(`spell_magic_stone', `spell_line(`Magic Stone',
	PHB 251, Trns,,, V S DF,, `range_touch', `30~min.',,
	`up to 3 pebbles gain +1 attack and deal 1D6+1 damage (double against undead)')')
define(`spell_magic_vestment', `spell_line(`Magic Vestment',
	PHB 251, Trns,,, V S DF,, `range_touch', `{level_caster}~h.',,
	`touched suit of armor \textbf{or} shield gains +`'calc_min(5, eval(level_caster / 4)) enhancement bonus')')
define(`spell_magic_weapon', `spell_line(`Magic Weapon',
	PHB 251, Trns,,, V S DF,, `range_touch', `{level_caster}~min.',,
	`one weapon (not natural): +1 enhancement bonus')')
define(`spell_magic_weapon_greater', `spell_line(`Magic Weapon\komma Greater',
	PHB 251, Trns,,, V S AM DF,, `range_close', `{level_caster}~h.',,
	`one weapon (not natural) or 50 projectiles: +calc_min(eval(level_caster / 4),5) enhancement bonus')')
define(`spell_major_creation', `spell_line(`Major Creation',
	PHB 253, Conj, Crea,, V S M, `10~min.', `range_close', `varies', `{level_caster}~cb-ft',
	`create nonmagical\komma unattended object of nonliving\komma vegetable or mineral matter\komma need appropriate craft skill check')')
define(`spell_major_image', `spell_line(`Major Image',
	PHB 252, Ills, Figm,, V S F,, `range_long', `C + 3~rnd.',,
	`create mobile, visual, audible, olfactory, thermal figment within eval(4 + level_caster) 10-ft cubes')')
define(`spell_make_whole', `spell_line(`Make Whole',
	PHB 252, Trns,,, V S,, `range_close',,,
	`one object of up to eval(10 * level_caster)~lbs.')')
define(`spell_mark_of_justice', `spell_line(`Mark of Justice',
	PHB 252, Necr,,, V S DF, `10~min.', `range_touch', `permanent',,
	`inscribed mark activates curse upon defined behavior')')
define(`spell_maze', `spell_line(`Maze',
	PHB 252, Conj, Tele, Planar, V S,, `range_close', `varies\komma max.~10~min.',,
	`banish one creature into extra-dimensional labyrinth\komma needs DC~20 I{}N{}T check to return')')
define(`spell_meld_into_stone', `spell_line(`Meld into Stone',
	PHB 252, Trns,, Earth, V S DF,, `range_you', `eval(level_caster * 10)~min.',,
	`you and up to 100~lbs.~gear meld into large enough single block of stone\komma can still hear and cast spells on yourself')')
define(`spell_melfs_acid_arrow', `spell_line(`Melf\aps{}s Acid Arrow',
	PHB 253, Conj, Crea, Acid, V S M F,, `range_long', `eval(1 + (calc_min(level_caster, 18) / 3))~rnd.',,
	`attack_touch_ranged ranged touch attack\komma deal 2D4 acid damage each round')')
define(`spell_mending', `spell_line(`Mending',
	PHB 253, Trns,,, V S,, `10~ft',,,
	`repair one object of up to 1 lb.')')
define(`spell_message', `spell_line(`Message',
	PHB 253, Trns,, Lang, V S F,, `range_medium', `eval(level_caster * 10)~min.',,
	`whisper to and back from {level_caster} targets')')
define(`spell_meteor_swarm', `spell_line(`Meteor Swarm',
	PHB 253, Evoc,, Fire, V S,, `range_long',, `four 40-ft radius spreads',
	`deal 6D6 fire and -- if hit by attack_touch_ranged ranged touch attack -- 2D6 bludgeoning for each meteor')')
define(`spell_mind_blank', `spell_line(`Mind Blank',
	PHB 253, Abjr,,, V S,, `range_close', `24~h.',,
	`protect one creature from all effects that detect\komma read or influence emotions and thoughts')')
define(`spell_mind_fog', `spell_line(`Mind Fog',
	PHB 253, Ench, Comp, Mind, V S,, `range_medium', `30~min.', `20-ft radius\komma 20-ft high fog spread',
	`within fog and 2D6~rnd.~thereafter suffer -10 W{}I{}S checks and Will Saves')')
define(`spell_minor_creation', `spell_line(`Minor Creation',
	PHB 253, Conj, Crea,, V S M, `1~min.', `0~ft', `{level_caster}~h.~D', `{level_caster}~cb-ft',
	`create nonmagical\komma unattended object of nonliving\komma vegetable matter\komma need appropriate craft skill check')')
define(`spell_minor_image', `spell_line(`Minor Image',
	PHB 254, Ills, Figm,, V S F,, `range_long', `C + 2~rnd.',,
	`create mobile, visual and audible figment within eval(4 + level_caster) 10-ft cubes')')
define(`spell_miracle', `spell_line(`Miracle',
	PHB 254, Evoc,,, V S XP,, `varies', `varies',,
	`duplicate spell or (un)do effect or request powerful effect')')
define(`spell_mirage_arcana', `spell_line(`Mirage Arcana',
	PHB 254, Ills, Glam,, V S,, `range_long', `C + {level_caster}~h.~D', `{level_caster} 20-ft cubes~S',
	`change any terrain character (visual\komma audible\komma olfactory\komma tactile) including structures')')
define(`spell_mirror_image', `spell_line(`Mirror Image',
	PHB 254, Ills, Figm,, V S,, `range_you', `{level_caster}~min.~D',,
	`1D4+`'eval(level_caster / 3) (max.~8) illusory doubles of you fool attackers\komma destroyed when hit (AC eval(10 + stat_size_AC_mod(stat_size) + DEX))')')
define(`spell_misdirection', `spell_line(`Misdirection',
	PHB 254, Ills, Glam,, V S,, `range_close', `{level_caster}~h.',,
	`fool aura-divinations by misdirecting them to alternative target')')
define(`spell_mislead', `spell_line(`Mislead',
	PHB 255, Ills, Figm Glam,, S,, `range_close', `varies',,
	`you turn invisible for {level_caster}~rnd., an illusory double acts by concentration +3~rnd.')')
define(`spell_modify_memory', `spell_line(`Modify Memory',
	PHB 255, Ench, Comp, Mind, V S, `1~rnd.+5~min.', `range_close', `duration_permanent',,
	`modify 5 minutes of memory of one living creature')')
define(`spell_moment_of_prescience', `spell_line(`Moment of Prescience',
	PHB 255, Divn,,, V S,, `range_you', `{level_caster}~h.~until discharged',,
	`once within duration grant +`'calc_min(25, level_caster) insight bonus to attack\komma opposed ability/skill check\komma saving throw or A{}C')')
define(`spell_mordenkainens_disjunction', `spell_line(`Mordenkainen\aps{}s Disjunction',
	PHB 255, Abjr,,, V,, `range_close',, `40-ft radius burst',
	`all magic effects and magic items (except yours) are disjoined (even {level_caster}\% chance for Antimagic Field and artefacts)')')
define(`spell_mordenkainens_faithful_hound', `spell_line(`Mordenkainen\aps{}s Faithful Hound',
	PHB 255, Conj, Crea,, V S M,, `range_close', `{level_caster}~h.~until discharged',,
	`invisible phantom watchdog\komma activated for {level_caster}~rnd.~if approached 30~ft: bark\komma then attack within 5~ft')')
define(`spell_mordenkainens_lucubration', `spell_line(`Mordenkainen\aps{}s Lucubration',
	PHB 256, Trns,,, V S,, `range_you',,,
	`recall one spell of up to 5th level actually cast within past 24~h.')')
define(`spell_mordenkainens_magnificent_mansion', `spell_line(`Mordenkainen\aps{}s Magnificent Mansion',
	PHB 256, Conj, Crea, Planar, V S FE(spellfocus_mordenkainens_magnificent_mansion),, `range_close', `eval(2 * level_caster)~h.~D', `eval(3 * level_caster) 10-ft cubes~S',
	`extradimensional dwelling with single entrance\komma high-quality food for eval(12 * level_caster) persons\komma eval(2 * level_caster) servants')')
define(`spell_mordenkainens_private_sanctum', `spell_line(`Mordenkainen\aps{}s Private Sanctum',
	PHB 256, Abjr,,, V S M, `10~min.', `range_close', `24~h.~D',,
	`privacy is provided within {level_caster} 30-ft-cubes')')
define(`spell_mordenkainens_sword', `spell_line(`Mordenkainen\aps{}s Sword',
	PHB 256, Evoc,, Force Planar, V S FE(spellfocus_mordenkainens_sword),, `range_close', `{level_caster}~rnd.~D',,
	`sword of force attacks foes at emph_sign(eval(level_caster + ifelse(token_caster,wizard,INT,token_caster,sorcerer,CHA,0) + 3)) and deals 4D6+3 damage 19/{}$\times${}2\komma A{}C 13')')
define(`spell_mount', `spell_line(`Mount',
	PHB 256, Conj, Summ,, V S M, `1~rnd.', `range_close', `eval(level_caster * 2)~h.~D',,
	`light horse or pony serves as mount')')
define(`spell_move_earth', `spell_line(`Move Earth',
	PHB 257, Trns,, Earth, V S M, `10~min./150-ft.~sq.', `range_long',, `750~ft{}$\times${}750~ft\komma 10~ft deep~S',
	`slowly move earth\komma not rocks\komma cannot create tunnel')')
define(`spell_neutralize_poison', `spell_line(`Neutralize Poison',
	PHB 257, Conj, Heal,, V S AM DF,, `range_touch', `eval(level_caster * 10)~min.',,
	`remove all venoms in creature or object (up to {level_caster}~cu.ft)')')
define(`spell_nightmare', `spell_line(`Nightmare',
	PHB 257, Ills, Phan, Mind Evil, V S, `10~min.', `$\infty$',,,
	`disturbs rest of one sleeping living creature and deals 1D10\komma fatigued\komma cannot regain arcane spells for 24~h.')')
define(`spell_nondetection', `spell_line(`Nondetection',
	PHB 257, Abjr,,, V S ME(spellmaterial_nondetection),, `range_touch', `{level_caster}~h.',,
	`protect from divination magic')')
define(`spell_nystuls_magic_aura', `spell_line(`Nystul\aps{}s Magic Aura',
	PHB 257, Ills, Glam,, V S F,, `range_touch', `{level_caster}~d.~D',,
	`alter detectable aura of one object up to {eval(5 * level_caster)}~lbs.')')
define(`spell_obscure_object', `spell_line(`Obscure Object',
	PHB 258, Abjr,,, V S AM DF,, `range_touch', `8~h.~D',,
	`prevent srying on one object up to {eval(100 * level_caster)}~lbs.')')
define(`spell_obscuring_mist', `spell_line(`Obscuring Mist',
	PHB 258, Conj, Crea,, V S,,, `{level_caster}~min.', `20~ft radius and 20~ft high stationary cloud spread around you',
	`concealment up to 5~ft\komma total beyond')')
define(`spell_open_close', `spell_line(`Open/Close',
	PHB 258, Trns,,, V S F,, `range_close',,,
	`open \textbf{or} close one nonbarred door or container\komma up to 30~lbs.')')
define(`spell_orders_wrath', `spell_line(`Order\aps{}s Wrath',
	PHB 258, Evoc,, Law, V S,, `range_medium',, `30-ft cube burst',
	`deal calc_min(5, eval(level_caster / 2))`'D8 to chaotic creatures (neutral half) and daze 1~rnd.')')
define(`spell_otilukes_freezing_sphere', `spell_line(`Otiluke\aps{}s Freezing Sphere',
	PHB 258, Evoc,, Cold, V S F,, `range_long', `', `',
	`deal calc_min(15, level_caster)`'D6 cold within 10-ft radius burst and freeze liquid within {level_caster} 10-ft squares at 6~inch depth for {level_caster}~rnd.\komma trapping creatures')')
define(`spell_otilukes_resilient_sphere', `spell_line(`Otiluke\aps{}s Resilient Sphere',
	PHB 258, Evoc,, Force Planar, V S M,, `range_close', `{level_caster}~min.~D', `{level_caster}-ft diameter sphere',
	`enclose one fitting creature within sphere of force')')
define(`spell_otilukes_telekinetic_sphere', `spell_line(`Otiluke\aps{}s Telekinetic Sphere',
	PHB 259, Evoc,, Force Planar, V S M,, `range_close', `{level_caster}~min.~D', `{level_caster}-ft diameter sphere',
	`enclose fitting creatures within sphere of force\komma reduce their weight to 1/16 and move them or the sphere telekinetically')')
define(`spell_ottos_irresistible_dance', `spell_line(`Otto\aps{}s Irresistible Dance',
	PHB 259, Ench, Comp, Mind, V,, `range_touch', `1D4+1~rnd.',,
	`one living creature dances\komma -4~A{}C\komma negate shield-A{}C\komma -10~reflex saves\komma provoke attacks of opportunity')')
define(`spell_overland_flight', `spell_line(`Overland Flight',
	PHB 259, Trns,,, V S,, `range_you', `{level_caster}~h.',,
	`speed 40~ft (30~ft with medium or heavy encumbrance), average maneuverability\komma can hustle without nonlethal damage')')
define(`spell_owls_wisdom', `spell_line(`Owl\aps s Wisdom',
	PHB 259, Trns,,, V S AM DF,, `range_touch', `{level_caster}~min.',,
	`+4 W{}I{}S score')')
define(`spell_owls_wisdom_mass', `spell_line(`Owl\aps s Wisdom\komma Mass',
	PHB 259, Trns,,, V S AM DF,, `range_close', `{level_caster}~min.',,
	`+4 W{}I{}S score for {level_caster} targets')')
define(`spell_passwall', `spell_line(`Passwall',
	PHB 259, Trns,,, V S M,, `range_touch', `{level_caster}~h.~D', `5-ft $\times$ 8-ft opening\komma ifelse(eval(level_caster < 12),1,10,eval(level_caster < 15),1,15,eval(level_caster < 18),1,20,25)`'-ft deep',
	`create passage through wood\komma plaster or stone\komma but not metal or harder material')')
define(`spell_pass_without_trace', `spell_line(`Pass without Trace',
	PHB 259, Trns,,, V S DF,, `range_touch', `{level_caster}~h.~D',,
	`{level_caster} creatures cannot be tracked by nonmagical means')')
define(`spell_permanency', `spell_line(`Permanency',
	PHB 259, Univ,,, V S XP, `2~rnd.', `varies', `duration_permanent',,
	`extend other spell permanently')')
define(`spell_permanent_image', `spell_line(`Permanent Image',
	PHB 260, Ills, Figm,, V S ME(spellmaterial_permanent_image),, `range_long', `duration_permanent', `eval(4 + level_caster) 10-ft cubes~S',
	`create mobile (needs concentration)\komma visual\komma auditory\komma olfactory and thermal figment')')
define(`spell_persistent_image', `spell_line(`Persistent Image',
	PHB 260, Ills, Figm,, V S M,, `range_long', `{level_caster}~min.~D', `eval(4 + level_caster) 10-ft cubes',
	`create mobile (predefined action)\komma visual\komma auditory\komma olfactory and thermal figment')')
define(`spell_phantasmal_killer', `spell_line(`Phantasmal Killer',
	PHB 260, Ills, Phan, Fear Mind, V S,, `range_medium',,,
	`Illusion delivers deadly fear attack to one living creature')')
define(`spell_phantom_steed', `spell_line(`Phantom Steed',
	PHB 260, Conj, Crea,, V S, `10~min.',, `{level_caster}~h.~D',,
	`horse-like creature carries defined rider and eval(level_caster * 10)~lbs.\komma AC 18\komma eval(7 + level_caster)~hits\komma soundless\komma speed calc_min(eval(level_caster * 20), 240)~ft`'ifelse(eval(level_caster >= 8),1,`\komma ride over sandy to swampy ground')`'ifelse(eval(level_caster >= 10),1,`\komma water walk')`'ifelse(eval(level_caster >= 12),1,`\komma air walk (1~rnd.)')`'ifelse(eval(level_caster >= 14),1,`\komma fly (ave{}rage)')')')
define(`spell_phase_door', `spell_line(`Phase Door',
	PHB 261, Conj, Crea,, V,, `0~ft', `eval(level_caster / 2) usages', `5-ft $\times$ 8-ft opening\komma eval(10 + (5 * (level_caster / 3)))`'-ft deep',
	`ethereal passage through wood\komma plaster and stone\komma accessible only by you plus one other creature or predefined other creatures')')
define(`spell_planar_ally', `spell_line(`Planar Ally',
	PHB 261, Conj, Call, Planar Varies, V S DF XP, `10~min.', `range_close',,,
	`call one or two elemental(s) or outsider(s) of $\le${}12~HD in sum\komma ask it for task to perform for payment')')
define(`spell_planar_ally_greater', `spell_line(`Planar Ally\komma Greater',
	PHB 261, Conj, Call, Planar Varies, V S DF XP, `10~min.', `range_close',,,
	`call one to three elemental(s) or outsider(s) of $\le${}18~HD in sum\komma ask it for task to perform for payment')')
define(`spell_planar_ally_lesser', `spell_line(`Planar Ally\komma Lesser',
	PHB 261, Conj, Call, Planar Varies, V S DF XP, `10~min.', `range_close',,,
	`call elemental or outsider of $\le${}6~HD\komma ask it for task to perform for payment')')
define(`spell_planar_binding', `spell_line(`Planar Binding',
	PHB 261, Conj, Call, Planar Varies, V S, `10~min.', `range_close',,,
	`call up to three elementals or outsiders $\le${}12~HD in sum into trap (magic circle) to demand a service')')
define(`spell_planar_binding_greater', `spell_line(`Planar Binding\komma Greater',
	PHB 261, Conj, Call, Planar Varies, V S, `10~min.', `range_close',,,
	`call up to three elementals or outsiders $\le${}18~HD in sum into trap (magic circle) to demand a service')')
define(`spell_planar_binding_lesser', `spell_line(`Planar Binding\komma Lesser',
	PHB 261, Conj, Call, Planar Varies, V S, `10~min.', `range_close',,,
	`call one elemental or outsider $\le${}6~HD into trap (magic circle) to demand a service')')
define(`spell_plane_shift', `spell_line(`Plane Shift',
	PHB 262, Conj, Tele, Planar, V S F,, `range_touch',,,
	`move either you with eight creatures or one single creature to a different plane')')
define(`spell_plant_growth', `spell_line(`Plant Growth',
	PHB 262, Trns,,, V S DF,,,,`100-ft radius within range_long or 1/2 mile around you',
	`overgrow and entwine or enrich year-productivity by 1/3')')
define(`spell_poison', `spell_line(`Poison',
	PHB 262, Necr,,, V S DF,, `range_touch',,,
	`{attack_touch_melee} melee touch attack deals 1D10 C{}O{}N damage (initial and again after 1~min.) to living creature\komma DC eval(10 + (level_caster / 2) + WIS)')')
define(`spell_polar_ray', `spell_line(`Polar Ray',
	PHB 262, Evoc,, Cold, V S F,, `range_close',,,
	`attack_touch_ranged ranged touch attack to deal calc_min(25, level_caster)D6 cold damage')')
define(`spell_polymorph', `spell_line(`Polymorph',
	PHB 263, Trns,,, V S M,, `range_touch', `{level_caster}~min.~D',,
	`target form: fine size or larger\komma max.~`'calc_min(level_caster,15)~HD\komma gain several qualities')')
define(`spell_polymorph_any_object', `spell_line(`Polymorph any Object',
	PHB 263, Trns,,, V S AM DF,, `range_close', `varies',,
	`transform one creature or nonmagical object (up to eval(100 * level_caster)~cb-ft) into something else')')
define(`spell_power_word_blind', `spell_line(`Power Word Blind',
	PHB 263, Ench, Comp, Mind, V,, `range_close', `varies',,
	`blind one creature according to its current hitpoints: $\le${}50: permanent\komma 51--100: 1D4+1~min.\komma 101--200: 1D4+1~rnd.\komma $>${}200: unaffected')')
define(`spell_power_word_kill', `spell_line(`Power Word Kill',
	PHB 263, Ench, Comp, Death Mind, V,, `range_close',,,
	`kill one creature with $\le${}100 current hitpoints')')
define(`spell_power_word_stun', `spell_line(`Power Word Stun',
	PHB 263, Ench, Comp, Mind, V,, `range_close', `varies',,
	`stun one creature according to its current hitpoints: $\le${}50: 4D4~rnd.\komma 51--100: 2D4~rnd.\komma 101--150: 1D4~rnd.\komma $>${}151: unaffected')')
define(`spell_prayer', `spell_line(`Prayer',
	PHB 264, Ench, Comp, Mind, V S DF,, `40~ft', `{level_caster}~rnd.',,
	`allies +1 on attacks, damage, saves and skills, enemies -1')')
define(`spell_prestidigitation', `spell_line(`Prestidigitation',
	PHB 264, Univ,,, V S,, `10~ft', `1~h.',,
	`perform minor trick-effects')')
define(`spell_prismatic_sphere', `spell_line(`Prismatic Sphere',
	PHB 264, Abjr,,, V,, `10~ft', `eval(10 * level_caster)~min.~D', `10-ft radius immobile sphere centered on you',
	`seven-layered sphere protects from anything\komma you can pass\komma creatures of $<${}8~HD within 20~ft are blinded for 2D4{}$\times${}10~min.')')
define(`spell_prismatic_spray', `spell_line(`Prismatic Spray',
	PHB 264, Evoc,,, V S,, `60~ft',, `60-ft cone shaped burst',
	`every creature is struck by one of seven different effects\komma creatures with $\le${}8~HD automatically blinded for 2D4~rnd.')')
define(`spell_prismatic_wall', `spell_line(`Prismatic Wall',
	PHB 264, Abjr,,, V S,, `range_close', `eval(10 * level_caster)~min.~D', `eval(4 * level_caster)~ft wide\komma eval(2 * level_caster)~ft high immobile wall',
	`seven-layered wall protects from anything\komma you can pass\komma creatures of $<${}8~HD within 20~ft are blinded for 2D4~rnd.')')
define(`spell_produce_flame', `spell_line(`Produce Flame',
	PHB 265, Evoc,, Fire, V S,, `range_you', `{level_caster}~min.~D',,
	`{attack_touch_melee} melee or {attack_touch_ranged} ranged (120~ft) touch attack (1D6+calc_min(level_caster, 5))')')
define(`spell_programmed_image', `spell_line(`Programmed Image',
	PHB 265, Ills, Figm,, V S ME(spellmaterial_programmed_image),, `range_long', `until triggered', `eval(8 + level_caster) 10-ft cubes~S',
	`upon trigger: mobile\komma visual\komma auditory\komma olfactory and thermal figment for {level_caster}~rnd.')')
define(`spell_project_image', `spell_line(`Project Image',
	PHB 265, Ills, Shdw,, V S ME(spellmaterial_project_image),, `range_medium', `{level_caster}~rnd.~D',,
	`create shadow duplicate of yourself\komma can use its eyes and ears\komma can cast spells through it\komma must maintain li{}ne of effect')')
define(`spell_protection_from_arrows', `spell_line(`Protection from Arrows',
	PHB 266, Abjr,,, V S F,, `range_touch', `{level_caster}~h.',,
	`gain damage reduction 10/magic against ranged weapons, protect for max.~`'calc_min(eval(level_caster * 10),100)')')
define(`spell_protection_from_chaos', `spell_line(`Protection from Chaos',
	PHB 266, Abjr,, Law Planar, V S AM DF,, `range_touch', `{level_caster}~min.~D',,
	`+2 deflect AC\komma +2 resistance saves\komma ward from mental control \& summons')')
define(`spell_protection_from_energy', `spell_line(`Protection from Energy',
	PHB 266, Abjr,,, V S DF,, `range_touch', `eval(level_caster * 10)~min.',,
	`absorb up to calc_min(eval(level_caster * 12), 120) points of damage from one type of energy')')
define(`spell_protection_from_evil', `spell_line(`Protection from Evil',
	PHB 266, Abjr,, Good Planar, V S AM DF,, `range_touch', `{level_caster}~min.~D',,
	`+2 deflect AC\komma +2 resistance saves\komma ward from mental control \& summons')')
define(`spell_protection_from_good', `spell_line(`Protection from Good',
	PHB 266, Abjr,, Evil Planar, V S AM DF,, `range_touch', `{level_caster}~min.~D',,
	`+2 deflect AC\komma +2 resistance saves\komma ward from mental control \& summons')')
define(`spell_protection_from_law', `spell_line(`Protection from Law',
	PHB 266, Abjr,, Chaos Planar, V S AM DF,, `range_touch', `{level_caster}~min.~D',,
	`+2 deflect AC\komma +2 resistance saves\komma ward from mental control \& summons')')
define(`spell_protection_from_spells', `spell_line(`Protection from Spells',
	PHB 266, Abjr,,, V S ME(spellmaterial_protection_from_spells) FE(spellfocus_protection_from_spells),, `range_touch', `eval(level_caster * 10)~min.',,
	`+8 saves against spells and spell-like abilities for eval(level_caster / 4) targets')')
define(`spell_prying_eyes', `spell_line(`Prying Eyes',
	PHB 266, Divn,,, V S M, `1~min.', `1~mile', `{level_caster}~h.~D',,
	`create 1D4+{level_caster} eyes: 120~ft normal vision like you\komma 1 hitpoint\komma A{}C 18\komma fly at speed 30~ft (perfect)\komma +16 hide\komma +calc_min(15, level_caster) spot\komma give them instructions to perform\komma eye must touch you to report information then fades')')
define(`spell_prying_eyes_greater', `spell_line(`Prying Eyes\komma Greater',
	PHB 267, Divn,,, V S M, `1~min.', `1~mile', `{level_caster}~h.~D',,
	`create 1D4+{level_caster} eyes: 120~ft true sight\komma 1 hitpoint\komma A{}C 18\komma fly at speed 30~ft (perfect)\komma +16 hide\komma +calc_min(25, level_caster) spot\komma give them instructions to perform\komma eye must touch you to report information then fades')')
define(`spell_purify_food_drink', `spell_line(`Purify Food and Drink',
	PHB 267, Trns,,, V S,, `10~ft',, `{level_caster}~cu.ft',
	`remove spoilage\komma poison etc.')')
define(`spell_pyrotechnics', `spell_line(`Pyrotechnics',
	PHB 267, Trns,,, V S M,, `range_long', `1D4+1~rnd.',,
	`turn fire into instant firework (blinding within 120\aps) or {level_caster}~rnd.~20-ft radius smoke cloud (block sight and -4 S{}T{}R and D{}E{}X)')')
define(`spell_quench', `spell_line(`Quench',
	PHB 267, Trns,,, V S DF,, `range_medium',,,
	`{level_caster} areas, each 20~ft cubes, dispel checks against fire spell, calc_min(level_caster, 15)`'D6 damage to elemental fire creatures')')
define(`spell_rage', `spell_line(`Rage',
	PHB 268, Ench, Comp, Mind, V S,, `range_medium', `C+{level_caster}~rnd.~D',,
	`eval(level_caster / 3) living targets gain +2 S{}T{}R and C{}O{}N, +1 Will, -2 AC')')
define(`spell_rainbow_pattern', `spell_line(`Rainbow Pattern',
	PHB 268, Ills, Patt, Mind, `ifelse(token_caster,bard,V ,)`'S M F',, `range_medium', `C + {level_caster}~rnd.', `20-ft radius spread',
	`fascinate 24~HD of creatures (want to remain in area)\komma can move rainbow at speed 30~ft')')
define(`spell_raise_dead', `spell_line(`Raise Dead',
	PHB 268, Conj, Heal,, V S ME(spellmaterial_raise_dead) DF, `1~min.', `range_touch',,,
	`restore life to one creature dead up to {level_caster} days\komma creature loses one level')')
define(`spell_rarys_mnemonic_enhancer', `spell_line(`Rary\aps{}s Mnemonic Enhancer',
	PHB 268, Trns,,, V S M FE(spellfocus_rarys_mnemonic_enhancer), `10~min.', `range_you',,,
	`prepare up to three levels of additional spells \textbf{or} retain spell cast immediately before of up to third level')')
define(`spell_rarys_telepathic_bond', `spell_line(`Rary\aps{}s Telepathic Bond',
	PHB 268, Divn,,, V S M,, `range_close', `eval(10 * level_caster)~min.~D',,
	`you and eval(level_caster / 3) creatures (I{}N{}T$\ge${}3) can communicate telepathically')')
define(`spell_ray_of_enfeeblement', `spell_line(`Ray of Enfeeblement',
	PHB 269, Necr,,, V S,, `range_close', `{level_caster}~min.',,
	`attack_touch_ranged ranged touch attack deals 1D6+calc_min(5, eval(level_caster / 2)) S{}T{}R penalty')')
define(`spell_ray_of_exhaustion', `spell_line(`Ray of Exhaustion',
	PHB 269, Necr,,, V S M,, `range_close', `{level_caster}~min.',,
	`attack_touch_ranged ranged touch attack exhausts / fatigues target')')
define(`spell_ray_of_frost', `spell_line(`Ray of Frost',
	PHB 269, Evoc,, Cold, V S,, `range_close',,,
	`attack_touch_ranged ranged touch attack deals 1D3 cold damage')')
define(`spell_read_magic', `spell_line(`Read Magic',
	PHB 269, Divn,,, V S F,, `range_you', `eval(level_caster * 10)~min.',,
	`decipher magical inscriptions')')
define(`spell_reduce_animal', `spell_line(`Reduce Animal',
	PHB 269, Trns,,, V S,, `range_touch', `{level_caster}~h.~D',,
	`shrink willing animal (small -- huge) by one size category')')
define(`spell_reduce_person', `spell_line(`Reduce Person',
	PHB 269, Trns,,, V S M, `1~rnd.', `range_close', `{level_caster}~min.~D',,
	`shrink humanoid person by one size category')')
define(`spell_reduce_person_mass', `spell_line(`Reduce Person\komma Mass',
	PHB 269, Trns,,, V S M, `1~rnd.', `range_close', `{level_caster}~min.~D',,
	`shrink up to {level_caster} humanoid persons within 30~ft by one size category')')
define(`spell_refuge', `spell_line(`Refuge',
	PHB 269, Conj, Tele,, V S ME(spellmaterial_refuge),, `range_touch', `until discharged',,
	`prepare object: when broken and trigger word spoken its teleports its current possessor to you or vice versa')')
define(`spell_regenerate', `spell_line(`Regenerate',
	PHB 270, Conj, Heal,, V S DF, `3~full rnd.', `range_touch',,,
	`regenerate body parts\komma heal 4D8+{calc_min(level_caster, 35)}')')
define(`spell_reincarnate', `spell_line(`Reincarnate',
	PHB 270, Trns,,, V S ME(spellmaterial_reincarnate) DF, `10~min.', `range_touch',,,
	`create new body for dead creature')')
define(`spell_remove_blindness_deafness', `spell_line(`Remove Blindness / Deafness',
	PHB 270, Conj, Heal,, V S,, `range_touch',,,
	`cure blindness or deafness')')
define(`spell_remove_curse', `spell_line(`Remove Curse',
	PHB 270, Abjr,,, V S,, `range_touch',,,
	`remove all curses from creature or some object')')
define(`spell_remove_disease', `spell_line(`Remove Disease',
	PHB 271, Conj, Heal,, V S,, `range_touch',,,
	`cure all diseases, kill all parasites')')
define(`spell_remove_fear', `spell_line(`Remove Fear',
	PHB 271, Abjr,,, V S,, `range_close', `10~min.',,
	`{eval(1 + (level_caster / 4))} creatures gain +4 moral against fear or suppress fear')')
define(`spell_remove_paralysis', `spell_line(`Remove Paralysis',
	PHB 271, Conj, Heal,, V S,, `range_close',,,
	`heal up to 4 creatures from temporary paralysis of any kind')')
define(`spell_repel_metal_or_stone', `spell_line(`Repel Metal or Stone',
	PHB 271, Abjr,, Earth, V S,, `60~ft', `{level_caster}~rnd.~D',,
	`60~ft li{}ne shaped emanation')')dnl width of wave 60 ft ???
define(`spell_repel_vermin', `spell_line(`Repel Vermin',
	PHB 271, Abjr,,, V S DF,, `', `eval(level_caster * 10)~min.~D', `10~ft radius emanation mobile centered on you',
	`vermin $<${}`'eval(level_caster / 3)`'HD cannot pass\komma others take 2D6')')
define(`spell_repel_wood', `spell_line(`Repel Wood',
	PHB 271, Trns,,, V S,, `60~ft', `{level_caster}~min.~D',,
	`60~ft li{}ne shaped emanation')')dnl width of wave 60 ft ???
define(`spell_repulsion', `spell_line(`Repulsion',
	PHB 271, Abjr,,, V S AFE(spellfocus_repulsion) DF,, `eval(10 * level_caster)~ft', `{level_caster}~rnd.~D', `eval(10 * level_caster)~ft radius emanation centered on you',
	`keep creatures from aproaching you')')
define(`spell_resistance', `spell_line(`Resistance',
	PHB 272, Abjr,,, V S DF,, `range_touch', `1~min.',,
	`+1 saves')')
define(`spell_resist_energy', `spell_line(`Resist Energy',
	PHB 272, Abjr,,, V S DF,, `range_touch', `eval(level_caster * 10)~min.',,
	`gain resistance ifelse(eval(level_caster >= 11),1,30,eval(level_caster >= 7),1,20,10) to one type of energy: acid\komma cold\komma electricity\komma fire\komma sonic')')
define(`spell_restoration_lesser', `spell_line(`Restoration\komma Lesser',
	PHB 272, Conj, Heal,, V S, `3~rnd.', `range_touch',,,
	`dispel magic effects penalizing one ability score\komma cure 1D4 damage for one ability score\komma cure fatigue\komma improve exhaustion to fatigue')')
define(`spell_restoration', `spell_line(`Restoration',
	PHB 272, Conj, Heal,, V S ME(spellmaterial_restoration), `3~rnd.', `range_touch',,,
	`dispel magic effects penalizing one ability score\komma cure all damage for all ability scores\komma restore all drained points for one ability score (except C{}O{}N due to death)\komma cure fatigue and exhaustion\komma dispel all negative levels\komma restore one drained level (except from death)')')
define(`spell_restoration_greater', `spell_line(`Restoration\komma Greater',
	PHB 272, Conj, Heal,, V S XP, `10~min.', `range_touch',,,
	`dispel magic effects penalizing all ability scores\komma cure all damage for all ability scores\komma restore all drained points for all ability scores (except C{}O{}N due to death)\komma cure fatigue and exhaustion\komma dispel all negative levels\komma restore all drained levels (except from death)\komma remove mental illnesses')')
define(`spell_resurrection', `spell_line(`Resurrection',
	PHB 272, Conj, Heal,, V S ME(spellmaterial_resurrection) DF, `10~min.', `range_touch',,,
	`restore life to one creature dead up to eval(10 * level_caster)~years\komma creature loses one level')')
define(`spell_reverse_gravity', `spell_line(`Reverse Gravity',
	PHB 273, Trns,,, V S AM DF,, `range_medium', `{level_caster}~rnd.~D',,
	`eval(level_caster / 2) 10-ft cubes')')
define(`spell_righteous_might', `spell_line(`Righteous Might',
	PHB 273, Trns,,, V S DF,, `range_you', `{level_caster}~rnd.~D',,
	`you plus equipment grow by one size category\komma gain modifiers and damage reduction ifelse(eval(level_caster < 12),1,5,eval(level_caster < 15),1,10,15)`'/ifelse(char_turn_polarity,1,evil,good)')')
define(`spell_rope_trick', `spell_line(`Rope Trick',
	PHB 273, Trns,, Planar, V S M,, `range_touch', `{level_caster}~h.~D',,
	`one 5--30-ft long rope is tied to extradimensional space')')
define(`spell_rusting_grasp', `spell_line(`Rusting Grasp',
	PHB 273, Trns,,, V S DF,, `range_touch', `varies',,
	`one non-magical ferrous object or a ferrous creature')')
define(`spell_sanctuary', `spell_line(`Sanctuary',
	PHB 274, Abjr,,, V S DF,, `range_touch', `{level_caster}~rnd.',,
	`warded creature cannot be aiming attacked (will save for attacker)')')
define(`spell_scare', `spell_line(`Scare',
	PHB 274, Necr,, Fear Mind, V S M,, `range_medium', `varies',,
	`eval(level_caster / 3) living targets ($\le${}5 HD) frightened ({level_caster}~rnd.) or shaken (1~rnd.)')')
define(`spell_scintillating_pattern', `spell_line(`Scintillating Pattern',
	PHB 274, Ills, Patt, Mind, V S M,, `range_close', `C + 2~rnd.', `20-ft radius spread',
	`affect (unless sightless) summed up to calc_min(20, level_caster)~HD of creatures: (cumulative) $\le${}6~HD unconscious 1D4 rnd.\komma $\le${}12~HD stunned 1D4 rnd.\komma all other confused 1D4 rnd.')')
define(`spell_scorching_ray', `spell_line(`Scorching Ray',
	PHB 274, Evoc,, Fire, V S,, `range_close',,,
	`ifelse(eval(level_caster < 7),1,one,eval(level_caster < 11),1,two,three) ray`'ifelse(eval(level_caster >= 7),1,s) deal 4D6 (attack_touch_ranged ranged touch attack) each')')
define(`spell_screen', `spell_line(`Screen',
	PHB 274, Ills, Glam,, V S, `10~min.', `range_close', `24~h.', `{level_caster} 30-ft cubes~S',
	`create false scene against scrying and direct observation')')
define(`spell_scrying', `spell_line(`Scrying',
	PHB 274, Divn, Scry,, V S AM DF FE(spellfocus_scrying), `1~h.', `$\infty$', `{level_caster}~min.',,
	`see and hear specific creature and 10~ft radius around\komma calc_min(100, eval(level_caster * 5))\% chance to transmit special spells')')
define(`spell_scrying_greater', `spell_line(`Scrying\komma Greater',
	PHB 275, Divn, Scry,, V S,, `$\infty$', `{level_caster}~h.',,
	`see and hear specific creature and 10~ft radius around\komma can transmit special spells')')
define(`spell_sculpt_sound', `spell_line(`Sculpt Sound',
	PHB 275, Trns,,, V S,, `range_close', `{level_caster}~h.~D',,
	`change the sound of {level_caster} creatures or objects')')
define(`spell_searing_light', `spell_line(`Searing Light',
	PHB 275, Evoc,,, V S,, `range_medium',, `ray',
	`attack_touch_ranged ranged touch attack deals calc_min(5, eval(level_caster / 2))`'D8 (differs for special targets)')')
define(`spell_secret_page', `spell_line(`Secret Page',
	PHB 275, Trns,,, V S M, `10~min.', `range_touch', `duration_permanent',,
	`hide text by changing it to some other text')')
define(`spell_see_invisibility', `spell_line(`See Invisibility',
	PHB 275, Divn,, Planar, V S M,, `range_you', `eval(level_caster * 10)~min.~D',,
	`see invisible and ethereal objects and beings within range of vision')')
define(`spell_seeming', `spell_line(`Seeming',
	PHB 275, Ills, Glam,, V S,, `range_close', `12~h.~D',,
	`eval(level_caster / 2) creatures and all their equipment are disguised\komma 1~ft size difference\komma keep body type')')
define(`spell_sending', `spell_line(`Sending',
	PHB 275, Evoc,,, V S AM DF, `10~min.', `$\infty$', `1~rnd.',,
	`send 25-words-message to one familiar target, answer possible')')
define(`spell_sepia_snake_sigil', `spell_line(`Sepia Snake Sigil',
	PHB 276, Conj, Crea, Force Planar, V S ME(spellmaterial_sepia_snake_sigil), `10~min.', `range_touch', `until activated',,
	`sigil within text traps reader for 1D4+{level_caster} days')')
define(`spell_sequester', `spell_line(`Sequester',
	PHB 276, Abjr,,, V S M,, `range_touch', `{level_caster}~d.~D',,
	`one creature (rendered comatose) or object (up to {level_caster} 2-ft cubes) is protected from divination spells and turned invisible')')
define(`spell_shades', `spell_line(`Shades',
	PHB 276, Ills, Shdw, Planar, V S,, `varies', `varies', `varies',
	`mimic any conjuration (summoning) or conjuration (creation) spell of sorcerer/wizard up to 8rd level\komma still 80\% real if disbelieved')')
define(`spell_shadow_conjuration', `spell_line(`Shadow Conjuration',
	PHB 276, Ills, Shdw, Planar, V S,, `varies', `varies', `varies',
	`mimic any conjuration (summoning) or conjuration (creation) spell of sorcerer/wizard up to 3rd level\komma still 20\% real if disbelieved')')
define(`spell_shadow_conjuration_greater', `spell_line(`Shadow Conjuration\komma Greater',
	PHB 276, Ills, Shdw, Planar, V S,, `varies', `varies', `varies',
	`mimic any conjuration (summoning) or conjuration (creation) spell of sorcerer/wizard up to 6th level\komma still 60\% real if disbelieved')')
define(`spell_shadow_evocation', `spell_line(`Shadow Evocation',
	PHB 277, Ills, Shdw, Planar, V S,, `varies', `varies', `varies',
	`mimic any evocation spell of sorcerer/wizard up to 4th level\komma still 20\% real if disbelieved')')
define(`spell_shadow_evocation_greater', `spell_line(`Shadow Evocation\komma Greater',
	PHB 277, Ills, Shdw, Planar, V S,, `varies', `varies', `varies',
	`mimic any evocation spell of sorcerer/wizard up to 7th level\komma still 60\% real if disbelieved')')
define(`spell_shadow_walk', `spell_line(`Shadow Walk',
	PHB 277, Ills, Shdw, Planar, V S,, `range_touch', `{level_caster}~h.~D',,
	`you and up to {level_caster} creatures move through shadows at speed 50~mph\komma destination offset 1D10{}$\times${}100~ft\komma or move through the plane of shadow to different plane (requires 1D4~h.)')')
define(`spell_shambler', `spell_line(`Shambler',
	PHB 277, Conj, Crea,, V S,, `range_medium', `varies',,
	`1D4+2 shambling mounds guard for 7 months or perform other duty for 7 days')')
define(`spell_shapechange', `spell_line(`Shapechange',
	PHB 277, Trns,,, V S FE(spellfocus_shapechange),, `range_you', `eval(level_caster)~min.',,
	`transform into anything\komma up to once per round')')
define(`spell_shatter', `spell_line(`Shatter',
	PHB 278, Evoc,, Sonic, V S AM DF,, `range_close',,,
	`crystalline targets: shatter all objects ($\le${level_caster}~lbs.) within 5-ft radius spread, or one object ($\le${}eval(10 * level_caster)~lbs.), or deal calc_min(10, level_caster)`'D6 to creature')')
define(`spell_shield', `spell_line(`Shield',
	PHB 278, Abjr,, Force Planar, V S,, `range_you', `{level_caster}~min.~D',,
	`+4 shield AC, unencumbering, negate magic missile')')
define(`spell_shield_of_faith', `spell_line(`Shield of Faith',
	PHB 278, Abjr,,, V S M,, `range_touch', `{level_caster}~min.',,
	`+{calc_min(5, eval(2 + (level_caster / 6)))} deflect AC')')
define(`spell_shield_of_law', `spell_line(`Shield of Law',
	PHB 278, Abjr,, Law, V S FE(spellfocus_shield_of_law),, `', `{level_caster}~rnd.~D', `20-ft radius burst centered on you',
	`{level_caster} creatures gain: +4 deflect AC, +4 saves, spell resistance 25 against chaos, block possession and mental influence, attacking chaotic creatures are slowed')')
define(`spell_shield_other', `spell_line(`Shield Other',
	PHB 278, Abjr,,, V S FE(spellfocus_shield_other),, `range_close', `{level_caster}~h.~D',,
	`+1 deflect AC, +1 saves, caster takes half the target\aps{}s hitpoint damage')')
define(`spell_shillelagh', `spell_line(`Shillelagh',
	PHB 278, Trns,,, V S DF,, `range_touch', `{level_caster}~min.',,
	`oaken club or quarterstaff (both ends) becomes +1 and deals increase_damage_by_size(increase_damage_by_size(translate_damage_by_size(1D6, stat_size)))`'+1')')
define(`spell_shocking_grasp', `spell_line(`Shocking Grasp',
	PHB 279, Evoc,, Elec, V S,, `range_touch',,,
	`attack_touch_melee melee touch attack (+3 against metal target) deals calc_min(level_caster,5)`'D6')')
define(`spell_shout', `spell_line(`Shout',
	PHB 279, Evoc,, Sonic, V,, `30~ft',,,
	`cone-shaped burst deals 5D6 sonic damage and deafens for 2D6 rounds, some objects take calc_min(level_caster,15)`'D6')')
define(`spell_shout_greater', `spell_line(`Shout\komma Greater',
	PHB 279, Evoc,, Sonic, V S F,, `60~ft',,,
	`cone-shaped burst deals 10D6 sonic damage, deafens for 4D6 rounds and stuns for 1~round, some objects take calc_min(level_caster,20)`'D6')')
define(`spell_shrink_item', `spell_line(`Shrink Item',
	PHB 279, Trns,,, V S,, `range_touch', `{level_caster}~d.',,
	`object up to eval(2 * level_caster)~cu.ft is shrunk by 1/16 in each dimension (four categories) and can be turned cloth-like')')
define(`spell_silence', `spell_line(`Silence',
	PHB 279, Ills, Glam,, V S,, `range_long', `{level_caster}~min.~D',,
	`suppress any sounds within 20-ft radius emanation')')
define(`spell_silent_image', `spell_line(`Silent Image',
	PHB 279, Ills, Figm,, V S F,, `range_long', `C', `eval(4 + level_caster) 10-ft-cubes',
	`create mobile\komma visual-only figment')')
define(`spell_simulacrum', `spell_line(`Simulacrum',
	PHB 279, Ills, Shdw,, V S ME(spellmaterial_simulacrum) XP, `12~h.', `0~ft',,,
	`create illusory duplicate (1/2~HD of original) of one creature ($\le${}eval(2 * level_caster)~HD)\komma you command copy')')
define(`spell_slay_living', `spell_line(`Slay Living',
	PHB 280, Necr,, Death, V S,, `range_touch',,,
	`on successful attack_touch_melee melee touch attack kill living subject or deal 3D6+{level_caster} hits')')
define(`spell_sleep', `spell_line(`Sleep',
	PHB 280, Ench, Comp, Mind, V S M, `1~rnd.', `range_medium', `{level_caster}~min.',,
	`living creatures of together up to 4~HD in 10-ft radius burst')')
define(`spell_sleet_storm', `spell_line(`Sleet Storm',
	PHB 280, Conj, Crea, Cold, V S AM DF,, `range_long', `{level_caster}~rnd.',,
	`40~ft radius, 20~ft high, block sight, balance DC 10')')
define(`spell_slow', `spell_line(`Slow',
	PHB 280, Trns,,, V S M,, `range_close', `{level_caster}~rnd.',,
	`{level_caster}~targets suffers: -1 attacks, -1 AC, -1 Reflex Saves, half speed, only move- \textbf{or} standard-action')')
define(`spell_snare', `spell_line(`Snare',
	PHB 280, Trns,,, V S DF, `3~rnd.', `range_touch', `until triggered',,
	`eval((level_caster + 1) * 2)~ft diameter')')
define(`spell_soften_earth_stone', `spell_line(`Soften Earth and Stone',
	PHB 280, Trns,, Earth, V S DF,, `range_close',,,
	`area: eval(level_caster * 10)~sq.ft')')
define(`spell_solid_fog', `spell_line(`Solid Fog',
	PHB 281, Conj, Crea,, V S M,, `range_medium', `{level_caster}~min.', `20~ft radius\komma 20~ft high spread',
	`fog obscures sight beyond 5~ft\komma reduce passing speed to 5~ft\komma -2 melee attacks and damage')')
define(`spell_song_of_discord', `spell_line(`Song of Discord',
	PHB 281, Ench, Comp, Mind Sonic, V S,, `range_medium', `{level_caster}~rnd.', `20-ft radius spread',
	`50\% each creature each round to attack its nearest target by its maximum capability')')
define(`spell_soul_bind', `spell_line(`Soul Bind',
	PHB 281, Necr,,, V S FE(spellfocus_soul_bind),, `range_close', `duration_permanent',,
	`bind soul of a newly deceased (within past {level_caster}~rnd.) into a gem')')
define(`spell_sound_burst', `spell_line(`Sound Burst',
	PHB 281, Evoc,, Sonic, V S AF DF,, `range_close',,,
	`within 10-ft radius spread deal 1D8 and stun 1 rnd.')')
define(`spell_speak_with_animals', `spell_line(`Speak with Animals',
	PHB 281, Divn,,, V S,, `range_you', `{level_caster}~min.',,
	`communicate with animals')')
define(`spell_speak_with_dead', `spell_line(`Speak with Dead',
	PHB 281, Necr,, Lang, V S DF, `10~min.', `10~ft', `{level_caster}~min.',,
	`ask up to eval(level_caster / 2) questions')')
define(`spell_speak_with_plants', `spell_line(`Speak with Plants',
	PHB 282, Divn,,, V S,, `range_you', `{level_caster}~min.',,
	`communicate with plants and plant creatures')')
define(`spell_spectral_hand', `spell_line(`Spectral Hand',
	PHB 282, Necr,,, V S,, `range_medium', `{level_caster}~min.~D',,
	`ghostly hand delivers (+2 bonus) touch spells of up to 4th level')')
define(`spell_spell_immunity', `spell_line(`Spell Immunity',
	PHB 282, Abjr,,, V S DF,, `range_touch', `eval(10 * level_caster)~min.',,
	`target creature is immune to eval(level_caster / 4) specified spells ($\le$ 4th level) that allow for spell resistance')')
define(`spell_spell_immunity_greater', `spell_line(`Spell Immunity\komma Greater',
	PHB 282, Abjr,,, V S DF,, `range_touch', `eval(10 * level_caster)~min.',,
	`target creature is immune to eval(level_caster / 4) specified spells ($\le$ 8th level) that allow for spell resistance')')
define(`spell_spell_resistance', `spell_line(`Spell Resistance',
	PHB 282, Abjr,,, V S DF,, `range_touch', `{level_caster}~min.',,
	`target creature gains spell resistance eval(12 + level_caster)')')
define(`spell_spellstaff', `spell_line(`Spellstaff',
	PHB 282, Trns,,, V S FE(spellfocus_spellstaff), `10~min.', `range_touch', `until used~D',,
	`store one spell in wooden quarterstaff')')
define(`spell_spell_turning', `spell_line(`Spell Turning',
	PHB 282, Abjr,,, V S AM DF,, `range_you', `eval(10 * level_caster)~min.',,
	`turn up to 1D4+6 spell and spell-like \textbf{levels} (or remaining fractions) back on corresponding caster\komma area and touch spells remain unaffected')')
define(`spell_spider_climb', `spell_line(`Spider Climb',
	PHB 283, Trns,,, V S M,, `range_touch', `eval(level_caster * 10)~min.',,
	`climb and travel vertical surfaces and ceilings\komma climb speed 20~ft')')
define(`spell_spike_growth', `spell_line(`Spike Growth',
	PHB 283, Trns,,, V S DF,, `range_medium', `{level_caster}~h.~D', `{level_caster}$\times$~20-ft squares',
	`1D4 damage each 5~ft moved\komma maybe slowed')')
define(`spell_spike_stones', `spell_line(`Spike Stones',
	PHB 283, Trns,, Earth, V S DF,, `range_medium', `{level_caster}~h.~D',,
	`{level_caster}~~20-ft squares, 1D8 damage each 5~ft, maybe slowed')')
define(`spell_spiritual_weapon', `spell_line(`Spiritual Weapon',
	PHB 283, Evoc,, Force Planar, V S DF,, `range_medium', `{level_caster}~rnd.~D',,
	`weapon of force attacks designated target: emph_sign(eval(bonus_attack_base + bonus_attack_epic + stat_size_attack_mod(stat_size) + WIS)) (1D8+calc_min(5, eval(level_caster / 3)))')')
define(`spell_statue', `spell_line(`Statue',
	PHB 284, Trns,,, V S M, `1~rnd.', `range_touch', `{level_caster}~h.~D',,
	`turn one creature and its gear to stone\komma creature can freely change between these two states')')
define(`spell_status', `spell_line(`Status',
	PHB 284, Divn,,, V S,, `range_touch', `{level_caster}~h.',,
	`monitor the location and state of eval(level_caster / 3) target(s)')')
define(`spell_stinking_cloud', `spell_line(`Stinking Cloud',
	PHB 284, Conj, Crea,, V S M,, `range_medium', `{level_caster}~rnd.',,
	`20-ft radius 20-ft high fog nauseates living creatures within plus 1D4+1~rnd.')')
define(`spell_stone_shape', `spell_line(`Stone Shape',
	PHB 284, Trns,, Earth, V S AM DF,, `range_touch',,,
	`up to eval(level_caster + 10)~cu.ft of stone')')
define(`spell_stoneskin', `spell_line(`Stoneskin',
	PHB 284, Abjr,,, V S ME(spellmaterial_stoneskin),, `range_touch', `eval(level_caster * 10)~min.',,
	`damage reduction 10/adamantine, absorb max.~`'calc_min(eval(level_caster * 10), 150) hits')')
define(`spell_stone_tell', `spell_line(`Stone Tell',
	PHB 284, Divn,,, V S DF, `10~min.', `range_you', `{level_caster}~min.',,
	`gain information from stone')')
define(`spell_stone_to_flesh', `spell_line(`Stone to Flesh',
	PHB 285, Trns,,, V S M,, `range_medium',,,
	`restore a petrified creature or transform 1--3-ft diameter and 10-ft long cylinder of stone into flesh')')
define(`spell_storm_of_vengeance', `spell_line(`Storm of Vengeance',
	PHB 285, Conj, Summ,, V S, `1~rnd.', `range_long', `C (max.~10~rnd.) D',,
	`360~ft radius storm cloud: deafening thunder, acid rain, lightning strokes, hailstone rain, and violet rain and wind gusts')')
define(`spell_suggestion', `spell_line(`Suggestion',
	PHB 285, Ench, Comp, Lang Mind, V M,, `range_close', `up to {level_caster}~h.',,
	`compel one living creature')')
define(`spell_suggestion_mass', `spell_line(`Suggestion\komma Mass',
	PHB 285, Ench, Comp, Lang Mind, V M,, `range_medium', `up to {level_caster}~h.',,
	`compel up to {level_caster} living creatures')')
define(`spell_summon_instrument', `spell_line(`Summon Instrument',
	PHB 285, Conj, Summ,, V S, `1~rnd.', `0~ft', `{level_caster}~min.~D',,
	`summon one handheld musical instrument')')
define(`spell_summon_monster_1', `spell_line(`Summon Monster I',
	PHB 285, Conj, Summ, Planar Varies, V S AF DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_monster_2', `spell_line(`Summon Monster II',
	PHB 286, Conj, Summ, Planar Varies, V S AF DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_monster_3', `spell_line(`Summon Monster III',
	PHB 286, Conj, Summ, Planar Varies, V S AF DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_monster_4', `spell_line(`Summon Monster IV',
	PHB 286, Conj, Summ, Planar Varies, V S AF DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_monster_5', `spell_line(`Summon Monster V',
	PHB 286, Conj, Summ, Planar Varies, V S AF DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_monster_6', `spell_line(`Summon Monster VI',
	PHB 287, Conj, Summ, Planar Varies, V S AF DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_monster_7', `spell_line(`Summon Monster VII',
	PHB 287, Conj, Summ, Planar Varies, V S AF DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_monster_8', `spell_line(`Summon Monster VIII',
	PHB 287, Conj, Summ, Planar Varies, V S AF DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_monster_9', `spell_line(`Summon Monster IX',
	PHB 288, Conj, Summ, Planar Varies, V S AF DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_natures_ally_1', `spell_line(`Summon Nature\aps s Ally I',
	PHB 288, Conj, Summ, Varies, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_natures_ally_2', `spell_line(`Summon Nature\aps s Ally II',
	PHB 288, Conj, Summ, Varies, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_natures_ally_3', `spell_line(`Summon Nature\aps s Ally III',
	PHB 288, Conj, Summ, Varies, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_natures_ally_4', `spell_line(`Summon Nature\aps s Ally IV',
	PHB 288, Conj, Summ, Varies, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_natures_ally_5', `spell_line(`Summon Nature\aps s Ally V',
	PHB 289, Conj, Summ, Varies, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_natures_ally_6', `spell_line(`Summon Nature\aps s Ally VI',
	PHB 289, Conj, Summ, Varies, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_natures_ally_7', `spell_line(`Summon Nature\aps s Ally VII',
	PHB 289, Conj, Summ, Varies, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_natures_ally_8', `spell_line(`Summon Nature\aps s Ally VIII',
	PHB 289, Conj, Summ, Varies, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_natures_ally_9', `spell_line(`Summon Nature\aps s Ally IX',
	PHB 289, Conj, Summ, Varies, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_swarm', `spell_line(`Summon Swarm',
	PHB 289, Conj, Summ,, V S AM DF, `1~rnd.', `range_close', `C + 2~rnd.',,
	`one swarm of bats\komma rats or spiders (MOM~I~p.237ff.)')')
define(`spell_sunbeam', `spell_line(`Sunbeam',
	PHB 289, Evoc,, Light, V S DF,, `60~ft', `{level_caster}~rnd.',,
	`call up to calc_min(eval(level_caster / 3),6) beams (1/rnd)\komma blind and deal 4D6 damage\komma double against creatures to which sunlight is harmful or unnatural\komma calc_min(level_caster, 20)`'D6 against undead\komma oozes etc.\komma kill special undead')')
define(`spell_sunburst', `spell_line(`Sunburst',
	PHB 289, Evoc,, Light, V S AM DF,, `range_long',,,
	`80-ft radius burst, blind and deal 6D6 damage (more against special creatures)')')
define(`spell_symbol_of_death', `spell_line(`Symbol of Death',
	PHB 289, Necr,, Death, V S ME(spellmaterial_symbol_of_death), `10~min.', `60~ft', `until triggered',,
	`within 60-ft radius burst and for eval(10 * level_caster)~min. slay creatures with summed 150 hit points')')
define(`spell_symbol_of_fear', `spell_line(`Symbol of Fear',
	PHB 290, Necr,, Fear Mind, V S ME(spellmaterial_symbol_of_fear), `10~min.', `60~ft', `until triggered',,
	`within 60-ft radius burst and for eval(10 * level_caster)~min. creatures with summed 150 hit points are panicked for {level_caster}~rnd.')')
define(`spell_symbol_of_insanity', `spell_line(`Symbol of Insanity',
	PHB 290, Ench, Comp, Mind, V S ME(spellmaterial_symbol_of_insanity), `10~min.', `60~ft', `until triggered',,
	`within 60-ft radius burst and for eval(10 * level_caster)~min. all creatures become insane permanently')')
define(`spell_symbol_of_pain', `spell_line(`Symbol of Pain',
	PHB 290, Necr,, Evil, V S ME(spellmaterial_symbol_of_pain), `10~min.', `60~ft', `until triggered',,
	`within 60-ft radius burst and for eval(10 * level_caster)~min. all creatures suffer -4 on attacks\komma skills and ability checks\komma effect remains 1 hour outside area')')
define(`spell_symbol_of_persuasion', `spell_line(`Symbol of Persuasion',
	PHB 290, Ench, Comp, Mind, V S ME(spellmaterial_symbol_of_persuasion), `10~min.', `60~ft', `until triggered',,
	`within 60-ft radius burst and for eval(10 * level_caster)~min. all creatures become charmed for 1~hour')')
define(`spell_symbol_of_sleep', `spell_line(`Symbol of Sleep',
	PHB 291, Ench, Comp, Mind, V S ME(spellmaterial_symbol_of_sleep), `10~min.', `60~ft', `until triggered',,
	`within 60-ft radius burst and for eval(10 * level_caster)~min. all creatures $\le${}10~HD fall asleep for 3D6{}$\times${}10 minutes')')
define(`spell_symbol_of_stunning', `spell_line(`Symbol of Stunning',
	PHB 291, Ench, Comp, Mind, V S ME(spellmaterial_symbol_of_stunning), `10~min.', `60~ft', `until triggered',,
	`within 60-ft radius burst and for eval(10 * level_caster)~min. stun creatures with summed 150 hit points for 1D6~rnd.~each')')
define(`spell_symbol_of_weakness', `spell_line(`Symbol of Weakness',
	PHB 291, Necr,,, V S ME(spellmaterial_symbol_of_weakness), `10~min.', `60~ft', `until triggered',,
	`within 60-ft radius burst and for eval(10 * level_caster)~min. all creatures suffer 3D6 S{}T{}R damage')')
define(`spell_sympathetic_vibration', `spell_line(`Sympathetic Vibration',
	PHB 291, Evoc,, Sonic, V S F, `10~min.', `range_touch', `up to {level_caster}~rnd.',,
	`deal 2D10 per rnd.~to a free standing structure')')
define(`spell_sympathy', `spell_line(`Sympathy',
	PHB 292, Ench, Comp, Mind, V S M, `1~h.', `range_close', `eval(level_caster * 2)~h.~D',,
	`one location of {level_caster} 10-ft cubes of one subject')')
define(`spell_tashas_hideous_laughter', `spell_line(`Tasha\aps s Hideous Laughter',
	PHB 292, Ench, Comp, Mind, V S M,, `range_close', `{level_caster}~rnd.',,
	`uncontrollable laughter leaves one creatue (I{}N{}T$>${}2) prone')')
define(`spell_telekinesis', `spell_line(`Telekinesis',
	PHB 292, Trns,,, V S,, `range_long', `C~({level_caster}~rnd.) or 1~rnd.',,
	`sustained force moves and handles up to eval(calc_min(level_caster, 15) * 25)~lbs.-target by 20~ft/rnd.~\textbf{or} combat maneuvers (bull rush\komma disarm\komma grapple\komma trip\komma emph_sign(level_caster) base attack\komma emph_sign(ifelse(token_caster,wizard,INT,token_caster,sorcerer,CHA,0)) S{}T{}R or D{}E{}X)~\textbf{or} single violent thrust hurles up to {level_caster} targets (summed up to eval(calc_min(level_caster, 15) * 25)~lbs.) against one target within eval(level_caster * 10)~ft and thus deals 1 to 1D6 per 25~lbs.')')
define(`spell_teleport', `spell_line(`Teleport',
	PHB 292, Conj, Tele, Planar, V,, `range_you',,,
	`you and eval(level_caster / 3) touched creatures plus gear travel eval(level_caster * 100)~miles\komma missing arrival position possible')')
define(`spell_teleport_object', `spell_line(`Teleport Object',
	PHB 293, Conj, Tele, Planar, V,, `range_touch',,,
	`object (up to eval(50 * level_caster)~lbs.~and eval(3 * level_caster)~cb-ft) travels eval(level_caster * 100)~miles or to ethereal plane\komma missing arrival position possible')')
define(`spell_teleport_greater', `spell_line(`Teleport\komma Greater',
	PHB 293, Conj, Tele, Planar, V,, `range_you',,,
	`you and eval(level_caster / 3) touched creatures plus gear travel unlimited range\komma exact arrival position')')
define(`spell_teleportation_circle', `spell_line(`Teleportation Circle',
	PHB 293, Conj, Tele, Planar, V ME(spellmaterial_teleportation_circle), `10~min.', `0~ft', `eval(10 * level_caster)~min.~D', `5-ft radius circle',
	`creatures that enter the area are teleported to the destination\komma no range limit\komma exact arrival position')')
define(`spell_temporal_stasis', `spell_line(`Temporal Stasis',
	PHB 293, Trns,,, V S ME(spellmaterial_temporal_stasis),, `range_touch', `duration_permanent',,
	`attack_touch_melee melee touch attack puts subject into stasis')')
define(`spell_tensers_floating_disk', `spell_line(`Tenser\aps{}s Floating Disk',
	PHB 294, Evoc,, Force Planar, V S M,, `range_close', `{level_caster}~h.',,
	`3-ft diameter disk of force carries eval(100 * level_caster)~lbs.')')
define(`spell_tensers_transformation', `spell_line(`Tenser\aps{}s Transformation',
	PHB 294, Trns,,, V S ME(spellmaterial_tensers_transformation),, `range_you', `{level_caster}~rnd.',,
	`gain +4 strength\komma dexterity and constitution\komma +4 natural A{}C\komma +5 fortitude saves\komma {level_total} base attack bonus\komma proficiency with all simple and martial weapons\komma cannot cast spells')')
define(`spell_time_stop', `spell_line(`Time Stop',
	PHB 294, Trns,,, V,, `range_you', `1D4+1~rnd.',,
	`you gain extra rounds to act\komma normal and magical elements still harm you\komma only your meanwhile cast area spells effect others and only after time stop ends\komma can handle unattended items')')
define(`spell_tongues', `spell_line(`Tongues',
	PHB 294, Divn,,, V AM DF,, `range_touch', `eval(level_caster * 10)~min.',,
	`speak and understand one language of any intelligent creature')')
define(`spell_touch_of_fatigue', `spell_line(`Touch of Fatigue',
	PHB 294, Necr,,, V S M,, `range_touch', `{level_caster}~rnd.',,
	`attack_touch_melee melee touch attack fatigues target')')
define(`spell_touch_of_idiocy', `spell_line(`Touch of Idiocy',
	PHB 294, Ench, Comp, Mind, V S,, `range_touch', `eval(level_caster * 10)~min.',,
	`attack_touch_melee melee touch attack at living creature deals 1D6 penalty to I{}N{}T, W{}I{}S and C{}H{}A')')
define(`spell_transmute_metal_to_wood', `spell_line(`Transmute Metal to Wood',
	PHB 294, Trns,,, V S DF,, `range_long',,,
	`all metal objects within 40~ft radius burst')')
define(`spell_transmute_mud_to_rock', `spell_line(`Transmute Mud to Rock',
	PHB 295, Trns,, Earth, V S AM DF,, `range_medium', `duration_permanent',,
	`up to eval(level_caster * 2) cubes of 10~ft')')
define(`spell_transmute_rock_to_mud', `spell_line(`Transmute Rock to Mud',
	PHB 295, Trns,, Earth, V S AM DF,, `range_medium', `duration_permanent',,
	`up to eval(level_caster * 2) cubes of 10~ft')')
define(`spell_transport_via_plants', `spell_line(`Transport via Plants',
	PHB 295, Conj, Tele,, V S,, `range_you', `1~rnd',,
	`travel unlimited range between two plants of the same kind, carry up to eval(weight_limit_max / 45360)~lbs., joined by up to eval(level_caster / 3) willing medium size beings touched')')
define(`spell_trap_the_soul', `spell_line(`Trap the Soul',
	PHB 295, Conj, Summ, Planar, V S ME(spellmaterial_trap_the_soul) F, `varies', `range_close', `duration_permanent',,
	`trap one creature\aps{}s life force inside a gem')')
define(`spell_tree_shape', `spell_line(`Tree Shape',
	PHB 296, Trns,,, V S DF,, `range_you', `{level_caster}~h.~D',,
	`turn yourself into a large tree\komma can still see')')
define(`spell_tree_stride', `spell_line(`Tree Stride',
	PHB 296, Conj, Tele,, V S DF,, `range_you', `{level_caster}~h.',,
	`max.~{level_caster} teleportation steps')')
define(`spell_true_resurrection', `spell_line(`True Resurrection',
	PHB 296, Conj, Heal,, V S ME(spellmaterial_true_resurrection) DF, `10~min.', `range_touch',,,
	`restore life to one creature dead up to eval(10 * level_caster) years')')
define(`spell_true_seeing', `spell_line(`True Seeing',
	PHB 296, Divn,, Planar, V S ME(spellmaterial_true_seeing),, `range_touch', `{level_caster}~min.',,
	`see through several magical effects at 120~ft range')')
define(`spell_true_strike', `spell_line(`True Strike',
	PHB 296, Divn,,, V F,, `range_you', `1~rnd.',,
	`+20 next single attack\komma overcome miss chance of concealment')')
define(`spell_undeath_to_death', `spell_line(`Undeath to Death',
	PHB 297, Necr,,, V S ME(spellmaterial_undeath_to_death) DF,, `range_medium',, `40-ft radius burst',
	`slay calc_min(level_caster,20)`'D4~HD of undead with less than 9~HD')')
define(`spell_undetectable_alignment', `spell_line(`Undetectable Alignment',
	PHB 297, Abjr,,, V S,, `range_close', `24~h.',,
	`no divination can reveal target\aps{}s alignment')')
define(`spell_unhallow', `spell_line(`Unhallow',
	PHB 297, Evoc,, Evil, V S ME(spellmaterial_unhallow), `24~h.', `range_touch',,,
	`40~ft radius emanation from point touched')')
define(`spell_unholy_aura', `spell_line(`Unholy Aura',
	PHB 297, Abjr,, Evil, V S FE(spellfocus_unholy_aura),, `', `{level_caster}~rnd.~D', `20-ft radius burst centered on you',
	`{level_caster} creatures gain: +4 deflect AC, +4 saves, spell resistance 25 against good, block possession and mental influence, attacking good creatures suffer 1D6 S{}T{}R damage')')
define(`spell_unholy_blight', `spell_line(`Unholy Blight',
	PHB 297, Evoc,, Evil, V S,, `range_medium',, `20-ft radius spread',
	`deal calc_min(5, eval(level_caster / 2))`'D8 to good creatures (neutral half) and sicken 1D4~rnd.')')
define(`spell_unseen_servant', `spell_line(`Unseen Servant',
	PHB 297, Conj, Crea,, V S M,, `range_close', `{level_caster}~h.',,
	`Invisible, mindless, shapeless force servant obeys your commands')')
define(`spell_vampiric_touch', `spell_line(`Vampiric Touch',
	PHB 298, Necr,,, V S,, `range_touch', `-- / 1~h.',,
	`attack_touch_melee melee touch attack drains calc_min(10, eval(level_caster / 2))D6 hits, you gain them temporarily')')
define(`spell_veil', `spell_line(`Veil',
	PHB 298, Ills, Glam,, V S,, `range_long', `C + {level_caster}~h.~D',,
	`disguise creatures within 30~ft visually\komma tactile and olfactory')')
define(`spell_ventriloquism', `spell_line(`Ventriloquism',
	PHB 298, Ills, Figm,, V F,, `range_close', `{level_caster}~min.~D',,
	`make your voice sound from somewhere else')')
define(`spell_virtue', `spell_line(`Virtue',
	PHB 298, Trns,,, V S DF,, `range_touch', `1~min.',,
	`1 temporary hit point')')
define(`spell_vision', `spell_line(`Vision',
	PHB 298, Divn,,, V S ME(spellmaterial_vision) XP,, `range_you',,,
	`learn about one important person\komma place or object')')
define(`spell_wail_of_banshee', `spell_line(`Wail of the Banshee',
	PHB 298, Necr,, Death Sonic, V,, `range_close',, 40-ft radius spread,
	`kill up to {level_caster} living creatures')')
define(`spell_wall_of_fire', `spell_line(`Wall of Fire',
	PHB 298, Evoc,, Fire, V S AM DF,, `range_medium', `C + {level_caster}~rnd.',,
	`20~ft high, eval(level_caster * 20)~ft long sheet or eval(5 * (level_caster / 2))~ft radius ring')')
define(`spell_wall_of_force', `spell_line(`Wall of Force',
	PHB 298, Evoc,, Force Planar, V S M,, `range_close', `{level_caster}~rnd.~D', `{level_caster} 10-ft squares immobile\komma invisible wall',
	`immune to damage and nearly any magic\komma blocks breath weapons\komma spells\komma material and ethereal objects and creatures\komma but not gazes\komma circumventable by extradimensional travel and ethereal creatures')')
define(`spell_wall_of_ice', `spell_line(`Wall of Ice',
	PHB 299, Evoc,, Cold, V S M,, `range_medium', `{level_caster}~min.', `{level_caster} 10-ft square\komma {level_caster}-inch thick plane or eval(level_caster + 3)`'-ft radius hemisphere',
	`create anchored mass of ice in empty place')')
define(`spell_wall_of_iron', `spell_line(`Wall of Iron',
	PHB 299, Conj, Crea,, V S ME(spellmaterial_wall_of_iron),, `range_medium',, `{level_caster} 5-ft squares\komma eval(level_caster / 4)~inch thick wall (trade size for thickness)',
	`create iron wall to block passage or topple onto creatures')')
define(`spell_wall_of_stone', `spell_line(`Wall of Stone',
	PHB 299, Conj, Crea, Earth, V S AM DF,, `range_medium',,,
	`{level_caster} 5-ft-squares area, eval(level_caster / 4)~inch thick, or double area by half thickness')')
define(`spell_wall_of_thorns', `spell_line(`Wall of Thorns',
	PHB 300, Conj, Crea,, V S,, `range_medium', `eval(level_caster * 10)~min.~D',,
	`{level_caster} adjacent cubes of 10~ft each')')
define(`spell_warp_wood', `spell_line(`Warp Wood',
	PHB 300, Trns,,, V S,, `range_close',,,
	`{level_caster} objects of small size or eval(level_caster / 2) of medium size, etc.')')
define(`spell_water_breathing', `spell_line(`Water Breathing',
	PHB 300, Trns,,, V S AM DF,, `range_touch', `eval(level_caster * 2)~h.',,
	`distribute duration among all targets')')
define(`spell_water_walk', `spell_line(`Water Walk',
	PHB 300, Trns,, Water, V S DF,, `range_touch', `eval(level_caster * 10)~min.',,
	`{level_caster} targets can tread on any liquid')')
define(`spell_waves_of_exhaustion', `spell_line(`Waves of Exhaustion',
	PHB 301, Necr,,, V S,, `60~ft',, `60-ft cone shaped burst',
	`all living creatures in area are exhausted')')
define(`spell_waves_of_fatigue', `spell_line(`Waves of Fatigue',
	PHB 301, Necr,,, V S,, `30~ft',, `30-ft cone shaped burst',
	`all living creatures in area are fatigued')')
define(`spell_web', `spell_line(`Web',
	PHB 301, Conj, Crea,, V S M,, `range_medium', `eval(10 * level_caster)~min.~D',,
	`entangle and immobilize creatures in 20-ft radius spread web')')
define(`spell_weird', `spell_line(`Weird',
	PHB 301, Ills, Phan, Fear Mind, V S,, `range_medium',,,
	`illusion delivers deadly fear attack to any number of living creatures within 30~ft\komma or suffer 3D6 damage and 1D4 temporary strength damage and 1~rnd.~stunned')')
define(`spell_whirlwind', `spell_line(`Whirlwind',
	PHB 301, Evoc,, Air, V S DF,, `range_long', `{level_caster}~rnd.~D',,
	`cyclone: 30~ft tall, 10~ft wide at base and 30~ft at top, 3D6 damage to large or smaller creatures, pick up medium or smaller creatures')')
define(`spell_whispering_wind', `spell_line(`Whispering Wind',
	PHB 301, Trns,, Air, V S,, `{level_caster}~mi.', `{level_caster}~h.',,
	`send 25-word-message or 1-rnd.-sound')')
define(`spell_wind_walk', `spell_line(`Wind Walk',
	PHB 302, Trns,, Air, V S DF,, `range_touch', `{level_caster}~h.~D',,
	`you and eval(level_caster / 3) targets touched turn gaseous, fly base speed: 10~ft (perfect) or 600~ft (poor)')')
define(`spell_wind_wall', `spell_line(`Wind Wall',
	PHB 302, Evoc,, Air, V S AM DF,, `range_medium', `{level_caster}~rnd.',,
	`eval(level_caster * 10)~ft long (can shape path), eval(level_caster * 5)~ft high and 2~ft thick')')
define(`spell_wish', `spell_line(`Wish',
	PHB 302, Univ,,, V XP,, `varies', `varies',,
	`duplicate spell or (un)do effect\komma injury\komma affliction or misfortune or create item or revive dead')')
define(`spell_wood_shape', `spell_line(`Wood Shape',
	PHB 303, Trns,,, V S DF,, `range_touch',,,
	`one eval(10 + level_caster) cu.ft piece of wood')')
define(`spell_word_of_chaos', `spell_line(`Word of Chaos',
	PHB 303, Evoc,, Chaos Sonic Planar, V,, `',, `40~ft radius spread centered on you',
	`any nonchaotic creature is cumulatively deafened ($\le${level_caster}~HD)\komma stunned ($\le${eval(level_caster - 1)}~HD)\komma confused ($\le${eval(level_caster - 5)}~HD) and killed ($\le${eval(level_caster - 10)}~HD) and extraplanar creatures are banished')')
define(`spell_word_of_recall', `spell_line(`Word of Recall',
	PHB 303, Conj, Tele,, V,, `range_you',,,
	`travel unlimited range to designated location, carry up to eval(weight_limit_max / 45360)~lbs., joined by up to eval(level_caster / 3) willing medium sized beings touched')')
define(`spell_zone_of_silence', `spell_line(`Zone of Silence',
	PHB 303, Ills, Glam,, V S, `1~rnd.', `range_you', `{level_caster}~h.~D',,
	`no sound leaves 5-ft radius around you')')
define(`spell_zone_of_truth', `spell_line(`Zone of Truth',
	PHB 303, Ench, Comp, Mind, V S DF,, `range_close', `{level_caster}~min.',,
	`creatures inside 20-ft radius area cannot lie')')



dnl Spells from ``Sandstorm'' Companion

define(`spell_antifire_sphere', `spell_line(`Antifire Sphere',
	SST 110, Abjr,,, V S,, `range_touch', `eval(10 * level_caster)~min.',,
	`all within 10-ft radius emanation are immune to fire, fire creatures cannot enter')')
define(`spell_ashen_union', `spell_line(`Ashen Union',
	SST 110, Necr,,, V S M,, `range_medium',,,
	`living target takes calc_min(10, eval(level_caster / 2))D6 dessication damage and can die')')
define(`spell_ashstar', `spell_line(`Ashstar',
	SST 111, Conj, Crea, Evil, V S,, `range_medium', `{level_caster}~rnd.',,
	`create hovering construct that illuminates light and turn any damage into dessication damage')')
define(`spell_awaken_sand', `spell_line(`Awaken Sand',
	SST 111, Trns,,, V S DF XP, `24~h.', `range_touch',,,
	`turn a mass of sand into intelligent creature')')
define(`spell_black_sand', `spell_line(`Black Sand',
	SST 111, Necr,, Dark Evil, V S,, `range_medium', `{level_caster}~min.',,
	`turn 20-ft radius spread into Black Sand, cf.~p.20')')
define(`spell_blast_of_sand', `spell_line(`Blast of Sand',
	SST 112, Conj, Crea, Earth, V S M,, `30~ft',,,
	`cone shaped burst of sand deals calc_min(level_caster, 10)`'D6')')
define(`spell_body_blaze', `spell_line(`Body Blaze',
	SST 112, Evoc,, Fire, V S M,, `range_you', `{level_caster}~rnd.~D',,
	`you immolate in flames and leave fire-trail that deals 2D6+calc_min(20, level_caster)')')
define(`spell_choking_sands', `spell_line(`Choking Sands',
	SST 112, Necr,,, V S M,, `range_touch',,,
	`living creature touched suffocates from sand-filled lungs')')
define(`spell_cloak_of_shade', `spell_line(`Cloak of Shade',
	SST 112, Abjr,,, V S DF,, `range_touch', `{level_caster}~h.~D',,
	`shade reduces heat conditions up to ``Extreme Heat'' by one level')')
define(`spell_control_sand', `spell_line(`Control Sand',
	SST 112, Trns,,, V S DF,, `range_long', `eval(level_caster * 10)~min.~D',,
	`raise or lower sand in eval(level_caster * 10)~ft $\times$ eval(level_caster * 10)~ft $\times$ eval(level_caster * 2)~ft')')
define(`spell_desert_binding', `spell_line(`Desert Binding',
	SST 113, Ench, Comp, Mind, V S ME(spellmaterial_desert_binding), `1~min.', `range_close', `varies~D',,
	`')')
define(`spell_desert_diversion', `spell_line(`Desert Diversion',
	SST 113, Conj, Tele,, V S,, `range_medium', `{level_caster}~min.',,
	`target of attack_touch_ranged ranged touch attack using teleportation spells are redirected to desert')')
define(`spell_desiccate', `spell_line(`Desiccate',
	SST 114, Necr,,, V S M,, `range_close',,,
	`deal calc_min(level_caster,5)`'D6 desiccation damage (different for plants and elementals)')')
define(`spell_desiccate_mass', `spell_line(`Desiccate\komma Mass',
	SST 114, Necr,,, V S M,, `range_close',,,
	`deal calc_min(level_caster,5)`'D6 desiccation damage to {level_caster} targets (different for plants and elementals)')')
define(`spell_dispel_water', `spell_line(`Dispel Water',
	SST 114, Abjr,,, V S,, `range_medium',,,
	`destroy eval(level_caster * 200)~cu-ft of water or dispel water-based spell or dismiss extraplanar water creature')')
define(`spell_flashflood', `spell_line(`Flashflood',
	SST 114, Conj, Crea, Water, V S DF,, `120~ft', `1~rnd',,
	`cone shaped spread of water rushes out')')
define(`spell_flaywind_burst', `spell_line(`Flaywind Burst',
	SST 115, Evoc,, Air Earth, V S M, `1~rnd.', `60~ft',,,
	`cause windstorm (cf.~DMG p.95) that also deals calc_min(level_caster,10)`'D6 damage')')
define(`spell_flesh_to_salt', `spell_line(`Flesh to Salt',
	SST 116, Trns,,, V S M,, `range_medium',,,
	`deal calc_min(eval(level_caster / 2),10)`'D6 damage, turn to salt statue if this takes more than half current hits')')
define(`spell_flesh_to_salt_mass', `spell_line(`Flesh to Salt\komma Mass',
	SST 116, Trns,,, V S M,, `range_medium',,,
	`deal calc_min(eval(level_caster / 2),10)`'D6 damage to eval(1 + calc_min(eval(level_caster / 4),5)) targets, turn to salt statue if this takes more than half current hits')')
define(`spell_freedom_of_breath', `spell_line(`Freedom of Breath',
	SST 116, Abjr,,, V S M,, `range_touch', `eval(level_caster * 10)~min.',,
	`breathe freely in usually adverse conditions')')
define(`spell_fuse_sand', `spell_line(`Fuse Sand',
	SST 116, Trns,, Earth, V S M,, `range_close',,,
	`form soft stone from eval(level_caster * 2)~10-ft cubes of sand')')
define(`spell_haboob', `spell_line(`Haboob',
	SST 117, Conj, Crea, Air Earth, V S M,, `range_medium', `{level_caster}~min.',,
	`swirling sand blocks vision and deals calc_min(eval(level_caster / 2),5)`'D4 damage')')
define(`spell_halo_of_sand', `spell_line(`Halo of Sand',
	SST 117, Abjr,, Earth, V S DF,, `range_you', `eval(level_caster * 10)~min.',,
	`grant +`'calc_min(eval(1 + ifelse(eval(level_caster > 3),1,(level_caster - 3) / 3,0)),4) deflection bonus to AC')')
define(`spell_hydrate', `spell_line(`Hydrate',
	SST 117, Conj, Heal,, V S,, `range_touch',,,
	`heal 2D8+calc_min(level_caster,10) points of desiccation damage, all nonlethal dehydration damage and any dehydration condition')')
define(`spell_impede_suns_brilliance', `spell_line(`Impede Sun\aps s Brilliance',
	SST 117, Abjr,,, S,, `range_close', `eval(level_caster * 10)~min.',,
	`protect from sunlight in cylinder of 10~ft radius and 20~ft height')')
define(`spell_locate_water', `spell_line(`Locate Water',
	SST 117, Divn,,, V S AF DF,, `range_long', `C (eval(level_caster * 10)~min.)',,
	`detect water within cone-shaped emanation')')
define(`spell_mantle_fiery_spirit', `spell_line(`Mantle of the Fiery Spirit',
	SST 118, Trns,,, V S M XP,, `range_touch',,,
	`grant permanent fire-subtype to target')')
define(`spell_mephit_mob', `spell_line(`Mephit Mob',
	SST 118, Conj, Summ, Varies, V S, `1~min.', `range_medium', `eval(level_caster * 10)~min.~D',,
	`summon 2D6 mephits of same type')')
define(`spell_mummify', `spell_line(`Mummify',
	SST 118, Necr,,, V S AM DF,, `range_touch',,,
	`kill and mummify one living creature or deal 6D6 points of desiccation damage')')
define(`spell_parboil', `spell_line(`Parboil',
	SST 118, Evoc,, Fire, V S AM DF,, `range_close',,,
	`within 20-ft radius spread deal 6D6 fire and 2D4 I{}N{}T')')
define(`spell_parching_touch', `spell_line(`Parching Touch',
	SST 118, Necr,,, V S,, `range_touch',,,
	`{level_caster} targets take 1D6 dessication and 1 C{}O{}N damage and are dehydrated')')
define(`spell_protection_from_desiccation', `spell_line(`Protection from Desiccation',
	SST 119, Abjr,,, V S DF,, `range_touch', `eval(level_caster * 10)~min.',,
	`protect for max.~calc_min(eval(level_caster * 10),100) points of desiccation damage')')
define(`spell_sandform', `spell_line(`Sandform',
	SST 119, Trns,,, V S M,, `range_you', `{level_caster}~min.~D',,
	`you turn into living sand, gain immunities and abrasive slam attack')')
define(`spell_sandstorm', `spell_line(`Sandstorm',
	SST 119, Conj, Crea, Air Earth, V S,, `eval(level_caster * 40)~ft', `eval(level_caster * 10)~min.',,
	`eval(level_caster * 40)~ft radius, 40~ft high, up to $\pm${}eval(level_caster / 3) wind strength, cf.~DMG p.95')')
define(`spell_scalding_mud', `spell_line(`Scalding Mud',
	SST 120, Trns,, Earth Fire, V S AM DF,, `range_medium', `duration_permanent',,
	`turn eval(level_caster * 2) 10-ft cubes into hot mud, dealing fire damage')')
define(`spell_scimitar_of_sand', `spell_line(`Scimitar of Sand',
	SST 120, Evoc,, Earth, V S AM DF,, `0~ft', `{level_caster}~min.~D',,
	`attack_touch_melee melee touch attack, 1D6+calc_min(eval(level_caster / 2),10) damage plus dehydration')')
define(`spell_searing_exposure', `spell_line(`Searing Exposure',
	SST 120, Evoc,, Fire Light, V S AM DF,, `range_medium',,,
	`deal calc_min(level_caster,15)`'D4 nonlethal damage, dazzle, dehydrate and sunburn living target')')
define(`spell_skin_of_cactus', `spell_line(`Skin of the Cactus',
	SST 120, Abjr,,, V S M,, `range_touch', `eval(level_caster * 10)~min.',,
	`+`'ifelse(eval(level_caster >= 13),1,5,eval(level_caster >= 10),1,4,3) natural armor\komma needles deal 1D6 against natural attacks\komma +4 saves against dehydration')')
define(`spell_sleep_mote', `spell_line(`Sleep Mote',
	SST 121, Ench, Comp, Mind, V S AM DF,, `range_medium', `{level_caster}~rnd.',,
	`5-ft diameter sphere dust devil causes sleep')')
define(`spell_slipsand', `spell_line(`Slipsand',
	SST 121, Trns,,, V S M,, `range_close', `duration_permanent',,
	`{level_caster} 10-ft cubes turn into slipsand, cf.~Sandstorm p.25')')
define(`spell_soul_of_waste', `spell_line(`Soul of the Waste',
	SST 121, Trns,, Earth, V S DF,, `range_you', `eval(level_caster * 10)~min.',,
	`you meld into sand')')
define(`spell_storm_mote', `spell_line(`Storm Mote',
	SST 121, Evoc,, Air Earth, V S AM DF,, `range_medium', `{level_caster}~rnd.',,
	`5-ft radius and 10-ft high vortex deals 2D8 damage, bestows concealment and extinguishs flames')')
define(`spell_summon_desert_ally_1', `spell_line(`Summon Desert Ally I',
	SST 122, Conj, Summ,, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_desert_ally_2', `spell_line(`Summon Desert Ally II',
	SST 122, Conj, Summ,, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_desert_ally_3', `spell_line(`Summon Desert Ally III',
	SST 122, Conj, Summ,, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_desert_ally_4', `spell_line(`Summon Desert Ally IV',
	SST 123, Conj, Summ,, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_desert_ally_5', `spell_line(`Summon Desert Ally V',
	SST 123, Conj, Summ,, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_desert_ally_6', `spell_line(`Summon Desert Ally VI',
	SST 123, Conj, Summ,, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_desert_ally_7', `spell_line(`Summon Desert Ally VII',
	SST 123, Conj, Summ,, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_desert_ally_8', `spell_line(`Summon Desert Ally VIII',
	SST 123, Conj, Summ,, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_summon_desert_ally_9', `spell_line(`Summon Desert Ally IX',
	SST 123, Conj, Summ,, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_sunstroke', `spell_line(`Sunstroke',
	SST 123, Necr,,, V S,, `range_close',,,
	`living target takes 2D6 nonlethal damage and is fatigued')')
define(`spell_surelife', `spell_line(`Surelife',
	SST 123, Abjr,,, V S M, `1~rnd.', `target_you', `{level_caster}~min.',,
	`protection from one type of natural or non-magical thread')')
define(`spell_symbol_of_thirst', `spell_line(`Symbol of Thirst',
	SST 123, Ench, Comp, Mind, V S ME(spellmaterial_symbol_of_thirst), `10~min.', `60~ft', `until triggered',,
	`within 60-ft radius burst and for eval(10 * level_caster)~min. creatures with summed 150 hit points become thirsty')')
define(`spell_tormenting_thirst', `spell_line(`Tormenting Thirst',
	SST 124, Ench, Comp, Mind, V S,, `range_close', `{level_caster}~rnd.',,
	`one living creature becomes terribly thirsty, trying to acquire liquid by all means')')
define(`spell_transcribe_symbol', `spell_line(`Transscribe Symbol',
	SST 124, Abjr,,, V S F,, `range_touch', `10~min.~C',,
	`pick up and move one symbol')')
define(`spell_transmute_sand_to_glass', `spell_line(`Transmute Sand to Glass',
	SST 124, Trns,, Earth, V S AM DF,, `range_medium', `duration_permanent',,
	`eval(level_caster * 2)~10-ft cubes sand turn into glass, can trap creatures')')
define(`spell_transmute_sand_to_stone', `spell_line(`Transmute Sand to Stone',
	SST 124, Trns,, Earth, V S AM DF,, `range_medium', `duration_permanent',,
	`eval(level_caster * 2)~10-ft cubes sand turn into stone, can trap creatures')')
define(`spell_transmute_stone_to_sand', `spell_line(`Transmute Stone to Sand',
	SST 125, Trns,, Earth, V S AM DF,, `range_medium', `duration_permanent',,
	`eval(level_caster * 2)~10-ft cubes stone turn into sand')')
define(`spell_unearthly_heat', `spell_line(`Unearthly Heat',
	SST 125, Trns,,, V S,, `range_touch', `{level_caster}~rnd.',,
	`heat up target\aps{}s body, deal 1D6 lethal and 1D4 nonlethal each round, fatigue')')
define(`spell_vitrify', `spell_line(`Vitrify',
	SST 125, Trns,, Earth, V S AM DF,, `range_medium', `duration_permanent',,
	`melt sand within eval(level_caster / 5) 10-ft cubes, cool and harden over next 10~rnd., trap creatures within, deal 10D6{}$\ldots${}1D6 on consecutive rounds')')
define(`spell_wall_of_magma', `spell_line(`Wall of Magma',
	SST 126, Conj, Crea, Earth Fire, V S AM DF,, `range_medium', `{level_caster}~min.',,
	`{level_caster} 5-ft squares wall, eval(level_caster / 4)~inch thick')')
define(`spell_wall_of_salt', `spell_line(`Wall of Salt',
	SST 127, Conj, Crea, Earth, V S AM DF,, `range_medium',,,
	`{level_caster} 5-ft squares wall, {level_caster}~inch thick')')
define(`spell_wall_of_sand', `spell_line(`Wall of Sand',
	SST 127, Conj, Crea, Earth, V S AM DF,, `range_close', `{level_caster}~min.',,
	`{level_caster} 10-ft squares wall, eval(level_caster / 4)~inch thick')')
define(`spell_wall_of_water', `spell_line(`Wall of Water',
	SST 128, Conj, Crea, Water, V S AM DF,, `range_close', `{level_caster}~rnd.',,
	`{level_caster} 10-ft squares wall, 1~ft thick')')
define(`spell_wastestrider', `spell_line(`Wastestrider',
	SST 128, Trns,,, V S DF,, `range_touch', `{level_caster}~h.~D',,
	`move through desert without hinderance')')
define(`spell_whispering_sand', `spell_line(`Whispering Sand',
	SST 128, Trns,, Lang, V S F,, `$\infty$', `eval(level_caster * 10)~min.~D',,
	`transmit messages through sand')')
define(`spell_wither', `spell_line(`Wither',
	SST 128, Necr,,, V S M,, `range_medium',,,
	`deal calc_min(10, level_caster)`'D6 dessication damage to living creature and dehydrate')')



dnl Spells from ``Frostburn'' Companion
dnl
dnl remind special spell components: Coldfire (abbreviated: CF) and Frostfell (abbreviated: FF)

define(`spell_algid_enhancement', `spell_line(`Algid Enhancement',
	FRB 88, Trns,, Cold, V S CF, `1 rnd', `range_close', `24~h.', `',
	`creatures with cold subtype gain +`'eval(1 + (level_caster / 3)) deflect AC\komma 1D8+`'eval(level_caster / 3) temporary hits\komma +`'eval(1 + (level_caster / 3)) enhancement on attack rollss and +`'eval(2 + (level_caster / 3)) on saves against fire')')
define(`spell_animate_snow', `spell_line(`Animate Snow',
	FRB 88, Trns,, Cold, V S M,, `range_medium', `{level_caster}~rnd.', `up to 20~ft cube of snow',
	`raise one gargantuan or two huge or four large animated snow objects with additional cold subtype\komma Blind and Trample attacks and deal +1D6 cold')')
define(`spell_anticold_sphere', `spell_line(`Anticold Sphere',
	FRB 88, Abjr,,, V S,, `range_you', `eval(level_caster * 10)~min.~D', `10-ft radius mobile emanation centered on you',
	`all creature within the sphere are immune against cold\komma creatures with cold subtype cannot enter and are repelled upon casting')')
define(`spell_arctic_haze', `spell_line(`Arctic Haze',
	FRB 88, Conj, Crea, Cold, V S,, `range_medium', `eval(level_caster * 10)~min.', `30-ft radius and 20-ft high fog',
	`fog of tiny ice shards obscures vision and deals damage to trespassers (2 +2 cold per rnd.)')')
define(`spell_aura_of_cold_lesser', `spell_line(`Aura of Cold\komma Lesser',
	FRB 88, Trns,, Cold, V S DF,, `range_you', `{level_caster}~rnd.~D', `5~ft radius spherical emanation centered on you',
	`creatures within aura take 1D6 cold per round')')
define(`spell_aura_of_cold_greater', `spell_line(`Aura of Cold\komma Greater',
	FRB 88, Trns,, Cold, V S DF,, `range_you', `{level_caster}~rnd.~D', `10~ft radius spherical emanation centered on you',
	`creatures within aura take 2D6 cold per round')')
define(`spell_binding_snow', `spell_line(`Binding Snow',
	FRB 89, Trns,, Cold, V S DF FF,, `range_medium', `{level_caster}~h.~D', `{level_caster}$\times${ }10-ft squares',
	`freeze snow field\komma impede movement')')
define(`spell_blizzard', `spell_line(`Blizzard',
	FRB 89, Trns,, Cold, V S, `1~rnd.', `range_long', `{level_caster}~rnd.', `eval(100 * level_caster)~ft radius spread',
	`blizzard blows out most flames\komma brings 1~ft snow per rnd.\komma deals 1D6 non-lethal cold')')
define(`spell_blood_snow', `spell_line(`Blood Snow',
	FRB 89, Necr,, Cold, V S,, `range_medium', `{level_caster}~rnd.', `{level_caster}$\times${ }20-ft squares',
	`snow field drains 1D2 C{}O{}N per rnd.~and causes nausea')')
define(`spell_death_hail', `spell_line(`Death Hail',
        FRB 92, Conj, Crea, Cold Death, V S DF, `1~rnd.', `range_medium', `{level_caster}~rnd.', `40~ft radius\komma 20~ft high cylinder',
	`deal 1D2 S{}T{}R and C{}O{}N damage')')
define(`spell_fimbulwinter', `spell_line(`Fimbulwinter',
        FRB 93, Trns,, Cold, V S XP, `10~min.', `', `4D12~weeks', `{level_caster}~mi.~radius centered on you',
	`change weather to winter or strengthen winter conditions')')
define(`spell_snow_walk', `spell_line(`Snow Walk',
        FRB 104, Trns,,, V S DF,, `range_touch', `eval(level_caster * 10)~min.', `',
	`can walk on top of snow\komma leave no track\komma +10~base speed')')
define(`spell_snowsight', `spell_line(`Snowsight',
        FRB 104, Trns,,, V S DF,, `range_touch', `{level_caster}~h.', `',
	`can see normally -- even in whiteout-conditions')')
define(`spell_summon_giants', `spell_line(`Summon Giants',
        FRB 105, Conj, Summ,, V S F DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D', `',
	`summon 1--3 giants')')
define(`spell_winters_embrace', `spell_line(`Winter\aps s Embrace',
        FRB 106, Evoc,, Cold, V S,, `range_close', `{level_caster}~rnd.', `',
	`one creature is coated in ice\komma takes 1D8 cold per rnd.')')
dnl going on ...


define(`spell_conjure_ice_beast_1', `spell_line(`Conjure Ice Beast I',
	FRB 91, Conj, Crea, Cold, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_conjure_ice_beast_2', `spell_line(`Conjure Ice Beast II',
	FRB 91, Conj, Crea, Cold, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_conjure_ice_beast_3', `spell_line(`Conjure Ice Beast III',
	FRB 91, Conj, Crea, Cold, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_conjure_ice_beast_4', `spell_line(`Conjure Ice Beast IV',
	FRB 91, Conj, Crea, Cold, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_conjure_ice_beast_5', `spell_line(`Conjure Ice Beast V',
	FRB 91, Conj, Crea, Cold, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_conjure_ice_beast_6', `spell_line(`Conjure Ice Beast VI',
	FRB 91, Conj, Crea, Cold, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_conjure_ice_beast_7', `spell_line(`Conjure Ice Beast VII',
	FRB 91, Conj, Crea, Cold, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_conjure_ice_beast_8', `spell_line(`Conjure Ice Beast VIII',
	FRB 91, Conj, Crea, Cold, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_conjure_ice_beast_9', `spell_line(`Conjure Ice Beast IX',
	FRB 91, Conj, Crea, Cold, V S DF, `1~rnd.', `range_close', `{level_caster}~rnd.~D',,
	`')')
define(`spell_leomunds_tiny_igloo', `spell_line(`Leomund\aps{}s Tiny Igloo',
        FRB 101, Evoc,, Cold, V S M,, , `eval(level_caster * 2)~h.~D', `5~ft. radius igloo centered around you',
	`you and 3~medium sized creatures fit inside\komma single entrance\komma temperature 50{}${}^{\circ}$F (10{}${}^{\circ}$C)\komma smokeless stone lamp\komma withstand less than hurricane wind\komma walls have eval(level_caster * 3) hits and hardness~0')')



dnl Spells from ``Complete Champion'' Companion

define(`spell_aligned_aura', `spell_line(`Aligned Aura',
        CPC 116, Abjr,,, V S DF,, , `{level_caster}~rnd.', `20~ft radius emanation or 60~ft radius burst centered on you',
	`within emanation grant bonus to same-aligned and penalty to opposite-aligned targets\komma can discharge remaining energy in single burst')')
define(`spell_benediction', `spell_line(`Benediction',
        CPC 116, Abjr,,, V S DF, `1~rnd.', `range_touch\komma not \range_you', `eval(level_caster * 10)~min.', `',
	`+2 luck bonus on all saving throws\komma can discharge to reroll single roll')')
define(`spell_bewildering_mischance', `spell_line(`Bewildering Mischance',
        CPC 116, Ench, Comp, Mind, V S DF,, `range_close', `{level_caster}~rnd.', `',
	`living creature must roll twice for every save\komma attack and skill check and always take the worse result of both')')
define(`spell_bewildering_substitution', `spell_line(`Bewildering Substitution',
        CPC 116, Ills, Phan, Mind, V S DF,, `range_close', `{level_caster}~rnd.', `',
	`closest ally and closest enemy of living creature seem like the other respectively')')
define(`spell_bewildering_visions', `spell_line(`Bewildering Visions',
        CPC 117, Ills, Phan, Mind, V S DF,, `range_close', `{level_caster}~rnd.', `',
	`living creature is sickened and eventually nauseated too')')
define(`spell_bleed', `spell_line(`Bleed',
        CPC 117, Necr,,, V S,, `range_touch', `{level_caster}~rnd.~D', `',
	`living creature takes additional 1~C{}O{}N damage at each piercing or slashing damage')')
define(`spell_body_ward', `spell_line(`Body Ward',
        CPC 117, Abjr,,, V S DF,, `range_touch', `{level_caster}~min.~/ until discharged', `',
	`target is warded for 5 points (more from multiple castings) of damage against one physical ability score')')
define(`spell_bolster_aura', `spell_line(`Bolster Aura',
        CPC 117, Abjr,,, V S,, `range_touch', `eval(level_caster * 10)~min.', `',
	`target seems to have eval(level_caster / 2)~HD more')')
define(`spell_conduit_of_life', `spell_line(`Conduit of Life',
        CPC 118, Conj, Heal,, V S,, `range_you', `eval(level_caster * 10)~min.', `',
	`heal 2D10+calc_min(level_caster, 10) hits each time you channel positive energy\komma can discharge along healing spell')')
define(`spell_confound', `spell_line(`Confound',
        CPC 118, Ench, Comp, Mind, V S DF,, `range_close', `{level_caster}~rnd.', `',
	`subject takes --2 on attacks against you\komma you gain +2 against it\komma more if deity grants trickery domain')')
define(`spell_dampen_magic', `spell_line(`Dampen Magic',
        CPC 118, Abjr,,, V S DF,, `range_touch', `{level_caster}~rnd.~D', `',
	`reduce attacking magic (weapon enchancements\komma caster level and save~DC) by ifelse(eval(level_caster <= 12),1,1,eval(level_caster <= 18),1,2,3)\komma can discharge into anti-magic field')')
define(`spell_darts_of_life', `spell_line(`Darts of Life',
        CPC 118, Conj, Heal,, V S,, `range_close', `{level_caster}~min.', `',
	`10 orbs can be fired at targets\komma each healing 1D8 hits')')
define(`spell_deific_bastion', `spell_line(`Deific Bastion',
        CPC 119, Trns,,, V S DF,, `range_touch', `{level_caster}~rnd.', `',
	`+`'ifelse(eval(level_caster <= 8),1,1,eval(level_caster <= 11),1,2,eval(level_caster <= 14),1,3,eval(level_caster <= 17),1,4,5) on shield or heavy armor and special ability depending on deity')')
define(`spell_divine_presence', `spell_line(`Divine Presence',
        CPC 119, Trns,,, V S,, `range_you', `eval(level_caster * 10)~min.~D', `',
	`gain bonus to intimidation: +5 if different deity\komma +10 if one opposed alignment\komma +15 if diametrically opposed alignment')')
define(`spell_divine_retribution', `spell_line(`Divine Retribution',
        CPC 199, Abjr,,, V S DF,, `range_you', `eval(level_caster * 10)~min.~until used~D', `',
	`once exert retribution against one attacker: calc_min(level_caster,15)`'D6 hits and 1D4 ability damage\komma types according to deity')')
define(`spell_door_of_decay', `spell_line(`Door of Decay',
        CPC 120, Conj, Tele,, V S,, `range_you', `', `',
	`enter an undead and leave another up to eval(level_caster * 100)~miles away\komma both must be willing or controled and large enough')')
define(`spell_execration', `spell_line(`Execration',
        CPC 120, Necr,,, V S DF, `1~rnd.', `range_touch', `eval(level_caster * 10)~min.~until used', `',
	`target takes --2 on all saves\komma you can discharge to force rerolling single attack or save or skill check\komma the worse result counts')')
define(`spell_footsteps_of_divine', `spell_line(`Footsteps of the Divine',
        CPC 120, Trns,,, V S DF,, `range_you', `{level_caster}~rnd.~D', `',
	`improve existing speed or gain a new movement mode -- based on deity')')
define(`spell_forrest_child', `spell_line(`Forrest Child',
        CPC 121, Trns,,, V S ME(spellmaterial_forrest_child) DF,, `range_medium', `{level_caster}~rnd.~D', `',
	`create wooden duplicate ({level_caster}~hits)\komma can see and hear through it\komma can cast non-personal spells through it\komma can switch place with it')')
define(`spell_forrest_eyes', `spell_line(`Forrest Eyes',
        CPC 121, Divn, Scry,, V S DF, `1~min.', `range_touch', `{level_caster}~min.~D', `',
	`touch living plant and see (can rotate) through another fixed plant of same kind\komma no range limit')')
define(`spell_forrest_voice', `spell_line(`Forrest Voice',
        CPC 122, Trns,, Lang, V S DF, `1~min.', `range_touch', `{level_caster}~min.~D', `',
	`touch living plant and converse through another fixed plant of same kind\komma no range limit')')
define(`spell_healing_circle', `spell_line(`Healing Circle',
        CPC 122, Conj, Heal,, V S,, `range_you', `{level_caster}~min.', `',
	`within duration allies within 30~ft can draw 5 healing charges: 1{}$\times$ Cure Critical Wounds\komma $\ldots$')')
define(`spell_iconic_manifestation', `spell_line(`Iconic Manifestation',
        CPC 122, Trns,, ifelse(alignment_LC,L,Law,alignment_LC,C,Chaos) ifelse(alignment_GE,G,Good,alignment_GE,E,Evil), V S DF, `1~swift action', `range_you', `eval(level_caster * 10)~min.', `',
	`can trade 1 daily use of wild-shape into ifelse(alignment_LC,L,axiomatic,alignment_LC,C,anarchic) ifelse(alignment_GE,G,celestial,alignment_GE,E,fiendish) template for {level_caster}~min.~D')')
define(`spell_impede', `spell_line(`Impede',
        CPC 122, Ench, Comp, Mind, V S DF,, `range_medium', `{level_caster}~rnd.~D', `',
	`prevent movement of humaniod target\komma -1 melee attacks\komma -2 reflex saves')')
define(`spell_interfaith_blessing', `spell_line(`Interfaith Blessing',
        CPC 123, Ench, Comp, Mind, V S DF, `1~rnd.', `', `{level_caster}~min.', `20~ft. radius burst centered on you',
	`every creature in range receives blessing by \textbf{its own} deity')')
dnl going on ...
define(`spell_metal_fang', `spell_line(`Metal Fang',
        CPC 124, Trns,,, V S,, `range_touch', `{level_caster}~min.', `',
	`one of living creature\aps{}s natural weapons becomes magic and either cold iron or silvered')')
define(`spell_seed_of_life', `spell_line(`Seed of Life',
        CPC 127, Conj, Heal,, V S,, `range_touch', `calc_min(30, eval(10 + level_caster))~rnd.~/ until discharged', `',
	`grant living creature fast healing~2\komma can be used in single burst (heals 1D4 / 2~rnd.~remaining)')')
define(`spell_soul_ward', `spell_line(`Soul Ward',
        CPC 127, Abjr,,, V S DF,, `range_touch', `{level_caster}~min.~/ until discharged', `',
	`target is warded for 5 points (more from multiple castings) of damage against one mental ability score')')
define(`spell_weight_of_sin', `spell_line(`Weight of Sin',
        CPC 129, Evoc,, ifelse(alignment_LC,L,Law,alignment_LC,C,Chaos) ifelse(alignment_GE,G,Good,alignment_GE,E,Evil), V S,, `range_medium', `varies', `',
	`affect single creature according to its alignment compared to yours')')
define(`spell_wooden_blight', `spell_line(`Wooden Blight',
        CPC 130, Trns,,, V S M,, `range_medium', `{level_caster}~rnd.~D', `',
	`living creature takes 1D4 D{}E{}X damage / rnd.\komma transformed to wood at D{}E{}X~0')')


dnl Spells from ``Manual of the Planes'' Companion

define(`spell_analyze_portal', `spell_line(`Analyze Portal',
        MOP 33, Divn,,, V S M, `1~min.',, `{level_caster}~rnd.~CD', `60~ft cone shaped emanation',
	`detect portals and analyze their normal and unusual properties')')
define(`spell_attune_form', `spell_line(`Attune Form',
        MOP 33, Trns,,, V S AM DF,, `range_touch', `eval(level_caster * 2)~h.', `',
	`{level_caster} creatures are protected from evironmental hazards of a specific plane')')
define(`spell_avoid_planar_effects', `spell_line(`Avoid Planar Effects',
        MOP 33, Abjr,,, V,,, `{level_caster}~min.', `{level_caster} creatures in 20~ft radius burst centered on you',
	`creatures are protected from evironmental hazards of a specific plane')')
dnl going on ...


dnl Epic Spells from ``Epic Level Handbook'' and other rulebooks

define(`spell_animus_blast', `spell_line(`Animus Blast',
        FRB 107, Evoc,, Cold, V S DC(50),, `300~ft.',, `20~ft. radius hemisphere burst',
	`deal 10D6 cold\komma raise up to 20 victims as medium skeletons')')
define(`spell_animus_blizzard', `spell_line(`Animus Blizzard',
        FRB 107, Evoc,, Cold, V S DC(78), `1~min.', `300~ft.',, `20~ft. radius hemisphere burst',
	`deal 20D6 cold\komma raise up to 5 victims as wights')')
define(`spell_beast_thousand_legs', `spell_line(`Beast of a Thousand Legs',
        SST 129, Evoc,,, V S XP DC(132), `10~min.',, `20~h.', `2~mile radius emanation',
	`create massive storm including 10 tornados at any time')')
define(`spell_coldfire_blast', `spell_line(`Coldfire Blast',
        FRB 107, Evoc,, Cold, V S CF DC(93),, `300~ft.',, `40~ft. radius hemisphere burst',
	`deal 40D6 forstburn damage')')
define(`spell_contingent_resurrection', `spell_line(`Contingent Resurrection',
        ELH 74, Conj, Heal,, V S DF DC(52), `1~min.', `range_touch', `until discharged', `',
	`target is returned to life if killed')')
define(`spell_create_living_vault', `spell_line(`Create Living Vault',
        ELH 75, Conj, Crea,, V S XP DC(58), `100~d.+11~min.',,,`50~ft $\times$ 50~ft $\times$ 10~ft',
	`create construct to keep your possessions\komma cf.~ELH~p.203')')
define(`spell_crown_of_vermin', `spell_line(`Crown of Vermin',
        ELH 75, Conj, Summ,, V S DC(56), `1~min.', `range_you', `20~rnd.~D', `10~ft radius spread mobile aura centered on you',
	`1000~vermin deal up to 1000 point of damage\komma provide 50\% concealment')')
define(`spell_damnation', `spell_line(`Damnation',
        ELH 76, Ench, Comp, Mind, V S XP DC(97),, `range_touch', `20~h.',,
	`one creature is sent to Nine Hells or Abyss and compelled to stay')')
define(`spell_demise_unseen', `spell_line(`Demise Unseen',
        ELH 76, Necr,, Death Evil, V S DC(82),, `300~ft.',,,
	`one creature (up to 80~HD) is killed and instantly replaced by a controlled ghoul')')
define(`spell_dire_drought', `spell_line(`Dire Drought',
        SST 129, Evoc,, Fire, V S XP DC(319), `1~min.', `1000~ft.', `20~h.', `1000~ft. radius emanation',
	`deal 2D6 dessication per rnd.\komma evaporate water\komma cause sandstorm')')
define(`spell_dire_winter', `spell_line(`Dire Winter',
        FRB 107, Evoc,, Cold, V S XP DC(319), `1~min.', `1000~ft.', `20~h.', `1000~ft. radius emanation',
	`deal 2D6 cold per rnd.\komma freeze water\komma cause blizzard')')
define(`spell_dragon_knight', `spell_line(`Dragon Knight',
        ELH 77, Conj, Summ, Fire, V S R DC(38),, `75~ft.', `20~rnd.~D',,
	`summon one adult red dragon that fights for you')')
define(`spell_dragon_strike', `spell_line(`Dragon Strike',
        ELH 77, Conj, Summ, Fire, V S R XP DC(50),, `75~ft.', `20~rnd.~D',,
	`summon ten adult red dragons that fights for you')')

define(`spell_epic_mage_armor', `spell_line(`Epic Mage Armor',
        ELH 79, Conj, Crea, Force Planar, V S DC(46), `1~min.', `range_touch', `24~h.~D',,
	`provide +20 armor bonus to AC')')
define(`spell_global_warming', `spell_line(`Global Warming',
        SST 130, Evoc,, Fire, V S R XP DC(150), `10~min.',, `duration_permanent', `100~mile radius emanation',
	`raise temperature by one band or to warm (61--90{}${}^{\circ}$F $=$ 16--32{}${}^{\circ}$C) -- the higher of both\komma evaporate water\komma create desert')')
define(`spell_ice_age', `spell_line(`Ice Age',
        FRB 107, Trns,, Cold, V S XP DC(323), `1~min.',, `duration_permanent', `20~mile radius emanation',
	`summon glacier\komma temp.~drops by 100{}${}^{\circ}$F or to 0{}${}^{\circ}$F\komma cause blizzard')')
define(`spell_peripety', `spell_line(`Peripety',
        ELH 84, Abjr,,, V S DC(27), `1~min.', `range_you', `12~h.~until discharged',,
	`choose to reflect up to five ranged targeted attacks back on attacker(s)')')
define(`spell_ruin', `spell_line(`Ruin',
        ELH 85, Trns,,, V S XP DC(27), `1~rnd.', `12.000~ft.',,`one creature or 10-ft-cube of non-living matter',
	`deal 20D6')')
define(`spell_volcano', `spell_line(`Volcano',
        SST 130, Conj, Crea, Earth Fire, V S XP DC(56), `1~d.+11~min.',,, `500~ft wide and 500~ft high cone',
	`raise an active volcano')')


dnl search token: XXX


define(`cleric_domains', `air animal chaos death destruction earth evil fire good healing knowledge law luck magic plant protection strength sun travel trickery war water')
define(`spells_domain_cleric', `dnl
ifelse(eval($1 < 1  ||  $1 > 9),1,`error(`wrong cleric domain level $1')')dnl
[0.5ex] \underline{\textbf{Domain Spells:}}\\
patsubst(translit(char_domains, `A-Z-', `a-z'), `\(\<[^ ]+\>\)', `spells_domain_\1_$1 %
')')


dnl List of level 0 spells on page 183
define(`spells_cleric_0', `dnl
spell_create_water
spell_cure_minor_wound
spell_detect_magic
spell_detect_poison
spell_guidance
spell_inflict_minor_wound
spell_light
spell_mending
spell_purify_food_drink
spell_read_magic
spell_resistance
spell_virtue
')

dnl List of level 1 spells on page 183
define(`spells_cleric_1', `dnl
spell_bane
spell_bless
spell_bless_water
spell_cause_fear
spell_command
spell_comprehend_languages
spell_cure_light_wounds
spell_curse_water
spell_deathwatch
spell_detect_chaos
spell_detect_evil
spell_detect_good
spell_detect_law
spell_detect_undead
spell_divine_favor
spell_doom
spell_endure_elements
spell_entropic_shield
spell_hide_from_undead
spell_inflict_light_wounds
spell_magic_stone
spell_magic_weapon
spell_obscuring_mist
spell_protection_from_chaos
spell_protection_from_evil
spell_protection_from_good
spell_protection_from_law
spell_remove_fear
spell_sanctuary
spell_shield_of_faith
spell_summon_monster_1
dnl
spells_domain_cleric(1)
')

dnl List of level 2 spells on page 183 f.
define(`spells_cleric_2', `dnl
spell_aid
spell_align_weapon
spell_augury
spell_bears_endurance
spell_bulls_strength
spell_calm_emotions
spell_consecrate
spell_cure_moderate_wounds
spell_darkness
spell_death_knell
spell_delay_poison
spell_desecrate
spell_eagles_splendor
spell_enthrall
spell_find_traps
spell_gentle_repose
spell_hold_person
spell_inflict_moderate_wounds
spell_make_whole
spell_owls_wisdom
spell_remove_paralysis
spell_resist_energy
spell_restoration_lesser
spell_shatter
spell_shield_other
spell_silence
spell_sound_burst
spell_spiritual_weapon
spell_status
spell_summon_monster_2
spell_undetectable_alignment
spell_zone_of_truth
dnl
spells_domain_cleric(2)
')

dnl List of level 3 spells on page 184
define(`spells_cleric_3', `dnl
spell_animate_dead
spell_bestow_curse
spell_blindness_deafness
spell_contagion
spell_continual_flame
spell_create_food_water
spell_cure_serious_wounds
spell_daylight
spell_deeper_darkness
spell_dispel_magic
spell_glyph_of_warding
spell_helping_hand
spell_inflict_serious_wounds
spell_invisibility_purge
spell_locate_object
spell_magic_circle_against_chaos
spell_magic_circle_against_evil
spell_magic_circle_against_good
spell_magic_circle_against_law
spell_magic_vestment
spell_meld_into_stone
spell_obscure_object
spell_prayer
spell_protection_from_energy
spell_remove_blindness_deafness
spell_remove_curse
spell_remove_disease
spell_searing_light
spell_speak_with_dead
spell_stone_shape
spell_summon_monster_3
spell_water_breathing
spell_water_walk
spell_wind_wall
dnl
spells_domain_cleric(3)
')

dnl List of level 4 spells on page 184
define(`spells_cleric_4', `dnl
spell_air_walk
spell_control_water
spell_cure_critical_wounds
spell_death_ward
spell_dimensional_anchor
spell_discern_lies
spell_dismissal
spell_divination
spell_divine_power
spell_freedom_movement
spell_giant_vermin
spell_imbue_with_spell_ability
spell_inflict_critical_wounds
spell_magic_weapon_greater
spell_neutralize_poison
spell_planar_ally_lesser
spell_poison
spell_repel_vermin
spell_restoration
spell_sending
spell_spell_immunity
spell_summon_monster_4
spell_tongues
dnl
spells_domain_cleric(4)
')

dnl List of level 5 spells on page 184 f.
define(`spells_cleric_5', `dnl
spell_atonement
spell_break_enchantment
spell_command_greater
spell_commune
spell_cure_light_wounds_mass
spell_dispel_chaos
spell_dispel_evil
spell_dispel_good
spell_dispel_law
spell_disrupting_weapon
spell_flame_strike
spell_hallow
spell_inflict_light_wounds_mass
spell_insect_plague
spell_mark_of_justice
spell_plane_shift
spell_raise_dead
spell_righteous_might
spell_scrying
spell_slay_living
spell_spell_resistance
spell_summon_monster_5
spell_symbol_of_pain
spell_symbol_of_sleep
spell_true_seeing
spell_unhallow
spell_wall_of_stone
dnl
spells_domain_cleric(5)
')

dnl List of level 6 spells on page 185
define(`spells_cleric_6', `dnl
spell_animate_objects
spell_antilife_shell
spell_banishment
spell_bears_endurance_mass
spell_blade_barrier
spell_bulls_strength_mass
spell_create_undead
spell_cure_moderate_wounds_mass
spell_dispel_magic_greater
spell_eagles_splendor_mass
spell_find_path
spell_forbiddance
spell_geas
spell_glyph_of_warding_greater
spell_harm
spell_heal
spell_heroes_feast
spell_inflict_moderate_wounds_mass
spell_owls_wisdom_mass
spell_planar_ally
spell_summon_monster_6
spell_symbol_of_fear
spell_symbol_of_persuasion
spell_undeath_to_death
spell_wind_walk
spell_word_of_recall
dnl
spells_domain_cleric(6)
')

dnl List of level 7 spells on page 185
define(`spells_cleric_7', `dnl
spell_blasphemy
spell_control_weather
spell_cure_serious_wounds_mass
spell_destruction
spell_dictum
spell_ethereal_jaunt
spell_holy_word
spell_inflict_serious_wounds_mass
spell_refuge
spell_regenerate
spell_repulsion
spell_restoration_greater
spell_resurrection
spell_scrying_greater
spell_summon_monster_7
spell_symbol_of_stunning
spell_symbol_of_weakness
spell_word_of_chaos
dnl
spells_domain_cleric(7)
')

dnl List of level 8 spells on page 185
define(`spells_cleric_8', `dnl
spell_antimagic_field
spell_cloak_of_chaos
spell_create_greater_undead
spell_cure_critical_wounds_mass
spell_dimensional_lock
spell_discern_location
spell_earthquake
spell_fire_storm
spell_holy_aura
spell_inflict_critical_wounds_mass
spell_planar_ally_greater
spell_shield_of_law
spell_spell_immunity_greater
spell_summon_monster_8
spell_symbol_of_death
spell_symbol_of_insanity
spell_unholy_aura
dnl
spells_domain_cleric(8)
')

dnl List of level 9 spells on page 185
define(`spells_cleric_9', `dnl
spell_astral_projection
spell_energy_drain
spell_etherealness
spell_gate
spell_heal_mass
spell_implosion
spell_miracle
spell_soul_bind
spell_storm_of_vengeance
spell_summon_monster_9
spell_true_resurrection
dnl
spells_domain_cleric(9)
')


dnl The Temple Raider uses the same macro "char_domains" to define its domains as the cleric !!!
dnl This will cause a clash only if a Cleric becomes a Temple Raider.
define(`templeraider_domains', `chaos luck trickery')
define(`spells_domain_templeraider', `dnl
ifelse(eval($1 < 1  ||  $1 > 4),1,`error(`wrong templeraider domain level $1')')dnl
[0.5ex] \underline{\textbf{Domain Spells:}}\\
patsubst(translit(char_domains, `A-Z-', `a-z'), `\(\<[^ ]+\>\)', `spells_domain_\1_$1 %
')')

dnl List of spells on page 18 of Song and Silence
define(`spells_templeraider_1', `dnl
spell_cure_light_wounds
spell_detect_chaos
spell_detect_evil
spell_detect_good
spell_detect_law
spell_detect_secret_doors
spell_endure_elements
spell_entropic_shield
spell_hide_from_undead
spell_inflict_light_wounds
spell_obscuring_mist
spell_protection_from_evil
spell_protection_from_good
spell_protection_from_law
dnl spell_random_action
spell_remove_fear
spell_sanctuary
spell_shield_of_faith
spell_spider_climb
dnl
spells_domain_templeraider(1)
')

define(`spells_templeraider_2', `dnl
spell_augury
spell_cats_grace
spell_cure_moderate_wounds
spell_darkness
spell_darkvision
spell_delay_poison
spell_fog_cloud
spell_hold_person
spell_inflict_moderate_wounds
spell_knock
spell_misdirection
spell_resist_energy
spell_restoration_lesser
spell_silence
spell_undetectable_alignment
dnl
spells_domain_templeraider(2)
')

define(`spells_templeraider_3', `dnl
spell_blindness_deafness
spell_cure_serious_wounds
spell_dispel_magic
spell_inflict_serious_wounds
spell_locate_object
spell_magic_circle_against_evil
spell_magic_circle_against_good
spell_magic_circle_against_law
spell_magic_vestment
dnl spell_negative_energy_protection
spell_protection_from_energy
spell_remove_curse
dnl
spells_domain_templeraider(3)
')

define(`spells_templeraider_4', `dnl
spell_air_walk
spell_cure_critical_wounds
spell_freedom_movement
spell_inflict_critical_wounds
spell_neutralize_poison
spell_restoration
spell_spell_immunity
dnl
spells_domain_templeraider(4)
')



dnl List of Domain AIR on page 185 of Players Handbook
define(`spells_domain_air_1', `spell_obscuring_mist')
define(`spells_domain_air_2', `spell_wind_wall')
define(`spells_domain_air_3', `spell_gaseous_form')
define(`spells_domain_air_4', `spell_air_walk')
define(`spells_domain_air_5', `spell_control_winds')
define(`spells_domain_air_6', `spell_chain_lightning')
define(`spells_domain_air_7', `spell_control_weather')
define(`spells_domain_air_8', `spell_whirlwind')
define(`spells_domain_air_9', `spell_elemental_swarm')

dnl List of Domain ANIMAL on page 186 of Players Handbook
define(`spells_domain_animal_1', `spell_calm_animals')
define(`spells_domain_animal_2', `spell_hold_animal')
define(`spells_domain_animal_3', `spell_dominate_animal')
define(`spells_domain_animal_4', `spell_summon_natures_ally_4')
define(`spells_domain_animal_5', `spell_commune_with_nature')
define(`spells_domain_animal_6', `spell_antilife_shell')
define(`spells_domain_animal_7', `spell_animal_shapes')
define(`spells_domain_animal_8', `spell_summon_natures_ally_8')
define(`spells_domain_animal_9', `spell_shapechange')

dnl List of Domain ARTIFICE on page 213 of Deities and Demigods
define(`spells_domain_artifice_1', `spell_animate_rope')
define(`spells_domain_artifice_2', `spell_wood_shape')
define(`spells_domain_artifice_3', `spell_stone_shape')
define(`spells_domain_artifice_4', `spell_minor_creation')
define(`spells_domain_artifice_5', `spell_fabricate')
define(`spells_domain_artifice_6', `spell_major_creation')
define(`spells_domain_artifice_7', `')
define(`spells_domain_artifice_8', `')
define(`spells_domain_artifice_9', `spell_prismatic_sphere')

dnl List of Domain CHAOS on page 186 of Players Handbook
define(`spells_domain_chaos_1', `spell_protection_from_law')
define(`spells_domain_chaos_2', `spell_shatter')
define(`spells_domain_chaos_3', `spell_magic_circle_against_law')
define(`spells_domain_chaos_4', `spell_chaos_hammer')
define(`spells_domain_chaos_5', `spell_dispel_law')
define(`spells_domain_chaos_6', `spell_animate_objects')
define(`spells_domain_chaos_7', `spell_word_of_chaos')
define(`spells_domain_chaos_8', `spell_cloak_of_chaos')
define(`spells_domain_chaos_9', `spell_summon_monster_9')

dnl List of Domain CHARM on page 213 of Deities and Demigods
define(`spells_domain_charm_1', `spell_charm_person')
define(`spells_domain_charm_2', `spell_calm_emotions')
define(`spells_domain_charm_3', `spell_suggestion')
define(`spells_domain_charm_4', `')dnl unknown spell Emotion
define(`spells_domain_charm_5', `spell_charm_monster')
define(`spells_domain_charm_6', `spell_geas')
define(`spells_domain_charm_7', `spell_insanity')
define(`spells_domain_charm_8', `spell_demand')
define(`spells_domain_charm_9', `spell_dominate_monster')

dnl List of Domain COLD on page 84 of Frostburn
define(`spells_domain_cold_1', `spell_chill_touch')
define(`spells_domain_cold_2', `spell_chill_metal')
define(`spells_domain_cold_3', `spell_sleet_storm')
define(`spells_domain_cold_4', `spell_ice_storm')
define(`spells_domain_cold_5', `spell_wall_of_ice')
define(`spells_domain_cold_6', `spell_cone_of_cold')
define(`spells_domain_cold_7', `spell_control_weather')
define(`spells_domain_cold_8', `spell_polar_ray')
define(`spells_domain_cold_9', `')

dnl List of Domain COMMUNITY on page 213 of Deities and Demigods
define(`spells_domain_community_1', `spell_bless')
define(`spells_domain_community_2', `spell_shield_other')
define(`spells_domain_community_3', `spell_prayer')
define(`spells_domain_community_4', `spell_status')
define(`spells_domain_community_5', `spell_rarys_telepathic_bond')
define(`spells_domain_community_6', `spell_heroes_feast')
define(`spells_domain_community_7', `spell_refuge')
define(`spells_domain_community_8', `spell_heal_mass')
define(`spells_domain_community_9', `spell_miracle')

dnl List of Domain CREATION on page 213 of Deities and Demigods
define(`spells_domain_creation_1', `spell_create_water')
define(`spells_domain_creation_2', `spell_minor_image')
define(`spells_domain_creation_3', `spell_create_food_water')
define(`spells_domain_creation_4', `spell_minor_creation')
define(`spells_domain_creation_5', `spell_major_creation')
define(`spells_domain_creation_6', `spell_heroes_feast')
define(`spells_domain_creation_7', `spell_permanent_image')
define(`spells_domain_creation_8', `')
define(`spells_domain_creation_9', `')

dnl List of Domain DARKNESS on page 213 of Deities and Demigods
define(`spells_domain_darkness_1', `spell_obscuring_mist')
define(`spells_domain_darkness_2', `spell_blindness_deafness')
define(`spells_domain_darkness_3', `')
define(`spells_domain_darkness_4', `')
define(`spells_domain_darkness_5', `spell_summon_monster_5')
define(`spells_domain_darkness_6', `spell_prying_eyes')
define(`spells_domain_darkness_7', `spell_nightmare')
define(`spells_domain_darkness_8', `spell_power_word_blind')
define(`spells_domain_darkness_9', `spell_power_word_kill')

dnl List of Domain DEATH on page 186 of Players Handbook
define(`spells_domain_death_1', `spell_cause_fear')
define(`spells_domain_death_2', `spell_death_knell')
define(`spells_domain_death_3', `spell_animate_dead')
define(`spells_domain_death_4', `spell_death_ward')
define(`spells_domain_death_5', `spell_slay_living')
define(`spells_domain_death_6', `spell_create_undead')
define(`spells_domain_death_7', `spell_destruction')
define(`spells_domain_death_8', `spell_create_greater_undead')
define(`spells_domain_death_9', `spell_wail_of_banshee')

dnl List of Domain DESTRUCTION on page 186 of Players Handbook
define(`spells_domain_destruction_1', `spell_inflict_light_wounds')
define(`spells_domain_destruction_2', `spell_shatter')
define(`spells_domain_destruction_3', `spell_contagion')
define(`spells_domain_destruction_4', `spell_inflict_critical_wounds')
define(`spells_domain_destruction_5', `spell_inflict_light_wounds_mass')
define(`spells_domain_destruction_6', `spell_harm')
define(`spells_domain_destruction_7', `spell_disintegrate')
define(`spells_domain_destruction_8', `spell_earthquake')
define(`spells_domain_destruction_9', `spell_implosion')

dnl List of Domain EARTH on page 186 of Players Handbook
define(`spells_domain_earth_1', `spell_magic_stone')
define(`spells_domain_earth_2', `spell_soften_earth_stone')
define(`spells_domain_earth_3', `spell_stone_shape')
define(`spells_domain_earth_4', `spell_spike_stones')
define(`spells_domain_earth_5', `spell_wall_of_stone')
define(`spells_domain_earth_6', `spell_stoneskin')
define(`spells_domain_earth_7', `spell_earthquake')
define(`spells_domain_earth_8', `spell_iron_body')
define(`spells_domain_earth_9', `spell_elemental_swarm')

dnl List of Domain EVIL on page 186 of Players Handbook
define(`spells_domain_evil_1', `spell_protection_from_good')
define(`spells_domain_evil_2', `spell_desecrate')
define(`spells_domain_evil_3', `spell_magic_circle_against_good')
define(`spells_domain_evil_4', `spell_unholy_blight')
define(`spells_domain_evil_5', `spell_dispel_good')
define(`spells_domain_evil_6', `spell_create_undead')
define(`spells_domain_evil_7', `spell_blasphemy')
define(`spells_domain_evil_8', `spell_unholy_aura')
define(`spells_domain_evil_9', `spell_summon_monster_9')

dnl List of Domain FIRE on page 187 of Players Handbook
define(`spells_domain_fire_1', `spell_burning_hands')
define(`spells_domain_fire_2', `spell_produce_flame')
define(`spells_domain_fire_3', `spell_resist_energy')
define(`spells_domain_fire_4', `spell_wall_of_fire')
define(`spells_domain_fire_5', `spell_fire_shield')
define(`spells_domain_fire_6', `spell_fire_seeds')
define(`spells_domain_fire_7', `spell_fire_storm')
define(`spells_domain_fire_8', `spell_incendiary_cloud')
define(`spells_domain_fire_9', `spell_elemental_swarm')

dnl List of Domain GLORY on page 214 of Deities and Demigods
define(`spells_domain_glory_1', `spell_disrupt_undead')
define(`spells_domain_glory_2', `spell_bless_weapon')
define(`spells_domain_glory_3', `spell_searing_light')
define(`spells_domain_glory_4', `spell_holy_smite')
define(`spells_domain_glory_5', `spell_holy_sword')
define(`spells_domain_glory_6', `')
define(`spells_domain_glory_7', `spell_sunbeam')
define(`spells_domain_glory_8', `')
define(`spells_domain_glory_9', `spell_gate')

dnl List of Domain GOOD on page 187 of Players Handbook
define(`spells_domain_good_1', `spell_protection_from_evil')
define(`spells_domain_good_2', `spell_aid')
define(`spells_domain_good_3', `spell_magic_circle_against_evil')
define(`spells_domain_good_4', `spell_holy_smite')
define(`spells_domain_good_5', `spell_dispel_evil')
define(`spells_domain_good_6', `spell_blade_barrier')
define(`spells_domain_good_7', `spell_holy_word')
define(`spells_domain_good_8', `spell_holy_aura')
define(`spells_domain_good_9', `spell_summon_monster_9')

dnl List of Domain HEALING on page 187 of Players Handbook
define(`spells_domain_healing_1', `spell_cure_light_wounds')
define(`spells_domain_healing_2', `spell_cure_moderate_wounds')
define(`spells_domain_healing_3', `spell_cure_serious_wounds')
define(`spells_domain_healing_4', `spell_cure_critical_wounds')
define(`spells_domain_healing_5', `spell_cure_light_wounds_mass')
define(`spells_domain_healing_6', `spell_heal')
define(`spells_domain_healing_7', `spell_regenerate')
define(`spells_domain_healing_8', `spell_cure_critical_wounds_mass')
define(`spells_domain_healing_9', `spell_heal_mass')

dnl List of Domain KNOWLEDGE on page 187 of Players Handbook
define(`spells_domain_knowledge_1', `spell_detect_secret_doors')
define(`spells_domain_knowledge_2', `spell_detect_thoughts')
define(`spells_domain_knowledge_3', `spell_clairaudience_clairvoyance')
define(`spells_domain_knowledge_4', `spell_divination')
define(`spells_domain_knowledge_5', `spell_true_seeing')
define(`spells_domain_knowledge_6', `spell_find_path')
define(`spells_domain_knowledge_7', `spell_legend_lore')
define(`spells_domain_knowledge_8', `spell_discern_location')
define(`spells_domain_knowledge_9', `spell_foresight')

dnl List of Domain LAW on page 187 of Players Handbook
define(`spells_domain_law_1', `spell_protection_from_chaos')
define(`spells_domain_law_2', `spell_calm_emotions')
define(`spells_domain_law_3', `spell_magic_circle_against_chaos')
define(`spells_domain_law_4', `spell_orders_wrath')
define(`spells_domain_law_5', `spell_dispel_chaos')
define(`spells_domain_law_6', `spell_hold_monster')
define(`spells_domain_law_7', `spell_dictum')
define(`spells_domain_law_8', `spell_shield_of_law')
define(`spells_domain_law_9', `spell_summon_monster_9')

dnl List of Domain LIBERATION on page 214 of Deities and Demigods
define(`spells_domain_liberation_1', `spell_remove_fear')
define(`spells_domain_liberation_2', `spell_remove_paralysis')
define(`spells_domain_liberation_3', `spell_remove_curse')
define(`spells_domain_liberation_4', `spell_freedom_movement')
define(`spells_domain_liberation_5', `spell_break_enchantment')
define(`spells_domain_liberation_6', `')dnl unknown spell "Greater Dispelling"
define(`spells_domain_liberation_7', `spell_refuge')
define(`spells_domain_liberation_8', `spell_mind_blank')
define(`spells_domain_liberation_9', `')dnl unknown spell "Unbinding"

dnl List of Domain LUCK on page 187 of Players Handbook
define(`spells_domain_luck_1', `spell_entropic_shield')
define(`spells_domain_luck_2', `spell_aid')
define(`spells_domain_luck_3', `spell_protection_from_energy')
define(`spells_domain_luck_4', `spell_freedom_movement')
define(`spells_domain_luck_5', `spell_break_enchantment')
define(`spells_domain_luck_6', `spell_mislead')
define(`spells_domain_luck_7', `spell_spell_turning')
define(`spells_domain_luck_8', `spell_moment_of_prescience')
define(`spells_domain_luck_9', `spell_miracle')

dnl List of Domain MADNESS on page 214 of Deities and Demigods
define(`spells_domain_madness_1', `')dnl unknown spell "Random Action"
define(`spells_domain_madness_2', `')
define(`spells_domain_madness_3', `')
define(`spells_domain_madness_4', `spell_confusion')
define(`spells_domain_madness_5', `')
define(`spells_domain_madness_6', `spell_phantasmal_killer')
define(`spells_domain_madness_7', `spell_insanity')
define(`spells_domain_madness_8', `')
define(`spells_domain_madness_9', `spell_weird')

dnl List of Domain MAGIC on page 188 of Players Handbook
define(`spells_domain_magic_1', `spell_nystuls_magic_aura')
define(`spells_domain_magic_2', `spell_identify')
define(`spells_domain_magic_3', `spell_dispel_magic')
define(`spells_domain_magic_4', `spell_imbue_with_spell_ability')
define(`spells_domain_magic_5', `spell_spell_resistance')
define(`spells_domain_magic_6', `spell_antimagic_field')
define(`spells_domain_magic_7', `spell_spell_turning')
define(`spells_domain_magic_8', `spell_protection_from_spells')
define(`spells_domain_magic_9', `spell_mordenkainens_disjunction')

dnl List of Domain NOBILITY on page 106 of Sandstorm and on page 214 of Deities and Demigods
define(`spells_domain_nobility_1', `spell_divine_favor')
define(`spells_domain_nobility_2', `spell_enthrall')
define(`spells_domain_nobility_3', `spell_magic_vestment')
define(`spells_domain_nobility_4', `spell_discern_lies')
define(`spells_domain_nobility_5', `spell_command_greater')
define(`spells_domain_nobility_6', `spell_geas')
define(`spells_domain_nobility_7', `spell_repulsion')
define(`spells_domain_nobility_8', `spell_demand')
define(`spells_domain_nobility_9', `spell_storm_of_vengeance')

dnl List of Domain PLANT on page 188 of Players Handbook
define(`spells_domain_plant_1', `spell_entangle')
define(`spells_domain_plant_2', `spell_barkskin')
define(`spells_domain_plant_3', `spell_plant_growth')
define(`spells_domain_plant_4', `spell_command_plants')
define(`spells_domain_plant_5', `spell_wall_of_thorns')
define(`spells_domain_plant_6', `spell_repel_wood')
define(`spells_domain_plant_7', `spell_animate_plants')
define(`spells_domain_plant_8', `spell_control_plants')
define(`spells_domain_plant_9', `spell_shambler')

dnl List of Domain PROTECTION on page 188 of Players Handbook
define(`spells_domain_protection_1', `spell_sanctuary')
define(`spells_domain_protection_2', `spell_shield_other')
define(`spells_domain_protection_3', `spell_protection_from_energy')
define(`spells_domain_protection_4', `spell_spell_immunity')
define(`spells_domain_protection_5', `spell_spell_resistance')
define(`spells_domain_protection_6', `spell_antimagic_field')
define(`spells_domain_protection_7', `spell_repulsion')
define(`spells_domain_protection_8', `spell_mind_blank')
define(`spells_domain_protection_9', `spell_prismatic_sphere')

dnl List of Domain REPOSE on page 107 of Sandstorm and on page 215 of Deities and Demigods
define(`spells_domain_repose_1', `spell_deathwatch')
define(`spells_domain_repose_2', `spell_gentle_repose')
define(`spells_domain_repose_3', `spell_speak_with_dead')
define(`spells_domain_repose_4', `spell_discern_lies')dnl Death Watch in Deities and Demigods
define(`spells_domain_repose_5', `spell_command_greater')dnl Slay Living in Deities and Demigods
define(`spells_domain_repose_6', `spell_undeath_to_death')
define(`spells_domain_repose_7', `spell_destruction')
define(`spells_domain_repose_8', `spell_surelife')
define(`spells_domain_repose_9', `spell_wail_of_banshee')

dnl List of Domain RUNE on page 107 of Sandstorm and on page 215 of Deities and Demigods
define(`spells_domain_rune_1', `spell_erase')
define(`spells_domain_rune_2', `spell_secret_page')
define(`spells_domain_rune_3', `spell_glyph_of_warding')
define(`spells_domain_rune_4', `spell_explosive_runes')
define(`spells_domain_rune_5', `spell_planar_binding_lesser')
define(`spells_domain_rune_6', `spell_glyph_of_warding_greater')
define(`spells_domain_rune_7', `spell_drawmijs_instant_summons')
define(`spells_domain_rune_8', `spell_transcribe_symbol')dnl Symbol in Deities and Demigods
define(`spells_domain_rune_9', `spell_teleportation_circle')

dnl List of Domain SAND on page 107 of Sandstorm
define(`spells_domain_sand_1', `spell_wastestrider')
define(`spells_domain_sand_2', `spell_black_sand')
define(`spells_domain_sand_3', `spell_haboob')
define(`spells_domain_sand_4', `spell_blast_of_sand')
define(`spells_domain_sand_5', `spell_flaywind_burst')
define(`spells_domain_sand_6', `spell_awaken_sand')
define(`spells_domain_sand_7', `spell_vitrify')
define(`spells_domain_sand_8', `spell_desert_binding')
define(`spells_domain_sand_9', `spell_summon_desert_ally_9')

dnl List of Domain SCALYKIND on page 215 of Deities and Demigods
define(`spells_domain_scalykind_1', `spell_magic_fang')
define(`spells_domain_scalykind_2', `spell_animal_trance')
define(`spells_domain_scalykind_3', `spell_magic_fang_greater')
define(`spells_domain_scalykind_4', `spell_poison')
define(`spells_domain_scalykind_5', `spell_animal_growth')
define(`spells_domain_scalykind_6', `spell_eyebite')
define(`spells_domain_scalykind_7', `spell_creeping_doom')
define(`spells_domain_scalykind_8', `spell_animal_shapes')
define(`spells_domain_scalykind_9', `spell_shapechange')

dnl List of Domain STRENGTH on page 188 of Players Handbook
define(`spells_domain_strength_1', `spell_enlarge_person')
define(`spells_domain_strength_2', `spell_bulls_strength')
define(`spells_domain_strength_3', `spell_magic_vestment')
define(`spells_domain_strength_4', `spell_spell_immunity')
define(`spells_domain_strength_5', `spell_righteous_might')
define(`spells_domain_strength_6', `spell_stoneskin')
define(`spells_domain_strength_7', `spell_bigbys_grasping_hand')
define(`spells_domain_strength_8', `spell_bigbys_clenched_fist')
define(`spells_domain_strength_9', `spell_bigbys_crushing_hand')

dnl List of Domain SUMMER on page 107 of Sandstorm
define(`spells_domain_summer_1', `spell_impede_suns_brilliance')
define(`spells_domain_summer_2', `spell_sunstroke')
define(`spells_domain_summer_3', `spell_protection_from_desiccation')
define(`spells_domain_summer_4', `spell_skin_of_cactus')
define(`spells_domain_summer_5', `spell_unearthly_heat')
define(`spells_domain_summer_6', `spell_sunbeam')
define(`spells_domain_summer_7', `spell_control_weather')
define(`spells_domain_summer_8', `spell_sunburst')
define(`spells_domain_summer_9', `spell_storm_of_vengeance')

dnl List of Domain SUN on page 188 of Players Handbook
define(`spells_domain_sun_1', `spell_endure_elements')
define(`spells_domain_sun_2', `spell_heat_metal')
define(`spells_domain_sun_3', `spell_searing_light')
define(`spells_domain_sun_4', `spell_fire_shield')
define(`spells_domain_sun_5', `spell_flame_strike')
define(`spells_domain_sun_6', `spell_fire_seeds')
define(`spells_domain_sun_7', `spell_sunbeam')
define(`spells_domain_sun_8', `spell_sunburst')
define(`spells_domain_sun_9', `spell_prismatic_sphere')

dnl List of Domain THIRST on page 108 of Sandstorm
define(`spells_domain_thirst_1', `spell_parching_touch')
define(`spells_domain_thirst_2', `spell_desiccate')
define(`spells_domain_thirst_3', `spell_tormenting_thirst')
define(`spells_domain_thirst_4', `spell_dispel_water')
define(`spells_domain_thirst_5', `spell_desiccate_mass')
define(`spells_domain_thirst_6', `spell_symbol_of_thirst')
define(`spells_domain_thirst_7', `spell_mephit_mob')
define(`spells_domain_thirst_8', `spell_horrid_wilting')
define(`spells_domain_thirst_9', `spell_energy_drain')

dnl List of Domain TRAVEL on page 188 f. of Players Handbook
define(`spells_domain_travel_1', `spell_longstrider')
define(`spells_domain_travel_2', `spell_locate_object')
define(`spells_domain_travel_3', `spell_fly')
define(`spells_domain_travel_4', `spell_dimension_door')
define(`spells_domain_travel_5', `spell_teleport')
define(`spells_domain_travel_6', `spell_find_path')
define(`spells_domain_travel_7', `spell_teleport_greater')
define(`spells_domain_travel_8', `spell_phase_door')
define(`spells_domain_travel_9', `spell_astral_projection')

dnl List of Domain TRICKERY on page 189 of Players Handbook
define(`spells_domain_trickery_1', `spell_disguise_self')
define(`spells_domain_trickery_2', `spell_invisibility')
define(`spells_domain_trickery_3', `spell_nondetection')
define(`spells_domain_trickery_4', `spell_confusion')
define(`spells_domain_trickery_5', `spell_false_vision')
define(`spells_domain_trickery_6', `spell_mislead')
define(`spells_domain_trickery_7', `spell_screen')
define(`spells_domain_trickery_8', `spell_polymorph_any_object')
define(`spells_domain_trickery_9', `spell_time_stop')

dnl List of Domain WAR on page 189 of Players Handbook
define(`spells_domain_war_1', `spell_magic_weapon')
define(`spells_domain_war_2', `spell_spiritual_weapon')
define(`spells_domain_war_3', `spell_magic_vestment')
define(`spells_domain_war_4', `spell_divine_power')
define(`spells_domain_war_5', `spell_flame_strike')
define(`spells_domain_war_6', `spell_blade_barrier')
define(`spells_domain_war_7', `spell_power_word_blind')
define(`spells_domain_war_8', `spell_power_word_stun')
define(`spells_domain_war_9', `spell_power_word_kill')

dnl List of Domain WATER on page 189 of Players Handbook
define(`spells_domain_water_1', `spell_obscuring_mist')
define(`spells_domain_water_2', `spell_fog_cloud')
define(`spells_domain_water_3', `spell_water_breathing')
define(`spells_domain_water_4', `spell_control_water')
define(`spells_domain_water_5', `spell_ice_storm')
define(`spells_domain_water_6', `spell_cone_of_cold')
define(`spells_domain_water_7', `spell_acid_fog')
define(`spells_domain_water_8', `spell_horrid_wilting')
define(`spells_domain_water_9', `spell_elemental_swarm')

dnl List of Domain WEATHER on page 215 of Deities and Demigods
define(`spells_domain_weather_1', `spell_obscuring_mist')
define(`spells_domain_weather_2', `spell_fog_cloud')
define(`spells_domain_weather_3', `spell_call_lightning')
define(`spells_domain_weather_4', `spell_sleet_storm')
define(`spells_domain_weather_5', `spell_ice_storm')
define(`spells_domain_weather_6', `spell_control_winds')
define(`spells_domain_weather_7', `spell_control_weather')
define(`spells_domain_weather_8', `spell_whirlwind')
define(`spells_domain_weather_9', `spell_storm_of_vengeance')

dnl List of Domain WINTER on page 85 of Frostburn
define(`spells_domain_winter_1', `spell_snowsight')
define(`spells_domain_winter_2', `spell_snow_walk')
define(`spells_domain_winter_3', `spell_winters_embrace')
define(`spells_domain_winter_4', `spell_ice_storm')
define(`spells_domain_winter_5', `spell_blizzard')
define(`spells_domain_winter_6', `spell_death_hail')
define(`spells_domain_winter_7', `spell_control_weather')
define(`spells_domain_winter_8', `spell_summon_giants')
define(`spells_domain_winter_9', `spell_fimbulwinter')






dnl List of level 0 spells on page 189
define(`spells_druid_0', `dnl
spell_create_water
spell_cure_minor_wound
spell_detect_magic
spell_detect_poison
spell_flare
spell_guidance
spell_know_direction
spell_light
spell_mending
spell_purify_food_drink
spell_read_magic
spell_resistance
spell_virtue
ifdef(`extra_spells_druid_0', `extra_spells_druid_0', %)
')

dnl List of level 1 spells on page 189
define(`spells_druid_1', `dnl
spell_calm_animals
spell_charm_animal
spell_cure_light_wounds
spell_detect_animal_or_plants
spell_detect_snares_and_pits
spell_endure_elements
spell_entangle
spell_faerie_fire
spell_goodberry
spell_hide_from_animals
spell_jump
spell_longstrider
spell_magic_fang
spell_magic_stone
spell_obscuring_mist
spell_pass_without_trace
spell_produce_flame
spell_shillelagh
spell_speak_with_animals
spell_summon_natures_ally_1
ifdef(`extra_spells_druid_1', `extra_spells_druid_1', %)
')

dnl List of level 2 spells on page 189 f.
define(`spells_druid_2', `dnl
spell_animal_messenger
spell_animal_trance
spell_barkskin
spell_bears_endurance
spell_bulls_strength
spell_cats_grace
spell_chill_metal
spell_delay_poison
spell_fire_trap
spell_flame_blade
spell_flaming_sphere
spell_fog_cloud
spell_gust_of_wind
spell_heat_metal
spell_hold_animal
spell_owls_wisdom
spell_reduce_animal
spell_resist_energy
spell_restoration_lesser
spell_soften_earth_stone
spell_spider_climb
spell_summon_natures_ally_2
spell_summon_swarm
spell_tree_shape
spell_warp_wood
spell_wood_shape
ifdef(`extra_spells_druid_2', `extra_spells_druid_2', %)
')

dnl List of level 3 spells on page 190
define(`spells_druid_3', `dnl
spell_call_lightning
spell_contagion
spell_cure_moderate_wounds
spell_daylight
spell_diminish_plants
spell_dominate_animal
spell_magic_fang_greater
spell_meld_into_stone
spell_neutralize_poison
spell_plant_growth
spell_poison
spell_protection_from_energy
spell_quench
spell_remove_disease
spell_sleet_storm
spell_snare
spell_speak_with_plants
spell_spike_growth
spell_stone_shape
spell_summon_natures_ally_3
spell_water_breathing
spell_wind_wall
ifdef(`extra_spells_druid_3', `extra_spells_druid_3', %)
')

dnl List of level 4 spells on page 190
define(`spells_druid_4', `dnl
spell_air_walk
spell_antiplant_shell
spell_blight
spell_command_plants
spell_control_water
spell_cure_serious_wounds
spell_dispel_magic
spell_flame_strike
spell_freedom_movement
spell_giant_vermin
spell_ice_storm
spell_reincarnate
spell_repel_vermin
spell_rusting_grasp
spell_scrying
spell_spike_stones
spell_summon_natures_ally_4
ifdef(`extra_spells_druid_4', `extra_spells_druid_4', %)
')

dnl List of level 5 spells on page 190
define(`spells_druid_5', `dnl
spell_animal_growth
spell_atonement
spell_awaken
spell_baleful_polymorph
spell_call_lightning_storm
spell_commune_with_nature
spell_control_winds
spell_cure_critical_wounds
spell_death_ward
spell_hallow
spell_insect_plague
spell_stoneskin
spell_summon_natures_ally_5
spell_transmute_mud_to_rock
spell_transmute_rock_to_mud
spell_tree_stride
spell_unhallow
spell_wall_of_fire
dnl would fit for druids: spell_wall_of_ice
spell_wall_of_thorns
ifdef(`extra_spells_druid_5', `extra_spells_druid_5', %)
')

dnl List of level 6 spells on page 190
define(`spells_druid_6', `dnl
spell_antilife_shell
spell_bears_endurance_mass
spell_bulls_strength_mass
spell_cats_grace_mass
spell_cure_light_wounds_mass
spell_dispel_magic_greater
spell_find_path
spell_fire_seeds
spell_ironwood
spell_liveoak
spell_move_earth
spell_owls_wisdom_mass
spell_repel_wood
spell_spellstaff
spell_stone_tell
spell_summon_natures_ally_6
spell_transport_via_plants
spell_wall_of_stone
ifdef(`extra_spells_druid_6', `extra_spells_druid_6', %)
')

dnl List of level 7 spells on page 190
define(`spells_druid_7', `dnl
spell_animate_plants
spell_changestaff
spell_control_weather
spell_creeping_doom
spell_cure_moderate_wounds_mass
spell_fire_storm
spell_heal
spell_scrying_greater
spell_summon_natures_ally_7
spell_sunbeam
spell_transmute_metal_to_wood
spell_true_seeing
spell_wind_walk
ifdef(`extra_spells_druid_7', `extra_spells_druid_7', %)
')

dnl List of level 8 spells on page 191
define(`spells_druid_8', `dnl
spell_animal_shapes
spell_control_plants
spell_cure_serious_wounds_mass
spell_earthquake
spell_finger_of_death
spell_repel_metal_or_stone
spell_reverse_gravity
spell_summon_natures_ally_8
spell_sunburst
spell_whirlwind
spell_word_of_recall
ifdef(`extra_spells_druid_8', `extra_spells_druid_8', %)
')

dnl List of level 9 spells on page 191
define(`spells_druid_9', `dnl
spell_antipathy
spell_cure_critical_wounds_mass
spell_elemental_swarm
spell_foresight
spell_regenerate
spell_shambler
spell_shapechange
spell_storm_of_vengeance
spell_summon_natures_ally_9
spell_sympathy
ifdef(`extra_spells_druid_9', `extra_spells_druid_9', %)
')



dnl List of level 1 spell on page 191
define(`spells_paladin_1', `dnl
spell_bless
spell_bless_water
spell_bless_weapon
spell_create_water
spell_cure_light_wounds
spell_detect_poison
spell_detect_undead
spell_divine_favor
spell_endure_elements
spell_magic_weapon
spell_protection_from_chaos
spell_protection_from_evil
spell_read_magic
spell_resistance
spell_restoration_lesser
spell_virtue
')

dnl List of level 2 spell on page 191
define(`spells_paladin_2', `dnl
spell_bulls_strength
spell_delay_poison
spell_eagles_splendor
spell_owls_wisdom
spell_remove_paralysis
spell_resist_energy
spell_shield_other
spell_undetectable_alignment
spell_zone_of_truth
')

dnl List of level 3 spell on page 191
define(`spells_paladin_3', `dnl
spell_cure_moderate_wounds
spell_daylight
spell_discern_lies
spell_dispel_magic
spell_heal_mount
spell_magic_circle_against_chaos
spell_magic_circle_against_evil
spell_magic_weapon_greater
spell_prayer
spell_remove_blindness_deafness
spell_remove_curse
')

dnl List of level 4 spell on page 191
define(`spells_paladin_4', `dnl
spell_break_enchantment
spell_cure_serious_wounds
spell_death_ward
spell_dispel_chaos
spell_dispel_evil
spell_holy_sword
spell_mark_of_justice
spell_neutralize_poison
spell_restoration
')



dnl List of level 1 spell on page 191
define(`spells_ranger_1', `dnl
spell_alarm
spell_animal_messenger
spell_calm_animals
spell_charm_animal
spell_delay_poison
spell_detect_animal_or_plants
spell_detect_poison
spell_detect_snares_and_pits
spell_endure_elements
spell_entangle
spell_hide_from_animals
spell_jump
spell_longstrider
spell_magic_fang
spell_pass_without_trace
spell_read_magic
spell_resist_energy
spell_speak_with_animals
spell_summon_natures_ally_1
ifdef(`extra_spells_ranger_1', `extra_spells_ranger_1', %)
')

dnl List of level 2 spell on page 191 f.
define(`spells_ranger_2', `dnl
spell_barkskin
spell_bears_endurance
spell_cats_grace
spell_cure_light_wounds
spell_hold_animal
spell_owls_wisdom
spell_protection_from_energy
spell_snare
spell_speak_with_plants
spell_spike_growth
spell_summon_natures_ally_2
spell_wind_wall
ifdef(`extra_spells_ranger_2', `extra_spells_ranger_2', %)
')

dnl List of level 3 spell on page 192
define(`spells_ranger_3', `dnl
spell_command_plants
spell_cure_moderate_wounds
spell_darkvision
spell_diminish_plants
spell_magic_fang_greater
spell_neutralize_poison
spell_plant_growth
spell_reduce_animal
spell_remove_disease
spell_repel_vermin
spell_summon_natures_ally_3
spell_tree_shape
spell_water_walk
ifdef(`extra_spells_ranger_3', `extra_spells_ranger_3', %)
')

dnl List of level 4 spell on page 192
define(`spells_ranger_4', `dnl
spell_animal_growth
spell_commune_with_nature
spell_cure_serious_wounds
spell_freedom_movement
spell_nondetection
spell_summon_natures_ally_4
spell_tree_stride
ifdef(`extra_spells_ranger_4', `extra_spells_ranger_4', %)
')




dnl ***** Cleric Spells
ifelse(eval(level_cleric > 0),1,`dnl
define(`level_caster_base', eval(level_cleric + adjust_CL_cleric))dnl adjustments possible e.g. by prestige classes
define(`type_caster', D)dnl devine caster type
define(`token_caster', cleric)dnl
%
%\small
\footnotesize
%
ifelse(eval(level_caster_base >=  1),1, `spell_headline(cleric, Cleric, 0, WIS)', %)
ifelse(eval(level_caster_base >=  1),1, `spell_headline(cleric, Cleric, 1, WIS)', %)
ifelse(eval(level_caster_base >=  3),1, `spell_headline(cleric, Cleric, 2, WIS)', %)
ifelse(eval(level_caster_base >=  5),1, `spell_headline(cleric, Cleric, 3, WIS)', %)
ifelse(eval(level_caster_base >=  7),1, `spell_headline(cleric, Cleric, 4, WIS)', %)
ifelse(eval(level_caster_base >=  9),1, `spell_headline(cleric, Cleric, 5, WIS)', %)
ifelse(eval(level_caster_base >= 11),1, `spell_headline(cleric, Cleric, 6, WIS)', %)
ifelse(eval(level_caster_base >= 13),1, `spell_headline(cleric, Cleric, 7, WIS)', %)
ifelse(eval(level_caster_base >= 15),1, `spell_headline(cleric, Cleric, 8, WIS)', %)
ifelse(eval(level_caster_base >= 17),1, `spell_headline(cleric, Cleric, 9, WIS)', %)
ifelse(eval(level_caster_base >= 20  &&  ifdef(`feat_improved_spell_capacity',1,0)),1, `spells_above_max_level(cleric, Cleric, 10, WIS)', %)
%
\normalsize
')%
%
%
dnl ***** Druid Spells
ifelse(eval(level_druid > 0),1,`dnl
define(`level_caster_base', eval(level_druid + adjust_CL_druid))dnl adjustments possible e.g. by prestige classes
define(`type_caster', D)dnl devine caster type
define(`token_caster', druid)dnl
%
%\small
\footnotesize
%
ifelse(eval(level_caster_base >=  1),1, `spell_headline(druid, Druid, 0, WIS)', %)
ifelse(eval(level_caster_base >=  1),1, `spell_headline(druid, Druid, 1, WIS)', %)
ifelse(eval(level_caster_base >=  3),1, `spell_headline(druid, Druid, 2, WIS)', %)
ifelse(eval(level_caster_base >=  5),1, `spell_headline(druid, Druid, 3, WIS)', %)
ifelse(eval(level_caster_base >=  7),1, `spell_headline(druid, Druid, 4, WIS)', %)
ifelse(eval(level_caster_base >=  9),1, `spell_headline(druid, Druid, 5, WIS)', %)
ifelse(eval(level_caster_base >= 11),1, `spell_headline(druid, Druid, 6, WIS)', %)
ifelse(eval(level_caster_base >= 13),1, `spell_headline(druid, Druid, 7, WIS)', %)
ifelse(eval(level_caster_base >= 15),1, `spell_headline(druid, Druid, 8, WIS)', %)
ifelse(eval(level_caster_base >= 17),1, `spell_headline(druid, Druid, 9, WIS)', %)
ifelse(eval(level_caster_base >= 20  &&  ifdef(`feat_improved_spell_capacity',1,0)),1, `spells_above_max_level(druid, Druid, 10, WIS)', %)
%
\normalsize
')%
%
%
dnl dnl ***** Paladin Spells
ifelse(eval(level_paladin > 0),1,`dnl
define(`level_caster_base', eval(level_paladin / 2 + adjust_CL_paladin))dnl adjustments possible e.g. by prestige classes, how affect the paladins caster level: full or half (like its class level) ???
define(`type_caster', D)dnl devine caster type
define(`token_caster', paladin)dnl
%
%\small
\footnotesize
%
ifelse(eval(level_paladin >= 4  &&  level_caster_base >=  4),1, `spell_headline(paladin, Paladin, 1, WIS)', %)
ifelse(eval(level_paladin >= 4  &&  level_caster_base >=  8),1, `spell_headline(paladin, Paladin, 2, WIS)', %)
ifelse(eval(level_paladin >= 4  &&  level_caster_base >= 11),1, `spell_headline(paladin, Paladin, 3, WIS)', %)
ifelse(eval(level_paladin >= 4  &&  level_caster_base >= 14),1, `spell_headline(paladin, Paladin, 4, WIS)', %)
ifelse(eval(level_paladin >= 4  &&  level_caster_base >= 20  &&  ifdef(`feat_improved_spell_capacity',1,0)),1, `spells_above_max_level(paladin, Paladin, 5, WIS)', %)
%
\normalsize
')%
%
%
dnl dnl ***** Ranger Spells
ifelse(eval(level_ranger > 0),1,`dnl
define(`level_caster_base', eval(level_ranger / 2 + adjust_CL_ranger))dnl adjustments possible e.g. by prestige classes, how affect the rangers caster level: full or half (like its class level) ???
define(`type_caster', D)dnl devine caster type
define(`token_caster', ranger)dnl
%
%\small
\footnotesize
%
ifelse(eval(level_ranger >= 4  &&  level_caster_base >=  4),1, `spell_headline(ranger, Ranger, 1, WIS)', %)
ifelse(eval(level_ranger >= 4  &&  level_caster_base >=  8),1, `spell_headline(ranger, Ranger, 2, WIS)', %)
ifelse(eval(level_ranger >= 4  &&  level_caster_base >= 11),1, `spell_headline(ranger, Ranger, 3, WIS)', %)
ifelse(eval(level_ranger >= 4  &&  level_caster_base >= 14),1, `spell_headline(ranger, Ranger, 4, WIS)', %)
ifelse(eval(level_ranger >= 4  &&  level_caster_base >= 20  &&  ifdef(`feat_improved_spell_capacity',1,0)),1, `spells_above_max_level(ranger, Ranger, 5, WIS)', %)
%
\normalsize
')%
%
%
dnl ***** Bard Spells
ifelse(eval(level_bard > 0),1,`dnl
define(`level_caster_base', eval(level_bard + adjust_CL_bard))dnl adjustments possible e.g. by prestige classes
define(`type_caster', A)dnl arcane caster type
define(`token_caster', bard)dnl
%
%\small
\footnotesize
%
ifelse(eval(level_caster_base >=  1),1, `spell_headline(bard, Bard, 0, CHA)', %)
ifelse(eval(level_caster_base >=  2),1, `spell_headline(bard, Bard, 1, CHA)', %)
ifelse(eval(level_caster_base >=  4),1, `spell_headline(bard, Bard, 2, CHA)', %)
ifelse(eval(level_caster_base >=  7),1, `spell_headline(bard, Bard, 3, CHA)', %)
ifelse(eval(level_caster_base >= 10),1, `spell_headline(bard, Bard, 4, CHA)', %)
ifelse(eval(level_caster_base >= 13),1, `spell_headline(bard, Bard, 5, CHA)', %)
ifelse(eval(level_caster_base >= 16),1, `spell_headline(bard, Bard, 6, CHA)', %)
ifelse(eval(level_caster_base >= 20  &&  ifdef(`feat_improved_spell_capacity',1,0)),1, `spells_above_max_level(bard, Bard, 7, CHA)', %)
%
\normalsize
')%
%
%
dnl ***** Sorcerer Spells
ifelse(eval(level_sorcerer > 0),1,`dnl
define(`level_caster_base', eval(level_sorcerer + adjust_CL_sorcerer))dnl adjustments possible e.g. by prestige classes
define(`type_caster', A)dnl arcane caster type
define(`token_caster', sorcerer)dnl
%
%\small
\footnotesize
%
ifelse(eval(level_caster_base >=  1),1, `spell_headline(sorcerer, Sorcerer, 0, CHA)', %)
ifelse(eval(level_caster_base >=  1),1, `spell_headline(sorcerer, Sorcerer, 1, CHA)', %)
ifelse(eval(level_caster_base >=  4),1, `spell_headline(sorcerer, Sorcerer, 2, CHA)', %)
ifelse(eval(level_caster_base >=  6),1, `spell_headline(sorcerer, Sorcerer, 3, CHA)', %)
ifelse(eval(level_caster_base >=  8),1, `spell_headline(sorcerer, Sorcerer, 4, CHA)', %)
ifelse(eval(level_caster_base >= 10),1, `spell_headline(sorcerer, Sorcerer, 5, CHA)', %)
ifelse(eval(level_caster_base >= 12),1, `spell_headline(sorcerer, Sorcerer, 6, CHA)', %)
ifelse(eval(level_caster_base >= 14),1, `spell_headline(sorcerer, Sorcerer, 7, CHA)', %)
ifelse(eval(level_caster_base >= 16),1, `spell_headline(sorcerer, Sorcerer, 8, CHA)', %)
ifelse(eval(level_caster_base >= 18),1, `spell_headline(sorcerer, Sorcerer, 9, CHA)', %)
ifelse(eval(level_caster_base >= 20  &&  ifdef(`feat_improved_spell_capacity',1,0)),1, `spells_above_max_level(sorcerer, Sorcerer, 10, CHA)', %)
%
\normalsize
')%
%
%
dnl ***** Wizard Spells
ifelse(eval(level_wizard > 0),1,`dnl
define(`level_caster_base', eval(level_wizard + adjust_CL_wizard))dnl adjustments possible e.g. by prestige classes
define(`type_caster', A)dnl arcane caster type
define(`token_caster', wizard)dnl
%
%\small
\footnotesize
%
ifelse(eval(level_caster_base >=  1),1, `spell_headline(wizard, Wizard, 0, INT)', %)
ifelse(eval(level_caster_base >=  1),1, `spell_headline(wizard, Wizard, 1, INT)', %)
ifelse(eval(level_caster_base >=  3),1, `spell_headline(wizard, Wizard, 2, INT)', %)
ifelse(eval(level_caster_base >=  5),1, `spell_headline(wizard, Wizard, 3, INT)', %)
ifelse(eval(level_caster_base >=  7),1, `spell_headline(wizard, Wizard, 4, INT)', %)
ifelse(eval(level_caster_base >=  9),1, `spell_headline(wizard, Wizard, 5, INT)', %)
ifelse(eval(level_caster_base >= 11),1, `spell_headline(wizard, Wizard, 6, INT)', %)
ifelse(eval(level_caster_base >= 13),1, `spell_headline(wizard, Wizard, 7, INT)', %)
ifelse(eval(level_caster_base >= 15),1, `spell_headline(wizard, Wizard, 8, INT)', %)
ifelse(eval(level_caster_base >= 17),1, `spell_headline(wizard, Wizard, 9, INT)', %)
ifelse(eval(level_caster_base >= 20  &&  ifdef(`feat_improved_spell_capacity',1,0)),1, `spells_above_max_level(wizard, Wizard, 10, INT)', %)
%
\normalsize
')%
%
%
dnl ***** Temple Raider of Olidammara Spells
ifelse(eval(level_templeraider > 0),1,`dnl
define(`level_caster_base', eval(level_templeraider + adjust_CL_templeraider))dnl adjustments possible e.g. by prestige classes
define(`type_caster', D)dnl devine caster type
define(`token_caster', templeraider)dnl
%
%\small
\footnotesize
%
ifelse(eval(level_caster_base >= 1),1, `spell_headline(templeraider, Temple Raider of Olidammara, 1, WIS)', %)
ifelse(eval(level_caster_base >= 3),1, `spell_headline(templeraider, Temple Raider of Olidammara, 2, WIS)', %)
ifelse(eval(level_caster_base >= 5),1, `spell_headline(templeraider, Temple Raider of Olidammara, 3, WIS)', %)
ifelse(eval(level_caster_base >= 7),1, `spell_headline(templeraider, Temple Raider of Olidammara, 4, WIS)', %)
ifelse(eval(level_caster_base >= 10  &&  ifdef(`feat_improved_spell_capacity',1,0)),1, `spells_above_max_level(templeraider, Temple Raider of Olidammara, 5, WIS)', %)
%
\normalsize
')%
%
%
dnl ***** Epic Spells for Cleric, Druid, Sorcerer and Wizard
ifelse(eval(ifdef(`feat_epic_spellcasting',1,0)  &&  (rank_spellcraft >= 24)),0, %,`dnl
define(`epic_spells_cleric',   ifelse(eval(level_cleric   + adjust_CL_cleric   < 17),1,0, eval(rank_knowledge_religion < 24),1,0, eval(rank_knowledge_religion / 10)))dnl calculate epic spells per day ...
define(`epic_spells_druid',    ifelse(eval(level_druid    + adjust_CL_druid    < 17),1,0, eval(rank_knowledge_nature   < 24),1,0, eval(rank_knowledge_nature   / 10)))dnl ... for those classes that gain ...
define(`epic_spells_sorcerer', ifelse(eval(level_sorcerer + adjust_CL_sorcerer < 18),1,0, eval(rank_knowledge_arcana   < 24),1,0, eval(rank_knowledge_arcana   / 10)))dnl ... spells of 9th level
define(`epic_spells_wizard',   ifelse(eval(level_wizard   + adjust_CL_wizard   < 17),1,0, eval(rank_knowledge_arcana   < 24),1,0, eval(rank_knowledge_arcana   / 10)))dnl
dnl
\footnotesize
\begin{boxedminipage}{\textwidth}
ifelse(eval(epic_spells_cleric   > 0),1, `\makebox[0.25\textwidth][l]{\textbf{Cleric   Epic Spells:}}\makebox[0.2\textwidth][l]{epic_spells_cleric   per day}\makebox[0.2\textwidth][l]{DC eval(20 + WIS)}`'ifelse(eval(epic_spells_druid + epic_spells_sorcerer + epic_spells_wizard > 0),1,\\)', %)
ifelse(eval(epic_spells_druid    > 0),1, `\makebox[0.25\textwidth][l]{\textbf{Druid    Epic Spells:}}\makebox[0.2\textwidth][l]{epic_spells_druid    per day}\makebox[0.2\textwidth][l]{DC eval(20 + WIS)}`'ifelse(eval(epic_spells_sorcerer + epic_spells_wizard > 0),1,\\)', %)
ifelse(eval(epic_spells_sorcerer > 0),1, `\makebox[0.25\textwidth][l]{\textbf{Sorcerer Epic Spells:}}\makebox[0.2\textwidth][l]{epic_spells_sorcerer per day}\makebox[0.2\textwidth][l]{DC eval(20 + CHA)} \hfill Spell Failure: arcane_error\%`'ifelse(eval(epic_spells_wizard > 0),1,\\)', %)
ifelse(eval(epic_spells_wizard   > 0),1, `\makebox[0.25\textwidth][l]{\textbf{Wizard   Epic Spells:}}\makebox[0.2\textwidth][l]{epic_spells_wizard   per day}\makebox[0.2\textwidth][l]{DC eval(20 + INT)} \hfill Spell Failure: arcane_error\%', %)
\end{boxedminipage}\\
spells_epic
\normalsize
')
