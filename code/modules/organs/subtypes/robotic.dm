/obj/item/organ/external/robotic
	icon = 'icons/mob/human_races/cyberlimbs/robotic.dmi'
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	dislocated = -1
	cannot_break = 1
	robotic = ORGAN_ROBOT
	brute_mod = 0.8
	burn_mod = 0.8
	var/list/forced_children = null

/obj/item/organ/external/robotic/install()
	if(..()) return 1
	if(islist(forced_children) && forced_children[organ_tag])
		var/list/spawn_part = forced_children[organ_tag]
		var/child_type
		for(var/name in spawn_part)
			child_type = spawn_part[name]
			new child_type(owner, owner.species.has_limbs[name])
	if(can_activate())
		activate()

/obj/item/organ/external/robotic/get_icon()
	var/gender = "_m"
	var/body_build = ""
	if(owner)
		if(owner.gender == FEMALE)
			gender = "_f"
		body_build = owner.body_build.index
	icon_state = "[organ_tag][gendered ? "[gender]" : ""][body_build]"

	mob_icon = new /icon(icon, icon_state)
	icon = mob_icon
	dir = SOUTH
	return mob_icon

/obj/item/organ/external/robotic/get_icon_key()
	. = "2"
	if(model)
		. += model

/obj/item/organ/external/robotic/Destroy()
	deactivate(1)
	..()

/obj/item/organ/external/robotic/removed()
	deactivate(1)
	..()

/obj/item/organ/external/robotic/update_germs()
	germ_level = 0
	return

/obj/item/organ/external/robotic/proc/can_activate()
	return 1

/obj/item/organ/external/robotic/proc/activate()
	return 1

/obj/item/organ/external/robotic/proc/deactivate(var/emergency = 1)
	return 1

/obj/item/organ/external/robotic/limb
	max_damage = 50
	min_broken_damage = 30
	w_class = 3

/obj/item/organ/external/robotic/tiny
	min_broken_damage = 15
	w_class = 2

