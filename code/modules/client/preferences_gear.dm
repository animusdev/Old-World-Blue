var/global/list/gear_datums = list()

/hook/startup/proc/populate_gear_list()
	var/list/sort_categories = list(
		"[slot_head]"		= list(),
		"ears"				= list(),
		"[slot_glasses]" 	= list(),
		"[slot_wear_mask]"	= list(),
		"[slot_w_uniform]"	= list(),
		"[slot_tie]"		= list(),
		"[slot_wear_suit]"	= list(),
		"[slot_gloves]"		= list(),
		"[slot_shoes]"		= list(),
		"utility"			= list(),
		"misc"				= list(),
		"unknown"			= list(),
	)

	//create a list of gear datums to sort
	for(var/type in typesof(/datum/gear)-/datum/gear)
		var/datum/gear/G = new type()

		if(G.display_name == "basic")
			del(G)
			continue

		var/category = (G.sort_category in sort_categories)? G.sort_category : "unknown"
		sort_categories[category][G.display_name] = G

	for (var/category in sort_categories)
		gear_datums.Add(sortAssoc(sort_categories[category]))

	return 1

/datum/gear
	var/display_name       //Name/index. Must be unique.
	var/path               //Path to item.
	var/cost = 1            //Number of points used. Items in general cost 1 point, storage/armor/gloves/special use costs 2 points.
	var/slot               //Slot to equip to.
	var/list/allowed_roles //Roles that can spawn with this item.
	var/whitelisted        //Term to check the whitelist for..
	var/sort_category

/datum/gear/New()
	..()
	if (!sort_category)
		sort_category = "[slot]"

// This is sorted both by slot and alphabetically! Don't fuck it up!
// Headslot items

/datum/gear/gbandana
	display_name = "bandana, green"
	path = /obj/item/clothing/head/greenbandana
	slot = slot_head

/datum/gear/obandana
	display_name = "bandana, orange"
	path = /obj/item/clothing/head/orangebandana
	slot = slot_head

/datum/gear/bandana
	display_name = "bandana, pirate-red"
	path = /obj/item/clothing/head/bandana
	slot = slot_head

/datum/gear/bsec_beret
	display_name = "beret, blue (security)"
	path = /obj/item/clothing/head/beret/sec/alt
	slot = slot_head
	allowed_roles = list("Security Officer","Head of Security","Warden","Detective")

/datum/gear/eng_beret
	display_name = "beret, engie-orange"
	path = /obj/item/clothing/head/beret/eng
	slot = slot_head
//	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer")

/datum/gear/purp_beret
	display_name = "beret, purple"
	path = /obj/item/clothing/head/beret/jan
	slot = slot_head

/datum/gear/red_beret
	display_name = "beret, red"
	path = /obj/item/clothing/head/beret
	slot = slot_head

/datum/gear/beret/black
	display_name = "beret, black"
	path = /obj/item/clothing/head/beret/black
	slot = slot_head

/datum/gear/sec_beret
	display_name = "beret, red (security)"
	path = /obj/item/clothing/head/beret/sec
	slot = slot_head
	allowed_roles = list("Security Officer","Head of Security","Warden","Detective")

/datum/gear/sec_beret/corp
	display_name = "beret, black (security)"
	path = /obj/item/clothing/head/beret/sec/alt/corp
	slot = slot_head
	allowed_roles = list("Security Officer","Head of Security","Warden","Detective")

/datum/gear/sec_beret/hos
	display_name = "beret, black (HoS)"
	path = /obj/item/clothing/head/beret/sec/hos/corp
	slot = slot_head
	allowed_roles = list("Head of Security")

/datum/gear/sec_beret/war
	display_name = "beret, black (Warden)"
	path = /obj/item/clothing/head/beret/sec/warden/corp
	slot = slot_head
	allowed_roles = list("Warden")

/datum/gear/bcap
	display_name = "cap, blue"
	path = /obj/item/clothing/head/soft/blue
	slot = slot_head

/datum/gear/mailman
	display_name = "cap, blue station"
	path = /obj/item/clothing/head/mailman
	slot = slot_head

/datum/gear/flatcap
	display_name = "cap, brown-flat"
	path = /obj/item/clothing/head/flatcap
	slot = slot_head

/datum/gear/corpcap
	display_name = "cap, corporate (Security)"
	path = /obj/item/clothing/head/soft/sec/corp
	slot = slot_head
	allowed_roles = list("Security Officer","Head of Security","Warden")

/datum/gear/gcap
	display_name = "cap, green"
	path = /obj/item/clothing/head/soft/green
	slot = slot_head

 /datum/gear/grcap
	display_name = "cap, grey"
	path = /obj/item/clothing/head/soft/grey
	slot = slot_head

 /datum/gear/ocap
	display_name = "cap, orange"
	path = /obj/item/clothing/head/soft/orange
	slot = slot_head

/datum/gear/purcap
	display_name = "cap, purple"
	path = /obj/item/clothing/head/soft/purple
	slot = slot_head

/datum/gear/raincap
	display_name = "cap, rainbow"
	path = /obj/item/clothing/head/soft/rainbow
	slot = slot_head

/datum/gear/rcap
	display_name = "cap, red"
	path = /obj/item/clothing/head/soft/red
	slot = slot_head

/datum/gear/ycap
	display_name = "cap, yellow"
	path = /obj/item/clothing/head/soft/yellow
	slot = slot_head

/datum/gear/wcap
	display_name = "cap, white"
	path = /obj/item/clothing/head/soft/mime
	slot = slot_head

/datum/gear/hairflower
	display_name = "hair flower pin"
	path = /obj/item/clothing/head/hairflower
	slot = slot_head

/datum/gear/dbhardhat
	display_name = "hardhat, blue"
	path = /obj/item/clothing/head/hardhat/dblue
	cost = 2
	slot = slot_head

/datum/gear/ohardhat
	display_name = "hardhat, orange"
	path = /obj/item/clothing/head/hardhat/orange
	cost = 2
	slot = slot_head

