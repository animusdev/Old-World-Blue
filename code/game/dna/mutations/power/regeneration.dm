/datum/mutation/power/regeneration
	id = "regeneration"
	affected_species = list(SPECIES_HUMAN)

/datum/mutation/power/regeneration/on_mob_life(var/mob/living/carbon/human/H)
	//first - check if we already begin organ generation
	var/obj/item/organ/external/organic/growing/E = locate() in H.organs
	if(E)
		if(E.left_time > 0)
			if(prob(30))
				E.left_time -= 1
		else
			var/datum/organ_description/OD = H.species.has_limbs[E.organ_tag]
			new OD.default_type(H, OD)
			qdel(E)
	else
		if(H.organs.len != H.organs_by_name.len)
			if(prob(20))
				var/tag
				for(tag in H.species.has_limbs)
					if(!H.get_organ(tag))
						var/datum/organ_description/OD = H.species.has_limbs[tag]
						new /obj/item/organ/external/organic/growing(H, OD)

/obj/item/organ/external/organic/growing
	var/left_time = 100
/*
/obj/item/organ/external/organic/growing/can_use()
	return 0
*/
