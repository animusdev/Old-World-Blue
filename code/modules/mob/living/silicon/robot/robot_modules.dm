var/mob/living/silicon/robot/global/list/robot_modules = list(
	"Standard"		= /obj/item/weapon/robot_module/standard,
	"Service" 		= /obj/item/weapon/robot_module/clerical/butler,
	"Clerical" 		= /obj/item/weapon/robot_module/clerical/general,
	"Research" 		= /obj/item/weapon/robot_module/research,
	"Miner" 		= /obj/item/weapon/robot_module/miner,
	"Medical" 		= /obj/item/weapon/robot_module/medical/crisis,
	"Surgeon" 		= /obj/item/weapon/robot_module/medical/surgeon,
	"Security" 		= /obj/item/weapon/robot_module/security/general,
	"Engineering"	= /obj/item/weapon/robot_module/engineering/general,
	"Janitor" 		= /obj/item/weapon/robot_module/janitor
)

// It's possible to override original modules with RedCode one.
var/mob/living/silicon/robot/global/list/redcode_robot_modules = list(
	"Combat" 		= /obj/item/weapon/robot_module/security/combat
)

/obj/item/weapon/robot_module
	name = "robot module"
	icon = 'icons/obj/module.dmi'
	icon_state = "std_module"
	w_class = 100.0
	item_state = "electronic"
	flags = CONDUCT
	var/channels = list()
	var/networks = list()
	var/languages = list(
		LANGUAGE_SOL_COMMON = 1,
		LANGUAGE_TRADEBAND = 1,
		LANGUAGE_UNATHI = 0,
		LANGUAGE_SIIK_TAJR = 0,
		LANGUAGE_SKRELLIAN = 0,
		LANGUAGE_GUTTER = 0,
		LANGUAGE_SIIK_MAAS = 0,
		LANGUAGE_SURZHYK = 0
	)
	var/list/emotes = list()
	var/module_type = "Standard"
	//var/sprites = list()
	var/can_be_pushed = 1
	var/no_slip = 0
	var/list/modules = list()
	var/list/datum/matter_synth/synths = list()
	var/obj/item/emag = null
	var/obj/item/borg/upgrade/jetpack = null
	var/list/subsystems = list()
	var/list/obj/item/borg/upgrade/supported_upgrades = list()

	// Bookkeeping
	var/list/original_languages = list()
	var/list/added_networks = list()

/obj/item/weapon/robot_module/New(var/mob/living/silicon/robot/R)
	..()
	R.module = src

	add_camera_networks(R)
	add_languages(R)
	add_subsystems(R)
	apply_status_flags(R)

	if(R.radio)
		R.radio.recalculateChannels()

	if(emotes.len)
		var/list/tmp_emotes = emotes.Copy()
		emotes.Cut()
		for(var/T in tmp_emotes)
			var/datum/emote/E = new T
			emotes[E.key] = E

/obj/item/weapon/robot_module/proc/Reset(var/mob/living/silicon/robot/R)
	R.module = null

	remove_camera_networks(R)
	remove_languages(R)
	remove_subsystems(R)
	remove_status_flags(R)

	if(R.radio)
		R.radio.recalculateChannels()

	qdel(src)

/obj/item/weapon/robot_module/Destroy()
	for(var/obj/O in modules)
		qdel(O)
	modules.Cut()
	for(var/datum/matter_synth/S in synths)
		qdel(S)
	synths.Cut()
	qdel(emag)
	qdel(jetpack)
	emag = null
	jetpack = null
	return ..()

/obj/item/weapon/robot_module/emp_act(severity)
	if(modules)
		for(var/obj/O in modules)
			O.emp_act(severity)
	if(emag)
		emag.emp_act(severity)
	if(synths)
		for(var/datum/matter_synth/S in synths)
			S.emp_act(severity)
	..()
	return

