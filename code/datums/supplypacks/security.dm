/*
*	Here is where any supply packs
*	related to security tasks live
*/


/datum/supply_packs/security
	group = "Security"
	access = access_security

/datum/supply_packs/randomised/security
	group = "Security"
	access = access_security


/datum/supply_packs/security/riot_gear
	name = "Riot gear crate"
	contains = list(
		/obj/item/weapon/melee/baton = 3,
		/obj/item/weapon/shield/riot = 3,
		/obj/item/weapon/handcuffs = 3,
		/obj/item/weapon/storage/box/flashbangs,
		/obj/item/weapon/storage/box/beanbags,
		/obj/item/weapon/storage/box/handcuffs
	)
	cost = 40
	containertype = /obj/structure/closet/crate/secure
	containername = "riot gear crate"
	access = access_armory

/datum/supply_packs/security/beanbagammo
	name = "Beanbag shells"
	contains = list(/obj/item/weapon/storage/box/beanbags = 3)
	cost = 30
	containertype = /obj/structure/closet/crate/secure
	containername = "Beanbag shells"

/datum/supply_packs/security/securitybarriers
	name = "Security barrier crate"
	contains = list(/obj/machinery/deployable/barrier = 4)
	cost = 20
	containertype = /obj/structure/closet/crate/secure/gear
	containername = "Security barrier crate"
	access = null

/datum/supply_packs/security/securityshieldgen
	name = "Wall shield Generators"
	contains = list(/obj/machinery/shieldwallgen = 4)
	cost = 20
	containertype = /obj/structure/closet/crate/secure
	containername = "wall shield generators crate"
	access = access_teleporter

/datum/supply_packs/security/weapons
	name = "Weapons crate"
	contains = list(
		/obj/item/weapon/melee/baton,
		/obj/item/weapon/melee/baton,
		/obj/item/weapon/gun/energy/gun,
		/obj/item/weapon/gun/energy/gun,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/weapon/gun/projectile/sec,
		/obj/item/weapon/gun/projectile/sec,
		/obj/item/weapon/storage/box/flashbangs,
		/obj/item/weapon/storage/box/flashbangs
	)
	cost = 40
	containertype = /obj/structure/closet/crate/secure/weapon
	containername = "Weapons crate"

/datum/supply_packs/security/flareguns
	name = "Flare guns crate"
	contains = list(
		/obj/item/weapon/gun/projectile/sec/flash,
		/obj/item/ammo_magazine/c45m/flash,
		/obj/item/weapon/gun/projectile/shotgun/doublebarrel/flare,
		/obj/item/weapon/storage/box/flashshells
	)
	cost = 25
	containertype = /obj/structure/closet/crate/secure/weapon
	containername = "Flare gun crate"

/datum/supply_packs/security/eweapons
	name = "Experimental weapons crate"
	contains = list(
		/obj/item/weapon/gun/energy/xray = 2,
		/obj/item/weapon/shield/energy = 2,
		/obj/item/clothing/suit/armor/laserproof = 2
	)
	cost = 125
	containertype = /obj/structure/closet/crate/secure/weapon
	containername = "Experimental weapons crate"
	access = access_heads

/datum/supply_packs/security/energyweapons
	name = "Energy weapons crate"
	contains = list(
		/obj/item/weapon/gun/energy/laser,
		/obj/item/weapon/gun/energy/laser,
		/obj/item/weapon/gun/energy/laser
	)
	cost = 50
	containertype = /obj/structure/closet/crate/secure
	containername = "energy weapons crate"
	access = access_armory

/datum/supply_packs/security/shotgun
	name = "Shotgun crate"
	contains = list(
		/obj/item/clothing/suit/armor/bulletproof = 2,
		/obj/item/weapon/storage/box/shotgunammo,
		/obj/item/weapon/storage/box/shotgunshells,
		/obj/item/weapon/gun/projectile/shotgun/pump/combat = 2
	)
	cost = 65
	containertype = /obj/structure/closet/crate/secure
	containername = "Shotgun crate"
	access = access_armory

/datum/supply_packs/security/erifle
	name = "Energy marksman crate"
	contains = list(
		/obj/item/clothing/suit/armor/laserproof,
		/obj/item/clothing/suit/armor/laserproof,
		/obj/item/weapon/gun/energy/sniperrifle,
		/obj/item/weapon/gun/energy/sniperrifle
	)
	cost = 90
	containertype = /obj/structure/closet/crate/secure
	containername = "Energy marksman crate"
	access = access_armory

