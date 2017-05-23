//Define basic code and subtypes

/obj/item/organ_module
	name = "embedded organ module"
	desc = "Embedded organ module."
	icon = 'icons/obj/surgery.dmi'
	var/list/allowed_organs = list() // Surgery. list of organ_tags. BP_R_ARM, BP_L_ARM, BP_HEAD, etc.

/obj/item/organ_module/proc/install(var/obj/item/organ/external/E)

/obj/item/organ_module/proc/remove(var/obj/item/organ/external/E)

/obj/item/organ_module/proc/organ_removed(var/obj/item/organ/external/E, var/mob/living/carbon/human/H)

/obj/item/organ_module/proc/organ_installed(var/obj/item/organ/external/E, var/mob/living/carbon/human/H)


//Toggleable embedded module

/obj/item/organ_module/active
	var/verb_name = "Activate"
	var/verb_desc = "activate embedded module"

/obj/item/organ_module/active/install(var/obj/item/organ/external/E)
	new /obj/item/organ/external/proc/activate_module(E, verb_name, verb_desc)

/obj/item/organ_module/active/remove(var/obj/item/organ/external/E)
	E.verbs -= /obj/item/organ/external/proc/activate_module

/obj/item/organ_module/active/organ_removed(obj/item/organ/external/E, mob/living/carbon/human/H)
	remove(E)

/obj/item/organ_module/active/organ_installed(obj/item/organ/external/E, mob/living/carbon/human/H)
	install(E)

/obj/item/organ_module/active/proc/can_activate(var/mob/living/carbon/human/H, var/obj/item/organ/external/E)
	if(H.sleeping || H.stunned || H.restrained())
		H << SPAN_WARN("You can't do that now!")
		return

	for(var/obj/item/weapon/implant/prosthesis_inhibition/I in H)
		if(I.malfunction)
			continue
		H << SPAN_WARN("[I] in your [I.part] prevent [src] activation!")
		return FALSE
	return TRUE

/obj/item/organ_module/active/proc/activate(var/mob/living/carbon/human/H, var/obj/item/organ/external/E)
/obj/item/organ_module/active/proc/deactivate(var/mob/living/carbon/human/H, var/obj/item/organ/external/E)


//Simple toggleabse module. Just put holding in hands or get it back

/obj/item/organ_module/active/simple
	var/obj/item/holding = null
	var/holding_type = null

/obj/item/organ_module/active/simple/New()
	..()
	if(holding_type)
		holding = new holding_type(src)
		holding.canremove = 0

/obj/item/organ_module/active/simple/proc/deploy(mob/living/carbon/human/H, obj/item/organ/external/E)
	var/slot = null
	if(E.organ_tag in list(BP_L_ARM, BP_L_HAND))
		slot = slot_l_hand
	else if(E.organ_tag in list(BP_R_ARM, BP_R_HAND))
		slot = slot_r_hand
	if(H.equip_to_slot_if_possible(holding, slot))
		H.visible_message(
			SPAN_WARN("[H] extend \his [holding.name] from [E]."),
			SPAN_NOTE("You extend your [holding.name] from [E].")
		)

/obj/item/organ_module/active/simple/proc/retract(mob/living/carbon/human/H, obj/item/organ/external/E)
	if(holding.loc == src)
		return

	if(ismob(holding.loc))
		var/mob/M = holding.loc
		M.drop_from_inventory(holding)
		M.visible_message(
			SPAN_WARN("[M] retract \his [holding.name] into [E]."),
			SPAN_NOTE("You retract your [holding.name] into [E].")
		)
	holding.forceMove(src)


/obj/item/organ_module/active/simple/activate(mob/living/carbon/human/H, obj/item/organ/external/E)
	if(!can_activate(H, E))
		return

	if(holding.loc == src) //item not in hands
		deploy(H, E)
	else //retract item
		retract(H, E)

/obj/item/organ_module/active/simple/deactivate(mob/living/carbon/human/H, obj/item/organ/external/E)
	retract(H, E)

/obj/item/organ_module/active/simple/organ_removed(var/obj/item/organ/external/E, var/mob/living/carbon/human/H)
	retract(H, E)

// Subtypes passive

/obj/item/organ_module/armor
	name = "subdermal armor"
	allowed_organs = list(BP_CHEST)
	icon_state = "armor-chest"

/obj/item/organ_module/armor/install(obj/item/organ/external/E)
	E.brute_mod -= 0.3

/obj/item/organ_module/armor/remove(obj/item/organ/external/E)
	E.brute_mod += 0.3


// Subtypes active

/obj/item/weapon/material/hatchet/tacknife/armblade
	icon_state = "armblade"
	item_state = null
	sprite_group = SPRITE_MELEE
	name = "armblade"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "armblade"
	applies_material_colour = 0

/*
There's an armblade instead of his hand.
There's an Armblade sticking out from his hand.
From his hand sticks out an armblade.
Instead of his hand there's an armblade.
*/

/obj/item/weapon/material/hatchet/tacknife/armblade/on_mob_description(mob/living/carbon/human/H, datum/gender/T, slot, slot_name)
	if(!slot in list(slot_l_hand, slot_r_hand))
		return ..()

	var/msg = "There's "
	var/end_part = "\a \icon[src] [src] sticking out from [T.his] [slot_name]"

	if(blood_DNA)
		msg = SPAN_WARN("[msg] [gender==PLURAL?"some":"a"] [(blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained [end_part]!")
	else
		msg += "[end_part]."
	return msg

/obj/item/weapon/material/hatchet/tacknife/armblade/claws
	icon_state = "wolverine"
	name = "claws"

/obj/item/organ_module/active/simple/wolverine
	name = "embed claws"
	verb_name = "Deploy embed claws"
	icon_state = "wolverine"
	allowed_organs = list(BP_R_HAND, BP_L_HAND)
	holding_type = /obj/item/weapon/material/hatchet/tacknife/armblade/claws

/obj/item/organ_module/active/simple/armblade
	name = "embed blade"
	verb_name = "Deploy embed blade"
	icon_state = "armblade"
	allowed_organs = list(BP_R_HAND, BP_L_HAND)
	holding_type = /obj/item/weapon/material/hatchet/tacknife/armblade

