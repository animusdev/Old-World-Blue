/*
Add fingerprints to items when we put them in our hands.
This saves us from having to call add_fingerprint() any time something is put in a human's hands programmatically.
*/

/mob/living/carbon/human/get_active_hand()
	if(hand)	return l_hand
	else		return r_hand

/mob/living/carbon/human/get_inactive_hand()
	if(hand)	return r_hand
	else		return l_hand


/mob/living/carbon/human/proc/put_in_l_hand(var/obj/item/W)
	var/obj/item/organ/external/hand = organs_by_name[BP_L_HAND]
	if(!hand || !hand.is_usable()) return 0
	. = equip_to_slot_if_possible(W, slot_l_hand, 0, 1)
	if(.) W.add_fingerprint(src)

/mob/living/carbon/human/proc/put_in_r_hand(var/obj/item/W)
	var/obj/item/organ/external/hand = organs_by_name[BP_R_HAND]
	if(!hand || !hand.is_usable()) return 0
	. = equip_to_slot_if_possible(W, slot_r_hand, 0, 1)
	if(.) W.add_fingerprint(src)

/mob/living/carbon/human/put_in_active_hand(var/obj/item/W)
	if(hand)	return put_in_l_hand(W)
	else		return put_in_r_hand(W)

/mob/living/carbon/human/put_in_inactive_hand(var/obj/item/W)
	if(hand)	return put_in_r_hand(W)
	else		return put_in_l_hand(W)

/mob/living/carbon/human/put_in_hands(var/obj/item/W)
	if(!W)		return 0
	if(put_in_active_hand(W))
		return 1
	else if(put_in_inactive_hand(W))
		return 1
	else
		return ..()


//Drops the item in our left hand
/mob/living/carbon/human/proc/drop_l_hand(var/atom/Target)
	return unEquip(l_hand, Target)

//Drops the item in our right hand
/mob/living/carbon/human/proc/drop_r_hand(var/atom/Target)
	return unEquip(r_hand, Target)

/mob/living/carbon/human/drop_active_hand(var/atom/Target)
	if(hand)	return drop_l_hand(Target)
	else		return drop_r_hand(Target)

/mob/living/carbon/human/drop_inactive_hand(var/atom/Target)
	if(hand)	return drop_r_hand(Target)
	else		return drop_l_hand(Target)


/mob/living/carbon/human/verb/quick_equip()
	set name = "quick-equip"
	set hidden = 1

	var/obj/item/I = get_active_hand()
	if(!I)
		src << "<span class='notice'>You are not holding anything to equip.</span>"
		return
	if(equip_to_appropriate_slot(I))
		if(hand)
			update_inv_l_hand(0)
		else
			update_inv_r_hand(0)
	else
		src << "\red You are unable to equip that."

/mob/living/carbon/human/proc/equip_in_one_of_slots(obj/item/W, list/slots, del_on_fail = 1)
	for (var/slot in slots)
		if (equip_to_slot_if_possible(W, slots[slot], del_on_fail = 0))
			return slot
	if (del_on_fail)
		qdel(W)
	return null


/mob/living/carbon/human/proc/has_organ(name)
	var/obj/item/organ/external/O = organs_by_name[name]

	return (O && !(O.status & ORGAN_DESTROYED) && !O.is_stump())

/mob/living/carbon/human/proc/has_organ_for_slot(slot)
	switch(slot)
		if(slot_back)
			return has_organ(BP_CHEST)
		if(slot_wear_mask)
			return has_organ(BP_HEAD)
		if(slot_handcuffed)
			return has_organ(BP_L_HAND) && has_organ(BP_R_HAND)
		if(slot_legcuffed)
			return has_organ(BP_L_LEG) && has_organ(BP_R_LEG)
		if(slot_l_hand)
			return has_organ(BP_L_HAND)
		if(slot_r_hand)
			return has_organ(BP_R_HAND)
		if(slot_belt)
			return has_organ(BP_CHEST)
		if(slot_wear_id)
			// the only relevant check for this is the uniform check
			return 1
		if(slot_l_ear, slot_r_ear)
			return has_organ(BP_HEAD)
		if(slot_glasses)
			return has_organ(BP_HEAD)
		if(slot_gloves)
			return has_organ(BP_L_HAND) || has_organ(BP_R_HAND)
		if(slot_head)
			return has_organ(BP_HEAD)
		if(slot_shoes)
			return has_organ(BP_R_FOOT) || has_organ(BP_L_FOOT)
		if(slot_wear_suit, slot_w_uniform, slot_l_store, slot_r_store, slot_s_store)
			return has_organ(BP_CHEST)
		if(slot_socks)
			return has_organ(BP_R_FOOT) || has_organ(BP_L_FOOT)
		if(slot_undershirt)
			return has_organ(BP_CHEST)
		if(slot_underwear)
			return has_organ(BP_CHEST)
		if(slot_in_backpack)
			return 1
		if(slot_tie)
			return 1