/obj/item/weapon/robot_module/proc/respawn_consumable(var/mob/living/silicon/robot/R, var/rate)
	var/obj/item/device/flash/F = locate() in src.modules
	if(F)
		if(F.broken)
			F.broken = 0
			F.times_used = 0
			F.icon_state = "flash"
		else if(F.times_used)
			F.times_used--

	if(!synths || !synths.len)
		return

	for(var/datum/matter_synth/T in synths)
		T.add_charge(T.recharge_rate * rate)

/obj/item/weapon/robot_module/proc/rebuild() //Rebuilds the list so it's possible to add/rem items from the module
	var/list/temp_list = modules
	modules = list()
	for(var/obj/O in temp_list)
		if(O)
			modules += O

/obj/item/weapon/robot_module/proc/add_languages(var/mob/living/silicon/robot/R)
	// Stores the languages as they were before receiving the module, and whether they could be synthezized.
	for(var/datum/language/language_datum in R.languages)
		original_languages[language_datum] = (language_datum in R.speech_synthesizer_langs)

	for(var/language in languages)
		R.add_language(language, languages[language])

/obj/item/weapon/robot_module/proc/remove_languages(var/mob/living/silicon/robot/R)
	// Clear all added languages, whether or not we originally had them.
	for(var/language in languages)
		R.remove_language(language)

	// Then add back all the original languages, and the relevant synthezising ability
	for(var/original_language in original_languages)
		R.add_language(original_language, original_languages[original_language])
	original_languages.Cut()

/obj/item/weapon/robot_module/proc/add_camera_networks(var/mob/living/silicon/robot/R)
	if(R.camera && (NETWORK_ROBOTS in R.camera.network))
		for(var/network in networks)
			if(!(network in R.camera.network))
				R.camera.add_network(network)
				added_networks |= network

/obj/item/weapon/robot_module/proc/remove_camera_networks(var/mob/living/silicon/robot/R)
	if(R.camera)
		R.camera.remove_networks(added_networks)
	added_networks.Cut()

/obj/item/weapon/robot_module/proc/add_subsystems(var/mob/living/silicon/robot/R)
	R.verbs |= subsystems

/obj/item/weapon/robot_module/proc/remove_subsystems(var/mob/living/silicon/robot/R)
	R.verbs -= subsystems

/obj/item/weapon/robot_module/proc/apply_status_flags(var/mob/living/silicon/robot/R)
	if(!can_be_pushed)
		R.status_flags &= ~CANPUSH

/obj/item/weapon/robot_module/proc/remove_status_flags(var/mob/living/silicon/robot/R)
	if(!can_be_pushed)
		R.status_flags |= CANPUSH

/obj/item/weapon/robot_module/standard
	name = "standard robot module"
	module_type = "Standard"

/obj/item/weapon/robot_module/standard/New()
	..()
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/weapon/melee/baton/loaded(src)
	src.modules += new /obj/item/weapon/extinguisher(src)
	src.modules += new /obj/item/weapon/wrench(src)
	src.modules += new /obj/item/weapon/crowbar(src)
	src.modules += new /obj/item/device/healthanalyzer(src)
	src.emag = new /obj/item/weapon/melee/energy/sword(src)
	return

/obj/item/weapon/robot_module/medical
	name = "medical robot module"
	channels = list("Medical" = 1)
	networks = list(NETWORK_MEDICAL)
	subsystems = list(/mob/living/silicon/proc/subsystem_crew_monitor)
	can_be_pushed = 0

/obj/item/weapon/robot_module/medical/surgeon
	name = "surgeon robot module"
	module_type = "Surgeon"

