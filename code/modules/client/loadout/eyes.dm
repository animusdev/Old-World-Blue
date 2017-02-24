// Eyes
/datum/gear/eyes
	display_name = "eyepatch"
	path = /obj/item/clothing/glasses/eyepatch
	slot = slot_glasses
	sort_category = "Glasses and Eyewear"

/datum/gear/eyes/glasses
	display_name = "Glasses, prescription"
	path = /obj/item/clothing/glasses/regular

/datum/gear/eyes/glasses/green
	display_name = "Glasses, green"
	path = /obj/item/clothing/glasses/gglasses

/datum/gear/eyes/glasses/aviator
	display_name = "Glasses, aviator"
	path = /obj/item/clothing/glasses/sunglasses/aviator

/datum/gear/eyes/glasses/prescriptionhipster
	display_name = "Glasses, hipster"
	path = /obj/item/clothing/glasses/regular/hipster

/datum/gear/eyes/glasses/monocle
	display_name = "Monocle"
	path = /obj/item/clothing/glasses/monocle

/datum/gear/eyes/scanning_goggles
	display_name = "scanning goggles"
	path = /obj/item/clothing/glasses/regular/scanners

/datum/gear/eyes/sciencegoggles
	display_name = "Science Goggles"
	path = /obj/item/clothing/glasses/science

/datum/gear/eyes/security
	display_name = "Security HUD (Security)"
	path = /obj/item/clothing/glasses/hud/security
	cost = 2
	allowed_roles = list("Security Officer","Head of Security","Warden","Detective")

/datum/gear/eyes/medical
	display_name = "Medical HUD (Medical)"
	path = /obj/item/clothing/glasses/hud/health
	allowed_roles = list("Medical Doctor","Chief Medical Officer","Paramedic")

/datum/gear/eyes/medical/prescription
	display_name = "Medical HUD, prescription (Medical)"
	path = /obj/item/clothing/glasses/hud/health/prescription

/datum/gear/eyes/crimson
	display_name = "sunglasses, crimson"
	path = /obj/item/clothing/glasses/sunglasses/red
	cost = 2

/datum/gear/eyes/shades
	display_name = "Sunglasses, fat (Security/Command)"
	path = /obj/item/clothing/glasses/sunglasses/big
	allowed_roles = list("Security Officer","Head of Security","Warden","Captain","Head of Personnel","Quartermaster","Internal Affairs Agent","Detective")

/datum/gear/eyes/shades/prescriptionsun
	display_name = "sunglasses, presciption (Security/Command)"
	path = /obj/item/clothing/glasses/sunglasses/prescription
	cost = 2

/datum/gear/eyes/orange
	path = /obj/item/clothing/glasses/orange
	display_name = "Glasses, orange"

/datum/gear/eyes/red
	path = /obj/item/clothing/glasses/red
	display_name = "Glasses, red"

