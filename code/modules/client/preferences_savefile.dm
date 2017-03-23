#define SAVEFILE_VERSION_MIN	1
#define SAVEFILE_VERSION_MAX	2

//handles converting savefiles to new formats
//MAKE SURE YOU KEEP THIS UP TO DATE!
//If the sanity checks are capable of handling any issues. Only increase SAVEFILE_VERSION_MAX,
//this will mean that savefile_version will still be over SAVEFILE_VERSION_MIN, meaning
//this savefile update doesn't run everytime we load from the savefile.
//This is mainly for format changes, such as the bitflags in toggles changing order or something.
//if a file can't be updated, return 0 to delete it and start again
//if a file was updated, return 1
/datum/preferences/proc/savefile_update()
	if(savefile_version < SAVEFILE_VERSION_MIN)	//lazily delete everything + additional files so they can be saved in the new format
		for(var/ckey in preferences_datums)
			var/datum/preferences/D = preferences_datums[ckey]
			if(D == src)
				var/delpath = "data/player_saves/[copytext(ckey,1,2)]/[ckey]/"
				if(delpath && fexists(delpath))
					fdel(delpath)
					savefile_version = SAVEFILE_VERSION_MIN
				break
		return 0

	if(savefile_version < 2)
		savefile_version = 2

	if(savefile_version == SAVEFILE_VERSION_MAX)	//update successful.
		save_preferences()
		save_character()
		return 1
	return 0

/datum/preferences/proc/load_path(ckey,filename="preferences.sav")
	if(!ckey)	return
	path = "data/player_saves/[copytext(ckey,1,2)]/[ckey]/[filename]"
	savefile_version = SAVEFILE_VERSION_MAX

/datum/preferences/proc/load_preferences()
	if(!path)				return 0
	if(!fexists(path))		return 0
	var/savefile/S = new /savefile(path)
	if(!S)					return 0
	S.cd = "/"

	S["version"] >> savefile_version
	//Conversion
	if(!savefile_version || !isnum(savefile_version) || savefile_version < SAVEFILE_VERSION_MIN || savefile_version > SAVEFILE_VERSION_MAX)
		if(!savefile_update())  //handles updates
			savefile_version = SAVEFILE_VERSION_MAX
			save_preferences()
			save_character()
			return 0

	//general preferences
	S["ooccolor"]			>> ooccolor
	S["lastchangelog"]		>> lastchangelog
	S["UI_style"]			>> UI_style
	S["be_special"]			>> be_special
	S["default_slot"]		>> default_slot
	S["toggles"]			>> toggles
	S["chat_toggles"]		>> chat_toggles
	S["UI_style_color"]		>> UI_style_color
	S["UI_style_alpha"]		>> UI_style_alpha

	//Sanitize
	ooccolor		= sanitize_hexcolor(ooccolor, initial(ooccolor))
	lastchangelog	= sanitize_text(lastchangelog, initial(lastchangelog))
	UI_style		= sanitize_inlist(UI_style, list("White", "Midnight","Orange","old"), initial(UI_style))
	be_special		= sanitize_integer(be_special, 0, 65535, initial(be_special))
	default_slot	= sanitize_integer(default_slot, 1, config.character_slots, initial(default_slot))
	toggles			= sanitize_integer(toggles, 0, 65535, initial(toggles))
	chat_toggles	= sanitize_integer(chat_toggles, 0, 65535, initial(chat_toggles))
	UI_style_color	= sanitize_hexcolor(UI_style_color, initial(UI_style_color))
	UI_style_alpha	= sanitize_integer(UI_style_alpha, 0, 255, initial(UI_style_alpha))

	return 1

/datum/preferences/proc/save_preferences()
	if(!path)			return 0
	var/savefile/S =	new /savefile(path)
	if(!S)				return 0
	S.cd = "/"

	S["version"] 		<< savefile_version

	//general preferences
	S["ooccolor"]		<< ooccolor
	S["lastchangelog"]	<< lastchangelog
	S["UI_style"]		<< UI_style
	S["be_special"]		<< be_special
	S["default_slot"]	<< default_slot
	S["toggles"]		<< toggles
	S["chat_toggles"]	<< chat_toggles
	S["UI_style_color"]	<< UI_style_color
	S["UI_style_alpha"]	<< UI_style_alpha

	return 1

