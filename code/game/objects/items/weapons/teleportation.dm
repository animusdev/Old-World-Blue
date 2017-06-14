/* Teleportation devices.
 * Contains:
 *		Locator
 *		Hand-tele
 *		Vortex Manipulator
 */

/*
 * Locator
 */
/obj/item/weapon/locator
	name = "locator"
	desc = "Used to track those with locater implants."
	icon = 'icons/obj/device.dmi'
	icon_state = "locator"
	var/temp = null
	var/frequency = 1451
	var/broadcasting = null
	var/listening = 1.0
	flags = CONDUCT
	w_class = ITEM_SIZE_SMALL
	item_state = "electronic"
	throw_speed = 4
	throw_range = 20
	origin_tech = list(TECH_MAGNET = 1)
	matter = list(MATERIAL_STEEL = 400)

/obj/item/weapon/locator/attack_self(mob/user as mob)
	user.set_machine(src)
	var/dat
	if (src.temp)
		dat = "[src.temp]<BR><BR><A href='byond://?src=\ref[src];temp=1'>Clear</A>"
	else
		dat = {"
<B>Persistent Signal Locator</B><HR>
Frequency:
<A href='byond://?src=\ref[src];freq=-10'>-</A>
<A href='byond://?src=\ref[src];freq=-2'>-</A> [format_frequency(src.frequency)]
<A href='byond://?src=\ref[src];freq=2'>+</A>
<A href='byond://?src=\ref[src];freq=10'>+</A><BR>

<A href='?src=\ref[src];refresh=1'>Refresh</A>"}
	user << browse(dat, "window=radio")
	onclose(user, "radio")
	return

/obj/item/weapon/locator/Topic(href, href_list)
	..()
	if (usr.stat || usr.restrained())
		return
	var/turf/current_location = get_turf(usr)//What turf is the user on?
	if(!current_location||current_location.z==2)//If turf was not found or they're on z level 2.
		usr << "The [src] is malfunctioning."
		return
	if ((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))))
		usr.set_machine(src)
		if (href_list["refresh"])
			src.temp = "<B>Persistent Signal Locator</B><HR>"
			var/turf/sr = get_turf(src)

			if (sr)
				src.temp += "<B>Located Beacons:</B><BR>"

				for(var/obj/item/device/radio/beacon/W in world)
					if (W.frequency == src.frequency)
						var/turf/tr = get_turf(W)
						if (tr.z == sr.z && tr)
							var/direct = max(abs(tr.x - sr.x), abs(tr.y - sr.y))
							if (direct < 5)
								direct = "very strong"
							else
								if (direct < 10)
									direct = "strong"
								else
									if (direct < 20)
										direct = "weak"
									else
										direct = "very weak"
							src.temp += "[W.code]-[dir2text(get_dir(sr, tr))]-[direct]<BR>"

				src.temp += "<B>Extranneous Signals:</B><BR>"
				for (var/obj/item/weapon/implant/tracking/W in world)
					if (!W.implanted || !(istype(W.loc,/obj/item/organ/external) || ismob(W.loc)))
						continue
					else
						var/mob/M = W.loc
						if (M.stat == DEAD)
							if (M.timeofdeath + 6000 < world.time)
								continue

					var/turf/tr = get_turf(W)
					if (tr.z == sr.z && tr)
						var/direct = max(abs(tr.x - sr.x), abs(tr.y - sr.y))
						if (direct < 20)
							if (direct < 5)
								direct = "very strong"
							else
								if (direct < 10)
									direct = "strong"
								else
									direct = "weak"
							src.temp += "[W.id]-[dir2text(get_dir(sr, tr))]-[direct]<BR>"

				src.temp += "<B>You are at \[[sr.x],[sr.y],[sr.z]\]</B> in orbital coordinates.<BR><BR><A href='byond://?src=\ref[src];refresh=1'>Refresh</A><BR>"
			else
				src.temp += "<B><FONT color='red'>Processing Error:</FONT></B> Unable to locate orbital position.<BR>"
		else
			if (href_list["freq"])
				src.frequency += text2num(href_list["freq"])
				src.frequency = sanitize_frequency(src.frequency)
			else
				if (href_list["temp"])
					src.temp = null
		if (istype(src.loc, /mob))
			attack_self(src.loc)
		else
			for(var/mob/M in viewers(1, src))
				if (M.client)
					src.attack_self(M)
	return


