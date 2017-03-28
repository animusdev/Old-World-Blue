//// Variables ////
/datum/preferences
	var/high_job_title = ""

		//Jobs, uses bitflags
	var/job_civilian_high = 0
	var/job_civilian_med = 0
	var/job_civilian_low = 0

	var/job_medsci_high = 0
	var/job_medsci_med = 0
	var/job_medsci_low = 0

	var/job_engsec_high = 0
	var/job_engsec_med = 0
	var/job_engsec_low = 0

	//Keeps track of preferrence for not getting any wanted jobs
	var/alternate_option = 0

	var/list/player_alt_titles = new()		// the default name of a job like "Medical Doctor"


//// PAGE GENERATION ////

/datum/preferences/proc/GetOccupationPage()
	if(!job_master)
		return

	//limit     - The amount of jobs allowed per column. Defaults to 17 to make it look nice.
	//splitJobs - Allows you split the table by job. You can make different tables for each department by including their heads. Defaults to CE to make it look nice.
	var/limit = 17
	var/list/splitJobs = list("Chief Medical Officer")
	var/datum/job/lastJob


	var/dat = "<style>td.job{text-align:right; width:60%}</style><tt><center>"
	dat += "<b>Choose occupation chances</b><br>Unavailable occupations are crossed out.<br>"
	dat += "<table width='100%' cellpadding='1' cellspacing='0'><tr><td width='20%'>" // Table within a table for alignment, also allows you to easily add more colomns.
	dat += "<table width='100%' cellpadding='1' cellspacing='0'>"
	var/index = -1

	//The job before the current job. I only use this to get the previous jobs color when I'm filling in blank rows.
	if (!job_master)		return
	var/mob/user = usr
	for(var/datum/job/job in job_master.occupations)
		index += 1
		if((index >= limit) || (job.title in splitJobs))
			if((index < limit) && (lastJob != null))
				//If the cells were broken up by a job in the splitJob list then it will fill in the rest of the cells with
				//the last job's selection color. Creating a rather nice effect.
				for(var/i = 0, i < (limit - index), i += 1)
					dat += "<tr bgcolor='[lastJob.selection_color]'><td width='60%' align='right'><a>&nbsp</a></td><td><a>&nbsp</a></td></tr>"

			dat += "</table></td><td width='20%'><table width='100%' cellpadding='1' cellspacing='0'>"
			index = 0

		dat += "<tr bgcolor='[job.selection_color]'><td class='job'>"
		var/rank = job.title
		lastJob = job
		var/job_name = rank
		if(job.alt_titles)
			job_name = "<a href=\"?src=\ref[src];act=alt_title;job=\ref[job]\">\[[GetPlayerAltTitle(job)]\]</a>"
		if(jobban_isbanned(user, rank))
			dat += "<del>[job_name]</del></td><td><b> \[BANNED]</b></td></tr>"
			continue
		if(job.minimum_character_age && (user.client.prefs.age < job.minimum_character_age))
			dat += "<del>[job_name]</del></td><td><b> \[MIN AGE [job.minimum_character_age]]</b></td></tr>"
			continue
		if(!job.player_old_enough(user.client))
			var/available_in_days = job.available_in_days(user.client)
			dat += "<del>[job_name]</del></td><td> \[IN [(available_in_days)] DAYS]</td></tr>"
			continue
		if((job_civilian_low & ASSISTANT) && (rank != "Assistant"))
			dat += "<font color=orange>[job_name]</font></td><td>\[NEVER]</td></tr>"
			continue
		if((rank in command_positions) || (rank == "AI"))//Bold head jobs
			dat += "<b>[job_name]</b>"
		else
			dat += "[job_name]"

		dat += "</td><td width='40%'>"

		dat += "<a href='?src=\ref[src];act=input;text=[rank]'>"

		if(rank == "Assistant")//Assistant is special
			if(job_civilian_low & ASSISTANT)
				dat += " <font color=green>\[Yes]</font>"
			else
				dat += " <font color=red>\[No]</font>"
			dat += "</a></td></tr>"
			continue

		if(GetJobDepartment(job, 1) & job.flag)
			dat += " <font color=blue>\[High]</font>"
		else if(GetJobDepartment(job, 2) & job.flag)
			dat += " <font color=green>\[Medium]</font>"
		else if(GetJobDepartment(job, 3) & job.flag)
			dat += " <font color=orange>\[Low]</font>"
		else
			dat += " <font color=red>\[NEVER]</font>"
		dat += "</a></td></tr>"

	dat += "</table></td></tr>"

	dat += "</table>"

	switch(alternate_option)
		if(GET_RANDOM_JOB)
			dat += "<br><u><a href='?src=\ref[src];act=random'>\
				<font color=green>Get random job if preferences unavailable</font></a></u><br>"
		if(BE_ASSISTANT)
			dat += "<br><u><a href='?src=\ref[src];act=random'>\
				<font color=red>Be assistant if preference unavailable</font></a></u><br>"
		if(RETURN_TO_LOBBY)
			dat += "<br><u><a href='?src=\ref[src];act=random'>\
				<font color=purple>Return to lobby if preference unavailable</font></a></u><br>"

	dat += "<a href='?src=\ref[src];act=reset'>\[Reset\]</a>"
	dat += "</center></tt>"

	return dat

