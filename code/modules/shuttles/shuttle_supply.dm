/datum/shuttle/ferry/supply
	var/away_location = 1	//the location to hide at while pretending to be in-transit
	var/late_chance = 80
	var/max_late_time = 300

/datum/shuttle/ferry/supply/short_jump(var/area/origin,var/area/destination)
	// If canceled or already start.
	if(moving_status != SHUTTLE_IDLE || moving_status == SHUTTLE_WARMUP) return

	//it would be cool to play a sound here
	moving_status = SHUTTLE_WARMUP
	spawn(warmup_time*10)
		//
		if (moving_status == SHUTTLE_IDLE)
			return	//someone cancelled the launch
		var/stat_at_station = at_station()
		if (stat_at_station)
			if(forbidden_atoms_check())
				//cancel the launch because of forbidden atoms. announce over supply channel?
				moving_status = SHUTTLE_IDLE
				return

		else	//at centcom
			supply_controller.buy()

		//We pretend it's a long_jump by making the shuttle stay at centcom for the "in-transit" period.
		moving_status = SHUTTLE_INTRANSIT

		if(stat_at_station)
			move(area_station, area_offsite)

		//wait ETA here.
		arrive_time = world.time + supply_controller.movetime
		while (world.time <= arrive_time)
			sleep(5)

		if(!stat_at_station)
			//late
			if (prob(late_chance))
				sleep(rand(0,max_late_time))

			move(area_offsite, area_station)

		moving_status = SHUTTLE_IDLE

		if (stat_at_station)
			supply_controller.sell()

// returns 1 if the supply shuttle should be prevented from moving because it contains forbidden atoms
/datum/shuttle/ferry/supply/proc/forbidden_atoms_check()
	if (!at_station())
		return 0	//if badmins want to send mobs or a nuke on the supply shuttle from centcom we don't care

	return supply_controller.forbidden_atoms_check(get_location_area())

/datum/shuttle/ferry/supply/proc/at_station()
	return (!location)

//returns 1 if the shuttle is idle and we can still mess with the cargo shopping list
/datum/shuttle/ferry/supply/proc/idle()
	return (moving_status == SHUTTLE_IDLE)

//returns the ETA in minutes
/datum/shuttle/ferry/supply/proc/eta_minutes()
	var/ticksleft = arrive_time - world.time
	return round(ticksleft/600,1)
