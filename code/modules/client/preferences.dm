//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:33

var/list/preferences_datums = list()

var/global/list/special_roles = list( //keep synced with the defines BE_* in setup.dm --rastaf
//some autodetection here.
// TODO: Update to new antagonist system.
	"traitor" = IS_MODE_COMPILED("traitor"),             // 0
	"operative" = IS_MODE_COMPILED("nuclear"),           // 1
	"changeling" = IS_MODE_COMPILED("changeling"),       // 2
	"wizard" = IS_MODE_COMPILED("wizard"),               // 3
	"malf AI" = IS_MODE_COMPILED("malfunction"),         // 4
	"revolutionary" = IS_MODE_COMPILED("revolution"),    // 5
	"alien candidate" = 1, //always show                 // 6
	"positronic brain" = 1,                              // 7
	"cultist" = IS_MODE_COMPILED("cult"),                // 8
	"ninja" = "true",                                    // 9
	"raider" = IS_MODE_COMPILED("heist"),                // 10
	"diona" = 1,                                         // 11
	"loyalist" = IS_MODE_COMPILED("revolution"),         // 12
	"pAI candidate" = 1, // -- TLE                       // 13
)

//used for alternate_option
#define GET_RANDOM_JOB 0
#define BE_ASSISTANT 1
#define RETURN_TO_LOBBY 2

/datum/preferences
	//doohickeys for savefiles
	var/path
	var/default_slot = 1				//Holder so it doesn't default to slot 1, rather the last one used
	var/savefile_version = 0

	//non-preference stuff
	var/warns = 0
	var/muted = 0
	var/last_ip
	var/last_id

	//game-preferences
	var/lastchangelog = ""				//Saved changlog filesize to detect if there was a change
	var/ooccolor = "#010000"			//Whatever this is set to acts as 'reset' color and is thus unusable as an actual custom color
	var/be_special = 0					//Special role selection
	var/UI_style = "Midnight"
	var/toggles = TOGGLES_DEFAULT
	var/chat_toggles = CHAT_TOGGLES_DEFAULT
	var/UI_style_color = "#ffffff"
	var/UI_style_alpha = 255

	//character preferences
	var/real_name						//our character's name
	var/random_name = 0					//whether we are a random name every round
	var/gender = MALE					//gender of character (well duh)
	var/age = 30						//age of character
	var/spawnpoint = "Arrivals Shuttle" //where this character will spawn (0-2).
	var/b_type = "A+"					//blood type (not-chooseable)
	var/underwear = "None"				//underwear type
	var/undershirt = "None"				//undershirt type
	var/socks = "None"					//socks type
	var/backbag = 2						//backpack type
	var/h_style = "Bald"				//Hair type
	var/f_style = "Shaved"				//Face hair type
	var/s_tone = 0						//Skin tone
	var/species = "Human"				//Species name for save file
	var/datum/species/current_species	//Species datum to use
	var/body = "Default"
	var/species_preview                 //Used for the species selection window.
	var/language = "None"				//Secondary language
	var/list/gear						//Custom/fluff item loadout.

		//Some faction information.
	var/home_system = "Unset"           //System of birth.
	var/citizenship = "None"            //Current home system.
	var/faction = "None"                //Antag faction/general associated faction.
	var/religion = "None"               //Religious association.

		//Mob preview
	var/icon/preview_icon = null
	var/icon/preview_icon_front = null
	var/icon/preview_icon_side = null

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


	// maps each organ to either null(intact), "cyborg" or "amputated"
	// will probably not be able to do this for head and torso ;)
	var/list/organ_data = list()
	var/list/rlimb_data = list()
	var/list/tattoo_data = list()
	var/list/player_alt_titles = new()		// the default name of a job like "Medical Doctor"

	var/list/flavor_texts = list()
	var/list/flavour_texts_robot = list()

	var/med_record = ""
	var/sec_record = ""
	var/gen_record = ""
	var/exploit_record = ""
	var/disabilities = 0

	var/nanotrasen_relation = "Neutral"

	var/uplinklocation = "PDA"

	var/slot_name = ""

/datum/preferences/New(client/C)
	b_type = pick(4;"O-", 36;"O+", 3;"A-", 28;"A+", 1;"B-", 20;"B+", 1;"AB-", 5;"AB+")
	if(istype(C))
		if(!IsGuestKey(C.key))
			load_path(C.ckey)
			if(load_preferences())
				if(load_character())
					return
	gender = pick(MALE, FEMALE)
	real_name = random_name(gender,species)
	current_species = all_species["Human"]
	sanitize_body_build()
	h_style = random_hair_style(gender, species)
	gear = list()

/datum/preferences/proc/IsJobRestricted(rank)
	var/datum/species/PS = all_species[species]
	if(rank in PS.restricted_jobs) return 1
	return 0

