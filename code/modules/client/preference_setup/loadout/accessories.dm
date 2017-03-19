/datum/gear/accessory
	display_name = "aquila"
	path = /obj/item/clothing/accessory/amulet/aquila
	slot = slot_tie
	sort_category = "Accessories"

/datum/gear/accessory/dogtag
	display_name = "dogtag"
	path = /obj/item/clothing/accessory/amulet/dogtag

/datum/gear/accessory/armband
	display_name = "armband"
	path = /obj/item/clothing/accessory/armband
	options = list(
		"red"         = /obj/item/clothing/accessory/armband,
		"cargo"       = /obj/item/clothing/accessory/armband/cargo,
		"EMT"         = /obj/item/clothing/accessory/armband/medgreen,
		"engineering" = /obj/item/clothing/accessory/armband/engine,
		"hydroponics" = /obj/item/clothing/accessory/armband/hydro,
		"medical"     = /obj/item/clothing/accessory/armband/med,
		"science"     = /obj/item/clothing/accessory/armband/science
	)

/datum/gear/suspenders
	display_name = "suspenders"
	path = /obj/item/clothing/accessory/suspenders
	slot = slot_tie

/datum/gear/accessory/holster
	display_name = "holster, armpit"
	path = /obj/item/clothing/accessory/holster/gun/armpit
	allowed_roles = list("Captain", "Head of Personnel", "Security Officer", "Warden", "Head of Security","Detective","Forensic Technician")

/datum/gear/accessory/holster/hip
	display_name = "holster, hip"
	path = /obj/item/clothing/accessory/holster/gun/hip

/datum/gear/accessory/holster/waist
	display_name = "holster, waist"
	path = /obj/item/clothing/accessory/holster/gun/waist

/datum/gear/accessory/holster/knife
	display_name = "holster (knifeholder)"
	path = /obj/item/clothing/accessory/holster/knife

/datum/gear/accessory/holster/knife/hip
	display_name = "holster (knifeholder), hip"
	path = /obj/item/clothing/accessory/holster/knife/hip

/datum/gear/accessory/tie
	display_name = "tie"
	path = /obj/item/clothing/accessory/blue
	options = list(
		"blue"          = /obj/item/clothing/accessory/blue,
		"blue with clip"= /obj/item/clothing/accessory/blue_clip,
		"blue long"     = /obj/item/clothing/accessory/blue_long,
		"red"           = /obj/item/clothing/accessory/red,
		"red with clip" = /obj/item/clothing/accessory/red_clip,
		"red long"      = /obj/item/clothing/accessory/red_long,
		"yellow"        = /obj/item/clothing/accessory/yellow,
		"navy blue"     = /obj/item/clothing/accessory/navy,
		"socially disgraceful" = /obj/item/clothing/accessory/horrible
	)

/datum/gear/accessory/scarf
	display_name = "tie-scarf"
	path = /obj/item/clothing/accessory/scarf/black
	options = list(
		"black"     = /obj/item/clothing/accessory/scarf/black,
		"red"       = /obj/item/clothing/accessory/scarf/red,
		"green"     = /obj/item/clothing/accessory/scarf/green,
		"darkblue"  = /obj/item/clothing/accessory/scarf/darkblue,
		"purple"    = /obj/item/clothing/accessory/scarf/purple,
		"yellow"    = /obj/item/clothing/accessory/scarf/yellow,
		"orange"    = /obj/item/clothing/accessory/scarf/orange,
		"lightblue" = /obj/item/clothing/accessory/scarf/lightblue,
		"white"     = /obj/item/clothing/accessory/scarf/white,
		"zebra"     = /obj/item/clothing/accessory/scarf/zebra,
		"christmas" = /obj/item/clothing/accessory/scarf/christmas
	)

/datum/gear/accessory/suitjacket
	display_name = "suit jacket, tan"
	path = /obj/item/clothing/accessory/tan_jacket

/datum/gear/accessory/suitjacket/charcoal
	display_name = "suit jacket, charcoal"
	path = /obj/item/clothing/accessory/charcoal_jacket

/datum/gear/accessory/suitjacket/navy
	display_name = "suit jacket, navy blue"
	path = /obj/item/clothing/accessory/navy_jacket

/datum/gear/accessory/suitjacket/burgundy
	display_name = "suit jacket, burgundy"
	path = /obj/item/clothing/accessory/burgundy_jacket

/datum/gear/accessory/suitjacket/checkered
	display_name = "suit jacket, checkered"
	path = /obj/item/clothing/accessory/checkered_jacket

/datum/gear/accessory/vest
	display_name = "webbing, engineering"
	path = /obj/item/clothing/accessory/storage/brown_vest
	allowed_roles = list(
		"Chief Engineer","Station Engineer","Atmospheric Technician",
		"Head of Security","Warden","Security Officer","Detective","Forensic Technician",
		"Chief Medical Officer","Paramedic","Medical Doctor","Chemist"
	)

/datum/gear/accessory/vest/black
	display_name = "webbing, security"
	path = /obj/item/clothing/accessory/storage/black_vest

/datum/gear/accessory/vest/white
	display_name = "webbing, medical"
	path = /obj/item/clothing/accessory/storage/white_vest

/datum/gear/accessory/vest/drop_pouches
	display_name = "drop pouches"
	path = /obj/item/clothing/accessory/storage/drop_pouches
	options = list(
		"security"    = /obj/item/clothing/accessory/storage/drop_pouches,
		"engineering" = /obj/item/clothing/accessory/storage/drop_pouches/brown,
		"medical"     = /obj/item/clothing/accessory/storage/drop_pouches/white
	)

/datum/gear/accessory/webbing
	display_name = "webbing, simple"
	path = /obj/item/clothing/accessory/storage/webbing
	cost = 2

