/obj/item/clothing/mask/muzzle
	name = "muzzle"
	desc = "To stop that awful noise."
	icon_state = "muzzle"
	item_state = "muzzle"
	flags = MASKCOVERSMOUTH
	body_parts_covered = 0
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
	icon_state = "tape"
	item_state = "tape"

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
	flags = MASKCOVERSMOUTH
	body_parts_covered = 0
	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.01
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 60, rad = 0)

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

/obj/item/clothing/mask/D00k_N00kem
	name = "Clown"
	desc = "Reminder of the wonderful past"
	icon_state = "sad_clown"
	flags_inv = HIDEFACE
	body_parts_covered = 0

// For Terti with love <3.
/obj/item/clothing/mask/arafatka
	name = "shemagh"
	desc = "Traditional Middle Eastern headdress fashioned from a square scarf."
	icon_state = "arafatka"
	item_state = "arafatka"
	flags = MASKCOVERSMOUTH
	slot_flags = SLOT_HEAD|SLOT_MASK
	w_class = 2
	gas_transfer_coefficient = 0.90

/obj/item/clothing/mask/arafatka/equipped(mob/living/carbon/human/H, var/slot)
	if(slot == slot_wear_mask)
		flags |= MASKCOVERSMOUTH
		body_parts_covered = FACE|EYES
	else
		flags &= ~MASKCOVERSMOUTH
		body_parts_covered = HEAD

/obj/item/clothing/mask/pig
	name = "pig mask"
	desc = "A rubber pig mask."
	icon_state = "pig"
	item_state = "pig"
	flags = BLOCKHAIR
	flags_inv = HIDEFACE
	w_class = 2
	siemens_coefficient = 0.9
	body_parts_covered = HEAD|FACE|EYES

/obj/item/clothing/mask/horsehead
	name = "horse head mask"
	desc = "A mask made of soft vinyl and latex, representing the head of a horse."
	icon_state = "horsehead"
	item_state = "horsehead"
	flags = BLOCKHAIR
	flags_inv = HIDEFACE
	body_parts_covered = HEAD|FACE|EYES
	w_class = 2
	var/voicechange = 0
	siemens_coefficient = 0.9

/obj/item/clothing/mask/bluescarf
	name = "blue neck scarf"
	desc = "A blue neck scarf."
	icon_state = "blueneckscarf"
	item_state = "blueneckscarf"
	w_class = 2
	gas_transfer_coefficient = 0.90

/obj/item/clothing/mask/redscarf
	name = "red scarf"
	desc = "A red and white checkered neck scarf."
	icon_state = "redwhite_scarf"
	item_state = "redwhite_scarf"
	w_class = 2
	gas_transfer_coefficient = 0.90

/obj/item/clothing/mask/greenscarf
	name = "green scarf"
	desc = "A green neck scarf."
	icon_state = "green_scarf"
	item_state = "green_scarf"
	w_class = 2
	gas_transfer_coefficient = 0.90

/obj/item/clothing/mask/ninjascarf
	name = "ninja scarf"
	desc = "A stealthy, dark scarf."
	icon_state = "ninja_scarf"
	item_state = "ninja_scarf"
	w_class = 2
	gas_transfer_coefficient = 0.90
	siemens_coefficient = 0

/obj/item/clothing/mask/flagmask
	name = "flgmask"
	desc = "A simple cloth rag that bears the flag of the first nations."
	icon_state = "flagmask"
	item_state = "flagmask"
	flags = MASKCOVERSMOUTH
	w_class = 2
	gas_transfer_coefficient = 0.90

/obj/item/clothing/mask/tuskmask
	name = "tuskmask"
	desc = "Standart Boars mask."
	icon_state = "tuskmask"
	w_class = 1
	gas_transfer_coefficient = 0.90
	siemens_coefficient = 0

/obj/item/clothing/mask/ai
	name = "camera MIU"
	desc = "Allows for direct mental connection to accessible camera networks."
	icon_state = "s-ninja"
	item_state = "s-ninja"
	flags_inv = HIDEFACE
	body_parts_covered = 0
	var/mob/eye/aiEye/eye

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
