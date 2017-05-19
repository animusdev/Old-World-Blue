var/datum/maps_data/maps_data = new

/proc/isStationLevel(var/level)
	return level in maps_data.station_levels

/proc/isNotStationLevel(var/level)
	return !isStationLevel(level)

/proc/isOnStationLevel(var/atom/A)
	var/turf/T = get_turf(A)
	return T && isStationLevel(T.z)

/proc/isPlayerLevel(var/level)
	return level in maps_data.player_levels

/proc/isOnPlayerLevel(var/atom/A)
	var/turf/T = get_turf(A)
	return T && isPlayerLevel(T.z)

/proc/isAdminLevel(var/level)
	return level in maps_data.admin_levels

/proc/isNotAdminLevel(var/level)
	return !isAdminLevel(level)

/proc/isOnAdminLevel(var/atom/A)
	var/turf/T = get_turf(A)
	return T && isAdminLevel(T.z)

/proc/max_default_z_level()
	return maps_data.all_levels.len

/client/proc/test_MD()
	set name = "Test Map Markers"
	set category = "Debug"

	mob << "isStationLevel: [isStationLevel(mob.z)]"
	mob << "isNotStationLevel: [isNotStationLevel(mob.z)]"
	mob << "isOnStationLevel: [isOnStationLevel(mob)]"

	mob << "isPlayerLevel: [isPlayerLevel(mob.z)]"
	mob << "isOnPlayerLevel: [isOnPlayerLevel(mob)]"

	mob << "isAdminLevel: [isAdminLevel(mob.z)]"
	mob << "isNotAdminLevel: [isNotAdminLevel(mob.z)]"
	mob << "isOnAdminLevel: [isOnAdminLevel(mob)]"

/datum/maps_data
	var/list/all_levels     = new
	var/list/station_levels = new
	var/list/admin_levels   = new
	var/list/player_levels  = new
	var/list/overmap_levels = new
	var/list/overmap_finds  = new
	var/list/asteroid_leves = new

/datum/maps_data/proc/registrate(var/obj/map_data/MD)
	var/level = MD.z_level
	if(level in all_levels)
		WARNING("[level] is already in all_levels list!")
		qdel(MD)
		return

	MD.loc = null
	if(all_levels.len < level)
		all_levels.len = level
	all_levels[level] = MD

	if(MD.is_station_level)
		station_levels += level

	if(MD.is_admin_level)
		admin_levels += level

	if(MD.is_player_level)
		player_levels += level

	if(MD.is_overmap_level)
		overmap_levels += level

	if(MD.is_overmap_finds)
		overmap_finds += level

	if(MD.generate_asteroid)
		asteroid_leves += level



/obj/map_data
	name = "Map data"
	var/is_admin_level   = 0 // Defines which Z-levels which are for admin functionality, for example including such areas as Central Command and the Syndicate Shuttle
	var/is_station_level = 0 // Defines Z-levels on which the station exists.
	var/is_player_level  = 0 // Defines Z-levels a character can typically reach
	var/is_overmap_level = 0
	var/is_overmap_finds = 0
	var/generate_asteroid= 0
	var/tmp/z_level

/obj/map_data/station
	name = "Station Level"
	is_station_level = 1
	is_player_level = 1

/obj/map_data/admin
	name = "Admin Level"
	is_admin_level = 1

/obj/map_data/asteroid
	name = "Asteroid Level"
	is_player_level = 1
	generate_asteroid = 1

/obj/map_data/finds
	name = "Overmap finds Level"
	is_overmap_finds = 1
	is_player_level = 1

/obj/map_data/New()
	..()
	z_level = z
	spawn()
		maps_data.registrate(src)





