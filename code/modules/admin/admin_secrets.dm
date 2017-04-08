var/datum/admin_secrets/admin_secrets = new()

/datum/admin_secrets
	var/list/datum/admin_secret_category/categories
	var/list/datum/admin_secret_item/items

/datum/admin_secrets/New()
	..()
	categories = init_subtypes(/datum/admin_secret_category)
	items = list()
	var/list/category_assoc = list()
	for(var/datum/admin_secret_category/category in categories)
		category_assoc[category.type] = category

	for(var/item_type in (typesof(/datum/admin_secret_item) - /datum/admin_secret_item))
		var/datum/admin_secret_item/secret_item = item_type
		if(!initial(secret_item.name))
			continue

		var/datum/admin_secret_item/item = new item_type()
		var/datum/admin_secret_category/category = category_assoc[item.category]
		dd_insertObjectList(category.items, item)
		items += item

/datum/admin_secret_category
	var/name = ""
	var/desc = ""
	var/list/datum/admin_secret_item/items

/datum/admin_secret_category
	..()
	items = list()

/datum/admin_secret_category/proc/can_view(var/mob/user)
	for(var/datum/admin_secret_item/item in items)
		if(item.can_execute(user))
			return 1
	return 0

/datum/admin_secret_item
	var/name = ""
	var/category = null
	var/log = 1
	var/permissions = R_HOST

/datum/admin_secret_item/proc/name()
	return name

/datum/admin_secret_item/proc/can_execute(var/mob/user)
	return check_rights(permissions, 0, user)

/datum/admin_secret_item/proc/execute(var/mob/user)
	if(!can_execute(user))
		return 0

	if(log)
		log_admin("[key_name(user)] used [name]", user)


	return 1

/*************************
* Pre-defined categories *
*************************/
/datum/admin_secret_category/admin_secrets
	name = "Admin Secrets"

/datum/admin_secret_category/random_events
	name = "'Random' Events"

/datum/admin_secret_category/fun_secrets
	name = "Fun Secrets"

/datum/admin_secret_category/final_solutions
	name = "Final Solutions"

/*************************
* Pre-defined base items *
*************************/
/datum/admin_secret_item/admin_secret
	category = /datum/admin_secret_category/admin_secrets
	log = 0
	permissions = R_ADMIN

/datum/admin_secret_item/random_event
	category = /datum/admin_secret_category/random_events
	permissions = R_FUN

/datum/admin_secret_item/fun_secret
	category = /datum/admin_secret_category/fun_secrets
	permissions = R_FUN

/datum/admin_secret_item/final_solution
	category = /datum/admin_secret_category/final_solutions
	permissions = R_FUN|R_SERVER|R_ADMIN

/*****************************************************************************************************
* ************************************************************************************************** *
*****************************************************************************************************/


/**********
* Gravity *
**********/
/datum/admin_secret_item/random_event/gravity
	name = "Toggle station artificial gravity"

/datum/admin_secret_item/random_event/gravity/execute(var/mob/user)
	. = ..()
	if(!.)
		return

	if(!(ticker && ticker.mode))
		user << "Please wait until the game starts!  Not sure how it will work otherwise."
		return

	gravity_is_on = !gravity_is_on
	for(var/area/A in world)
		A.gravitychange(gravity_is_on,A)

	if(gravity_is_on)
		log_admin("[key_name(usr)] toggled gravity on.")
		command_announcement.Announce("Gravity generators are again functioning within normal parameters. Sorry for any inconvenience.")
	else
		log_admin("[key_name(usr)] toggled gravity off.")
		command_announcement.Announce("Feedback surge detected in mass-distributions systems. Artificial gravity has been disabled whilst the system reinitializes. Further failures may result in a gravitational collapse and formation of blackholes. Have a nice day.")



///BOMBING LIST///
/datum/admin_secret_item/admin_secret/bombing_list
	name = "Bombing List"

/datum/admin_secret_item/admin_secret/bombing_list/execute(var/mob/user)
	. = ..()
	if(!.)
		return

	var/dat = "<B>Bombing List<HR>"
	for(var/l in bombers)
		dat += text("[l]<BR>")
	user << browse(dat, "window=bombers")


///DNA///

/datum/admin_secret_item/admin_secret/list_dna
	name = "List DNA (Blood)"

/datum/admin_secret_item/admin_secret/list_dna/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	var/dat = "<B>Showing DNA from blood.</B><HR>"
	dat += "<table cellspacing=5><tr><th>Name</th><th>DNA</th><th>Blood Type</th></tr>"
	for(var/mob/living/carbon/human/H in mob_list)
		if(H.dna && H.ckey)
			dat += "<tr><td>[H]</td><td>[H.dna.unique_enzymes]</td><td>[H.b_type]</td></tr>"
	dat += "</table>"
	user << browse(dat, "window=DNA;size=440x410")