/obj/item/weapon/robot_module/medical/surgeon/New()
	..()
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/device/healthanalyzer(src)
	src.modules += new /obj/item/weapon/reagent_containers/borghypo/surgeon(src)
	src.modules += new /obj/item/weapon/scalpel/manager(src)
	src.modules += new /obj/item/weapon/inflatable_dispenser(src)
	src.modules += new /obj/item/weapon/hemostat(src)
	src.modules += new /obj/item/weapon/retractor(src)
	src.modules += new /obj/item/weapon/cautery(src)
	src.modules += new /obj/item/weapon/bonegel(src)
	src.modules += new /obj/item/roller_holder(src)
	src.modules += new /obj/item/weapon/FixOVein(src)
	src.modules += new /obj/item/weapon/bonesetter(src)
	src.modules += new /obj/item/weapon/circular_saw(src)
	src.modules += new /obj/item/weapon/surgicaldrill(src)
	src.modules += new /obj/item/weapon/extinguisher/mini(src)
	src.emag = new /obj/item/weapon/reagent_containers/spray(src)
	src.emag.reagents.add_reagent("pacid", 250)
	src.emag.name = "Polyacid spray"

	var/datum/matter_synth/medicine/medicine = new(10000)
	synths += medicine

	var/obj/item/stack/nanopaste/N = new(src)
	var/obj/item/stack/medical/bruise_pack/advanced/B = new(src)
	N.uses_charge = 1
	N.charge_costs = list(1000)
	N.synths = list(medicine)
	B.uses_charge = 1
	B.charge_costs = list(1000)
	B.synths = list(medicine)
	src.modules += N
	src.modules += B

	return

/obj/item/weapon/robot_module/medical/surgeon/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	if(src.emag)
		var/obj/item/weapon/reagent_containers/spray/PS = src.emag
		PS.reagents.add_reagent("pacid", 2 * amount)
	..()

/obj/item/weapon/robot_module/medical/crisis
	name = "medical robot module"
	module_type = "Medical"

/obj/item/weapon/robot_module/medical/crisis/New()
	..()
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/borg/sight/hud/med(src)
	src.modules += new /obj/item/weapon/inflatable_dispenser(src)
	src.modules += new /obj/item/device/healthanalyzer(src)
	src.modules += new /obj/item/device/reagent_scanner/adv(src)
	src.modules += new /obj/item/roller_holder(src)
	src.modules += new /obj/item/weapon/reagent_containers/borghypo/crisis(src)
	src.modules += new /obj/item/weapon/reagent_containers/glass/beaker/large(src)
	src.modules += new /obj/item/weapon/reagent_containers/dropper/industrial(src)
	src.modules += new /obj/item/weapon/reagent_containers/syringe(src)
	src.modules += new /obj/item/weapon/extinguisher/mini(src)
	src.modules += new /obj/item/weapon/crowbar(src)
	src.emag = new /obj/item/weapon/reagent_containers/spray(src)
	src.emag.reagents.add_reagent("pacid", 250)
	src.emag.name = "Polyacid spray"

	var/datum/matter_synth/medicine/medicine = new(15000)
	synths += medicine

	var/obj/item/stack/medical/ointment/O = new (src)
	src.modules += O
	O.uses_charge = 1
	O.charge_costs = list(1000)
	O.synths = list(medicine)
	var/obj/item/stack/medical/bruise_pack/B = new (src)
	src.modules += B
	B.uses_charge = 1
	B.charge_costs = list(1000)
	B.synths = list(medicine)
	var/obj/item/stack/medical/splint/S = new (src)
	src.modules += S
	S.uses_charge = 1
	S.charge_costs = list(1000)
	S.synths = list(medicine)

	return

/obj/item/weapon/robot_module/medical/crisis/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	var/obj/item/weapon/reagent_containers/syringe/S = locate() in src.modules
	if(S.mode == 2)
		S.reagents.clear_reagents()
		S.mode = initial(S.mode)
		S.desc = initial(S.desc)
		S.update_icon()

	if(src.emag)
		var/obj/item/weapon/reagent_containers/spray/PS = src.emag
		PS.reagents.add_reagent("pacid", 2 * amount)

	..()


/obj/item/weapon/robot_module/engineering
	name = "engineering robot module"
	channels = list("Engineering" = 1)
	networks = list(NETWORK_ENGINEERING)
	subsystems = list(/mob/living/silicon/proc/subsystem_power_monitor)
	module_type = "Engineering"

