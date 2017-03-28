/mob/living/carbon/human/proc/change_appearance(var/flags = APPEARANCE_ALL_HAIR, var/location = src, var/mob/user = src, var/check_species_whitelist = 1, var/list/species_whitelist = list(), var/list/species_blacklist = list(), var/datum/topic_state/state = default_state)
	var/obj/nano_module/appearance_changer/AC = new(location, src, check_species_whitelist, species_whitelist, species_blacklist)
	AC.flags = flags
	AC.ui_interact(user, state = state)

/mob/living/carbon/human/proc/change_species(var/new_species)
	if(!new_species)
		return

	if(species == new_species)
		return

	if(!(new_species in all_species))
		return

	set_species(new_species)
	reset_hair()
	return 1

/mob/living/carbon/human/proc/change_gender(var/gender)
	if(src.gender == gender)
		return

	src.gender = gender
	reset_hair()
	fix_body_build()
	force_update_limbs()
	update_body()
	update_dna()
	return 1

/mob/living/carbon/human/proc/change_body_build(var/prefered = "Default")
	body_build = species.get_body_build(gender, prefered)
	fix_body_build()
	force_update_limbs()
	update_body()
	regenerate_icons()
	update_dna()

	return 1

/mob/living/carbon/human/proc/change_hair(var/hair_style)
	if(!hair_style)
		return

	if(h_style == hair_style)
		return

	if(!(hair_style in hair_styles_list))
		return

	h_style = hair_style

	update_hair()
	return 1

/mob/living/carbon/human/proc/change_facial_hair(var/facial_hair_style)
	if(!facial_hair_style)
		return

	if(f_style == facial_hair_style)
		return

	if(!facial_hair_style in facial_hair_styles_list)
		return

	f_style = facial_hair_style

	update_hair()
	return 1

/mob/living/carbon/human/proc/reset_hair()
	h_style = pick(get_hair_styles_list(species.get_bodytype(), gender))
	f_style = pick(get_facial_styles_list(species.get_bodytype(), gender))

	update_hair()

/mob/living/carbon/human/proc/change_eye_color(var/new_color)
	if(eyes_color == new_color)
		return

	eyes_color = new_color

	update_eyes()
	update_body()
	return 1

/*/mob/living/carbon/human/proc/change_lips_color(var/new_color)
	if(new_color == lips_color)
		return

	lips_color = new_color

	update_body()
	return 1*/

/mob/living/carbon/human/proc/change_hair_color(var/new_color)
	if(hair_color == new_color)
		return

	hair_color = new_color
	update_hair()
	return 1

/mob/living/carbon/human/proc/change_facial_hair_color(var/new_color)
	if(facial_color == new_color)
		return

	facial_color = new_color

	update_hair()
	return 1

/mob/living/carbon/human/proc/change_skin_color(var/new_color)
	if(new_color == skin_color || !(species.flags & HAS_SKIN_COLOR))
		return

	skin_color = new_color

	force_update_limbs()
	update_body()
	return 1

/mob/living/carbon/human/proc/change_skin_tone(var/tone)
	if(s_tone == tone || !(species.flags & HAS_SKIN_TONE))
		return

	s_tone = tone

	force_update_limbs()
	update_body()
	return 1

/mob/living/carbon/human/proc/update_dna()
	check_dna()
	dna.ready_dna(src)

/mob/living/carbon/human/proc/generate_valid_species(var/check_whitelist = 1, var/list/whitelist = list(), var/list/blacklist = list())
	var/list/valid_species = new()
	var/possible_species = (whitelist && whitelist.len) ? whitelist : all_species - blacklist

	for(var/current_species_name in possible_species)
		var/datum/species/current_species = all_species[current_species_name]
		if(!check_rights(R_ADMIN, 0, src)) //If we're using the whitelist, make sure to check it!
			if(!(current_species.flags & CAN_JOIN))
				continue
			if(check_whitelist && config.usealienwhitelist && (current_species.flags & IS_WHITELISTED) && !is_alien_whitelisted(src, current_species_name))
				continue

		valid_species += current_species_name

	return valid_species

/mob/living/carbon/human/proc/force_update_limbs()
	for(var/obj/item/organ/external/O in organs)
		O.sync_to_owner()
	update_body(0)
