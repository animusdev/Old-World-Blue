/obj/item/clothing/mask/muzzle
	name = "muzzle"
	desc = "To stop that awful noise."
	icon_state = "muzzle"
	item_state = "muzzle"
	body_parts_covered = FACE
	w_class = 2
	gas_transfer_coefficient = 0.90

/obj/item/clothing/mask/muzzle/ballgag
	name = "ballgag"
	desc = "For when Master wants silence."
	icon_state = "ballgag"
	item_state = "ballgag"

// Clumsy folks can't take the mask off themselves.
/obj/item/clothing/mask/muzzle/attack_hand(mob/user as mob)
	if(user.wear_mask == src && !user.IsAdvancedToolUser())
		return 0
	..()

/obj/item/clothing/mask/muzzle/tape
	name = "tape piece"
	desc = "It's a robust DIY muzzle!"
	icon_state = "tape"
	item_state = null
	w_class = 1

/obj/item/clothing/mask/muzzle/tape/New()
	..()
	if(prob(50))
		icon_state = "tape_alt"

/obj/item/clothing/mask/muzzle/tape/dropped()
	name = "utilized tape piece"
	slot_flags = 0
	icon = 'icons/obj/items.dmi'
	icon_state = "taperoll_piece"

/obj/item/clothing/mask/surgical
	name = "sterile mask"
	desc = "A sterile mask designed to help prevent the spread of diseases."
	icon_state = "sterile"
	item_state = "sterile"
	w_class = 2
	body_parts_covered = FACE
	item_flags = FLEXIBLEMATERIAL
	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.01
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 60, rad = 0)
	var/hanging = 0

/obj/item/clothing/mask/surgical/proc/adjust_mask(mob_user)
	if(usr.canmove && !usr.stat)
		src.hanging = !src.hanging
		if (src.hanging)
			gas_transfer_coefficient = 1
			body_parts_covered = body_parts_covered & ~FACE
			armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
			icon_state = "steriledown"
			usr << "You pull the mask below your chin."
		else
			gas_transfer_coefficient = initial(gas_transfer_coefficient)
			body_parts_covered = initial(body_parts_covered)
			icon_state = initial(icon_state)
			armor = initial(armor)
			usr << "You pull the mask up to cover your face."
		update_clothing_icon()

/obj/item/clothing/mask/surgical/verb/toggle()
	set category = "Object"
	set name = "Adjust mask"
	set src in usr

	adjust_mask(usr)

/obj/item/clothing/mask/fakemoustache
	name = "fake moustache"
	desc = "Warning: moustache is fake."
	icon_state = "fake-moustache"
	flags_inv = HIDEFACE
	body_parts_covered = 0

/obj/item/clothing/mask/snorkel
	name = "Snorkel"
	desc = "For the Swimming Savant."
	icon_state = "snorkel"
	flags_inv = HIDEFACE
	body_parts_covered = 0

//scarves (large so fit in in mask slot)
/obj/item/clothing/mask/scarf
	body_parts_covered = FACE
	item_flags = FLEXIBLEMATERIAL
	w_class = 2
	gas_transfer_coefficient = 0.90

/obj/item/clothing/mask/scarf/blue
	name = "blue neck scarf"
	desc = "A blue neck scarf."
	icon_state = "blue_scarf"
	item_state = "blue_scarf"

/obj/item/clothing/mask/scarf/redwhite
	name = "red scarf"
	desc = "A red and white checkered neck scarf."
	icon_state = "redwhite_scarf"
	item_state = "redwhite_scarf"

/obj/item/clothing/mask/scarf/red
	name = "red scarf"
	desc = "A red neck scarf."
	icon_state = "red_scarf"
	item_state = "red_scarf"

/obj/item/clothing/mask/scarf/green
	name = "green scarf"
	desc = "A green neck scarf."
	icon_state = "green_scarf"
	item_state = "green_scarf"

/obj/item/clothing/mask/scarf/ninja
	name = "ninja scarf"
	desc = "A stealthy, dark scarf."
	icon_state = "ninja_scarf"
	item_state = "ninja_scarf"
	siemens_coefficient = 0

/obj/item/clothing/mask/scarf/long_blue
	name = "long blue scarf"
	desc = "A long blue neck scarf."
	icon_state = "stripedbluescarf"
	item_state = "stripedbluescarf"

/obj/item/clothing/mask/scarf/long_red
	name = "long red scarf"
	desc = "A long red neck scarf."
	icon_state = "stripedredscarf"
	item_state = "stripedredscarf"

/obj/item/clothing/mask/scarf/long_green
	name = "long green scarf"
	desc = "A long green neck scarf."
	icon_state = "stripedgreenscarf"
	item_state = "stripedgreenscarf"

/obj/item/clothing/mask/scarf/flagmask
	name = "flgmask"
	desc = "A simple cloth rag that bears the flag of the first nations."
	icon_state = "flagmask"
	item_state = "flagmask"