/obj/item/weapon/robot_module/engineering/general/New()
	..()
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/borg/sight/meson(src)
	src.modules += new /obj/item/weapon/extinguisher(src)
	src.modules += new /obj/item/weapon/weldingtool/largetank(src)
	src.modules += new /obj/item/weapon/screwdriver(src)
	src.modules += new /obj/item/weapon/wrench(src)
	src.modules += new /obj/item/weapon/inflatable_dispenser(src)
	src.modules += new /obj/item/weapon/crowbar(src)
	src.modules += new /obj/item/weapon/wirecutters(src)
	src.modules += new /obj/item/device/multitool(src)
	src.modules += new /obj/item/device/t_scanner(src)
	src.modules += new /obj/item/device/analyzer(src)
	src.modules += new /obj/item/taperoll/engineering(src)
	src.modules += new /obj/item/weapon/gripper(src)
	src.modules += new /obj/item/device/lightreplacer(src)
	src.modules += new /obj/item/device/pipe_painter(src)
	src.emag = new /obj/item/borg/stun(src)

	var/datum/matter_synth/metal/metal = new (60000)
	synths += metal
	var/datum/matter_synth/glass/glass = new (40000)
	synths += glass
	var/datum/matter_synth/plasteel/plasteel = new (30000)
	synths += plasteel
	var/datum/matter_synth/wire/wire = new()
	synths += wire


	var/obj/item/weapon/matter_decompiler/MD = new (src)
	MD.metal = metal
	MD.glass = glass
	src.modules += MD

	var/obj/item/stack/material/cyborg/steel/M = new (src)
	M.synths = list(metal)
	src.modules += M

	var/obj/item/stack/material/cyborg/glass/G = new (src)
	G.synths = list(glass)
	src.modules += G

	var/obj/item/stack/rods/cyborg/R = new (src)
	R.synths = list(metal)
	src.modules += R

	var/obj/item/stack/cable_coil/cyborg/C = new (src)
	C.synths = list(wire)
	src.modules += C

	var/obj/item/stack/tile/steel/cyborg/S = new (src)
	S.synths = list(metal)
	src.modules += S

	var/obj/item/stack/material/cyborg/glass/reinforced/RG = new (src)
	RG.synths = list(metal, glass)
	src.modules += RG

	var/obj/item/stack/material/cyborg/plasteel/P = new (src)
	P.synths = list(plasteel)
	src.modules += P

	return

/obj/item/weapon/robot_module/security
	name = "security robot module"
	channels = list("Security" = 1)
	emotes = list(/datum/emote/law, /datum/emote/halt)
	networks = list(NETWORK_SECURITY)
	subsystems = list(/mob/living/silicon/proc/subsystem_crew_monitor)
	can_be_pushed = 0
	supported_upgrades = list(/obj/item/borg/upgrade/tasercooler)
	module_type = "Security"

/obj/item/weapon/robot_module/security/general/New()
	..()
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/weapon/inflatable_dispenser(src)
	src.modules += new /obj/item/borg/sight/hud/sec(src)
	src.modules += new /obj/item/weapon/handcuffs/cyborg(src)
	src.modules += new /obj/item/weapon/melee/baton/robot(src)
	src.modules += new /obj/item/weapon/gun/energy/taser/mounted/cyborg(src)
	src.modules += new /obj/item/taperoll/police(src)
	src.modules += new /obj/item/weapon/crowbar(src)
	src.modules += new /obj/item/weapon/gun/energy/laser/mounted(src)
	src.emag = new /obj/item/weapon/gun/energy/pulse_rifle/mounted(src)
	return

/obj/item/weapon/robot_module/security/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	..()
	for(var/obj/item/weapon/gun/energy/E in src.modules)
		if(E.power_supply.charge < E.power_supply.maxcharge)
			E.power_supply.give(E.charge_cost * amount)
			E.update_icon()
		else
			E.charge_tick = 0

	var/obj/item/weapon/melee/baton/robot/B = locate() in src.modules
	if(B && B.bcell)
		B.bcell.give(amount)

/obj/item/weapon/robot_module/janitor
	name = "janitorial robot module"
	channels = list("Service" = 1)
	module_type = "Janitor"

