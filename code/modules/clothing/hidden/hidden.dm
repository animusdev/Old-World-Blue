/obj/item/clothing/hidden
	var/wear_slot = 0
	var/slot_name = ""
	desc = "Totally what you think it is"
	w_class = 1

/obj/item/clothing/hidden/New()
	..()
	if(!wear_state)
		wear_state = icon_state

/*
/obj/item/clothing/hidden/mob_can_equip(M as mob, slot, disable_warning = 0)
	if(slot == slot_socks)
		if(!M) return 0

		if(!ishuman(M)) return 0

		var/mob/living/carbon/human/H = M

		var/mob/_user = disable_warning? null : H
		if(!H.slot_is_accessible(slot, src, _user))
			return 0

		if(H.get_equipped_item(wear_slot)) return 0
	return ..()
*/
/obj/item/clothing/hidden/attack_self(mob/living/carbon/human/user)
	if(!istype(user)) return
	if(user.equip_to_slot_if_possible(src, wear_slot))
		user << "<span class = 'notice'>You equip [name] in [slot_name] slot.</span>"
