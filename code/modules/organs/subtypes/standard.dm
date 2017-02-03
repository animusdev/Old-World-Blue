/****************************************************
			   ORGAN DEFINES
****************************************************/

/obj/item/organ/external/chest
	name = "upper body"
	organ_tag = BP_CHEST
	max_damage = 100
	min_broken_damage = 35
	w_class = 5
	body_part = UPPER_TORSO
	vital = 1
	amputation_point = "spine"
	joint = "neck"
	dislocated = -1
	gendered = 1
	cannot_amputate = 1
	parent_organ = null
	encased = "ribcage"

/obj/item/organ/external/groin
	name = "lower body"
	organ_tag = BP_GROIN
	max_damage = 100
	min_broken_damage = 35
	w_class = 5
	body_part = LOWER_TORSO
	vital = 1
	parent_organ = BP_CHEST
	amputation_point = "lumbar"
	joint = "hip"
	dislocated = -1
	gendered = 1

/obj/item/organ/external/limb
	max_damage = 50
	min_broken_damage = 30
	w_class = 3

/obj/item/organ/external/tiny
	min_broken_damage = 15
	w_class = 2

/obj/item/organ/external/head
	organ_tag = BP_HEAD
	name = "head"
	max_damage = 75
	min_broken_damage = 35
	w_class = 3
	body_part = HEAD
	vital = 1
	parent_organ = BP_CHEST
	joint = "jaw"
	amputation_point = "neck"
	gendered = 1
	encased = "skull"

/obj/item/organ/external/head/removed(user, delete_children)
	if(owner)
		var/mob/living/carbon/human/last_owner = owner
		name = "[owner.real_name]'s head"
		spawn(1)
			if(last_owner)
				last_owner.update_hair()
	return ..()

/obj/item/organ/external/head/take_damage(brute, burn, sharp, edge, used_weapon = null, list/forbidden_limbs = list())
	..(brute, burn, sharp, edge, used_weapon, forbidden_limbs)
	if (!disfigured)
		if (brute_dam > 40)
			if (prob(50))
				disfigure("brute")
		if (burn_dam > 40)
			disfigure("burn")