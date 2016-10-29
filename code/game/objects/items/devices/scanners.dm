/*
CONTAINS:
T-RAY
DETECTIVE SCANNER
HEALTH ANALYZER
GAS ANALYZER
MASS SPECTROMETER
REAGENT SCANNER
*/
#define OVERLAY_CACHE_LEN 50

/obj/item/device/t_scanner
	name = "\improper T-ray scanner"
	desc = "A terahertz-ray emitter and scanner used to detect underfloor objects such as cables and pipes."
	icon_state = "t-ray0"
	slot_flags = SLOT_BELT
	w_class = 2
	item_state = "electronic"
	matter = list(DEFAULT_WALL_MATERIAL = 150)
	origin_tech = list(TECH_MAGNET = 1, TECH_ENGINERING = 1)

	var/scan_range = 1

	var/on = 0
	var/list/active_scanned = list() //assoc list of objects being scanned, mapped to their overlay
	var/client/user_client //since making sure overlays are properly added and removed is pretty important, so we track the current user explicitly
	var/flicker = 0

	var/global/list/overlay_cache = list() //cache recent overlays

/obj/item/device/t_scanner/update_icon()
	icon_state = "t-ray[on]"

/obj/item/device/t_scanner/attack_self(mob/user)
	set_active(!on)

/obj/item/device/t_scanner/proc/set_active(var/active)
	on = active
	if(on)
		processing_objects.Add(src)
		flicker = 0
	else
		processing_objects.Remove(src)
		set_user_client(null)
	update_icon()

//If reset is set, then assume the client has none of our overlays, otherwise we only send new overlays.
/obj/item/device/t_scanner/process()
	if(!on) return

	//handle clients changing
	var/client/loc_client = null
	if(ismob(src.loc))
		var/mob/M = src.loc
		loc_client = M.client
	set_user_client(loc_client)

	//no sense processing if no-one is going to see it.
	if(!user_client) return

	//get all objects in scan range
	var/list/scanned = get_scanned_objects(scan_range)
	var/list/update_add = scanned - active_scanned
	var/list/update_remove = active_scanned - scanned

	//Add new overlays
	for(var/obj/O in update_add)
		var/image/overlay = get_overlay(O)
		active_scanned[O] = overlay
		user_client.images += overlay

	//Remove stale overlays
	for(var/obj/O in update_remove)
		user_client.images -= active_scanned[O]
		active_scanned -= O

	//Flicker effect
	for(var/obj/O in active_scanned)
		var/image/overlay = active_scanned[O]
		if(flicker)
			overlay.alpha = 0
		else
			overlay.alpha = 128
	flicker = !flicker

//creates a new overlay for a scanned object
/obj/item/device/t_scanner/proc/get_overlay(obj/scanned)
	//Use a cache so we don't create a whole bunch of new images just because someone's walking back and forth in a room.
	//Also means that images are reused if multiple people are using t-rays to look at the same objects.
	if(scanned in overlay_cache)
		. = overlay_cache[scanned]
	else
		var/image/I = image(loc = scanned, icon = scanned.icon, icon_state = scanned.icon_state, layer = HUD_LAYER)

		//Pipes are special
		if(istype(scanned, /obj/machinery/atmospherics/pipe))
			var/obj/machinery/atmospherics/pipe/P = scanned
			I.color = P.pipe_color
			I.overlays += P.overlays

		I.alpha = 128
		I.mouse_opacity = 0
		. = I

	// Add it to cache, cutting old entries if the list is too long
	overlay_cache[scanned] = .
	if(overlay_cache.len > OVERLAY_CACHE_LEN)
		overlay_cache.Cut(1, overlay_cache.len-OVERLAY_CACHE_LEN-1)

/obj/item/device/t_scanner/proc/get_scanned_objects(var/scan_dist)
	. = list()

	var/turf/center = get_turf(src.loc)
	if(!center) return

	for(var/turf/T in range(scan_range, center))
		if(!T.intact)
			continue

		for(var/obj/O in T.contents)
			if(O.level != 1)
				continue
			if(!O.invisibility)
				continue //if it's already visible don't need an overlay for it
			. += O

/obj/item/device/t_scanner/proc/set_user_client(var/client/new_client)
	if(new_client == user_client)
		return
	if(user_client)
		for(var/scanned in active_scanned)
			user_client.images -= active_scanned[scanned]
	if(new_client)
		for(var/scanned in active_scanned)
			new_client.images += active_scanned[scanned]
	else
		active_scanned.Cut()

	user_client = new_client

/obj/item/device/t_scanner/dropped(mob/user)
	set_user_client(null)

#undef OVERLAY_CACHE_LEN


