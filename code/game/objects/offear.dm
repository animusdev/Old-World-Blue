/obj/item/dropped(user)
	. = ..()
	if(slot_flags & SLOT_TWOEARS)
		var/mob/living/carbon/human/H = user
		var/obj/item/offear/Other = null

		if(H.l_ear && istype(H.l_ear, /obj/item/offear))
			Other = H.l_ear
		else if(H.r_ear && istype(H.r_ear, /obj/item/offear))
			Other = H.r_ear

		if(Other) H.unEquip(Other)

/obj/item/equipped(user, slot)
	. = ..()
	if(slot_flags & SLOT_TWOEARS)
		var/mob/living/carbon/human/H = user
		if(istype(H))
			if(slot == slot_l_ear)
				H.equip_to_slot(new /obj/item/offear(src), slot_r_ear, 0)
			else if(slot == slot_r_ear)
				H.equip_to_slot(new /obj/item/offear(src), slot_l_ear, 0)
	return

/obj/item/update_icon()
	. = ..()
	if(slot_flags & SLOT_TWOEARS)
		for(var/obj/item/offear/O in loc)
			if(O.origin == src)
				O.update_icon()

/obj/item/mob_can_equip(var/mob/living/M, slot, disable_warning = 0)
	if(ishuman(M) && slot in list(slot_l_ear, slot_r_ear))
		var/mob/living/carbon/human/H = M
		var/slot_other_ear = (slot == slot_l_ear)? slot_r_ear : slot_l_ear
		if( (slot_flags & SLOT_TWOEARS) && H.get_equipped_item(slot_other_ear) )
			return 0
	return ..()

/obj/item/offear
	name = "Other ear"
	w_class = 5.0
	icon = 'icons/mob/screen1_Midnight.dmi'
	icon_state = "block"
	slot_flags = SLOT_EARS
	var/obj/item/origin = null

	New(var/obj/O)
		origin = O
		update_icon()

	update_icon()
		name = origin.name
		desc = origin.desc
		icon = origin.icon
		icon_state = origin.icon_state
		overlays = origin.overlays.Copy()
		set_dir(origin.dir)

	attack_hand(user)
		return origin.attack_hand(user)

	dropped(mob/user)
		..()
		var/mob/living/carbon/human/H = user
		if(H.l_ear == origin || H.r_ear == origin)
			H.remove_from_mob(origin)
		qdel(src)
		return

