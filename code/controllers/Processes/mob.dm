/datum/controller/process/mob/setup()
	name = "mob"
	schedule_interval = 20 // every 2 seconds

/datum/controller/process/mob/started()
	..()
	if(!mob_list)
		mob_list = list()

/datum/controller/process/mob/doWork()
	for(last_object in mob_list)
		var/mob/M = last_object
		if(istype(M) && isnull(M.gcDestroyed))
			M.Life()

/datum/controller/process/mob/getStatName()
	return ..()+"([mob_list.len])"