/obj/item/weapon/robot_module/janitor/New()
	..()
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/weapon/soap/nanotrasen(src)
	src.modules += new /obj/item/weapon/storage/bag/trash(src)
	src.modules += new /obj/item/weapon/mop(src)
	src.modules += new /obj/item/device/lightreplacer(src)
	src.modules += new /obj/item/weapon/crowbar(src)
	src.modules += new /obj/item/weapon/extinguisher/mini(src)
	src.emag = new /obj/item/weapon/reagent_containers/spray(src)
	src.emag.reagents.add_reagent("lube", 250)
	src.emag.name = "Lube spray"
	return

/obj/item/weapon/robot_module/janitor/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	..()
	var/obj/item/device/lightreplacer/LR = locate() in src.modules
	LR.Charge(R, amount)
	if(src.emag)
		var/obj/item/weapon/reagent_containers/spray/S = src.emag
		S.reagents.add_reagent("lube", 2 * amount)

/obj/item/weapon/robot_module/clerical
	name = "service robot module"
	channels = list("Service" = 1)
	languages = list(
		LANGUAGE_SOL_COMMON	= 1,
		LANGUAGE_UNATHI		= 1,
		LANGUAGE_SIIK_MAAS	= 1,
		LANGUAGE_SIIK_TAJR	= 0,
		LANGUAGE_SKRELLIAN	= 1,
		LANGUAGE_ROOTSPEAK	= 1,
		LANGUAGE_TRADEBAND	= 1,
		LANGUAGE_GUTTER		= 1,
		LANGUAGE_SURZHYK	= 1
	)

/obj/item/weapon/robot_module/clerical/butler
	module_type = "Service"

/obj/item/weapon/robot_module/clerical/butler/New()
	..()
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/weapon/gripper/service(src)
	src.modules += new /obj/item/weapon/reagent_containers/glass/bucket(src)
	src.modules += new /obj/item/weapon/material/minihoe(src)
	src.modules += new /obj/item/weapon/material/hatchet(src)
	src.modules += new /obj/item/device/analyzer/plant_analyzer(src)
	src.modules += new /obj/item/weapon/storage/bag/plants(src)
	src.modules += new /obj/item/weapon/robot_harvester(src)

	var/obj/item/weapon/rsf/M = new /obj/item/weapon/rsf(src)
	M.stored_matter = 30
	src.modules += M

	src.modules += new /obj/item/weapon/reagent_containers/dropper/industrial(src)

	var/obj/item/weapon/flame/lighter/zippo/L = new /obj/item/weapon/flame/lighter/zippo(src)
	L.lit = 1
	src.modules += L

	src.modules += new /obj/item/weapon/tray/robotray(src)
	src.modules += new /obj/item/weapon/reagent_containers/borghypo/service(src)
	src.modules += new /obj/item/weapon/crowbar(src)
	src.modules += new /obj/item/weapon/extinguisher/mini(src)
	src.emag = new /obj/item/weapon/reagent_containers/glass/drinks/cans/beer(src)

	var/datum/reagents/R = new/datum/reagents(50)
	src.emag.reagents = R
	R.my_atom = src.emag
	R.add_reagent("beer2", 50)
	src.emag.name = "Mickey Finn's Special Brew"
	return

/obj/item/weapon/robot_module/clerical/general
	name = "clerical robot module"
	module_type = "Clerical"

/obj/item/weapon/robot_module/clerical/general/New()
	..()
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/weapon/pen/robopen(src)
	src.modules += new /obj/item/weapon/form_printer(src)
	src.modules += new /obj/item/weapon/gripper/paperwork(src)
	src.modules += new /obj/item/weapon/hand_labeler(src)
	src.modules += new /obj/item/weapon/crowbar(src)
	src.modules += new /obj/item/weapon/extinguisher/mini(src)
	src.emag = new /obj/item/weapon/stamp/denied(src)

/obj/item/weapon/robot_module/general/butler/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	..()
	var/obj/item/weapon/reagent_containers/food/condiment/enzyme/E = locate() in src.modules
	E.reagents.add_reagent("enzyme", 2 * amount)
	if(src.emag)
		var/obj/item/weapon/reagent_containers/glass/drinks/cans/beer/B = src.emag
		B.reagents.add_reagent("beer2", 2 * amount)

