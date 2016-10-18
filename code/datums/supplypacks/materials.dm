/*
*	Here is where any supply packs
*	related to materials live.
*/


/datum/supply_packs/materials
	group = "Materials"

/datum/supply_packs/materials/metal
	name = "50 metal sheets"
	contains = list(/obj/item/stack/material/steel/full)
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Metal sheets crate"

/datum/supply_packs/materials/glass
	name = "50 glass sheets"
	contains = list(/obj/item/stack/material/glass/full)
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Glass sheets crate"

/datum/supply_packs/materials/wood
	name = "50 wooden planks"
	contains = list(/obj/item/stack/material/wood/full)
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Wooden planks crate"

/datum/supply_packs/materials/plastic
	name = "50 plastic sheets"
	contains = list(/obj/item/stack/material/plastic/full)
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Plastic sheets crate"

/datum/supply_packs/materials/cardboard_sheets
	contains = list(/obj/item/stack/material/cardboard/full)
	name = "50 cardboard sheets"
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Cardboard sheets crate"

/datum/supply_packs/materials/carpet
	name = "Imported carpet"
	containertype = /obj/structure/closet/crate
	containername = "Imported carpet crate"
	cost = 15
	contains = list(/obj/item/stack/tile/carpet)

