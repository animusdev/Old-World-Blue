/datum/species/arachna
	name = "Arachna"
	name_plural = "Arachnas"
	language = "Sol Common"
	primitive_form = "Monkey"
//	eyes = "arachna_eyes"
	unarmed_attacks = list(
		new /datum/unarmed_attack/stomp,
		new /datum/unarmed_attack/kick,
		new /datum/unarmed_attack/punch,
		new /datum/unarmed_attack/bite
		)
	gluttonous = 1
	blurb = "Arachna history here"


	inherent_verbs = list(
		/mob/living/carbon/human/arachna/verb/add_venom,
		/mob/living/carbon/human/arachna/verb/remove_venom,
		/mob/living/carbon/human/arachna/proc/prepare_bite,
		/mob/living/carbon/human/arachna/proc/use_silk_gland
	)

	has_organ = list(
		"lungs" =        /obj/item/organ/internal/lungs,
		"heart" =        /obj/item/organ/internal/heart/arachna,
		"kidneys" =      /obj/item/organ/internal/kidneys/arachna,
		"eyes" =         /obj/item/organ/internal/eyes,
		"liver" =        /obj/item/organ/internal/liver,
		"appendix" =     /obj/item/organ/internal/appendix,
		"poison_gland" = /obj/item/organ/internal/arachna/poison_gland,
		"silk_gland" =   /obj/item/organ/internal/arachna/silk_gland,
		"brain" =        /obj/item/organ/internal/brain
		)

	has_limbs = list(
		"chest" =  /datum/organ_description,
		"groin" =  /datum/organ_description/groin/arachna,
		"head"   = /datum/organ_description/head,
		"l_arm"  = /datum/organ_description/arm/left,
		"r_arm"  = /datum/organ_description/arm/right,
		"l_leg"  = /datum/organ_description/leg/left,
		"r_leg"  = /datum/organ_description/leg/right,
		"l_hand" = /datum/organ_description/hand/left,
		"r_hand" = /datum/organ_description/hand/right,
		"l_foot" = /datum/organ_description/foot/left,
		"r_foot" = /datum/organ_description/foot/right
	)

	/*has_limbs = list(
		"chest" =    list("path" = /obj/item/organ/external/chest),
		"abdomen" =  list("path" = /obj/item/organ/external/groin/arachna),
		"head" =     list("path" = /obj/item/organ/external/head),
		"l_arm" =    list("path" = /obj/item/organ/external/arm),
		"r_arm" =    list("path" = /obj/item/organ/external/arm/right),
		"l_hand" =   list("path" = /obj/item/organ/external/hand),
		"r_hand" =   list("path" = /obj/item/organ/external/hand/right),
		"l_f_leg" =  list("path" = /obj/item/organ/external/leg/arachna/left/f_leg),
		"l_f_foot" = list("path" = /obj/item/organ/external/foot/arachna/left/f_foot),
		"l_mf_leg" =  list("path" = /obj/item/organ/external/leg/arachna/left/mf_leg),
		"l_mf_foot" = list("path" = /obj/item/organ/external/foot/arachna/left/mf_foot),
		"l_mb_leg" =  list("path" = /obj/item/organ/external/leg/arachna/left/mb_leg),
		"l_mb_foot" = list("path" = /obj/item/organ/external/foot/arachna/left/mb_foot),
		"l_b_leg" =  list("path" = /obj/item/organ/external/leg/arachna/left/b_leg),
		"l_b_foot" = list("path" = /obj/item/organ/external/foot/arachna/left/b_foot),
		"r_f_leg" =  list("path" = /obj/item/organ/external/leg/arachna/right/f_leg),
		"r_f_foot" = list("path" = /obj/item/organ/external/foot/arachna/right/f_foot),
		"r_mf_leg" =  list("path" = /obj/item/organ/external/leg/arachna/right/mf_leg),
		"r_mf_foot" = list("path" = /obj/item/organ/external/foot/arachna/right/mf_foot),
		"r_mb_leg" =  list("path" = /obj/item/organ/external/leg/arachna/right/mb_leg),
		"r_mb_foot" = list("path" = /obj/item/organ/external/foot/arachna/right/mb_foot),
		"r_b_leg" =  list("path" = /obj/item/organ/external/leg/arachna/right/b_leg),
		"r_b_foot" = list("path" = /obj/item/organ/external/foot/arachna/right/b_foot)
	)*/


	flags = IS_RESTRICTED | IS_WHITELISTED | HAS_SKIN_TONE | HAS_EYE_COLOR

	icobase = 'code/modules/mob/living/carbon/arachna/r_arachna.dmi'
	deform = 'code/modules/mob/living/carbon/arachna/r_def_arachna.dmi'

	get_uniform_sprite(state = "")
		return 'code/modules/mob/living/carbon/arachna/arachna_uniform.dmi'

	get_suit_sprite(state = "")
		return 'code/modules/mob/living/carbon/arachna/arachna_suit.dmi'

	get_gloves_sprite(state = "")
		return 'code/modules/mob/living/carbon/arachna/arachna_hands.dmi'

//	get_shoes_sprite(state = "", body_build = 0)
//		if(body_build==BODY_SLIM)
//			return 'code\modules/mob/living/carbon/arachna/feet_f.dmi'
//		else
//			return 'code\modules/mob/living/carbon/arachna/feet.dmi'

	get_glasses_sprite(state = "")
		return 'code/modules/mob/living/carbon/arachna/arachna_eyes.dmi'

	get_belt_sprite(state = "")
		return 'code/modules/mob/living/carbon/arachna/arachna_belt.dmi'

	get_ears_sprite(state = "")
		return 'code/modules/mob/living/carbon/arachna/arachna_ears.dmi'

	get_back_sprite(state = "")
		return 'code/modules/mob/living/carbon/arachna/arachna_back.dmi'

	get_mask_sprite(state = "")
		return 'code/modules/mob/living/carbon/arachna/arachna_mask.dmi'

/datum/species/arachna/handle_post_spawn(var/mob/living/carbon/human/H)
	H.gender = FEMALE
	return ..()




datum/species/arachna/Stat(var/mob/living/carbon/human/H)
	..()
	var/obj/item/organ/internal/arachna/P = H.internal_organs_by_name["poison_gland"]
	if(P)
		stat("Poison Stored:", " [P.reagents.total_volume]/[P.reagents.maximum_volume]")
	P = H.internal_organs_by_name["silk_gland"]
	if(P)
		stat("Silk Stored:", " [P:silk]/[P:silk_max]")
	return
