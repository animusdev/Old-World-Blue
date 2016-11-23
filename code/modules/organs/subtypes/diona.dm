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

/obj/item/organ/external/diona/chest
	name = "core trunk"
	organ_tag = BP_CHEST
	max_damage = 200
	min_broken_damage = 50
	w_class = 5
	body_part = UPPER_TORSO
	vital = 1
	cannot_amputate = 1
	parent_organ = null
	gendered_icon = 1

/obj/item/organ/external/diona/head
	max_damage = 50
	min_broken_damage = 25

/obj/item/organ/external/diona/groin
	name = "fork"
	organ_tag = BP_GROIN
	max_damage = 100
	min_broken_damage = 50
	w_class = 4
	body_part = LOWER_TORSO
	parent_organ = BP_CHEST
	gendered_icon = 1

/obj/item/organ/external/diona/limb
	max_damage = 35
	min_broken_damage = 20
	w_class = 3

/obj/item/organ/external/diona/tiny
	max_damage = 20
	min_broken_damage = 10
	w_class = 2

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
	organ_tag = O_NUTRIENT
	parent_organ = BP_HEAD
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"

/obj/item/organ/internal/node
	name = "receptor node"
	organ_tag = O_RESPONSE
	parent_organ = BP_HEAD
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"

