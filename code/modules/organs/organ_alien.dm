/proc/spawn_diona_nymph_from_organ(var/obj/item/organ/organ)
	if(!istype(organ))
		return 0

	//This is a terrible hack and I should be ashamed.
	var/datum/seed/diona = plant_controller.seeds["diona"]
	if(!diona)
		return 0

	spawn(1) // So it has time to be thrown about by the gib() proc.
		var/mob/living/carbon/alien/diona/D = new(get_turf(organ))
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
	limb_name = "chest"
	health = 200
	min_broken_damage = 50
	body_part = UPPER_TORSO
	vital = 1
	gendered = 1
	cannot_amputate = 1
	parent_organ = null

/obj/item/organ/external/diona/groin
	name = "fork"
	limb_name = "groin"
	gendered = 1
	health = 100
	min_broken_damage = 50
	body_part = LOWER_TORSO
	parent_organ = "chest"

/obj/item/organ/external/diona/limb
	health = 35
	min_broken_damage = 20

/obj/item/organ/external/diona/foot
	health = 20
	min_broken_damage = 10

/obj/item/organ/external/diona/hand
	health = 30
	min_broken_damage = 15

/obj/item/organ/external/diona/head
	limb_name = "head"
	name = "head"
	gendered = 1
	health = 50
	min_broken_damage = 25
	body_part = HEAD
	parent_organ = "chest"

//DIONA ORGANS.
/obj/item/organ/external/diona/removed()
	var/mob/living/carbon/human/H = owner
	..()
	if(!istype(H) || !H.organs || !H.organs.len)
		H.death()
	if(prob(50) && spawn_diona_nymph_from_organ(src))
		qdel(src)

/obj/item/organ/internal/diona/process()
	return

/obj/item/organ/internal/diona/strata
	name = "neural strata"
	organ_tag = "strata"
	parent_organ = "chest"

/obj/item/organ/internal/diona/bladder
	name = "gas bladder"
	organ_tag = "bladder"
	parent_organ = "head"

/obj/item/organ/internal/diona/polyp
	name = "polyp segment"
	organ_tag = "polyp"
	parent_organ = "groin"

/obj/item/organ/internal/diona/ligament
	name = "anchoring ligament"
	organ_tag = "ligament"
	parent_organ = "groin"

/obj/item/organ/internal/diona
	name = "diona nymph"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"
	organ_tag = "special" // Turns into a nymph instantly, no transplanting possible.

/obj/item/organ/internal/diona/removed(var/mob/living/user)
	var/mob/living/carbon/human/H = owner
	..()
	if(!istype(H) || !H.organs || !H.organs.len)
		H.death()
	if(prob(50) && spawn_diona_nymph_from_organ(src))
		qdel(src)

// These are different to the standard diona organs as they have a purpose in other
// species (absorbing radiation and light respectively)
/obj/item/organ/internal/nutrients
	name = "nutrient vessel"
	organ_tag = "nutrient vessel"
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"

/obj/item/organ/internal/node
	name = "receptor node"
	organ_tag = "receptor node"
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"

//CORTICAL BORER ORGANS.
/obj/item/organ/internal/borer
	name = "cortical borer"
	parent_organ = "head"
	vital = 1

/obj/item/organ/internal/borer/process()

	// Borer husks regenerate health, feel no pain, and are resistant to stuns and brainloss.
	for(var/chem in list("tricordrazine","tramadol","hyperzine","alkysine"))
		if(owner.reagents.get_reagent_amount(chem) < 3)
			owner.reagents.add_reagent(chem, 5)

	// They're also super gross and ooze ichor.
	if(prob(5))
		var/mob/living/carbon/human/H = owner
		if(!istype(H))
			return

		var/datum/reagent/blood/B = locate(/datum/reagent/blood) in H.vessel.reagent_list
		blood_splatter(H,B,1)
		var/obj/effect/decal/cleanable/blood/splatter/goo = locate() in get_turf(owner)
		if(goo)
			goo.name = "husk ichor"
			goo.desc = "It's thick and stinks of decay."
			goo.basecolor = "#412464"
			goo.update_icon()

/obj/item/organ/internal/borer
	name = "cortical borer"
	icon = 'icons/obj/objects.dmi'
	icon_state = "borer"
	organ_tag = "brain"
	desc = "A disgusting space slug."

/obj/item/organ/internal/borer/removed(var/mob/living/user)

	..()

	var/mob/living/simple_animal/borer/B = owner.has_brain_worms()
	if(B)
		B.leave_host()
		B.ckey = owner.ckey

	spawn(0)
		qdel(src)

//XENOMORPH ORGANS
/obj/item/organ/internal/xenos
	name = "xeno organ"
	icon = 'icons/effects/blood.dmi'
	desc = "It smells like an accident in a chemical factory."

/obj/item/organ/internal/xenos/eggsac
	name = "egg sac"
	parent_organ = "groin"
	icon_state = "xgibmid1"
	organ_tag = "egg sac"

/obj/item/organ/internal/xenos/plasmavessel
	name = "plasma vessel"
	parent_organ = "chest"
	icon_state = "xgibdown1"
	organ_tag = "plasma vessel"
	var/stored_plasma = 0
	var/max_plasma = 500

/obj/item/organ/internal/xenos/plasmavessel/queen
	name = "bloated plasma vessel"
	stored_plasma = 200
	max_plasma = 500

/obj/item/organ/internal/xenos/plasmavessel/sentinel
	stored_plasma = 100
	max_plasma = 250

/obj/item/organ/internal/xenos/plasmavessel/hunter
	name = "tiny plasma vessel"
	stored_plasma = 100
	max_plasma = 150

/obj/item/organ/internal/xenos/acidgland
	name = "acid gland"
	parent_organ = "head"
	icon_state = "xgibtorso"
	organ_tag = "acid gland"

/obj/item/organ/internal/xenos/hivenode
	name = "hive node"
	parent_organ = "chest"
	icon_state = "xgibmid2"
	organ_tag = "hive node"

/obj/item/organ/internal/xenos/resinspinner
	name = "resin spinner"
	parent_organ = "head"
	icon_state = "xgibmid2"
	organ_tag = "resin spinner"

//VOX ORGANS.
/obj/item/organ/internal/stack
	name = "cortical stack"
	parent_organ = "head"
	robotic = 2
	vital = 1
	var/backup_time = 0
	var/datum/mind/backup

/obj/item/organ/internal/stack/process()
	if(owner && owner.stat != 2 && !is_broken())
		backup_time = world.time
		if(owner.mind) backup = owner.mind

/obj/item/organ/internal/stack/vox

/obj/item/organ/internal/stack
	name = "cortical stack"
	icon_state = "brain-prosthetic"
	organ_tag = "stack"
	robotic = 2

/obj/item/organ/internal/stack/vox
	name = "vox cortical stack"

// Slime limbs.
/obj/item/organ/external/chest/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/groin/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/limb/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/tiny/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/head/slime
	cannot_break = 1
	dislocated = -1
