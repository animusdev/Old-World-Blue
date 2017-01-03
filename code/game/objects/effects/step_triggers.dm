/* Simple object type, calls a proc when "stepped" on by something */

/obj/effect/step_trigger
	var/affect_ghosts = 0
	var/stopper = 1 // stops throwers
	invisibility = 101 // nope cant see this shit
	anchored = 1

/obj/effect/step_trigger/proc/Trigger(var/atom/movable/A)
	return 0

/obj/effect/step_trigger/Crossed(H as mob|obj)
	..()
	if(!H)
		return
	if(isobserver(H) && !affect_ghosts)
		return
	Trigger(H)



/* Tosses things in a certain direction */

/obj/effect/step_trigger/thrower
	var/direction = SOUTH // the direction of throw
	var/tiles = 3	// if 0: forever until atom hits a stopper
	var/immobilize = 1 // if nonzero: prevents mobs from moving while they're being flung
	var/speed = 1	// delay of movement
	var/facedir = 0 // if 1: atom faces the direction of movement
	var/nostop = 0 // if 1: will only be stopped by teleporters
	var/list/affecting = list()

	Trigger(var/atom/A)
		if(!A || !istype(A, /atom/movable))
			return
		var/atom/movable/AM = A
		var/curtiles = 0
		var/stopthrow = 0
		for(var/obj/effect/step_trigger/thrower/T in orange(2, src))
			if(AM in T.affecting)
				return

		if(ismob(AM))
			var/mob/M = AM
			if(immobilize)
				M.canmove = 0

		affecting.Add(AM)
		while(AM && !stopthrow)
			if(tiles)
				if(curtiles >= tiles)
					break
			if(AM.z != src.z)
				break

			curtiles++

			sleep(speed)

			// Calculate if we should stop the process
			if(!nostop)
				for(var/obj/effect/step_trigger/T in get_step(AM, direction))
					if(T.stopper && T != src)
						stopthrow = 1
			else
				for(var/obj/effect/step_trigger/teleporter/T in get_step(AM, direction))
					if(T.stopper)
						stopthrow = 1

			if(AM)
				var/predir = AM.dir
				step(AM, direction)
				if(!facedir)
					AM.set_dir(predir)



		affecting.Remove(AM)

		if(ismob(AM))
			var/mob/M = AM
			if(immobilize)
				M.canmove = 1

/* Stops things thrown by a thrower, doesn't do anything */

/obj/effect/step_trigger/stopper

/* Instant teleporter */

/obj/effect/step_trigger/teleporter
	var/teleport_x = 0	// teleportation coordinates (if one is null, then no teleport!)
	var/teleport_y = 0
	var/teleport_z = 0

	Trigger(var/atom/movable/A)
		if(teleport_x && teleport_y && teleport_z)

			A.x = teleport_x
			A.y = teleport_y
			A.z = teleport_z

/* Random teleporter, teleports atoms to locations ranging from teleport_x - teleport_x_offset, etc */

/obj/effect/step_trigger/teleporter/random
	var/teleport_x_offset = 0
	var/teleport_y_offset = 0
	var/teleport_z_offset = 0

	Trigger(var/atom/movable/A)
		if(teleport_x && teleport_y && teleport_z)
			if(teleport_x_offset && teleport_y_offset && teleport_z_offset)

				A.x = rand(teleport_x, teleport_x_offset)
				A.y = rand(teleport_y, teleport_y_offset)
				A.z = rand(teleport_z, teleport_z_offset)


/obj/effect/step_trigger/edge_teleporter
	affect_ghosts = 1

/obj/effect/step_trigger/edge_teleporter/Trigger(var/atom/movable/A)
	if(ticker && ticker.mode)

		if(istype(A, /obj/effect/meteor)||istype(A, /obj/effect/space_dust))
			qdel(A)
			return

		if(istype(A, /obj/item/weapon/disk/nuclear)) // Don't let nuke disks travel Z levels  ... And moving this shit down here so it only fires when they're actually trying to change z-level.
			qdel(A) //The disk's Destroy() proc ensures a new one is created
			return
		if(config.use_overmap)
			overmap_spacetravel(src,A)
			return
		var/list/disk_search = A.search_contents_for(/obj/item/weapon/disk/nuclear)
		if(!isemptylist(disk_search))
			if(istype(A, /mob/living))
				var/mob/living/MM = A
				if(MM.client && !MM.stat)
					MM << "\red Something you are carrying is preventing you from leaving. Don't play stupid; you know exactly what it is."
					if(MM.x <= TRANSITIONEDGE)
						MM.inertia_dir = 4
					else if(MM.x >= world.maxx -TRANSITIONEDGE)
						MM.inertia_dir = 8
					else if(MM.y <= TRANSITIONEDGE)
						MM.inertia_dir = 1
					else if(MM.y >= world.maxy -TRANSITIONEDGE)
						MM.inertia_dir = 2
				else
					for(var/obj/item/weapon/disk/nuclear/N in disk_search)
						qdel(N)//Make the disk respawn it is on a clientless mob or corpse
			else
				for(var/obj/item/weapon/disk/nuclear/N in disk_search)
					qdel(N)//Make the disk respawn if it is floating on its own
			return

		var/move_to_z = text2num(pickweight(accessible_z_levels - "[src.z]"))

		if(!move_to_z)
			return

		A.z = move_to_z

		if(src.x <= TRANSITIONEDGE)
			A.x = world.maxx - TRANSITIONEDGE - 2
			A.y = rand(TRANSITIONEDGE + 2, world.maxy - TRANSITIONEDGE - 2)

		else if (src.x >= (world.maxx - TRANSITIONEDGE + 1))
			A.x = TRANSITIONEDGE + 1
			A.y = rand(TRANSITIONEDGE + 2, world.maxy - TRANSITIONEDGE - 2)

		else if (src.y <= TRANSITIONEDGE)
			A.y = world.maxy - TRANSITIONEDGE -2
			A.x = rand(TRANSITIONEDGE + 2, world.maxx - TRANSITIONEDGE - 2)

		else if (src.y >= (world.maxy - TRANSITIONEDGE + 1))
			A.y = TRANSITIONEDGE + 1
			A.x = rand(TRANSITIONEDGE + 2, world.maxx - TRANSITIONEDGE - 2)


		spawn (0)
			if(A && A.loc)
				A.loc.Entered(A)
