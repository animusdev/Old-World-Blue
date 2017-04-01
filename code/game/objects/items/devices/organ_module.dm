/obj/item/organ_module
	name = "embedded organ module"
	desc = "Embedded organ module."
	icon = 'icons/obj/surgery.dmi'
	var/list/allowed_organs = list() // Surgery. list of organ_tags. BP_R_ARM, BP_L_ARM, BP_HEAD, etc.

/obj/item/organ_module/proc/install(var/obj/item/organ/external/E)

/obj/item/organ_module/proc/remove(var/obj/item/organ/external/E)


//Toggleable embedded module

/obj/item/organ_module/active
	var/verb_name = "Activate"
	var/verb_desc = "activate embedded module"

/obj/item/organ_module/active/install(var/obj/item/organ/external/E)
	new /obj/item/organ/external/proc/activate(E, verb_name, verb_desc)

/obj/item/organ_module/active/remove(var/obj/item/organ/external/E)
	E.verbs -= /obj/item/organ/external/proc/activate

/obj/item/organ_module/active/proc/activate(var/mob/living/carbon/human/H, var/obj/item/organ/external/E)


//Simple toggleabse module. Just put holding in hands or get it back

/obj/item/organ_module/active/simple
	var/obj/item/holding = null
	var/holding_type = null

/obj/item/organ_module/active/simple/New()
	..()
	if(holding_type)
		holding = new holding_type(src)

/obj/item/organ_module/active/simple/activate(mob/living/carbon/human/H, obj/item/organ/external/E)
	if(H.sleeping || H.stunned || H.restrained())
		H << SPAN_WARN("You can't do that now!")
		return

	if(holding in src) //item not in hands
		var/slot = null
		if(E.icon_position == LEFT)
			slot = slot_l_hand
		else if(E.icon_position == RIGHT)
			slot = slot_r_hand
		if(H.equip_to_slot_if_possible(holding, slot))
			H.visible_message(
				SPAN_WARN("[H] extend /his [holding.name] from [E]."),
				SPAN_NOTE("You extend your [holding.name] from [E].")
			)
	else //retract item
		if(ismob(holding.loc))
			var/mob/M = holding.loc
			M.drop_from_inventory(holding)
			M.visible_message(
				SPAN_WARN("[M] retract /his [holding.name] into [E]."),
				SPAN_NOTE("You retract your [holding.name] into [E].")
			)
		holding.forceMove(src)
