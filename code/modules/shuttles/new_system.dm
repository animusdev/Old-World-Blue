var/global/list/sh_beakons = list()

/datum/shuttle_controller
	var/list/new_shuttles = list()

/obj/shuttle_beacon
	name = "Shuttle Beacon"
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "beacon"
	var/global/num = 1
	var/turf/target = null

/obj/shuttle_beacon/New()
	if(name == initial(name))
		name = "[initial(name)] #[num++]"
	sh_beakons[name] = src
	target = get_step(src, dir)

/obj/shuttle_beacon/proc/get_target()
	return target

/obj/shuttle_marker
	name = "Shuttle Marker"
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "marker"

/obj/shuttle_marker/New()
	..()
	spawn(5)
		setup()

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

/client/verb/beacon_move()
	set name = "Beacon move"
	set category = "Debug"

	var/where = input("Beakon", "Pick!") as null|anything in sh_beakons
	if(!where) return
	var/shuttle_tag = input("Shuttle","pick!") as null|anything in shuttle_controller.new_shuttles
	if(!shuttle_tag) return
	var/datum/shuttle/untethered/shuttle = shuttle_controller.new_shuttles[shuttle_tag]
	shuttle.beacon_move(sh_beakons[where])


/datum/shuttle/untethered
	var/name = ""
	var/obj/shuttle_marker/marker = null
	var/area/my_area
	var/list/docking_points

/datum/shuttle/untethered/New(var/obj/shuttle_marker/Marker)
	..()
	src.my_area = get_area(Marker)
	src.marker  = Marker
	src.name    = Marker.name
	shuttle_controller.new_shuttles[name] = shuttle
	docking_points = list()

/datum/shuttle/untethered/proc/beacon_move(var/obj/shuttle_beacon/destination, var/direction=null)

	var/turf/target = destination.get_target()

	var/list/shift = list(
		marker.x - target.x,
		marker.y - target.y,
		marker.z - target.z
	)

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

/*
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