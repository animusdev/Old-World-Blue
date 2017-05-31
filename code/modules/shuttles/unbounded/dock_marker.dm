/obj/dock_marker
	name = "Dock marker"
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "beacon"
	invisibility = 101
	var/dock_system = "Station"
	var/global/num = 1
	var/list/target = list(0,0,0)

/obj/dock_marker/New()
	..()
	spawn(15)
		setup()

/obj/dock_marker/verb/setup()
	set name = "Init Dock"
	set category = "Object"
	set src in view(1)

	if(name == initial(name))
		name = "[initial(name)] #[num++]"

	var/datum/dock_system/D = shuttle_controller.get_dock_system(dock_system)
	D.docks[name] = src

	var/turf/T = get_step(src, dir)
	target = list(T.x, T.y, T.z)
	loc = null

/obj/dock_marker/proc/get_target()
	return locate(target[1], target[2], target[3])

/obj/dock_marker/proc/get_docking_dir()
	return turn(dir,180)