/obj/item/device/healthanalyzer
	name = "health analyzer"
	desc = "A hand-held body scanner able to distinguish vital signs of the subject."
	icon_state = "health"
	item_state = "analyzer"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	throwforce = 3
	w_class = 2.0
	throw_speed = 5
	throw_range = 10
	matter = list(DEFAULT_WALL_MATERIAL = 200)
	origin_tech = "magnets=1;biotech=1"
	var/mode = 1;


/obj/item/device/healthanalyzer/attack(mob/living/M as mob, mob/living/user as mob)
	if (( (CLUMSY in user.mutations) || user.getBrainLoss() >= 60) && prob(50))
		user << text("\red You try to analyze the floor's vitals!")
		for(var/mob/O in viewers(M, null))
			O.show_message(text("\red [user] has analyzed the floor's vitals!"), 1)
		user.show_message(text("\blue Analyzing Results for The floor:\n\t Overall Status: Healthy"), 1)
		user.show_message(text("\blue \t Damage Specifics: [0]-[0]-[0]-[0]"), 1)
		user.show_message("\blue Key: Suffocation/Toxin/Burns/Brute", 1)
		user.show_message("\blue Body Temperature: ???", 1)
		return
	user.visible_message("<span class='notice'> [user] has analyzed [M]'s vitals.</span>","<span class='notice'> You have analyzed [M]'s vitals.</span>")

	if (!istype(M,/mob/living/carbon/human) || M.isSynthetic())
		//these sensors are designed for organic life
		user.show_message("\blue Analyzing Results for ERROR:\n\t Overall Status: ERROR")
		user.show_message("\t Key: <font color='blue'>Suffocation</font>/<font color='green'>Toxin</font>/<font color='#FFA500'>Burns</font>/<font color='red'>Brute</font>", 1)
		user.show_message("\t Damage Specifics: <font color='blue'>?</font> - <font color='green'>?</font> - <font color='#FFA500'>?</font> - <font color='red'>?</font>")
		user.show_message("\blue Body Temperature: [M.bodytemperature-T0C]&deg;C ([M.bodytemperature*1.8-459.67]&deg;F)", 1)
		user.show_message("\red <b>Warning: Blood Level ERROR: --% --cl.\blue Type: ERROR</b>")
		user.show_message("\blue Subject's pulse: <font color='red'>-- bpm.</font>")
		return

	var/fake_oxy = max(rand(1,40), M.getOxyLoss(), (300 - (M.getToxLoss() + M.getFireLoss() + M.getBruteLoss())))
	var/OX = M.getOxyLoss() > 50 	? 	"<b>[M.getOxyLoss()]</b>" 		: M.getOxyLoss()
	var/TX = M.getToxLoss() > 50 	? 	"<b>[M.getToxLoss()]</b>" 		: M.getToxLoss()
	var/BU = M.getFireLoss() > 50 	? 	"<b>[M.getFireLoss()]</b>" 		: M.getFireLoss()
	var/BR = M.getBruteLoss() > 50 	? 	"<b>[M.getBruteLoss()]</b>" 	: M.getBruteLoss()
	if(M.status_flags & FAKEDEATH)
		OX = fake_oxy > 50 			? 	"<b>[fake_oxy]</b>" 			: fake_oxy
		user.show_message("\blue Analyzing Results for [M]:\n\t Overall Status: dead")
	else
		user.show_message("\blue Analyzing Results for [M]:\n\t Overall Status: [M.stat > 1 ? "dead" : "[M.health - M.halloss]% healthy"]")
	user.show_message("\t Key: <font color='blue'>Suffocation</font>/<font color='green'>Toxin</font>/<font color='#FFA500'>Burns</font>/<font color='red'>Brute</font>", 1)
	user.show_message("\t Damage Specifics: <font color='blue'>[OX]</font> - <font color='green'>[TX]</font> - <font color='#FFA500'>[BU]</font> - <font color='red'>[BR]</font>")
	user.show_message("\blue Body Temperature: [M.bodytemperature-T0C]&deg;C ([M.bodytemperature*1.8-459.67]&deg;F)", 1)
	if(M.tod && (M.stat == DEAD || (M.status_flags & FAKEDEATH)))
		user.show_message("\blue Time of Death: [M.tod]")
	if(ishuman(M) && mode == 1)
		var/mob/living/carbon/human/H = M
		var/list/damaged = H.get_damaged_organs(1,1)
		user.show_message("\blue Localized Damage, Brute/Burn:",1)
		if(length(damaged)>0)
			for(var/obj/item/organ/external/org in damaged)
				user.show_message(text("\blue \t []: [][]\blue - []",	\
				"[capitalize(org.name)][org.status & ORGAN_ROBOT ? "(Cybernetic)" : ""]",	\
				(org.brute_dam > 0)	?	"\red [org.brute_dam]"							:0,		\
				(org.status & ORGAN_BLEEDING)?"\red <b>\[Bleeding\]</b>":"\t", 		\
				(org.burn_dam > 0)	?	"<font color='#FFA500'>[org.burn_dam]</font>"	:0),1)
		else
			user.show_message("\blue \t Limbs are OK.",1)

	OX = M.getOxyLoss() > 50 ? 	"<font color='blue'><b>Severe oxygen deprivation detected</b></font>" 		: 	"Subject bloodstream oxygen level normal"
	TX = M.getToxLoss() > 50 ? 	"<font color='green'><b>Dangerous amount of toxins detected</b></font>" 	: 	"Subject bloodstream toxin level minimal"
	BU = M.getFireLoss() > 50 ? 	"<font color='#FFA500'><b>Severe burn damage detected</b></font>" 			:	"Subject burn injury status O.K"
	BR = M.getBruteLoss() > 50 ? "<font color='red'><b>Severe anatomical damage detected</b></font>" 		: 	"Subject brute-force injury status O.K"
	if(M.status_flags & FAKEDEATH)
		OX = fake_oxy > 50 ? 		"\red Severe oxygen deprivation detected\blue" 	: 	"Subject bloodstream oxygen level normal"
	user.show_message("[OX] | [TX] | [BU] | [BR]")
	if(istype(M, /mob/living/carbon))
		var/mob/living/carbon/C = M
		if(C.reagents.total_volume)
			var/unknown = 0
			var/reagentdata[0]
			for(var/A in C.reagents.reagent_list)
				var/datum/reagent/R = A
				if(R.scannable)
					reagentdata["[R.id]"] = "\t \blue [round(C.reagents.get_reagent_amount(R.id), 1)]u [R.name]"
				else
					unknown++
			if(reagentdata.len)
				user.show_message("\blue Beneficial reagents detected in subject's blood:")
				for(var/d in reagentdata)
					user.show_message(reagentdata[d])
			if(unknown)
				user.show_message(text("\red Warning: Unknown substance[(unknown>1)?"s":""] detected in subject's blood."))
		if(C.ingested && C.ingested.total_volume)
			var/unknown = 0
			for(var/datum/reagent/R in C.ingested.reagent_list)
				if(R.scannable)
					user << "<span class='notice'>[R.name] found in subject's stomach.</span>"
				else
					++unknown
			if(unknown)
				user << "<span class='warning'>Non-medical reagent[(unknown > 1)?"s":""] found in subject's stomach.</span>"
		if(C.virus2.len)
			for (var/ID in C.virus2)
				if (ID in virusDB)
					var/datum/data/record/V = virusDB[ID]
					user.show_message(text("\red Warning: Pathogen [V.fields["name"]] detected in subject's blood. Known antigen : [V.fields["antigen"]]"))