///FINGER///
/datum/admin_secret_item/admin_secret/list_fingerprints
	name = "List Fingerprints"

/datum/admin_secret_item/admin_secret/list_fingerprints/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	var/dat = "<B>Showing Fingerprints.</B><HR>"
	dat += "<table cellspacing=5><tr><th>Name</th><th>Fingerprints</th></tr>"
	for(var/mob/living/carbon/human/H in mob_list)
		if(H.ckey)
			if(H.dna && H.dna.uni_identity)
				dat += "<tr><td>[H]</td><td>[md5(H.dna.uni_identity)]</td></tr>"
			else if(H.dna && !H.dna.uni_identity)
				dat += "<tr><td>[H]</td><td>H.dna.uni_identity = null</td></tr>"
			else if(!H.dna)
				dat += "<tr><td>[H]</td><td>H.dna = null</td></tr>"
	dat += "</table>"
	usr << browse(dat, "window=fingerprints;size=440x410")



///LAWS///

/datum/admin_secret_item/admin_secret/show_ai_laws
	name = "Show AI laws"

/datum/admin_secret_item/admin_secret/show_ai_laws/execute(var/mob/user)
	. = ..()
	if(.)
		user.client.holder.output_ai_laws()


///CREW///

/datum/admin_secret_item/admin_secret/show_crew_manifest
	name = "Show Crew Manifest"

/datum/admin_secret_item/admin_secret/show_crew_manifest/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	var/dat
	dat += "<h4>Crew Manifest</h4>"
	dat += data_core.get_manifest()

	user << browse(dat, "window=manifest;size=370x420;can_close=1")


///GAME MODE///

/datum/admin_secret_item/admin_secret/show_game_mode
	name = "Show Game Mode"

/datum/admin_secret_item/admin_secret/show_game_mode/can_execute(var/mob/user)
	if(!ticker)
		return 0
	return ..()

/datum/admin_secret_item/admin_secret/show_game_mode/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	if (ticker.mode) alert("The game mode is [ticker.mode.name]")
	else alert("For some reason there's a ticker, but not a game mode")


///LAW CHANGES///
/datum/admin_secret_item/admin_secret/show_law_changes
	name = "Show law changes"

/datum/admin_secret_item/admin_secret/show_law_changes/name()
	return "Show last [length(lawchanges)] law changes"

/datum/admin_secret_item/admin_secret/show_law_changes/execute(var/mob/user)
	. = ..()
	if(!.)
		return

	var/dat = "<B>Showing last [length(lawchanges)] law changes.</B><HR>"
	for(var/sig in lawchanges)
		dat += "[sig]<BR>"
	user << browse(dat, "window=lawchanges;size=800x500")



///SIGNALERS///


/datum/admin_secret_item/admin_secret/show_signalers
	name = "Show last signalers"

/datum/admin_secret_item/admin_secret/show_signalers/name()
	return "Show last [length(lastsignalers)] signalers"

/datum/admin_secret_item/admin_secret/show_signalers/execute(var/mob/user)
	. = ..()
	if(!.)
		return

	var/dat = "<B>Showing last [length(lastsignalers)] signalers.</B><HR>"
	for(var/sig in lastsignalers)
		dat += "[sig]<BR>"
	user << browse(dat, "window=lastsignalers;size=800x500")



///TRAITOR LIST///

/datum/admin_secret_item/admin_secret/traitors_and_objectives
	name = "Show current traitors and objectives"

/datum/admin_secret_item/admin_secret/traitors_and_objectives/execute(var/mob/user)
	. = ..()
	if(.)
		user.client.holder.check_antagonists()


/datum/admin_secret_item/admin_secret/alter_narise
	name = "Alter Nar-Sie"

/datum/admin_secret_item/admin_secret/alter_narise/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	var/choice = input(user, "How do you wish for Nar-Sie to interact with its surroundings?") as null|anything in list("CultStation13", "Nar-Singulo")
	if(choice == "CultStation13")
		log_and_message_admins("has set narsie's behaviour to \"CultStation13\".", user)
		narsie_behaviour = choice
	if(choice == "Nar-Singulo")
		log_and_message_admins("has set narsie's behaviour to \"Nar-Singulo\".", user)
		narsie_behaviour = choice




/datum/admin_secret_item/admin_secret/jump_shuttle
	name = "Jump a Shuttle"

