var/datum/maps_data/maps_data = new

/proc/isStationLevel(var/level)
	if(isnum(level))
		level = num2text(level)
	return level in maps_data.station_levels

/proc/isNotStationLevel(var/level)
	return !isStationLevel(level)

/proc/isOnStationLevel(var/atom/A)
	var/turf/T = get_turf(A)
	return T && isStationLevel(T.z)

/proc/isPlayerLevel(var/level)
	return level in config.player_levels

/proc/isAdminLevel(var/level)
	if(isnum(level))
		level = num2text(level)
	return level in maps_data.admin_levels

/proc/isNotAdminLevel(var/level)
	return !isAdminLevel(level)

/proc/isOnAdminLevel(var/atom/A)
	var/turf/T = get_turf(A)
	return T && isAdminLevel(T.z)

/proc/max_default_z_level()
	var/max_z = 0
	for(var/level in maps_data.all_levels)
		var/z = text2num(level)
		max_z = max(z, max_z)

	return max_z




/datum/maps_data
	var/list/all_levels     = new
	var/list/station_levels = new
	var/list/admin_levels   = new
	var/list/overmap_levels = new
	var/list/overmap_finds  = new

/datum/maps_data/proc/registrate(var/obj/map_data/MD)
	var/level = "[MD.z]"
	if(level in all_levels)
		WARNING("[level] is already in all_levels list!")
		qdel(MD)
		return

	MD.loc = null
	all_levels[level] = MD

	if(MD.is_station_level)
		station_levels[level]= MD

	if(MD.is_admin_level)
		admin_levels[level]  = MD

	if(MD.is_overmap_level)
		overmap_levels[level]= MD

	if(MD.is_overmap_finds)
		overmap_finds[level] = MD



/obj/map_data
	name = "Map data"
	var/is_admin_level   = 0
	var/is_station_level = 0
	var/is_overmap_level = 0
	var/is_overmap_finds = 0
	var/generate_asteroid= 0

/obj/map_data/station
	name = "Station Level"
	is_station_level = 1

/obj/map_data/admin
	name = "Admin Level"
	is_admin_level = 1

/obj/map_data/asteroid
	name = "Asteroid Level"
	generate_asteroid = 1

/obj/map_data/finds
	name = "Overmap finds Level"
	is_overmap_finds = 1

/obj/map_data/New()
	..()
	maps_data.registrate(src)