/datum/preferences/proc/ShowChoices(mob/user)
	if(!user || !user.client)	return
	req_update_icon = 1 // For synchronization with new menu.
	update_preview_icon()
	if(preview_icon_front && preview_icon_side)
		user << browse_rsc(preview_icon_front, "previewicon.png")
		user << browse_rsc(preview_icon_side, "previewicon2.png")
	var/dat = "<html><body><center>"

	if(path)
		dat += "<center>"
		dat += "<a href=\"?src=\ref[src];preference=open_load_dialog\">Load Setup</a> | "
		dat += "<a href=\"?src=\ref[src];preference=reload\">Reload Setup</a> | "
		dat += "<a href=\"?src=\ref[src];preference=open_save_dialog\">Save Setup</a>"
		dat += "</center>"

	else
		dat += "Please create an account to save your preferences."

	dat += "</center><hr><table><tr><td width='340px' height='320px'>"

	dat += "<b>Name:</b> "
	dat += "<a href='?src=\ref[src];preference=name;task=input'><b>[real_name]</b></a><br>"
	dat += "(<a href='?src=\ref[src];preference=name;task=random'>Random Name</A>) "
	dat += "(<a href='?src=\ref[src];preference=name'>Always Random Name: [random_name ? "Yes" : "No"]</a>)"
	dat += "<br>"

	dat += "<b>Gender:</b> <a href='?src=\ref[src];preference=gender'><b>[gender == MALE ? "Male" : "Female"]</b></a><br>"
	dat += "<b>Body build:</b> <a href='?src=\ref[src];preference=build'><b>[body]</b></a><br>"
	dat += "<b>Age:</b> <a href='?src=\ref[src];preference=age;task=input'>[age]</a><br>"
	dat += "<b>Spawn Point</b>: <a href='?src=\ref[src];preference=spawnpoint;task=input'>[spawnpoint]</a>"

	dat += "<br>"
	dat += "<b>UI Style:</b> <a href='?src=\ref[src];preference=ui'><b>[UI_style]</b></a><br>"
	dat += "<b>Custom UI</b>(recommended for White UI):<br>"
	dat += "-Color: <a href='?src=\ref[src];preference=UIcolor'><b>[UI_style_color]</b></a> <table style='display:inline;' bgcolor='[UI_style_color]'><tr><td>__</td></tr></table><br>"
	dat += "-Alpha(transparency): <a href='?src=\ref[src];preference=UIalpha'><b>[UI_style_alpha]</b></a><br>"
	dat += "<b>Play admin midis:</b> <a href='?src=\ref[src];preference=hear_midis'><b>[(toggles & SOUND_MIDI) ? "Yes" : "No"]</b></a><br>"
	dat += "<b>Play lobby music:</b> <a href='?src=\ref[src];preference=lobby_music'><b>[(toggles & SOUND_LOBBY) ? "Yes" : "No"]</b></a><br>"
	dat += "<b>Ghost ears:</b> <a href='?src=\ref[src];preference=ghost_ears'><b>[(chat_toggles & CHAT_GHOSTEARS) ? "All Speech" : "Nearest Creatures"]</b></a><br>"
	dat += "<b>Ghost sight:</b> <a href='?src=\ref[src];preference=ghost_sight'><b>[(chat_toggles & CHAT_GHOSTSIGHT) ? "All Emotes" : "Nearest Creatures"]</b></a><br>"
	dat += "<b>Ghost radio:</b> <a href='?src=\ref[src];preference=ghost_radio'><b>[(chat_toggles & CHAT_GHOSTRADIO) ? "All Chatter" : "Nearest Speakers"]</b></a><br>"

	dat += "<br><b>Custom Loadout:</b> "
	var/total_cost = 0

	if(!islist(gear)) gear = list()

	if(gear && gear.len)
		dat += "<br>"
		for(var/i = 1; i <= gear.len; i++)
			var/datum/gear/G = gear_datums[gear[i]]
			if(G)
				total_cost += G.cost
				dat += "[gear[i]] ([G.cost] points) <a href='?src=\ref[src];preference=loadout;task=remove;gear=[i]'>\[remove\]</a><br>"

		dat += "<b>Used:</b> [total_cost] points."
	else
		dat += "none."

	if(total_cost < MAX_GEAR_COST)
		dat += " <a href='?src=\ref[src];preference=loadout;task=input'>\[add\]</a>"
		if(gear && gear.len)
			dat += " <a href='?src=\ref[src];preference=loadout;task=clear'>\[clear\]</a>"

	dat += "<br><br><b>Occupation Choices</b><br>"
	dat += "\t<a href='?src=\ref[src];preference=job;task=menu'><b>Set Preferences</b></a><br>"

	dat += "<br><table><tr><td><b>Body</b> "
	dat += "(<a href='?src=\ref[src];preference=all;task=random'>&reg;</A>)"
	dat += "<br>"
	dat += "Species: <a href='?src=\ref[src];preference=species;task=change'>[species]</a><br>"
	dat += "Secondary Language:<br><a href='?src=\ref[src];preference=language;task=input'>[language]</a><br>"
	dat += "Blood Type: <a href='?src=\ref[src];preference=b_type;task=input'>[b_type]</a><br>"
	if(current_species.flags & HAS_SKIN_TONE)
		dat += "Skin Tone: <a href='?src=\ref[src];preference=s_tone;task=input'>[-s_tone + 35]/220<br></a>"
	dat += "Needs Glasses: <a href='?src=\ref[src];preference=disabilities'><b>[disabilities == 0 ? "No" : "Yes"]</b></a><br>"
	dat += "Tattoo: <a href='?src=\ref[src];preference=tattoo;task=open'>Set</a><br>"
	if( !(current_species.flags & (IS_PLANT|IS_SYNTHETIC)) )
		dat += "Limbs: <a href='?src=\ref[src];preference=limbs;task=open'>Adjust</a><br>"
		dat += "Internal Organs: <a href='?src=\ref[src];preference=organs;task=input'>Adjust</a><br>"

	//display limbs below
	var/ind = 0
	for(var/name in organ_data)
		//world << "[ind] \ [organ_data.len]"
		var/status = organ_data[name]
		var/organ_name = null
		switch(name)
			if(BP_L_ARM)
				organ_name = "left arm"
			if(BP_R_ARM)
				organ_name = "right arm"
			if(BP_L_LEG)
				organ_name = "left leg"
			if(BP_R_LEG)
				organ_name = "right leg"
			if(BP_L_FOOT)
				organ_name = "left foot"
			if(BP_R_FOOT)
				organ_name = "right foot"
			if(BP_L_HAND)
				organ_name = "left hand"
			if(BP_R_HAND)
				organ_name = "right hand"
			if(O_HEART)
				organ_name = "heart"
			if(O_EYES)
				organ_name = "eyes"

		switch(status)
			if("cyborg")
				++ind
				if(ind > 1)
					dat += ", "
				var/datum/robolimb/R
				if(rlimb_data[name] && all_robolimbs[rlimb_data[name]])
					R = all_robolimbs[rlimb_data[name]]
				else
					R = basic_robolimb
				dat += "\t[R.company] [organ_name] prothesis"
			if("amputated")
				++ind
				if(ind > 1)
					dat += ", "
				dat += "\tAmputated [organ_name]"
			if("mechanical")
				++ind
				if(ind > 1)
					dat += ", "
				dat += "\tMechanical [organ_name]"
			if("assisted")
				++ind
				if(ind > 1)
					dat += ", "
				switch(organ_name)
					if(O_HEART)
						dat += "\tPacemaker-assisted [organ_name]"
					if("voicebox") //on adding voiceboxes for speaking skrell/similar replacements
						dat += "\tSurgically altered [organ_name]"
					if(O_EYES)
						dat += "\tRetinal overlayed [organ_name]"
					else
						dat += "\tMechanically assisted [organ_name]"
	if(!ind)
		dat += "\[...\]<br><br>"
	else
		dat += "<br><br>"

	dat += "Underwear: <a href ='?src=\ref[src];preference=underwear;task=input'><b>[underwear]</b></a><br>"

	dat += "Undershirt: <a href='?src=\ref[src];preference=undershirt;task=input'><b>[undershirt]</b></a><br>"

	dat += "Socks: <a href='?src=\ref[src];preference=socks;task=input'><b>[socks]</b></a><br>"

	dat += "Backpack Type:<br><a href ='?src=\ref[src];preference=bag;task=input'><b>[backbaglist[backbag]]</b></a><br>"

	dat += "Nanotrasen Relation:<br><a href ='?src=\ref[src];preference=nt_relation;task=input'><b>[nanotrasen_relation]</b></a><br>"

	dat += "</td><td><b>Preview</b><br><img src=previewicon.png height=64 width=64><img src=previewicon2.png height=64 width=64></td></tr></table>"

	dat += "</td><td width='300px' height='300px'>"

	if(jobban_isbanned(user, "Records"))
		dat += "<b>You are banned from using character records.</b><br>"
	else
		dat += "<b><a href=\"?src=\ref[src];preference=records;record=1\">Character Records</a></b><br>"

	dat += "<b><a href=\"?src=\ref[src];preference=antagoptions;active=0\">Set Antag Options</b></a><br>"

	dat += "<a href='?src=\ref[src];preference=flavor_text;task=open'><b>Set Flavor Text</b></a><br>"
	dat += "<a href='?src=\ref[src];preference=flavour_text_robot;task=open'><b>Set Robot Flavour Text</b></a><br>"

	dat += "<a href='?src=\ref[src];preference=pAI'><b>pAI Configuration</b></a><br>"
	dat += "<br>"

	dat += "<br><b>Hair</b><br>"
	dat += "<a href='?src=\ref[src];preference=hair;task=input'>Change Color</a> <font face='fixedsys' size='3' color='[hair_color]'><table style='display:inline;' bgcolor='[hair_color]'><tr><td>__</td></tr></table></font> "
	dat += " Style: <a href='?src=\ref[src];preference=h_style;task=input'>[h_style]</a><br>"

	dat += "<br><b>Facial</b><br>"
	dat += "<a href='?src=\ref[src];preference=facial;task=input'>Change Color</a> <font face='fixedsys' size='3' color='[facial_color]'><table  style='display:inline;' bgcolor='[facial_color]'><tr><td>__</td></tr></table></font> "
	dat += " Style: <a href='?src=\ref[src];preference=f_style;task=input'>[f_style]</a><br>"

	dat += "<br><b>Eyes</b><br>"
	dat += "<a href='?src=\ref[src];preference=eyes;task=input'>Change Color</a> <font face='fixedsys' size='3' color='[eyes_color]'><table  style='display:inline;' bgcolor='[eyes_color]'><tr><td>__</td></tr></table></font><br>"

	if(current_species.flags & HAS_SKIN_COLOR)
		dat += "<br><b>Body Color</b><br>"
		dat += "<a href='?src=\ref[src];preference=skin;task=input'>Change Color</a> <font face='fixedsys' size='3' color='[skin_color]'><table style='display:inline;' bgcolor='[skin_color]'><tr><td>__</td></tr></table></font>"

	dat += "<br><br><b>Background Information</b><br>"
	dat += "<b>Home system</b>: <a href='?src=\ref[src];preference=home_system;task=input'>[home_system]</a><br/>"
	dat += "<b>Citizenship</b>: <a href='?src=\ref[src];preference=citizenship;task=input'>[citizenship]</a><br/>"
	dat += "<b>Faction</b>: <a href='?src=\ref[src];preference=faction;task=input'>[faction]</a><br/>"
	dat += "<b>Religion</b>: <a href='?src=\ref[src];preference=religion;task=input'>[religion]</a><br/>"

	dat += "<br><br>"

	if(jobban_isbanned(user, "Syndicate"))
		dat += "<b>You are banned from antagonist roles.</b>"
		src.be_special = 0
	else
		var/n = 0
		for (var/i in special_roles)
			if(special_roles[i]) //if mode is available on the server
				if(jobban_isbanned(user, i) || (i == "positronic brain" && jobban_isbanned(user, "AI") && jobban_isbanned(user, "Cyborg")) || (i == "pAI candidate" && jobban_isbanned(user, "pAI")))
					dat += "<b>Be [i]:<b> <font color=red><b> \[BANNED]</b></font><br>"
				else
					dat += "<b>Be [i]:</b> <a href='?src=\ref[src];preference=be_special;num=[n]'><b>[src.be_special&(1<<n) ? "Yes" : "No"]</b></a><br>"
			n++
	dat += "</td></tr></table></body></html>"

	user << browse(dat, "window=preferences;size=560x736")