/datum/admin_secret_item/admin_secret/jump_shuttle/can_execute(var/mob/user)
	if(!shuttle_controller) return 0
	return ..()

/datum/admin_secret_item/admin_secret/jump_shuttle/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	var/shuttle_tag = input(user, "Which shuttle do you want to jump?") as null|anything in shuttle_controller.shuttles
	if (!shuttle_tag) return

	var/datum/shuttle/S = shuttle_controller.shuttles[shuttle_tag]

	var/origin_area = input(user, "Which area is the shuttle at now? (MAKE SURE THIS IS CORRECT OR THINGS WILL BREAK)") as null|area in world
	if (!origin_area) return

	var/destination_area = input(user, "Which area is the shuttle at now? (MAKE SURE THIS IS CORRECT OR THINGS WILL BREAK)") as null|area in world
	if (!destination_area) return

	var/long_jump = alert(user, "Is there a transition area for this jump?","", "Yes", "No")
	if (long_jump == "Yes")
		var/transition_area = input(user, "Which area is the transition area? (MAKE SURE THIS IS CORRECT OR THINGS WILL BREAK)") as null|area in world
		if (!transition_area) return

		var/move_duration = input(user, "How many seconds will this jump take?") as num

		S.long_jump(origin_area, destination_area, transition_area, move_duration)
		log_admin("[key_name_admin(user)] has initiated a jump from [origin_area] to [destination_area] lasting [move_duration] seconds for the [shuttle_tag] shuttle")
	else
		S.short_jump(origin_area, destination_area)
		log_admin("[key_name_admin(user)] has initiated a jump from [origin_area] to [destination_area] for the [shuttle_tag] shuttle")



/datum/admin_secret_item/admin_secret/launch_shuttle
	name = "Launch a Shuttle"

/datum/admin_secret_item/admin_secret/launch_shuttle/can_execute(var/mob/user)
	if(!shuttle_controller) return 0
	return ..()

/datum/admin_secret_item/admin_secret/launch_shuttle/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	var/list/valid_shuttles = list()
	for (var/shuttle_tag in shuttle_controller.shuttles)
		if (istype(shuttle_controller.shuttles[shuttle_tag], /datum/shuttle/ferry))
			valid_shuttles += shuttle_tag

	var/shuttle_tag = input("Which shuttle do you want to launch?") as null|anything in valid_shuttles
	if (!shuttle_tag)
		return

	var/datum/shuttle/ferry/S = shuttle_controller.shuttles[shuttle_tag]
	if (S.can_launch())
		S.launch(usr)
		log_and_message_admins("launched the [shuttle_tag] shuttle", user)
	else
		alert("The [shuttle_tag] shuttle cannot be launched at this time. It's probably busy.")



/datum/admin_secret_item/admin_secret/launch_shuttle_forced
	name = "Launch a Shuttle (Forced)"

/datum/admin_secret_item/admin_secret/launch_shuttle_forced/can_execute(var/mob/user)
	if(!shuttle_controller) return 0
	return ..()

/datum/admin_secret_item/admin_secret/launch_shuttle_forced/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	var/list/valid_shuttles = list()
	for (var/shuttle_tag in shuttle_controller.shuttles)
		if (istype(shuttle_controller.shuttles[shuttle_tag], /datum/shuttle/ferry))
			valid_shuttles += shuttle_tag

	var/shuttle_tag = input("Which shuttle's launch do you want to force?") as null|anything in valid_shuttles
	if (!shuttle_tag)
		return

	var/datum/shuttle/ferry/S = shuttle_controller.shuttles[shuttle_tag]
	if (S.can_force())
		S.force_launch(usr)
		log_and_message_admins("forced the [shuttle_tag] shuttle", user)
	else
		alert("The [shuttle_tag] shuttle launch cannot be forced at this time. It's busy, or hasn't been launched yet.")




/datum/admin_secret_item/admin_secret/move_shuttle
	name = "Move a Shuttle"

/datum/admin_secret_item/admin_secret/move_shuttle/can_execute(var/mob/user)
	if(!shuttle_controller) return 0
	return ..()

