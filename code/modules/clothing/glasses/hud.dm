/obj/item/clothing/glasses/hud
	name = "HUD"
	desc = "A heads-up display that provides important info in (almost) real time."
	flags = null //doesn't protect eyes because it's a monocle, duh
	origin_tech = "magnets=3;biotech=2"
	var/list/icon/current = list() //the current hud icons

	proc
		process_hud(var/mob/M)	return



/obj/item/clothing/glasses/hud/health
	name = "Health Scanner HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their health status."
	icon_state = "healthhud"
	body_parts_covered = 0

/obj/item/clothing/glasses/hud/health/prescription
	name = "Prescription Medical HUD Glasses"
	desc = "Medical HUD glasses with prescription lenses."
	icon_state = "glasseshealth"
	prescription = 1

/obj/item/clothing/glasses/hud/health/process_hud(var/mob/M)
	process_med_hud(M, 1)

/obj/item/clothing/glasses/hud/security
	name = "Security HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their ID status and security records."
	icon_state = "securityhud"
	body_parts_covered = 0
	var/global/list/jobs[0]

/obj/item/clothing/glasses/hud/engi
	name = "Engineereing HUD"
	desc = "A heads-up display that scans walls, floors, and stuff to provide accurate data about station condition"
	icon_state = "engihud"
	item_state = "engihud"
	body_parts_covered = 0
	vision_flags = SEE_TURFS

/obj/item/clothing/glasses/hud/security/jensenshades
	name = "Augmented shades"
	desc = "Polarized bioneural eyewear, designed to augment your vision."
	icon_state = "jensenshades"
	item_state = "jensenshades"
	darkness_view = -1

/obj/item/clothing/glasses/hud/security/process_hud(var/mob/M)
	process_sec_hud(M, 1)