/datum/preferences/proc/SetChoices(mob/user, limit = 18, list/splitJobs = list("Chief Medical Officer"), width = 550, height = 660)
	if(!job_master)
		return

	//limit 	 - The amount of jobs allowed per column. Defaults to 17 to make it look nice.
	//splitJobs - Allows you split the table by job. You can make different tables for each department by including their heads. Defaults to CE to make it look nice.
	//width	 - Screen' width. Defaults to 550 to make it look nice.
	//height 	 - Screen's height. Defaults to 500 to make it look nice.


	var/HTML = "<body>"
	HTML += "<tt><center>"
	HTML += "<b>Choose occupation chances</b><br>Unavailable occupations are crossed out.<br><br>"
	HTML += "<center><a href='?src=\ref[src];preference=job;task=close'>\[Done\]</a></center><br>" // Easier to press up here.
	HTML += "<table width='100%' cellpadding='1' cellspacing='0'><tr><td width='20%'>" // Table within a table for alignment, also allows you to easily add more colomns.
	HTML += "<table width='100%' cellpadding='1' cellspacing='0'>"
	var/index = -1

	//The job before the current job. I only use this to get the previous jobs color when I'm filling in blank rows.
	var/datum/job/lastJob
	if (!job_master)		return
	for(var/datum/job/job in job_master.occupations)
		index += 1
		if((index >= limit) || (job.title in splitJobs))
			if((index < limit) && (lastJob != null))
				//If the cells were broken up by a job in the splitJob list then it will fill in the rest of the cells with
				//the last job's selection color. Creating a rather nice effect.
				for(var/i = 0, i < (limit - index), i += 1)
					HTML += "<tr bgcolor='[lastJob.selection_color]'><td width='60%' align='right'><a>&nbsp</a></td><td><a>&nbsp</a></td></tr>"
			HTML += "</table></td><td width='20%'><table width='100%' cellpadding='1' cellspacing='0'>"
			index = 0

		HTML += "<tr bgcolor='[job.selection_color]'><td width='60%' align='right'>"
		var/rank = job.title
		lastJob = job
		if(jobban_isbanned(user, rank))
			HTML += "<del>[rank]</del></td><td><b> \[BANNED]</b></td></tr>"
			continue
		if(!job.player_old_enough(user.client))
			var/available_in_days = job.available_in_days(user.client)
			HTML += "<del>[rank]</del></td><td> \[IN [(available_in_days)] DAYS]</td></tr>"
			continue
		if((job_civilian_low & ASSISTANT) && (rank != "Assistant"))
			HTML += "<font color=orange>[rank]</font></td><td></td></tr>"
			continue
		if((rank in command_positions) || (rank == "AI"))//Bold head jobs
			HTML += "<b>[rank]</b>"
		else
			HTML += "[rank]"

		HTML += "</td><td width='40%'>"

		HTML += "<a href='?src=\ref[src];preference=job;task=input;text=[rank]'>"

		if(rank == "Assistant")//Assistant is special
			if(job_civilian_low & ASSISTANT)
				HTML += " <font color=green>\[Yes]</font>"
			else
				HTML += " <font color=red>\[No]</font>"
			if(job.alt_titles) //Blatantly cloned from a few lines down.
				HTML += "</a></td></tr><tr bgcolor='[lastJob.selection_color]'><td width='60%' align='center'><a>&nbsp</a></td><td><a href=\"?src=\ref[src];preference=job;task=alt_title;job=\ref[job]\">\[[GetPlayerAltTitle(job)]\]</a></td></tr>"
			HTML += "</a></td></tr>"
			continue

		if(GetJobDepartment(job, 1) & job.flag)
			HTML += " <font color=blue>\[High]</font>"
		else if(GetJobDepartment(job, 2) & job.flag)
			HTML += " <font color=green>\[Medium]</font>"
		else if(GetJobDepartment(job, 3) & job.flag)
			HTML += " <font color=orange>\[Low]</font>"
		else
			HTML += " <font color=red>\[NEVER]</font>"
		if(job.alt_titles)
			HTML += "</a></td></tr><tr bgcolor='[lastJob.selection_color]'><td width='60%' align='center'><a>&nbsp</a></td><td><a href=\"?src=\ref[src];preference=job;task=alt_title;job=\ref[job]\">\[[GetPlayerAltTitle(job)]\]</a></td></tr>"
		HTML += "</a></td></tr>"

	HTML += "</td'></tr></table>"

	HTML += "</center></table>"

	switch(alternate_option)
		if(GET_RANDOM_JOB)
			HTML += "<center><br><u><a href='?src=\ref[src];preference=job;task=random'><font color=green>Get random job if preferences unavailable</font></a></u></center><br>"
		if(BE_ASSISTANT)
			HTML += "<center><br><u><a href='?src=\ref[src];preference=job;task=random'><font color=red>Be assistant if preference unavailable</font></a></u></center><br>"
		if(RETURN_TO_LOBBY)
			HTML += "<center><br><u><a href='?src=\ref[src];preference=job;task=random'><font color=purple>Return to lobby if preference unavailable</font></a></u></center><br>"

	HTML += "<center><a href='?src=\ref[src];preference=job;task=reset'>\[Reset\]</a></center>"
	HTML += "</tt>"

	user << browse(null, "window=preferences")
	user << browse(HTML, "window=mob_occupation;size=[width]x[height]")
	return

/datum/preferences/proc/SetDisabilities(mob/user)
	var/HTML = "<body>"
	HTML += "<tt><center>"
	HTML += "<b>Choose disabilities</b><br>"

	HTML += "Need Glasses? <a href=\"?src=\ref[src];preferences=1;disabilities=0\">[disabilities & (1<<0) ? "Yes" : "No"]</a><br>"
	HTML += "Seizures? <a href=\"?src=\ref[src];preferences=1;disabilities=1\">[disabilities & (1<<1) ? "Yes" : "No"]</a><br>"
	HTML += "Coughing? <a href=\"?src=\ref[src];preferences=1;disabilities=2\">[disabilities & (1<<2) ? "Yes" : "No"]</a><br>"
	HTML += "Tourettes/Twitching? <a href=\"?src=\ref[src];preferences=1;disabilities=3\">[disabilities & (1<<3) ? "Yes" : "No"]</a><br>"
	HTML += "Nervousness? <a href=\"?src=\ref[src];preferences=1;disabilities=4\">[disabilities & (1<<4) ? "Yes" : "No"]</a><br>"
	HTML += "Deafness? <a href=\"?src=\ref[src];preferences=1;disabilities=5\">[disabilities & (1<<5) ? "Yes" : "No"]</a><br>"

	HTML += "<br>"
	HTML += "<a href=\"?src=\ref[src];preferences=1;disabilities=-2\">\[Done\]</a>"
	HTML += "</center></tt>"

	user << browse(null, "window=preferences")
	user << browse(HTML, "window=disabil;size=350x300")
	return

