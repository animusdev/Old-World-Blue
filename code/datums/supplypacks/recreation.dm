/*
*	Here is where any supply packs
*	related to recreation live.
*/


/datum/supply_packs/recreation
	group = "Recreation"

/datum/supply_packs/randomised/recreation
	group = "Recreation"
	access = access_security

/datum/supply_packs/recreation/artscrafts
	name = "Arts and Crafts supplies"
	contains = list(
		/obj/item/weapon/storage/fancy/crayons,
		/obj/item/device/camera,
		/obj/item/device/camera_film = 2,
		/obj/item/weapon/storage/photo_album,
		/obj/item/weapon/packageWrap,
		/obj/item/weapon/reagent_containers/glass/paint/red,
		/obj/item/weapon/reagent_containers/glass/paint/green,
		/obj/item/weapon/reagent_containers/glass/paint/blue,
		/obj/item/weapon/reagent_containers/glass/paint/yellow,
		/obj/item/weapon/reagent_containers/glass/paint/purple,
		/obj/item/weapon/reagent_containers/glass/paint/black,
		/obj/item/weapon/reagent_containers/glass/paint/white,
		/obj/item/weapon/contraband/poster,
		/obj/item/weapon/wrapping_paper = 3
	)
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Arts and Crafts crate"

/datum/supply_packs/recreation/painters
	name = "Station Painting Supplies"
	cost = 10
	containername = "station painting supplies crate"
	containertype = /obj/structure/closet/crate
	contains = list(
		/obj/item/device/pipe_painter = 2,
		/obj/item/device/floor_painter = 2,
//		/obj/item/device/closet_painter = 2
	)
