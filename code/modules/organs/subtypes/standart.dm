/****************************************************
			   ORGAN DEFINES
****************************************************/

/obj/item/organ/external/chest
	vital = 1
	gendered = 1
	dislocated = -1
	cannot_amputate = 1
	encased = "ribcage"

/obj/item/organ/external/groin
	vital = 1
	gendered = 1
	dislocated = -1

/obj/item/organ/external/head
	vital = 1
	gendered = 1
	encased = "skull"
	var/hairstyle
	var/real_name

/obj/item/organ/external/head/removed(user, delete_children)
	if(owner)
		var/mob/living/carbon/human/last_owner = owner
		name = "[owner.name]'s head"
		hairstyle = owner.h_style
		real_name = owner.real_name
		spawn(1)
			if(last_owner)
				last_owner.update_hair()
	return ..()

/obj/item/organ/external/head/install()
	if(..()) return 1

	name = "head"
	if(hairstyle)
		owner.h_style = hairstyle
	if(real_name)
		owner.real_name = real_name
	owner.update_body()

/obj/item/organ/external/head/take_damage(brute, burn, sharp, edge, used_weapon = null, list/forbidden_limbs = list())
	..(brute, burn, sharp, edge, used_weapon, forbidden_limbs)
	if (!disfigured)
		if (brute_dam > 40)
			if (prob(50))
				disfigure("brute")
		if (burn_dam > 40)
			disfigure("burn")