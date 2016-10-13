/obj/item/clothing/suit/storage/toggle/labcoat
	name = "labcoat"
	desc = "A suit that protects against minor chemical spills."
	icon_state = "labcoat_open"
	item_state = "labcoat"
	base_state = "labcoat"
	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|ARMS
	allowed = list(
		/obj/item/device/analyzer,/obj/item/stack/medical,/obj/item/weapon/dnainjector,
		/obj/item/weapon/reagent_containers/dropper,/obj/item/weapon/reagent_containers/syringe,
		/obj/item/weapon/reagent_containers/hypospray,/obj/item/device/healthanalyzer,
		/obj/item/device/flashlight/pen,/obj/item/weapon/reagent_containers/glass/beaker/bottle,
		/obj/item/weapon/reagent_containers/glass/beaker,/obj/item/weapon/reagent_containers/pill,
		/obj/item/weapon/storage/pill_bottle,/obj/item/weapon/paper,/obj/item/device/radio
	)
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 50, rad = 0)

/obj/item/clothing/suit/storage/toggle/labcoat/red
	name = "red labcoat"
	desc = "A suit that protects against minor chemical spills. This one is red."
	color = "#c92222"

/obj/item/clothing/suit/storage/toggle/labcoat/blue
	name = "blue labcoat"
	desc = "A suit that protects against minor chemical spills. This one is blue."
	color = "#026ad7"

/obj/item/clothing/suit/storage/toggle/labcoat/purple
	name = "purple labcoat"
	desc = "A suit that protects against minor chemical spills. This one is purple."
	color = "#8b11f2"

/obj/item/clothing/suit/storage/toggle/labcoat/orange
	name = "orange labcoat"
	desc = "A suit that protects against minor chemical spills. This one is orange."
	color = "#d5902c"

/obj/item/clothing/suit/storage/toggle/labcoat/green
	name = "green labcoat"
	desc = "A suit that protects against minor chemical spills. This one is green."
	color = "#59d516"

/obj/item/clothing/suit/storage/toggle/labcoat/cmo
	name = "chief medical officer's labcoat"
	desc = "Bluer than the standard model."
	icon_state = "labcoat_cmo_open"
	base_state = "labcoat_cmo"

/obj/item/clothing/suit/storage/toggle/labcoat/cmoalt
	name = "chief medical officer labcoat"
	desc = "A labcoat with command blue highlights."
	icon_state = "labcoat_cmoalt_open"
	base_state = "labcoat_cmoalt"

/obj/item/clothing/suit/storage/toggle/labcoat/genetics
	name = "Geneticist labcoat"
	desc = "A suit that protects against minor chemical spills. Has a blue stripe on the shoulder."
	icon_state = "labcoat_gen_open"
	base_state = "labcoat_gen"

/obj/item/clothing/suit/storage/toggle/labcoat/chemist
	name = "Chemist labcoat"
	desc = "A suit that protects against minor chemical spills. Has an orange stripe on the shoulder."
	icon_state = "labcoat_chem_open"
	base_state = "labcoat_chem"

/obj/item/clothing/suit/storage/toggle/labcoat/forensic
	name = "Forensic Technician labcoat"
	desc = "A padded suit that protects against minor damage. Has a red stripe on the shoulder."
	icon_state = "labcoat_foren_open"
	base_state = "labcoat_foren"
	armor = list(melee = 10, bullet = 10, laser = 15, energy = 10, bomb = 0, bio = 0, rad = 0)
	allowed = list(
		/obj/item/device/analyzer,/obj/item/stack/medical,/obj/item/weapon/dnainjector,
		/obj/item/weapon/reagent_containers/dropper,/obj/item/weapon/reagent_containers/syringe,
		/obj/item/weapon/reagent_containers/hypospray,/obj/item/device/healthanalyzer,
		/obj/item/device/flashlight/pen,/obj/item/weapon/reagent_containers/glass/beaker/bottle,
		/obj/item/weapon/reagent_containers/glass/beaker,/obj/item/weapon/reagent_containers/pill,
		/obj/item/weapon/storage/pill_bottle,/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/device/taperecorder
	)

/obj/item/clothing/suit/storage/toggle/labcoat/virologist
	name = "Virologist labcoat"
	desc = "A suit that protects against minor chemical spills. \
	Offers slightly more protection against biohazards than the standard model. Has a green stripe on the shoulder."
	icon_state = "labcoat_vir_open"
	base_state = "labcoat_vir"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 60, rad = 0)

/obj/item/clothing/suit/storage/toggle/labcoat/science
	name = "Scientist labcoat"
	desc = "A suit that protects against minor chemical spills. Has a purple stripe on the shoulder."
	icon_state = "labcoat_tox_open"
	base_state = "labcoat_tox"

/obj/item/clothing/suit/storage/labcoat
	item_state = "labcoat"
	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|ARMS
	allowed = list(
		/obj/item/device/analyzer,/obj/item/stack/medical,/obj/item/weapon/dnainjector,
		/obj/item/weapon/reagent_containers/dropper,/obj/item/weapon/reagent_containers/syringe,
		/obj/item/weapon/reagent_containers/hypospray,/obj/item/device/healthanalyzer,
		/obj/item/device/flashlight/pen,/obj/item/weapon/reagent_containers/glass/beaker/bottle,
		/obj/item/weapon/reagent_containers/glass/beaker,/obj/item/weapon/reagent_containers/pill,
		/obj/item/weapon/storage/pill_bottle,/obj/item/weapon/paper,/obj/item/device/radio
	)
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 50, rad = 0)

/obj/item/clothing/suit/storage/labcoat/augmented
	name = "augmented labcoat"
	desc = "What a lovely diods! Blink."
	icon_state = "labcoat_aug"

/obj/item/clothing/suit/storage/labcoat/long
	name = "long labcoat"
	desc = "A suit that protects against minor chemical spills."
	icon_state = "labcoat_long"

/obj/item/clothing/suit/storage/toggle/labcoat/forensic
	name = "forensics labcoat"
	desc = "That's a long white labcoat with the forensic insignia on ot."
	icon_state = "forensictech_open"
	base_state = "forensictech"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 30, rad = 0)
	allowed = list(
		/obj/item/weapon/tank/emergency_oxygen, /obj/item/device/flashlight,/obj/item/weapon/gun/energy,
		/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,
		/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/storage/fancy/cigarettes,
		/obj/item/weapon/flame/lighter,/obj/item/device/taperecorder,/obj/item/device/uv_light
	)