/datum/preferences/proc/SetRecords(mob/user)
	var/HTML = "<body>"
	HTML += "<tt><center>"
	HTML += "<b>Set Character Records</b><br>"

	HTML += "<a href=\"?src=\ref[src];preference=records;task=med_record\">Medical Records</a><br>"

	HTML += TextPreview(med_record,40)

	HTML += "<br><br><a href=\"?src=\ref[src];preference=records;task=gen_record\">Employment Records</a><br>"

	HTML += TextPreview(gen_record,40)

	HTML += "<br><br><a href=\"?src=\ref[src];preference=records;task=sec_record\">Security Records</a><br>"

	HTML += TextPreview(sec_record,40)

	HTML += "<br>"
	HTML += "<a href=\"?src=\ref[src];preference=records;records=-1\">\[Done\]</a>"
	HTML += "</center></tt>"

	user << browse(null, "window=preferences")
	user << browse(HTML, "window=records;size=350x300")
	return

/datum/preferences/proc/SetSpecies(mob/user)
	if(!species_preview || !(species_preview in all_species))
		species_preview = "Human"
	var/datum/species/current_species = all_species[species_preview]
	var/dat = "<body>"
	dat += "<center><h2>[current_species.name] \[<a href='?src=\ref[src];preference=species;task=change'>change</a>\]</h2></center><hr/>"
	dat += "<table padding='8px'>"
	dat += "<tr>"
	dat += "<td width = 400>[current_species.blurb]</td>"
	dat += "<td width = 200 align='center'>"
	if("preview" in icon_states(current_species.icobase))
		usr << browse_rsc(icon(current_species.icobase,"preview"), "species_preview_[current_species.name].png")
		dat += "<img src='species_preview_[current_species.name].png' width='64px' height='64px'><br/><br/>"
	dat += "<b>Language:</b> [current_species.language]<br/>"
	dat += "<small>"
	if(current_species.flags & CAN_JOIN)
		dat += "</br><b>Often present on human stations.</b>"
	if(current_species.flags & IS_WHITELISTED)
		dat += "</br><b>Whitelist restricted.</b>"
	if(current_species.flags & NO_BLOOD)
		dat += "</br><b>Does not have blood.</b>"
	if(current_species.flags & NO_BREATHE)
		dat += "</br><b>Does not breathe.</b>"
	if(current_species.flags & NO_SCAN)
		dat += "</br><b>Does not have DNA.</b>"
	if(current_species.flags & NO_PAIN)
		dat += "</br><b>Does not feel pain.</b>"
	if(current_species.flags & NO_SLIP)
		dat += "</br><b>Has excellent traction.</b>"
	if(current_species.flags & NO_POISON)
		dat += "</br><b>Immune to most poisons.</b>"
	if(current_species.flags & HAS_SKIN_TONE)
		dat += "</br><b>Has a variety of skin tones.</b>"
	if(current_species.flags & HAS_SKIN_COLOR)
		dat += "</br><b>Has a variety of skin colours.</b>"
	if(current_species.flags & HAS_EYE_COLOR)
		dat += "</br><b>Has a variety of eye colours.</b>"
	if(current_species.flags & IS_PLANT)
		dat += "</br><b>Has a plantlike physiology.</b>"
	if(current_species.flags & IS_SYNTHETIC)
		dat += "</br><b>Is machine-based.</b>"
	if(current_species.flags & REGENERATES_LIMBS)
		dat += "</br><b>Has a plantlike physiology.</b>"
	dat += "</small></td>"
	dat += "</tr>"
	dat += "</table><center><hr/>"

	var/restricted = 0
	if(jobban_isbanned(user, current_species.name))
		restricted = 1
	else if(config.usealienwhitelist) //If we're using the whitelist, make sure to check it!
		if(!(current_species.flags & CAN_JOIN))
			restricted = 2
		else if((current_species.flags & IS_WHITELISTED) && !is_alien_whitelisted(user,current_species))
			restricted = 1

	if(restricted)
		if(restricted == 1)
			dat += "<font color='red'><b>You cannot play as this species.</br><small>If you wish to be whitelisted, you can make an application post on <a href='?src=\ref[src];preference=open_whitelist_forum'>the forums</a>.</small></b></font></br>"
		else if(restricted == 2)
			dat += "<font color='red'><b>You cannot play as this species.</br><small>This species is not available for play as a station race..</small></b></font></br>"
	if(!restricted || check_rights(R_ADMIN, 0))
		dat += "\[<a href='?src=\ref[src];preference=species;task=input;newspecies=[species_preview]'>select</a>\]"
	dat += "</center></body>"

	user << browse(null, "window=preferences")
	spawn(2)
		user << browse(dat, "window=species;size=700x400")

/datum/preferences/proc/SetAntagoptions(mob/user)
	if(uplinklocation == "" || !uplinklocation)
		uplinklocation = "PDA"
	var/HTML = "<body>"
	HTML += "<tt><center>"
	HTML += "<b>Antagonist Options</b> <hr />"
	HTML += "<br>"
	HTML +="Uplink Type : <b><a href='?src=\ref[src];preference=antagoptions;antagtask=uplinktype;active=1'>[uplinklocation]</a></b>"
	HTML +="<br>"
	HTML +="Exploitable information about you : "
	HTML += "<br>"
	if(jobban_isbanned(user, "Records"))
		HTML += "<b>You are banned from using character records.</b><br>"
	else
		HTML +="<b><a href=\"?src=\ref[src];preference=records;task=exploitable_record\">[TextPreview(exploit_record,40)]</a></b>"
	HTML +="<br>"
	HTML +="<hr />"
	HTML +="<a href='?src=\ref[src];preference=antagoptions;antagtask=done;active=1'>\[Done\]</a>"

	HTML += "</center></tt>"

	user << browse(null, "window=preferences")
	user << browse(HTML, "window=antagoptions")
	return

/datum/preferences/proc/SetFlavorText(mob/user)
	var/HTML = "<body>"
	HTML += "<tt><center>"
	HTML += "<b>Set Flavour Text</b> <hr />"
	HTML += "<br></center>"
	for(var/flavor in flavs_list)
		HTML += "<a href='?src=\ref[src];preference=flavor_text;task=[flavor]'>[flavs_list[flavor]]:</a> "
		HTML += TextPreview(cp1251_to_utf8(flavor_texts[flavor]))
		HTML += "<br>"
	HTML += "<hr />"
	HTML +="<a href='?src=\ref[src];preference=flavor_text;task=done'>\[Done\]</a>"
	HTML += "<tt>"
	user << browse(null, "window=preferences")
	user << browse(HTML, "window=flavor_text;size=430x300")
	return

/datum/preferences/proc/SetFlavourTextRobot(mob/user)
	var/HTML = "<body>"
	HTML += "<tt><center>"
	HTML += "<b>Set Robot Flavour Text</b> <hr />"
	HTML += "<br></center>"
	HTML += "<a href ='?src=\ref[src];preference=flavour_text_robot;task=Default'>Default:</a> "
	HTML += TextPreview(cp1251_to_utf8(flavour_texts_robot["Default"]))
	HTML += "<hr />"
	for(var/module in robot_modules)
		HTML += "<a href='?src=\ref[src];preference=flavour_text_robot;task=[module]'>[module]:</a> "
		HTML += TextPreview(cp1251_to_utf8(flavour_texts_robot[module]))
		HTML += "<br>"
	HTML += "<hr />"
	HTML +="<a href='?src=\ref[src];preference=flavour_text_robot;task=done'>\[Done\]</a>"
	HTML += "<tt>"
	user << browse(null, "window=preferences")
	user << browse(HTML, "window=flavour_text_robot;size=430x300")
	return

