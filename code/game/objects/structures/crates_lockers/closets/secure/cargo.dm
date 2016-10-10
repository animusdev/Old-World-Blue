/obj/structure/closet/secure_closet/cargotech
	name = "cargo technician's locker"
	req_access = list(access_cargo)
	icon_state = "securecargo"
	icon_opened = "securecargoopen"
	icon_broken = "securecargobroken"

	New()
		..()
		switch(rand(3))
			if(1) new /obj/item/weapon/storage/backpack(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel_norm(src)
			if(3) new /obj/item/weapon/storage/backpack/duffle(src)
		new /obj/item/clothing/under/rank/cargotech(src)
		new /obj/item/clothing/shoes/black(src)
		new /obj/item/device/radio/headset/headset_cargo(src)
		new /obj/item/clothing/gloves/black(src)
		new /obj/item/clothing/head/soft(src)
		return

/obj/structure/closet/secure_closet/quartermaster
	name = "quartermaster's locker"
	req_access = list(access_qm)
	icon_state = "secureqm"
	icon_opened = "secureqmopen"
	icon_broken = "secureqmbroken"

	New()
		..()
		switch(rand(3))
			if(1) new /obj/item/weapon/storage/backpack(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel_norm(src)
			if(3) new /obj/item/weapon/storage/backpack/duffle(src)
		new /obj/item/clothing/under/rank/qm(src)
		new /obj/item/clothing/shoes/brown(src)
		new /obj/item/device/radio/headset/headset_cargo(src)
		new /obj/item/clothing/gloves/black(src)
		new /obj/item/weapon/cartridge/quartermaster(src)
		new /obj/item/clothing/suit/fire/firefighter(src)
		new /obj/item/weapon/tank/emergency_oxygen(src)
		new /obj/item/clothing/mask/gas(src)
		new /obj/item/clothing/glasses/meson(src)
		new /obj/item/clothing/head/soft(src)
		return
