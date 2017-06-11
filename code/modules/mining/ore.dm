/obj/item/weapon/ore
	name = "rock"
	icon = 'icons/obj/mining.dmi'
	icon_state = "ore2"
	randpixel = 8
	w_class = ITEM_SIZE_SMALL
	var/datum/geosample/geologic_data
	var/material

/obj/item/weapon/ore/uranium
	name = "pitchblende"
	icon_state = "ore_uranium"
	origin_tech = list(TECH_MATERIAL = 5)
	material = MATERIAL_URANIUM

/obj/item/weapon/ore/iron
	name = "hematite"
	icon_state = "ore_iron"
	origin_tech = list(TECH_MATERIAL = 1)
	material = "hematite"

/obj/item/weapon/ore/coal
	name = "raw carbon"
	icon_state = "ore_coal"
	origin_tech = list(TECH_MATERIAL = 1)
	material = "carbon"

/obj/item/weapon/ore/glass
	name = "impure silicates"
	icon_state = "ore_glass"
	origin_tech = list(TECH_MATERIAL = 1)
	material = "sand"
	slot_flags = SLOT_HOLSTER

/obj/item/weapon/ore/phoron
	name = "phoron crystals"
	icon_state = "ore_phoron"
	origin_tech = list(TECH_MATERIAL = 2)
	material = MATERIAL_PHORON

/obj/item/weapon/ore/silver
	name = "native silver ore"
	icon_state = "ore_silver"
	origin_tech = list(TECH_MATERIAL = 3)
	material = MATERIAL_SILVER

/obj/item/weapon/ore/gold
	name = "native gold ore"
	icon_state = "ore_gold"
	origin_tech = list(TECH_MATERIAL = 4)
	material = MATERIAL_GOLD

/obj/item/weapon/ore/diamond
	name = "diamonds"
	icon_state = "ore_diamond"
	origin_tech = list(TECH_MATERIAL = 6)
	material = MATERIAL_DIAMOND

/obj/item/weapon/ore/osmium
	name = "raw platinum"
	icon_state = "ore_platinum"
	material = "platinum"

/obj/item/weapon/ore/hydrogen
	name = "raw hydrogen"
	icon_state = "ore_hydrogen"
	material = MATERIAL_MYTHRIL

/obj/item/weapon/ore/slag
	name = "Slag"
	desc = "Someone screwed up..."
	icon_state = "slag"
	material = null

/obj/item/weapon/ore/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W,/obj/item/device/core_sampler))
		var/obj/item/device/core_sampler/C = W
		C.sample_item(src, user)
	else
		return ..()