//			user.show_message(text("\red Warning: Unknown pathogen detected in subject's blood."))
	if (M.getCloneLoss())
		user.show_message("\red Subject appears to have been imperfectly cloned.")
	for(var/datum/disease/D in M.viruses)
		if(!D.hidden[SCANNER])
			user.show_message(text("\red <b>Warning: [D.form] Detected</b>\nName: [D.name].\nType: [D.spread].\nStage: [D.stage]/[D.max_stages].\nPossible Cure: [D.cure]"))
//	if (M.reagents && M.reagents.get_reagent_amount("inaprovaline"))
//		user.show_message("\blue Bloodstream Analysis located [M.reagents:get_reagent_amount("inaprovaline")] units of rejuvenation chemicals.")
	if (M.has_brain_worms())
		user.show_message("\red Subject suffering from aberrant brain activity. Recommend further scanning.")
	else if (M.getBrainLoss() >= 100 || !M.has_brain())
		user.show_message("\red Subject is brain dead.")
	else if (M.getBrainLoss() >= 60)
		user.show_message("\red Severe brain damage detected. Subject likely to have mental retardation.")
	else if (M.getBrainLoss() >= 10)
		user.show_message("\red Significant brain damage detected. Subject may have had a concussion.")
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		for(var/name in H.organs_by_name)
			var/obj/item/organ/external/e = H.organs_by_name[name]
			if(!e)
				continue
			var/limb = e.name
			if(e.status & ORGAN_BROKEN)
				if(e.organ_tag in list(BP_L_ARM, BP_R_ARM, BP_L_LEG, BP_R_LEG) && !e.status&ORGAN_SPLINTED)
					user << "\red Unsecured fracture in subject [limb]. Splinting recommended for transport."
			if(e.has_infected_wound())
				user << "\red Infected wound detected in subject [limb]. Disinfection recommended."

		for(var/name in H.organs_by_name)
			var/obj/item/organ/external/e = H.organs_by_name[name]
			if(e && e.status & ORGAN_BROKEN)
				user.show_message(text("\red Bone fractures detected. Advanced scanner required for location."), 1)
				break
		for(var/obj/item/organ/external/e in H.organs)
			if(!e)
				continue
			for(var/datum/wound/W in e.wounds) if(W.internal)
				user.show_message(text("\red Internal bleeding detected. Advanced scanner required for location."), 1)
				break
		if(H.vessel)
			var/blood_volume = H.vessel.get_reagent_amount("blood")
			var/blood_percent =  round((blood_volume / H.species.blood_volume)*100)
			var/blood_type = H.dna.b_type
			switch(blood_percent)
				if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_SAFE)
					user.show_message("<span class='danger'>Warning: Blood Level LOW: [blood_percent]% [blood_volume]cl.</span> <span class='notice'>Type: [blood_type]</span>")
				if(-1 to BLOOD_VOLUME_BAD)
					user.show_message("<span class='danger'><i>Warning: Blood Level CRITICAL: [blood_percent]% [blood_volume]cl.</i></span> <span class='notice'>Type: [blood_type]</span>")
				else
					user.show_message("<span class='notice'>Blood Level Normal: [blood_percent]% [blood_volume]cl. Type: [blood_type]</span>")
		user.show_message("\blue Subject's pulse: <font color='[H.pulse == PULSE_THREADY || H.pulse == PULSE_NONE ? "red" : "blue"]'>[H.get_pulse(GETPULSE_TOOL)] bpm.</font>")
	src.add_fingerprint(user)
	return