//// TOPIC ////

/datum/preferences/proc/HandleOccupationTopic(mob/user, list/href_list)
	switch(href_list["act"])
		if("random")
			if(alternate_option == GET_RANDOM_JOB || alternate_option == BE_ASSISTANT)
				alternate_option += 1
			else if(alternate_option == RETURN_TO_LOBBY)
				alternate_option = 0
		if ("alt_title")
			var/datum/job/job = locate(href_list["job"])
			if (job)
				var/choices = list(job.title) + job.alt_titles
				var/choice = input("Pick a title for [job.title].", "Character Generation", GetPlayerAltTitle(job)) as anything in choices | null
				if(choice)
					SetPlayerAltTitle(job, choice)
		if("input")
			SetJob(user, href_list["text"])
		if("reset")
			ResetJobs()

//// HELPER FUNCTIONS ////

/datum/preferences/proc/GetPlayerAltTitle(datum/job/job)
	return player_alt_titles.Find(job.title) > 0 \
		? player_alt_titles[job.title] \
		: job.title

/datum/preferences/proc/SetPlayerAltTitle(datum/job/job, new_title)
	// remove existing entry
	if(player_alt_titles.Find(job.title))
		player_alt_titles -= job.title
	// add one if it's not default
	if(job.title != new_title)
		player_alt_titles[job.title] = new_title

/datum/preferences/proc/SetJob(mob/user, role)
	var/datum/job/job = job_master.GetJob(role)
	if(!job)
		return

	if(role == "Assistant")
		if(job_civilian_low & job.flag)
			job_civilian_low &= ~job.flag
		else
			job_civilian_low |= job.flag
		return 1

	if(GetJobDepartment(job, 1) & job.flag)
		SetJobDepartment(job, 1)
	else if(GetJobDepartment(job, 2) & job.flag)
		SetJobDepartment(job, 2)
	else if(GetJobDepartment(job, 3) & job.flag)
		SetJobDepartment(job, 3)
	else//job = Never
		SetJobDepartment(job, 4)
	return 1

/datum/preferences/proc/ResetJobs()
	job_civilian_high = 0
	job_civilian_med = 0
	job_civilian_low = 0

	job_medsci_high = 0
	job_medsci_med = 0
	job_medsci_low = 0

	job_engsec_high = 0
	job_engsec_med = 0
	job_engsec_low = 0


/datum/preferences/proc/GetJobDepartment(var/datum/job/job, var/level)
	if(!job || !level)	return 0
	switch(job.department_flag)
		if(CIVILIAN)
			switch(level)
				if(1)
					return job_civilian_high
				if(2)
					return job_civilian_med
				if(3)
					return job_civilian_low
		if(MEDSCI)
			switch(level)
				if(1)
					return job_medsci_high
				if(2)
					return job_medsci_med
				if(3)
					return job_medsci_low
		if(ENGSEC)
			switch(level)
				if(1)
					return job_engsec_high
				if(2)
					return job_engsec_med
				if(3)
					return job_engsec_low
	return 0

/datum/preferences/proc/SetJobDepartment(var/datum/job/job, var/level)
	if(!job || !level)	return 0
	switch(level)
		if(1)//Only one of these should ever be active at once so clear them all here
			job_civilian_high = 0
			job_medsci_high = 0
			job_engsec_high = 0
			req_update_icon = 1
			high_job_title = ""
			return 1
		if(2)//Set current highs to med, then reset them
			job_civilian_med |= job_civilian_high
			job_medsci_med |= job_medsci_high
			job_engsec_med |= job_engsec_high
			job_civilian_high = 0
			job_medsci_high = 0
			job_engsec_high = 0
			req_update_icon = 1
			high_job_title = job.title

	switch(job.department_flag)
		if(CIVILIAN)
			switch(level)
				if(2)
					job_civilian_high = job.flag
					job_civilian_med &= ~job.flag
				if(3)
					job_civilian_med |= job.flag
					job_civilian_low &= ~job.flag
				else
					job_civilian_low |= job.flag
		if(MEDSCI)
			switch(level)
				if(2)
					job_medsci_high = job.flag
					job_medsci_med &= ~job.flag
				if(3)
					job_medsci_med |= job.flag
					job_medsci_low &= ~job.flag
				else
					job_medsci_low |= job.flag
		if(ENGSEC)
			switch(level)
				if(2)
					job_engsec_high = job.flag
					job_engsec_med &= ~job.flag
				if(3)
					job_engsec_med |= job.flag
					job_engsec_low &= ~job.flag
				else
					job_engsec_low |= job.flag
	return 1

