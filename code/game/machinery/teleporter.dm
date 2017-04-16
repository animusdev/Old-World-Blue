#define CATEGORY_BEACON "beacons"
#define CATEGORY_IMPLANT "implants"


/datum/teleport_target
	var/name = ""
	var/atom/target_obj = null
	var/category = CATEGORY_BEACON
	var/obj/machinery/computer/teleporter/master

/datum/teleport_target/New(new_name, new_target, var/teleport)
	name = new_name
	target_obj = new_target
	master = teleport
	master.registered_targets += target_obj

/datum/teleport_target/Destroy()
	if(master)
		master.registered_targets -= target_obj
	return ..()

/datum/teleport_target/proc/is_active()
	return FALSE

/datum/teleport_target/beacon/is_active()
	return istype(target_obj) && isOnPlayerLevel(target_obj)

/datum/teleport_target/implant
	category = CATEGORY_IMPLANT

/datum/teleport_target/implant/is_active()
	var/obj/item/weapon/implant/I = target_obj
	if (!I.implanted || !ismob(I.loc) || !isOnPlayerLevel(target_obj))
		return FALSE

	var/mob/M = I.loc
	if(M.stat == DEAD)
		if(M.timeofdeath + 6000 < world.time)
			return FALSE

	return TRUE

/obj/machinery/computer/teleporter
	name = "Teleporter Control Console"
	desc = "Used to control a linked teleportation Hub and Station."
	icon_state = "teleport"
	circuit = /obj/item/weapon/circuitboard/teleporter
	dir = 4
	var/updating = 0
	var/last_update = 0
	var/list/locations = list()
	var/list/registered_targets = list()

	var/datum/teleport_target/locked = null
	var/id = null
	var/one_time_use = 0 //Used for one-time-use teleport cards (such as clown planet coordinates.)
						 //Setting this to 1 will set src.locked to null after a player enters the portal and will not allow hand-teles to open portals to that location.

/* Ghosts can't use this */
/obj/machinery/computer/teleporter/attack_ghost(user as mob)
	return 1

/obj/machinery/computer/teleporter/New()
	src.id = "[rand(1000, 9999)]"
	..()
	underlays.Cut()
	underlays += image('icons/obj/stationobjs.dmi', icon_state = "telecomp-wires")
	return

/obj/machinery/computer/teleporter/initialize()
	..()
	var/obj/machinery/teleport/station/station = locate(/obj/machinery/teleport/station) in get_step(src, dir)
	var/obj/machinery/teleport/hub/hub
	if(station)
		hub = locate(/obj/machinery/teleport/hub, get_step(station, dir))

	if(istype(station))
		station.com = hub
		station.set_dir(dir)

	if(istype(hub))
		hub.com = src
		hub.set_dir(dir)

/obj/machinery/computer/teleporter/attackby(I as obj, mob/living/user as mob)
	if(istype(I, /obj/item/weapon/card/data/))
		var/obj/item/weapon/card/data/C = I
		if(stat & (NOPOWER|BROKEN) & (C.function != "teleporter"))
			src.attack_hand()

		var/obj/L = null

		for(var/obj/effect/landmark/sloc in landmarks_list)
			if(sloc.name != C.data) continue
			if(locate(/mob/living) in sloc.loc) continue
			L = sloc
			break

		if(!L)
			L = locate("landmark*[C.data]") // use old stype

		if(istype(L, /obj/effect/landmark/) && istype(L.loc, /turf))
			usr << "You insert the coordinates into the machine."
			usr << "A message flashes across the screen reminding the traveller that the nuclear authentication disk is to remain on the station at all times."
			user.drop_from_inventory(C)
			qdel(C)

			if(C.data == "Clown Land")
				//whoops
				for(var/mob/O in hearers(src, null))
					O.show_message("\red Incoming bluespace portal detected, unable to lock in.", 2)

				for(var/obj/machinery/teleport/hub/H in range(1))
					var/amount = rand(2,5)
					for(var/i=0;i<amount;i++)
						new /mob/living/simple_animal/hostile/carp(get_turf(H))

			else
				for(var/mob/O in hearers(src, null))
					O.show_message("\blue Locked In", 2)
				src.locked = L
				one_time_use = 1

			src.add_fingerprint(usr)
	else
		..()

	return

