/*
*	Here is where any supply packs
*	related to medical tasks live.
*/


/datum/supply_packs/med
	group = "Medical"

/datum/supply_packs/med/medical
	name = "Medical crate"
	contains = list(
		/obj/item/weapon/storage/firstaid/regular,
		/obj/item/weapon/storage/firstaid/fire,
		/obj/item/weapon/storage/firstaid/toxin,
		/obj/item/weapon/storage/firstaid/o2,
		/obj/item/weapon/storage/firstaid/adv,
		/obj/item/weapon/reagent_containers/glass/beaker/bottle/antitoxin,
		/obj/item/weapon/reagent_containers/glass/beaker/bottle/inaprovaline,
		/obj/item/weapon/reagent_containers/glass/beaker/bottle/stoxin,
		/obj/item/weapon/storage/box/syringes,
		/obj/item/weapon/storage/box/autoinjectors
	)
	cost = 10
	containertype = /obj/structure/closet/crate/medical
	containername = "Medical crate"

/datum/supply_packs/med/bloodpack
	name = "BloodPack crate"
	contains = list(/obj/item/weapon/storage/box/bloodpacks = 3)
	cost = 10
	containertype = /obj/structure/closet/crate/medical
	containername = "BloodPack crate"

/datum/supply_packs/med/bodybag
	name = "Body bag crate"
	contains = list(/obj/item/weapon/storage/box/bodybags = 3)
	cost = 10
	containertype = /obj/structure/closet/crate/medical
	containername = "Body bag crate"

/datum/supply_packs/med/cryobag
	name = "Stasis bag crate"
	contains = list(/obj/item/bodybag/cryobag = 3)
	cost = 40
	containertype = /obj/structure/closet/crate/medical
	containername = "Stasis bag crate"

/datum/supply_packs/med/surgery
	name = "Surgery crate"
	contains = list(
		/obj/item/weapon/cautery,
		/obj/item/weapon/surgicaldrill,
		/obj/item/clothing/mask/breath/medical,
		/obj/item/weapon/tank/anesthetic,
		/obj/item/weapon/FixOVein,
		/obj/item/weapon/hemostat,
		/obj/item/weapon/scalpel,
		/obj/item/weapon/bonegel,
		/obj/item/weapon/retractor,
		/obj/item/weapon/bonesetter,
		/obj/item/weapon/circular_saw
	)
	cost = 25
	containertype = /obj/structure/closet/crate/secure
	containername = "Surgery crate"
	access = access_medical

/datum/supply_packs/med/sterile
	name = "Sterile equipment crate"
	contains = list(
		/obj/item/clothing/under/rank/medical/sleeveless/green = 2,
		/obj/item/clothing/head/surgery/green = 2,
		/obj/item/weapon/storage/box/masks,
		/obj/item/weapon/storage/box/gloves,
		/obj/item/weapon/storage/belt/medical = 3
	)
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Sterile equipment crate"

/datum/supply_packs/gen_disks
	name = "Genetics disks crate"
	contains = list(/obj/item/weapon/storage/box/disks = 2)
	cost = 10
	containertype = /obj/structure/closet/crate/medical
	containername = "Genetics disks crate"

/datum/supply_packs/med/virus
	name = "Virus sample crate"
	contains = list(/obj/item/weapon/virusdish/random = 4)
	cost = 25
	containertype = /obj/structure/closet/crate/secure
	containername = "Virus sample crate"
	access = access_cmo