/obj/item/weapon/robot_module/miner
	name = "miner robot module"
	channels = list("Supply" = 1)
	networks = list(NETWORK_MINE)
	module_type = "Miner"
	supported_upgrades = list(/obj/item/borg/upgrade/jetpack)

/obj/item/weapon/robot_module/miner/New()
	..()
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/borg/sight/meson(src)
	src.modules += new /obj/item/weapon/inflatable_dispenser(src)
	src.modules += new /obj/item/weapon/wrench(src)
	src.modules += new /obj/item/weapon/screwdriver(src)
	src.modules += new /obj/item/weapon/storage/bag/ore(src)
	src.modules += new /obj/item/weapon/extinguisher(src)
	src.modules += new /obj/item/weapon/pickaxe/borgdrill(src)
	src.modules += new /obj/item/weapon/storage/bag/sheetsnatcher/borg(src)
	src.modules += new /obj/item/weapon/gripper/miner(src)
	src.modules += new /obj/item/weapon/mining_scanner(src)
	src.modules += new /obj/item/weapon/crowbar(src)
	src.emag = new /obj/item/weapon/pickaxe/plasmacutter(src)
	return

/obj/item/weapon/robot_module/research
	name = "research module"
	channels = list("Science" = 1)
	module_type = "Research"

/obj/item/weapon/robot_module/research/New()
	..()
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/weapon/weldingtool(src)
	src.modules += new /obj/item/weapon/wirecutters(src)
	src.modules += new /obj/item/weapon/portable_destructive_analyzer(src)
	src.modules += new /obj/item/weapon/gripper/research(src)
	src.modules += new /obj/item/weapon/inflatable_dispenser(src)
	src.modules += new /obj/item/weapon/gripper/no_use/loader(src)
	src.modules += new /obj/item/device/robotanalyzer(src)
	src.modules += new /obj/item/weapon/card/robot(src)
	src.modules += new /obj/item/weapon/wrench(src)
	src.modules += new /obj/item/weapon/screwdriver(src)
	src.modules += new /obj/item/weapon/crowbar(src)
	src.modules += new /obj/item/weapon/scalpel(src)
	src.modules += new /obj/item/weapon/circular_saw(src)
	src.modules += new /obj/item/weapon/extinguisher(src)
	src.modules += new /obj/item/weapon/reagent_containers/syringe(src)
	src.modules += new /obj/item/weapon/reagent_containers/glass/beaker/large(src)
	src.modules += new /obj/item/weapon/hand_tele(src)
	src.emag = new /obj/item/weapon/card/emag (src)

	var/datum/matter_synth/nanite/nanite = new(10000)
	synths += nanite

	var/obj/item/stack/nanopaste/N = new(src)
	N.uses_charge = 1
	N.charge_costs = list(1000)
	N.synths = list(nanite)
	src.modules += N

	return

/obj/item/weapon/robot_module/syndicate
	name = "illegal robot module"
	module_type = "Synicate"
	languages = list(
		LANGUAGE_SOL_COMMON = 1,
		LANGUAGE_TRADEBAND = 1,
		LANGUAGE_UNATHI = 0,
		LANGUAGE_SIIK_TAJR = 0,
		LANGUAGE_SKRELLIAN = 0,
		LANGUAGE_GUTTER = 1
	)

/obj/item/weapon/robot_module/syndicate/New(var/mob/living/silicon/robot/R)
	..()
	loc = R
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/weapon/melee/energy/sword(src)
	src.modules += new /obj/item/weapon/gun/energy/pulse_rifle/destroyer(src)
	src.modules += new /obj/item/weapon/card/emag(src)
	src.modules += new /obj/item/weapon/crowbar(src)
	var/jetpack = new /obj/item/weapon/tank/jetpack/carbondioxide(src)
	src.modules += jetpack
	R.internals = jetpack
	return

