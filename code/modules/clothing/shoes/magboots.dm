/obj/item/clothing/shoes/magboots
	desc = "Magnetic boots, often used during extravehicular activity to ensure the user remains safely attached to the vehicle. They're large enough to be worn over other footwear."
	name = "magboots"
	icon_state = "magboots0"
	species_restricted = null
	force = 3
	overshoes = 1
	var/obj/item/clothing/shoes/shoes = null	//Undershoes
	var/mob/living/carbon/human/wearer = null	//For shoe procs
	flags = PHORONGUARD
	item_flags = NOSLIP

/obj/item/clothing/shoes/magboots/proc/set_slowdown()
	slowdown = (shoes? max(0, shoes.slowdown): 0) + 1 //So you can't put on magboots to make you walk faster.
	slowdown += 2

/obj/item/clothing/shoes/magboots/mob_can_equip(mob/user, slot)
	if(slot != slot_shoes)
		return ..()

	var/mob/living/carbon/human/H = user

	if(H.shoes)
		shoes = H.shoes
		if(shoes.overshoes)
			user << "You are unable to wear \the [src] as \the [H.shoes] are in the way."
			shoes = null
			return 0
		H.drop_from_inventory(shoes)	//Remove the old shoes so you can put on the magboots.
		shoes.forceMove(src)

	if(!..())
		if(shoes) 	//Put the old shoes back on if the check fails.
			if(H.equip_to_slot_if_possible(shoes, slot_shoes))
				src.shoes = null
		return 0

	if (shoes)
		user << "You slip \the [src] on over \the [shoes]."
	set_slowdown()
	wearer = H
	return 1

/obj/item/clothing/shoes/magboots/dropped()
	..()
	var/mob/living/carbon/human/H = wearer
	if(shoes)
		if(!H.equip_to_slot_if_possible(shoes, slot_shoes))
			shoes.forceMove(get_turf(src))
		src.shoes = null
	wearer = null

/obj/item/clothing/shoes/magboots/toggleable
	var/magpulse = 0
	var/icon_base = "magboots"
	icon_action_button = "action_blank"
	action_button_name = "Toggle the magboots"

/obj/item/clothing/shoes/magboots/toggleable/set_slowdown()
	slowdown = (shoes? max(0, shoes.slowdown): 0) + 1 //So you can't put on magboots to make you walk faster.
	if (magpulse)
		slowdown += 2


/obj/item/clothing/shoes/magboots/toggleable/attack_self(mob/user)
	magpulse = !magpulse
	if(!magpulse)
		item_flags &= ~NOSLIP
		set_slowdown()
		force = 3
		if(icon_base) icon_state = "[icon_base]0"
		user << "You disable the mag-pulse traction system."
	else
		item_flags |= NOSLIP
		set_slowdown()
		force = 5
		if(icon_base) icon_state = "[icon_base]1"
		user << "You enable the mag-pulse traction system."
	user.update_inv_shoes()	//so our mob-overlays update

/obj/item/clothing/shoes/magboots/toggleable/examine(mob/user, return_dist=1)
	. = ..()
	if(.<=3)
		user << "Its mag-pulse traction system appears to be [item_flags&NOSLIP ? "enabled" : "disabled"]."



/obj/item/clothing/shoes/magboots/toggleable/advanced
	desc = "Advanced magnetic boots that have a lighter magnetic pull, placing less burden on the wearer."
	name = "advanced magboots"
	icon_state = "advmag0"
	icon_base = "advmag"

/obj/item/clothing/shoes/magboots/toggleable/advanced/set_slowdown()
	slowdown = (shoes? max(0, shoes.slowdown): 0) + 1 //So you can't put on magboots to make you walk faster.
	if (magpulse)
		slowdown += 1

/obj/item/clothing/shoes/magboots/toggleable/syndie
	desc = "Reverse-engineered magnetic boots that have a heavy magnetic pull. Property of Gorlex Marauders."
	name = "blood-red magboots"
	icon_state = "syndiemag0"
	icon_base = "syndiemag"
