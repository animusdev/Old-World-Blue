/datum/species/proc/get_body_build(var/gender, var/prefered)
	for(var/datum/body_build/BB in body_builds)
		if( (!prefered || BB.name == prefered) && (gender in BB.genders) )
			return BB

/datum/species/proc/get_body_build_list(var/gender)
	. = list()
	for(var/datum/body_build/BB in body_builds)
		if(gender in BB.genders)
			. += BB.name

/datum/species/proc/get_random_name(var/gender)
	if(!name_language)
		if(gender == FEMALE)
			return capitalize(pick(first_names_female)) + " " + capitalize(pick(last_names))
		else
			return capitalize(pick(first_names_male)) + " " + capitalize(pick(last_names))

	var/datum/language/species_language = all_languages[name_language]
	if(!species_language)
		species_language = all_languages[default_language]
	if(!species_language)
		return "unknown"
	return species_language.get_random_name(gender)

/datum/species/machine/get_random_name(var/gender)
	return "[pick(list("PBU","HIU","SINA","ARMA","OSI"))]-[rand(100, 999)]"