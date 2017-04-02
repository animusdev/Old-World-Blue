// Slime limbs.
/obj/item/organ/external/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/slime/set_description(var/datum/organ_description/desc)
	..()
	if(organ_tag in list(BP_CHEST, BP_HEAD, BP_GROIN))
		gendered = 1

/obj/item/organ/external/head/slime
	cannot_break = 1
	dislocated = -1