/datum/body_build
	var/name		= "Default"
	var/genders		= list(MALE, FEMALE, NEUTER, PLURAL)
	var/index		= ""
	var/uniform_icon= 'icons/mob/uniform.dmi'
	var/suit_icon	= 'icons/mob/suit.dmi'
	var/gloves_icon	= 'icons/mob/hands.dmi'
	var/glasses_icon= 'icons/mob/eyes.dmi'
	var/ears_icon	= 'icons/mob/ears.dmi'
	var/mask_icon	= 'icons/mob/mask.dmi'
	var/hat_icon	= 'icons/mob/head.dmi'
	var/shoes_icon	= 'icons/mob/feet.dmi'
	var/misk_icon	= 'icons/mob/mob.dmi'
	var/belt_icon	= 'icons/mob/belt.dmi'
	var/s_store_icon= 'icons/mob/belt_mirror.dmi'
	var/back_icon	= 'icons/mob/back.dmi'
	var/ties_icon	= 'icons/mob/ties.dmi'
	var/rig_back	= 'icons/mob/rig_back.dmi'

/datum/body_build/slim
	name			= "Slim"
	index			= "_slim"
	genders			= list(FEMALE)
	uniform_icon	= 'icons/mob/uniform_f.dmi'
	suit_icon		= 'icons/mob/suit_f.dmi'
	gloves_icon		= 'icons/mob/hands_f.dmi'
	glasses_icon	= 'icons/mob/eyes_f.dmi'
	ears_icon		= 'icons/mob/ears_f.dmi'
	mask_icon		= 'icons/mob/mask_f.dmi'
	shoes_icon		= 'icons/mob/feet_f.dmi'
	belt_icon		= 'icons/mob/belt_f.dmi'
	back_icon		= 'icons/mob/back_f.dmi'
	ties_icon		= 'icons/mob/ties_f.dmi'
	rig_back		= 'icons/mob/rig_back_slim.dmi'

/proc/get_body_build(gender, prefered_build = "Default", var/list/limited_to)
	if(limited_to && !(prefered_build in limited_to))
		prefered_build = limited_to[1]
	if(prefered_build in body_builds[gender])
		return body_builds[gender][prefered_build]

	for(var/name in limited_to)
		if(body_builds[gender][name])
			return body_builds[gender][name]

	return body_builds[gender][body_builds[gender][1]]

/proc/get_body_build_list(gender = MALE, limited_to)
	return body_builds[gender]&limited_to

/mob/living/carbon/human/proc/update_body_build(var/update_icon = 1)
	if(gender in body_build.genders && body_build.name in species.body_builds)
		return 1

	body_build = get_body_build(gender, body_build.name, species.body_builds)
	if(update_icon) regenerate_icons()
	return 0