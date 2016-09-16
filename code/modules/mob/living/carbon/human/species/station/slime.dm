/datum/species/human/slime
	name = "Slime"
	name_plural = "slimes"
	is_small = 1

	icobase = 'icons/mob/human_races/r_slime.dmi'
	deform = 'icons/mob/human_races/r_slime.dmi'

	language = "Sol Common" //todo?
	unarmed_attacks = list(
		new/datum/unarmed_attack/slime_glomp
		)
	flags = IS_RESTRICTED | NO_BLOOD | NO_SCAN | NO_SLIP | NO_BREATHE
	siemens_coefficient = 3
	darksight = 3

	blood_color = "#05FF9B"
	flesh_color = "#05FFFB"

	remains_type = /obj/effect/decal/cleanable/ash
	death_message = "rapidly loses cohesion, splattering across the ground..."

	has_organ = list(
		"brain" = /obj/item/organ/internal/brain/slime
		)

	breath_type = null
	poison_type = null

	bump_flag = SLIME
	swap_flags = MONKEY|SLIME|SIMPLE_ANIMAL
	push_flags = MONKEY|SLIME|SIMPLE_ANIMAL

	has_limbs = list(
		"chest" =  new /datum/organ_description/slime,
		"groin" =  new /datum/organ_description/groin/slime,
		"head" =   new /datum/organ_description/head/slime,
		"l_arm" =  new /datum/organ_description/arm/left/slime,
		"r_arm" =  new /datum/organ_description/arm/right/slime,
		"l_leg" =  new /datum/organ_description/leg/left/slime,
		"r_leg" =  new /datum/organ_description/leg/right/slime,
		"l_hand" = new /datum/organ_description/hand/left/slime,
		"r_hand" = new /datum/organ_description/hand/right/slime,
		"l_foot" = new /datum/organ_description/foot/left/slime,
		"r_foot" = new /datum/organ_description/foot/right/slime
	)

/datum/species/human/slime/handle_death(var/mob/living/carbon/human/H)
	spawn(1)
		if(H)
			H.gib()
