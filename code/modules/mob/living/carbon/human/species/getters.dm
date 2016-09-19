
/datum/species/proc/get_blood_colour(var/mob/living/carbon/human/H)
	if(H)
		var/datum/robolimb/company = H.isSynthetic()
		if(company)
			return company.blood_color
		else
			return blood_color

