/datum/species/human/slime
	name = "Slime"
	name_plural = "slimes"
	is_small = 1

	icobase = 'icons/mob/human_races/slime.dmi'
	deform = 'icons/mob/human_races/slime.dmi'

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
		O_BRAIN = /obj/item/organ/internal/brain/slime
	)

	breath_type = null
	poison_type = null

	bump_flag = SLIME
	swap_flags = MONKEY|SLIME|SIMPLE_ANIMAL
	push_flags = MONKEY|SLIME|SIMPLE_ANIMAL

	has_limbs = list(
		BP_CHEST =  new /datum/organ_description/chest/slime,
		BP_GROIN =  new /datum/organ_description/groin/slime,
		BP_HEAD =   new /datum/organ_description/head/slime,
		BP_L_ARM =  new /datum/organ_description/arm/left/slime,
		BP_R_ARM =  new /datum/organ_description/arm/right/slime,
		BP_L_LEG =  new /datum/organ_description/leg/left/slime,
		BP_R_LEG =  new /datum/organ_description/leg/right/slime,
		BP_L_HAND = new /datum/organ_description/hand/left/slime,
		BP_R_HAND = new /datum/organ_description/hand/right/slime,
		BP_L_FOOT = new /datum/organ_description/foot/left/slime,
		BP_R_FOOT = new /datum/organ_description/foot/right/slime
	)

/datum/species/human/slime/handle_death(var/mob/living/carbon/human/H)
	spawn(1)
		if(H)
			H.gib()