/datum/preferences/proc/load_character(slot)
	if(!path)				return 0
	if(!fexists(path))		return 0
	var/savefile/S = new /savefile(path)
	if(!S)					return 0
	S.cd = "/"
	if(!slot)	slot = default_slot
	slot = sanitize_integer(slot, 1, config.character_slots, initial(default_slot))
	if(slot != default_slot)
		default_slot = slot
		S["default_slot"] << slot
	S.cd = "/character[slot]"

	//Character
	S["real_name"]			>> real_name
	S["name_is_random"] 	>> random_name
	S["gender"]				>> gender
	S["age"]				>> age
	S["species"]			>> species
	S["body"]				>> body
	S["language"]			>> language
	S["spawnpoint"]			>> spawnpoint

	S["hair_color"]			>> hair_color
	S["facial_color"]		>> facial_color
	S["skin_color"]			>> skin_color
	S["eyes_color"]			>> eyes_color

	S["skin_tone"]			>> s_tone
	S["hair_style_name"]	>> h_style
	S["facial_style_name"]	>> f_style
	S["underwear"]			>> underwear
	S["undershirt"]			>> undershirt
	S["socks"]				>> socks
	S["backbag"]			>> backbag
	S["b_type"]				>> b_type

	//Jobs
	S["alternate_option"]	>> alternate_option
	S["high_job_title"]		>> high_job_title
	S["job_civilian_high"]	>> job_civilian_high
	S["job_civilian_med"]	>> job_civilian_med
	S["job_civilian_low"]	>> job_civilian_low
	S["job_medsci_high"]	>> job_medsci_high
	S["job_medsci_med"]		>> job_medsci_med
	S["job_medsci_low"]		>> job_medsci_low
	S["job_engsec_high"]	>> job_engsec_high
	S["job_engsec_med"]		>> job_engsec_med
	S["job_engsec_low"]		>> job_engsec_low

	//Flavour Text
	for(var/flavor in flavs_list)
		S["flavor_texts_[flavor]"]	>> flavor_texts[flavor]

	//Flavour text for robots.
	S["flavor_texts_robot_Default"] >> flavor_texts_robot["Default"]
	for(var/module in robot_modules)
		S["flavour_texts_robot_[module]"] >> flavor_texts_robot[module]

	S["relations"]			>> relations
	S["relations_info"]		>> relations_info

	var/mod_id = "nothing"
	var/color = "#ffffff"
	for(var/organ in modifications_types)
		S["modification_[organ]"] >> mod_id
		S["color_[organ]"] >> color
		modifications_data[organ] = mod_id ? body_modifications[mod_id] : get_default_modificaton()
		modifications_colors[organ] = color ? color : "#ffffff"

	check_child_modifications()

	//Miscellaneous
	S["med_record"]			>> med_record
	S["sec_record"]			>> sec_record
	S["gen_record"]			>> gen_record
	S["be_special"]			>> be_special
	S["disabilities"]		>> disabilities
	S["player_alt_titles"]	>> player_alt_titles
	S["gear"]				>> gear
	S["home_system"] 		>> home_system
	S["citizenship"] 		>> citizenship
	S["faction"] 			>> faction
	S["religion"] 			>> religion

	S["nanotrasen_relation"] >> nanotrasen_relation
	//S["skin_style"]			>> skin_style

	S["uplinklocation"] >> uplinklocation
	S["exploit_record"]	>> exploit_record

	//Sanitize
	if(isnull(species) || !(species in playable_species))
		species = "Human"
	current_species = all_species[species]

	real_name		= current_species.sanitize_name(real_name)

	if(!underwear  || !(underwear in all_underwears))   underwear = pick(all_underwears)
	if(!undershirt || !(undershirt in all_undershirts)) undershirt = pick(all_undershirts)
	if(!socks || !(socks in all_socks)) socks = pick(all_socks)


	if(isnull(language)) language = "None"
	if(isnull(spawnpoint)) spawnpoint = "Arrivals Shuttle"
	if(isnull(nanotrasen_relation)) nanotrasen_relation = initial(nanotrasen_relation)
	if(!real_name) real_name = random_name(gender, species)
	random_name		= sanitize_integer(random_name, 0, 1, initial(random_name))
	gender			= sanitize_gender(gender)
	age				= sanitize_integer(age, current_species.min_age, current_species.max_age, initial(age))
	hair_color		= sanitize_hexcolor(hair_color, initial(hair_color))
	facial_color	= sanitize_hexcolor(facial_color, initial(facial_color))
	s_tone			= sanitize_integer(s_tone, 1, 220, initial(s_tone))
	skin_color		= sanitize_hexcolor(skin_color, initial(skin_color))
	h_style			= sanitize_inlist(h_style, hair_styles_list, initial(h_style))
	f_style			= sanitize_inlist(f_style, facial_hair_styles_list, initial(f_style))
	eyes_color		= sanitize_hexcolor(eyes_color, initial(eyes_color))
	backbag			= sanitize_integer(backbag, 1, backbaglist.len, initial(backbag))
	b_type			= sanitize_text(b_type, initial(b_type))

	alternate_option  = sanitize_integer(alternate_option,  0, 2,     initial(alternate_option))
	job_civilian_high = sanitize_integer(job_civilian_high, 0, 65535, initial(job_civilian_high))
	job_civilian_med  = sanitize_integer(job_civilian_med,  0, 65535, initial(job_civilian_med))
	job_civilian_low  = sanitize_integer(job_civilian_low,  0, 65535, initial(job_civilian_low))
	job_medsci_high   = sanitize_integer(job_medsci_high,   0, 65535, initial(job_medsci_high))
	job_medsci_med    = sanitize_integer(job_medsci_med,    0, 65535, initial(job_medsci_med))
	job_medsci_low    = sanitize_integer(job_medsci_low,    0, 65535, initial(job_medsci_low))
	job_engsec_high   = sanitize_integer(job_engsec_high,   0, 65535, initial(job_engsec_high))
	job_engsec_med    = sanitize_integer(job_engsec_med,    0, 65535, initial(job_engsec_med))
	job_engsec_low    = sanitize_integer(job_engsec_low,    0, 65535, initial(job_engsec_low))

	sanitize_body_build()

	if(isnull(disabilities)) disabilities = 0
	if(!player_alt_titles) player_alt_titles = new()
	if(!modifications_data) src.modifications_data = list()
	if(!modifications_colors) src.modifications_colors = list()
	if(!gear) src.gear = list()
	if(!relations) src.relations = list()
	if(!relations_info) src.relations_info = list()

	if(!home_system) home_system = "Unset"
	if(!citizenship) citizenship = "None"
	if(!faction)     faction =     "None"
	if(!religion)    religion =    "None"

	return 1

