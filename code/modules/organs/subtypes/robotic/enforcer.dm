/obj/item/organ/external/robotic/enforcer
	default_icon = 'icons/mob/human_races/cyberlimbs/enforcer.dmi'
	brute_mod = 0.7
	burn_mod = 0.7

/obj/item/organ/external/robotic/enforcer/set_description()
	..()
	w_class ++ // I't large than normal organ

/obj/item/organ/external/robotic/enforcer/limb
	forced_children = list(
		BP_L_ARM = list(BP_L_HAND = /obj/item/organ/external/robotic/enforcer/hand),
		BP_R_ARM = list(BP_R_HAND = /obj/item/organ/external/robotic/enforcer/hand),
		BP_L_LEG = list(BP_L_FOOT = /obj/item/organ/external/robotic/enforcer),
		BP_R_LEG = list(BP_R_FOOT = /obj/item/organ/external/robotic/enforcer)
		)

/obj/item/organ/external/robotic/enforcer/hand
	var/datum/unarmed_attack/enforcer/active_atack = new

	install()
		if(..())
			return 1
		verbs += /obj/item/organ/external/robotic/enforcer/hand/proc/toggle
		owner << SPAN_NOTE("Power system controller successfuly activated inside your [name].")

	removed()
		. = ..()
		verbs -= /obj/item/organ/external/robotic/enforcer/hand/proc/toggle

	deactivate()
		owner << SPAN_WARN("Your [name] power module has been emergency disabled!")
		attack = null

	proc/toggle()
		set name = "Toggle force mode"
		set category = "Prosthesis"
		set popup_menu = 0
		if(usr != owner || owner.stat || owner.restrained()) return
		if(in_use)
			owner << SPAN_WARN("Power system still toggling. Wait please.")
		in_use = 1
		spawn(60)
			in_use = 0

		if(!attack)
			if(!can_activate())
				return
			attack = active_atack
			owner.visible_message(
				SPAN_WARN("[owner] activate \his [name]'s power system!"),
				SPAN_NOTE("Your [name]'s power system has been successfully activated."),
				SPAN_WARN("You hear loudly metal sound and hissing of steam jets.")
			)
		else
			attack = null
			owner.visible_message(
				SPAN_NOTE("[owner] disabled \his [name]'s power system."),
				SPAN_NOTE("Your [name]'s power system has been successfully disabled."),
				SPAN_WARN("You hear loudly metal sound.")
			)

/datum/unarmed_attack/enforcer
	attack_verb = list("smash")
	attack_noun = list("fist")
	damage = 5
	attack_sound = "punch"
	shredding = 1
	is_usable(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target, var/zone)
		if(user.restrained())
			return FALSE
		return TRUE


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
	var/obj/item/organ/external/robotic/enforcer/limb/leg/slave = null

	install()
		. = ..()
		if(!.)
			prepare()

	removed()
		deactivate()
		..()
		verbs -= /obj/item/organ/external/robotic/enforcer/limb/leg/proc/toggle_magboots
		qdel(magboots)
		magboots = null
		if(slave && !deleted(slave) && slave.owner == owner)
			slave.prepare()
			slave = null

	deactivate()
		if(magboots)
			if(magboots.loc != src)
				if(owner)
					owner << SPAN_WARN("Magboots module has been emergency disabled!")
					owner.drop_from_inventory(magboots, src)
				magboots.forceMove(src)

	proc/prepare()
		var/obj/item/organ/external/robotic/enforcer/limb/leg/other = null
		if(body_part == BP_L_LEG)
			other = owner.organs_by_name[BP_R_LEG]
		else
			other = owner.organs_by_name[BP_L_LEG]
		if(other && istype(other, type))
			other.slave = src
		else
			verbs += /obj/item/organ/external/robotic/enforcer/limb/leg/proc/toggle_magboots
			magboots = PoolOrNew(/obj/item/clothing/shoes/magboots/mounted, src)
			magboots.canremove = FALSE
			owner << SPAN_NOTE("Magboots controller successfuly activated inside your [src].")

	proc/toggle_magboots()
		set name = "Toggle Magboots"
		set category = "Prosthesis"
		set popup_menu = 0
		if(!can_activate())
			return
		if(!owner || !magboots) //MB would be rewrited after forced toggle addition.
			usr << SPAN_WARN("You can't unload magboots when controller disabled.")
			return
		if(magboots.loc == src)
			if(owner.equip_to_slot_if_possible(magboots, slot_shoes))
				usr << SPAN_NOTE("The mag-pulse traction system has been activated.")
		else
			owner.drop_from_inventory(magboots, src)
			usr << SPAN_WARN("The mag-pulse traction system has been disabled.")
		return

