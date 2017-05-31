/obj/shuttle_marker
	name = "Shuttle Marker"
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "marker"
	var/list/dock_system = "Station"

/obj/shuttle_marker/New()
	spawn(15)
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
		qdel(src)