/datum/preferences/proc/save_character(slot)
	if(!path)				return 0
	var/savefile/S = new /savefile(path)
	if(!S)					return 0
	S.cd = "/"
	if(!slot)	slot = default_slot
	slot = sanitize_integer(slot, 1, config.character_slots, initial(default_slot))
	if(slot != default_slot)
		default_slot = slot
		S["default_slot"] << slot
	S.cd = "/character[slot]"

	//Character
	S["real_name"]			<< real_name
	S["name_is_random"] 	<< random_name
	S["gender"]				<< gender
	S["body"]				<< body
	S["age"]				<< age
	S["species"]			<< species
	S["language"]			<< language
	S["hair_color"]			<< hair_color
	S["facial_color"]		<< facial_color
	S["skin_tone"]			<< s_tone
	S["skin_color"]			<< skin_color
	S["hair_style_name"]	<< h_style
	S["facial_style_name"]	<< f_style
	S["eyes_color"]			<< eyes_color
	S["underwear"]			<< underwear
	S["undershirt"]			<< undershirt
	S["socks"]				<< socks
	S["backbag"]			<< backbag
	S["b_type"]				<< b_type
	S["spawnpoint"]			<< spawnpoint

	//Jobs
	S["alternate_option"]	<< alternate_option
	S["high_job_title"]		<< high_job_title
	S["job_civilian_high"]	<< job_civilian_high
	S["job_civilian_med"]	<< job_civilian_med
	S["job_civilian_low"]	<< job_civilian_low
	S["job_medsci_high"]	<< job_medsci_high
	S["job_medsci_med"]		<< job_medsci_med
	S["job_medsci_low"]		<< job_medsci_low
	S["job_engsec_high"]	<< job_engsec_high
	S["job_engsec_med"]		<< job_engsec_med
	S["job_engsec_low"]		<< job_engsec_low

	//Flavour Text
	for(var/flavor in flavs_list)
		S["flavor_texts_[flavor]"]	<< flavor_texts[flavor]

	//Flavour text for robots.
	S["flavour_texts_robot_Default"] << flavor_texts_robot["Default"]
	for(var/module in robot_modules)
		S["flavour_texts_robot_[module]"] << flavor_texts_robot[module]

	S["relations"]			<< relations
	S["relations_info"]		<< relations_info

	for(var/organ in modifications_types)
		var/datum/body_modification/BM = get_modification(organ)
		S["modification_[organ]"] << BM.id
		S["color_[organ]"]  	  << modifications_colors[organ]

	//Miscellaneous
	S["med_record"]			<< med_record
	S["sec_record"]			<< sec_record
	S["gen_record"]			<< gen_record
	S["player_alt_titles"]	<< player_alt_titles
	S["be_special"]			<< be_special
	S["disabilities"]		<< disabilities
	S["gear"]				<< gear
	S["home_system"] 		<< home_system
	S["citizenship"] 		<< citizenship
	S["faction"] 			<< faction
	S["religion"] 			<< religion

	S["nanotrasen_relation"]<< nanotrasen_relation

	S["uplinklocation"]		<< uplinklocation
	S["exploit_record"]		<< exploit_record

	return 1

/datum/preferences/proc/delete_character(var/slot)
	if(!path || !slot)			return 0
	var/savefile/S = new /savefile(path)
	if(!S)					return 0
	S.cd = "/character[slot]"
	var/char_name = ""
	S["real_name"] >> char_name
	if(char_name && alert("Are you realy wanna delete [char_name]?", "Delete", "Yes", "No") == "Yes")
		S.cd = "/"
		S.dir -= "character[slot]"

	return 1


#undef SAVEFILE_VERSION_MAX
#undef SAVEFILE_VERSION_MIN
