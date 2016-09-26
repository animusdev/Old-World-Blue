
var/global/list/body_builds = list("male" = list(), "female" = list(), "neuter" = list(), "plural" = list())

/hook/startup/proc/populate_body_builds()
	var/list/paths = typesof(/datum/body_build)
	for(var/path in paths)
		var/datum/body_build/B = new path()
		for(var/g in B.genders)
			if(!g in body_builds)
				body_builds[g] = list()
			body_builds[g][B.name] = B
	return 1

/datum/body_build
	var/name			= "Default"
	var/genders			= list(MALE, FEMALE, NEUTER, PLURAL)
	var/index			= ""
	var/uniform_icon	= 'icons/mob/uniform.dmi'
	var/suit_icon		= 'icons/mob/suit.dmi'
	var/gloves_icon		= 'icons/mob/hands.dmi'
	var/glasses_icon	= 'icons/mob/eyes.dmi'
	var/ears_icon		= 'icons/mob/ears.dmi'
	var/mask_icon		= 'icons/mob/mask.dmi'
	var/hat_icon		= 'icons/mob/head.dmi'
	var/shoes_icon		= 'icons/mob/feet.dmi'
	var/misk_icon		= 'icons/mob/mob.dmi'
	var/belt_icon		= 'icons/mob/belt.dmi'
	var/s_store_icon	= 'icons/mob/belt_mirror.dmi'
	var/backpack_icon	= 'icons/mob/back.dmi'
	var/ties_icon		= 'icons/mob/ties.dmi'

	//Rig vars
	var/rig_back		= 'icons/mob/rig_back.dmi'

/datum/body_build/slim
	name			= "Slim"
	index			= "_slim"
	genders			= list(FEMALE)
	uniform_icon	= 'icons/mob/uniform_slim.dmi'
	suit_icon		= 'icons/mob/suit_slim.dmi'
	gloves_icon		= 'icons/mob/hands_slim.dmi'
	glasses_icon	= 'icons/mob/eyes_slim.dmi'
	ears_icon		= 'icons/mob/ears_slim.dmi'
	mask_icon		= 'icons/mob/mask_slim.dmi'
	shoes_icon		= 'icons/mob/feet_slim.dmi'
	belt_icon		= 'icons/mob/belt_slim.dmi'
	backpack_icon	= 'icons/mob/back_slim.dmi'
	ties_icon		= 'icons/mob/ties_slim.dmi'
	//Rig.
	rig_back		= 'icons/mob/rig_back_slim.dmi'

/mob/living/carbon/human/proc/update_body_build(var/regenerate_icon = 1)
	var/prefered_build = body_build ? body_build.name : ""
	var/body_build/selected = body_builds[gender][prefered_build]

	if(prefered_build in species.body_builds && selected)
		if(regenerate_icon && body_build != selected)
			spawn regenerate_icons()
		body_build = selected
		return 1

	for(var/name in species.body_builds)
		selected = body_builds[gender][name]
		if(selected)
			if(body_build != selected)
				spawn regenerate_icons()
				body_build = selected
			return 1
	return 0