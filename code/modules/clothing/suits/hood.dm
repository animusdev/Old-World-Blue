// Suits with hoods

// SUIT //////////////////
/obj/item/clothing/suit/storage/toggleable_hood
	name = "suit with hood"
	body_parts_covered = LOWER_TORSO|UPPER_TORSO|ARMS

	var/hood = null
	var/hood_type = null

	proc/toggle()
		set name = "Toggle Hood"
		set category = "Object"
		set src in usr
		if(usr.stat || usr.restrained())
			return 0

		if(!hood)
			usr << "There is no hood."
			verbs -= /obj/item/clothing/suit/storage/toggleable_hood/proc/toggle
			return 0

		var/mob/living/carbon/human/H = usr

		if(H.head == hood)
			H.drop_from_inventory(hood, src)
		else if(H.equip_to_slot_if_possible(hood, slot_head))
			usr << "You put on a hood."
		else
			usr << "Your head is busy right now."

/obj/item/clothing/suit/storage/toggleable_hood/New()
	..()
	if(!hood_type)
		return
	var/obj/item/clothing/head/toggleable_hood/H = new hood_type
	hood = H
	H.holder = src
	verbs += /obj/item/clothing/suit/storage/toggleable_hood/proc/toggle

/obj/item/clothing/suit/storage/toggleable_hood/dropped(var/mob/user)
	..()
	user.drop_from_inventory(hood)


// HOOD ////////////////////////
/obj/item/clothing/head/toggleable_hood
	name = "hood"
	icon_state = "chaplain_hood"
	flags_inv = BLOCKHAIR
	body_parts_covered = HEAD
	var/obj/item/clothing/suit/holder = null

/obj/item/clothing/head/toggleable_hood/dropped(var/mob/user)
	. = ..()
	src.forceMove(holder)
	user << "You took off your [src]."