/datum/preferences/proc/SetLimbs(mob/user)
	var/list/limbs = list("Left Arm"=BP_L_ARM, "Left Hand"=BP_L_HAND, "Right Arm"=BP_R_ARM, "Right Hand"=BP_R_HAND,\
						  "Left Leg"=BP_L_LEG, "Left Foot"=BP_L_FOOT, "Right Leg"=BP_R_LEG, "Right Foot"=BP_R_FOOT)
	var/list/states = list("Normal"=null,"Amputated"="amputated","Prothesis"="cyborg")
	var/HTML = "<body>"
	HTML += "<tt><center>"
	HTML += "<b>Set Limbs State</b> <hr />"
	HTML += "<br></center>"
	for(var/limb in limbs)
		HTML += "[limb]:"
		for (var/state in states)
			if( organ_data[limbs[limb]]==states[state] )
				HTML += "\t<b>[state]</b>"
				if( organ_data[limbs[limb]]=="cyborg" )
					HTML += "\t<a href='?src=\ref[src];preference=limbs;task=input;limb=[limb];state=Prothesis'>Set type</a> "
			else
				HTML += "\t<a href='?src=\ref[src];preference=limbs;task=input;limb=[limb];state=[state]'>[state]</a> "
		HTML += "<br>"
	HTML += "<hr />"
	HTML +="<a href='?src=\ref[src];preference=limbs;task=done'>\[Done\]</a>"
	HTML += "<tt>"
	user << browse(HTML, "window=set_limbs;size=430x300")
	return

/datum/preferences/proc/SetTattoo(mob/user)
	var/list/limbs = list("Head"=BP_HEAD, "Chest"=BP_CHEST, "Back" = "chest2", "Groin"=BP_GROIN,\
						  "Left Arm"=BP_L_ARM, "Left Hand"=BP_L_HAND, "Right Arm"=BP_R_ARM, "Right Hand"=BP_R_HAND,\
						  "Left Leg"=BP_L_LEG, "Left Foot"=BP_L_FOOT, "Right Leg"=BP_R_LEG, "Right Foot"=BP_R_FOOT)
	var/HTML = "<body>"
	HTML += "<tt><center>"
	HTML += "<b>Set Tattoo State</b> <hr />"
	HTML += "<br></center>"
	for(var/limb in limbs)
		HTML += "[limb]:"
		if( tattoo_data[limbs[limb]] )
			HTML += "\t<a href='?src=\ref[src];preference=tattoo;task=input;limb=[limb];mark=[limbs[limb]];state=drop'>Drop</a> "
		HTML += "\t<a href='?src=\ref[src];preference=tattoo;task=input;limb=[limb];mark=[limbs[limb]]'>Set</a> <br>"
	HTML += "<br>"
	HTML += "<hr />"
	HTML +="<a href='?src=\ref[src];preference=tattoo;task=done'>\[Done\]</a>"
	HTML += "<tt>"
	user << browse(HTML, "window=set_tattoo;size=430x300")
	return


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
		user << browse(null, "window=mob_occupation")
		ShowChoices(user)
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

