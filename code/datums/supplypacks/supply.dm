/*
*	Here is where any supply packs
*	related to civilian tasks live
*/

/datum/supply_packs/supply
	group = "Supplies"

/datum/supply_packs/supply/lightbulbs
	name = "Replacement lights"
	contains = list(/obj/item/weapon/storage/box/lights/mixed = 3)
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Replacement lights"

/datum/supply_packs/supply/food
	name = "Kitchen supply crate"
	contains = list(
		/obj/item/weapon/reagent_containers/food/condiment/flour = 6,
		/obj/item/weapon/reagent_containers/glass/drinks/milk = 3,
		/obj/item/weapon/reagent_containers/glass/drinks/soymilk = 2,
		/obj/item/weapon/storage/fancy/egg_box = 2,
		/obj/item/weapon/reagent_containers/food/snacks/tofu = 3,
		/obj/item/weapon/reagent_containers/food/snacks/meat = 3
	)
	cost = 10
	containertype = /obj/structure/closet/crate/freezer
	containername = "Food crate"

/datum/supply_packs/supply/toner
	name = "Toner cartridges"
	contains = list(/obj/item/device/toner = 6)
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Toner cartridges"

/datum/supply_packs/supply/janitor
	name = "Janitorial supplies"
	contains = list(
		/obj/item/weapon/reagent_containers/glass/beaker/bucket = 3,
		/obj/item/weapon/mop,
		/obj/item/weapon/caution = 4,
		/obj/item/weapon/storage/bag/trash,
		/obj/item/device/lightreplacer,
		/obj/item/weapon/reagent_containers/spray/cleaner,
		/obj/item/weapon/reagent_containers/rag,
		/obj/item/weapon/grenade/chem_grenade/cleaner = 3,
		/obj/structure/mopbucket
	)
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "Janitorial supplies"

/datum/supply_packs/supply/boxes
	name = "Empty boxes"
	contains = list(/obj/item/weapon/storage/box = 10)
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Empty box crate"

/datum/supply_packs/supply/bureaucracy
	contains = list(
		/obj/item/weapon/clipboard = 2,
		/obj/item/weapon/pen/red,
		/obj/item/weapon/pen/blue,
		/obj/item/weapon/pen/blue,
		/obj/item/device/camera_film,
		/obj/item/weapon/folder/blue,
		/obj/item/weapon/folder/red,
		/obj/item/weapon/folder/yellow,
		/obj/item/weapon/hand_labeler,
		/obj/item/weapon/tape_roll,
		/obj/structure/filingcabinet/chestdrawer{anchored = 0},
		/obj/item/weapon/paper_bin
	)
	name = "Office supplies"
	cost = 15
	containertype = /obj/structure/closet/crate
	containername = "Office supplies crate"

/datum/supply_packs/supply/spare_pda
	name = "Spare PDAs"
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Spare PDA crate"
	contains = list(/obj/item/device/pda = 3)

/datum/supply_packs/supply/mule
	name = "Mulebot Crate"
	contains = list(/obj/machinery/bot/mulebot)
	cost = 20
	containertype = /obj/structure/largecrate/mule
	containername = "Mulebot Crate"
	manifest = "<ul><li>Mulebot</li></ul>"

/datum/supply_packs/supply/cargotrain
	name = "Cargo Train Tug"
	contains = list(/obj/vehicle/train/cargo/engine)
	cost = 35
	containertype = /obj/structure/largecrate
	containername = "Cargo Train Tug Crate"

/datum/supply_packs/supply/cargotrailer
	name = "Cargo Train Trolley"
	contains = list(/obj/vehicle/train/cargo/trolley)
	cost = 15
	containertype = /obj/structure/largecrate
	containername = "Cargo Train Trolley Crate"
