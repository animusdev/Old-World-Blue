/obj/structure/closet/cabinet/underwear
	name = "underwear wardrobe"
	desc = "Holds item of clothing you shouldn't be showing off in the hallways."

/obj/structure/closet/cabinet/underwear/New()
	..()
	var/tmp_type
	for(var/i in 1 to 6)
		tmp_type = pick(subtypesof(/obj/item/clothing/hidden/underwear))
		new tmp_type(src)
	for(var/i in 1 to 6)
		tmp_type = pick(subtypesof(/obj/item/clothing/hidden/undershirt))
		new tmp_type(src)
	for(var/i in 1 to 6)
		tmp_type = pick(subtypesof(/obj/item/clothing/hidden/socks))
		new tmp_type(src)

/obj/structure/closet/wardrobe
	name = "wardrobe"
	desc = "It's a storage unit for standard-issue attire."
	icon_state = "blue"

/obj/structure/closet/wardrobe/red
	name = "security wardrobe"
	icon_state = "red"

/obj/structure/closet/wardrobe/red/New()
	..()
	for(var/i in 1 to 3)
		switch(rand(4))
			if(1) new /obj/item/weapon/storage/backpack/security(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel/sec(src)
			if(3) new /obj/item/weapon/storage/backpack/dufflebag/sec(src)
			if(4) new /obj/item/weapon/storage/backpack/messenger/sec(src)
	new /obj/item/clothing/under/rank/security(src)
	new /obj/item/clothing/under/rank/security(src)
	new /obj/item/clothing/under/rank/security(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/head/soft/sec(src)
	new /obj/item/clothing/head/soft/sec(src)
	new /obj/item/clothing/head/soft/sec(src)
	new /obj/item/clothing/head/beret/sec(src)
	new /obj/item/clothing/head/beret/sec(src)
	new /obj/item/clothing/head/beret/sec(src)
	new /obj/item/clothing/mask/bandana/red(src)
	new /obj/item/clothing/mask/bandana/red(src)
	new /obj/item/clothing/mask/bandana/red(src)
	new /obj/item/clothing/accessory/armband(src)
	new /obj/item/clothing/accessory/armband(src)
	new /obj/item/clothing/accessory/armband(src)
	new /obj/item/clothing/accessory/holster/gun/armpit(src)
	new /obj/item/clothing/accessory/holster/gun/waist(src)
	new /obj/item/clothing/accessory/holster/gun/waist(src)
	new /obj/item/clothing/accessory/holster/gun/hip(src)
	return

/obj/structure/closet/wardrobe/redalt
	name = "alternative security wardrobe"
	desc = "It's a storage unit for not-so-standard-issue Nanotrasen attire. Still allowed though."
	icon_state = "red"

/obj/structure/closet/wardrobe/redalt/New()
	..()
	new /obj/item/clothing/under/rank/cadet(src)
	new /obj/item/clothing/under/rank/cadet(src)
	new /obj/item/clothing/under/rank/cadet(src)
	new /obj/item/clothing/under/rank/dispatch(src)
	new /obj/item/clothing/under/rank/dispatch(src)
	new /obj/item/clothing/head/beret/sec/alt(src)
	new /obj/item/clothing/head/beret/sec/alt(src)
	new /obj/item/clothing/head/beret/sec/alt(src)
	new /obj/item/clothing/under/rank/security/navyblue(src)
	new /obj/item/clothing/under/rank/security/navyblue(src)
	new /obj/item/clothing/under/rank/security/dnavy(src)
	new /obj/item/clothing/under/rank/security/dnavy(src)
	return

/obj/structure/closet/wardrobe/pink
	name = "pink wardrobe"
	icon_state = "pink"

/obj/structure/closet/wardrobe/pink/New()
	..()
	new /obj/item/clothing/under/color/pink(src)
	new /obj/item/clothing/under/color/pink(src)
	new /obj/item/clothing/under/color/pink(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/shoes/brown(src)
	return

/obj/structure/closet/wardrobe/black
	name = "black wardrobe"
	icon_state = "black"

/obj/structure/closet/wardrobe/black/New()
	..()
	new /obj/item/clothing/under/color/black(src)
	new /obj/item/clothing/under/color/black(src)
	new /obj/item/clothing/under/color/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/head/that(src)
	new /obj/item/clothing/head/that(src)
	new /obj/item/clothing/head/that(src)
	new /obj/item/clothing/head/soft/black(src)
	new /obj/item/clothing/head/soft/black(src)
	new /obj/item/clothing/head/soft/black(src)
	new /obj/item/clothing/mask/bandana(src)
	new /obj/item/clothing/mask/bandana(src)
	new /obj/item/clothing/mask/bandana(src)
	new /obj/item/weapon/storage/backpack/messenger/black(src)
	return


/obj/structure/closet/wardrobe/chaplain_black
	name = "chapel wardrobe"
	desc = "It's a storage unit for approved religious attire."
	icon_state = "black"

/obj/structure/closet/wardrobe/chaplain_black/New()
	..()
	new /obj/item/clothing/under/rank/chaplain(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/suit/nun(src)
	new /obj/item/clothing/head/nun_hood(src)
	new /obj/item/clothing/suit/storage/chaplain_hoodie(src)
	new /obj/item/clothing/head/chaplain_hood(src)
	new /obj/item/clothing/suit/holidaypriest(src)
	new /obj/item/clothing/under/wedding/bride_white(src)
	new /obj/item/weapon/storage/backpack/cultpack (src)
	new /obj/item/weapon/storage/fancy/candle_box(src)
	new /obj/item/weapon/storage/fancy/candle_box(src)
	return


/obj/structure/closet/wardrobe/green
	name = "green wardrobe"
	icon_state = "green"

/obj/structure/closet/wardrobe/green/New()
	..()
	new /obj/item/clothing/under/color/green(src)
	new /obj/item/clothing/under/color/green(src)
	new /obj/item/clothing/under/color/green(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/mask/bandana/green(src)
	new /obj/item/clothing/mask/bandana/green(src)
	new /obj/item/clothing/mask/bandana/green(src)
	return

/obj/structure/closet/wardrobe/xenos
	name = "xenos wardrobe"
	icon_state = "green"

/obj/structure/closet/wardrobe/xenos/New()
	..()
	new /obj/item/clothing/suit/unathi/mantle(src)
	new /obj/item/clothing/suit/unathi/robe(src)
	new /obj/item/clothing/shoes/sandal(src)
	new /obj/item/clothing/shoes/sandal(src)
	new /obj/item/clothing/shoes/sandal(src)
	return


/obj/structure/closet/wardrobe/orange
	name = "prison wardrobe"
	desc = "It's a storage unit for regulation prisoner attire."
	icon_state = "orange"

/obj/structure/closet/wardrobe/orange/New()
	..()
	new /obj/item/clothing/under/color/orange(src)
	new /obj/item/clothing/under/color/orange(src)
	new /obj/item/clothing/under/color/orange(src)
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/shoes/orange(src)
	return


/obj/structure/closet/wardrobe/yellow
	name = "yellow wardrobe"
	icon_state = "yellow"

/obj/structure/closet/wardrobe/yellow/New()
	..()
	new /obj/item/clothing/under/color/yellow(src)
	new /obj/item/clothing/under/color/yellow(src)
	new /obj/item/clothing/under/color/yellow(src)
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/mask/bandana/gold(src)
	new /obj/item/clothing/mask/bandana/gold(src)
	new /obj/item/clothing/mask/bandana/gold(src)
	return


/obj/structure/closet/wardrobe/atmospherics_yellow
	name = "atmospherics wardrobe"
	icon_state = "yellow"

/obj/structure/closet/wardrobe/atmospherics_yellow/New()
	..()
	new /obj/item/clothing/under/rank/atmospheric_technician(src)
	new /obj/item/clothing/under/rank/atmospheric_technician(src)
	new /obj/item/clothing/under/rank/atmospheric_technician(src)
	new /obj/item/clothing/under/rank/atmospheric_technician/skirt(src)
	new /obj/item/clothing/under/rank/atmospheric_technician/skirt(src)
	new /obj/item/clothing/under/rank/atmospheric_technician/skirt(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/head/hardhat/red(src)
	new /obj/item/clothing/head/hardhat/red(src)
	new /obj/item/clothing/head/hardhat/red(src)
	new /obj/item/clothing/head/beret/eng(src)
	new /obj/item/clothing/head/beret/eng(src)
	new /obj/item/clothing/head/beret/eng(src)
	new /obj/item/clothing/mask/bandana/gold(src)
	new /obj/item/clothing/mask/bandana/gold(src)
	new /obj/item/clothing/mask/bandana/gold(src)
	return

/obj/structure/closet/wardrobe/engineering_yellow
	name = "engineering wardrobe"
	icon_state = "yellow"

/obj/structure/closet/wardrobe/engineering_yellow/New()
	..()
	new /obj/item/clothing/under/rank/engineer(src)
	new /obj/item/clothing/under/rank/engineer/maintenance_tech(src)
	new /obj/item/clothing/under/rank/engineer/engine_tech(src)
	new /obj/item/clothing/under/rank/engineer/electrician(src)
	new /obj/item/clothing/under/rank/engineer/skirt
	new /obj/item/clothing/under/rank/engineer/skirt
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/head/hardhat(src)
	new /obj/item/clothing/head/hardhat(src)
	new /obj/item/clothing/head/hardhat(src)
	new /obj/item/clothing/head/beret/eng(src)
	new /obj/item/clothing/head/beret/eng(src)
	new /obj/item/clothing/head/beret/eng(src)
	new /obj/item/clothing/mask/bandana/gold(src)
	new /obj/item/clothing/mask/bandana/gold(src)
	new /obj/item/clothing/mask/bandana/gold(src)
	new /obj/item/clothing/shoes/workboots(src)
	new /obj/item/clothing/shoes/workboots(src)
	new /obj/item/clothing/shoes/workboots(src)
	return


/obj/structure/closet/wardrobe/white
	name = "white wardrobe"
	icon_state = "white"

/obj/structure/closet/wardrobe/white/New()
	..()
	new /obj/item/clothing/under/color/white(src)
	new /obj/item/clothing/under/color/white(src)
	new /obj/item/clothing/under/color/white(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	return


/obj/structure/closet/wardrobe/pjs
	name = "pajama wardrobe"
	icon_state = "white"

/obj/structure/closet/wardrobe/pjs/New()
	..()
	new /obj/item/clothing/under/pj/red(src)
	new /obj/item/clothing/under/pj/red(src)
	new /obj/item/clothing/under/pj/blue(src)
	new /obj/item/clothing/under/pj/blue(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/slippers(src)
	new /obj/item/clothing/shoes/slippers(src)
	return


/obj/structure/closet/wardrobe/research
	name = "science wardrobe"
	icon_state = "white"

/obj/structure/closet/wardrobe/research/New()
	..()
	new /obj/item/clothing/under/rank/scientist(src)
	new /obj/item/clothing/under/rank/scientist(src)
	new /obj/item/clothing/under/rank/xenoarch(src)
	new /obj/item/clothing/under/rank/xenoarch(src)
	new /obj/item/clothing/under/rank/plasmares(src)
	new /obj/item/clothing/under/rank/plasmares(src)
	new /obj/item/clothing/under/rank/xenobio(src)
	new /obj/item/clothing/under/rank/xenobio(src)
	new /obj/item/clothing/under/rank/anomalist(src)
	new /obj/item/clothing/under/rank/anomalist(src)
	new /obj/item/clothing/suit/storage/toggle/labcoat(src)
	new /obj/item/clothing/suit/storage/toggle/labcoat(src)
	new /obj/item/clothing/suit/storage/toggle/labcoat(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	for(var/i in 1 to 2)
		switch(rand(3))
			if(1) new /obj/item/weapon/storage/backpack/toxins(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel/tox(src)
			if(3) new /obj/item/weapon/storage/backpack/messenger/tox(src)
	return

/obj/structure/closet/wardrobe/robotics_black
	name = "robotics wardrobe"
	icon_state = "black"

/obj/structure/closet/wardrobe/robotics_black/New()
	..()
	for(var/i in 1 to 2)
		switch(rand(3))
			if(1) new /obj/item/weapon/storage/backpack/toxins(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel/tox(src)
			if(4) new /obj/item/weapon/storage/backpack/messenger/tox(src)
	new /obj/item/clothing/under/rank/roboticist(src)
	new /obj/item/clothing/under/rank/roboticist/skirt(src)
	new /obj/item/clothing/under/rank/biomechanical(src)
	new /obj/item/clothing/under/rank/mechatronic(src)
	new /obj/item/clothing/suit/storage/toggle/labcoat/science(src)
	new /obj/item/clothing/suit/storage/toggle/labcoat/science(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/gloves/black(src)
	new /obj/item/clothing/gloves/black(src)
	new /obj/item/device/radio/headset/rob(src)
	new /obj/item/device/radio/headset/rob(src)
	return


/obj/structure/closet/wardrobe/chemistry_white
	name = "chemistry wardrobe"
	icon_state = "white"

/obj/structure/closet/wardrobe/chemistry_white/New()
	..()
	new /obj/item/clothing/under/rank/chemist(src)
	new /obj/item/clothing/under/rank/pharma(src)
	new /obj/item/clothing/under/rank/chemist_new(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/suit/storage/toggle/labcoat/chemist(src)
	new /obj/item/clothing/suit/storage/toggle/labcoat/chemist(src)
	for(var/i in 1 to 2)
		switch(rand(4))
			if(1) new /obj/item/weapon/storage/backpack/chemistry(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel/chem(src)
			if(3) new /obj/item/weapon/storage/backpack/dufflebag/med(src)
			if(4) new /obj/item/weapon/storage/backpack/messenger/chem(src)
	return


/obj/structure/closet/wardrobe/genetics_white
	name = "genetics wardrobe"
	icon_state = "white"

/obj/structure/closet/wardrobe/genetics_white/New()
	..()
	new /obj/item/clothing/under/rank/geneticist(src)
	new /obj/item/clothing/under/rank/geneticist_new(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/suit/storage/toggle/labcoat/genetics(src)
	new /obj/item/clothing/suit/storage/toggle/labcoat/genetics(src)
	for(var/i in 1 to 2)
		switch(rand(4))
			if(1) new /obj/item/weapon/storage/backpack/genetics(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel/gen(src)
			if(3) new /obj/item/weapon/storage/backpack/dufflebag/med(src)
			if(4) new /obj/item/weapon/storage/backpack/messenger/med(src)
	return


/obj/structure/closet/wardrobe/virology_white
	name = "virology wardrobe"
	icon_state = "white"

/obj/structure/closet/wardrobe/virology_white/New()
	..()
	new /obj/item/clothing/under/rank/virologist(src)
	new /obj/item/clothing/under/rank/virologist_new(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/suit/storage/toggle/labcoat/virologist(src)
	new /obj/item/clothing/suit/storage/toggle/labcoat/virologist(src)
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/clothing/mask/surgical(src)
	for(var/i in 1 to 2)
		switch(rand(4))
			if(1) new /obj/item/weapon/storage/backpack/virology(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel/vir(src)
			if(3) new /obj/item/weapon/storage/backpack/dufflebag/med(src)
			if(4) new /obj/item/weapon/storage/backpack/messenger/vir(src)
	return


/obj/structure/closet/wardrobe/medic_white
	name = "medical wardrobe"
	icon_state = "white"

/obj/structure/closet/wardrobe/medic_white/New()
	..()
	new /obj/item/clothing/under/rank/medical(src)
	new /obj/item/clothing/under/rank/medical(src)
	new /obj/item/clothing/under/rank/medical/sleeveless/blue(src)
	new /obj/item/clothing/under/rank/medical/sleeveless/green(src)
	new /obj/item/clothing/under/rank/medical/sleeveless/purple(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/suit/storage/toggle/labcoat(src)
	new /obj/item/clothing/suit/storage/toggle/labcoat(src)
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/clothing/mask/surgical(src)
	return


/obj/structure/closet/wardrobe/grey
	name = "grey wardrobe"
	icon_state = "grey"

/obj/structure/closet/wardrobe/grey/New()
	..()
	new /obj/item/clothing/under/color/grey(src)
	new /obj/item/clothing/under/color/grey(src)
	new /obj/item/clothing/under/color/grey(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/head/soft/grey(src)
	new /obj/item/clothing/head/soft/grey(src)
	new /obj/item/clothing/head/soft/grey(src)
	return


/obj/structure/closet/wardrobe/mixed
	name = "mixed wardrobe"
	icon_state = "mixed"

/obj/structure/closet/wardrobe/mixed/New()
	..()
	new /obj/item/clothing/under/color/blue(src)
	new /obj/item/clothing/under/color/yellow(src)
	new /obj/item/clothing/under/color/green(src)
	new /obj/item/clothing/under/color/orange(src)
	new /obj/item/clothing/under/color/pink(src)
	new /obj/item/clothing/under/dress/plaid_blue(src)
	new /obj/item/clothing/under/dress/plaid_red(src)
	new /obj/item/clothing/under/dress/plaid_purple(src)
	new /obj/item/clothing/under/dress/plaid_black(src)
	new /obj/item/clothing/shoes/blue(src)
	new /obj/item/clothing/shoes/yellow(src)
	new /obj/item/clothing/shoes/green(src)
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/shoes/purple(src)
	new /obj/item/clothing/shoes/red(src)
	new /obj/item/clothing/shoes/leather(src)
	new /obj/item/clothing/mask/bandana/blue(src)
	new /obj/item/clothing/mask/bandana/blue(src)
	return

/obj/structure/closet/wardrobe/tactical
	name = "tactical equipment"
	icon_state = "syndicate1"
	icon_opened = "syndicate1open"

/obj/structure/closet/wardrobe/tactical/New()
	..()
	new /obj/item/clothing/under/rank/tactical(src)
	new /obj/item/clothing/suit/armor/tactical(src)
	new /obj/item/clothing/head/helmet/tactical(src)
	new /obj/item/clothing/mask/balaclava/tactical(src)
	new /obj/item/clothing/mask/balaclava(src)
	new /obj/item/clothing/glasses/sunglasses/sechud/tactical(src)
	new /obj/item/weapon/storage/belt/security/tactical(src)
	if(prob(10))
		new /obj/item/clothing/mask/bandana/skull(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/gloves/black(src)
	new /obj/item/clothing/under/pants/camo(src)
	return

/obj/structure/closet/wardrobe/ert
	name = "emergency response team equipment"
	icon_state = "syndicate1"
	icon_opened = "syndicate1open"

/obj/structure/closet/wardrobe/ert/New()
	..()
	new /obj/item/clothing/under/rank/centcom(src)
	new /obj/item/clothing/under/ert(src)
	new /obj/item/clothing/under/syndicate/combat(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/shoes/swat(src)
	new /obj/item/clothing/gloves/black/swat(src)
	new /obj/item/clothing/mask/balaclava/tactical(src)
	new /obj/item/clothing/mask/balaclava(src)
	new /obj/item/clothing/mask/bandana/skull(src)
	new /obj/item/clothing/mask/bandana/skull(src)
	return

/obj/structure/closet/wardrobe/suit
	name = "suit locker"
	icon_state = "mixed"

/obj/structure/closet/wardrobe/suit/New()
	..()
	new /obj/item/clothing/under/assistantformal(src)
	new /obj/item/clothing/under/suit_jacket/charcoal(src)
	new /obj/item/clothing/under/suit_jacket/navy(src)
	new /obj/item/clothing/under/suit_jacket/burgundy(src)
	new /obj/item/clothing/under/suit_jacket/checkered(src)
	new /obj/item/clothing/under/suit_jacket/tan(src)
	new /obj/item/clothing/under/sl_suit(src)
	new /obj/item/clothing/under/suit_jacket(src)
	new /obj/item/clothing/under/suit_jacket/female(src)
	new /obj/item/clothing/under/suit_jacket/really_black(src)
	new /obj/item/clothing/under/suit_jacket/red(src)
	new /obj/item/clothing/under/scratch(src)
	new /obj/item/weapon/storage/backpack/satchel(src)
	new /obj/item/weapon/storage/backpack/satchel(src)
	return

/obj/structure/closet/cabinet/captain
	name = "captaing's wardrobe"

/obj/structure/closet/wardrobe/captain/New()
	..()
	for(var/i in 1 to 2)
		switch(rand(3))
			if(1) new /obj/item/weapon/storage/backpack/captain(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel/cap(src)
			if(3) new /obj/item/weapon/storage/backpack/dufflebag/cap(src)
	new /obj/item/clothing/suit/captunic(src)
	new /obj/item/clothing/suit/captunic/capjacket(src)
	new /obj/item/clothing/under/rank/captain(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/gloves/captain(src)
	new /obj/item/clothing/under/dress/dress_cap(src)
	new /obj/item/clothing/under/captainformal(src)
	new /obj/item/clothing/head/beret/centcom/captain(src)
	new /obj/item/clothing/under/gimmick/rank/captain/suit(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	return

/obj/structure/closet/wardrobe/ems
	name = "EMS wardrobe"
	icon_state = "ems"

/obj/structure/closet/wardrobe/ems/New()
	..()
	new /obj/item/clothing/head/soft/emt(src)
	new /obj/item/clothing/head/soft/emt(src)
	new /obj/item/clothing/head/soft/emt/emerald(src)
	new /obj/item/clothing/head/soft/emt/emerald(src)
	new /obj/item/clothing/under/rank/medical/sleeveless/paramedic(src)
	new /obj/item/clothing/under/rank/medical/sleeveless/paramedic(src)
	new /obj/item/clothing/under/rank/medical/sleeveless/black(src)
	new /obj/item/clothing/under/rank/medical/sleeveless/black(src)
	new /obj/item/clothing/suit/storage/paramedic(src)
	new /obj/item/clothing/suit/storage/paramedic(src)
	new /obj/item/clothing/suit/storage/fr_jacket/emerald(src)
	new /obj/item/clothing/suit/storage/fr_jacket/emerald(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/shoes/jackboots(src)
	return