/obj/item/clothing/mask/scarf/arafatka
	name = "shemagh"
	desc = "Traditional Middle Eastern headdress fashioned from a square scarf."
	icon_state = "arafatka"
	item_state = "arafatka"
	slot_flags = SLOT_HEAD|SLOT_MASK

/obj/item/clothing/mask/scarf/arafatka/equipped(mob/living/carbon/human/H, var/slot)
	..()
	if(slot == slot_wear_mask)
		body_parts_covered = FACE
	else
		body_parts_covered = HEAD


/obj/item/clothing/mask/pig
	name = "pig mask"
	desc = "A rubber pig mask."
	icon_state = "pig"
	item_state = "pig"
	flags_inv = HIDEFACE|BLOCKHAIR
	w_class = 2
	siemens_coefficient = 0.9
	body_parts_covered = HEAD|FACE|EYES

/obj/item/clothing/mask/horsehead
	name = "horse head mask"
	desc = "A mask made of soft vinyl and latex, representing the head of a horse."
	icon_state = "horsehead"
	item_state = "horsehead"
	flags_inv = HIDEFACE|BLOCKHAIR
	body_parts_covered = HEAD|FACE|EYES
	w_class = 2
	siemens_coefficient = 0.9
	say_messages = list("NEEIIGGGHHHH!", "NEEEIIIIGHH!", "NEIIIGGHH!", "HAAWWWWW!", "HAAAWWW!")
	say_verbs = list("whinnies", "neighs", "says")


/obj/item/clothing/mask/tuskmask
	name = "tuskmask"
	desc = "Standart Boars mask."
	icon_state = "tuskmask"
	w_class = 1
	item_flags = FLEXIBLEMATERIAL
	gas_transfer_coefficient = 0.90
	siemens_coefficient = 0

/obj/item/clothing/mask/ai
	name = "camera MIU"
	desc = "Allows for direct mental connection to accessible camera networks."
	icon_state = "s-ninja"
	item_state = "s-ninja"
	flags_inv = HIDEFACE
	body_parts_covered = 0
	var/mob/observer/eye/aiEye/eye

/obj/item/clothing/mask/ai/New()
	eye = new(src)

/obj/item/clothing/mask/ai/equipped(var/mob/user, var/slot)
	..(user, slot)
	if(slot == slot_wear_mask)
		eye.owner = user
		user.eyeobj = eye

		for(var/datum/chunk/c in eye.visibleChunks)
			c.remove(eye)
		eye.setLoc(user)

/obj/item/clothing/mask/ai/dropped(var/mob/user)
	..()
	if(eye.owner == user)
		for(var/datum/chunk/c in eye.visibleChunks)
			c.remove(eye)

		eye.owner.eyeobj = null
		eye.owner = null

/obj/item/clothing/mask/bandana
	name = "black bandana"
	desc = "A fine black bandana with nanotech lining."
	w_class = 1
	body_parts_covered = FACE
	slot_flags = SLOT_MASK
	flags_inv = HIDEFACE
	item_flags = FLEXIBLEMATERIAL
	icon_state = "bandblack"
	item_state = "bandblack"
	var/tied = 0

/obj/item/clothing/mask/bandana/proc/adjust_bandana(mob/user)
	if(usr.canmove && !usr.stat)
		src.tied = !src.tied
		if (src.tied)
			flags_inv = flags_inv & ~HIDEFACE
			slot_flags = SLOT_HEAD
			body_parts_covered = HEAD
			icon_state = "[icon_state]_up"
			item_state = "[item_state]_up"
			usr << "You tie the bandana so that it can be worn on the head."
		else
			flags_inv = initial(flags_inv)
			body_parts_covered = FACE
			slot_flags = initial(slot_flags)
			icon_state = initial(icon_state)
			item_state = initial(item_state)
			usr << "You tie the bandana so that it can be worn on the face."

/obj/item/clothing/mask/bandana/verb/toggle()
	set category = "Object"
	set name = "Tie bandana"
	set src in usr

	adjust_bandana(usr)
	update_icon()

/obj/item/clothing/mask/bandana/red
	name = "red bandana"
	desc = "A fine red bandana with nanotech lining."
	icon_state = "bandred"

/obj/item/clothing/mask/bandana/blue
	name = "blue bandana"
	desc = "A fine blue bandana with nanotech lining."
	icon_state = "bandblue"

/obj/item/clothing/mask/bandana/green
	name = "green bandana"
	desc = "A fine green bandana with nanotech lining."
	icon_state = "bandgreen"

/obj/item/clothing/mask/bandana/gold
	name = "gold bandana"
	desc = "A fine gold bandana with nanotech lining."
	icon_state = "bandgold"

/obj/item/clothing/mask/bandana/skull
	name = "skull bandana"
	desc = "A fine black bandana with nanotech lining and a skull emblem."
	icon_state = "bandskull"
