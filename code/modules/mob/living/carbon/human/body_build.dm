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
	var/hidden_icon = 'icons/mob/hidden.dmi'
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
	mask_icon		= 'icons/mob/mask_slim.dmi'
	shoes_icon		= 'icons/mob/feet_f.dmi'
	belt_icon		= 'icons/mob/belt_f.dmi'
	back_icon		= 'icons/mob/back_f.dmi'
	ties_icon		= 'icons/mob/ties_f.dmi'
	hidden_icon 	= 'icons/mob/hidden_f.dmi'
	rig_back		= 'icons/mob/rig_back_slim.dmi'

/datum/body_build/vox
	name		= "Vox"
	uniform_icon= 'icons/mob/species/vox/uniform.dmi'
	suit_icon	= 'icons/mob/species/vox/suit.dmi'
	gloves_icon	= 'icons/mob/species/vox/gloves.dmi'
	glasses_icon= 'icons/mob/species/vox/eyes.dmi'
	mask_icon	= 'icons/mob/species/vox/masks.dmi'
	shoes_icon	= 'icons/mob/species/vox/shoes.dmi'
	ties_icon	= 'icons/mob/species/vox/ties.dmi'
