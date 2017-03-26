//// Wolverine ////

/obj/item/organ/external/robotic/wolverine
	default_icon = 'icons/mob/human_races/cyberlimbs/wolverine.dmi'


obj/item/prosthesis/wolverine
	desc = "Full limb Wolverine module."
	matter = list(DEFAULT_WALL_MATERIAL = 25000)
	construction_cost = list(DEFAULT_WALL_MATERIAL=30000)

/obj/item/prosthesis/wolverine/l_arm
	name = "Wolverine left arm"
	icon_state = "l_arm"
	part = list(BP_L_ARM = /obj/item/organ/external/robotic/wolverine/limb)

/obj/item/prosthesis/wolverine/r_arm
	name = "Wolverine right arm"
	icon_state = "r_arm"
	part = list(BP_R_ARM = /obj/item/organ/external/robotic/wolverine/limb)

/obj/item/organ/external/robotic/wolverine/limb
	forced_children = list(
		BP_L_ARM = list(BP_L_HAND = /obj/item/organ/external/robotic/wolverine/hand),
		BP_R_ARM = list(BP_R_HAND = /obj/item/organ/external/robotic/wolverine/hand)
		)

/obj/item/organ/external/robotic/wolverine/hand
	var/datum/unarmed_attack/wolverine/active_atack = new

	activate()
		verbs += /obj/item/organ/external/robotic/wolverine/hand/proc/toggle
		owner << "<span class='notice'>Cyber-blade controller successfuly activated inside your [name].</span>"

	proc/toggle()
		set name = "Enable cyber-blade"
		set category = "Prosthesis"
		set popup_menu = 0
		if(usr != owner || owner.stat || owner.restrained()) return
		if(in_use)
			owner << "<span class = 'warning'>Blade is still retracting. Wait please.</span>"
		in_use = 1
		if(!attack)
			attack = active_atack
			owner.visible_message("<span class = 'warning'>[owner] switch \his [name]'s cyber-blades!</span>",\
				"<span class = 'notice'>Your [name]'s cyber-blades have been successfully activated.</span>",\
				"<span class = 'warning'>You hear loud metal sound and clang of drawing out blades.</span>")
		else
			attack = null
			owner.visible_message("<span class = 'notice'>[owner] retracted \his [name]'s cyber-blades.</span>",\
				"<span class = 'notice'>Your [name]'s cyber-blades has been successfully retracted.</span>",\
				"<span class = 'warning'>You hear loudly metal sound.</span>")
		sleep(60)
		in_use = 0

/datum/unarmed_attack/wolverine
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	attack_noun = list("blade")
	damage = 10
	shredding = 1
	attack_sound = 'sound/weapons/slice.ogg'
	is_usable(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target, var/zone)
		if(user.restrained()) return 0
		return 1
