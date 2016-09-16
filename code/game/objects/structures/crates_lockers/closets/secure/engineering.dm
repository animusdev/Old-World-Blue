/obj/structure/closet/secure_closet/engineering_chief
	name = "chief engineer's locker"
	req_access = list(access_ce)
	icon_state = "securece"
	icon_closed = "securece"
	icon_opened = "secureceopen"
	icon_broken = "securecebroken"
	icon_off = "secureceoff"


	New()
		..()
		switch(pick(1,2,3))
			if(1)
				new /obj/item/weapon/storage/backpack/industrial(src)
			if(2)
				new /obj/item/weapon/storage/backpack/satchel_eng(src)
			if(3)
				new /obj/item/weapon/storage/backpack/duffle/engie(src)
		if (prob(70))
			new /obj/item/clothing/accessory/storage/brown_vest(src)
		else
			new /obj/item/clothing/accessory/storage/webbing(src)
		new /obj/item/blueprints(src)
		new /obj/item/clothing/under/rank/chief_engineer(src)
		new /obj/item/clothing/head/hardhat/white(src)
		new /obj/item/clothing/head/welding(src)
		new /obj/item/clothing/gloves/yellow(src)
		new /obj/item/clothing/shoes/brown(src)
		new /obj/item/weapon/cartridge/ce(src)
		new /obj/item/device/radio/headset/heads/ce(src)
		new /obj/item/weapon/storage/toolbox/mechanical(src)
		new /obj/item/clothing/suit/storage/hazardvest(src)
		new /obj/item/clothing/mask/gas(src)
		new /obj/item/device/multitool(src)
		new /obj/item/weapon/melee/baton/shocker(src)
		new /obj/item/device/flash(src)
		new /obj/item/taperoll/engineering(src)
		return



/obj/structure/closet/secure_closet/engineering_electrical
	name = "electrical supplies"
	req_access = list(access_engine_equip)
	icon_state = "secureengelec"
	icon_closed = "secureengelec"
	icon_opened = "toolclosetopen"
	icon_broken = "secureengelecbroken"
	icon_off = "secureengelecoff"

	New()
		..()
		new /obj/item/clothing/gloves/yellow(src)
		new /obj/item/clothing/gloves/yellow(src)
		new /obj/item/weapon/storage/toolbox/electrical(src)
		new /obj/item/weapon/storage/toolbox/electrical(src)
		new /obj/item/weapon/storage/toolbox/electrical(src)
		new /obj/item/weapon/module/power_control(src)
		new /obj/item/weapon/module/power_control(src)
		new /obj/item/weapon/module/power_control(src)
		new /obj/item/device/multitool(src)
		new /obj/item/device/multitool(src)
		new /obj/item/device/multitool(src)
		return



/obj/structure/closet/secure_closet/engineering_welding
	name = "welding supplies"
	req_access = list(access_construction)
	icon_state = "secureengweld"
	icon_closed = "secureengweld"
	icon_opened = "toolclosetopen"
	icon_broken = "secureengweldbroken"
	icon_off = "secureengweldoff"

	New()
		..()
		new /obj/item/clothing/head/welding(src)
		new /obj/item/clothing/head/welding(src)
		new /obj/item/clothing/head/welding(src)
		new /obj/item/weapon/weldingtool/largetank(src)
		new /obj/item/weapon/weldingtool/largetank(src)
		new /obj/item/weapon/weldingtool/largetank(src)
		new /obj/item/weapon/weldpack(src)
		new /obj/item/weapon/weldpack(src)
		new /obj/item/weapon/weldpack(src)
		return



/obj/structure/closet/secure_closet/engineering_personal
	name = "engineer's locker"
	req_access = list(access_engine_equip)
	icon_state = "secureeng"
	icon_closed = "secureeng"
	icon_opened = "secureengopen"
	icon_broken = "secureengbroken"
	icon_off = "secureengoff"

	New()
		..()
		switch(pick(1,2,3))
			if(1)
				new /obj/item/weapon/storage/backpack/industrial(src)
			if(2)
				new /obj/item/weapon/storage/backpack/satchel_eng(src)
			if(3)
				new /obj/item/weapon/storage/backpack/duffle/engie(src)

		if (prob(70))
			new /obj/item/clothing/accessory/storage/brown_vest(src)
		else
			new /obj/item/clothing/accessory/storage/webbing(src)
		new /obj/item/weapon/storage/toolbox/mechanical(src)
		new /obj/item/device/radio/headset/headset_eng(src)
		new /obj/item/clothing/suit/storage/hazardvest(src)
		new /obj/item/clothing/mask/gas(src)
		new /obj/item/clothing/glasses/meson(src)
		new /obj/item/weapon/cartridge/engineering(src)
		new /obj/item/taperoll/engineering(src)
		return

/obj/structure/closet/secure_closet/atmos_personal
	name = "technician's locker"
	req_access = list(access_atmospherics)
	icon_state = "secureatm"
	icon_closed = "secureatm"
	icon_opened = "secureatmopen"
	icon_broken = "secureatmbroken"
	icon_off = "secureatmoff"

	New()
		..()
		switch(pick(1,2,3))
			if(1)
				new /obj/item/weapon/storage/backpack/industrial(src)
			if(2)
				new /obj/item/weapon/storage/backpack/satchel_eng(src)
			if(3)
				new /obj/item/weapon/storage/backpack/duffle/engie(src)

		if (prob(70))
			new /obj/item/clothing/accessory/storage/brown_vest(src)
		else
			new /obj/item/clothing/accessory/storage/webbing(src)
		new /obj/item/clothing/suit/fire/firefighter(src)
		new /obj/item/device/flashlight(src)
		new /obj/item/weapon/extinguisher(src)
		new /obj/item/device/radio/headset/headset_eng(src)
		new /obj/item/clothing/suit/storage/hazardvest(src)
		new /obj/item/clothing/mask/gas(src)
		new /obj/item/weapon/cartridge/atmos(src)
		new /obj/item/taperoll/engineering(src)
		return
