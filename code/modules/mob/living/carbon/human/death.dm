/mob/living/carbon/human/gib()

	for(var/obj/item/organ/internal/I in internal_organs)
		I.removed()
		if(istype(loc,/turf))
			I.throw_at(get_edge_target_turf(src,pick(alldirs)),rand(1,3),30)

	for(var/obj/item/organ/external/E in src.organs)
		E.droplimb(0,DROPLIMB_EDGE,1)

	sleep(1)

	for(var/obj/item/I in src)
		drop_from_inventory(I)
		I.throw_at(get_edge_target_turf(src,pick(alldirs)), rand(1,3), round(30/I.w_class))

	..(species.gibbed_anim)
	gibs(loc, dna, null, get_flesh_colour(), get_blood_colour())

/mob/living/carbon/human/dust()
	if(species)
		..(species.dusted_anim, species.remains_type)
	else
		..()

/mob/living/carbon/human/death(gibbed)

	if(stat == DEAD) return

	BITSET(hud_updateflag, HEALTH_HUD)
	BITSET(hud_updateflag, STATUS_HUD)
	BITSET(hud_updateflag, LIFE_HUD)

	handle_hud_list()

	//Handle species-specific deaths.
	species.handle_death(src)
	animate_tail_stop()

	//Handle brain slugs.
	var/obj/item/organ/external/head = get_organ(BP_HEAD)
	if(head)
		var/mob/living/simple_animal/borer/B = locate() in head.implants
		if(B)
			if(!B.ckey && ckey && B.controlling)
				B.ckey = ckey
				B.controlling = 0
			if(B.host_brain && B.host_brain.ckey)
				ckey = B.host_brain.ckey
				B.host_brain.ckey = null
				B.host_brain.name = "host brain"
				B.host_brain.real_name = "host brain"

			verbs -= /mob/living/carbon/proc/release_control

	callHook("death", list(src, gibbed))

	if(!gibbed && species.death_sound)
		playsound(loc, species.death_sound, 80, 1, 1)

	if(ticker && ticker.mode)
		ticker.mode.check_win()

	return ..(gibbed,get_death_message())

/mob/living/carbon/human/proc/ChangeToHusk()
	if(HUSK & status_flags)	return

	if(f_style)
		f_style = "Shaved"		//we only change the icon_state of the hair datum, so it doesn't mess up their UI/UE
	if(h_style)
		h_style = "Bald"
	update_hair(0)

	status_flags |= DISFIGURED|HUSK	//makes them unknown without fucking up other stuff like admintools
	update_body(1)
	return

/mob/living/carbon/human/proc/Drain()
	ChangeToHusk()
	return

/mob/living/carbon/human/proc/ChangeToSkeleton()
	if(SKELETON & status_flags)	return

	if(f_style)
		f_style = "Shaved"
	if(h_style)
		h_style = "Bald"
	update_hair(0)

	status_flags |= DISFIGURED|SKELETON
	update_body(0)
	return
