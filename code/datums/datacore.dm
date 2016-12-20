var/global/list/PDA_Manifest = list()
var/global/ManifestJSON

/hook/startup/proc/createDatacore()
	data_core = new /datum/datacore()
	return 1

/datum/datacore
	var/name = "datacore"
	var/list/medical[] = list()
	var/list/general[] = list()
	var/list/security[] = list()
	//This list tracks characters spawned in the world and cannot be modified in-game. Currently referenced by respawn_character().
	var/list/locked[] = list()

/datum/datacore/proc/manifest()
	spawn()
		for(var/mob/living/carbon/human/H in player_list)
			manifest_inject(H)
		return

/datum/datacore/proc/manifest_modify(var/name, var/assignment)
	if(PDA_Manifest.len)
		PDA_Manifest.Cut()
	var/datum/data/record/foundrecord
	var/real_title = assignment

	for(var/datum/data/record/t in data_core.general)
		if (t)
			if(t.fields["name"] == name)
				foundrecord = t
				break

	var/list/all_jobs = job_master.occupations

	for(var/datum/job/J in all_jobs)
		var/list/alttitles = get_alternate_titles(J.title)
		if(!J)	continue
		if(assignment in alttitles)
			real_title = J.title
			break

	if(foundrecord)
		foundrecord.fields["rank"] = assignment
		foundrecord.fields["real_rank"] = real_title

/datum/datacore/proc/manifest_inject(var/mob/living/carbon/human/H)
	if(PDA_Manifest.len)
		PDA_Manifest.Cut()

	if(H.mind && !player_is_antag(H.mind, only_offstation_roles = 1))
		var/assignment
		if(H.mind.role_alt_title)
			assignment = H.mind.role_alt_title
		else if(H.mind.assigned_role)
			assignment = H.mind.assigned_role
		else if(H.job)
			assignment = H.job
		else
			assignment = "Unassigned"

		var/id = generate_record_id()
		var/icon/front = new(get_id_photo(H), dir = SOUTH)
		var/icon/side = new(get_id_photo(H), dir = WEST)
		//General Record
		var/datum/data/record/G = new()
		G.fields["id"]			= id
		G.fields["name"]		= H.real_name
		G.fields["real_rank"]	= H.mind.assigned_role
		G.fields["rank"]		= assignment
		G.fields["age"]			= H.age
		G.fields["fingerprint"]	= md5(H.dna.uni_identity)
		G.fields["p_stat"]		= "Active"
		G.fields["m_stat"]		= "Stable"
		G.fields["sex"]			= H.gender
		G.fields["species"]		= H.get_species()
		G.fields["home_system"]	= H.home_system
		G.fields["citizenship"]	= H.citizenship
		G.fields["faction"]		= H.personal_faction
		G.fields["religion"]	= H.religion
		G.fields["photo_front"]	= front
		G.fields["photo_side"]	= side
		if(H.gen_record && !jobban_isbanned(H, "Records"))
			G.fields["notes"] = H.gen_record
		else
			G.fields["notes"] = "No notes found."
		general += G

		//Medical Record
		var/datum/data/record/M = new()
		M.fields["id"]			= id
		M.fields["name"]		= H.real_name
		M.fields["b_type"]		= H.b_type
		M.fields["b_dna"]		= H.dna.unique_enzymes
		M.fields["mi_dis"]		= "None"
		M.fields["mi_dis_d"]	= "No minor disabilities have been declared."
		M.fields["ma_dis"]		= "None"
		M.fields["ma_dis_d"]	= "No major disabilities have been diagnosed."
		M.fields["alg"]			= "None"
		M.fields["alg_d"]		= "No allergies have been detected in this patient."
		M.fields["cdi"]			= "None"
		M.fields["cdi_d"]		= "No diseases have been diagnosed at the moment."
		if(H.med_record && !jobban_isbanned(H, "Records"))
			M.fields["notes"] = H.med_record
		else
			M.fields["notes"] = "No notes found."
		medical += M

		//Security Record
		var/datum/data/record/S = new()
		S.fields["id"]			= id
		S.fields["name"]		= H.real_name
		S.fields["criminal"]	= "None"
		S.fields["mi_crim"]		= "None"
		S.fields["mi_crim_d"]	= "No minor crime convictions."
		S.fields["ma_crim"]		= "None"
		S.fields["ma_crim_d"]	= "No major crime convictions."
		S.fields["notes"]		= "No notes."
		if(H.sec_record && !jobban_isbanned(H, "Records"))
			S.fields["notes"] = H.sec_record
		else
			S.fields["notes"] = "No notes."
		security += S

		//Locked Record
		var/datum/data/record/L = new()
		L.fields["id"]			= md5("[H.real_name][H.mind.assigned_role]")
		L.fields["name"]		= H.real_name
		L.fields["rank"] 		= H.mind.assigned_role
		L.fields["age"]			= H.age
		L.fields["fingerprint"]	= md5(H.dna.uni_identity)
		L.fields["sex"]			= H.gender
		L.fields["b_type"]		= H.b_type
		L.fields["b_dna"]		= H.dna.unique_enzymes
		L.fields["enzymes"]		= H.dna.SE // Used in respawning
		L.fields["identity"]	= H.dna.UI // "
		L.fields["species"]		= H.get_species()
		L.fields["home_system"]	= H.home_system
		L.fields["citizenship"]	= H.citizenship
		L.fields["faction"]		= H.personal_faction
		L.fields["religion"]	= H.religion
		L.fields["image"]		= getFlatIcon(H)	//This is god-awful
		if(H.exploit_record && !jobban_isbanned(H, "Records"))
			L.fields["exploit_record"] = H.exploit_record
		else
			L.fields["exploit_record"] = "No additional information acquired."
		locked += L
	return