/datum/gear/rhardhat
	display_name = "hardhat, red"
	path = /obj/item/clothing/head/hardhat/red
	cost = 2
	slot = slot_head

/datum/gear/yhardhat
	display_name = "hardhat, yellow"
	path = /obj/item/clothing/head/hardhat
	cost = 2
	slot = slot_head

/datum/gear/welding/flame
	display_name = "welding helmet, flame"
	path = /obj/item/clothing/head/welding/flame
	cost = 2
	slot = slot_head

/datum/gear/welding/white
	display_name = "welding helmet, white"
	path = /obj/item/clothing/head/welding/white
	cost = 2
	slot = slot_head

/datum/gear/welding/blue
	display_name = "welding helmet, blue"
	path = /obj/item/clothing/head/welding/blue
	cost = 2
	slot = slot_head

/datum/gear/boater
	display_name = "hat, boatsman"
	path = /obj/item/clothing/head/boaterhat
	slot = slot_head

 /datum/gear/bowler
	display_name = "hat, bowler"
	path = /obj/item/clothing/head/bowler
	slot = slot_head

/datum/gear/fez
	display_name = "hat, fez"
	path = /obj/item/clothing/head/fez
	slot = slot_head

/datum/gear/tophat
	display_name = "hat, tophat"
	path = /obj/item/clothing/head/that
	slot = slot_head

// Wig by Earthcrusher, blame him.
/datum/gear/philosopher_wig
	display_name = "natural philosopher's wig"
	path = /obj/item/clothing/head/philosopher_wig
	slot = slot_head

/datum/gear/ushanka
	display_name = "ushanka"
	path = /obj/item/clothing/head/ushanka
	slot = slot_head

/datum/gear/sombrero
	display_name = "sombrero"
	path = /obj/item/clothing/head/sombrero
	slot = slot_head

// This was sprited and coded specifically for Zhan-Khazan characters. Before you
// decide that it's 'not even Taj themed' maybe you should read the wiki, gamer. ~ Z
/datum/gear/zhan_scarf
	display_name = "Zhan headscarf"
	path = /obj/item/clothing/head/tajaran/scarf
	slot = slot_head
	whitelisted = "Tajara"

// Eyes

/datum/gear/eyepatch
	display_name = "eyepatch"
	path = /obj/item/clothing/glasses/eyepatch
	slot = slot_glasses

/datum/gear/green_glasses
	display_name = "Glasses, green"
	path = /obj/item/clothing/glasses/gglasses
	slot = slot_glasses

/datum/gear/prescriptionhipster
	display_name = "Glasses, hipster"
	path = /obj/item/clothing/glasses/regular/hipster
	slot = slot_glasses

/datum/gear/prescription
	display_name = "Glasses, prescription"
	path = /obj/item/clothing/glasses/regular
	slot = slot_glasses

/datum/gear/orange
	path = /obj/item/clothing/glasses/orange
	display_name = "Glasses, orange"
	slot = slot_glasses

/datum/gear/red
	path = /obj/item/clothing/glasses/red
	display_name = "Glasses, red"
	slot = slot_glasses

/datum/gear/monocle
	display_name = "Monocle"
	path = /obj/item/clothing/glasses/monocle
	slot = slot_glasses

/datum/gear/scanning_goggles
	display_name = "scanning goggles"
	path = /obj/item/clothing/glasses/regular/scanners
	slot = slot_glasses

/datum/gear/sciencegoggles
	display_name = "Science Goggles"
	path = /obj/item/clothing/glasses/science
	slot = slot_glasses

/datum/gear/security
	display_name = "Security HUD"
	path = /obj/item/clothing/glasses/hud/security
	cost = 2
	slot = slot_glasses
	allowed_roles = list("Security Officer","Head of Security","Warden","Detective","Internal Affairs Agent")

/datum/gear/medical_hud
	display_name = "Medical HUD (prescription)"
	path = /obj/item/clothing/glasses/hud/health/prescription
	slot = slot_glasses
	allowed_roles = list("Chief Medical Officer","Medical Doctor","Paramedic")

/datum/gear/crimson
	display_name = "sunglasses, crimson"
	path = /obj/item/clothing/glasses/sunglasses/red
	cost = 2
	slot = slot_glasses

/datum/gear/thugshades
	display_name = "Sunglasses, Fat"
	path = /obj/item/clothing/glasses/sunglasses/big
	slot = slot_glasses

/datum/gear/prescriptionsun
	display_name = "sunglasses, presciption"
	path = /obj/item/clothing/glasses/sunglasses/prescription
	cost = 2
	slot = slot_glasses

// Mask

/datum/gear/sterilemask
	display_name = "sterile mask"
	path = /obj/item/clothing/mask/surgical
	slot = slot_wear_mask
	cost = 2

/datum/gear/redscarf
	display_name = "facescarf, red"
	path = /obj/item/clothing/mask/redscarf
	slot = slot_wear_mask
	cost = 2

/datum/gear/greenscarf
	display_name = "facescarf, green"
	path = /obj/item/clothing/mask/greenscarf
	slot = slot_wear_mask
	cost = 2

/datum/gear/bluescarf
	display_name = "facescarf, blue"
	path = /obj/item/clothing/mask/bluescarf
	slot = slot_wear_mask
	cost = 2

/datum/gear/arafatka
	display_name = "facescarf, shemagh"
	path = /obj/item/clothing/mask/arafatka
	slot = slot_wear_mask
	cost = 2

// Uniform slot

/datum/gear/blazer_blue
	display_name = "blazer, blue"
	path = /obj/item/clothing/under/blazer
	slot = slot_w_uniform

/datum/gear/cheongsam
	display_name = "cheongsam, white"
	path = /obj/item/clothing/under/cheongsam
	slot = slot_w_uniform

/datum/gear/kilt
	display_name = "kilt"
	path = /obj/item/clothing/under/kilt
	slot = slot_w_uniform

/datum/gear/blackjumpskirt
	display_name = "jumpskirt, black"
	path = /obj/item/clothing/under/blackjumpskirt
	slot = slot_w_uniform

