/*
*	Here is where any supply packs
*	that don't belong elsewhere live.
*/


/datum/supply_packs/misc
	group = "Miscellaneous"

/datum/supply_packs/randomised/misc
	group = "Miscellaneous"


/datum/supply_packs/misc/eftpos
	contains = list(/obj/item/device/eftpos)
	name = "EFTPOS scanner"
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "EFTPOS crate"

/datum/supply_packs/misc/hoverpod
	name = "Hoverpod Shipment"
	contains = list()
	cost = 80
	containertype = /obj/structure/largecrate/hoverpod
	containername = "Hoverpod Crate"
	manifest = "<ul><li>Hover Pod</li></ul>"

/datum/supply_packs/randomised/misc/webbing
	name = "Webbing crate"
	num_contained = 4
	contains = list(
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/accessory/storage/brown_vest,
		/obj/item/clothing/accessory/storage/white_vest,
		/obj/item/clothing/accessory/storage/drop_pouches,
		/obj/item/clothing/accessory/storage/drop_pouches/brown,
		/obj/item/clothing/accessory/storage/drop_pouches/white,
		/obj/item/clothing/accessory/storage/webbing
	)
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Webbing crate"

/datum/supply_packs/misc/underwear
	name = "Random underwear pack"
	contains = list(/obj/item/weapon/storage/box/underwear = 3)
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Underwear crate"