/datum/preferences/Topic(href, list/href_list)
	switch(href_list["preference"])
		if("open_whitelist_forum")
			if(config.forumurl)
				usr << link(config.forumurl)
			else
				usr << "<span class='danger'>The forum URL is not set in the server configuration.</span>"
				return

		if("job")
			switch(href_list["task"])
				if("close")
					usr << browse(null, "window=mob_occupation")
					ShowChoices(usr)
				if("reset")
					ResetJobs()
					SetChoices(usr)
				if("random")
					if(alternate_option == GET_RANDOM_JOB || alternate_option == BE_ASSISTANT)
						alternate_option += 1
					else if(alternate_option == RETURN_TO_LOBBY)
						alternate_option = 0
					else
						return 0
					SetChoices(usr)
				if ("alt_title")
					var/datum/job/job = locate(href_list["job"])
					if (job)
						var/choices = list(job.title) + job.alt_titles
						var/choice = input("Pick a title for [job.title].", "Character Generation", GetPlayerAltTitle(job)) as anything in choices | null
						if(choice)
							SetPlayerAltTitle(job, choice)
							SetChoices(usr)
				if("input")
					if(SetJob(usr, href_list["text"]))
						spawn SetChoices(usr)
				else
					SetChoices(usr)
			return 1

		if("loadout")
			if(href_list["task"] == "input")
				var/list/valid_gear_choices = list()
				for(var/gear_name in gear_datums)
					var/datum/gear/G = gear_datums[gear_name]
					if(G.whitelisted && !is_alien_whitelisted(usr, G.whitelisted))
						continue
					valid_gear_choices += gear_name

				var/choice = input(usr, "Select gear to add: ") as null|anything in valid_gear_choices
				if(choice && gear_datums[choice])
					var/total_cost = 0
					if(isnull(gear) || !islist(gear)) gear = list()
					if(gear && gear.len)
						for(var/gear_name in gear)
							if(gear_datums[gear_name])
								var/datum/gear/G = gear_datums[gear_name]
								total_cost += G.cost
					var/datum/gear/C = gear_datums[choice]
					total_cost += C.cost
					if(C && total_cost <= MAX_GEAR_COST)
						gear += choice
						usr << "<span class='notice'>Added \the '[choice]' for [C.cost] points ([MAX_GEAR_COST - total_cost] points remaining).</span>"
					else
						usr << "<span class='warning'>Adding \the '[choice]' will exceed the maximum loadout cost of [MAX_GEAR_COST] points.</span>"
			else if(href_list["task"] == "remove")
				var/i_remove = text2num(href_list["gear"])
				if(i_remove < 1 || i_remove > gear.len) return
				gear.Cut(i_remove, i_remove + 1)
			else if(href_list["task"] == "clear")
				gear.Cut()

		if("flavor_text")
			switch(href_list["task"])
				if("open")
					SetFlavorText(usr)
					return
				if("done")
					usr << browse(null, "window=flavor_text")
					ShowChoices(usr)
					return
				if("general")
					var/msg = input(usr,"Give a general description of your character. This will be shown regardless of clothing, and may include OOC notes and preferences.","Flavor Text",rhtml_decode(edit_cp1251(flavor_texts["general"]))) as message
					flavor_texts[href_list["task"]] = post_edit_cp1251(sanitize(msg, extra = 0))
				else
					var/msg = input(usr,"Set the flavor text for your [href_list["task"]].","Flavor Text",rhtml_decode(edit_cp1251(flavor_texts[href_list["task"]]))) as message
					flavor_texts[href_list["task"]] = post_edit_cp1251(sanitize(msg, extra = 0))
			SetFlavorText(usr)
			return

		if("flavour_text_robot")
			switch(href_list["task"])
				if("open")
					SetFlavourTextRobot(usr)
					return
				if("done")
					usr << browse(null, "window=flavour_text_robot")
					ShowChoices(usr)
					return
				if("Default")
					var/msg = input(usr,"Set the default flavour text for your robot. It will be used for any module without individual setting.","Flavour Text",rhtml_decode(flavour_texts_robot["Default"])) as message
					flavour_texts_robot[href_list["task"]] = post_edit_utf8(sanitize(msg, extra = 0))
				else
					var/msg = input(usr,\
						"Set the flavour text for your robot with [href_list["task"]] module. If you leave this empty, default flavour text will be used for this module.",\
						"Flavour Text",rhtml_decode(flavour_texts_robot[href_list["task"]])) as message
					flavour_texts_robot[href_list["task"]] = post_edit_utf8(sanitize(msg, extra = 0))
			SetFlavourTextRobot(usr)
			return

		if("pAI")
			paiController.recruitWindow(usr, 0)
			return 1

		if("records")
			if(text2num(href_list["record"]) >= 1)
				SetRecords(usr)
				return
			else
				usr << browse(null, "window=records")
			if(href_list["task"] == "med_record")
				var/medmsg = cp1251_to_utf8(post_edit_utf8(sanitize(input(usr,"Set your medical notes here.","Medical Records",rhtml_decode(edit_utf8(med_record))) as message, MAX_PAPER_MESSAGE_LEN, extra = 0)))
				if(medmsg != null)
					med_record = medmsg
					SetRecords(usr)

			switch(href_list["task"])
				if("sec_record")
					var/secmsg = cp1251_to_utf8(post_edit_utf8(sanitize(input(usr,"Set your security notes here.","Security Records",rhtml_decode(edit_utf8(sec_record))) as message, MAX_PAPER_MESSAGE_LEN, extra = 0)))
					if(secmsg != null)
						sec_record = secmsg
						SetRecords(usr)
				if("gen_record")
					var/genmsg = cp1251_to_utf8(post_edit_utf8(sanitize(input(usr,"Set your employment notes here.","Employment Records",rhtml_decode(edit_utf8(gen_record))) as message, MAX_PAPER_MESSAGE_LEN, extra = 0)))
					if(genmsg != null)
						gen_record = genmsg
						SetRecords(usr)

				if("exploitable_record")
					var/exploitmsg = cp1251_to_utf8(post_edit_utf8(sanitize(input(usr,"Set exploitable information about you here.","Exploitable Information",rhtml_decode(edit_utf8(exploit_record))) as message, MAX_PAPER_MESSAGE_LEN, extra = 0)))
					if(exploitmsg != null)
						exploit_record = exploitmsg
						SetAntagoptions(usr)

		if("antagoptions")
			if(text2num(href_list["active"]) == 0)
				SetAntagoptions(usr)
				return
			switch(href_list["antagtask"])
				if("uplinktype")
					if (uplinklocation == "PDA")
						uplinklocation = "Headset"
					else if(uplinklocation == "Headset")
						uplinklocation = "None"
					else
						uplinklocation = "PDA"
					SetAntagoptions(usr)
				if("done")
					usr << browse(null, "window=antagoptions")
					ShowChoices(usr)
			return 1

		if("loadout")
			switch(href_list["task"])
				if("input")
					var/list/valid_gear_choices = list()
					for(var/gear_name in gear_datums)
						var/datum/gear/G = gear_datums[gear_name]
						if(G.whitelisted && !is_alien_whitelisted(usr, G.whitelisted))
							continue
						valid_gear_choices += gear_name
					var/choice = input(usr, "Select gear to add: ") as null|anything in valid_gear_choices
					if(choice && gear_datums[choice])
						var/total_cost = 0
						if(isnull(gear) || !islist(gear)) gear = list()
						if(gear && gear.len)
							for(var/gear_name in gear)
								if(gear_datums[gear_name])
									var/datum/gear/G = gear_datums[gear_name]
									total_cost += G.cost

						var/datum/gear/C = gear_datums[choice]
						total_cost += C.cost
						if(C && total_cost <= MAX_GEAR_COST)
							gear += choice
							usr << "\blue Added [choice] for [C.cost] points ([MAX_GEAR_COST - total_cost] points remaining)."
						else
							usr << "\red That item will exceed the maximum loadout cost of [MAX_GEAR_COST] points."

				if("remove")

					if(isnull(gear) || !islist(gear))
						gear = list()
					if(!gear.len)
						return

					var/choice = input(usr, "Select gear to remove: ") as null|anything in gear
					if(!choice)
						return

					for(var/gear_name in gear)
						if(gear_name == choice)
							gear -= gear_name
							break

	switch(href_list["task"])
		if("change")
			if(href_list["preference"] == "species")
				// Actual whitelist checks are handled elsewhere, this is just for accessing the preview window.
				var/choice = input("Which species would you like to look at?") as null|anything in playable_species
				if(!choice) return
				species_preview = choice
				SetSpecies(usr)

		if("random")
			switch(href_list["preference"])
				if("name")
					real_name = random_name(gender,species)
				if("age")
					age = rand(current_species.min_age, current_species.max_age)
				if("hair")
					hair_color = rgb(rand(0,255), rand(0,255), rand(0,255))
				if("h_style")
					h_style = random_hair_style(gender, species)
				if("facial")
					facial_color = rgb(rand(0,255), rand(0,255), rand(0,255))
				if("f_style")
					f_style = random_facial_hair_style(gender, species)
				if("underwear")
					underwear = pick(all_underwears)
					ShowChoices(usr)
				if("undershirt")
					undershirt = pick(all_undershirts)
					ShowChoices(usr)
				if("socks")
					socks = pick(all_socks)
					ShowChoices(usr)
				if("eyes")
					eyes_color = rgb(rand(0,255), rand(0,255), rand(0,255))
				if("s_tone")
					s_tone = random_skin_tone()
				if("s_color")
					skin_color = rgb(rand(0,255), rand(0,255), rand(0,255))
				if("bag")
					backbag = rand(1,4)
				if("all")
					randomize_appearance_for()	//no params needed

		if("input")
			switch(href_list["preference"])
				if("name")
					var/raw_name = input(usr, "Choose your character's name:", "Character Preference")  as text|null
					if (!isnull(raw_name)) // Check to ensure that the user entered text (rather than cancel.)
						var/new_name = sanitizeName(raw_name)
						if(new_name)
							real_name = new_name
						else
							usr << "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>"

				if("age")
					var/new_age = input(usr, "Choose your character's age:\n([current_species.min_age]-[current_species.max_age])", "Character Preference") as num|null
					if(new_age)
						age = max(min( round(text2num(new_age)), current_species.max_age),current_species.min_age)

				if("species")
					usr << browse(null, "window=species")
					var/prev_species = species
					species = href_list["newspecies"]
					if(prev_species != species)
						current_species = all_species[species_preview]
						sanitize_body_build()

						var/datum/sprite_accessory/HS = hair_styles_list[h_style]
						if(HS.gender != gender || !(current_species.get_bodytype() in HS.species_allowed))
							//grab one of the valid hair styles for the newly chosen species
							var/list/hairstyles = get_hair_styles_list(current_species.get_bodytype(), gender)
							h_style = pick(hairstyles)

						HS = facial_hair_styles_list[f_style]
						if(HS.gender != gender || !(current_species.get_bodytype() in HS.species_allowed))
							//grab one of the valid facial hair styles for the newly chosen species
							var/list/facialstyles = get_facial_styles_list(current_species.get_bodytype(), gender)
							f_style = pick(facialstyles)

						//reset hair colour and skin colour
						hair_color = initial(hair_color)

						s_tone = 0

				if("language")
					var/list/new_languages = list("None")

					for(var/L in all_languages)
						var/datum/language/lang = all_languages[L]
						if(lang.flags & PUBLIC)
							new_languages += lang.name

					for(var/L in current_species.secondary_langs)
						new_languages += L

					if(!(new_languages.len))
						alert(usr, "There are not currently any available secondary languages.")
					else
						language = input("Please select a secondary language", "Character Generation", null) in new_languages


				if("b_type")
					var/new_b_type = input(usr, "Choose your character's blood-type:", "Character Preference") as null|anything in list( "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-" )
					if(new_b_type)
						b_type = new_b_type

				if("hair")
					var/datum/sprite_accessory/H = hair_styles_list[h_style]
					if(H.do_colouration)
						var/new_hair = input(usr, "Choose your character's hair colour:", "Character Preference", hair_color) as color|null
						if(new_hair && new_hair!=hair_color)
							req_update_icon = 1
							hair_color = new_hair

				if("h_style")
					var/new_h_style = input(usr, "Choose your character's hair style:", "Character Preference", h_style) \
						as null|anything in get_hair_styles_list(current_species.get_bodytype(), gender)
					if(new_h_style)
						h_style = new_h_style

				if("facial")
					var/new_facial = input(usr, "Choose your character's facial-hair colour:", "Character Preference", facial_color) as color|null
					if(new_facial)
						facial_color = new_facial

				if("f_style")
					var/new_f_style = input(usr, "Choose your character's facial-hair style:", "Character Preference", f_style) \
					as null|anything in get_facial_styles_list(current_species.get_bodytype(), gender)
					if(new_f_style)
						f_style = new_f_style

				if("underwear")
					var/new_underwear = input(usr, "Choose your character's underwear:", "Character Preference")  as null|anything in all_underwears
					if(new_underwear)
						underwear = new_underwear
					else
						underwear = "None"
					ShowChoices(usr)

				if("undershirt")
					var/new_undershirt = input(usr, "Choose your character's undershirt:", "Character Preference") as null|anything in all_undershirts
					if (new_undershirt)
						undershirt = new_undershirt
					else
						new_undershirt = "None"
					ShowChoices(usr)

				if("socks")
					var/new_socks = input(usr, "Choose your character's socks:", "Character Preference") as null|anything in all_socks
					if (new_socks)
						socks = new_socks
					else
						new_socks = "None"
					ShowChoices(usr)

				if("eyes")
					var/new_eyes = input(usr, "Choose your character's eye colour:", "Character Preference", eyes_color) as color|null
					if(new_eyes)
						eyes_color = new_eyes

				if("s_tone")
					if(current_species.flags & HAS_SKIN_TONE)
						var/new_s_tone = input(usr, "Choose your character's skin-tone:\n(Light 1 - 220 Dark)", "Character Preference")  as num|null
						if(new_s_tone)
							s_tone = 35 - max(min( round(new_s_tone), 220),1)

				if("skin")
					if(current_species.flags & HAS_SKIN_COLOR)
						var/new_skin = input(usr, "Choose your character's skin colour: ", "Character Preference", skin_color) as color|null
						if(new_skin)
							skin_color = new_skin

				if("ooccolor")
					var/new_ooccolor = input(usr, "Choose your OOC colour:", "Game Preference") as color|null
					if(new_ooccolor)
						ooccolor = new_ooccolor

				if("bag")
					var/new_backbag = input(usr, "Choose your character's style of bag:", "Character Preference")  as null|anything in backbaglist
					if(new_backbag)
						backbag = backbaglist.Find(new_backbag)

				if("nt_relation")
					var/new_relation = input(
						"Choose your relation to NT. Note that this represents what others can find out about \
						your character by researching your background, not what your character actually thinks.",
						"Character Preference")  as null|anything in COMPANY_ALIGNMENTS
					if(new_relation)
						nanotrasen_relation = new_relation

				if("disabilities")
					if(text2num(href_list["disabilities"]) >= -1)
						if(text2num(href_list["disabilities"]) >= 0)
							disabilities ^= (1<<text2num(href_list["disabilities"])) //MAGIC
						SetDisabilities(usr)
						return
					else
						usr << browse(null, "window=disabil")

				if("tattoo")
					var/limb_name = href_list["limb"]
					var/mark = href_list["mark"]
					if(!limb_name || !mark) return

					if(href_list["state"] == "drop")
						tattoo_data -= mark
					else
						var/list/states = list("None") + tattoo_list[mark]
						if(!states) return

						var/new_state = input("Select tattoo for your [limb_name]") in states
						if(!new_state) return

						if(new_state == "None")
							tattoo_data -= mark
						else
							tattoo_data[mark] = states[new_state]

					ShowChoices(usr)
					SetTattoo(usr)
					return

				if("limbs")
					if(current_species.flags & (IS_PLANT|IS_SYNTHETIC) )
						return

					var/limb_name = href_list["limb"]
					if(!limb_name) return

					var/new_state = href_list["state"]
					if(!new_state) return

					var/limb = null
					var/second_limb = null // if you try to change the arm, the hand should also change
					var/third_limb = null  // if you try to unchange the hand, the arm should also change
					switch(limb_name)
						if("Left Leg")
							limb = BP_L_LEG
							second_limb = BP_L_FOOT
						if("Right Leg")
							limb = BP_R_LEG
							second_limb = BP_R_FOOT
						if("Left Arm")
							limb = BP_L_ARM
							second_limb = BP_L_HAND
						if("Right Arm")
							limb = BP_R_ARM
							second_limb = BP_R_HAND
						if("Left Foot")
							limb = BP_L_FOOT
							third_limb = BP_L_LEG
						if("Right Foot")
							limb = BP_R_FOOT
							third_limb = BP_R_LEG
						if("Left Hand")
							limb = BP_L_HAND
							third_limb = BP_L_ARM
						if("Right Hand")
							limb = BP_R_HAND
							third_limb = BP_R_ARM

					switch(new_state)
						if("Normal")
							organ_data[limb] = null
							rlimb_data[limb] = null
							if(third_limb)
								organ_data[third_limb] = null
								rlimb_data[third_limb] = null
						if("Amputated")
							organ_data[limb] = "amputated"
							rlimb_data[limb] = null
							if(second_limb)
								organ_data[second_limb] = "amputated"
								rlimb_data[second_limb] = null

						if("Prothesis")
							var/choice = input(usr, "Which manufacturer do you wish to use for this limb?") as null|anything in chargen_robolimbs
							if(!choice) return
							rlimb_data[limb] = choice
							organ_data[limb] = "cyborg"
							if(second_limb)
								rlimb_data[second_limb] = choice
								organ_data[second_limb] = "cyborg"
							if(third_limb && organ_data[third_limb] == "amputated")
								organ_data[third_limb] = null
					ShowChoices(usr)
					SetLimbs(usr)
					return

				if("organs")
					if( current_species.flags & (IS_PLANT|IS_SYNTHETIC) )
						return
					var/organ_name = input(usr, "Which internal function do you want to change?") as null|anything in list("Heart", "Eyes")
					if(!organ_name) return

					var/organ = null
					switch(organ_name)
						if("Heart")
							organ = O_HEART
						if("Eyes")
							organ = O_EYES

					var/new_state = input(usr, "What state do you wish the organ to be in?") as null|anything in list("Normal","Assisted","Mechanical")
					if(!new_state) return

					switch(new_state)
						if("Normal")
							organ_data[organ] = null
						if("Assisted")
							organ_data[organ] = "assisted"
						if("Mechanical")
							organ_data[organ] = "mechanical"

				if("skin_style")
					var/skin_style_name = input(usr, "Select a new skin style") as null|anything in list("default1", "default2", "default3")
					if(!skin_style_name) return

				if("spawnpoint")
					var/list/spawnkeys = list()
					for(var/S in spawntypes)
						spawnkeys += S
					var/choice = input(usr, "Where would you like to spawn when latejoining?") as null|anything in spawnkeys
					if(!choice || !spawntypes[choice])
						spawnpoint = "Arrivals Shuttle"
						return
					spawnpoint = choice

				if("home_system")
					var/choice = input(usr, "Please choose a home system.") as null|anything in home_system_choices + list("Unset","Other")
					if(!choice)
						return
					if(choice == "Other")
						var/raw_choice = input(usr, "Please enter a home system.")  as text|null
						if(raw_choice)
							home_system = sanitize(raw_choice)
						return
					home_system = choice
				if("citizenship")
					var/choice = input(usr, "Please choose your current citizenship.") as null|anything in citizenship_choices + list("None","Other")
					if(!choice)
						return
					if(choice == "Other")
						var/raw_choice = input(usr, "Please enter your current citizenship.", "Character Preference") as text|null
						if(raw_choice)
							citizenship = sanitize(raw_choice)
						return
					citizenship = choice
				if("faction")
					var/choice = input(usr, "Please choose a faction to work for.") as null|anything in faction_choices + list("None","Other")
					if(!choice)
						return
					if(choice == "Other")
						var/raw_choice = input(usr, "Please enter a faction.")  as text|null
						if(raw_choice)
							faction = sanitize(raw_choice)
						return
					faction = choice
				if("religion")
					var/choice = input(usr, "Please choose a religion.") as null|anything in religion_choices + list("None","Other")
					if(!choice)
						return
					if(choice == "Other")
						var/raw_choice = input(usr, "Please enter a religon.")  as text|null
						if(raw_choice)
							religion = sanitize(raw_choice)
						return
					religion = choice
		else
			switch(href_list["preference"])
				if("limbs")
					switch(href_list["task"])
						if("open")
							spawn(2)
								SetLimbs(usr)
						if("done")
							usr << browse(null, "window=set_limbs")
							ShowChoices(usr)
							return

				if("tattoo")
					switch(href_list["task"])
						if("open")
							spawn(2)
								SetTattoo(usr)
						if("done")
							usr << browse(null, "window=set_tattoo")
							ShowChoices(usr)
							return

				if("gender")
					if(gender == MALE)
						gender = FEMALE
					else
						gender = MALE
					sanitize_body_build()

				if("build")
					body = next_in_list(body, current_species.get_body_build_list(gender))
					req_update_icon = 1

				if("disabilities")				//please note: current code only allows nearsightedness as a disability
					disabilities = !disabilities//if you want to add actual disabilities, code that selects them should be here

				if("hear_adminhelps")
					toggles ^= SOUND_ADMINHELP

				if("ui")
					switch(UI_style)
						if("Midnight")
							UI_style = "Orange"
						if("Orange")
							UI_style = "old"
						if("old")
							UI_style = "White"
						else
							UI_style = "Midnight"

				if("UIcolor")
					var/UI_style_color_new = input("Choose your UI color, dark colors are not recommended!") as color|null
					if(!UI_style_color_new) return
					UI_style_color = UI_style_color_new

				if("UIalpha")
					var/UI_style_alpha_new = input("Select a new alpha(transparence) parametr for UI, between 50 and 255") as num
					if(!UI_style_alpha_new || UI_style_alpha_new > 255 || UI_style_alpha_new < 50) return
					UI_style_alpha = UI_style_alpha_new

				if("be_special")
					var/num = text2num(href_list["num"])
					be_special ^= (1<<num)

				if("name")
					random_name = !random_name

				if("hear_midis")
					toggles ^= SOUND_MIDI

				if("lobby_music")
					toggles ^= SOUND_LOBBY
					if(toggles & SOUND_LOBBY)
						usr << sound(ticker.login_music, repeat = 0, wait = 0, volume = 85, channel = 1)
					else
						usr << sound(null, repeat = 0, wait = 0, volume = 85, channel = 1)

				if("ghost_ears")
					chat_toggles ^= CHAT_GHOSTEARS

				if("ghost_sight")
					chat_toggles ^= CHAT_GHOSTSIGHT

				if("ghost_radio")
					chat_toggles ^= CHAT_GHOSTRADIO

				if("open_load_dialog")
					if(!IsGuestKey(usr.key))
						spawn(2)
							open_load_dialog(usr)

				if("load")
					load_preferences()
					load_character(text2num(href_list["num"]))
					close_dialog(usr)

				if("open_save_dialog")
					if(!IsGuestKey(usr.key))
						spawn(2)
							open_save_dialog(usr)

				if("save")
					save_preferences()
					save_character(text2num(href_list["num"]))
					close_dialog(usr)

				if("close_dialog")
					close_dialog(usr)

				if("reload")
					load_preferences()
					load_character()

				if("delete")
					delete_character(href_list["num"])
					open_load_dialog(usr)

	ShowChoices(usr)
	return 1