/datum/gear/blackfjumpsuit
	display_name = "jumpsuit, female-black"
	path = /obj/item/clothing/under/color/blackf
	slot = slot_w_uniform

/datum/gear/rainbow
	display_name = "jumpsuit, rainbow"
	path = /obj/item/clothing/under/rainbow
	slot = slot_w_uniform

/datum/gear/SID
	display_name = "jumpsuit, SID"
	path = /obj/item/clothing/under/SID
	slot = slot_w_uniform

/datum/gear/skirt_blue
	display_name = "plaid skirt, blue"
	path = /obj/item/clothing/under/dress/plaid_blue
	slot = slot_w_uniform

/datum/gear/skirt_purple
	display_name = "plaid skirt, purple"
	path = /obj/item/clothing/under/dress/plaid_purple
	slot = slot_w_uniform

/datum/gear/skirt_red
	display_name = "plaid skirt, red"
	path = /obj/item/clothing/under/dress/plaid_red
	slot = slot_w_uniform

/datum/gear/skirt_black_plaid
	display_name = "plaid skirt, black"
	path = /obj/item/clothing/under/dress/plaid_black
	slot = slot_w_uniform

/datum/gear/skirt_black
	display_name = "skirt, black"
	path = /obj/item/clothing/under/blackskirt
	slot = slot_w_uniform

/datum/gear/amishsuit
	display_name = "suit, amish"
	path = /obj/item/clothing/under/sl_suit
	slot = slot_w_uniform

/datum/gear/blacksuit
	display_name = "suit, black"
	path = /obj/item/clothing/under/suit_jacket
	slot = slot_w_uniform

/datum/gear/shinyblacksuit
	display_name = "suit, shiny-black"
	path = /obj/item/clothing/under/lawyer/black
	slot = slot_w_uniform

/datum/gear/bluesuit
	display_name = "suit, blue"
	path = /obj/item/clothing/under/lawyer/blue
	slot = slot_w_uniform

/datum/gear/burgundysuit
	display_name = "suit, burgundy"
	path = /obj/item/clothing/under/suit_jacket/burgundy
	slot = slot_w_uniform

/datum/gear/checkeredsuit
	display_name = "suit, checkered"
	path = /obj/item/clothing/under/suit_jacket/checkered
	slot = slot_w_uniform

/datum/gear/charcoalsuit
	display_name = "suit, charcoal"
	path = /obj/item/clothing/under/suit_jacket/charcoal
	slot = slot_w_uniform

/datum/gear/execsuit
	display_name = "suit, executive"
	path = /obj/item/clothing/under/suit_jacket/really_black
	slot = slot_w_uniform

/datum/gear/femaleexecsuit
	display_name = "suit, female-executive"
	path = /obj/item/clothing/under/suit_jacket/female
	slot = slot_w_uniform

/datum/gear/gentlesuit
	display_name = "suit, gentlemen"
	path = /obj/item/clothing/under/gentlesuit
	slot = slot_w_uniform

/datum/gear/navysuit
	display_name = "suit, navy"
	path = /obj/item/clothing/under/suit_jacket/navy
	slot = slot_w_uniform

/datum/gear/redsuit
	display_name = "suit, red"
	path = /obj/item/clothing/under/suit_jacket/red
	slot = slot_w_uniform

/datum/gear/redlawyer
	display_name = "suit, lawyer-red"
	path = /obj/item/clothing/under/lawyer/red
	slot = slot_w_uniform

/datum/gear/oldmansuit
	display_name = "suit, old-man"
	path = /obj/item/clothing/under/lawyer/oldman
	slot = slot_w_uniform

/datum/gear/purplesuit
	display_name = "suit, purple"
	path = /obj/item/clothing/under/lawyer/purpsuit
	slot = slot_w_uniform

/datum/gear/tansuit
	display_name = "suit, tan"
	path = /obj/item/clothing/under/suit_jacket/tan
	slot = slot_w_uniform

/datum/gear/whitesuit
	display_name = "suit, white"
	path = /obj/item/clothing/under/scratch
	slot = slot_w_uniform

/datum/gear/whitebluesuit
	display_name = "suit, white-blue"
	path = /obj/item/clothing/under/lawyer/bluesuit
	slot = slot_w_uniform

/datum/gear/sundress
	display_name = "sundress"
	path = /obj/item/clothing/under/sundress
	slot = slot_w_uniform

/datum/gear/sundress_white
	display_name = "sundress, white"
	path = /obj/item/clothing/under/sundress_white
	slot = slot_w_uniform

/datum/gear/uniform_captain
	display_name = "uniform, captain's dress"
	path = /obj/item/clothing/under/dress/dress_cap
	slot = slot_w_uniform
	allowed_roles = list("Captain")

/datum/gear/corpsecsuit
	display_name = "uniform, corporate (Security)"
	path = /obj/item/clothing/under/rank/security/corp
	slot = slot_w_uniform
	allowed_roles = list("Security Officer","Head of Security","Warden")

/datum/gear/uniform_hop
	display_name = "uniform, HoP's dress"
	path = /obj/item/clothing/under/dress/dress_hop
	slot = slot_w_uniform
	allowed_roles = list("Head of Personnel")

/datum/gear/uniform_hr
	display_name = "uniform, HR director (HoP)"
	path = /obj/item/clothing/under/dress/dress_hr
	slot = slot_w_uniform
	allowed_roles = list("Head of Personnel")

/datum/gear/navysecsuit
	display_name = "uniform, navyblue (Security Officer)"
	path = /obj/item/clothing/under/rank/security/navyblue
	slot = slot_w_uniform
	allowed_roles = list("Security Officer")

/datum/gear/navywarsuit
	display_name = "uniform, navyblue (Warden)"
	path = /obj/item/clothing/under/rank/warden/navyblue
	slot = slot_w_uniform
	allowed_roles = list("Warden")

