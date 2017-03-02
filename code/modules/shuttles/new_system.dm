
/datum/shuttle_controller
	var/list/new_shuttles = list()
	var/list/sh_beakons = list()

/obj/shuttle_beacon
	name = "Shuttle Beacon"
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "beacon"
	invisibility = 101
	var/beacon_system = "Station"
	var/global/num = 1
	var/turf/target = null

/obj/shuttle_beacon/initialize()
	setup()

/obj/shuttle_beacon/verb/setup()
	set name = "Init Dock"
	set category = "Object"
	set src in view(1)

	if(name == initial(name))
		name = "[initial(name)] #[num++]"
	shuttle_controller.sh_beakons[name] = src
	target = get_step(src, dir)

/obj/shuttle_beacon/proc/get_target()
	return target

/obj/shuttle_beacon/proc/get_docking_dir()
	return get_dir(target, src)

/obj/shuttle_marker
	name = "Shuttle Marker"
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "marker"
	var/list/beacon_systems = list("Station")

/obj/shuttle_marker/verb/setup()
	set name = "Init shuttle"
	set category = "Object"
	set src in view(1)

	if(name == initial(name))
		world.log << "Failed to init shuttle_marker at ([x],[y],[z])"
		return
	var/datum/shuttle/untethered/shuttle = new(src)
	if(shuttle)
		world.log << "Successfully init shuttle: [name]"

		invisibility = 101
		src.verbs -= /obj/shuttle_marker/verb/setup

/client/proc/beacon_move()
	set name = "Beacon move"
	set category = "Debug"

	if(!check_rights(R_DEBUG))	return

	var/shuttle_tag = input("Shuttle","pick!") as null|anything in shuttle_controller.new_shuttles
	if(!shuttle_tag) return
	var/datum/shuttle/untethered/shuttle = shuttle_controller.new_shuttles[shuttle_tag]
	var/where = input("Beakon", "Pick!") as null|anything in shuttle_controller.sh_beakons
	if(!where) return
	var/result = shuttle.beacon_move(shuttle_controller.sh_beakons[where])
	if(!result)
		result = "<span class='notice'>Success!</span>"
	else
		result = "<span class='warning'>[result]</span>"
	usr << result

/proc/get_most_distant_object(var/list/L, var/dir = NORTH)
	if(!L || !L.len || !(dir in cardinal)) return null

	. = L[1]
	var/quality = 0
	var/tmp_quality
	for(var/obj/item in L)
		switch(dir)
			if(NORTH) tmp_quality = item.y
			if(SOUTH) tmp_quality =-item.y
			if(EAST)  tmp_quality = item.x
			if(WEST)  tmp_quality =-item.x
		if(tmp_quality > quality)
			quality = tmp_quality
			. = item

/datum/shuttle/untethered
	var/name = ""
	var/obj/shuttle_marker/marker = null
	var/area/my_area
	var/obj/north_port
	var/obj/south_port
	var/obj/west_port
	var/obj/east_port
	var/list/beacon_systems

/datum/shuttle/untethered/New(var/obj/shuttle_marker/Marker)
	..()
	src.my_area = get_area(Marker)
	src.marker  = Marker
	src.name    = Marker.name
	src.beacon_systems = Marker.beacon_systems
	shuttle_controller.new_shuttles[name] = src

	var/list/north = list()
	var/list/south = list()
	var/list/east  = list()
	var/list/west  = list()

	for(var/obj/machinery/door/airlock/external/E in my_area)
		for(var/dir in cardinal)
			if(get_area(get_step(E, dir)) != my_area)
				switch(dir)
					if(NORTH) north += E
					if(SOUTH) south += E
					if(WEST)  west  += E
					if(EAST)  east  += E
				break

	north_port = get_most_distant_object(north, NORTH)
	south_port = get_most_distant_object(south, SOUTH)
	west_port  = get_most_distant_object(west,  WEST)
	east_port  = get_most_distant_object(east,  EAST)

/datum/shuttle/untethered/proc/get_dock_list()
	. = list()
	for(var/obj/shuttle_beacon/SB in shuttle_controller.sh_beakons)
		if(SB.beacon_system in beacon_systems)
			. += SB

/datum/shuttle/untethered/proc/beacon_move(var/obj/shuttle_beacon/destination, var/direction=null)

	var/turf/target = destination.get_target()

	if(!istype(get_area(target), /area/space))
		return "Dock already occupied!"

	var/obj/marker
	switch(destination.get_docking_dir())
		if(NORTH) marker = north_port
		if(SOUTH) marker = south_port
		if(WEST)  marker = west_port
		if(EAST)  marker = east_port

	if(!marker)
		return "Can't find applyable port!"

	var/list/shift = list(
		marker.x - target.x,
		marker.y - target.y,
		marker.z - target.z
	)
/*
	var/list/dstturfs = list()
	var/throwy = world.maxy

	for(var/turf/T in destination)
		dstturfs += T
		if(T.y < throwy)
			throwy = T.y

	for(var/turf/T in dstturfs)
		var/turf/D = locate(T.x, throwy - 1, 1)
		for(var/atom/movable/AM as mob|obj in T)
			AM.Move(D)
		if(istype(T, /turf/simulated))
			qdel(T)

	for(var/mob/living/carbon/bug in destination)
		bug.gib()

	for(var/mob/living/simple_animal/pest in destination)
		pest.gib()
*/

	my_area.shift_contents(shift, direction=direction)

	for(var/mob/M in my_area)
		if(M.client)
			spawn(0)
				if(M.buckled)
					M << "\red Sudden acceleration presses you into your chair!"
					shake_camera(M, 3, 1)
				else
					M << "\red The floor lurches beneath you!"
					shake_camera(M, 10, 1)
		if(istype(M, /mob/living/carbon))
			if(!M.buckled)
				M.Weaken(3)

	// Power-related checks. If shuttle contains power related machinery, update powernets.
	if(locate(/obj/machinery/power) in my_area || locate(/obj/structure/cable) in my_area)
		makepowernets()

	return