/datum/preferences/proc/copy_to(mob/living/carbon/human/character, safety = 0)
	if(random_name || jobban_isbanned(usr, "Name"))
		real_name = random_name(gender,species)

	var/firstspace = findtext(real_name, " ")
	var/name_length = length(real_name)
	if(!firstspace)	//we need a surname
		real_name += " [pick(last_names)]"
	else if(firstspace == name_length)
		real_name += "[pick(last_names)]"

	character.real_name = real_name
	character.name = character.real_name
	if(character.dna)
		character.dna.real_name = character.real_name

	for (var/T in flavor_texts)
		character.flavor_texts[T] = flavor_texts[T]

	character.med_record = med_record
	character.sec_record = sec_record
	character.gen_record = gen_record
	character.exploit_record = exploit_record

	character.gender = gender
	character.body_build = current_species.get_body_build(gender, body)
	character.age = age
	character.b_type = b_type

	character.eyes_color = eyes_color
	character.hair_color = hair_color
	character.facial_color = facial_color
	character.skin_color = skin_color

	character.s_tone = s_tone

	character.h_style = h_style
	character.f_style = f_style

	character.home_system = home_system
	character.citizenship = citizenship
	character.personal_faction = faction
	character.religion = religion

	// Destroy/cyborgize organs
	for(var/name in character.organs_by_name)
		var/status = organ_data[name]
		var/obj/item/organ/external/O = character.organs_by_name[name]
		if(O)
			if(status == "amputated")
				qdel(O)
			else if(status == "cyborg")
				if(rlimb_data[name])
					O.robotize(rlimb_data[name])
				else
					O.robotize()
			else
				var/tattoo = tattoo_data[name]
				var/tattoo2 = tattoo_data["[name]2"]
				O.tattoo = tattoo ? tattoo : 0
				O.tattoo2 = tattoo2 ? tattoo2 : 0
	for(var/name in character.internal_organs_by_name)
		var/status = organ_data[name]
		if(status)
			var/obj/item/organ/internal/I = character.internal_organs_by_name[name]
			if(I)
				if(status == "assisted")
					I.mechassist()
				else if(status == "mechanical")
					I.robotize()

	if(backbag > 4 || backbag < 1)
		backbag = 1 //Same as above
	character.backbag = backbag

	//Debugging report to track down a bug, which randomly assigned the plural gender to people.
	if(character.gender in list(PLURAL, NEUTER))
		if(isliving(src)) //Ghosts get neuter by default
			message_admins("[character] ([character.ckey]) has spawned with their gender as plural or neuter. Please notify coders.")
			character.gender = MALE

	character.force_update_limbs()