/datum/gear/navyhossuit
	display_name = "uniform, navyblue (Head of Security)"
	path = /obj/item/clothing/under/rank/head_of_security/navyblue
	slot = slot_w_uniform
	allowed_roles = list("Head of Security")

/datum/gear/dnavysecsuit
	display_name = "uniform, deep navy (Security Officer)"
	path = /obj/item/clothing/under/rank/security/dnavy
	slot = slot_w_uniform
	allowed_roles = list("Security Officer")

/datum/gear/dnavywarsuit
	display_name = "uniform, deep navy (Warden)"
	path = /obj/item/clothing/under/rank/warden/dnavy
	slot = slot_w_uniform
	allowed_roles = list("Warden")

/datum/gear/dnavyhossuit
	display_name = "uniform, deep navy (Head of Security)"
	path = /obj/item/clothing/under/rank/head_of_security/dnavy
	slot = slot_w_uniform
	allowed_roles = list("Head of Security")

/datum/gear/squatter_outfit
	display_name = "slav squatter tracksuit"
	path = /obj/item/clothing/under/squatter_outfit
	slot = slot_w_uniform


// Attachments

/datum/gear/amulete
	display_name = "basic"
	slot = slot_tie

/datum/gear/amulete/khorne
	display_name = "amulete, khorne"
	path = /obj/item/clothing/accessory/amulet/khorne

/datum/gear/amulete/nurgle
	display_name = "amulete, nurgle"
	path = /obj/item/clothing/accessory/amulet/nurgle

/datum/gear/amulete/slaanesh
	display_name = "amulete, slaanesh"
	path = /obj/item/clothing/accessory/amulet/slaanesh

/datum/gear/amulete/tzeench
	display_name = "amulete, tzeench"
	path = /obj/item/clothing/accessory/amulet/tzeench

/datum/gear/amulete/chaos
	display_name = "amulete, chaos"
	path = /obj/item/clothing/accessory/amulet/chaos

/datum/gear/amulete/aquila
	display_name = "aquila"
	path = /obj/item/clothing/accessory/amulet/aquila

/datum/gear/armband_cargo
	display_name = "armband, cargo"
	path = /obj/item/clothing/accessory/armband/cargo
	slot = slot_tie

/datum/gear/armband_emt
	display_name = "armband, EMT"
	path = /obj/item/clothing/accessory/armband/medgreen
	slot = slot_tie

/datum/gear/armband_engineering
	display_name = "armband, engineering"
	path = /obj/item/clothing/accessory/armband/engine
	slot = slot_tie

/datum/gear/armband_hydroponics
	display_name = "armband, hydroponics"
	path = /obj/item/clothing/accessory/armband/hydro
	slot = slot_tie

/datum/gear/armband_medical
	display_name = "armband, medical"
	path = /obj/item/clothing/accessory/armband/med
	slot = slot_tie

/datum/gear/armband
	display_name = "armband, red"
	path = /obj/item/clothing/accessory/armband
	slot = slot_tie

/datum/gear/armband_science
	display_name = "armband, science"
	path = /obj/item/clothing/accessory/armband/science
	slot = slot_tie

/datum/gear/armpit
	display_name = "holster, armpit"
	path = /obj/item/clothing/accessory/holster/armpit
	slot = slot_tie
	allowed_roles = list("Captain", "Head of Personnel", "Security Officer", "Warden", "Head of Security","Detective")

/datum/gear/hip
	display_name = "holster, hip"
	path = /obj/item/clothing/accessory/holster/hip
	slot = slot_tie
	allowed_roles = list("Captain", "Head of Personnel", "Security Officer", "Warden", "Head of Security", "Detective")

/datum/gear/waist
	display_name = "holster, waist"
	path = /obj/item/clothing/accessory/holster/waist
	slot = slot_tie
	allowed_roles = list("Captain", "Head of Personnel", "Security Officer", "Warden", "Head of Security", "Detective")

/datum/gear/suspenders
	display_name = "suspenders"
	path = /obj/item/clothing/accessory/suspenders
	slot = slot_tie

/datum/gear/tie_blue
	display_name = "tie, blue"
	path = /obj/item/clothing/accessory/blue
	slot = slot_tie

/datum/gear/tie_red
	display_name = "tie, red"
	path = /obj/item/clothing/accessory/red
	slot = slot_tie

/datum/gear/tie_horrible
	display_name = "tie, socially disgraceful"
	path = /obj/item/clothing/accessory/horrible
	slot = slot_tie

/datum/gear/scarf/black
	display_name = "scarf, black"
	path = /obj/item/clothing/accessory/scarf/black
	slot = slot_tie

/datum/gear/scarf/red
	display_name = "scarf, red"
	path = /obj/item/clothing/accessory/scarf/red
	slot = slot_tie

/datum/gear/scarf/white
	display_name = "scarf, white"
	path = /obj/item/clothing/accessory/scarf/white
	slot = slot_tie

/datum/gear/scarf/green
	display_name = "scarf, green"
	path = /obj/item/clothing/accessory/scarf/green
	slot = slot_tie

/datum/gear/scarf/darkblue
	display_name = "scarf, darkblue"
	path = /obj/item/clothing/accessory/scarf/darkblue
	slot = slot_tie

/datum/gear/scarf/purple
	display_name = "scarf, purple"
	path = /obj/item/clothing/accessory/scarf/purple
	slot = slot_tie

/datum/gear/scarf/yellow
	display_name = "scarf, yellow"
	path = /obj/item/clothing/accessory/scarf/yellow
	slot = slot_tie

/datum/gear/scarf/orange
	display_name = "scarf, orange"
	path = /obj/item/clothing/accessory/scarf/orange
	slot = slot_tie

/datum/gear/scarf/lightblue
	display_name = "scarf, lightblue"
	path = /obj/item/clothing/accessory/scarf/lightblue
	slot = slot_tie

/datum/gear/scarf/stripedredscarf
	display_name = "scarf, striped red"
	path = /obj/item/clothing/accessory/stripedredscarf
	slot = slot_tie

