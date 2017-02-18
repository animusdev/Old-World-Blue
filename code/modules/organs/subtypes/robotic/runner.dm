//// Runner ////

/obj/item/prosthesis/runner
	desc = "Full limb runner prosthesis module."
	matter = list(DEFAULT_WALL_MATERIAL = 9000)
	construction_cost = list(DEFAULT_WALL_MATERIAL=15000)

/obj/item/prosthesis/runner/l_arm
	name = "Runner left arm"
	icon_state = "l_arm"
	part = list(BP_L_ARM = /obj/item/organ/external/robotic/limb/runner)

/obj/item/prosthesis/runner/r_arm
	name = "Runner Charge right arm"
	icon_state = "r_arm"
	part = list(BP_R_ARM = /obj/item/organ/external/robotic/limb/runner)

/obj/item/prosthesis/runner/l_leg
	name = "Runner Charge left leg"
	icon_state = "l_leg"
	part = list(BP_L_LEG = /obj/item/organ/external/robotic/limb/runner)

/obj/item/prosthesis/runner/r_leg
	name = "Runner Charge right leg"
	icon_state = "r_leg"
	part = list(BP_R_LEG = /obj/item/organ/external/robotic/limb/runner)


/obj/item/organ/external/robotic/limb/runner
	max_damage = 45
	min_broken_damage = 30
	w_class = 3
	forced_children = list(
		BP_L_ARM = list(BP_L_HAND = /obj/item/organ/external/robotic/limb/runner/tiny),
		BP_R_ARM = list(BP_R_HAND = /obj/item/organ/external/robotic/limb/runner/tiny),
		BP_L_LEG = list(BP_L_FOOT = /obj/item/organ/external/robotic/limb/runner/tiny),
		BP_R_LEG = list(BP_R_FOOT = /obj/item/organ/external/robotic/limb/runner/tiny)
		)

/obj/item/organ/external/robotic/limb/runner/tiny
	tally = -0.25
	min_broken_damage = 15
	w_class = 2