/*
 * Hand-tele
 */
/obj/item/weapon/hand_tele
	name = "hand tele"
	desc = "A portable item using blue-space technology."
	icon = 'icons/obj/device.dmi'
	icon_state = "hand_tele"
	item_state = "electronic"
	throwforce = 5
	w_class = ITEM_SIZE_SMALL
	throw_speed = 3
	throw_range = 5
	origin_tech = list(TECH_MAGNET = 1, TECH_BLUESPACE = 3)
	matter = list(MATERIAL_STEEL = 10000)

/obj/item/weapon/hand_tele/attack_self(mob/user as mob)
	var/turf/current_location = get_turf(user)//What turf is the user on?
	if(!isPlayerLevel(current_location.z))
		user << SPAN_NOTE("\The [src] is malfunctioning.")
		return
	var/list/L = list()
	for(var/obj/machinery/teleport/hub/R in machines)
		var/obj/machinery/computer/teleporter/com = R.com
		if (istype(com, /obj/machinery/computer/teleporter) && com.locked && com.locked.is_active() && !com.one_time_use)
			if(R.icon_state == "tele1")
				L["[com.id] (Active)"] = com.locked.target_obj
			else
				L["[com.id] (Inactive)"] = com.locked.target_obj
	var/list/turfs = list()
	for(var/turf/T in RANGE_TURFS(10, current_location))
		if(T.x>world.maxx-8 || T.x<8)
			continue	//putting them at the edge is dumb
		if(T.y>world.maxy-8 || T.y<8)
			continue
		turfs += T
	if(turfs.len)
		L["None (Dangerous)"] = pick(turfs)
	var/t1 = input(user, "Please select a teleporter to lock in on.", "Hand Teleporter") in L
	if ((user.get_active_hand() != src || user.stat || user.restrained()))
		return
	var/count = 0	//num of portals from this teleport in world
	for(var/obj/effect/portal/PO in world)
		if(PO.creator == src)	count++
	if(count >= 3)
		user << SPAN_NOTE("\The [src] is recharging!")
		return
	var/atom/T = L[t1]
	for(var/mob/O in hearers(user, null))
		O.show_message(SPAN_NOTE("Locked In."), 2)
	var/obj/effect/portal/P = new /obj/effect/portal( get_turf(src) )
	P.target = T
	P.creator = src
	src.add_fingerprint(user)
	return

/*
 * Vortex Manipulator (Hello Missy)
 */

/obj/item/weapon/vortex_manipulator
	name = "Vortex Manipulator"
	desc = "Strange and complex reverse-engineered technology of some ancient race designed to travel through space and time. Unfortunately, time-shifting is DNA-locked."
	icon = 'icons/obj/device.dmi'
	icon_state = "hand_tele"
	item_state = "electronic"
	var/chargecost_area = 10000
	var/chargecost_beacon = 2000
	var/chargecost_local = 1000
	var/timelord_mode = 0
	var/list/beacon_locations = list()
	var/obj/item/weapon/cell/vcell
	throwforce = 5
	w_class = ITEM_SIZE_SMALL
	throw_speed = 3
	throw_range = 5
	origin_tech = list(TECH_MATERIAL = 9, TECH_BLUESPACE = 10, TECH_MAGNET = 8, TECH_POWER = 8, TECH_ARCANE = 4, TECH_ILLEGAL = 5)
	matter = list(MATERIAL_STEEL = 10000, MATERIAL_GLASS = 5000)
	
