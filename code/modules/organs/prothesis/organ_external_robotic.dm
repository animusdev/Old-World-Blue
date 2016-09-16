/obj/item/organ/external/robotic
	force_icon = 'icons/mob/human_races/robotic.dmi'
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	dislocated = -1
	cannot_break = 1
	robotic = 2
	status = ORGAN_ROBOT|ORGAN_ASSISTED
	brute_mod = 0.8
	burn_mod = 0.8
	var/list/forced_children = null

/obj/item/organ/external/robotic/get_icon()
	var/body_build = owner ? (owner.body_build) : 0
	mob_icon = new /icon(force_icon, "[limb_name]_[body_build]")
	dir = EAST
	icon = mob_icon
	return mob_icon

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

/obj/item/organ/external/robotic/install()
	..()
	if(islist(forced_children) && forced_children[limb_name])
		var/list/spawn_part = forced_children[limb_name]
		var/child_type
		for(var/name in spawn_part)
			child_type = spawn_part[name]
			new child_type(owner, owner.species.has_limbs[name])
	if(can_activate())
		activate()

/obj/item/organ/external/robotic/removed(mob/living/user)
	var/mob/living/carbon/human/last_owner = src.owner
	..()
	if(sabotaged)
		last_owner.visible_message(
			"<span class='danger'>\The [last_owner]'s [src.name] explodes violently!</span>",\
			"<span class='danger'>Your [src.name] explodes!</span>",\
			"<span class='danger'>You hear an explosion!</span>")
		explosion(get_turf(src),-1,-1,2,3)
		var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
		spark_system.set_up(5, 0, last_owner)
		spark_system.attach(last_owner)
		spark_system.start()
		spawn(10)
			qdel(spark_system)
		qdel(src)


/obj/item/organ/external/robotic/limb
	max_damage = 50
	min_broken_damage = 30
	w_class = 3

/obj/item/organ/external/robotic/tiny
	min_broken_damage = 15
	w_class = 2

/obj/item/organ/external/robotic/enforcer
	force_icon = 'icons/mob/human_races/cyberlimbs/enforcer.dmi'
	brute_mod = 0.7
	burn_mod = 0.7

/obj/item/organ/external/robotic/enforcer/limb
	max_damage = 70
	min_broken_damage = 35
	w_class = 4
	forced_children = list(
		"l_arm" = list("l_hand" = /obj/item/organ/external/robotic/enforcer/tiny/hand),
		"r_arm" = list("r_hand" = /obj/item/organ/external/robotic/enforcer/tiny/hand),
		"l_leg" = list("l_foot" = /obj/item/organ/external/robotic/enforcer/tiny),
		"r_leg" = list("r_foot" = /obj/item/organ/external/robotic/enforcer/tiny)
		)

/obj/item/organ/external/robotic/enforcer/tiny
	min_broken_damage = 20
	w_class = 3

/obj/item/organ/external/robotic/enforcer/tiny/hand
	var/datum/unarmed_attack/enforcer/active_atack = new

	activate()
		verbs += /obj/item/organ/external/robotic/enforcer/tiny/hand/proc/toggle
		owner << "<span class='notice'>Power system controller successfuly activated inside your [name].</span>"

	deactivate(emergency = 1)
		owner << "<span class = 'warning'>Your [name] power module has been emergency disabled!</span>"
		if(emergency)
			verbs -= /obj/item/organ/external/robotic/enforcer/tiny/hand/proc/toggle
			qdel(active_atack)

	proc/toggle()
		set name = "Toggle force mode"
		set category = "Prosthesis"
		set popup_menu = 0
		if(usr != owner || owner.stat || owner.restrained()) return
		if(in_use)
			owner << "<span class = 'warning'>Power system still toggling. Wait please.</span>"
		in_use = 1
		if(!attack)
			attack = active_atack
			owner.visible_message("<span class = 'warning'>[owner] activate \his [name]'s power system!</span>",\
				"<span class = 'notice'>Your [name]'s power system has been successfully activated.</span>",\
				"<span class = 'warning'>You hear loudly metal sound and hissing of steam jets.</span>")
		else
			attack = null
			owner.visible_message("<span class = 'notice'>[owner] disabled \his [name]'s power system.</span>",\
				"<span class = 'notice'>Your [name]'s power system has been successfully disabled.</span>",\
				"<span class = 'warning'>You hear loudly metal sound.</span>")
		sleep(60)
		in_use = 0

/datum/unarmed_attack/enforcer
	attack_verb = list("smash")
	attack_noun = list("fist")
	damage = 5
	attack_sound = "punch"
	shredding = 1
	is_usable(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target, var/zone)
		if(user.restrained()) return 0
		return 1


/obj/item/clothing/shoes/magboots/mounted
	var/atom/holder = null
	New(newloc)
		holder = newloc
		..()
	dropped()
		..()
		if(holder)
			forceMove(holder)

/obj/item/organ/external/robotic/enforcer/limb/leg
	var/obj/item/clothing/shoes/magboots/mounted/magboots = null
	var/obj/item/organ/external/robotic/enforcer/limb/slave = null

	can_activate()
		var/obj/item/organ/external/robotic/enforcer/limb/leg/other = null
		if(body_part == "l_leg")
			other = owner.organs_by_name["r_leg"]
		else
			other = owner.organs_by_name["l_leg"]
		if(other && istype(other, type))
			other.slave = src
			return 0
		return 1

	activate()
		verbs += /obj/item/organ/external/robotic/enforcer/limb/leg/proc/toggle_magboots
		magboots = new(src)
		magboots.canremove = 0
		owner << "<span class='notice'>Magboots controller successfuly activated inside your [name].</span>"

	deactivate(emergency = 1)
		if(magboots)
			if(!(magboots in src))
				if(owner)
					owner << "<span class = 'warning'>Magboots module has been emergency disabled!</span>"
					owner.u_equip(magboots)
				magboots.forceMove(src)
			if(emergency)
				verbs -= /obj/item/organ/external/robotic/enforcer/limb/leg/proc/toggle_magboots
				qdel(magboots)
		if(slave && !deleted(slave) && slave.owner == owner)
			slave.activate()
			slave = null

	proc/toggle_magboots()
		set name = "Toggle Magboots"
		set category = "Prosthesis"
		set popup_menu = 0
		if(!owner || !magboots) //MB would be rewrited after forced toggle addition.
			usr << "<span class='warning'>You can't unload magboots when controller disabled.</span>"
			return
		if(owner.stat) return
		if(magboots in src)
			if(owner.equip_to_slot_if_possible(magboots, slot_shoes))
				usr << "<span class = 'notice'>The mag-pulse traction system has been activated.</span>"
		else
			owner.drop_from_inventory(magboots, src)
			usr << "<span class = 'notice'>The mag-pulse traction system has been disabled.</span>"
		return


