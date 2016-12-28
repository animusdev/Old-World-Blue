/datum/body_build
	var/name		= "Default"
	var/genders		= list(MALE, FEMALE, NEUTER, PLURAL)
	var/index		= ""
	var/misk_icon	= 'icons/mob/mob.dmi'
	var/uniform_icon= 'icons/inv_slots/uniforms/mob_default.dmi'
	var/suit_icon	= 'icons/inv_slots/suits/mob_default.dmi'
	var/gloves_icon	= 'icons/inv_slots/gloves/mob_default.dmi'
	var/glasses_icon= 'icons/inv_slots/glasses/mob_default.dmi'
	var/ears_icon	= 'icons/inv_slots/ears/mob_default.dmi'
	var/mask_icon	= 'icons/inv_slots/masks/mob_default.dmi'
	var/hat_icon	= 'icons/inv_slots/hats/mob_default.dmi'
	var/shoes_icon	= 'icons/inv_slots/shoes/mob_default.dmi'
	var/belt_icon	= 'icons/inv_slots/belts/mob_default.dmi'
	var/s_store_icon= 'icons/mob/belt_mirror.dmi'
	var/back_icon	= 'icons/inv_slots/back/mob_default.dmi'
	var/ties_icon	= 'icons/inv_slots/acessories/mob_default.dmi'
	var/hidden_icon = 'icons/inv_slots/hidden/mob_default.dmi'
	var/rig_back	= 'icons/inv_slots/rig/mob_default.dmi'

	var/r_hand		= 'icons/mob/items/righthand.dmi'
	var/l_hand		= 'icons/mob/items/lefthand.dmi'

	var/list/hand_groups = list()

/datum/body_build/New()
	hand_groups = list(
		"[SPRITE_STORAGE]_l"  = 'icons/inv_slots/back/hand_l_default.dmi',
		"[SPRITE_STORAGE]_r"  = 'icons/inv_slots/back/hand_r_default.dmi',
		"[SPRITE_UNIFORMS]_l" = 'icons/inv_slots/uniforms/hand_l_default.dmi',
		"[SPRITE_UNIFORMS]_r" = 'icons/inv_slots/uniforms/hand_r_default.dmi',
		"[SPRITE_GUNS]_l"     = 'icons/inv_slots/items/guns_l_default.dmi',
		"[SPRITE_GUNS]_r"     = 'icons/inv_slots/items/guns_r_default.dmi'

	)

/datum/body_build/proc/get_inhand_icon(var/group, var/hand)
	if(hand == LEFT)
		group += "_l"
	else
		group += "_r"
	if(group in hand_groups)
		return hand_groups[group]
	else
		return (hand == LEFT) ? l_hand : r_hand

/datum/body_build/slim
	name			= "Slim"
	index			= "_slim"
	genders			= list(FEMALE)
	uniform_icon	= 'icons/inv_slots/uniforms/mob_slim.dmi'
	suit_icon		= 'icons/inv_slots/suits/mob_slim.dmi'
	gloves_icon		= 'icons/inv_slots/gloves/mob_slim.dmi'
	glasses_icon	= 'icons/inv_slots/glasses/mob_slim.dmi'
	ears_icon		= 'icons/inv_slots/ears/mob_slim.dmi'
	mask_icon		= 'icons/inv_slots/masks/mob_slim.dmi'
	shoes_icon		= 'icons/inv_slots/shoes/mob_slim.dmi'
	belt_icon		= 'icons/inv_slots/belts/mob_slim.dmi'
	back_icon		= 'icons/inv_slots/back/mob_slim.dmi'
	ties_icon		= 'icons/inv_slots/acessories/mob_slim.dmi'
	hidden_icon 	= 'icons/inv_slots/hidden/mob_slim.dmi'
	rig_back		= 'icons/inv_slots/rig/mob_slim.dmi'

/datum/body_build/slim/New()
	hand_groups = list(
		"[SPRITE_STORAGE]_l"  = 'icons/inv_slots/back/hand_l_default.dmi',
		"[SPRITE_STORAGE]_r"  = 'icons/inv_slots/back/hand_r_default.dmi',
		"[SPRITE_UNIFORMS]_l" = 'icons/inv_slots/uniforms/hand_l_slim.dmi',
		"[SPRITE_UNIFORMS]_r" = 'icons/inv_slots/uniforms/hand_r_slim.dmi',
		"[SPRITE_GUNS]_l"     = 'icons/inv_slots/items/guns_l_default.dmi',
		"[SPRITE_GUNS]_r"     = 'icons/inv_slots/items/guns_r_default.dmi'

	)
/datum/body_build/vox
	name		= "Vox"
	uniform_icon= 'icons/inv_slots/uniforms/mob_vox.dmi'
	suit_icon	= 'icons/inv_slots/suits/mob_vox.dmi'
	gloves_icon	= 'icons/inv_slots/gloves/mob_vox.dmi'
	glasses_icon= 'icons/inv_slots/glasses/mob_vox.dmi'
	mask_icon	= 'icons/inv_slots/masks/mob_vox.dmi'
	shoes_icon	= 'icons/inv_slots/shoes/mob_vox.dmi'
	ties_icon	= 'icons/inv_slots/acessories/mob_vox.dmi'
