/obj/structure/closet/secure_closet/scientist
	name = "scientist's locker"
	req_access = list(access_tox_storage)
	icon_state = "secureres"
	icon_opened = "secureresopen"
	icon_broken = "secureresbroken"

	New()
		..()
		new /obj/item/clothing/under/rank/scientist(src)
		new /obj/item/clothing/under/rank/plasmares(src)
		new /obj/item/clothing/suit/storage/toggle/labcoat(src)
		new /obj/item/clothing/shoes/white(src)
//		new /obj/item/weapon/cartridge/signal/science(src)
		new /obj/item/device/radio/headset/sci(src)
		new /obj/item/weapon/tank/air(src)
		new /obj/item/clothing/mask/gas(src)
		return



/obj/structure/closet/secure_closet/RD
	name = "research director's locker"
	req_access = list(access_rd)
	icon_state = "rdsecure"
	icon_opened = "rdsecureopen"
	icon_broken = "rdsecurebroken"

	New()
		..()
		new /obj/item/clothing/suit/bio_suit/scientist(src)
		new /obj/item/clothing/head/bio_hood/scientist(src)
		new /obj/item/clothing/under/rank/research_director(src)
		new /obj/item/clothing/under/rank/research_director/alt(src)
		new /obj/item/clothing/under/rank/research_director/skirt(src)
		new /obj/item/clothing/suit/storage/toggle/labcoat(src)
		new /obj/item/weapon/cartridge/rd(src)
		new /obj/item/clothing/shoes/white(src)
		new /obj/item/clothing/shoes/leather(src)
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/device/radio/headset/heads/rd(src)
		new /obj/item/device/radio/headset/heads/rd/alt(src)
		new /obj/item/weapon/tank/air(src)
		new /obj/item/clothing/mask/gas(src)
		new /obj/item/weapon/melee/baton/shocker/loaded(src)
		new /obj/item/device/flash(src)
		return


/obj/structure/closet/secure_closet/animal
	name = "animal control closet"
	req_access = list(access_surgery)

	New()
		..()
		new /obj/item/device/assembly/signaler(src)
		new /obj/item/device/radio/electropack(src)
		new /obj/item/device/radio/electropack(src)
		new /obj/item/device/radio/electropack(src)
		return