/obj/item/device/healthanalyzer/verb/toggle_mode()
	set name = "Switch Verbosity"
	set category = "Object"

	mode = !mode
	switch (mode)
		if(1)
			usr << "The scanner now shows specific limb damage."
		if(0)
			usr << "The scanner no longer shows limb damage."


/obj/item/device/analyzer
	name = "analyzer"
	desc = "A hand-held environmental scanner which reports current gas levels."
	icon_state = "atmos"
	item_state = "analyzer"
	w_class = 2.0
	flags = CONDUCT
	slot_flags = SLOT_BELT
	throwforce = 5
	throw_speed = 4
	throw_range = 20

	matter = list(DEFAULT_WALL_MATERIAL = 30,"glass" = 20)

	origin_tech = "magnets=1;engineering=1"

/obj/item/device/analyzer/atmosanalyze(var/mob/user)
	var/air = user.return_air()
	if (!air)
		return

	return atmosanalyzer_scan(src, air, user)

/obj/item/device/analyzer/attack_self(mob/user as mob)

	if (user.stat)
		return
	if (!ishuman(usr))
		usr << "<span class='warning'>You don't have the dexterity to do this!</span>"
		return

	analyze_gases(src, user)
	return

/obj/item/device/mass_spectrometer
	name = "mass spectrometer"
	desc = "A hand-held mass spectrometer which identifies trace chemicals in a blood sample."
	icon_state = "spectrometer"
	item_state = "analyzer"
	w_class = 2.0
	flags = CONDUCT | OPENCONTAINER
	slot_flags = SLOT_BELT
	throwforce = 5
	throw_speed = 4
	throw_range = 20

	matter = list(DEFAULT_WALL_MATERIAL = 30,"glass" = 20)

	origin_tech = "magnets=2;biotech=2"
	var/details = 0
	var/recent_fail = 0

/obj/item/device/mass_spectrometer/New()
	..()
	var/datum/reagents/R = new/datum/reagents(5)
	reagents = R
	R.my_atom = src

/obj/item/device/mass_spectrometer/on_reagent_change()
	if(reagents.total_volume)
		icon_state = initial(icon_state) + "_s"
	else
		icon_state = initial(icon_state)

/obj/item/device/mass_spectrometer/attack_self(mob/user as mob)
	if (user.stat)
		return
	if (crit_fail)
		user << "\red This device has critically failed and is no longer functional!"
		return
	if(reagents.total_volume)
		var/list/blood_traces = list()
		for(var/datum/reagent/R in reagents.reagent_list)
			if(R.id != "blood")
				reagents.clear_reagents()
				user << "\red The sample was contaminated! Please insert another sample"
				return
			else
				blood_traces = params2list(R.data["trace_chem"])
				break
		var/dat = "Trace Chemicals Found: "
		for(var/R in blood_traces)
			if(prob(reliability))
				if(details)
					dat += "[R] ([blood_traces[R]] units) "
				else
					dat += "[R] "
				recent_fail = 0
			else
				if(recent_fail)
					crit_fail = 1
					reagents.clear_reagents()
					return
				else
					recent_fail = 1
		user << "[dat]"
		reagents.clear_reagents()
	return

