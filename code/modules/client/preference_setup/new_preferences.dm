#define PAGE_LOAD        1
#define PAGE_SAVE        2
#define PAGE_RECORDS     3
#define PAGE_LIMBS       4
#define PAGE_OCCUPATION  5
#define PAGE_LOADOUT     6
#define PAGE_FLAVOR      7
#define PAGE_MATCHMAKING 8
#define PAGE_PREFS       9
#define PAGE_SPECIES     10

/datum/preferences
	var/global/list/setup_pages = list(
		"General"     = PAGE_RECORDS,
		"Flavor"      = PAGE_FLAVOR,
		"Occupations" = PAGE_OCCUPATION,
		"Augmentation"= PAGE_LIMBS,
		"Loadout"     = PAGE_LOADOUT,
		"Matchmaking" = PAGE_MATCHMAKING,
		"Preferences" = PAGE_PREFS,
	)

	var/current_page = PAGE_RECORDS
	var/req_update_icon = 1

	// GENERAL
	var/hair_color   = "#000000"
	var/facial_color = "#000000"
	var/eyes_color   = "#000000"
	var/skin_color   = "#000000"

	var/email = ""					//Character email adress.
	var/email_is_public = 1			//Add or not to email-list at round join.

	// AUGMENTATION
	var/list/modifications_data   = list()
	var/list/modifications_colors = list()
	var/current_organ= BP_CHEST
	var/global/list/r_organs = list(BP_HEAD, BP_R_ARM, BP_R_HAND, BP_CHEST, BP_R_LEG, BP_R_FOOT)
	var/global/list/l_organs = list(O_EYES, BP_L_ARM, BP_L_HAND, BP_GROIN, BP_L_LEG, BP_L_FOOT)
	var/global/list/internal_organs = list("chest2", O_HEART, O_LUNGS, O_LIVER)

	// LOADOUT
	var/list/loadout = list()

/datum/preferences/proc/sanitize_body_build()
	if(body && current_species.get_body_build(gender, body))
		return 1

	var/datum/body_build/BB = current_species.get_body_build(gender)
	body = BB.name