/obj/item/weapon/vortex_manipulator/attack_self(mob/user as mob)
	user.set_machine(src)
	var/dat = "<B>Vortex Manipulator Menu:</B><BR>"
	dat += "Current charge: [src.vcell.charge] out of [src.vcell.maxcharge]<BR>"
	if(timelord_mode)
		dat += "SAY SOMETHING NICE<BR>"
	dat += "<HR>"
	dat += "<B>Unstable technology: Major Malfunction Possible!</B><BR>"
	if(timelord_mode || vcell)
		dat += "<A href='byond://?src=\ref[src];area_teleport=1'>Teleport to Area</A><BR>"
		dat += "<A href='byond://?src=\ref[src];beacon_teleport=1'>Teleport to Beacon</A><BR>"
		dat += "<A href='byond://?src=\ref[src];local_teleport=1'>Space-shift locally</A><BR>"
	else
		dat += "ALERT: THE DEVICE IS UNPOWERED"
	dat += "Kind regards,<br>Dominus temporis. <br><br>P.S. Don't forget to ask someone to say something nice.<HR>"
	user << browse(dat, "window=scroll")
	onclose(user, "scroll")
	return

/obj/item/weapon/vortex_manipulator/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/weapon/cell))
		if(!vcell)
			user.drop_from_inventory(W, src)
			vcell = W
			user << "<span class='notice'>You install a cell in [src].</span>"
			//update_icon()
		else
			user << "<span class='notice'>[src] already has a cell.</span>"

	else if(istype(W, /obj/item/weapon/screwdriver))
		if(vcell)
			vcell.update_icon()
			vcell.loc = get_turf(src.loc)
			vcell = null
			user << "<span class='notice'>You remove the cell from the [src].</span>"
			//update_icon()
			return
		..()
	return

/obj/item/weapon/vortex_manipulator/Topic(href, href_list)
	..()
	if (usr.stat || usr.restrained() || src.loc != usr)
		return
	if (!ishuman(usr))
		return 1
	var/mob/living/carbon/human/H = usr
	if ((H == src.loc || (in_range(src, H) && istype(src.loc, /turf))))
		usr.set_machine(src)
		if (href_list["area_teleport"])
			if (timelord_mode || (src.vcell.charge >= src.chargecost_area))
				areateleport(H)
		else if (href_list["beacon_teleport"])
			if (timelord_mode || (src.vcell.charge >= src.chargecost_beacon))
				beaconteleport(H)
		else if (href_list["local_teleport"])
			if(timelord_mode || (src.vcell.charge >= src.chargecost_local * 7))
				localteleport(H)
	attack_self(H)
	return

/obj/item/weapon/vortex_manipulator/proc/malfunction()
	visible_message("\red <B>\The Vortex Manipulator malfunctions!</B>")
	if(prob(1))
		visible_message("\red <B>\The Vortex Manipulator explodes and disappears in Bluespace!</B>")
		explosion(get_turf(src), 1, 2, 4, 5)
		qdel(src)
		return
	else if(prob(5))
		visible_message("\red <B>\Space Carps fade from local bluespace anomaly!</B>")
		playsound(get_turf(src), 'sound/effects/phasein.ogg', 50, 1)
		var/amount = rand(1,3)
		for(var/i=0;i<amount;i++)
			new /mob/living/simple_animal/hostile/carp(get_turf(src))
		return
	else if(prob(10))
		visible_message("\red <B>\The Vortex Manipulator violently shakes and releases some of its hidden energy!</B>")
		explosion(get_turf(src), 0, 0, 3, 4)
		return
	playsound(get_turf(src), "sparks", 50, 1)
	var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
	sparks.set_up(3, 0, get_turf(src))
	sparks.start()

/obj/item/weapon/vortex_manipulator/proc/deductcharge(var/chrgdeductamt)
	if(vcell)
		if(vcell.checked_use(chrgdeductamt))
			return 1
		else
			return 0
	return null

/obj/item/weapon/vortex_manipulator/proc/get_beacon_locations()
	beacon_locations = list()
	for(var/obj/item/device/radio/beacon/R in world)
		var/area/AR = get_area(R)
		if(is_type_in_list(AR, list(/area/shuttle, /area/syndicate_station, /area/wizard_station))) continue
		if(beacon_locations.Find(AR.name)) continue
		var/turf/picked = pick(get_area_turfs(AR.type))
		if(isStationLevel(picked.z))
			beacon_locations += AR.name
			beacon_locations[AR.name] = AR

	beacon_locations = sortAssoc(beacon_locations)

