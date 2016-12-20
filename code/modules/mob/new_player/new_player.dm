//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:33

/mob/new_player
	var/ready = 0
	var/spawning = 0//Referenced when you want to delete the new_player later on in the code.
	var/totalPlayers = 0		 //Player counts for the Lobby tab
	var/totalPlayersReady = 0
	universal_speak = 1

	invisibility = 101

	density = 0
	stat = 2
	canmove = 0

	anchored = 1	//  don't get pushed around

	New()
		mob_list += src

	verb/new_player_panel()
		set src = usr
		new_player_panel_proc()


	proc/new_player_panel_proc()
		var/output = "<div align='center'><B>New Player Options</B>"
		output +="<hr>"
		output += "<p><a href='byond://?src=\ref[src];show_preferences=1'>Setup Character</A></p>"
		//output += "<p><a href='byond://?src=\ref[src];show_preferences_new=1'>New Setup Character (WIP)</A></p>"

		if(!ticker || ticker.current_state <= GAME_STATE_PREGAME)
			if(ready)
				output += "<p>\[ <b>Ready</b> | <a href='byond://?src=\ref[src];ready=0'>Not Ready</a> \]</p>"
			else
				output += "<p>\[ <a href='byond://?src=\ref[src];ready=1'>Ready</a> | <b>Not Ready</b> \]</p>"

		else
			output += "<a href='byond://?src=\ref[src];manifest=1'>View the Crew Manifest</A><br><br>"
			output += "<p><a href='byond://?src=\ref[src];late_join=1'>Join Game!</A></p>"

		output += "<p><a href='byond://?src=\ref[src];observe=1'>Observe</A></p>"