/obj/machinery/teleport/station/attack_ai(mob/user)
	interact(user)

/obj/machinery/computer/teleporter/attack_hand(mob/user)
	if(..()) return
	interact(user)

/obj/machinery/computer/teleporter/proc/rebuild_locations_list()
	if(last_update > world.time + 15)
		return
	var/list/areaindex = list()

	for(var/datum/teleport_target/T in locations)
		if(!T.is_active())
			qdel(T)

	for(var/obj/item/device/radio/beacon/R in world)
		if(R in registered_targets)
			continue
		var/turf/T = get_turf(R)
		if (!T)
			continue
		if(!isPlayerLevel(T.z))
			continue
		var/tmpname = T.loc.name
		if(areaindex[tmpname])
			tmpname = "[tmpname] ([++areaindex[tmpname]])"
		else
			areaindex[tmpname] = 1
		locations += PoolOrNew(/datum/teleport_target/beacon, list(tmpname, R, src))

	for(var/obj/item/weapon/implant/tracking/I in world)
		if(I in registered_targets)
			continue
		if (!I.implanted || !ismob(I.loc))
			continue
		else
			var/mob/M = I.loc
			if(M.stat == DEAD)
				if(M.timeofdeath + 6000 < world.time)
					continue
			if(isOnAdminLevel(M))
				continue
			var/tmpname = M.real_name
			if(areaindex[tmpname])
				tmpname = "[tmpname] ([++areaindex[tmpname]])"
			else
				areaindex[tmpname] = 1
			locations += PoolOrNew(/datum/teleport_target/implant, list(tmpname, I, src))
	last_update = world.time


/obj/machinery/computer/teleporter/interact(mob/user)
	rebuild_locations_list()
	var/dat = "<html><body>"
	var/beacons = ""
	var/implants = ""
	for(var/datum/teleport_target/T in locations)
		if(!T.is_active())
			locations -= T
			if(locked == T)
				locked = null
			qdel(T)
			continue
		var/link = ""
		if(locked == T)
			link = "<b>[T.name]</b>"
		else
			link = "<a href='?src=\ref[src];target=\ref[T]'>[T.name]</a>"
		switch(T.category)
			if(CATEGORY_BEACON)
				beacons += "<li>[link]</li>"
			if(CATEGORY_IMPLANT)
				implants += "<li>[link]</li>"

	dat += "<h2>Beacons</h2>"
	if(beacons == "")
		dat += "None"
	else
		dat += "<ul>[beacons]</ul>"
	dat += "<h2>Tracking implants</h2>"
	if(implants == "")
		dat += "None"
	else
		dat += "<ul>[implants]</ul>"
	dat+="</body></html>"

	user << browse(dat,"window=[name];size = 500x325")

/obj/machinery/computer/teleporter/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["target"])
		var/datum/teleport_target/target = locate(href_list["target"])
		if(target in locations)
			locked = target
			for(var/mob/O in hearers(src, null))
				O.show_message("\blue Locked In", 2)

	spawn()
		interact(usr)


/obj/machinery/computer/teleporter/verb/set_id(t as text)
	set category = "Object"
	set name = "Set teleporter ID"
	set src in oview(1)
	set desc = "ID Tag:"

	if(stat & (NOPOWER|BROKEN) || !istype(usr,/mob/living))
		return
	if (t)
		src.id = t
	return

/obj/machinery/teleport
	name = "teleport"
	icon = 'icons/obj/stationobjs.dmi'
	density = 1
	anchored = 1.0
	var/lockeddown = 0


/obj/machinery/teleport/hub
	name = "teleporter hub"
	desc = "It's the hub of a teleporting machine."
	icon_state = "tele0"
	dir = 4
	var/accurate = 0
	use_power = 1
	idle_power_usage = 10
	active_power_usage = 2000
	var/obj/machinery/computer/teleporter/com