/datum/supply_packs/security/shotgunammo
	name = "Ballistic ammunition crate"
	contains = list(
		/obj/item/weapon/storage/box/shotgunammo = 2,
		/obj/item/weapon/storage/box/shotgunshells = 2
	)
	cost = 60
	containertype = /obj/structure/closet/crate/secure
	containername = "ballistic ammunition crate"
	access = access_armory

/datum/supply_packs/security/ionweapons
	name = "Electromagnetic weapons crate"
	contains = list(
		/obj/item/weapon/gun/energy/ionrifle = 2,
		/obj/item/weapon/storage/box/emps
	)
	cost = 50
	containertype = /obj/structure/closet/crate/secure
	containername = "electromagnetic weapons crate"
	access = access_armory

/datum/supply_packs/security/expenergy
	name = "Experimental energy gear crate"
	contains = list(
		/obj/item/clothing/suit/armor/laserproof = 2,
		/obj/item/weapon/gun/energy/gun = 2
	)
	cost = 50
	containertype = /obj/structure/closet/crate/secure
	containername = "Experimental energy gear crate"
	access = access_armory

/datum/supply_packs/security/exparmor
	name = "Experimental armor crate"
	contains = list(
		/obj/item/clothing/suit/armor/laserproof = 2,
		/obj/item/clothing/head/helmet/riot,
		/obj/item/clothing/suit/armor/riot
	)
	cost = 40
	containertype = /obj/structure/closet/crate/secure
	containername = "Experimental armor crate"
	access = access_armory

/datum/supply_packs/security/tactical
	name = "Tactical suits"
	containertype = /obj/structure/closet/crate/secure
	containername = "Tactical Suit Locker"
	cost = 50
	access = access_armory
	contains = list(
		/obj/item/clothing/under/rank/tactical = 2,
		/obj/item/clothing/suit/armor/tactical = 2,
		/obj/item/clothing/head/helmet/tactical = 2,
		/obj/item/clothing/mask/balaclava/tactical = 2,
		/obj/item/clothing/glasses/sunglasses/sechud/tactical = 2,
		/obj/item/weapon/storage/belt/security/tactical = 2,
		/obj/item/clothing/shoes/jackboots = 2,
		/obj/item/clothing/gloves/black = 2
	)

/datum/supply_packs/randomised/security/armor
	num_contained = 5
	contains = list(
		/obj/item/clothing/suit/storage/vest,
		/obj/item/clothing/suit/storage/vest/officer,
		/obj/item/clothing/suit/storage/vest/warden,
		/obj/item/clothing/suit/storage/vest/hos,
		/obj/item/clothing/suit/storage/vest/pcrc,
		/obj/item/clothing/suit/storage/vest/detective,
		/obj/item/clothing/suit/storage/vest/heavy,
		/obj/item/clothing/suit/storage/vest/heavy/officer,
		/obj/item/clothing/suit/storage/vest/heavy/warden,
		/obj/item/clothing/suit/storage/vest/heavy/hos,
		/obj/item/clothing/suit/storage/vest/heavy/pcrc
		)
	name = "Armor crate"
	cost = 40
	containertype = /obj/structure/closet/crate/secure
	containername = "Armor crate"

/datum/supply_packs/randomised/security/automatic
	name = "Automatic weapon crate"
	num_contained = 2
	contains = list(
		/obj/item/weapon/gun/projectile/automatic/wt550,
		/obj/item/weapon/gun/projectile/automatic/z8
	)
	cost = 90
	containertype = /obj/structure/closet/crate/secure
	containername = "Automatic weapon crate"
	access = access_armory

/datum/supply_packs/randomised/security/autoammo
	name = "Automatic weapon ammunition crate"
	num_contained = 6
	contains = list(
		/obj/item/ammo_magazine/mc9mmt,
		/obj/item/ammo_magazine/mc9mmt/rubber,
		/obj/item/ammo_magazine/a556
	)
	cost = 20
	containertype = /obj/structure/closet/crate/secure
	containername = "Automatic weapon ammunition crate"
	access = access_armory