/datum/admin_secret_item/admin_secret/move_shuttle/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	var/confirm = alert("This command directly moves a shuttle from one area to another. DO NOT USE THIS UNLESS YOU ARE DEBUGGING A SHUTTLE AND YOU KNOW WHAT YOU ARE DOING.", "Are you sure?", "Ok", "Cancel")
	if (confirm == "Cancel")
		return

	var/shuttle_tag = input("Which shuttle do you want to jump?") as null|anything in shuttle_controller.shuttles
	if (!shuttle_tag) return

	var/datum/shuttle/S = shuttle_controller.shuttles[shuttle_tag]

	var/origin_area = input("Which area is the shuttle at now? (MAKE SURE THIS IS CORRECT OR THINGS WILL BREAK)") as null|area in world
	if (!origin_area) return

	var/destination_area = input("Which area is the shuttle at now? (MAKE SURE THIS IS CORRECT OR THINGS WILL BREAK)") as null|area in world
	if (!destination_area) return

	S.move(origin_area, destination_area)
	log_and_message_admins("[key_name_admin(usr)] moved the [shuttle_tag] shuttle", user)


/datum/admin_secret_item/admin_secret/prison_warp
	name = "Prison Warp"

/datum/admin_secret_item/admin_secret/prison_warp/can_execute(var/mob/user)
	if(!ticker) return 0
	return ..()

/datum/admin_secret_item/admin_secret/prison_warp/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	for(var/mob/living/carbon/human/H in mob_list)
		var/security = 0
		if(isOnAdminLevel(H) || prisonwarped.Find(H))
		//don't warp them if they aren't ready or are already there
			continue
		H.Paralyse(5)
		if(H.wear_id)
			var/obj/item/weapon/card/id/id = H.get_idcard()
			for(var/A in id.access)
				if(A == access_security)
					security++
		if(!security)
			//strip their stuff before they teleport into a cell :downs:
			for(var/obj/item/weapon/W in H)
				if(istype(W, /obj/item/organ/external))
					continue
					//don't strip organs
				H.drop_from_inventory(W)
			//teleport person to cell
			H.loc = pick(prisonwarp)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/color/orange(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/orange(H), slot_shoes)
		else
			//teleport security person
			H.loc = pick(prisonsecuritywarp)
		prisonwarped += H


/datum/admin_secret_item/fun_secret/break_all_lights
	name = "Break All Lights"

/datum/admin_secret_item/fun_secret/break_all_lights/execute(var/mob/user)
	. = ..()
	if(.)
		lightsout(0,0)


/datum/admin_secret_item/fun_secret/break_some_lights
	name = "Break Some Lights"

/datum/admin_secret_item/fun_secret/break_some_lights/execute(var/mob/user)
	. = ..()
	if(.)
		lightsout(1,2)


/datum/admin_secret_item/fun_secret/fix_all_lights
	name = "Fix All Lights"

/datum/admin_secret_item/fun_secret/fix_all_lights/execute(var/mob/user)
	. = ..()
	if(!.)
		return

	for(var/obj/machinery/light/L in world)
		L.fix()


/datum/admin_secret_item/fun_secret/make_all_areas_powered
	name = "Make All Areas Powered"

/datum/admin_secret_item/fun_secret/make_all_areas_powered/execute(var/mob/user)
	. = ..()
	if(.)
		power_restore()



/datum/admin_secret_item/fun_secret/make_all_areas_unpowered
	name = "Make All Areas Unpowered"

/datum/admin_secret_item/fun_secret/make_all_areas_unpowered/execute(var/mob/user)
	. = ..()
	if(.)
		power_failure()


/datum/admin_secret_item/fun_secret/only_one
	name = "There Can Be Only One"

/datum/admin_secret_item/fun_secret/only_one/execute(var/mob/user)
	. = ..()
	if(.)
		only_one()



/datum/admin_secret_item/fun_secret/power_all_smes
	name = "Power All SMES"

/datum/admin_secret_item/fun_secret/power_all_smes/execute(var/mob/user)
	. = ..()
	if(.)
		power_restore_quick()


/datum/admin_secret_item/fun_secret/remove_all_clothing
	name = "Remove ALL Clothing"

/datum/admin_secret_item/fun_secret/remove_all_clothing/execute(var/mob/user)
	. = ..()
	if(!.)
		return

	for(var/obj/item/clothing/O in world)
		qdel(O)

/datum/admin_secret_item/fun_secret/send_strike_team
	name = "Send Strike Team"

/datum/admin_secret_item/fun_secret/send_strike_team/can_execute(var/mob/user)
	if(!ticker) return 0
	return ..()

/datum/admin_secret_item/fun_secret/send_strike_team/execute(var/mob/user)
	. = ..()
	if(.)
		return user.client.strike_team()


/datum/admin_secret_item/fun_secret/toggle_bomb_cap
	name = "Toggle Bomb Cap"
	permissions = R_SERVER