/mob/living/carbon/human/u_equip(obj/W as obj)
	if(!W)	return 0

	if (W == wear_suit)
		if(s_store)
			drop_from_inventory(s_store)
		wear_suit = null
		update_inv_wear_suit()
	else if (W == w_uniform)
		if (r_store)
			drop_from_inventory(r_store)
		if (l_store)
			drop_from_inventory(l_store)
		if (wear_id)
			drop_from_inventory(wear_id)
		if (belt)
			drop_from_inventory(belt)
		w_uniform = null
		update_inv_w_uniform()
	else if (W == gloves)
		gloves = null
		update_inv_gloves()
	else if (W == glasses)
		glasses = null
		update_inv_glasses()
	else if (W == head)
		head = null
		if(istype(W, /obj/item))
			var/obj/item/I = W
			if(I.flags_inv & (HIDEMASK|BLOCKHAIR|BLOCKHEADHAIR))
				update_hair(0)	//rebuild hair
				update_inv_ears(0)
				update_inv_wear_mask(0)
		update_inv_head()
	else if (W == l_ear)
		l_ear = null
		update_inv_ears()
	else if (W == r_ear)
		r_ear = null
		update_inv_ears()
	else if (W == shoes)
		shoes = null
		update_inv_shoes()
	else if (W == belt)
		belt = null
		update_inv_belt()
	else if (W == wear_mask)
		wear_mask = null
		if(istype(W, /obj/item))
			var/obj/item/I = W
			if(I.flags_inv & (BLOCKHAIR|BLOCKHEADHAIR))
				update_hair(0)	//rebuild hair
				update_inv_ears(0)
		if(internal)
			if(internals)
				internals.icon_state = "internal0"
			internal = null
		update_inv_wear_mask()
	else if (W == wear_id)
		wear_id = null
		update_inv_wear_id()
	else if (W == r_store)
		r_store = null
		update_inv_pockets()
	else if (W == l_store)
		l_store = null
		update_inv_pockets()
	else if (W == s_store)
		s_store = null
		update_inv_s_store()
	else if (W == back)
		back = null
		update_inv_back()
	else if (W == handcuffed)
		handcuffed = null
		if(buckled && buckled.buckle_require_restraints)
			buckled.unbuckle_mob()
		update_inv_handcuffed()
	else if (W == legcuffed)
		legcuffed = null
		update_inv_legcuffed()
	else if (W == r_hand)
		r_hand = null
		update_inv_r_hand()
	else if (W == l_hand)
		l_hand = null
		update_inv_l_hand()
	else if (W == h_socks)
		h_socks = null
		update_inv_underwear()
	else if (W == h_underwear)
		h_underwear = null
		update_inv_underwear()
	else if (W == h_undershirt)
		h_undershirt = null
		update_inv_underwear()
	else
		return 0

	update_action_buttons()
	return 1



