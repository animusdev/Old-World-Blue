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