/datum/admin_secret_item/fun_secret/toggle_bomb_cap/execute(var/mob/user)
	. = ..()
	if(!.)
		return

	switch(max_explosion_range)
		if(14)	max_explosion_range = 16
		if(16)	max_explosion_range = 20
		if(20)	max_explosion_range = 28
		if(28)	max_explosion_range = 56
		if(56)	max_explosion_range = 128
		if(128)	max_explosion_range = 14
	var/range_dev = max_explosion_range *0.25
	var/range_high = max_explosion_range *0.5
	var/range_low = max_explosion_range
	log_admin("[key_name_admin(usr)] changed the bomb cap to [range_dev], [range_high], [range_low]")


/datum/admin_secret_item/fun_secret/triple_ai_mode
	name = "Triple AI Mode"

/datum/admin_secret_item/fun_secret/triple_ai_mode/can_execute(var/mob/user)
	if(ticker && ticker.current_state > GAME_STATE_PREGAME)
		return 0

	return ..()

/datum/admin_secret_item/admin_secret/triple_ai_mode/execute(var/mob/user)
	. = ..()
	if(.)
		user.client.triple_ai()



/datum/admin_secret_item/fun_secret/turn_humans_into_corgies
	name = "Turn All Humans Into Corgies"

/datum/admin_secret_item/fun_secret/turn_humans_into_corgies/execute(var/mob/user)
	. = ..()
	if(!.)
		return

	for(var/mob/living/carbon/human/H in mob_list)
		spawn(0)
			H.corgize()



/datum/admin_secret_item/fun_secret/turn_humans_into_monkeys
	name = "Turn All Humans Into Monkeys"

/datum/admin_secret_item/fun_secret/turn_humans_into_monkeys/execute(var/mob/user)
	. = ..()
	if(!.)
		return

	for(var/mob/living/carbon/human/H in mob_list)
		spawn(0)
			H.monkeyize()


/datum/admin_secret_item/final_solution/supermatter_cascade
	name = "Supermatter Cascade"

/datum/admin_secret_item/final_solution/supermatter_cascade/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	var/choice = input(user, "You sure you want to destroy the universe and create a large explosion at your location? Misuse of this could result in removal of flags or hilarity.") in list("NO TIME TO EXPLAIN", "Cancel")
	if(choice == "NO TIME TO EXPLAIN")
		explosion(get_turf(user), 8, 16, 24, 32, 1)
		new /turf/unsimulated/wall/supermatter(get_turf(user))
		SetUniversalState(/datum/universal_state/supermatter_cascade)
		message_admins("[key_name_admin(user)] has managed to destroy the universe with a supermatter cascade. Good job, [key_name_admin(user)]")


/datum/admin_secret_item/final_solution/summon_narsie
	name = "Summon Nar-Sie"

/datum/admin_secret_item/final_solution/summon_narsie/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	var/choice = input(user, "You sure you want to end the round and summon Nar-Sie at your location? Misuse of this could result in removal of flags or hilarity.") in list("PRAISE SATAN", "Cancel")
	if(choice == "PRAISE SATAN")
		new /obj/singularity/narsie/large(get_turf(user))
		log_and_message_admins("has summoned Nar-Sie and brought about a new realm of suffering.", user)

/datum/admin_secret_item/random_event/trigger_xenomorph_infestation
	name = "Trigger a Xenomorph Infestation"

/datum/admin_secret_item/random_event/trigger_xenomorph_infestation/execute(var/mob/user)
	. = ..()
	if(.)
		return xenomorphs.attempt_random_spawn()


/datum/admin_secret_item/random_event/trigger_cordical_borer_infestation
	name = "Trigger a Cortical Borer infestation"

/datum/admin_secret_item/random_event/trigger_cordical_borer_infestation/execute(var/mob/user)
	. = ..()
	if(.)
		return borers.attempt_random_spawn()

/datum/admin_secret_item/random_event/meteorwave
	name = "Spawn a meteor wave"

/datum/admin_secret_item/random_event/meteorwave/execute(var/mob/user)
	. = ..()
	if(.)
		return new /datum/event/meteor_wave


/datum/admin_secret_item/random_event/meteorwave
	name = "Spawn a meteor wave"

/datum/admin_secret_item/random_event/meteorwave/execute(var/mob/user)
	. = ..()
	if(.)
		return new /datum/event/meteor_wave

/datum/admin_secret_item/random_event/prisonbreak
	name = "Allow a prison break"

/datum/admin_secret_item/random_event/prisonbreak/execute(var/mob/user)
	. = ..()
	if(.)
		return prison_break()


/datum/admin_secret_item/random_event/rod
	name = "Spawn an immovable rod"

/datum/admin_secret_item/random_event/rod/execute(var/mob/user)
	. = ..()
	if(.)
		return immovablerod()