//This is an UNSAFE proc. Use mob_can_equip() before calling this one! Or rather use equip_to_slot_if_possible() or advanced_equip_to_slot_if_possible()
//set redraw_mob to 0 if you don't wish the hud to be updated - if you're doing it manually in your own proc.
/mob/living/carbon/human/equip_to_slot(obj/item/W as obj, slot, redraw_mob = 1)

	if(!slot) return
	if(!istype(W)) return
	if(!has_organ_for_slot(slot)) return
	if(slot!=slot_socks && (!species || !species.hud || !(slot in species.hud.equip_slots))) return
	W.loc = src
	switch(slot)
		if(slot_back)
			src.back = W
			W.equipped(src, slot)
			update_inv_back(redraw_mob)
		if(slot_wear_mask)
			src.wear_mask = W
			if(wear_mask.flags_inv & (BLOCKHAIR|BLOCKHEADHAIR))
				update_hair(redraw_mob)	//rebuild hair
				update_inv_ears(0)
			W.equipped(src, slot)
			update_inv_wear_mask(redraw_mob)
		if(slot_handcuffed)
			src.handcuffed = W
			update_inv_handcuffed(redraw_mob)
		if(slot_legcuffed)
			src.legcuffed = W
			W.equipped(src, slot)
			update_inv_legcuffed(redraw_mob)
		if(slot_l_hand)
			src.l_hand = W
			W.equipped(src, slot)
			update_inv_l_hand(redraw_mob)
		if(slot_r_hand)
			src.r_hand = W
			W.equipped(src, slot)
			update_inv_r_hand(redraw_mob)
		if(slot_belt)
			src.belt = W
			W.equipped(src, slot)
			update_inv_belt(redraw_mob)
		if(slot_wear_id)
			src.wear_id = W
			W.equipped(src, slot)
			update_inv_wear_id(redraw_mob)
		if(slot_l_ear)
			src.l_ear = W
			W.equipped(src, slot)
			update_inv_ears(redraw_mob)
		if(slot_r_ear)
			src.r_ear = W
			W.equipped(src, slot)
			update_inv_ears(redraw_mob)
		if(slot_glasses)
			src.glasses = W
			W.equipped(src, slot)
			update_inv_glasses(redraw_mob)
		if(slot_gloves)
			src.gloves = W
			W.equipped(src, slot)
			update_inv_gloves(redraw_mob)
		if(slot_head)
			src.head = W
			if(head.flags_inv & (BLOCKHAIR|BLOCKHEADHAIR|HIDEMASK))
				update_hair(redraw_mob)	//rebuild hair
				update_inv_ears(0)
				update_inv_wear_mask(0)
			W.equipped(src, slot)
			update_inv_head(redraw_mob)
		if(slot_shoes)
			src.shoes = W
			W.equipped(src, slot)
			update_inv_shoes(redraw_mob)
		if(slot_wear_suit)
			src.wear_suit = W
			W.equipped(src, slot)
			update_inv_wear_suit(redraw_mob)
		if(slot_w_uniform)
			src.w_uniform = W
			W.equipped(src, slot)
			update_inv_w_uniform(redraw_mob)
		if(slot_l_store)
			src.l_store = W
			W.equipped(src, slot)
			update_inv_pockets(redraw_mob)
		if(slot_r_store)
			src.r_store = W
			W.equipped(src, slot)
			update_inv_pockets(redraw_mob)
		if(slot_s_store)
			src.s_store = W
			W.equipped(src, slot)
			update_inv_s_store(redraw_mob)
		if(slot_in_backpack)
			if(src.get_active_hand() == W)
				src.remove_from_mob(W)
			W.loc = src.back
		if(slot_tie)
			var/obj/item/clothing/under/uniform = src.w_uniform
			uniform.attackby(W,src)
		if(slot_socks)
			h_socks = W
			W.equipped(src, slot)
			update_inv_underwear(redraw_mob)
		if(slot_underwear)
			h_underwear = W
			W.equipped(src, slot)
			update_inv_underwear(redraw_mob)
		if(slot_undershirt)
			h_undershirt = W
			W.equipped(src, slot)
			update_inv_underwear(redraw_mob)
		else
			src << "\red You are trying to eqip this item to an unsupported inventory slot. How the heck did you manage that? Stop it..."
			return

	if((W == src.l_hand) && (slot != slot_l_hand))
		src.l_hand = null
		update_inv_l_hand() //So items actually disappear from hands.
	else if((W == src.r_hand) && (slot != slot_r_hand))
		src.r_hand = null
		update_inv_r_hand()

	W.layer = 20

	return 1

//Checks if a given slot can be accessed at this time, either to equip or unequip I
/mob/living/carbon/human/slot_is_accessible(var/slot, var/obj/item/I, mob/user=null)
	var/obj/item/covering = null
	var/check_flags = 0

	switch(slot)
		if(slot_wear_mask)
			covering = src.head
			check_flags = FACE
		if(slot_glasses)
			covering = src.head
			check_flags = EYES
		if(slot_gloves, slot_w_uniform)
			covering = src.wear_suit
		if(slot_socks)
			covering = src.shoes
		if(slot_underwear, slot_undershirt)
			covering = src.w_uniform

	if(covering && (covering.body_parts_covered & (I.body_parts_covered|check_flags)))
		user << "<span class='warning'>\The [covering] is in the way.</span>"
		return 0
	return 1

/mob/living/carbon/human/get_equipped_item(var/slot)
	switch(slot)
		if(slot_back)       return back
		if(slot_legcuffed)  return legcuffed
		if(slot_handcuffed) return handcuffed
		if(slot_l_store)    return l_store
		if(slot_r_store)    return r_store
		if(slot_wear_mask)  return wear_mask
		if(slot_l_hand)     return l_hand
		if(slot_r_hand)     return r_hand
		if(slot_wear_id)    return wear_id
		if(slot_glasses)    return glasses
		if(slot_gloves)     return gloves
		if(slot_head)       return head
		if(slot_shoes)      return shoes
		if(slot_belt)       return belt
		if(slot_wear_suit)  return wear_suit
		if(slot_w_uniform)  return w_uniform
		if(slot_s_store)    return s_store
		if(slot_l_ear)      return l_ear
		if(slot_r_ear)      return r_ear
		if(slot_socks)      return h_socks
		if(slot_underwear)  return h_underwear
		if(slot_undershirt) return h_undershirt
	return ..()

//Outdated but still in use apparently.
/mob/living/carbon/human/proc/get_equipped_items()
	var/list/items = new/list()

	if(back)	items += back
	if(belt)	items += belt
	if(l_ear)	items += l_ear
	if(r_ear)	items += r_ear
	if(glasses)	items += glasses
	if(gloves)	items += gloves
	if(head)	items += head
	if(shoes)	items += shoes
	if(wear_id)	items += wear_id
	if(wear_mask) items += wear_mask
	if(wear_suit) items += wear_suit
	if(w_uniform) items += w_uniform

	return items