/datum/preferences/proc/NewShowChoices(mob/user)
	if(!user || !user.client)	return
	if(req_update_icon)
		update_preview_icon()
		user << browse_rsc(preview_south, "new_previewicon[SOUTH].png") // TODO: return to list of dirs?
		user << browse_rsc(preview_north, "new_previewicon[NORTH].png")
		user << browse_rsc(preview_east,  "new_previewicon[EAST].png" )
		user << browse_rsc(preview_west,  "new_previewicon[WEST].png" )

	var/dat = {"
		<html><head>
		<script language='javascript'>
			[js_byjax]
			function set(param, value) {window.location='?src=\ref[src];'+param+'='+value;}
		</script>
		<style>
			span.box{display: inline-block; width: 20px; height: 10px; border:1px solid #000;}
			div.limited{display:none}
			div.limited.[species]{display: inline-block}
			td{padding: 0px}
		</style>
		</head>
		<body style='overflow:hidden'><center>
	"}

	if(path)
		dat += "<span onclick=\"set('switch_page', [PAGE_LOAD])\">Load slot</span> - "
		dat += "<span onclick=\"set('reload', 'reload')\">Reload slot</span> - "
		dat += "<span onclick=\"set('switch_page', [PAGE_SAVE])\">Save slot</span><hr>"
	else
		dat += "Please create an account to save your preferences.<hr>"

	// Page switching
	for(var/item in setup_pages)
		if(item!=setup_pages[1])
			dat += " | "
		if(current_page == setup_pages[item])
			dat += "<b>[item]</b>"
		else
			dat += "<span onclick=\"set('switch_page', '[setup_pages[item]]')\">[item]</span>"
	dat += "</center><hr>"

	switch(current_page)
		if(PAGE_LOAD)		dat += GetLoadPage(user)
		if(PAGE_SAVE)		dat += GetSavePage(user)
		if(PAGE_RECORDS)	dat += GetRecordsPage(user)
		if(PAGE_LIMBS)		dat += GetLimbsPage(user)
		if(PAGE_OCCUPATION)	dat += GetOccupationPage(user)
		if(PAGE_FLAVOR)		dat += GetFlavorPage(user)
		if(PAGE_PREFS)		dat += GetPrefsPage(user)
		if(PAGE_LOADOUT)	dat += GetLoadOutPage(user)
		if(PAGE_MATCHMAKING)dat += GetMatchmakingPage(user)
		if(PAGE_SPECIES)	dat += GetSpeciesPage(user)
		else dat+=GetRecordsPage(user) // Protection
	dat += "</body></html>"

	user << browse(dat, "window=new_pref;size=560x520;can_resize=0")

/datum/preferences/Topic(href, href_list)
	var/mob/user = usr
	if(!user || !user.client)
		return

	if(href_list["switch_page"])
		current_page = text2num(href_list["switch_page"])
		spawn(2)
			NewShowChoices(user)
		return

	else if(href_list["reload"])
		load_preferences()
		load_character()
		req_update_icon = 1

	else if(href_list["rotate"])
		if(href_list["rotate"] == "right")
			preview_dir = turn(preview_dir,-90)
		else
			preview_dir = turn(preview_dir,90)

	switch(current_page)
		if(PAGE_LOAD)		HandleLoadTopic(user, href_list)
		if(PAGE_SAVE)		HandleSaveTopic(user, href_list)
		if(PAGE_RECORDS)	HandleRecordsTopic(user, href_list)
		if(PAGE_LIMBS)		HandleLimbsTopic(user, href_list)
		if(PAGE_LOADOUT)	HandleLoadOutTopic(user, href_list)
		if(PAGE_OCCUPATION)	HandleOccupationTopic(user, href_list)
		if(PAGE_FLAVOR)		HandleFlavorTopic(user, href_list)
		if(PAGE_MATCHMAKING)HandleMatchmakingTopic(user, href_list)
		if(PAGE_PREFS)		HandlePrefsTopic(user, href_list)
		if(PAGE_SPECIES)	HandleSpeciesTopic(user, href_list)

	spawn()
		NewShowChoices(user)
	return



// Page. Generating and Handle.


/datum/preferences/proc/GetLoadPage()
	var/dat = "<tt><center>"
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
			dat += "<a href='?src=\ref[src];character=load;num=[i]'>[name]</a>"
			if(removable)
				dat += " <a href='?src=\ref[src];character=delete;num=[i]'>\[X]</a>"
			dat += "<br>"
	dat += "</center></tt>"
	return dat

/datum/preferences/proc/HandleLoadTopic(mob/user, list/href_list)
	switch(href_list["character"])
		if("load")
			load_preferences()
			load_character(text2num(href_list["num"]))
			req_update_icon = 1
			current_page = PAGE_RECORDS
		if("delete")
			delete_character(href_list["num"])

/datum/preferences/proc/GetSavePage()
	var/dat = "<tt><center>"
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
			dat += "<a href='?src=\ref[src];character=save;num=[i]'>[name]</a>"
			if(removable)
				dat += " <a href='?src=\ref[src];character=delete;num=[i]'>\[X]</a>"
			dat += "<br>"
	dat += "</center></tt>"
	return dat

/datum/preferences/proc/HandleSaveTopic(mob/user, list/href_list)
	switch(href_list["character"])
		if("save")
			save_preferences()
			save_character(text2num(href_list["num"]))
			current_page = PAGE_RECORDS
		if("delete")
			delete_character(href_list["num"])


/datum/preferences/proc/GetRecordsPage()
	var/dat = "<table><tr><td width='260px'>"
	dat += "<b>General Information</b><br>"
	dat += "Name: <a id='name' href='?src=\ref[src];name=input'>[real_name]</a><br>"
	dat += "(<a href='?src=\ref[src];name=random'>Random Name</a>) "
	dat += "(Always? <a href='?src=\ref[src];name=random_always'>[random_name ? "Yes" : "No"]</a>)"
	dat += "<br>"

	dat += "Species: <a href='?src=\ref[src];switch_page=[PAGE_SPECIES]'>[species]</a><br>"
//	dat += "Secondary Language:<br><a href='?src=\ref[src];language=input'>[language]</a><br>"
	dat += "Gender: <a href='?src=\ref[src];gender=switch'>[gender == MALE ? "Male" : "Female"]</a><br>"
	dat += "Body build: <a href='?src=\ref[src];build=switch'>[body]</a><br>"

	if(current_species.flags & HAS_SKIN_TONE)
		dat += "Skin Tone: <a href='?src=\ref[src];skin_tone=input'>[s_tone]/220</a><br>"

	dat += "<table style='border-collapse:collapse'>"
	dat += "<tr><td>Hair:</td><td><a href='?src=\ref[src];hair=color'>Color "
	dat += "<span class='box' style='background-color:[hair_color]'></span></a>"
	dat += "Style: <a href='?src=\ref[src];hair=style'>[h_style]</a></td></tr>"

	dat += "<tr><td>Facial:</td><td><a href='?src=\ref[src];facial=color'>Color "
	dat += "<span class='box' style='background-color:[facial_color]'></span></a>"
	dat += "Style: <a href='?src=\ref[src];facial=style'>[f_style]</a></td></tr>"

	dat += "<tr><td>Eyes:</td>"
	dat += "<td><a href='?src=\ref[src];eyes=color'>Color "
	dat += "<span class='box' style='background-color:[eyes_color]'></span></a></td></tr>"

	if(current_species.flags & HAS_SKIN_COLOR)
		dat += "<tr><td>Skin color:</td>"
		dat += "<td><a href='?src=\ref[src];skin=color'>Color "
		dat += "<span class='box' style='background-color:[skin_color]'></span></a></td></tr>"
	dat += "</table>"

	dat += "Blood Type: <a href='?src=\ref[src];blood_type=input'>[b_type]</a><br>"
	dat += "Age: <a href='?src=\ref[src];age=input'>[age]</a><br>"
	dat += "Spawn Point: <a href='?src=\ref[src];spawnpoint=input'>[spawnpoint]</a><br>"
	dat += "Second language: <a href='?src=\ref[src];language=input'>[language]</a><br>"
//	dat += "Corporate mail: <a href='?src=\ref[src];mail=input'>[email ? email : "\[RANDOM MAIL\]"]</a>@mail.nt<br>"
//	dat += "Add your mail to public catalogs: <a href='?src=\ref[src];mail=public'>[email_is_public?"Yes":"No"]</a><br>"

	dat += "<br><b>Background Information</b><br>"
	dat += "Nanotrasen Relation: <a href ='?src=\ref[src];nt_relation=input'>[nanotrasen_relation]</a><br>"
	dat += "Home system: <a href='?src=\ref[src];home_system=input'>[home_system]</a><br>"
	dat += "Citizenship: <a href='?src=\ref[src];citizenship=input'>[citizenship]</a><br>"
	dat += "Faction: <a href='?src=\ref[src];faction=input'>[faction]</a><br>"
	dat += "Religion: <a href='?src=\ref[src];religion=input'>[religion]</a>"

	dat += "</td><td style='vertical-align:top'>"

	dat += "<b>Preview</b><br><a href='?src=\ref[src];rotate=right'>&lt;&lt;&lt;</a> \
			<a href='?src=\ref[src];rotate=left'>&gt;&gt;&gt;</a><br>"
	dat += "<img src=new_previewicon[preview_dir].png height=64 width=64>"
	dat += "<img src=new_previewicon[turn(preview_dir,-90)].png height=64 width=64><br>"

	dat += "<br><b>Set Character Records</b><br>"
	dat += "<a href='?src=\ref[src];records=med'>Medical Records</a><br>"
	dat += "<span style='white-space: nowrap'>[TextPreview(med_record,26)]</span>"
	dat += "<br><a href='?src=\ref[src];records=gen'>Employment Records</a><br>"
	dat += "<span style='white-space: nowrap'>[TextPreview(gen_record,26)]</span>"
	dat += "<br><a href='?src=\ref[src];records=sec'>Security Records</a><br>"
	dat += "<span style='white-space: nowrap'>[TextPreview(sec_record,26)]</span>"
	dat += "<br><a href='?src=\ref[src];records=exp'>Exploitable Record</a><br>"
	dat += "<span style='white-space: nowrap'>[TextPreview(exploit_record,26)]</span>"

	dat += "<br><br>"

	dat += "Need Glasses: <a href='?src=\ref[src];disabilities=glasses'>[disabilities & NEARSIGHTED ? "Yes" : "No"]</a><br>"
	dat += "<table style='position:relative; left:-3px'>"
	dat += "<tr><td>Backpack:</td>\
		<td><a href ='?src=\ref[src];inventory=back'>[backbaglist[backbag]]</a></td></tr>"
	dat += "<tr><td>Underwear:</td>\
		<td><a href ='?src=\ref[src];inventory=underwear'>[underwear]</a></td></tr>"
	dat += "<tr><td>Undershirt:</td>\
		<td><a href='?src=\ref[src];inventory=undershirt'>[undershirt]</a></td></tr>"
	dat += "<tr><td>Socks:</td>\
		<td><a href='?src=\ref[src];inventory=socks'>[socks]</a></td></tr>"
	dat += "</table>"

/*
	dat += "<table style='position:relative; left:-3px'><tr><td>Need Glasses?<br>Coughing?<br>Nervousness?<br>Paraplegia?</td><td>"
	dat += "<a href='?src=\ref[src];disabilities=glasses'>[disabilities & NEARSIGHTED ? "Yes" : "No"]</a><br>"
	dat += "<a href='?src=\ref[src];disabilities=coughing'>[disabilities & COUGHING ? "Yes" : "No"]</a><br>"
	dat += "<a href='?src=\ref[src];disabilities=nervousness'>[disabilities & NERVOUS ? "Yes" : "No"]</a><br>"
	dat += "<a href='?src=\ref[src];disabilities=paraplegia'>[disabilities & PARAPLEGIA ? "Yes" : "No"]</a>"
	dat += "</td></tr></table>"
*/


	dat += "</td></tr></table>"

	return dat

/datum/preferences/proc/HandleRecordsTopic(mob/user, list/href_list)
	if(href_list["name"]) switch(href_list["name"])
		if("input")
			var/raw_name = input(user, "Choose your character's name:", "Character Preference")  as text|null
			if (!isnull(raw_name)) // Check to ensure that the user entered text (rather than cancel.)
				var/new_name = current_species.sanitize_name(raw_name)
				if(new_name)
					real_name = new_name
					send_byjax(user, "new_pref.browser", "name", real_name)
				else
					user << "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] \
					characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>"
		if("random")
			real_name = random_name(gender,species)
		if("random_always")
			random_name = !random_name

	else if(href_list["language"])
		var/list/new_languages = list("None")

		for(var/L in all_languages)
			var/datum/language/lang = all_languages[L]
			if(lang.flags & PUBLIC)
				new_languages += lang.name

		for(var/L in current_species.secondary_langs)
			new_languages += L

		language = input("Please select a secondary language", "Character Generation", null) in new_languages

	else if(href_list["gender"])
		req_update_icon = 1
		if(gender == MALE)
			gender = FEMALE
		else
			gender = MALE
		sanitize_body_build()

	else if(href_list["build"])
		body = next_in_list(body, current_species.get_body_build_list(gender))
		req_update_icon = 1

	else if(href_list["hair"])
		switch(href_list["hair"])
			if("color")
				var/datum/sprite_accessory/H = hair_styles_list[h_style]
				if(H.do_colouration)
					var/new_color = input(user, "Choose your character's hair colour:", "Character Preference", hair_color) as color|null
					if(new_color && new_color!=hair_color)
						req_update_icon = 1
						hair_color = new_color
			if("style")
				var/new_h_style = input(user, "Choose your character's hair style:", "Character Preference", h_style)\
					as null|anything in get_hair_styles_list(current_species.get_bodytype(), gender)
				if(new_h_style && new_h_style != h_style)
					req_update_icon = 1
					h_style = new_h_style

	else if(href_list["facial"])
		switch(href_list["facial"])
			if("color")
				var/datum/sprite_accessory/F = facial_hair_styles_list[f_style]
				if(F.do_colouration)
					var/new_color = input(user, "Choose your character's facial-hair colour:", "Character Preference", facial_color) as color|null
					if(new_color && new_color!=facial_color)
						req_update_icon = 1
						facial_color = new_color
			if("style")
				var/new_f_style = input(user, "Choose your character's facial-hair style:", "Character Preference", f_style) \
					as null|anything in get_facial_styles_list(current_species.get_bodytype(), gender)
				if(new_f_style && new_f_style!=f_style)
					req_update_icon = 1
					f_style = new_f_style

	else if(href_list["eyes"])
		var/new_eyes = input(user, "Choose your character's eye colour:", "Character Preference", eyes_color) as color|null
		if(new_eyes && new_eyes!=eyes_color)
			req_update_icon = 1
			eyes_color = new_eyes

	else if(href_list["age"])
		var/new_age = input(user, "Choose your character's age:\n([current_species.min_age]-[current_species.max_age])", "Character Preference") as num|null
		if(new_age)
			age = max(min( round(text2num(new_age)), current_species.max_age),current_species.min_age)

	else if(href_list["blood_type"])
		var/new_b_type = input(usr, "Choose your character's blood-type:", "Character Preference") as null|anything in list( "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-" )
		if(new_b_type)
			b_type = new_b_type

	else if(href_list["skin_tone"])
		if(current_species.flags & HAS_SKIN_TONE)
			var/new_s_tone = input(user, "Choose your character's skin-tone:\n(Light 1 - 220 Dark)", "Character Preference", s_tone)  as num|null
			if(new_s_tone && new_s_tone!=s_tone)
				req_update_icon = 1
				s_tone = max( min(new_s_tone, 220), 1)

	else if(href_list["skin"])
		if(current_species.flags & HAS_SKIN_COLOR)
			var/new_skin = input(user, "Choose your character's skin colour: ", "Character Preference", skin_color) as color|null
			if(new_skin && new_skin!=skin_color)
				req_update_icon = 1
				skin_color = new_skin

	else if(href_list["spawnpoint"])
		var/list/spawnkeys = list()
		for(var/S in spawntypes)
			spawnkeys += S
		var/choice = input(user, "Where would you like to spawn when latejoining?") as null|anything in spawnkeys
		if(!choice || !spawntypes[choice])
			spawnpoint = "Arrivals Shuttle"
			return
		spawnpoint = choice

	else if(href_list["disabilities"])
		disabilities ^= NEARSIGHTED
		req_update_icon = 1

	else if(href_list["mail"]) switch(href_list["mail"])
		if("input")
			var/raw_email = input(user, "Choose your character's name:", "Character Preference")  as text|null
			if (!isnull(raw_email)) // Check to ensure that the user entered text (rather than cancel.)
				var/new_email = replacetext(reject_bad_text(raw_email), " ", "")
				if(!new_email)
					user << "<span class = 'warning'>Your mail will be generated when you enter round.</span>"
				email = new_email

		if("public")
			email_is_public = !email_is_public

	else if(href_list["nt_relation"])
		var/new_relation = input(user, "Choose your relation to NT.\
			Note that this represents what others can find out about your character by researching your background,\
			not what your character actually thinks.", "Character Preference") \
			as null|anything in list("Loyal", "Supportive", "Neutral", "Skeptical", "Opposed")

		if(new_relation)
			nanotrasen_relation = new_relation

	else if(href_list["home_system"])
		var/choice = input(user, "Please choose a home system.") as null|anything in home_system_choices + list("Unset","Other")
		if(!choice)
			return
		if(choice == "Other")
			var/raw_choice = input(user, "Please enter a home system.")  as text|null
			if(raw_choice)
				home_system = sanitize(raw_choice)
			return
		home_system = choice

	else if(href_list["citizenship"])
		var/choice = input(user, "Please choose your current citizenship.") as null|anything in citizenship_choices + list("None","Other")
		if(!choice)
			return
		if(choice == "Other")
			var/raw_choice = input(user, "Please enter your current citizenship.", "Character Preference") as text|null
			if(raw_choice)
				citizenship = sanitize(raw_choice)
			return
		citizenship = choice

	else if(href_list["faction"])
		var/choice = input(user, "Please choose a faction to work for.") as null|anything in faction_choices + list("None","Other")
		if(!choice)
			return
		if(choice == "Other")
			var/raw_choice = input(user, "Please enter a faction.")  as text|null
			if(raw_choice)
				faction = sanitize(raw_choice)
			return
		faction = choice

	else if(href_list["religion"])
		var/choice = input(user, "Please choose a religion.") as null|anything in religion_choices + list("None","Other")
		if(!choice)
			return
		if(choice == "Other")
			var/raw_choice = input(user, "Please enter a religon.")  as text|null
			if(raw_choice)
				religion = sanitize(raw_choice)
			return
		religion = choice

	else if(href_list["records"]) switch(href_list["records"])
		if("med")
			var/medmsg = sanitize(input(usr,"Set your medical notes here.","Medical Records",\
						rhtml_decode(edit_utf8(med_record))) as message, MAX_PAPER_MESSAGE_LEN, extra = 0)
			if(medmsg != null)
				med_record = cp1251_to_utf8(post_edit_utf8(medmsg))

		if("sec")
			var/secmsg = sanitize(input(usr,"Set your security notes here.","Security Records",\
						rhtml_decode(edit_utf8(sec_record))) as message, MAX_PAPER_MESSAGE_LEN, extra = 0)
			if(secmsg != null)
				sec_record = cp1251_to_utf8(post_edit_utf8(secmsg))

		if("gen")
			var/genmsg = sanitize(input(usr,"Set your employment notes here.","Employment Records",\
						rhtml_decode(edit_utf8(gen_record))) as message, MAX_PAPER_MESSAGE_LEN, extra = 0)
			if(genmsg != null)
				gen_record = cp1251_to_utf8(post_edit_utf8(genmsg))

		if("exp")
			var/expmsg = sanitize(input(usr,"Set exploitable information about you here.","Exploitable Information",\
						rhtml_decode(edit_utf8(exploit_record))) as message, MAX_PAPER_MESSAGE_LEN, extra = 0)
			if(expmsg != null)
				exploit_record = cp1251_to_utf8(post_edit_utf8(expmsg))

	else if(href_list["inventory"]) switch(href_list["inventory"])
		if("back")
			var/new_backbag = input(usr, "Choose your character's style of bag:", "Character Preference")  as null|anything in backbaglist
			if(new_backbag)
				backbag = backbaglist.Find(new_backbag)
				req_update_icon = 1
		if("socks")
			var/new_socks = input(usr, "Choose your character's socks:", "Character Preference") as null|anything in all_socks
			if (new_socks)
				socks = new_socks
				req_update_icon = 1
		if("underwear")
			var/new_underwear = input(usr, "Choose your character's underwear:", "Character Preference")  as null|anything in all_underwears
			if(new_underwear)
				underwear = new_underwear
				req_update_icon = 1
		if("undershirt")
			var/new_undershirt = input(usr, "Choose your character's undershirt:", "Character Preference") as null|anything in all_undershirts
			if (new_undershirt)
				undershirt = new_undershirt
				req_update_icon = 1

	return


/datum/preferences/proc/GetLimbsPage()
	var/dat = "<style>div.block{border: 3px solid black;margin: 3px 0px;padding: 4px 0px;}</style>"
	dat += "<table style='max-height:400px;height:410px'>"
	dat += "<tr style='vertical-align:top'><td><div style='max-width:230px;width:230px;height:100%;overflow-y:auto;border:solid;padding:3px'>"
	dat += modifications_types[current_organ]
	dat += "</div></td><td style='margin-left:10px;width-max:285px;width:285px;border:solid'>"
	dat += "<table><tr><td style='width:105px; text-align:right'>"

	for(var/organ in r_organs)
		var/datum/body_modification/mod = get_modification(organ)
		var/disp_name = mod ? mod.short_name : "Nothing"
		if(organ == current_organ)
			dat += "<div><b><span style='background-color:pink'>[organ_tag_to_name[organ]]</span></b> "
		else
			dat += "<div><b>[organ_tag_to_name[organ]]</b> "
		dat += "<a href='?src=\ref[src];color=[organ]'><span class='box' style='background-color:[modifications_colors[organ]]'></span></a>"
		dat += "<br><a href='?src=\ref[src];organ=[organ]'>[disp_name]</a></div>"

	dat += "</td><td style='width:80px;text-align:center'><img src=new_previewicon[preview_dir].png height=64 width=64>"
	dat += "<br><a href='?src=\ref[src];rotate=right'>&lt;&lt;&lt;</a> <a href='?src=\ref[src];rotate=left'>&gt;&gt;&gt;</a></td>"
	dat += "<td style='width:95px'>"

	for(var/organ in l_organs)
		var/datum/body_modification/mod = get_modification(organ)
		var/disp_name = mod ? mod.short_name : "Nothing"
		dat += "<div><a href='?src=\ref[src];color=[organ]'><span class='box' style='background-color:[modifications_colors[organ]]'></span></a>"
		if(organ == current_organ)
			dat += " <b><span style='background-color:pink'>[organ_tag_to_name[organ]]</span></b>"
		else
			dat += " <b>[organ_tag_to_name[organ]]</b>"
		dat += "<br><a href='?src=\ref[src];organ=[organ]'>[disp_name]</a></div>"

	dat += "</td></tr></table><hr>"

	dat += "<table cellpadding='1' cellspacing='0' width='100%'>"
	dat += "<tr align='center'>"
	var/counter = 0
	for(var/organ in internal_organs)
		if(!organ in body_modifications) continue

		var/datum/body_modification/mod = get_modification(organ)
		var/disp_name = mod.short_name
		if(organ == current_organ)
			dat += "<td width='33%'><b><span style='background-color:pink'>[organ_tag_to_name[organ]]</span></b>"
		else
			dat += "<td width='33%'><b>[organ_tag_to_name[organ]]</b>"
		dat += "<br><a href='?src=\ref[src];organ=[organ]'>[disp_name]</a></td>"

		if(++counter >= 3)
			dat += "</tr><tr align='center'>"
			counter = 0
	dat += "</tr></table>"
	dat += "</span></div>"

	return dat

/datum/preferences/proc/get_modification(var/organ)
	if(!organ || !modifications_data[organ])
		return body_modifications["nothing"]
	return modifications_data[organ]

/datum/preferences/proc/check_child_modifications(var/organ = BP_CHEST)
	var/list/organ_data = organ_structure[organ]
	if(!organ_data) return
	var/datum/body_modification/mod = get_modification(organ)
	for(var/child_organ in organ_data["children"])
		var/datum/body_modification/child_mod = get_modification(child_organ)
		if(child_mod.nature < mod.nature)
			if(mod.is_allowed(child_organ, src))
				modifications_data[child_organ] = mod
			else
				modifications_data[child_organ] = get_default_modificaton(mod.nature)
			check_child_modifications(child_organ)
	return

/datum/preferences/proc/HandleLimbsTopic(mob/user, list/href_list)
	if(href_list["organ"])
		current_organ = href_list["organ"]

	else if(href_list["color"])
		var/organ = href_list["color"]
		if(!modifications_colors[organ]) modifications_colors[organ] = "#FFFFFF"
		var/new_color = input(user, "Choose color for [organ_tag_to_name[organ]]: ", "Character Preference", modifications_colors[organ]) as color|null
		if(new_color && modifications_colors[organ]!=new_color)
			req_update_icon = 1
			modifications_colors[organ] = new_color

	else if(href_list["body_modification"])
		var/datum/body_modification/mod = body_modifications[href_list["body_modification"]]
		if(mod && mod.is_allowed(current_organ, src))
			modifications_data[current_organ] = mod
			check_child_modifications(current_organ)
			req_update_icon = 1


/datum/preferences/proc/GetPrefsPage(var/mob/user)
	var/dat = {"
		<table style='display:inline'>
		<tr><td><b>UI:</b></td></tr>
		<tr><td>UI Style:</td><td><a href='?src=\ref[src];toggle=ui'>[UI_style]</a></td></tr>
		<tr><td>Color:</td> <td><a href='?src=\ref[src];toggle=UIcolor'><span class='box' style='background-color:[UI_style_color]'></span></a></td></tr>
		<tr><td>Alpha(transparency):</td> <td><a href='?src=\ref[src];toggle=UIalpha'>[UI_style_alpha]</a></td></tr>
		<tr><td><b>SOUND:</b></td></tr>
		<tr><td>Play admin midis:</td> <td><a href='?src=\ref[src];toggle=hear_midis'>[(toggles & SOUND_MIDI) ? "Yes" : "No"]</a></td></tr>
		<tr><td>Play lobby music:</td> <td><a href='?src=\ref[src];toggle=lobby_music'>[(toggles & SOUND_LOBBY) ? "Yes" : "No"]</a></td></tr>
		<tr><td>Hear Ambience: </td> <td><a href='?src=\ref[src];toggle=ambience'>[(toggles & SOUND_AMBIENCE) ? "Yes" : "No"]</a></td></tr>
		<tr><td><b>GHOST:</b></td></tr>
		<tr><td>Ghost ears:</td> <td><a href='?src=\ref[src];toggle=ghost_ears'>[(chat_toggles & CHAT_GHOSTEARS) ? "All Speech" : "Nearest Creatures"]</a></td></tr>
		<tr><td>Ghost sight:</td> <td><a href=?src=\ref[src];toggle=ghost_sight'>[(chat_toggles & CHAT_GHOSTSIGHT) ? "All Emotes" : "Nearest Creatures"]</a></td></tr>
		<tr><td>Ghost radio:</td> <td><a href='?src=\ref[src];toggle=ghost_radio'>[(chat_toggles & CHAT_GHOSTRADIO) ? "All Chatter" : "Nearest Speakers"]</a></td></tr>
		<tr><td>Hear dead chat:</td> <td><a href='?src=\ref[src];toggle=dead_chat'>[(chat_toggles & CHAT_DEAD) ? "Yes" : "No"]</a></td></tr>
		<tr><td><b>CHAT:</b></td></tr>
		<tr><td>Hear OOC:</td> <td><a href='?src=\ref[src];toggle=head_ooc'>[(chat_toggles & CHAT_OOC) ? "Yes" : "No"]</a></td></tr>
		<tr><td>Hear LOOC:</td> <td><a href='?src=\ref[src];toggle=head_looc'>[(chat_toggles & CHAT_LOOC) ? "Yes" : "No"]</a></td></tr>
		<tr><td>Hide Chat Tags:</td> <td><a href='?src=\ref[src];toggle=chat_tags'>[(toggles & CHAT_NOICONS) ? "Yes" : "No"]</a></td></tr>
		<tr><td>Emote Localization:</td> <td><a href='?src=\ref[src];toggle=emote_localization'>[(toggles & RUS_AUTOEMOTES) ? "Enabled" : "Disabled"]</a></td></tr>
		<tr><td>Show MOTD:</td> <td><a href='?src=\ref[src];toggle=show_motd'>[(toggles & HIDE_MOTD) ? "Disabled" : "Enabled"]</a></td></tr>
		</table>
		<span style='padding-left:15px;display:inline-block; vertical-align:top'>
		<b>ANTAGONISTS:</b><br>
	"}

	if(jobban_isbanned(user, "Syndicate"))
		dat += "<b>You are banned from antagonist roles.</b>"
		src.be_special = 0
	else
		var/n = 0
		for (var/i in special_roles)
			if(special_roles[i]) //if mode is available on the server
				if(jobban_isbanned(user, i) || (i == "positronic brain" && jobban_isbanned(user, "AI") && jobban_isbanned(user, "Cyborg")) || (i == "pAI candidate" && jobban_isbanned(user, "pAI")))
					dat += "Be [i]: <font color=red><b> \[BANNED]</b></font><br>"
				else
					dat += "Be [i]: <a href='?src=\ref[src];be_special=[n]'><b>[src.be_special&(1<<n) ? "Yes" : "No"]</b></a><br>"
			n++
	dat += "</span>"

	return dat

/datum/preferences/proc/HandlePrefsTopic(mob/user, list/href_list)
	if(href_list["toggle"]) switch(href_list["toggle"])
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
			var/UI_style_color_new = input(user, "Choose your UI color, dark colors are not recommended!") as color|null
			if(!UI_style_color_new) return
			UI_style_color = UI_style_color_new
		if("UIalpha")
			var/UI_style_alpha_new = input(user, "Select a new alpha(transparence) parametr for UI, between 50 and 255") as num
			if(!UI_style_alpha_new || UI_style_alpha_new > 255 || UI_style_alpha_new < 50) return
			UI_style_alpha = UI_style_alpha_new
		if("hear_midis")
			toggles ^= SOUND_MIDI
		if("lobby_music")
			toggles ^= SOUND_LOBBY
			if(toggles & SOUND_LOBBY)
				user << sound(ticker.login_music, repeat = 0, wait = 0, volume = 85, channel = 1)
			else
				user << sound(null, repeat = 0, wait = 0, volume = 85, channel = 1)
		if("ghost_ears")
			chat_toggles ^= CHAT_GHOSTEARS
		if("ghost_sight")
			chat_toggles ^= CHAT_GHOSTSIGHT
		if("ghost_radio")
			chat_toggles ^= CHAT_GHOSTRADIO
		if("dead_chat")
			chat_toggles ^= CHAT_DEAD
		if("hear_ooc")
			chat_toggles ^= CHAT_OOC
		if("hear_looc")
			chat_toggles ^= CHAT_LOOC
		if("chat_tags")
			toggles ^= CHAT_NOICONS
		if("ambience")
			toggles ^= SOUND_AMBIENCE
		if("emote_localization")
			toggles ^= RUS_AUTOEMOTES
		if("show_motd")
			toggles ^= HIDE_MOTD
	else if(href_list["be_special"])
		var/num = text2num(href_list["be_special"])
		be_special ^= (1<<num)

/datum/preferences/proc/GetSpeciesPage(mob/user)
	if(!species_preview || !(species_preview in all_species))
		species_preview = "Human"
	var/datum/species/show_species = all_species[species_preview]
	var/dat = list()
	dat += "<select onchange=\"set('preview', this.options\[this.selectedIndex\].text)\">"
	for(var/name in playable_species)
		dat += "<option [species_preview==name ? "selected" : null]>[name]</option>"

	dat += "</select>"

	var/restricted = 0
	if(jobban_isbanned(user, show_species.name))
		restricted = 1
	else if(config.usealienwhitelist) //If we're using the whitelist, make sure to check it!
		if(!(show_species.flags & CAN_JOIN))
			restricted = 2
		else if((show_species.flags & IS_WHITELISTED) && !is_alien_whitelisted(user,show_species))
			restricted = 1

	if(restricted)
		if(restricted == 1)
			dat += "<font color='red'><b>You cannot play as this species.</br><small>If you wish to be whitelisted, you can make an application post on <a href='?src=\ref[src];preference=open_whitelist_forum'>the forums</a>.</small></b></font></br>"
		else if(restricted == 2)
			dat += "<font color='red'><b>You cannot play as this species.</br><small>This species is not available for play as a station race..</small></b></font></br>"
	if(!restricted || check_rights(R_ADMIN, 0))
		dat += "\[<a href='?src=\ref[src];select_species=1'>select</a>\]<hr/>"

	dat += "<table padding='8px'>"
	dat += "<tr>"
	dat += "<td width = 180 align='center'>"
	if("preview" in icon_states(show_species.icobase))
		usr << browse_rsc(icon(show_species.icobase,"preview"), "species_preview_[show_species.name].png")
		dat += "<img src='species_preview_[show_species.name].png' width='64px' height='64px'><br/><br/>"
	dat += "<b>Language:</b> [show_species.language]<br/>"
	dat += "<small>"
	if(show_species.flags & CAN_JOIN)
		dat += "</br><b>Often present on human stations.</b>"
	if(show_species.flags & IS_WHITELISTED)
		dat += "</br><b>Whitelist restricted.</b>"
	if(show_species.flags & NO_BLOOD)
		dat += "</br><b>Does not have blood.</b>"
	if(show_species.flags & NO_BREATHE)
		dat += "</br><b>Does not breathe.</b>"
	if(show_species.flags & NO_SCAN)
		dat += "</br><b>Does not have DNA.</b>"
	if(show_species.flags & NO_PAIN)
		dat += "</br><b>Does not feel pain.</b>"
	if(show_species.flags & NO_SLIP)
		dat += "</br><b>Has excellent traction.</b>"
	if(show_species.flags & NO_POISON)
		dat += "</br><b>Immune to most poisons.</b>"
	if(show_species.flags & HAS_SKIN_TONE)
		dat += "</br><b>Has a variety of skin tones.</b>"
	if(show_species.flags & HAS_SKIN_COLOR)
		dat += "</br><b>Has a variety of skin colours.</b>"
	if(show_species.flags & HAS_EYE_COLOR)
		dat += "</br><b>Has a variety of eye colours.</b>"
	if(show_species.flags & IS_PLANT)
		dat += "</br><b>Has a plantlike physiology.</b>"
	if(show_species.flags & IS_SYNTHETIC)
		dat += "</br><b>Is machine-based.</b>"
	dat += "</small></td>"
	dat += "<td width = 400>[show_species.blurb]</td>"
	dat += "</tr>"
	dat += "</table><center>"

	dat += "</center>"
	return jointext(dat, "")

/datum/preferences/proc/HandleSpeciesTopic(mob/user, list/href_list)
	if(href_list["preview"])
		species_preview = href_list["preview"]
	else if(href_list["select_species"])
		if(!species_preview in playable_species || jobban_isbanned(user, species_preview))
			return
		var/datum/species/new_species = all_species[species_preview]
		if((new_species.flags&IS_WHITELISTED) && !is_alien_whitelisted(user,species_preview))
			return
		if(current_species.name != species_preview)
			var/datum/sprite_accessory/HS = hair_styles_list[h_style]
			if(HS.gender != gender || !(new_species.get_bodytype() in HS.species_allowed))
				//grab one of the valid hair styles for the newly chosen species
				var/list/hairstyles = get_hair_styles_list(new_species.get_bodytype(), gender)
				h_style = pick(hairstyles)

			HS = facial_hair_styles_list[f_style]
			if(HS.gender != gender || !(new_species.get_bodytype() in HS.species_allowed))
				//grab one of the valid facial hair styles for the newly chosen species
				var/list/facialstyles = get_facial_styles_list(new_species.get_bodytype(), gender)
				f_style = pick(facialstyles)

			//reset hair colour and skin colour
			if(!new_species.flags&HAS_SKIN_COLOR)
				hair_color = initial(hair_color)
			else
				if(!current_species.flags&HAS_SKIN_COLOR && new_species.base_color)
					hair_color = new_species.base_color

			if(! (new_species.flags & current_species.flags & HAS_SKIN_TONE) )
				s_tone = 0

			current_species = new_species
			species = new_species.name
			sanitize_body_build()

			current_page = PAGE_RECORDS

			req_update_icon = 1


#undef PAGE_RECORDS
#undef PAGE_LIMBS
#undef PAGE_OCCUPATION
#undef PAGE_LOADOUT
#undef PAGE_FLAVOR
#undef PAGE_PREFS
