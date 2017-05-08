/obj/screen/slot
	name = "slot"
	var/id = 0
	var/slot_flag = 0
	var/max_w_class = 0
	var/obj/item/wrapped
	var/mob/living/carbon/human/owner


/obj/screen/slot/proc/can_equip(obj/item/I, disable_warning)
	if(slot_flag && !(slot_flag & I.slot_flags))
		if(I.w_class > max_w_class)
			return FALSE

	if(wrapped)
		return FALSE

	return TRUE

/obj/screen/slot/update_icon()


/obj/screen/slot/attackby(obj/item/I, mob/user)
	if(wrapped)
		wrapped.attackby(I, user)

/obj/screen/slot/attack_hand(mob/user)
	if(wrapped)
		wrapped.atack_hand(user)

/obj/screen/slot/proc/equiped(obj/item/I)
/obj/screen/slot/proc/dropped(obj/item/I)

/obj/screen/slot/uniform
	name = "uniform"
	id = slot_w_uniform
	slot_flag = SLOT_ICLOTHING
	screen_loc = ui_iclothing

/obj/screen/slot/store
	slot_flag = SLOT_POCKET
	max_w_class = ITEM_SIZE_SMALL

/obj/screen/slot/store/mob_can_equip(var/obj/item/I, disable_warning)
	if(!..())
		return FALSE

	if(!owner.get_equipped_item(slot_w_uniform))
		if(!disable_warning)
			H << SPAN_WARN("You need a jumpsuit before you can attach this [name].")
		return FALSE
	if(slot_flags & SLOT_DENYPOCKET)
		return FALSE



/obj/screen/slot/suit
	name = "suit"
	id = slot_wear_suit
	slot_flag = SLOT_OCLOTHING
	screen_loc = ui_oclothing

/obj/screen/slot/s_store
	name = "suit store"
	id = slot_s_store
	screen_loc = ui_sstore1
	var/list/always_allowed = list(
		/obj/item/device/pda,
		/obj/item/weapon/pen
	)

/obj/screen/slot/s_store/can_equip(obj/item/I, disable_warning)
	. = ..()
	var/obj/item/suit = owner.get_equipped_item(slot_wear_suit)
	if(!suit)
		if(!disable_warning)
			H << SPAN_WARN("You need a suit before you can attach this [name].")
		return FALSE
	if(!suit.allowed)
		if(!disable_warning)
			usr << SPAN_WARN("You somehow have a suit with no defined allowed items for suit storage, stop that.")
		return FALSE
	if(is_type_in_list(I, always_allowed) || is_type_in_list(src, suit.allowed))
		return TRUE
	return FALSE

/obj/screen/slot/back
	name = "back"
	id = slot_back
	slot_flag = SLOT_BACK
	screen_loc = ui_back

/obj/screen/slot/gloves
	name = "gloves"
	id = slot_gloves
	slot_flag = SLOT_GLOVES
	screen_loc = ui_gloves

/obj/screen/slot/shoes
	name = "shoes"
	id = slot_shoes
	slot_flag = SLOT_FEET
	screen_loc = ui_shoes

/obj/screen/slot/ear
	name = "ear"
	max_w_class = ITEM_SIZE_TINY
	slot_flag = SLOT_EARS|SLOT_TWOEARS

/obj/screen/slot/ear/left
	name = "left ear"
	id = slot_l_ear
	screen_loc = ui_l_ear

/obj/screen/slot/ear/right
	name = "right ear"
	id = slot_r_ear
	screen_loc = ui_r_ear

/obj/screen/slot/mask
	name = "mask"
	id = slot_wear_mask
	slot_flag = SLOT_MASK
	screen_loc = ui_mask

/obj/screen/slot/belt
	name = "belt"
	id = slot_belt
	slot_flag = SLOT_BELT
	screen_loc = ui_belt

/obj/screen/slot/glasses
	name = "glasses"
	id = slot_glasses
	slot_flag = SLOT_EYES
	screen_loc = ui_glasses

/obj/screen/slot/head
	name = "head"
	id = slot_head
	slot_flag = SLOT_HEAD
	screen_loc = ui_head

/obj/screen/slot/id
	name = "id"
	id = slot_wear_id
	slot_flag = SLOT_ID
	screen_loc = ui_id

/obj/screen/slot/id/can_equip(obj/item/I, disable_warning)
	. = ..()
	if(. && !owner.get_equipped_item(slot_w_uniform))
		if(!disable_warning)
			user << SPAN_WARN("You need a jumpsuit before you can attach this [name].")
		return FALSE