/datum/preferences/proc/open_load_dialog(mob/user)
	var/dat = "<body>"
	dat += "<tt><center>"

	var/savefile/S = new /savefile(path)
	if(S)
		dat += "<b>Select a character slot to load:</b><hr>"
		var/name
		for(var/i=1, i<= config.character_slots, i++)
			S.cd = "/character[i]"
			S["real_name"] >> name
			var/removable = 1
			if(!name)
				name = "Character[i]"
				removable = 0
			if(i==default_slot)
				name = "<b>[name]</b>"
			dat += "<a href='?src=\ref[src];preference=load;num=[i];'>[name]</a>"
			if(removable)
				dat += " <a href='?src=\ref[src];preference=delete;num=[i];'>\[X]</a>"
			dat += "<br>"

	dat += "<hr>"
	dat += "<a href='?src=\ref[src];preference=close_dialog'>Close</a><br>"
	dat += "</center></tt>"
	user << browse(dat, "window=saves;size=300x390")

/datum/preferences/proc/open_save_dialog(mob/user)
	var/dat = "<body>"
	dat += "<tt><center>"

	var/savefile/S = new /savefile(path)
	if(S)
		dat += "<b>Select a character slot to save:</b><hr>"
		var/name
		for(var/i=1, i<= config.character_slots, i++)
			S.cd = "/character[i]"
			S["real_name"] >> name
			if(!name)	name = "Character[i]"
			if(i==default_slot)
				name = "<b>[name]</b>"
			dat += "<a href='?src=\ref[src];preference=save;num=[i];'>[name]</a><br>"

	dat += "<hr>"
	dat += "<a href='?src=\ref[src];preference=close_dialog'>Close</a><br>"
	dat += "</center></tt>"
	user << browse(dat, "window=saves;size=300x390")

/datum/preferences/proc/close_dialog(mob/user)
	user << browse(null, "window=saves")