/obj/item/device/mass_spectrometer/adv
	name = "advanced mass spectrometer"
	icon_state = "adv_spectrometer"
	details = 1
	origin_tech = "magnets=4;biotech=2"

/obj/item/device/reagent_scanner
	name = "reagent scanner"
	desc = "A hand-held reagent scanner which identifies chemical agents."
	icon_state = "spectrometer"
	item_state = "analyzer"
	w_class = 2.0
	flags = CONDUCT
	slot_flags = SLOT_BELT
	throwforce = 5
	throw_speed = 4
	throw_range = 20
	matter = list(DEFAULT_WALL_MATERIAL = 30,"glass" = 20)

	origin_tech = "magnets=2;biotech=2"
	var/details = 0
	var/recent_fail = 0

/obj/item/device/reagent_scanner/afterattack(obj/O, mob/user as mob, proximity)
	if(!proximity)
		return
	if (user.stat)
		return
	if(!istype(O))
		return
	if (crit_fail)
		user << "\red This device has critically failed and is no longer functional!"
		return

	if(!isnull(O.reagents))
		var/dat = ""
		if(O.reagents.reagent_list.len > 0)
			var/one_percent = O.reagents.total_volume / 100
			for (var/datum/reagent/R in O.reagents.reagent_list)
				if(prob(reliability))
					dat += "\n \t \blue [R][details ? ": [R.volume / one_percent]%" : ""]"
					recent_fail = 0
				else if(recent_fail)
					crit_fail = 1
					dat = null
					break
				else
					recent_fail = 1
		if(dat)
			user << "\blue Chemicals found: [dat]"
		else
			user << "\blue No active chemical agents found in [O]."
	else
		user << "\blue No significant chemical agents found in [O]."

	return

/obj/item/device/reagent_scanner/adv
	name = "advanced reagent scanner"
	icon_state = "adv_spectrometer"
	details = 1
	origin_tech = "magnets=4;biotech=2"

/obj/item/device/slime_scanner
	name = "slime scanner"
	icon_state = "adv_spectrometer"
	item_state = "analyzer"
	origin_tech = "biotech=1"
	w_class = 2.0
	flags = CONDUCT
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	matter = list(DEFAULT_WALL_MATERIAL = 30,"glass" = 20)

/obj/item/device/slime_scanner/attack(mob/living/M as mob, mob/living/user as mob)
	if (!isslime(M))
		user << "<B>This device can only scan slimes!</B>"
		return
	var/mob/living/carbon/slime/T = M
	user.show_message("Slime scan results:")
	user.show_message(text("[T.colour] [] slime", T.is_adult ? "adult" : "baby"))
	user.show_message(text("Nutrition: [T.nutrition]/[]", T.get_max_nutrition()))
	if (T.nutrition < T.get_starve_nutrition())
		user.show_message("<span class='alert'>Warning: slime is starving!</span>")
	else if (T.nutrition < T.get_hunger_nutrition())
		user.show_message("<span class='warning'>Warning: slime is hungry</span>")
	user.show_message("Electric change strength: [T.powerlevel]")
	user.show_message("Health: [T.health]")
	if (T.slime_mutation[4] == T.colour)
		user.show_message("This slime does not evolve any further")
	else
		if (T.slime_mutation[3] == T.slime_mutation[4])
			if (T.slime_mutation[2] == T.slime_mutation[1])
				user.show_message(text("Possible mutation: []", T.slime_mutation[3]))
				user.show_message("Genetic destability: [T.mutation_chance/2]% chance of mutation on splitting")
			else
				user.show_message(text("Possible mutations: [], [], [] (x2)", T.slime_mutation[1], T.slime_mutation[2], T.slime_mutation[3]))
				user.show_message("Genetic destability: [T.mutation_chance]% chance of mutation on splitting")
		else
			user.show_message(text("Possible mutations: [], [], [], []", T.slime_mutation[1], T.slime_mutation[2], T.slime_mutation[3], T.slime_mutation[4]))
			user.show_message("Genetic destability: [T.mutation_chance]% chance of mutation on splitting")
	if (T.cores > 1)
		user.show_message("Anomalious slime core amount detected")
	user.show_message("Growth progress: [T.amount_grown]/10")