/obj/machinery/teleport/hub/New()
	..()
	underlays.Cut()
	underlays += image('icons/obj/stationobjs.dmi', icon_state = "tele-wires")

/obj/machinery/teleport/hub/Bumped(M as mob|obj)
	spawn()
		if (src.icon_state == "tele1")
			teleport(M)
			use_power(5000)
	return

/obj/machinery/teleport/hub/proc/teleport(atom/movable/M as mob|obj)
	if (!com)
		return
	if (!com.locked)
		for(var/mob/O in hearers(src, null))
			O.show_message("\red Failure: Cannot authenticate locked on coordinates. Please reinstate coordinate matrix.")
		return
	if (istype(M, /atom/movable))
		if(prob(5) && !accurate) //oh dear a problem, put em in deep space
			do_teleport(M, locate(rand((2*TRANSITIONEDGE), world.maxx - (2*TRANSITIONEDGE)), rand((2*TRANSITIONEDGE), world.maxy - (2*TRANSITIONEDGE)), 3), 2)
		else
			do_teleport(M, com.locked.target_obj) //dead-on precision

		if(com.one_time_use) //Make one-time-use cards only usable one time!
			com.one_time_use = 0
			com.locked = null
	else
		var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
		s.set_up(5, 1, src)
		s.start()
		accurate = 1
		spawn(3000)	accurate = 0 //Accurate teleporting for 5 minutes
		for(var/mob/B in hearers(src, null))
			B.show_message("\blue Test fire completed.")
	return
/*
/proc/do_teleport(atom/movable/M as mob|obj, atom/destination, precision)
	if(istype(M, /obj/effect))
		qdel(M)
		return
	if (istype(M, /obj/item/weapon/disk/nuclear)) // Don't let nuke disks get teleported --NeoFite
		for(var/mob/O in viewers(M, null))
			O.show_message(text("\red <B>The [] bounces off of the portal!</B>", M.name), 1)
		return
	if (istype(M, /mob/living))
		var/mob/living/MM = M
		if(MM.check_contents_for(/obj/item/weapon/disk/nuclear))
			MM << "\red Something you are carrying seems to be unable to pass through the portal. Better drop it if you want to go through."
			return
	var/disky = 0
	for (var/atom/O in M.contents) //I'm pretty sure this accounts for the maximum amount of container in container stacking. --NeoFite
		if (istype(O, /obj/item/weapon/storage) || istype(O, /obj/item/weapon/gift))
			for (var/obj/OO in O.contents)
				if (istype(OO, /obj/item/weapon/storage) || istype(OO, /obj/item/weapon/gift))
					for (var/obj/OOO in OO.contents)
						if (istype(OOO, /obj/item/weapon/disk/nuclear))
							disky = 1
				if (istype(OO, /obj/item/weapon/disk/nuclear))
					disky = 1
		if (istype(O, /obj/item/weapon/disk/nuclear))
			disky = 1
		if (istype(O, /mob/living))
			var/mob/living/MM = O
			if(MM.check_contents_for(/obj/item/weapon/disk/nuclear))
				disky = 1
	if (disky)
		for(var/mob/P in viewers(M, null))
			P.show_message(text("\red <B>The [] bounces off of the portal!</B>", M.name), 1)
		return

//Bags of Holding cause bluespace teleportation to go funky. --NeoFite
	if (istype(M, /mob/living))
		var/mob/living/MM = M
		if(MM.check_contents_for(/obj/item/weapon/storage/backpack/holding))
			MM << "\red The Bluespace interface on your Bag of Holding interferes with the teleport!"
			precision = rand(1,100)
	if (istype(M, /obj/item/weapon/storage/backpack/holding))
		precision = rand(1,100)
	for (var/atom/O in M.contents) //I'm pretty sure this accounts for the maximum amount of container in container stacking. --NeoFite
		if (istype(O, /obj/item/weapon/storage) || istype(O, /obj/item/weapon/gift))
			for (var/obj/OO in O.contents)
				if (istype(OO, /obj/item/weapon/storage) || istype(OO, /obj/item/weapon/gift))
					for (var/obj/OOO in OO.contents)
						if (istype(OOO, /obj/item/weapon/storage/backpack/holding))
							precision = rand(1,100)
				if (istype(OO, /obj/item/weapon/storage/backpack/holding))
					precision = rand(1,100)
		if (istype(O, /obj/item/weapon/storage/backpack/holding))
			precision = rand(1,100)
		if (istype(O, /mob/living))
			var/mob/living/MM = O
			if(MM.check_contents_for(/obj/item/weapon/storage/backpack/holding))
				precision = rand(1,100)


	var/turf/destturf = get_turf(destination)

	var/tx = destturf.x + rand(precision * -1, precision)
	var/ty = destturf.y + rand(precision * -1, precision)

	var/tmploc

	if (ismob(destination.loc)) //If this is an implant.
		tmploc = locate(tx, ty, destturf.z)
	else
		tmploc = locate(tx, ty, destination.z)

	if(tx == destturf.x && ty == destturf.y && (istype(destination.loc, /obj/structure/closet) || istype(destination.loc, /obj/structure/closet/secure_closet)))
		tmploc = destination.loc

	if(tmploc==null)
		return

	M.loc = tmploc
	sleep(2)

	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(5, 1, M)
	s.start()
	return
*/

