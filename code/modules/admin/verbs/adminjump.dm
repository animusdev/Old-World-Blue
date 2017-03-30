/mob/proc/on_mob_jump()
	return

/mob/observer/dead/on_mob_jump()
	following = null

/client/proc/Jump(var/area/A in return_sorted_areas())
	set name = "Jump to Area"
	set desc = "Area to jump to"
	set category = "Admin"
	if(!check_rights(R_ADMIN|R_MOD|R_DEBUG))
		return

	if(config.allow_admin_jump)
		usr.on_mob_jump()
		usr.loc = pick(get_area_turfs(A))

		log_admin("[key_name(usr)] jumped to [A]", A, 0)
	else
		alert("Admin jumping disabled")

/client/proc/jumptoturf(var/turf/T in world)
	set name = "Jump to Turf"
	set category = "Admin"
	if(!check_rights(R_ADMIN|R_MOD|R_DEBUG))
		return
	if(config.allow_admin_jump)
		log_admin("[key_name(usr)] jumped to [T].", T, 0)
		usr.on_mob_jump()
		usr.loc = T
	else
		alert("Admin jumping disabled")
	return

/client/proc/jumptomob(var/mob/M in mob_list)
	set category = "Admin"
	set name = "Jump to Mob"

	if(!check_rights(R_ADMIN|R_MOD|R_DEBUG))
		return

	if(config.allow_admin_jump)
		log_admin("[key_name(usr)] jumped to [key_name(M)]", M, 0)
		if(src.mob)
			var/mob/A = src.mob
			var/turf/T = get_turf(M)
			if(T && isturf(T))
				A.on_mob_jump()
				A.loc = T
			else
				A << "This mob is not located in the game world."
	else
		alert("Admin jumping disabled")

/client/proc/jumptocoord(tx as num, ty as num, tz as num)
	set category = "Admin"
	set name = "Jump to Coordinate"

	jumptoturf(locate(tx,ty,tz))


/client/proc/jumptokey()
	set category = "Admin"
	set name = "Jump to Key"

	if(!check_rights(R_ADMIN|R_MOD|R_DEBUG))
		return

	if(config.allow_admin_jump)
		var/list/keys = list()
		for(var/mob/M in player_list)
			keys += M.client
		var/selection = input("Please, select a player!", "Admin Jumping", null, null) as null|anything in sortKey(keys)
		if(!selection)
			src << "No keys found."
			return
		var/mob/M = selection:mob
		log_admin("[key_name(usr)] jumped to [key_name(M)]", M, 0)
		usr.on_mob_jump()
		usr.loc = M.loc
	else
		alert("Admin jumping disabled")

/client/proc/Getmob(var/mob/M in mob_list)
	set category = "Admin"
	set name = "Get Mob"
	set desc = "Mob to teleport"
	if(!check_rights(R_ADMIN|R_MOD|R_DEBUG))
		return
	if(config.allow_admin_jump)
		log_admin("[key_name(usr)] teleported [key_name(M)]", M)
		M.on_mob_jump()
		M.loc = get_turf(usr)
	else
		alert("Admin jumping disabled")

/client/proc/Getkey()
	set category = "Admin"
	set name = "Get Key"
	set desc = "Key to teleport"

	if(!check_rights(R_ADMIN|R_MOD|R_DEBUG))
		return

	if(config.allow_admin_jump)
		var/list/keys = list()
		for(var/mob/M in player_list)
			keys += M.client
		var/selection = input("Please, select a player!", "Admin Jumping", null, null) as null|anything in sortKey(keys)
		if(!selection)
			return
		var/mob/M = selection:mob

		if(!M)
			return
		log_admin("[key_name(usr)] teleported [key_name(M)]", M)
		if(M)
			M.on_mob_jump()
			M.loc = get_turf(usr)
	else
		alert("Admin jumping disabled")

/client/proc/sendmob(var/mob/M in sortmobs())
	set category = "Admin"
	set name = "Send Mob"
	if(!check_rights(R_ADMIN|R_MOD|R_DEBUG))
		return
	var/area/A = input(usr, "Pick an area.", "Pick an area") in return_sorted_areas()
	if(A)
		if(config.allow_admin_jump)
			M.on_mob_jump()
			M.loc = pick(get_area_turfs(A))

			log_admin("[key_name(usr)] teleported [key_name(M)] to [A]", A)
		else
			alert("Admin jumping disabled")
