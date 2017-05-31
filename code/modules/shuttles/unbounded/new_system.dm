/area
	var/datum/shuttle/untethered/is_shuttle = null

/datum/shuttle_controller
	var/list/new_shuttles = list()

/client/proc/beacon_move()
	set name = "Beacon move"
	set category = "Debug"

	if(!check_rights(R_DEBUG))	return

	var/shuttle_tag = input("Shuttle","Pick!") as null|anything in shuttle_controller.new_shuttles
	if(!shuttle_tag) return
	var/datum/shuttle/untethered/shuttle = shuttle_controller.new_shuttles[shuttle_tag]
	var/where = input("Beakon", "Pick!") as null|anything in shuttle.dock_system.docks
	if(!where) return
	var/result = shuttle.beacon_move(shuttle.dock_system.docks[where])
	if(!result)
		result = SPAN_NOTE("Success!")
	else
		result = SPAN_WARN(result)
	usr << result

/proc/get_most_distant_object(var/list/L, var/dir = NORTH)
	if(!istype(L) || !L.len || !(dir in cardinal)) return null

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
	var/datum/dock_system/dock_system
	var/obj/dock_marker/target_dock = null
	var/obj/dock_marker/interim_dock = null //For multi-Z movement
	var/process_state = IDLE_STATE
	var/move_time = 0		//the time spent in the transition area
	var/last_dock_attempt_time = 0

/datum/shuttle/untethered/New(var/obj/shuttle_marker/Marker)
	..()
	src.my_area = get_area(Marker)
	my_area.is_shuttle = src
	src.name    = Marker.name
	shuttle_controller.new_shuttles[name] = src
	src.set_dock_system(shuttle_controller.get_dock_system(Marker.dock_system))

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

/datum/shuttle/untethered/proc/select_dock(var/name)
	target_dock = dock_system.docks[name]

/datum/shuttle/untethered/proc/get_dock_list()
	return dock_system.docks

/datum/shuttle/untethered/proc/set_dock_system(var/datum/dock_system/DS)
	if(dock_system)
		dock_system.shuttles -= src
	dock_system = DS
	dock_system.shuttles |= src

/datum/shuttle/untethered/proc/beacon_move(var/obj/dock_marker/destination, var/direction=null)

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
					M << SPAN_WARN("Sudden acceleration presses you into your chair!")
					shake_camera(M, 3, 1)
				else
					M << SPAN_WARN("The floor lurches beneath you!")
					shake_camera(M, 10, 1)
		if(istype(M, /mob/living/carbon))
			if(!M.buckled)
				M.Weaken(3)

	// Power-related checks. If shuttle contains power related machinery, update powernets.
	if(locate(/obj/machinery/power) in my_area || locate(/obj/structure/cable) in my_area)
		makepowernets()

	return


/datum/shuttle/untethered/short_jump()
	if(istype(target_dock))
		return

	if(moving_status != SHUTTLE_IDLE) return

	//it would be cool to play a sound here
	moving_status = SHUTTLE_WARMUP
	spawn(warmup_time*10)
		if (moving_status == SHUTTLE_IDLE)
			return	//someone cancelled the launch

		moving_status = SHUTTLE_INTRANSIT //shouldn't matter but just to be safe
		beacon_move(target_dock)
		moving_status = SHUTTLE_IDLE


/datum/shuttle/untethered/long_jump(var/travel_time)
	if(istype(target_dock))
		return

	if(moving_status != SHUTTLE_IDLE) return

	//it would be cool to play a sound here
	moving_status = SHUTTLE_WARMUP
	spawn(warmup_time*10)
		if (moving_status == SHUTTLE_IDLE)
			return	//someone cancelled the launch

		arrive_time = world.time + travel_time*10
		moving_status = SHUTTLE_INTRANSIT
		beacon_move(interim_dock)

		sleep(arrive_time - world.time)

		beacon_move(target_dock)
		moving_status = SHUTTLE_IDLE


/*
	Please ensure that long_jump() and short_jump() are only called from here. This applies to subtypes as well.
	Doing so will ensure that multiple jumps cannot be initiated in parallel.
*/
/datum/shuttle/untethered/proc/process()
	switch(process_state)
		if (WAIT_LAUNCH)
			if (skip_docking_checks() || docking_controller.can_launch())
				if (move_time && interim_dock)
					long_jump(move_time)
				else
					short_jump()
				process_state = WAIT_ARRIVE
		if (FORCE_LAUNCH)
			if (move_time && interim_dock)
				long_jump(move_time)
			else
				short_jump()
			process_state = WAIT_ARRIVE
		if (WAIT_ARRIVE)
			if (moving_status == SHUTTLE_IDLE)
				dock()
				process_state = WAIT_FINISH
		if (WAIT_FINISH)
			if (skip_docking_checks() || docking_controller.docked() || world.time > last_dock_attempt_time + DOCK_ATTEMPT_TIMEOUT)
				process_state = IDLE_STATE
				arrived()

/datum/shuttle/untethered/current_dock_target()
	return

/datum/shuttle/untethered/proc/launch(var/user)
	if (!can_launch()) return

	process_state = WAIT_LAUNCH
	undock()

/datum/shuttle/untethered/proc/force_launch(var/user)
	if (!can_force()) return

	process_state = FORCE_LAUNCH

/datum/shuttle/untethered/proc/cancel_launch(var/user)
	if (!can_cancel()) return

	moving_status = SHUTTLE_IDLE
	process_state = WAIT_FINISH

	if (docking_controller && !docking_controller.undocked())
		docking_controller.force_undock()

	spawn(10)
		dock()

	return

/datum/shuttle/untethered/proc/can_launch()
	if (moving_status != SHUTTLE_IDLE)
		return 0

	if (!target_dock)
		return 0

	return 1

/datum/shuttle/untethered/proc/can_force()
	if (moving_status == SHUTTLE_IDLE && process_state == WAIT_LAUNCH)
		return 1
	return 0

/datum/shuttle/untethered/proc/can_cancel()
	if (moving_status == SHUTTLE_WARMUP || process_state == WAIT_LAUNCH || process_state == FORCE_LAUNCH)
		return 1
	return 0

//returns 1 if the shuttle is getting ready to move, but is not in transit yet
/datum/shuttle/untethered/proc/is_launching()
	return (moving_status == SHUTTLE_WARMUP || process_state == WAIT_LAUNCH || process_state == FORCE_LAUNCH)

//This gets called when the shuttle finishes arriving at it's destination
//This can be used by subtypes to do things when the shuttle arrives.
/datum/shuttle/untethered/proc/arrived()
	return	//do nothing for now

