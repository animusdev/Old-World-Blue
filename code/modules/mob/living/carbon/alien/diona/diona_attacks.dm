/mob/living/carbon/alien/diona/attack_hand(mob/living/carbon/human/M as mob)
	if(istype(M) && M.a_intent == I_HELP)
		if(M.species && M.species.name == SPECIES_DIONA && do_merge(M))
			return
		get_scooped(M)
		return
	..()