// phase_in & phase_out are from ninja's teleport.
/obj/item/weapon/vortex_manipulator/proc/phase_in(var/mob/M,var/turf/T)
	if(!M || !T)
		return
	playsound(T, 'sound/effects/phasein.ogg', 50, 1)
	anim(T,M,'icons/mob/mob.dmi',,"phasein",,M.dir)
	
/obj/item/weapon/vortex_manipulator/proc/phase_out(var/mob/M,var/turf/T)
	if(!M || !T)
		return
	playsound(T, 'sound/effects/phasein.ogg', 50, 1)
	anim(T,M,'icons/mob/mob.dmi',,"phaseout",,M.dir)
	
/obj/item/weapon/vortex_manipulator/proc/localteleport(var/mob/user)
	var/list/possible_x = list(-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5)
	var/list/possible_y = list(-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5)
	var/A = input(user, "X-coordinate shift", "JEEROOONIMOOO") in possible_x
	var/B = input(user, "Y-coordinate shift", "JEEROOONIMOOO") in possible_y
	var/turf/starting = get_turf(user)
	var/new_x = starting.x + A
	var/new_y = starting.y + B
	var/turf/targetturf = locate(new_x, new_y, user.z)
	phase_out(user,get_turf(user))
	user.forceMove(targetturf)
	phase_in(user,get_turf(user))
	deductcharge(chargecost_local * round(sqrt(A * A + B * B)))
	for(var/obj/item/weapon/grab/G in user.contents)
		if(G.affecting)
			phase_out(G.affecting,get_turf(G.affecting))
			G.affecting.forceMove(get_turf(user))
			phase_in(G.affecting,get_turf(G.affecting))
	if(prob(25))
		malfunction()
	
	
/obj/item/weapon/vortex_manipulator/proc/beaconteleport(var/mob/user)
	get_beacon_locations()
	var/A = input(user, "Beacon to jump to", "JEEROOONIMOOO") in beacon_locations
	var/area/thearea = beacon_locations[A]
	if (user.stat || user.restrained())
		return
	if(!((user == loc || (in_range(src, user) && istype(src.loc, /turf)))))
		return
	if(user && user.buckled)
		user.buckled.unbuckle_mob()
	for(var/obj/item/device/radio/beacon/R in world)
		if(get_area(R) == thearea)
			var/turf/T = get_turf(R)
			phase_out(user,get_turf(user))
			user.forceMove(T)
			phase_in(user,get_turf(user))
			deductcharge(chargecost_beacon)
			for(var/obj/item/weapon/grab/G in user.contents)
				if(G.affecting)
					phase_out(G.affecting,get_turf(G.affecting))
					G.affecting.forceMove(locate(user.x+rand(-1,1),user.y+rand(-1,1),T.z))
					phase_in(G.affecting,get_turf(G.affecting))
			break
	if(prob(5))
		malfunction()
	

/obj/item/weapon/vortex_manipulator/proc/areateleport(var/mob/user)
	var/A = input(user, "Area to jump to", "JEEROOONIMOOO") in teleportlocs
	var/area/thearea = teleportlocs[A]
	if (user.stat || user.restrained())
		return
	if(!((user == loc || (in_range(src, user) && istype(src.loc, /turf)))))
		return
	var/list/L = list()
	for(var/turf/T in get_area_turfs(thearea.type))
		if(!T.density)
			var/clear = 1
			for(var/obj/O in T)
				if(O.density)
					clear = 0
					break
			if(clear)
				L+=T
	if(!L.len)
		user <<"The space-time travel matrix was unable to locate a suitable teleport destination for an unknown reason. Sorry."
		return
	if(user && user.buckled)
		user.buckled.unbuckle_mob()
	var/turf/T = pick(L)
	phase_out(user,get_turf(user))
	user.forceMove(T)
	phase_in(user,get_turf(user))
	deductcharge(chargecost_area)
	for(var/obj/item/weapon/grab/G in user.contents)
		if(G.affecting)
			phase_out(G.affecting,get_turf(G.affecting))
			G.affecting.forceMove(locate(user.x+rand(-1,1),user.y+rand(-1,1),T.z))
			phase_in(G.affecting,get_turf(G.affecting))
	if(prob(50))
		malfunction()
