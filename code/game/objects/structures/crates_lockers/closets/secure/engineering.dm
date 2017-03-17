/obj/structure/closet/secure_closet/engineering_chief
	name = "chief engineer's locker"
	req_access = list(access_ce)
	icon_state = "securece"
	icon_opened = "secureceopen"
	icon_broken = "securecebroken"


	New()
		..()
		switch(rand(4))
			if(1) new /obj/item/weapon/storage/backpack/industrial(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel/eng(src)
			if(3) new /obj/item/weapon/storage/backpack/dufflebag/eng(src)
			if(4) new /obj/item/weapon/storage/backpack/messenger/eng(src)
		new /obj/item/clothing/accessory/storage/brown_vest(src)
		new /obj/item/blueprints(src)
		new /obj/item/clothing/under/rank/chief_engineer(src)
		new /obj/item/clothing/under/rank/chief_engineer/skirt(src)
		new /obj/item/clothing/head/hardhat/white(src)
		new /obj/item/clothing/head/welding(src)
		new /obj/item/clothing/gloves/yellow(src)
		new /obj/item/clothing/shoes/brown(src)
		new /obj/item/weapon/cartridge/ce(src)
		new /obj/item/device/radio/headset/heads/ce/alt(src)
		new /obj/item/weapon/storage/toolbox/mechanical(src)
		new /obj/item/clothing/suit/storage/hazardvest(src)
		new /obj/item/clothing/mask/gas(src)
		new /obj/item/device/multitool(src)
		new /obj/item/weapon/melee/baton/shocker/loaded(src)
		new /obj/item/device/flash(src)
		new /obj/item/taperoll/engineering(src)
		new /obj/item/weapon/tank/emergency_oxygen/engi(src)
		return



/obj/structure/closet/secure_closet/engineering_electrical
	name = "electrical supplies"
	req_access = list(access_engine_equip)
	icon_state = "secureengelec"
	icon_opened = "toolclosetopen"
	icon_broken = "secureengelecbroken"

	New()
		..()
		new /obj/item/clothing/gloves/yellow(src)
		new /obj/item/clothing/gloves/yellow(src)
		new /obj/item/weapon/storage/toolbox/electrical(src)
		new /obj/item/weapon/storage/toolbox/electrical(src)
		new /obj/item/weapon/storage/toolbox/electrical(src)
		new /obj/item/weapon/power_control(src)
		new /obj/item/weapon/power_control(src)
		new /obj/item/weapon/power_control(src)
		new /obj/item/device/multitool(src)
		new /obj/item/device/multitool(src)
		new /obj/item/device/multitool(src)
		return



/obj/structure/closet/secure_closet/engineering_welding
	name = "welding supplies"
	req_access = list(access_construction)
	icon_state = "secureengweld"
	icon_opened = "toolclosetopen"
	icon_broken = "secureengweldbroken"

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
		new /obj/item/clothing/glasses/welding(src)
		new /obj/item/clothing/glasses/welding(src)
		new /obj/item/clothing/glasses/welding(src)
		return



/obj/structure/closet/secure_closet/engineering_personal
	name = "engineer's locker"
	req_access = list(access_engine_equip)
	icon_state = "secureeng"
	icon_opened = "secureengopen"
	icon_broken = "secureengbroken"

	New()
		..()
		switch(rand(4))
			if(1) new /obj/item/weapon/storage/backpack/industrial(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel/eng(src)
			if(3) new /obj/item/weapon/storage/backpack/dufflebag/eng(src)
			if(4) new /obj/item/weapon/storage/backpack/messenger/eng(src)
		new /obj/item/clothing/accessory/storage/brown_vest(src)
		new /obj/item/weapon/storage/toolbox/mechanical(src)
		new /obj/item/device/radio/headset/eng(src)
		new /obj/item/device/radio/headset/eng/alt(src)
		new /obj/item/clothing/suit/storage/hazardvest(src)
		new /obj/item/clothing/mask/gas(src)
		new /obj/item/clothing/glasses/meson(src)
		new /obj/item/weapon/cartridge/engineering(src)
		new /obj/item/taperoll/engineering(src)
		new /obj/item/weapon/tank/emergency_oxygen/engi(src)
		return


/obj/structure/closet/secure_closet/atmos_personal
	name = "technician's locker"
	req_access = list(access_atmospherics)
	icon_state = "secureatm"
	icon_opened = "secureatmopen"
	icon_broken = "secureatmbroken"

	New()
		..()
		switch(rand(4))
			if(1) new /obj/item/weapon/storage/backpack/industrial(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel/eng(src)
			if(3) new /obj/item/weapon/storage/backpack/dufflebag/eng(src)
			if(4) new /obj/item/weapon/storage/backpack/messenger/eng(src)
		new /obj/item/clothing/accessory/storage/brown_vest(src)
		new /obj/item/clothing/suit/fire/firefighter(src)
		new /obj/item/device/flashlight(src)
		new /obj/item/weapon/extinguisher(src)
		new /obj/item/device/radio/headset/eng(src)
		new /obj/item/device/radio/headset/eng/alt(src)
		new /obj/item/clothing/suit/storage/hazardvest(src)
		new /obj/item/clothing/mask/gas(src)
		new /obj/item/weapon/cartridge/atmos(src)
		new /obj/item/taperoll/engineering(src)
		new /obj/item/weapon/tank/emergency_oxygen/engi(src)
		return
