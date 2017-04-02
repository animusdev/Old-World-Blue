/proc/spawn_diona_nymph(var/turf/target)
	if(!istype(target))
		return 0

	//This is a terrible hack and I should be ashamed.
	var/datum/seed/diona = plant_controller.seeds["diona"]
	if(!diona)
		return 0

	spawn(1) // So it has time to be thrown about by the gib() proc.
		var/mob/living/carbon/alien/diona/D = new(target)
		diona.request_player(D)
		spawn(60)
			if(D)
				if(!D.ckey || !D.client)
					D.death()
		return 1

/obj/item/organ/external/diona
	name = "tendril"
	cannot_break = 1
	amputation_point = "branch"
	joint = "structural ligament"
	dislocated = -1

//DIONA ORGANS.
/obj/item/organ/external/diona/removed()
	if(robotic >= ORGAN_ROBOT)
		return ..()
	var/mob/living/carbon/human/H = owner
	..()
	if(!istype(H) || !H.organs || !H.organs.len)
		H.death()
	if(prob(50) && spawn_diona_nymph(get_turf(src)))
		qdel(src)


////DIONA////
/datum/organ_description/chest/diona
	name = "core trunk"
	amputation_point = "branch"
	joint = "structural ligament"
	min_broken_damage = 50
	default_type = /obj/item/organ/external/diona

/datum/organ_description/groin/diona
	vital = 0
	name = "fork"
	min_broken_damage = 50
	default_type = /obj/item/organ/external/diona

/datum/organ_description/head/diona
	vital = 0
	default_type = /obj/item/organ/external/diona
	min_broken_damage = 25

/datum/organ_description/arm/left/diona
	name = "left upper tendril"
	min_broken_damage = 20
	default_type = /obj/item/organ/external/diona

/datum/organ_description/arm/right/diona
	name = "right upper tendril"
	min_broken_damage = 20
	default_type = /obj/item/organ/external/diona

/datum/organ_description/leg/left/diona
	name = "left lower tendril"
	min_broken_damage = 20
	default_type = /obj/item/organ/external/diona

/datum/organ_description/leg/right/diona
	name = "right lower tendril"
	min_broken_damage = 20
	default_type = /obj/item/organ/external/diona

/datum/organ_description/hand/left/diona
	name = "left grasper"
	min_broken_damage = 10
	w_class = 2
	default_type = /obj/item/organ/external/diona

/datum/organ_description/hand/right/diona
	name = "right grasper"
	min_broken_damage = 10
	w_class = 2
	default_type = /obj/item/organ/external/diona

/datum/organ_description/foot/left/diona
	min_broken_damage = 10
	w_class = 2
	default_type = /obj/item/organ/external/diona

/datum/organ_description/foot/right/diona
	min_broken_damage = 10
	w_class = 2
	default_type = /obj/item/organ/external/diona


/obj/item/organ/internal/diona
	name = "diona nymph"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"
	organ_tag = "special" // Turns into a nymph instantly, no transplanting possible.

/obj/item/organ/internal/diona/removed(var/mob/living/user, var/skip_nymph)
	if(robotic >= ORGAN_ROBOT)
		return ..()
	var/mob/living/carbon/human/H = owner
	..()
	if(!istype(H) || !H.organs || !H.organs.len)
		H.death()
	if(prob(50) && !skip_nymph && spawn_diona_nymph(get_turf(src)))
		qdel(src)

/obj/item/organ/internal/diona/process()
	return

/obj/item/organ/internal/diona/strata
	name = "neural strata"
	organ_tag = O_STRATA
	parent_organ = BP_CHEST

/obj/item/organ/internal/diona/bladder
	name = "gas bladder"
	organ_tag = O_GBLADDER
	parent_organ = BP_HEAD

/obj/item/organ/internal/diona/polyp
	name = "polyp segment"
	organ_tag = O_POLYP
	parent_organ = BP_GROIN

/obj/item/organ/internal/diona/ligament
	name = "anchoring ligament"
	organ_tag = O_ANCHOR
	parent_organ = BP_GROIN

// These are different to the standard diona organs as they have a purpose in other
// species (absorbing radiation and light respectively)
/obj/item/organ/internal/nutrients
	name = O_NUTRIENT
	parent_organ = BP_CHEST
	organ_tag = O_NUTRIENT
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"

/obj/item/organ/internal/node
	name = "response node"
	parent_organ = BP_HEAD
	organ_tag = O_RESPONSE
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"