/*		if(!IsGuestKey(src.key))
			establish_db_connection()*/

		output += "</div>"

		src << browse(output,"window=playersetup;size=210x280;can_close=0")
		return

	proc/IsJobRestricted(rank)
		if(client && client.prefs)
			return client.prefs.IsJobRestricted(rank)
		return 0

	Stat()
		..()

		if(statpanel("Lobby") && ticker)
			if(ticker.hide_mode)
				stat("Game Mode:", "Secret")
			else
				if(ticker.hide_mode == 0)
					stat("Game Mode:", "[master_mode]") // Old setting for showing the game mode

			if(ticker.current_state == GAME_STATE_PREGAME)
				stat("Time To Start:", "[ticker.pregame_timeleft][going ? "" : " (DELAYED)"]")
				stat("Players: [totalPlayers]", "Players Ready: [totalPlayersReady]")
				totalPlayers = 0
				totalPlayersReady = 0
				for(var/mob/new_player/player in player_list)
					stat("[player.key]", (player.ready)?("(Playing)"):(null))
					totalPlayers++
					if(player.ready)totalPlayersReady++

	Topic(href, href_list[])
		if(!client)	return 0

		//Determines Relevent Population Cap
		var/relevant_cap
		if(config.hard_popcap && config.extreme_popcap)
			relevant_cap = min(config.hard_popcap, config.extreme_popcap)
		else
			relevant_cap = max(config.hard_popcap, config.extreme_popcap)

		if(href_list["show_preferences_new"])
			client.prefs.NewShowChoices(src)
			return 1

		if(href_list["show_preferences"])
			client.prefs.ShowChoices(src)
			return 1

		if(href_list["ready"])
			if(!ticker || ticker.current_state <= GAME_STATE_PREGAME) // Make sure we don't ready up after the round has started
				ready = text2num(href_list["ready"])
			else
				ready = 0

		if(href_list["refresh"])
			src << browse(null, "window=playersetup") //closes the player setup window
			new_player_panel_proc()

		if(href_list["observe"])

			if(alert(src,"Are you sure you wish to observe? You will have to wait [config.respawn_time] minutes before being able to respawn!","Player Setup","Yes","No") == "Yes")
				if(!client)	return 1
				var/mob/observer/dead/observer = new()

				spawning = 1
				src << sound(null, repeat = 0, wait = 0, volume = 85, channel = 1) // MAD JAMS cant last forever yo


				observer.started_as_observer = 1
				close_spawn_windows()
				var/obj/O = locate("landmark*Observer-Start")
				if(istype(O))
					src << "<span class='notice'>Now teleporting.</span>"
					observer.loc = O.loc
				else
					src << "<span class='danger'>Could not locate an observer spawn point. Use the Teleport verb to jump to the station map.</span>"
				observer.timeofdeath = world.time // Set the time of death so that the respawn timer works correctly.

				announce_ghost_joinleave(src)
				client.prefs.update_preview_icon()
				observer.icon = client.prefs.preview_icon
				observer.alpha = 127

				if(client.prefs.random_name || jobban_isbanned(src, "Name"))
					client.prefs.real_name = random_name(client.prefs.gender)
				observer.real_name = client.prefs.real_name
				observer.name = observer.real_name
				if(!client.holder && !config.antag_hud_allowed)           // For new ghosts we remove the verb from even showing up if it's not allowed.
					observer.verbs -= /mob/observer/dead/verb/toggle_antagHUD        // Poor guys, don't know what they are missing!
				observer.key = key
				qdel(src)

				return 1

		if(href_list["late_join"])

			if(!ticker || ticker.current_state != GAME_STATE_PLAYING)
				usr << "\red The round is either not ready, or has already finished..."
				return

			if(ticker.queued_players.len || (relevant_cap && living_player_count() >= relevant_cap && !(ckey(key) in admin_datums)))
				usr << "<span class='danger'>[config.hard_popcap_message]</span>"

				var/queue_position = ticker.queued_players.Find(usr)
				if(queue_position == 1)
					usr << "<span class='notice'>You are next in line to join the game. You will be notified when a slot opens up.</span>"
				else if(queue_position)
					usr << "<span class='notice'>There are [queue_position-1] players in front of you in the queue to join the game.</span>"
				else
					ticker.queued_players += usr
					usr << "<span class='notice'>You have been added to the queue to join the game. Your position in queue is [ticker.queued_players.len].</span>"
				return

			if(client.prefs.species != "Human" && !check_rights(R_ADMIN, 0))
				if(jobban_isbanned(src, client.prefs.species))
					src << alert("You are currently banned from play [client.prefs.species].")
					return 0
				else if(!is_alien_whitelisted(src, client.prefs.species) && config.usealienwhitelist)
					src << alert("You are currently not whitelisted to play [client.prefs.species].")
					return 0

				var/datum/species/S = all_species[client.prefs.species]
				if(!(S.flags & IS_WHITELISTED))
					src << alert("Your current species,[client.prefs.species], is not available for play on the station.")
					return 0

			LateChoices()

		if(href_list["manifest"])
			ViewManifest()

		if(href_list["SelectedJob"])

			if(!config.enter_allowed)
				usr << "<span class='notice'>There is an administrative lock on entering the game!</span>"
				return
			else if(ticker && ticker.mode && ticker.mode.explosion_in_progress)
				usr << "<span class='danger'>The station is currently exploding. Joining would go poorly.</span>"
				return

			if(client.prefs.species != "Human")
				if(!is_alien_whitelisted(src, client.prefs.species) && config.usealienwhitelist)
					src << alert("You are currently not whitelisted to play [client.prefs.species].")
					return 0

				var/datum/species/S = all_species[client.prefs.species]
				if(!(S.flags & CAN_JOIN))
					src << alert("Your current species, [client.prefs.species], is not available for play on the station.")
					return 0

			AttemptLateSpawn(href_list["SelectedJob"],client.prefs.spawnpoint)
			return

		if(href_list["preference"])
			world << "Outdated link format. HREF = [href]"
		else if(!href_list["late_join"])
			new_player_panel()

	proc/IsJobAvailable(rank)
		var/datum/job/job = job_master.GetJob(rank)
		if(!job)								return 0
		if(!job.is_position_available(1))		return 0
		if(jobban_isbanned(src,rank))			return 0
		if(IsJobRestricted(rank))				return 0
		if(!job.player_old_enough(src.client))	return 0
		return 1


	proc/AttemptLateSpawn(rank,var/spawning_at)
		if(src != usr)
			return 0
		if(!ticker || ticker.current_state != GAME_STATE_PLAYING)
			usr << "\red The round is either not ready, or has already finished..."
			return 0
		if(!config.enter_allowed)
			usr << "<span class='notice'>There is an administrative lock on entering the game!</span>"
			return 0
		if(!IsJobAvailable(rank))
			src << alert("[rank] is not available. Please try another.")
			return 0

		if(!job_master.AssignRole(src, rank, 1))
			return 0

		spawning = 1
		close_spawn_windows()

		src << sound(null, repeat = 0, wait = 0, volume = 85, channel = 1) // MAD JAMS cant last forever yo

		var/mob/living/character
		switch(mind.assigned_role)
			if("AI")
				var/mob/living/silicon/ai/O = src.AIize(1,0) //SRC was deleted here!
				AnnounceCyborg(O, rank, "has been downloaded to the empty core in \the [character.loc.loc]")
				ticker.mode.handle_latejoin(O)
				qdel(src)
				return
			if("Cyborg")
				character = create_robot_character()
			else
				character = create_character()	//creates the human and transfers vars and mind
				job_master.EquipRank(character, rank)					//equips the human
				UpdateFactionList(character)
				equip_custom_items(character)

		//Find our spawning point.
		var/join_message
		var/datum/spawnpoint/S

		if(spawning_at)
			S = spawntypes[spawning_at]

		if(S && istype(S))
			if(S.check_job_spawning(rank))
				character.loc = pick(S.turfs)
				join_message = S.msg
			else
				character << "Your chosen spawnpoint ([S.display_name]) is unavailable for your chosen job. Spawning you at the Arrivals shuttle instead."
				character.loc = pick(latejoin)
				join_message = "has arrived on the station"
		else
			character.loc = pick(latejoin)
			join_message = "has arrived on the station"

		character.lastarea = get_area(loc)
		// Moving wheelchair if they have one
		if(character.buckled && istype(character.buckled, /obj/structure/bed/chair/wheelchair))
			character.buckled.loc = character.loc
			character.buckled.set_dir(character.dir)

		ticker.mode.handle_latejoin(character)
		ticker.minds += character.mind //AIs handle this in the transform proc.	//TODO!!!!! ~Carn

		if(character.mind.assigned_role != "Cyborg")
			data_core.manifest_inject(character)
			AnnounceArrival(character, rank, join_message)
		else
			AnnounceCyborg(character, rank, join_message)

		qdel(src)

	proc/AnnounceArrival(var/mob/living/carbon/human/character, var/rank, var/join_message)
		if (ticker.current_state == GAME_STATE_PLAYING)
			if(character.mind.role_alt_title)
				rank = character.mind.role_alt_title
			global_announcer.autosay("[character.real_name],[rank ? " [rank]," : " visitor," ] [join_message ? join_message : "has arrived on the station"].", "Arrivals Announcement Computer")

	proc/AnnounceCyborg(var/mob/living/character, var/rank, var/join_message)
		if (ticker.current_state == GAME_STATE_PLAYING)
			if(character.mind.role_alt_title)
				rank = character.mind.role_alt_title
			// can't use their name here, since cyborg namepicking is done post-spawn, so we'll just say "A new Cyborg has arrived"/"A new Android has arrived"/etc.
			global_announcer.autosay("A new[rank ? " [rank]" : " visitor" ] [join_message ? join_message : "has arrived on the station"].", "Arrivals Announcement Computer")

	proc/LateChoices()
		var/name = client.prefs.random_name ? "friend" : client.prefs.real_name

		var/dat = "<html><body><center>"
		dat += "<b>Welcome, [name].<br></b>"
		dat += "Round Duration: [round_duration()]<br>"

		if(emergency_shuttle) //In case Nanotrasen decides reposess CentComm's shuttles.
			if(emergency_shuttle.going_to_centcom()) //Shuttle is going to centcomm, not recalled
				dat += "<font color='red'><b>The station has been evacuated.</b></font><br>"
			if(emergency_shuttle.online())
				if (emergency_shuttle.evac)	// Emergency shuttle is past the point of no recall
					dat += "<font color='red'>The station is currently undergoing evacuation procedures.</font><br>"
				else						// Crew transfer initiated
					dat += "<font color='red'>The station is currently undergoing crew transfer procedures.</font><br>"

		dat += "Choose from the following open positions:<br>"
		for(var/datum/job/job in job_master.occupations)
			if(job && IsJobAvailable(job.title))
				var/active = 0
				// Only players with the job assigned and AFK for less than 10 minutes count as active
				for(var/mob/M in player_list) if(M.mind && M.client && M.mind.assigned_role == job.title && M.client.inactivity <= 10 * 60 * 10)
					active++
				dat += "<a href='byond://?src=\ref[src];SelectedJob=[job.title]'>[job.title] ([job.current_positions]) (Active: [active])</a><br>"

		dat += "</center>"
		src << browse(dat, "window=latechoices;size=300x640;can_close=1")


	proc/create_character()
		spawning = 1
		close_spawn_windows()

		var/mob/living/carbon/human/new_character

		var/use_species_name
		var/datum/species/chosen_species
		if(client.prefs.species)
			chosen_species = all_species[client.prefs.species]
			use_species_name = chosen_species.get_station_variant() //Only used by pariahs atm.

		if(chosen_species && use_species_name)
			// Have to recheck admin due to no usr at roundstart. Latejoins are fine though.
			if(is_species_whitelisted(chosen_species) || has_admin_rights())
				new_character = new(loc, use_species_name)

		if(!new_character)
			new_character = new(loc)

		new_character.lastarea = get_area(loc)

		var/datum/language/chosen_language
		if(client.prefs.language)
			chosen_language = all_languages["[client.prefs.language]"]
		if(chosen_language)
			if(is_alien_whitelisted(src, client.prefs.language) || !config.usealienwhitelist || !(chosen_language.flags & WHITELISTED) || (new_character.species && (chosen_language.name in new_character.species.secondary_langs)))
				new_character.add_language("[client.prefs.language]")

		if(ticker.random_players)
			new_character.gender = pick(MALE, FEMALE)
			client.prefs.real_name = random_name(new_character.gender)
			client.prefs.randomize_appearance_for(new_character)
		else
			client.prefs.copy_to(new_character)

		if(mind)
			mind.active = 0					//we wish to transfer the key manually
			mind.original = new_character
			mind.transfer_to(new_character)					//won't transfer key since the mind is not active

		new_character.name = real_name
		new_character.dna.ready_dna(new_character)
		new_character.dna.b_type = client.prefs.b_type

		if(client.prefs.disabilities)
			// Set defer to 1 if you add more crap here so it only recalculates struc_enzymes once. - N3X
			new_character.dna.SetSEState(GLASSESBLOCK,1,0)
			new_character.disabilities |= NEARSIGHTED

		// And uncomment this, too.
		//new_character.dna.UpdateSE()

		// Do the initial caching of the player's body icons.
		new_character.force_update_limbs()
		new_character.update_eyes()
		new_character.regenerate_icons()

		new_character.key = key		//Manually transfer the key to log them in

		return new_character

	proc/create_robot_character()
		spawning = 1
		close_spawn_windows()

		var/mob/living/silicon/robot/R = new (src.loc)
		R.job = "Cyborg"
		switch(mind.role_alt_title)
			if("Android")
				R.mmi = new /obj/item/device/mmi/digital/posibrain(R)
			if("Robot")
				R.mmi = new /obj/item/device/mmi/digital/robot(R)
			else
				R.mmi = new /obj/item/device/mmi(R)
		R.mmi.set_identity(client.prefs.real_name)
		if(mind)
			mind.active = 0		//we wish to transfer the key manually
			mind.original = R
			mind.transfer_to(R)	//won't transfer key since the mind is not active
		R.key = key				//Manually transfer the key to log them in
		return R


	proc/ViewManifest()
		var/dat = "<html><body>"
		dat += "<h4>Show Crew Manifest</h4>"
		dat += data_core.get_manifest(OOC = 1)
		src << browse(dat, "window=manifest;size=370x420;can_close=1")

	Move()
		return 0

	proc/close_spawn_windows()
		src << browse(null, "window=latechoices") //closes late choices window
		src << browse(null, "window=playersetup") //closes the player setup window

	proc/has_admin_rights()
		return client.holder.rights & R_ADMIN

	proc/is_species_whitelisted(datum/species/S)
		if(!S) return 1
		return is_alien_whitelisted(src, S.name) || !config.usealienwhitelist || !(S.flags & IS_WHITELISTED)

/mob/new_player/get_species()
	var/datum/species/chosen_species
	if(client.prefs.species)
		chosen_species = all_species[client.prefs.species]

	if(!chosen_species)
		return "Human"

	if(is_species_whitelisted(chosen_species) || has_admin_rights())
		return chosen_species.name

	return "Human"

/mob/new_player/get_gender()
	if(!client || !client.prefs) ..()
	return client.prefs.gender

/mob/new_player/is_ready()
	return ready && ..()

/mob/new_player/hear_say(var/message, var/verb = "says", var/datum/language/language = null, var/alt_name = "",var/italics = 0, var/mob/speaker = null)
	return

/mob/new_player/hear_radio(var/message, var/verb="says", var/datum/language/language=null, var/part_a, var/part_b, var/mob/speaker = null, var/hard_to_hear = 0)
	return

mob/new_player/MayRespawn()
	return 1