/obj/item/weapon/robot_module/security/combat
	name = "combat robot module"
	module_type = "Combat"

/obj/item/weapon/robot_module/security/combat/New()
	..()
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/borg/sight/thermal(src)
	src.modules += new /obj/item/weapon/gun/energy/laser/mounted(src)
	src.modules += new /obj/item/weapon/pickaxe/plasmacutter(src)
	src.modules += new /obj/item/borg/combat/shield(src)
	src.modules += new /obj/item/borg/combat/mobility(src)
	src.modules += new /obj/item/weapon/crowbar(src)
	src.emag = new /obj/item/weapon/gun/energy/lasercannon/mounted(src)
	return

/obj/item/weapon/robot_module/drone
	name = "drone module"
	no_slip = 1
	networks = list(NETWORK_ENGINEERING)
	channels = list("Engineering" = 1)

/obj/item/weapon/robot_module/drone/New()
	..()
	src.modules += new /obj/item/weapon/weldingtool(src)
	src.modules += new /obj/item/weapon/screwdriver(src)
	src.modules += new /obj/item/weapon/wrench(src)
	src.modules += new /obj/item/weapon/crowbar(src)
	src.modules += new /obj/item/weapon/wirecutters(src)
	src.modules += new /obj/item/device/multitool(src)
	src.modules += new /obj/item/device/lightreplacer(src)
	src.modules += new /obj/item/weapon/gripper(src)
	src.modules += new /obj/item/weapon/soap(src)
	src.modules += new /obj/item/device/t_scanner(src)
	src.modules += new /obj/item/weapon/rpd/borg(src)
	src.modules += new /obj/item/device/analyzer(src)
	src.modules += new /obj/item/weapon/gripper/no_use/loader(src)
	src.emag = new /obj/item/weapon/pickaxe/plasmacutter(src)
	src.emag.name = "Plasma Cutter"

	var/datum/matter_synth/metal/metal = new (25000)
	var/datum/matter_synth/glass/glass = new (25000)
	var/datum/matter_synth/wood/wood = new (2000)
	var/datum/matter_synth/plastic/plastic = new (1000)
	var/datum/matter_synth/wire/wire = new (30)
	synths += metal
	synths += glass
	synths += wood
	synths += plastic
	synths += wire

	var/obj/item/weapon/matter_decompiler/MD = new (src)
	MD.metal = metal
	MD.glass = glass
	MD.wood = wood
	MD.plastic = plastic
	src.modules += MD

	var/obj/item/stack/material/cyborg/steel/M = new (src)
	M.synths = list(metal)
	src.modules += M

	var/obj/item/stack/material/cyborg/glass/G = new (src)
	G.synths = list(glass)
	src.modules += G

	var/obj/item/stack/rods/cyborg/R = new (src)
	R.synths = list(metal)
	src.modules += R

	var/obj/item/stack/cable_coil/cyborg/C = new (src)
	C.synths = list(wire)
	src.modules += C

	var/obj/item/stack/tile/steel/cyborg/S = new (src)
	S.synths = list(metal)
	src.modules += S

	var/obj/item/stack/material/cyborg/glass/reinforced/RG = new (src)
	RG.synths = list(metal, glass)
	src.modules += RG

	var/obj/item/stack/tile/wood/cyborg/WT = new (src)
	WT.synths = list(wood)
	src.modules += WT

	var/obj/item/stack/material/cyborg/wood/W = new (src)
	W.synths = list(wood)
	src.modules += W

	var/obj/item/stack/material/cyborg/plastic/P = new (src)
	P.synths = list(plastic)
	src.modules += P

/obj/item/weapon/robot_module/drone/construction
	name = "construction drone module"
	//channels = list("Engineering" = 1)
	languages = list()

/obj/item/weapon/robot_module/drone/construction/New()
	..()
	src.modules += new /obj/item/weapon/rcd/borg(src)

/obj/item/weapon/robot_module/drone/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	var/obj/item/device/lightreplacer/LR = locate() in src.modules
	LR.Charge(R, amount)
	..()
	return
