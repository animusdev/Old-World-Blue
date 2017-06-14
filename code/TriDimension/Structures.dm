///////////////////////////////////////
//Contents: Ladders, Hatches, Stairs.//
///////////////////////////////////////

/obj/multiz
	icon = 'icons/obj/structures.dmi'
	density = 0
	opacity = 0
	anchored = 1

	CanPass(obj/mover, turf/source, height, airflow)
		return airflow || !density

/obj/multiz/ladder
	icon_state = "ladderdown"
	name = "ladder"
	desc = "A ladder.  You climb up and down it."

	var/d_state = 1
	var/obj/multiz/target

	proc/connect()
		if(icon_state == "ladderdown") // the upper will connect to the lower
			d_state = 1
			var/turf/controllerlocation = locate(1, 1, z)
			for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
				if(controller.down)
					var/turf/below = locate(src.x, src.y, controller.down_target)
					for(var/obj/multiz/ladder/L in below)
						if(L.icon_state == "ladderup")
							target = L
							L.target = src
							d_state = 0
							break
		return

	Destroy()
		spawn(1)
			if(target && icon_state == "ladderdown")
				qdel(target)
		return ..()

	attack_hand(var/mob/M)
		if(!target || !istype(target.loc, /turf))
			M << "The ladder is incomplete and can't be climbed."
		else
			var/turf/T = target.loc
			var/blocked = 0
			for(var/atom/A in T.contents)
				if(A.density)
					blocked = 1
					break
			if(blocked || istype(T, /turf/simulated/wall))
				M << "Something is blocking the ladder."
			else
				M.visible_message(
					"\blue \The [M] climbs [src.icon_state == "ladderup" ? "up" : "down"] \the [src]!",
					"You climb [src.icon_state == "ladderup"  ? "up" : "down"] \the [src]!",
					"You hear some grunting, and clanging of a metal ladder being used."
				)
				M.Move(target.loc)

/obj/multiz/stairs
	name = "Stairs"
	desc = "Stairs.  You walk up and down them."
	icon_state = "rampbottom"
	var/obj/multiz/stairs/connected
	var/turf/target
	var/turf/target2
	var/suggest_dir // try this dir first when finding stairs; this is the direction to walk *down* the stairs

	New()
		..()
		var/turf/cl= locate(1, 1, src.z)
		for(var/obj/effect/landmark/zcontroller/c in cl)
			if(c.up)
				var/turf/O = locate(src.x, src.y, c.up_target)
				if(istype(O, /turf/space))
					O.ChangeTurf(/turf/simulated/floor/open)

		spawn(1)
			var/turf/T
			if(suggest_dir)
				T = get_step(src.loc,suggest_dir)
				find_stair_connection(T, suggest_dir, 1)
			if(!target)
				for(var/dir in cardinal)
					T = get_step(src.loc,dir)
					find_stair_connection(T, dir)
					if(target)
						break

	Bumped(var/atom/movable/M)
		if(connected && target && istype(src, /obj/multiz/stairs) && locate(/obj/multiz/stairs) in M.loc)
			var/obj/multiz/stairs/Con = locate(/obj/multiz/stairs) in M.loc
			if(Con == src.connected) //make sure the atom enters from the approriate lower stairs tile
				M.Move(target)
		return

	proc/find_stair_connection(var/turf/T, var/dir, var/suggested=0)
		for(var/obj/multiz/stairs/S in T)
			if(S && S.icon_state == "rampbottom" && !S.connected)
				if(!S.suggest_dir || S.suggest_dir == dir) // it doesn't have a suggested direction, or it's the same direction as we're trying, so we connect to it
					initialise_stair_connection(src, S, dir)
				else if(!suggested) // we're trying directions, so it could be a reverse stair (i.e. we're the bottom stair rather than the top)
					var/inv_dir = 0
					switch(dir)
						if(1)
							inv_dir = 2
						if(2)
							inv_dir = 1
						if(4)
							inv_dir = 8
						if(8)
							inv_dir = 4
					if(S.suggest_dir == inv_dir)
						initialise_stair_connection(S, src, inv_dir)

	proc/initialise_stair_connection(var/obj/multiz/stairs/top, var/obj/multiz/stairs/bottom, var/dir)
		top.set_dir(dir)
		bottom.set_dir(dir)
		top.connected = bottom
		bottom.connected = top
		top.icon_state = "ramptop"
		top.density = 1
		var/turf/controllerlocation = locate(1, 1, top.z)
		for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
			if(controller.up)
				var/turf/above = locate(top.x, top.y, controller.up_target)
				if(istype(above,/turf/space) || istype(above,/turf/simulated/floor/open))
					top.target = above
				var/turf/above2 = locate(bottom.x, bottom.y, controller.up_target)
				if(istype(above2, /turf/space) || istype(above,/turf/simulated/floor/open))
					top.target2 = above2
		return