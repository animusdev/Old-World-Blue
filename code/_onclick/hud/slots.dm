/obj/screen/slot
	name = "slot"
	var/slot_flag = 0
	var/max_w_class = 0
	var/obj/item/wrapped
	var/mob/living/carbon/human/owner


/obj/screen/slot/proc/can_equip(obj/item/I)
	if(slot_flag && !(slot_flag & I.slot_flags))
		return FALSE
	if(wrapped)
		return FALSE
	if(I.w_class > max_w_class)
		return FALSE


/obj/screen/slot/update_icon()


/obj/screen/slot/attackby(obj/item/I, mob/user)
	if(wrapped)
		wrapped.attackby(I, user)

/obj/screen/slot/attack_hand(mob/user)
	if(wrapped)
		wrapped.atack_hand(user)

/obj/screen/slot/proc/equiped(obj/item/I)
/obj/screen/slot/proc/dropped(obj/item/I)

