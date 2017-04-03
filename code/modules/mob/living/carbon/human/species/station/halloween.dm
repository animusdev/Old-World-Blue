/datum/species/human/cursed
	name = "Cursed huamn"
	name_plural = "Humans"
	language = "Sol Common"
	primitive_form = ""
	flags = HAS_SKIN_TONE | HAS_LIPS | HAS_UNDERWEAR | HAS_EYE_COLOR | IS_RESTRICTED

/datum/species/human/cursed/get_bodytype()
	return "Human"

/datum/species/human/cursed/handle_environment_special(var/mob/living/carbon/human/H)
	var/is_skeleton = (SKELETON & H.status_flags)
	var/light_amount = 0
	if(isturf(H.loc))
		var/turf/T = H.loc
		var/atom/movable/lighting_overlay/L = locate(/atom/movable/lighting_overlay) in T
		if(L)
			light_amount = L.lum_r + L.lum_g + L.lum_b //hardcapped so it's not abused by having a ton of flashlights
		else
			light_amount =  10
	if(light_amount > 0.9)
		if(is_skeleton)
			H.status_flags ^= SKELETON
			H.update_hair(0)
			H.update_body()
	else
		if(!is_skeleton)
			H.status_flags ^= SKELETON
			H.update_hair(0)
			H.update_body()


/datum/species/human/vampire
	name = "Vampire"
	name_plural = "Vampires"
	burn_mod = 1.3
	reagent_tag = IS_VAMPIRE
	rarity_value = 3

	flags = HAS_SKIN_TONE | HAS_LIPS | HAS_UNDERWEAR | HAS_EYE_COLOR | IS_RESTRICTED

	inherent_verbs = list(
		/mob/living/carbon/human/proc/drink_blood
	)

/datum/species/human/vampire/get_bodytype()
	return "Human"

/datum/species/human/vampire/equip_survival_gear(mob/living/carbon/human/H)
	var/pack_type = pick(
		/obj/item/weapon/reagent_containers/blood/APlus,
		/obj/item/weapon/reagent_containers/blood/AMinus,
		/obj/item/weapon/reagent_containers/blood/BPlus,
		/obj/item/weapon/reagent_containers/blood/BMinus,
		/obj/item/weapon/reagent_containers/blood/OPlus,
		/obj/item/weapon/reagent_containers/blood/OMinus)

	if(H.back && istype(H.back,/obj/item/weapon/storage))
		H.equip_to_slot_or_del(new pack_type(H.back), slot_in_backpack)
	else
		H.equip_to_slot_or_del(new pack_type(H), slot_r_hand)

/mob/living/carbon/human/proc/drink_blood()
	set category = "Abilities"
	set name = "Drink blood"
	set desc = "Drink someone blood."

	var/obj/item/weapon/grab/G = src.get_active_hand()
	if(!istype(G))
		src << "<span class='warning'>We must be grabbing a creature in our active hand to absorb them.</span>"
		return

	var/mob/living/carbon/human/H = G.affecting

	if(!istype(H) || H.isSynthetic() || HUSK & status_flags)
		src << "<span class='warning'>\The [H] is not compatible with our biology.</span>"
		return

	if(G.state < GRAB_NECK)
		src << "<span class='warning'>We must have a tighter grip to drink this creature blood.</span>"
		return

	var/list/applayable_organs = list()
	applayable_organs["Neck"] = BP_HEAD
	applayable_organs["Left wrist"] = BP_L_HAND
	applayable_organs["Right wrist"] = BP_R_HAND

	if(!applayable_organs.len)
		src << "<span class='warning'>We can't feed from this creature.</span>"
		return

	var/body_part = input(src, "Select organ for bitten", "Where we gonna bite?") as null|anything in applayable_organs
	if(!body_part)
		return

	if(!can_inject(src, applayable_organs[body_part]))
		return

	src.visible_message(
		"<span class='dangerous'>[src] sank \his teeth into [H] [body_part]!</span>",
		"<span class='warning'>We sank our teeth into [H] [body_part].</span>",
		"<span class='dangerous'>You can hear </span>"
	)

	var/obj/item/organ/external/E = H.get_organ(applayable_organs[body_part])
	E.status |= ORGAN_BLEEDING

	var/blood_state

	while((G in list(l_hand, r_hand)) && (G.state >= GRAB_NECK) && E && (E.status & ORGAN_BLEEDING))
		switch(H.vessel.get_reagent_amount("blood")/H.species.blood_volume)
			if(BLOOD_VOLUME_SAFE/100 to 1)
				if(!blood_state)
					blood_state = BLOOD_VOLUME_SAFE
					src << "<span class='notice'>[H] is full of life essence.</span>"
			if(BLOOD_VOLUME_OKAY/100 to BLOOD_VOLUME_SAFE/100)
				if(blood_state != BLOOD_VOLUME_OKAY)
					blood_state = BLOOD_VOLUME_OKAY
					src << "<span class='warning'>[H] will be okay with that blood amount.</span>"
			if(BLOOD_VOLUME_BAD/100 to BLOOD_VOLUME_OKAY/100)
				if(blood_state != BLOOD_VOLUME_BAD)
					blood_state = BLOOD_VOLUME_BAD
					src << "<span class='warning'>[H] definitely get worse!</span>"
			if(BLOOD_VOLUME_SURVIVE/100 to BLOOD_VOLUME_BAD/100)
				if(blood_state != BLOOD_VOLUME_SURVIVE)
					blood_state = BLOOD_VOLUME_SURVIVE
					src << "<span class='warning'>[H] can die any moment now!</span>"
			else
				src << "<span class='dangerous'>[H] don't have anough blood for feed us.</span>"
				break
		H.vessel.trans_to_mob(src, 10, CHEM_INGEST)
		sleep(40)

	src.visible_message(
		"<span class='warning'>[src] released [H] [body_part].</span>",
		"<span class='notice'>We stop dringing [H] blood.</span>"
	)
	if(G)
		qdel(G)

/*
/datum/species/human/werewolf
	name = "Werewolf"
	name_plural = "Werewolfs"
	siemens_coefficient = 0.8
	rarity_value = 3
	gluttonous = 2
*/