/datum/gear/scarf/stripedgreenscarf
	display_name = "scarf, striped green"
	path = /obj/item/clothing/accessory/stripedgreenscarf
	slot = slot_tie

/datum/gear/scarf/stripedbluescarf
	display_name = "scarf, striped blue"
	path = /obj/item/clothing/accessory/stripedbluescarf
	slot = slot_tie

/datum/gear/brown_vest
	display_name = "webbing, engineering"
	path = /obj/item/clothing/accessory/storage/brown_vest
	slot = slot_tie
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer")

/datum/gear/black_vest
	display_name = "webbing, security"
	path = /obj/item/clothing/accessory/storage/black_vest
	slot = slot_tie
	allowed_roles = list("Security Officer","Head of Security","Warden")

/datum/gear/webbing
	display_name = "webbing, simple"
	path = /obj/item/clothing/accessory/storage/webbing
	slot = slot_tie
	cost = 2

// Suit slot

/datum/gear/apron
	display_name = "apron, blue"
	path = /obj/item/clothing/suit/apron
	slot = slot_wear_suit

/datum/gear/bomber
	display_name = "bomber jacket"
	path = /obj/item/clothing/suit/storage/toggle/bomber
	cost = 2
	slot = slot_wear_suit

/datum/gear/brown_jacket/nt
	display_name = "brown jacket, NanoTrasen"
	path = /obj/item/clothing/suit/storage/toggle/brown_jacket/nanotrasen

/datum/gear/leather_jacket
	display_name = "leather jacket, black"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket
	cost = 2
	slot = slot_wear_suit

/datum/gear/brown_jacket
	display_name = "leather jacket, brown"
	path = /obj/item/clothing/suit/storage/toggle/brown_jacket
	cost = 2
	slot = slot_wear_suit

/datum/gear/leather_jacket/boar
	display_name = "leather jacket, boar"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket/boar

/datum/gear/leather_jacket/cerber
	display_name = "leather jacket, cerber"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket/cerberus

/datum/gear/leather_jacket/fox
	display_name = "leather jacket, fox"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket/fox

/datum/gear/leather_jacket/mouse
	display_name = "leather jacket, rat"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket/mouse

/datum/gear/leather_jacket/nt
	display_name = "leather jacket, NanoTrasen"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket/nanotrasen

/datum/gear/leather_jacket/skull
	display_name = "leather jacket, skull"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket/skull

/datum/gear/leather_jacket/snake
	display_name = "leather jacket, snake"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket/snake

/datum/gear/leather_jacket/wolf
	display_name = "leather jacket, wolf"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket/wolf

/datum/gear/militaryjacket
	display_name = "military jacket"
	path = /obj/item/clothing/suit/storage/militaryjacket
	cost = 2
	slot = slot_wear_suit

/datum/gear/leathercoat
	display_name = "leather coat"
	path = /obj/item/clothing/suit/storage/leathercoat
	cost = 2
	slot = slot_wear_suit

/datum/gear/leathercoatsec
	display_name = "leather coat, (Security)"
	path = /obj/item/clothing/suit/storage/leathercoatsec
	cost = 2
	slot = slot_wear_suit
	allowed_roles = list("Security Officer","Head of Security","Warden")


/datum/gear/hazard_vest
	display_name = "hazard vest"
	path = /obj/item/clothing/suit/storage/hazardvest
	cost = 2
	slot = slot_wear_suit

/datum/gear/hoodie
	display_name = "hoodie, grey"
	path = /obj/item/clothing/suit/storage/toggle/hoodie
	cost = 2
	slot = slot_wear_suit

/datum/gear/hoodie/black
	display_name = "hoodie, black"
	path = /obj/item/clothing/suit/storage/toggle/hoodie/black
	cost = 2

/datum/gear/unathi_mantle
	display_name = "hide mantle (Unathi)"
	path = /obj/item/clothing/suit/unathi/mantle
	slot = slot_wear_suit
	whitelisted = "Unathi"

/datum/gear/labcoat
	display_name = "labcoat"
	path = /obj/item/clothing/suit/storage/toggle/labcoat
	cost = 2
	slot = slot_wear_suit

/datum/gear/bluelabcoat
	display_name = "labcoat, blue"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/blue
	cost = 2
	slot = slot_wear_suit

/datum/gear/greenlabcoat
	display_name = "labcoat, green"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/green
	cost = 2
	slot = slot_wear_suit

/datum/gear/orangelabcoat
	display_name = "labcoat, orange"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/orange
	cost = 2
	slot = slot_wear_suit

/datum/gear/purplelabcoat
	display_name = "labcoat, purple"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/purple
	cost = 2
	slot = slot_wear_suit

/datum/gear/redlabcoat
	display_name = "labcoat, red"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/red
	cost = 2
	slot = slot_wear_suit

/datum/gear/overalls
	display_name = "overalls"
	path = /obj/item/clothing/suit/apron/overalls
	slot = slot_wear_suit

/datum/gear/bponcho
	display_name = "poncho, blue"
	path = /obj/item/clothing/suit/poncho/blue
	slot = slot_wear_suit

/datum/gear/gponcho
	display_name = "poncho, green"
	path = /obj/item/clothing/suit/poncho/green
	slot = slot_wear_suit

/datum/gear/pponcho
	display_name = "poncho, purple"
	path = /obj/item/clothing/suit/poncho/purple
	slot = slot_wear_suit

/datum/gear/rponcho
	display_name = "poncho, red"
	path = /obj/item/clothing/suit/poncho/red
	slot = slot_wear_suit

/datum/gear/poncho
	display_name = "poncho, tan"
	path = /obj/item/clothing/suit/poncho
	slot = slot_wear_suit

/datum/gear/unathi_robe
	display_name = "roughspun robe (Unathi)"
	path = /obj/item/clothing/suit/unathi/robe
	slot = slot_wear_suit
//	whitelisted = "Unathi" // You don't have a monopoly on a robe!

