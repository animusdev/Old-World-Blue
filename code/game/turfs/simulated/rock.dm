/turf/simulated/rock
	name = "Rock"
	icon = 'icons/turf/rock_wall.dmi'
	icon_state = "rock_wall4"
	oxygen = 0
	nitrogen = 0
	opacity = 1
	density = 1
	blocks_air = 1
	temperature = T0C

/turf/simulated/floor/rock
	name = "rocky floor"
	icon = 'icons/turf/rock_floor.dmi'

/turf/simulated/floor/rock/is_plating()
	return 1

/turf/simulated/floor/rock/airless
	name = "airless rocky floor"
	oxygen = 0
	nitrogen = 0
	temperature = TCMB

	New()
		..()
		name = replacetext(name, "airless ", null)

/turf/simulated/floor/rock/underwather
	icon = 'icons/turf/rock_underwater.dmi'
