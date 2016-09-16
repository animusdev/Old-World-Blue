/obj/item/weapon/storage/box/swabs
	name = "box of swab kits"
	desc = "Sterilized equipment within. Do not contaminate."
	icon = 'icons/obj/forensics.dmi'
	icon_state = "dnakit"
	storage_slots = 10
	var/startswith = 10
	can_hold = list(/obj/item/weapon/forensics/swab)
	foldable = /obj/item/stack/material/cardboard

/obj/item/weapon/storage/box/swabs/New()
	..()
	for(var/i=1; i <= startswith; i++)
		new /obj/item/weapon/forensics/swab(src)
	update_icon()
	return


/obj/item/weapon/storage/box/fingerprints
	name = "box of fingerprint cards"
	desc = "Sterilized equipment within. Do not contaminate."
	icon = 'icons/obj/forensics.dmi'
	icon_state = "dnakit"
	storage_slots = 10
	var/startswith = 10
	can_hold = list(/obj/item/weapon/sample/print)
	foldable = /obj/item/stack/material/cardboard

/obj/item/weapon/storage/box/fingerprints/New()
	..()
	for(var/i=1; i <= startswith; i++)
		new /obj/item/weapon/sample/print(src)
	update_icon()
	return