/datum/gear/blue_lawyer_jacket
	display_name = "suit jacket, blue"
	path = /obj/item/clothing/suit/storage/toggle/lawyer/bluejacket
	cost = 2
	slot = slot_wear_suit

/datum/gear/purple_lawyer_jacket
	display_name = "suit jacket, purple"
	path = /obj/item/clothing/suit/storage/lawyer/purpjacket
	cost = 2
	slot = slot_wear_suit

/datum/gear/wcoat
	display_name = "waistcoat"
	path = /obj/item/clothing/suit/wcoat
	slot = slot_wear_suit

/datum/gear/zhan_furs
	display_name = "Zhan-Khazan furs (Tajaran)"
	path = /obj/item/clothing/suit/tajaran/furs
	slot = slot_wear_suit
	whitelisted = "Tajara" // You do have a monopoly on a fur suit tho

/datum/gear/ianshirt
	display_name = "Worn shirt"
	path = /obj/item/clothing/suit/ianshirt
	cost = 4
	slot = slot_wear_suit

// Gloves

/datum/gear/black_gloves
	display_name = "gloves, black"
	path = /obj/item/clothing/gloves/black
	cost = 2
	slot = slot_gloves

/datum/gear/blue_gloves
	display_name = "gloves, blue"
	path = /obj/item/clothing/gloves/blue
	cost = 2
	slot = slot_gloves

/datum/gear/brown_gloves
	display_name = "gloves, brown"
	path = /obj/item/clothing/gloves/brown
	cost = 2
	slot = slot_gloves

/datum/gear/light_brown_gloves
	display_name = "gloves, light-brown"
	path = /obj/item/clothing/gloves/light_brown
	cost = 2
	slot = slot_gloves

/datum/gear/green_gloves
	display_name = "gloves, green"
	path = /obj/item/clothing/gloves/green
	cost = 2
	slot = slot_gloves

/datum/gear/grey_gloves
	display_name = "gloves, grey"
	path = /obj/item/clothing/gloves/grey
	cost = 2
	slot = slot_gloves

/datum/gear/latex_gloves
	display_name = "gloves, latex"
	path = /obj/item/clothing/gloves/white/latex
	cost = 2
	slot = slot_gloves
/*
/datum/gear/latex_gloves
	display_name = "gloves, latex, tajaran"
	path = /obj/item/clothing/gloves/fluff/murad_hassim_1
	cost = 3
	slot = slot_gloves
	whitelisted = "Tajara"
*/
/datum/gear/orange_gloves
	display_name = "gloves, orange"
	path = /obj/item/clothing/gloves/orange
	cost = 2
	slot = slot_gloves

/datum/gear/purple_gloves
	display_name = "gloves, purple"
	path = /obj/item/clothing/gloves/purple
	cost = 2
	slot = slot_gloves

/datum/gear/rainbow_gloves
	display_name = "gloves, rainbow"
	path = /obj/item/clothing/gloves/rainbow
	cost = 2
	slot = slot_gloves

/datum/gear/red_gloves
	display_name = "gloves, red"
	path = /obj/item/clothing/gloves/red
	cost = 2
	slot = slot_gloves

/datum/gear/white_gloves
	display_name = "gloves, white"
	path = /obj/item/clothing/gloves/white
	cost = 2
	slot = slot_gloves

// Shoelocker

/datum/gear/jackboots
	display_name = "jackboots"
	path = /obj/item/clothing/shoes/jackboots
	slot = slot_shoes

/datum/gear/toeless_jackboots
	display_name = "toe-less jackboots"
	path = /obj/item/clothing/shoes/jackboots/unathi
	slot = slot_shoes

/datum/gear/workboots
	display_name = "workboots"
	path = /obj/item/clothing/shoes/workboots
	slot = slot_shoes

/datum/gear/sandal
	display_name = "sandals"
	path = /obj/item/clothing/shoes/sandal
	slot = slot_shoes

/datum/gear/black_shoes
	display_name = "shoes, black"
	path = /obj/item/clothing/shoes/black
	slot = slot_shoes

/datum/gear/blue_shoes
	display_name = "shoes, blue"
	path = /obj/item/clothing/shoes/blue
	slot = slot_shoes

/datum/gear/brown_shoes
	display_name = "shoes, brown"
	path = /obj/item/clothing/shoes/brown
	slot = slot_shoes

/datum/gear/laceyshoes
	display_name = "shoes, classy"
	path = /obj/item/clothing/shoes/laceup
	slot = slot_shoes

/datum/gear/green_shoes
	display_name = "shoes, green"
	path = /obj/item/clothing/shoes/green
	slot = slot_shoes

/datum/gear/leather
	display_name = "shoes, leather"
	path = /obj/item/clothing/shoes/leather
	slot = slot_shoes

/datum/gear/orange_shoes
	display_name = "shoes, orange"
	path = /obj/item/clothing/shoes/orange
	slot = slot_shoes

/datum/gear/purple_shoes
	display_name = "shoes, purple"
	path = /obj/item/clothing/shoes/purple
	slot = slot_shoes

/datum/gear/rainbow_shoes
	display_name = "shoes, rainbow"
	path = /obj/item/clothing/shoes/rainbow
	slot = slot_shoes

/datum/gear/red_shoes
	display_name = "shoes, red"
	path = /obj/item/clothing/shoes/red
	slot = slot_shoes

/datum/gear/white_shoes
	display_name = "shoes, white"
	path = /obj/item/clothing/shoes/white
	slot = slot_shoes

/datum/gear/yellow_shoes
	display_name = "shoes, yellow"
	path = /obj/item/clothing/shoes/yellow
	slot = slot_shoes

/datum/gear/footwraps
	display_name = "footwraps"
	path = /obj/item/clothing/shoes/footwraps
	cost = 2
	slot = slot_shoes

/datum/gear/sandals_brown
	display_name = "sandals, brown"
	path = /obj/item/clothing/shoes/sandal/brown
	cost = 2
	slot = slot_shoes

/datum/gear/sandals_pink
	display_name = "sandals, pink"
	path = /obj/item/clothing/shoes/sandal/pink
	cost = 2
	slot = slot_shoes

