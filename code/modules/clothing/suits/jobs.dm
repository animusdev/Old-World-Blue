/*
 * Job related
 */

//Botonist
/obj/item/clothing/suit/apron
	name = "apron"
	desc = "A basic blue apron."
	icon_state = "apron"
	blood_overlay_type = "armor"
	body_parts_covered = 0
	allowed = list (
		/obj/item/weapon/reagent_containers/spray/plantbgone,/obj/item/device/analyzer/plant_analyzer,
		/obj/item/seeds,/obj/item/weapon/reagent_containers/glass/fertilizer,
		/obj/item/weapon/material/minihoe
	)

//Captain
/obj/item/clothing/suit/captunic
	name = "captain's parade tunic"
	desc = "Worn by a Captain to show their class."
	icon_state = "captunic"
	item_state = "captunic"
	body_parts_covered = UPPER_TORSO|ARMS
	flags_inv = HIDEJUMPSUIT

/obj/item/clothing/suit/captunic/capjacket
	name = "captain's uniform jacket"
	desc = "A less formal jacket for everyday captain use."
	icon_state = "capjacket"
	item_state = "capjacket"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS

//Chaplain
/obj/item/clothing/suit/storage/chaplain_hoodie
	name = "chaplain hoodie"
	desc = "This suit says to you 'hush'!"
	icon_state = "chaplain_hoodie"
	body_parts_covered = UPPER_TORSO|ARMS
	allowed = list (/obj/item/weapon/storage/bible,/obj/item/weapon/nullrod)

//Chaplain
/obj/item/clothing/suit/nun
	name = "nun robe"
	desc = "Maximum piety in this star system."
	icon_state = "nun"
	item_state = "nun"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	flags_inv = HIDESHOES|HIDEJUMPSUIT

//Chef
/obj/item/clothing/suit/chef
	name = "chef's apron"
	desc = "An apron used by a high class chef."
	icon_state = "chef"
	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.50
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	allowed = list (/obj/item/weapon/material/knife)

/obj/item/clothing/suit/chef/classic
	name = "A classic chef's apron."
	desc = "A basic, dull, white chef's apron."
	icon_state = "apronchef"
	blood_overlay_type = "armor"
	body_parts_covered = 0

