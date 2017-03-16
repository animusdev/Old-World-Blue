// Suit slot
/datum/gear/suit
	display_name = "apron, blue"
	path = /obj/item/clothing/suit/apron
	slot = slot_wear_suit
	sort_category = "Suits and Overwear"
	cost = 2

/datum/gear/suit/leather_coat
	display_name = "leather coat"
	path = /obj/item/clothing/suit/storage/leathercoat

/datum/gear/suit/bomber
	display_name = "bomber jacket"
	path = /obj/item/clothing/suit/storage/toggle/bomber

/datum/gear/suit/leather_jacket
	display_name = "leather jacket"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket
	options = list(
		"black"  = /obj/item/clothing/suit/storage/toggle/leather_jacket,
		"boar"   = /obj/item/clothing/suit/storage/toggle/leather_jacket/boar,
		"cerber" = /obj/item/clothing/suit/storage/toggle/leather_jacket/cerberus,
		"fox"    = /obj/item/clothing/suit/storage/toggle/leather_jacket/fox,
		"rat"    = /obj/item/clothing/suit/storage/toggle/leather_jacket/mouse,
		"skull"  = /obj/item/clothing/suit/storage/toggle/leather_jacket/skull,
		"snake"  = /obj/item/clothing/suit/storage/toggle/leather_jacket/snake,
		"wolf"   = /obj/item/clothing/suit/storage/toggle/leather_jacket/wolf,
		"NanoTrasen" = /obj/item/clothing/suit/storage/toggle/leather_jacket/nanotrasen
	)

/datum/gear/suit/brown_jacket
	display_name = "leather jacket"
	path = /obj/item/clothing/suit/storage/toggle/brown_jacket
	options = list(
		"default" = /obj/item/clothing/suit/storage/toggle/brown_jacket,
		"NanoTrasen" = /obj/item/clothing/suit/storage/toggle/brown_jacket/nanotrasen
	)

/datum/gear/suit/militaryjacket
	display_name = "military jacket"
	path = /obj/item/clothing/suit/storage/militaryjacket

/datum/gear/suit/leathercoatsec
	display_name = "leather coat, (Security)"
	path = /obj/item/clothing/suit/storage/leathercoatsec
	allowed_roles = list("Security Officer","Head of Security","Warden")

/datum/gear/suit/hazard_vest
	display_name = "hazard vest"
	path = /obj/item/clothing/suit/storage/hazardvest

/datum/gear/suit/hoodie
	display_name = "hoodie, grey"
	path = /obj/item/clothing/suit/storage/toggle/hoodie

/datum/gear/suit/hoodie/black
	display_name = "hoodie, black"
	path = /obj/item/clothing/suit/storage/toggle/hoodie/black

/datum/gear/suit/unathi_mantle
	display_name = "hide mantle (Unathi)"
	path = /obj/item/clothing/suit/unathi/mantle
	whitelisted = "Unathi"

/datum/gear/suit/labcoat
	display_name = "labcoat"
	path = /obj/item/clothing/suit/storage/toggle/labcoat
	options = list(
		"default" = /obj/item/clothing/suit/storage/toggle/labcoat,
		"blue"    = /obj/item/clothing/suit/storage/toggle/labcoat/blue,
		"green"   = /obj/item/clothing/suit/storage/toggle/labcoat/green,
		"orange"  = /obj/item/clothing/suit/storage/toggle/labcoat/orange,
		"purple"  = /obj/item/clothing/suit/storage/toggle/labcoat/purple,
		"red"     = /obj/item/clothing/suit/storage/toggle/labcoat/red
	)

/datum/gear/suit/overalls
	display_name = "overalls"
	path = /obj/item/clothing/suit/apron/overalls
	cost = 1

/datum/gear/suit/poncho
	display_name = "poncho"
	path = /obj/item/clothing/suit/poncho/blue
	options = list(
		"blue"   = /obj/item/clothing/suit/poncho/blue,
		"green"  = /obj/item/clothing/suit/poncho/green,
		"purple" = /obj/item/clothing/suit/poncho/purple,
		"red"    = /obj/item/clothing/suit/poncho/red,
		"tan"    = /obj/item/clothing/suit/poncho
	)

/datum/gear/suit/unathi_robe
	display_name = "roughspun robe"
	path = /obj/item/clothing/suit/unathi/robe
	cost = 1

/datum/gear/suit/blue_lawyer_jacket
	display_name = "suit jacket, blue"
	path = /obj/item/clothing/suit/storage/toggle/lawyer/bluejacket

/datum/gear/suit/purple_lawyer_jacket
	display_name = "suit jacket, purple"
	path = /obj/item/clothing/suit/storage/lawyer/purpjacket

/datum/gear/suit/wcoat
	display_name = "waistcoat"
	path = /obj/item/clothing/suit/wcoat

/datum/gear/suit/varsityred
	display_name = "Varsity jacket"
	path = /obj/item/clothing/suit/storage/toggle/varsity
	options = list(
		"red"   = /obj/item/clothing/suit/storage/toggle/varsity,
		"blue"  = /obj/item/clothing/suit/storage/toggle/varsity/blue,
		"black" = /obj/item/clothing/suit/storage/toggle/varsity/black,
		"brown" = /obj/item/clothing/suit/storage/toggle/varsity/brown
	)

/datum/gear/suit/flannel
	display_name = "flannel"
	path = /obj/item/clothing/suit/storage/flannel
	options = list(
		"grey" = /obj/item/clothing/suit/storage/flannel,
		"red"  = /obj/item/clothing/suit/storage/flannel/red,
		"aqua" = /obj/item/clothing/suit/storage/flannel/aqua
	)

/datum/gear/suit/zhan_furs
	display_name = "Zhan-Khazan furs (Tajaran)"
	path = /obj/item/clothing/suit/tajaran/furs
	whitelisted = "Tajara" // You do have a monopoly on a fur suit tho

/datum/gear/suit/native
	display_name = "traditional clothing (Tajaran)"
	path = /obj/item/clothing/suit/storage/native
	cost = 3
	whitelisted = "Tajara"

/datum/gear/suit/fluffy_priest
	display_name = "priest robe (Tajaran)"
	path = /obj/item/clothing/suit/fluffy_priest
	cost = 3
	whitelisted = "Tajara"

/datum/gear/suit/ianshirt
	display_name = "Worn shirt"
	path = /obj/item/clothing/suit/ianshirt
	cost = 4