// "Useful" items - I'm guessing things that might be used at work?

/datum/gear/briefcase
	display_name = "briefcase"
	path = /obj/item/weapon/storage/briefcase
	sort_category = "utility"
	cost = 2

/datum/gear/clipboard
	display_name = "clipboard"
	path = /obj/item/weapon/clipboard
	sort_category = "utility"

/datum/gear/folder_blue
	display_name = "folder, blue"
	path = /obj/item/weapon/folder/blue
	sort_category = "utility"

/datum/gear/folder_grey
	display_name = "folder, grey"
	path = /obj/item/weapon/folder
	sort_category = "utility"

/datum/gear/folder_red
	display_name = "folder, red"
	path = /obj/item/weapon/folder/red
	sort_category = "utility"

/datum/gear/folder_white
	display_name = "folder, white"
	path = /obj/item/weapon/folder/white
	sort_category = "utility"

/datum/gear/folder_yellow
	display_name = "folder, yellow"
	path = /obj/item/weapon/folder/yellow
	sort_category = "utility"

/datum/gear/paicard
	display_name = "personal AI device"
	path = /obj/item/device/paicard
	sort_category = "utility"
	cost = 2

// The rest of the trash.

/datum/gear/ashtray
	display_name = "ashtray, plastic"
	path = /obj/item/weapon/material/ashtray/plastic
	sort_category = "misc"

/datum/gear/cane
	display_name = "cane"
	path = /obj/item/weapon/cane
	sort_category = "misc"

/datum/gear/dice
	display_name = "d20"
	path = /obj/item/weapon/dice/d20
	sort_category = "misc"

/datum/gear/cards
	display_name = "deck of cards"
	path = /obj/item/weapon/deck
	sort_category = "misc"

/datum/gear/flask
	display_name = "flask"
	path = /obj/item/weapon/reagent_containers/glass/drinks/flask/barflask
	sort_category = "misc"

/datum/gear/vacflask
	display_name = "vacuum-flask"
	path = /obj/item/weapon/reagent_containers/glass/drinks/flask/vacuumflask
	sort_category = "misc"

/datum/gear/blipstick
	display_name = "lipstick, black"
	path = /obj/item/weapon/lipstick/black
	sort_category = "misc"

/datum/gear/jlipstick
	display_name = "lipstick, jade"
	path = /obj/item/weapon/lipstick/jade
	sort_category = "misc"

/datum/gear/plipstick
	display_name = "lipstick, purple"
	path = /obj/item/weapon/lipstick/purple
	sort_category = "misc"

/datum/gear/rlipstick
	display_name = "lipstick, red"
	path = /obj/item/weapon/lipstick
	sort_category = "misc"

/datum/gear/smokingpipe
	display_name = "pipe, smoking"
	path = /obj/item/clothing/mask/smokable/pipe
	sort_category = "misc"

/datum/gear/cornpipe
	display_name = "pipe, corn"
	path = /obj/item/clothing/mask/smokable/pipe/cobpipe
	sort_category = "misc"

/datum/gear/matchbook
	display_name = "matchbook"
	path = /obj/item/weapon/storage/box/matches
	sort_category = "misc"

/datum/gear/comb
	display_name = "purple comb"
	path = /obj/item/weapon/haircomb
	sort_category = "misc"

/datum/gear/zippo
	display_name = "zippo"
	path = /obj/item/weapon/flame/lighter/zippo
	sort_category = "misc"

/*/datum/gear/combitool
	display_name = "combi-tool"
	path = /obj/item/weapon/combitool
	cost = 3*/

// Stuff worn on the ears. Items here go in the "ears" sort_category but they must not use
// the slot_r_ear or slot_l_ear as the slot, or else players will spawn with no headset.
/datum/gear/earmuffs
	display_name = "earmuffs"
	path = /obj/item/clothing/ears/earmuffs
	sort_category = "ears"

/datum/gear/headphones
	display_name = "headphones"
	path = /obj/item/clothing/ears/earmuffs/mp3
	cost = 1
	sort_category = "ears"

/datum/gear/skrell_chain
	display_name = "skrell headtail-wear, female, chain"
	path = /obj/item/clothing/ears/skrell/chain
	sort_category = "ears"
	whitelisted = "Skrell"

/datum/gear/skrell_plate
	display_name = "skrell headtail-wear, male, bands"
	path = /obj/item/clothing/ears/skrell/band
	sort_category = "ears"
	whitelisted = "Skrell"

/datum/gear/skrell_cloth_male
	display_name = "skrell headtail-wear, male, cloth"
	path = /obj/item/clothing/ears/skrell/cloth_male
	sort_category = "ears"
	whitelisted = "Skrell"

/datum/gear/skrell_cloth_female
	display_name = "skrell headtail-wear, female, cloth"
	path = /obj/item/clothing/ears/skrell/cloth_female
	sort_category = "ears"
	whitelisted = "Skrell"

/datum/gear/skrell_xilobeads
	display_name = "skrell xilobeads"
	path = /obj/item/clothing/ears/skrell/xilobeads
	cost = 2
	sort_category = "ears"
	whitelisted = "Skrell"


/datum/gear/underwear
	display_name = "basic"
	slot = slot_underwear

/datum/gear/underwear/black_female
	display_name = "Underwear, female, black"
	path = /obj/item/clothing/hidden/underwear/type1/black

/datum/gear/underwear/blue_female
	display_name = "Underwear, female, blue"
	path = /obj/item/clothing/hidden/underwear/type1/blue

/datum/gear/underwear/gray_female
	display_name = "Underwear, female, gray"
	path = /obj/item/clothing/hidden/underwear/gray_female

/datum/gear/underwear/green_female
	display_name = "Underwear, female, green"
	path = /obj/item/clothing/hidden/underwear/green_female

/datum/gear/underwear/light_pink_female
	display_name = "Underwear, female, light pink"
	path = /obj/item/clothing/hidden/underwear/light_pink_female