//Security
/obj/item/clothing/suit/security/navyofficer
	name = "security officer's jacket"
	desc = "This jacket is for those special occasions when a security officer actually feels safe."
	icon_state = "officerbluejacket"
	item_state = "blue_blazer"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/suit/security/navywarden
	name = "warden's jacket"
	desc = "Perfectly suited for the warden that wants to leave an impression of style on those who visit the brig."
	icon_state = "wardenbluejacket"
	item_state = "blue_blazer"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/suit/security/navyhos
	name = "head of security's jacket"
	desc = "This piece of clothing was specifically designed for asserting superior authority."
	icon_state = "hosbluejacket"
	item_state = "blue_blazer"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/suit/storage/security/dnavyofficer
	name = "security officer's jacket"
	desc = "This jacket is for those special occasions when a security officer actually feels safe. \
			Still, it's slightly armored."
	icon_state = "officerdnavyjacket"
	item_state = "blue_blazer"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	allowed = list(
		/obj/item/weapon/tank/emergency_oxygen,/obj/item/device/flashlight,/obj/item/weapon/gun/energy,
		/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,
		/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs
	)
	armor = list(melee = 20, bullet = 20, laser = 25, energy = 15, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/suit/storage/security/dnavywarden
	name = "warden's jacket"
	desc = "Perfectly suited for the warden that wants to leave an impression of style on those who visit the brig."
	icon_state = "wardendnavyjacket"
	item_state = "blue_blazer"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	allowed = list(
		/obj/item/weapon/tank/emergency_oxygen, /obj/item/device/flashlight,/obj/item/weapon/gun/energy,
		/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,
		/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs
	)
	armor = list(melee = 20, bullet = 20, laser = 25, energy = 15, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/suit/storage/security/dnavyhos
	name = "head of security's jacket"
	desc = "This piece of clothing was specifically designed for asserting superior authority."
	icon_state = "hosdnavyjacket"
	item_state = "blue_blazer"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	allowed = list(
		/obj/item/weapon/tank/emergency_oxygen, /obj/item/device/flashlight,/obj/item/weapon/gun/energy,
		/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,
		/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs
	)
	armor = list(melee = 20, bullet = 20, laser = 25, energy = 15, bomb = 0, bio = 0, rad = 0)

//Detective
/obj/item/clothing/suit/storage/det_suit
	name = "trenchcoat"
	desc = "An 18th-century multi-purpose trenchcoat. Someone who wears this means serious business."
	icon_state = "detective"
	item_state = "det_suit"
	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|ARMS
	allowed = list(
		/obj/item/weapon/tank/emergency_oxygen, /obj/item/device/flashlight,/obj/item/weapon/gun/energy,
		/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/weapon/flame/lighter,
		/obj/item/weapon/handcuffs,/obj/item/weapon/storage/fancy/cigarettes,
		/obj/item/weapon/melee/baton,/obj/item/ammo_casing
	)
	armor = list(melee = 50, bullet = 10, laser = 25, energy = 10, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/suit/storage/det_suit/black
	icon_state = "detective2"

/obj/item/clothing/suit/storage/det_suit/seven
	name = "leather coat"
	icon_state = "sevencoat"
	desc = "Thick and sturdy coat with the armor vest attached to it's innards. So, what's in the box?"
	armor = list(melee = 50, bullet = 15, laser = 50, energy = 10, bomb = 25, bio = 0, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO



//Forensics
/obj/item/clothing/suit/storage/forensics
	name = "jacket"
	desc = "A forensics technician jacket."
	item_state = "det_suit"
	body_parts_covered = UPPER_TORSO|ARMS
	allowed = list(
		/obj/item/weapon/tank/emergency_oxygen, /obj/item/device/flashlight,/obj/item/weapon/gun/energy,
		/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/weapon/melee/baton,
		/obj/item/weapon/handcuffs,/obj/item/device/taperecorder,/obj/item/ammo_casing
	)
	armor = list(melee = 10, bullet = 10, laser = 15, energy = 10, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/suit/storage/forensics/red
	name = "red jacket"
	desc = "A red forensics technician jacket."
	icon_state = "forensics_red"

/obj/item/clothing/suit/storage/forensics/blue
	name = "blue jacket"
	desc = "A blue forensics technician jacket."
	icon_state = "forensics_blue"

//Engineering
/obj/item/clothing/suit/storage/hazardvest
	name = "hazard vest"
	desc = "A high-visibility vest used in work zones."
	icon_state = "hazard"
	blood_overlay_type = "armor"
	allowed = list (
		/obj/item/device/analyzer, /obj/item/device/flashlight, /obj/item/weapon/tank/emergency_oxygen,
		/obj/item/device/pipe_painter, /obj/item/weapon/weldingtool, /obj/item/weapon/screwdriver,
		/obj/item/weapon/wirecutters, /obj/item/taperoll/engineering, /obj/item/device/multitool,
		/obj/item/weapon/crowbar, /obj/item/weapon/wrench, /obj/item/device/radio,
		/obj/item/clothing/mask/gas, /obj/item/device/t_scanner
	)
	body_parts_covered = UPPER_TORSO

//Lawyer
/obj/item/clothing/suit/storage/toggle/lawyer/bluejacket
	name = "Blue Suit Jacket"
	desc = "A snappy dress jacket."
	icon_state = "suitjacket_blue_open"
	base_state = "suitjacket_blue"
	item_state = "blue_blazer"
	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|ARMS

/obj/item/clothing/suit/storage/lawyer/purpjacket
	name = "Purple Suit Jacket"
	desc = "A snappy dress jacket."
	icon_state = "suitjacket_purp"
	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|ARMS

//Internal Affairs
/obj/item/clothing/suit/storage/toggle/internalaffairs
	name = "Internal Affairs Jacket"
	desc = "A smooth black jacket."
	icon_state = "ia_jacket_open"
	base_state = "ia_jacket"
	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|ARMS

//Head of Personnel
/obj/item/clothing/suit/storage/toggle/hop
	name = "head of personnel's jacket"
	desc = "Funny, it looks bigger inside."
	icon_state = "gmjacket_open"
	base_state = "gmjacket"
	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|ARMS

//Medical
/obj/item/clothing/suit/storage/toggle/fr_jacket
	name = "first responder jacket"
	desc = "A high-visibility jacket worn by medical first responders."
	icon_state = "fr_jacket_open"
	item_state = "fr_jacket"
	base_state = "fr_jacket"
	blood_overlay_type = "armor"
	allowed = list(
		/obj/item/stack/medical, /obj/item/device/radio, /obj/item/weapon/reagent_containers/dropper,
		/obj/item/weapon/reagent_containers/hypospray, /obj/item/weapon/reagent_containers/syringe,
		/obj/item/device/healthanalyzer, /obj/item/device/flashlight,
		/obj/item/weapon/tank/emergency_oxygen
	)
	body_parts_covered = UPPER_TORSO|ARMS

/obj/item/clothing/suit/storage/toggle/fr_jacket/ems
	name = "\improper EMS jacket"
	desc = "A dark blue, martian-pattern, EMS jacket. \
			It sports high-visibility reflective stripes and a star of life on the back."
	icon_state = "ems_jacket"

/obj/item/clothing/suit/storage/paramedic
	name = "paramedic vest"
	desc = "A hazard vest used in the recovery of bodies."
	icon_state = "paramedic-vest"
	allowed = list(
		/obj/item/device/analyzer,/obj/item/weapon/dnainjector,/obj/item/weapon/tank/emergency_oxygen,
		/obj/item/weapon/reagent_containers/hypospray,/obj/item/weapon/reagent_containers/syringe,
		/obj/item/device/healthanalyzer,/obj/item/weapon/reagent_containers/dropper,
		/obj/item/device/flashlight/pen,/obj/item/stack/medical,/obj/item/device/radio
	)
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 10, rad = 10)

/obj/item/clothing/suit/storage/fr_jacket/emerald
	name = "EMS jacket"
	desc = "Emerald jacket worn by medical first responders."
	icon_state = "labcoat_emt"

//Investigator
/obj/item/clothing/suit/storage/toggle/investigator
	name = "investigator jacket"
	desc = "That's a black jacket with the investigator badge on it."
	icon_state = "investigator_open"
	item_state = "investigator"
	base_state = "investigator"
	blood_overlay_type = "armor"
	body_parts_covered = UPPER_TORSO|ARMS
	allowed = list(
		/obj/item/weapon/tank/emergency_oxygen, /obj/item/device/flashlight,/obj/item/weapon/gun/energy,
		/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,
		/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/storage/fancy/cigarettes,
		/obj/item/weapon/flame/lighter,/obj/item/device/taperecorder,/obj/item/device/uv_light
	)

/obj/item/clothing/suit/storage/toggle/investigator/alt
	desc = "That't a black jacket with investigator insignias."
	icon_state = "investigatoralt_open"
	item_state = "investigatoralt"
	base_state = "investigatoralt"