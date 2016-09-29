//////////////////////////////
//Contents: Ladders, Stairs.//
//////////////////////////////

/obj/structure/ladder
	name = "ladder"
	desc = "A ladder.  You can climb it up and down."
	icon_state = "ladder01"
	icon = 'icons/obj/structures.dmi'
	density = 0
	opacity = 0
	anchored = 1

	var/obj/structure/ladder/target

	initialize()
		// the upper will connect to the lower
		if(icon_state == "ladder00")
			return

		for(var/obj/structure/ladder/L in GetBelow(src))
			if(L.icon_state == "ladder00")
				target = L
				L.target = src
				return

	Destroy()
		if(target && icon_state == "ladder01")
			qdel(target)
		return ..()

	attackby(obj/item/C as obj, mob/user as mob)
		. = ..()
		attack_hand(user)
		return

	attack_hand(var/mob/M)
		if(!target || !istype(target.loc, /turf))
			M << "<span class='notice'>\The [src] is incomplete and can't be climbed.</span>"
			return

		var/turf/T = target.loc
		for(var/atom/A in T)
			if(A.density)
				M << "<span class='notice'>\A [A] is blocking \the [src].</span>"
				return

		M.visible_message("<span class='notice'>\A [M] climbs [icon_state == "ladderup" ? "up" : "down"] \a [src]!</span>",
			"You climb [icon_state == "ladderup"  ? "up" : "down"] \the [src]!",
			"You hear the grunting and clanging of a metal ladder being used.")
		M.Move(T)

	CanPass(obj/mover, turf/source, height, airflow)
		return airflow || !density

// The storage of connections between adjacent levels means some bitwise magic is needed.
var/z_levels = 0

proc/HasAbove(var/z)
	if(z >= world.maxz || z > 16 || z < 1)
		return 0
	return z_levels & (1 << (z - 1))

proc/HasBelow(var/z)
	if(z > world.maxz || z > 17 || z < 2)
		return 0
	return z_levels & (1 << (z - 2))

// Thankfully, no bitwise magic is needed here.
proc/GetAbove(var/atom/atom)
	var/turf/turf = get_turf(atom)
	if(!turf)
		return null
	return HasAbove(turf.z) ? get_step(turf, UP) : null

proc/GetBelow(var/atom/atom)
	var/turf/turf = get_turf(atom)
	if(!turf)
		return null
	return HasBelow(turf.z) ? get_step(turf, DOWN) : null
