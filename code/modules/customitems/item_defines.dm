/obj/item/clothing/mask/gas/D00k_N00kem
	name = "Clown"
	desc = "Reminder of the wonderful past"
	icon_state = "sad_clown"
/***************************************/
/*****************LethalGhost****************/
/***************************************/
/obj/item/clothing/accessory/locket/Evans
	desc = "This oval shaped, argentium sterling silver locket."
	held = new /obj/item/weapon/photo/custom()

/***************************************/
/*****************Venligen*****************/
/***************************************/

/obj/item/clothing/under/rank/security/venligen
	name = "\improper Black Turtleneck"
	desc = "Standard-issue uniform for Nemesis operatives. Perfectly fits the rightful wearer. Made from high quality and sturdy material."
	icon_state = "BW_uniform"
	item_state = "jensen"


 /***************************************/
/*****************Security medals*****************/
/***************************************/

/obj/item/clothing/accessory/purple_heart
	name = "Purple Heart"
	desc = "The Purple Heart is a NanoTrasen military decoration awarded in the name of the Director to those badly wounded or killed while serving.\n\
	FOR MILITARY MERIT\n"
	icon_state = "bronze_heart"
	var/owner = ""

/obj/item/clothing/accessory/purple_heart/New()
	..()
	desc += owner


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

/***************************************/
/*****************Solar&Madman*****************/
/***************************************/
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

/***************************************/
/*****************Deverezzer*****************/
/***************************************/
/obj/item/weapon/flame/lighter/zippo/black
	name = "\improper View family's lighter"
	desc = "A black zippo lighter, which holds some form of sentimental value."
	icon_state = "blackzippo"
	item_state = "zippo"

/obj/item/clothing/suit/storage/deverezzer
	name = "Ambassador"
	icon_state = "ambassador"

/***************************************/
/*****************Maglaj*****************/
/***************************************/

/obj/item/clothing/under/rank/security/maglaj
	name = "officer's frock"
	icon_state = "maglaj"
	item_state = "mime"

/obj/item/clothing/shoes/jackboots/maglaj
	name = "jackboots"
	desc = "When you REALLY want to turn up the heat"
	icon_state = "maglaj"

/***************************************/
/*****************Joody*****************/
/***************************************/
/obj/item/clothing/suit/storage/toggleable_hood/cloak
	name = "desert cloak"
	desc = "A warm and comfortable cloak, which is the traditional garment of the Erg'ishchort people."
	icon_state = "descloak"
	hood_type = /obj/item/clothing/head/toggleable_hood/cloakhood

	cold_protection = LOWER_TORSO|UPPER_TORSO|ARMS
	min_cold_protection_temperature = T0C - 20

/obj/item/clothing/head/toggleable_hood/cloakhood
	name = "desert cloak hood"
	icon_state = "cloak_hood"
	flags_inv = BLOCKHAIR|HIDEFACE|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = T0C - 20

/obj/item/clothing/under/dbodywraps
	name = "body wraps"
	desc = "A bunch of tight bandages as additional to leather pants."
	icon_state = "dbodywraps"

/obj/item/clothing/shoes/leatherboots
	name = "light leather boots"
	desc = "Protects your legs from a cold wind."
	icon_state = "leatherboots"

	cold_protection = FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