/obj/machinery/teleport/station
	name = "station"
	desc = "It's the station thingy of a teleport thingy." //seriously, wtf.
	icon_state = "controller"
	dir = 4
	var/active = 0
	var/engaged = 0
	use_power = 1
	idle_power_usage = 10
	active_power_usage = 2000
	var/obj/machinery/teleport/hub/com

/obj/machinery/teleport/station/New()
	..()
	overlays.Cut()
	overlays += image('icons/obj/stationobjs.dmi', icon_state = "controller-wires")

/obj/machinery/teleport/station/attackby(var/obj/item/weapon/W)
	src.attack_hand()

/obj/machinery/teleport/station/attack_ai()
	src.attack_hand()

/obj/machinery/teleport/station/attack_hand()
	if(engaged)
		src.disengage()
	else
		src.engage()

/obj/machinery/teleport/station/proc/engage()
	if(stat & (BROKEN|NOPOWER))
		return

	if (com)
		com.icon_state = "tele1"
		use_power(5000)
		update_use_power(2)
		com.update_use_power(2)
		for(var/mob/O in hearers(src, null))
			O.show_message("\blue Teleporter engaged!", 2)
	src.add_fingerprint(usr)
	src.engaged = 1
	return

/obj/machinery/teleport/station/proc/disengage()
	if(stat & (BROKEN|NOPOWER))
		return

	if (com)
		com.icon_state = "tele0"
		com.accurate = 0
		com.update_use_power(1)
		update_use_power(1)
		for(var/mob/O in hearers(src, null))
			O.show_message("\blue Teleporter disengaged!", 2)
	src.add_fingerprint(usr)
	src.engaged = 0
	return

/obj/machinery/teleport/station/verb/testfire()
	set name = "Test Fire Teleporter"
	set category = "Object"
	set src in oview(1)

	if(stat & (BROKEN|NOPOWER) || !istype(usr,/mob/living))
		return

	if (com && !active)
		active = 1
		for(var/mob/O in hearers(src, null))
			O.show_message("\blue Test firing!", 2)
		com.teleport()
		use_power(5000)

		spawn(30)
			active=0

	src.add_fingerprint(usr)
	return

/obj/machinery/teleport/station/power_change()
	..()
	if(stat & NOPOWER)
		icon_state = "controller-p"

		if(com)
			com.icon_state = "tele0"
	else
		icon_state = "controller"

#undef CATEGORY_BEACON
#undef CATEGORY_IMPLANT
