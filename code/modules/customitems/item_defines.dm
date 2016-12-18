/obj/item/clothing/mask/gas/D00k_N00kem
	name = "Clown"
	desc = "Reminder of the wonderful past"
	icon_state = "sad_clown"

/obj/item/clothing/accessory/locket/Evans
	desc = "This oval shaped, argentium sterling silver locket."
	held = new /obj/item/weapon/photo/custom()

/obj/item/clothing/under/rank/security/venligen
	name = "\improper PMC Turtleneck"
	desc = "Standart issued uniform for Redwood mercenary operatives. Made from high quality and sturdy material."
	icon_state = "BW_uniform"
	item_state = "jensen"

/obj/item/clothing/under/rank/security/venligen_alt
	name = "\improper PMC Uniform"
	desc = "Standart issued security uniform for Blackwater operatives. Made from sturdier material to allow more protection."
	icon_state = "constableuniform"
	item_state = "black"

/obj/item/clothing/suit/armor/vest/venligen
	name = "PMC Kevlar Vest"
	desc = "Standart issued ballistic vest for Blackwater high-risk security operatives."
	icon_state = "constablevest"

/obj/item/clothing/accessory/purple_heart
	name = "Purple Heart"
	desc = "The Purple Heart is a NanoTrasen military decoration awarded in the name of the Director to those badly wounded or killed while serving.\n\
	FOR MILITARY MERIT\n"
	icon_state = "bronze_heart"
	var/owner = ""

/obj/item/clothing/accessory/purple_heart/New()
	..()
	desc += owner

/obj/item/clothing/accessory/purple_heart/nikiton
	owner = "Leroy Woodward"

/obj/item/clothing/accessory/purple_heart/egorkor
	owner = "Graham Maclagan"

/obj/item/clothing/accessory/purple_heart/madman
	owner = "Megan Abbott"

/obj/item/clothing/accessory/purple_heart/solar
	owner = "Aiden McMurray"

/obj/item/clothing/accessory/purple_heart/shepard
	owner = "Weston Ludwig"

/obj/item/clothing/suit/storage/toggle/leather_jacket/mil
	name = "leather jacket"
	wear_state = "mil_jacket"

//private military contractors 4life <3

/obj/item/clothing/suit/storage/vest/madman
	name = "\improper MOLLE plate carrier"
	desc = "That's the high quality generic plate carrier."
	icon_state = "mollemadman"
	item_state = "jensen"

/obj/item/clothing/suit/storage/vest/solar
	name = "\improper MOLLE plate carrier"
	desc = "That's the high quality generic plate carrier."
	icon_state = "mollesolar"
	item_state = "jensen"

/obj/item/clothing/under/rank/security/madman
	name = "\improper generic clothes"
	desc = "That's some generic black pants with a tan shirt."
	icon_state = "pmcsuitmadman"
	item_state = "black"

/obj/item/clothing/under/rank/security/solar
	name = "\improper generic clothes"
	desc = "That's some generic khaki pants with a tan shirt."
	icon_state = "pmcsuitsolar"
	item_state = "black"

/obj/item/weapon/gun/projectile/sec/madman
	desc = "That's the Mk.14, a very unusual and pretty outdated pistol which was used by NT."
	name = "custom .45 pistol"
	icon_state = "madmanpistol"

/obj/item/weapon/gun/projectile/sec/madman/update_icon()
	..()
	icon_state = (ammo_magazine)? "madmanpistol" : "madmanpistol-empty"
	update_held_icon()


/obj/item/clothing/head/helmet/pmcsolar
	name = "tan helmet"
	desc = "It's a generic helmet used by some PMC's."
	icon_state = "solarhelm"
	item_state = "helmet"
	armor = list(melee = 50, bullet = 15, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	body_parts_covered = HEAD|EYES
	siemens_coefficient = 0.7
	var/glassesup = 0

	verb/glasses()
		set category = "Object"
		set name = "Raise glasses up/down"
		set src in usr
		if(usr.canmove && !usr.stat && !usr.restrained())
			src.glassesup = !src.glassesup
			if(src.glassesup)
				icon_state = "[icon_state]_gogup"
				flags_inv |= (HIDEFACE|HIDEEYES)
				body_parts_covered |= (FACE|EYES)
				usr << "You raise your helmet glasses up."
			else
				src.icon_state = initial(icon_state)
				flags_inv &= ~(HIDEFACE|HIDEEYES)
				body_parts_covered &= ~(FACE|EYES)
				usr << "You place your glasses into the normal position."
			update_clothing_icon()	//so our mob-overlays update

/obj/item/clothing/head/helmet/pmcmadman
	name = "tan helmet"
	desc = "That's the combat helmet with some attachments."
	icon_state = "madmanhelm"
	armor = list(melee = 50, bullet = 15, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS
	body_parts_covered = HEAD
	siemens_coefficient = 0.4
	light_overlay = "helmet-army_light"
	brightness_on = 4

/obj/item/clothing/mask/keffiehsolar
	name = "keffieh"
	desc = "Yet another tactical thing."
	w_class = 2
	body_parts_covered = null
	slot_flags = SLOT_MASK
	flags_inv = null
	item_flags = FLEXIBLEMATERIAL
	icon_state = "kuffieh"
	item_state = "kuffieh"
	var/tied = 0

/obj/item/clothing/mask/keffiehsolar/proc/adjust_keffieh(mob/user)
	if(usr.canmove && !usr.stat)
		src.tied = !src.tied
		if (src.tied)
			icon_state = "[icon_state]_up"
			item_state = "[item_state]_up"
			flags_inv = HIDEFACE
			body_parts_covered = FACE
			usr << "You pull the keffieh up."
		else
			flags_inv = initial(flags_inv)
			body_parts_covered = FACE
			slot_flags = initial(slot_flags)
			icon_state = initial(icon_state)
			item_state = initial(item_state)
			usr << "You pull the keffieh down."
