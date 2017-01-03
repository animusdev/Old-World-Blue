/obj/corner
	name = "wall"
	anchored = 1
	density = 1

/area/proc/shift_contents(var/list/Shift, var/turftoleave=null, var/direction = null)

	if(!Shift || !src) return 0

	var/list/turfs_src = get_area_turfs(src.type)

	var/turf/target = null
	for (var/turf/T in turfs_src)
		target = locate(T.x-Shift[1], T.y-Shift[2], T.z-Shift[3])
		target = target.ChangeTurf(T.type)
		target.set_dir(T.dir)
		target.icon_state = T.icon_state
		target.icon = T.icon
		target.overlays = T.overlays.Copy()
		target.underlays = T.underlays.Copy()

		var/turf/simulated/ST = T
		if(istype(ST) && ST.zone)
			var/turf/simulated/SX = target
			if(!SX.air)
				SX.make_air()
			SX.air.copy_from(ST.zone.air)
			ST.zone.remove(ST)

		/* Quick visual fix for some weird shuttle corner artefacts when on transit space tiles */
		if(direction && findtext(target.icon_state, "swall_s"))

			// Spawn a new shuttle corner object
			var/obj/corner/C = new(target)
			C.icon = target.icon
			C.icon_state = replacetext(target.icon_state, "_s", "_f")
			C.tag = "delete me"

			// Find a new turf to take on the property of
			var/turf/nextturf = get_step(C, direction)
			if(!nextturf || !istype(nextturf, /turf/space))
				nextturf = get_step(C, turn(direction, 180))

			// Take on the icon of a neighboring scrolling space icon
			target.icon = nextturf.icon
			target.icon_state = nextturf.icon_state


		for(var/obj/O in T)

			// Reset the shuttle corners
			if(O.tag == "delete me")
				target.icon = 'icons/turf/shuttle.dmi'
				target.icon_state = replacetext(O.icon_state, "_f", "_s") // revert the turf to the old icon_state
				target.name = "wall"
				qdel(O) // prevents multiple shuttle corners from stacking
				continue
			if(!istype(O,/obj)) continue
			O.loc = target
		for(var/mob/M in T)
			// If we need to check for more mobs, I'll add a variable
			if(!istype(M,/mob)) continue
			M.loc = target

		if(turftoleave)
			T.ChangeTurf(turftoleave)
		else
			T.ChangeTurf(/turf/space)

		new T.loc.type (target)
		new world.area (T)
