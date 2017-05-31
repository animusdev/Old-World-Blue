/datum/shuttle_controller
	var/list/dock_systems = list()

/datum/dock_system
	var/id = null
	var/list/shuttles = list()
	var/list/docks = list()

/datum/dock_system/New(var/name)
	id = name

/datum/shuttle_controller/proc/get_dock_system(name)
	var/datum/dock_system/D
	for(D in dock_systems)
		if(D.id == name)
			return D
	D = new(name)
	dock_systems += D

	return D
