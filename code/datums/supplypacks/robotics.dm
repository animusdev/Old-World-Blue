/*
*	Here is where any supply packs
*	related to robotics tasks live.
*/


/datum/supply_packs/robotics
	group = "Robotics"

/datum/supply_packs/randomised/robotics
	group = "Robotics"
	access = access_robotics

/datum/supply_packs/robotics/robotics
	name = "Robotics assembly crate"
	contains = list(
		/obj/item/device/assembly/prox_sensor = 3,
		/obj/item/weapon/storage/toolbox/electrical,
		/obj/item/device/flash = 4,
		/obj/item/weapon/cell/high = 2
	)
	cost = 10
	containertype = /obj/structure/closet/crate/secure/gear
	containername = "Robotics assembly"
	access = access_robotics

/datum/supply_packs/robotics/mecha_ripley
	name = "Circuit Crate (\"Ripley\" APLU)"
	contains = list(
		/obj/item/weapon/book/manual/ripley_build_and_repair,
		/obj/item/weapon/circuitboard/mecha/ripley/main,
		/obj/item/weapon/circuitboard/mecha/ripley/peripherals
	)
	cost = 25
	containertype = /obj/structure/closet/crate/secure
	containername = "APLU \"Ripley\" Circuit Crate"
	access = access_robotics

/datum/supply_packs/robotics/mecha_odysseus
	name = "Circuit Crate (\"Odysseus\")"
	contains = list(
		/obj/item/weapon/circuitboard/mecha/odysseus/peripherals,
		/obj/item/weapon/circuitboard/mecha/odysseus/main
	)
	cost = 25
	containertype = /obj/structure/closet/crate/secure
	containername = "\"Odysseus\" Circuit Crate"
	access = access_robotics

/datum/supply_packs/robotics/exosuit_mod
	cost = 50
	containertype = /obj/structure/closet/crate
	containername = "heavy crate"

/datum/supply_packs/robotics/exosuit_mod/aplu
	contains = list(/obj/item/device/kit/paint/ripley)
	name = "APLU classic modkit"

/datum/supply_packs/robotics/exosuit_mod/aplu/medic
	contains = list(/obj/item/device/kit/paint/ripley/medic)
	name = "APLU medical modkit"
	containertype = /obj/structure/closet/crate
	containername = "heavy crate"

/datum/supply_packs/robotics/exosuit_mod/aplu/death
	contains = list(/obj/item/device/kit/paint/ripley/death)
	name = "APLU death modkit"
	cost = 60
	containertype = /obj/structure/closet/crate
	containername = "heavy crate"

/datum/supply_packs/robotics/exosuit_mod/aplu/red
	contains = list(/obj/item/device/kit/paint/ripley/flames_red)
	name = "APLU flames red modkit"
	cost = 60

/datum/supply_packs/robotics/exosuit_mod/aplu/blue
	contains = list(/obj/item/device/kit/paint/ripley/flames_blue)
	name = "APLU flames blue modkit"
	cost = 60

/datum/supply_packs/robotics/exosuit_mod/durand
	contains = list(/obj/item/device/kit/paint/durand)
	name = "Durand classic exosuit modkit"
	cost = 75

/datum/supply_packs/robotics/exosuit_mod/durand/seraph
	contains = list(/obj/item/device/kit/paint/durand/seraph)
	name = "Durand seraph exosuit modkit"
	cost = 80

/datum/supply_packs/robotics/exosuit_mod/durand/phazon
	contains = list(/obj/item/device/kit/paint/durand/phazon)
	name = "Durand phazon exosuit modkit"
	cost = 80

/datum/supply_packs/robotics/exosuit_mod/gygax
	contains = list(/obj/item/device/kit/paint/gygax)
	name = "Gygax classic exosuit modkit"
	cost = 75

/datum/supply_packs/robotics/exosuit_mod/gygax/darkgygax
	contains = list(/obj/item/device/kit/paint/gygax/darkgygax)
	name = "Gygax darkgygax exosuit modkit"
	cost = 80

/datum/supply_packs/robotics/exosuit_mod/gygax/recitence
	contains = list(/obj/item/device/kit/paint/gygax/recitence)
	name = "Gygax recitence exosuit modkit"
	cost = 80