/datum/gear/underwear/light_purple_female
	display_name = "Underwear, female, light purple"
	path = /obj/item/clothing/hidden/underwear/light_purple_female

/datum/gear/underwear/mixed_female
	display_name = "Underwear, female, mixed"
	path = /obj/item/clothing/hidden/underwear/mixed_female

/datum/gear/underwear/pink_female
	display_name = "Underwear, female, pink"
	path = /obj/item/clothing/hidden/underwear/type1/pink

/datum/gear/underwear/red_female
	display_name = "Underwear, female, red"
	path = /obj/item/clothing/hidden/underwear/type1/red

/datum/gear/underwear/red_alt_female
	display_name = "Underwear, female, red alt"
	path = /obj/item/clothing/hidden/underwear/red_alt_female

/datum/gear/underwear/teal_female
	display_name = "Underwear, female, teal"
	path = /obj/item/clothing/hidden/underwear/teal_female

/datum/gear/underwear/thong_female
	display_name = "Underwear, female, thong"
	path = /obj/item/clothing/hidden/underwear/thong_female

/datum/gear/underwear/yellow_female
	display_name = "Underwear, female, yellow"
	path = /obj/item/clothing/hidden/underwear/yellow_female

/datum/gear/socks
	display_name = "basic"
	slot = slot_socks

/datum/gear/socks/black_norm
	display_name = "Socks, Black"
	path = /obj/item/clothing/hidden/socks/black_norm

/datum/gear/socks/black_short
	display_name = "Socks, Black Short"
	path = /obj/item/clothing/hidden/socks/black_short

/datum/gear/socks/black_knee
	display_name = "Socks, Black Knee-length"
	path = /obj/item/clothing/hidden/socks/black_knee

/datum/gear/socks/black_thigh
	display_name = "Socks, Black Thigh"
	path = /obj/item/clothing/hidden/socks/black_thigh

/datum/gear/socks/white_norm
	display_name = "Socks, White"
	path = /obj/item/clothing/hidden/socks/white_norm

/datum/gear/socks/white_short
	display_name = "Socks, White short"
	path = /obj/item/clothing/hidden/socks/white_short

/datum/gear/socks/white_knee
	display_name = "Socks, White Knee-length"
	path = /obj/item/clothing/hidden/socks/white_knee

/datum/gear/socks/white_thigh
	display_name = "Socks, White Thigh"
	path = /obj/item/clothing/hidden/socks/white_thigh

/datum/gear/socks/pantyhose
	display_name = "Socks, Pantyhose"
	path = /obj/item/clothing/hidden/socks/pantyhose

/datum/gear/socks/striped_knee
	display_name = "Socks, Striped Knee-length"
	path = /obj/item/clothing/hidden/socks/striped_knee

/datum/gear/socks/striped_thigh
	display_name = "Socks, Striped Thigh"
	path = /obj/item/clothing/hidden/socks/striped_thigh

/datum/gear/socks/thin_knee
	display_name = "Socks, Thin Knee-length"
	path = /obj/item/clothing/hidden/socks/thin_knee

/datum/gear/socks/thin_thigh
	display_name = "Socks, Thin Thigh"
	path = /obj/item/clothing/hidden/socks/thin_thigh

/datum/gear/pants
	display_name = "Pants, classic jeans"
	path = /obj/item/clothing/under/pants/classicjeans
	slot = slot_w_uniform

/datum/gear/pants/blackjeans
	display_name = "Pants, black"
	path = /obj/item/clothing/under/pants/blackjeans

/datum/gear/pants/white
	display_name = "Pants, white"
	path = /obj/item/clothing/under/pants/white

/datum/gear/pants/red
	display_name = "Pants, red"
	path = /obj/item/clothing/under/pants/red

/datum/gear/pants/black
	display_name = "Pants, black"
	path = /obj/item/clothing/under/pants/black

/datum/gear/pants/track
	display_name = "Pants, track"
	path = /obj/item/clothing/under/pants/track

/datum/gear/pants/tan
	display_name = "Pants, tan"
	path = /obj/item/clothing/under/pants/tan

/datum/gear/pants/jeans
	display_name = "Pants, jeans"
	path = /obj/item/clothing/under/pants/jeans

/datum/gear/pants/khaki
	display_name = "Pants, khaki"
	path = /obj/item/clothing/under/pants/khaki

/datum/gear/pants/camo
	display_name = "Pants, camo"
	path = /obj/item/clothing/under/pants/camo

/datum/gear/aviator
	display_name = "Glasses, aviator"
	path = /obj/item/clothing/glasses/sunglasses/aviator
	cost = 2
	slot = slot_glasses

/datum/gear/varsityred
	display_name = "Varsity jacket, red"
	path = /obj/item/clothing/suit/storage/toggle/varsityred
	cost = 2
	slot = slot_wear_suit

/datum/gear/varsityblue
	display_name = "Varsity jacket, blue"
	path = /obj/item/clothing/suit/storage/toggle/varsityblue
	cost = 2
	slot = slot_wear_suit

/datum/gear/varsityblack
	display_name = "Varsity jacket, black"
	path = /obj/item/clothing/suit/storage/toggle/varsityblack
	cost = 2
	slot = slot_wear_suit

/datum/gear/varsitybrown
	display_name = "Varsity jacket, brown"
	path = /obj/item/clothing/suit/storage/toggle/varsitybrown
	cost = 2
	slot = slot_wear_suit

// Belt

/datum/gear/fannypack
	display_name = "fannypack, leather"
	path = /obj/item/weapon/storage/belt/fannypack
	cost = 2

/datum/gear/fannypack/red
	display_name = "fannypack, red"
	path = /obj/item/weapon/storage/belt/fannypack/red
	cost = 2

/datum/gear/fannypack/white
	display_name = "fannypack, white"
	path = /obj/item/weapon/storage/belt/fannypack/white
	cost = 2

/datum/gear/fannypack/black
	display_name = "fannypack, black"
	path = /obj/item/weapon/storage/belt/fannypack/black
	cost = 2