/datum/datacore/proc/get_manifest(monochrome, OOC)
	var/list/heads = new()
	var/list/sec = new()
	var/list/eng = new()
	var/list/med = new()
	var/list/sci = new()
	var/list/civ = new()
	var/list/bot = new()
	var/list/misc = new()
	var/list/isactive = new()
	var/dat = {"
	<head><style>
		.manifest {border-collapse:collapse;}
		.manifest td, th {border:1px solid [monochrome?"black":"#DEF; background-color:white; color:black"]; padding:.25em}
		.manifest th {height: 2em; [monochrome?"border-top-width: 3px":"background-color: #48C; color:white"]}
		.manifest tr.head th { [monochrome?"border-top-width: 1px":"background-color: #488;"] }
		.manifest td:first-child {text-align:right}
		.manifest tr.alt td {[monochrome?"border-top-width: 2px":"background-color: #DEF"]}
	</style></head>
	<table class="manifest" width='350px'>
	<tr class='head'><th>Name</th><th>Rank</th><th>Activity</th></tr>
	"}
	var/even = 0
	// sort mobs
	for(var/datum/data/record/t in data_core.general)
		var/name = t.fields["name"]
		var/rank = t.fields["rank"]
		var/real_rank = make_list_rank(t.fields["real_rank"])

		if(OOC)
			var/active = 0
			for(var/mob/M in player_list)
				if(M.real_name == name && M.client && M.client.inactivity <= 10 * 60 * 10)
					active = 1
					break
			isactive[name] = active ? "Active" : "Inactive"
		else
			isactive[name] = t.fields["p_stat"]
			//world << "[name]: [rank]"
			//cael - to prevent multiple appearances of a player/job combination, add a continue after each line
		var/department = 0
		if(real_rank in command_positions)
			heads[name] = rank
			department = 1
		if(real_rank in security_positions)
			sec[name] = rank
			department = 1
		if(real_rank in engineering_positions)
			eng[name] = rank
			department = 1
		if(real_rank in medical_positions)
			med[name] = rank
			department = 1
		if(real_rank in science_positions)
			sci[name] = rank
			department = 1
		if(real_rank in civilian_positions)
			civ[name] = rank
			department = 1
		if(real_rank in nonhuman_positions)
			bot[name] = rank
			department = 1
		if(!department && !(name in heads))
			misc[name] = rank
	if(heads.len > 0)
		dat += "<tr><th colspan=3>Heads</th></tr>"
		for(name in heads)
			dat += "<tr[even ? " class='alt'" : ""]><td>[name]</td><td>[heads[name]]</td><td>[isactive[name]]</td></tr>"
			even = !even
	if(sec.len > 0)
		dat += "<tr><th colspan=3>Security</th></tr>"
		for(name in sec)
			dat += "<tr[even ? " class='alt'" : ""]><td>[name]</td><td>[sec[name]]</td><td>[isactive[name]]</td></tr>"
			even = !even
	if(eng.len > 0)
		dat += "<tr><th colspan=3>Engineering</th></tr>"
		for(name in eng)
			dat += "<tr[even ? " class='alt'" : ""]><td>[name]</td><td>[eng[name]]</td><td>[isactive[name]]</td></tr>"
			even = !even
	if(med.len > 0)
		dat += "<tr><th colspan=3>Medical</th></tr>"
		for(name in med)
			dat += "<tr[even ? " class='alt'" : ""]><td>[name]</td><td>[med[name]]</td><td>[isactive[name]]</td></tr>"
			even = !even
	if(sci.len > 0)
		dat += "<tr><th colspan=3>Science</th></tr>"
		for(name in sci)
			dat += "<tr[even ? " class='alt'" : ""]><td>[name]</td><td>[sci[name]]</td><td>[isactive[name]]</td></tr>"
			even = !even
	if(civ.len > 0)
		dat += "<tr><th colspan=3>Civilian</th></tr>"
		for(name in civ)
			dat += "<tr[even ? " class='alt'" : ""]><td>[name]</td><td>[civ[name]]</td><td>[isactive[name]]</td></tr>"
			even = !even
	// in case somebody is insane and added them to the manifest, why not
	if(bot.len > 0)
		dat += "<tr><th colspan=3>Silicon</th></tr>"
		for(name in bot)
			dat += "<tr[even ? " class='alt'" : ""]><td>[name]</td><td>[bot[name]]</td><td>[isactive[name]]</td></tr>"
			even = !even
	// misc guys
	if(misc.len > 0)
		dat += "<tr><th colspan=3>Miscellaneous</th></tr>"
		for(name in misc)
			dat += "<tr[even ? " class='alt'" : ""]><td>[name]</td><td>[misc[name]]</td><td>[isactive[name]]</td></tr>"
			even = !even

	dat += "</table>"
	dat = replacetext(dat, "\n", "") // so it can be placed on paper correctly
	dat = replacetext(dat, "\t", "")
	return dat


/var/list/acting_rank_prefixes = list("acting", "temporary", "interim", "provisional")

/proc/make_list_rank(rank)
	for(var/prefix in acting_rank_prefixes)
		if(findtext(rank, "[prefix] ", 1, 2+length(prefix)))
			return copytext(rank, 2+length(prefix))
	return rank


/*
We can't just insert in HTML into the nanoUI so we need the raw data to play with.
Instead of creating this list over and over when someone leaves their PDA open to the page
we'll only update it when it changes.  The PDA_Manifest global list is zeroed out upon any change
using /datum/datacore/proc/manifest_inject( ), or manifest_insert( )
*/

/datum/datacore/proc/get_manifest_json()
	if(PDA_Manifest.len)
		return
	var/heads[0]
	var/sec[0]
	var/eng[0]
	var/med[0]
	var/sci[0]
	var/civ[0]
	var/bot[0]
	var/misc[0]
	for(var/datum/data/record/t in data_core.general)
		var/name = sanitize(t.fields["name"])
		var/rank = sanitize(t.fields["rank"])
		var/real_rank = make_list_rank(t.fields["real_rank"])

		var/isactive = t.fields["p_stat"]
		var/department = 0
		var/depthead = 0 			// Department Heads will be placed at the top of their lists.
		if(real_rank in command_positions)
			heads[++heads.len] = list("name" = name, "rank" = rank, "active" = isactive)
			department = 1
			depthead = 1
			if(rank=="Captain" && heads.len != 1)
				heads.Swap(1,heads.len)

		if(real_rank in security_positions)
			sec[++sec.len] = list("name" = name, "rank" = rank, "active" = isactive)
			department = 1
			if(depthead && sec.len != 1)
				sec.Swap(1,sec.len)

		if(real_rank in engineering_positions)
			eng[++eng.len] = list("name" = name, "rank" = rank, "active" = isactive)
			department = 1
			if(depthead && eng.len != 1)
				eng.Swap(1,eng.len)

		if(real_rank in medical_positions)
			med[++med.len] = list("name" = name, "rank" = rank, "active" = isactive)
			department = 1
			if(depthead && med.len != 1)
				med.Swap(1,med.len)

		if(real_rank in science_positions)
			sci[++sci.len] = list("name" = name, "rank" = rank, "active" = isactive)
			department = 1
			if(depthead && sci.len != 1)
				sci.Swap(1,sci.len)

		if(real_rank in civilian_positions)
			civ[++civ.len] = list("name" = name, "rank" = rank, "active" = isactive)
			department = 1
			if(depthead && civ.len != 1)
				civ.Swap(1,civ.len)

		if(real_rank in nonhuman_positions)
			bot[++bot.len] = list("name" = name, "rank" = rank, "active" = isactive)
			department = 1

		if(!department && !(name in heads))
			misc[++misc.len] = list("name" = name, "rank" = rank, "active" = isactive)


	PDA_Manifest = list(
		"heads" = heads,
		"sec" = sec,
		"eng" = eng,
		"med" = med,
		"sci" = sci,
		"civ" = civ,
		"bot" = bot,
		"misc" = misc
		)
	ManifestJSON = list2json(PDA_Manifest)
	return

/proc/generate_record_id()
	return add_zero(num2hex(rand(1, 65535)), 4)	//no point generating higher numbers because of the limitations of num2hex

/proc/get_id_photo(var/mob/living/carbon/human/H, var/assigned_role)

	var/icon/preview_icon = H.stand_icon
	var/icon/temp

	var/datum/sprite_accessory/hair_style = hair_styles_list[H.h_style ? H.h_style : "Bald"]
	if(hair_style)
		temp = new/icon(hair_style.icon, hair_style.icon_state)
		temp.Blend(H.hair_color, ICON_ADD)

	hair_style = facial_hair_styles_list[H.f_style ? H.f_style : "Shaved"]
	if(hair_style)
		var/icon/facial = new/icon(hair_style.icon, hair_style.icon_state)
		facial.Blend(H.facial_color, ICON_ADD)
		temp.Blend(facial, ICON_OVERLAY)

	preview_icon.Blend(temp, ICON_OVERLAY)


	var/datum/job/J = job_master.GetJob(H.mind.assigned_role)
	if(J)
		var/obj/item/clothing/under/UF = J.uniform
		temp = new /icon(H.body_build.uniform_icon, initial(UF.icon_state))

		var/obj/item/clothing/shoes/SH = J.shoes
		temp.Blend(new /icon(H.body_build.shoes_icon, initial(SH.icon_state)), ICON_OVERLAY)
	else
		temp = new /icon(H.body_build.uniform_icon, "grey")
		temp.Blend(new /icon(H.body_build.shoes_icon, "black"), ICON_OVERLAY)

	preview_icon.Blend(temp, ICON_OVERLAY)

	qdel(temp)

	return preview_icon
