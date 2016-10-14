/datum/species/proc/get_body_build(var/gender, var/prefered)
	for(var/datum/body_build/BB in body_builds)
		if( (!prefered || BB.name == prefered) && (gender in BB.genders) )
			return BB

/datum/species/proc/get_body_build_list(var/gender)
	. = list()
	for(var/datum/body_build/BB in body_builds)
		if(gender in BB.genders)
			. += BB.name