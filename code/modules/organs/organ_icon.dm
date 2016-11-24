/obj/item/organ/external/set_dir()
	return

/obj/item/organ/external/proc/compile_icon()
	overlays.Cut()
	 // This is a kludge, only one icon has more than one generation of children though.
	for(var/obj/item/organ/external/organ in contents)
		if(organ.children && organ.children.len)
			for(var/obj/item/organ/external/child in organ.children)
				overlays += child.mob_icon
		overlays += organ.mob_icon

/obj/item/organ/external/proc/sync_colour_to_human(var/mob/living/carbon/human/human)
	s_tone = null
	s_col = null
	if(robotic >= ORGAN_ROBOT)
		return
	if(species && human.species && species.name != human.species.name)
		return
	if(!isnull(human.s_tone) && (human.species.flags & HAS_SKIN_TONE))
		s_tone = human.s_tone
	if(human.species.flags & HAS_SKIN_COLOR)
		s_col = human.skin_color

/obj/item/organ/external/proc/sync_colour_to_dna()
	s_tone = null
	s_col = null
	if(robotic >= ORGAN_ROBOT)
		return
	if(!isnull(dna.GetUIValue(DNA_UI_SKIN_TONE)) && (species.flags & HAS_SKIN_TONE))
		s_tone = dna.GetUIValue(DNA_UI_SKIN_TONE)
	if(species.flags & HAS_SKIN_COLOR)
		s_col = rgb(dna.GetUIValue(DNA_UI_SKIN_R), dna.GetUIValue(DNA_UI_SKIN_G), dna.GetUIValue(DNA_UI_SKIN_B))

/obj/item/organ/external/head/sync_colour_to_human(var/mob/living/carbon/human/human)
	..()
	var/obj/item/organ/internal/eyes/eyes = owner.internal_organs_by_name[O_EYES]
	if(eyes) eyes.update_colour()

/obj/item/organ/external/head
	var/icon/hair
	var/icon/facial

/obj/item/organ/external/head/removed(user, delete_children)
	get_icon()
	if(hair)   mob_icon.Blend(hair, ICON_OVERLAY)
	if(facial) mob_icon.Blend(facial, ICON_OVERLAY)
	icon = mob_icon
	..()

/obj/item/organ/external/head/get_icon()

	..()
	overlays.Cut()
	if(!owner || !owner.species || !owner.body_build)
		return
	if(owner.should_have_organ(O_EYES))
		var/obj/item/organ/internal/eyes/eyes = owner.internal_organs_by_name[O_EYES]
		var/icon/eyes_icon
		if(eyes)
			eyes_icon = eyes.get_icon()
		else
			eyes_icon = new/icon(owner.species.icobase, "eyes[owner.body_build.index]")
			eyes_icon.Blend(rgb(128,0,0), ICON_ADD)

		mob_icon.Blend(eyes_icon, ICON_OVERLAY)

	if(owner.lip_color && (owner.species.flags & HAS_LIPS))
		var/icon/lip_icon = new/icon(species.icobase, "lips[owner.body_build.index]")
		lip_icon.Blend(owner.lip_color, ICON_ADD)
		mob_icon.Blend(lip_icon, ICON_OVERLAY)

	if(owner.f_style)
		var/datum/sprite_accessory/facial_hair_style = facial_hair_styles_list[owner.f_style]
		if(facial_hair_style && facial_hair_style.species_allowed && (species.get_bodytype() in facial_hair_style.species_allowed))
			facial = new/icon(facial_hair_style.icon, facial_hair_style.icon_state)
			if(facial_hair_style.do_colouration)
				facial.Blend(owner.facial_color, ICON_ADD)
			overlays |= facial

	if(owner.h_style && !(owner.head && (owner.head.flags_inv & BLOCKHEADHAIR)))
		var/datum/sprite_accessory/hair_style = hair_styles_list[owner.h_style]
		if(hair_style && (species.get_bodytype() in hair_style.species_allowed))
			hair = new/icon(hair_style.icon, hair_style.icon_state)
			if(hair_style.do_colouration)
				hair.Blend(owner.hair_color, ICON_ADD)
			overlays |= hair

	icon = mob_icon
	return mob_icon

/obj/item/organ/external/proc/get_icon_key()
	if(robotic >= ORGAN_ROBOT)
		. = "2[model ? "-[model]": ""]"
	else if(status & ORGAN_MUTATED)
		. = "3"
	else if(status & ORGAN_DEAD)
		. = "4"
	else
		. = "1"
	. += "[species.race_key][dna.GetUIState(DNA_UI_GENDER)][dna.GetUIValue(DNA_UI_SKIN_TONE)]"

/obj/item/organ/external/proc/get_icon(var/skeletal)

	var/gender = "_f"
	var/body_build = ""
	if(owner)
		if(owner.gender == MALE)
			gender = "_m"
		body_build = owner.body_build.index

	icon_state = "[organ_tag][gendered_icon ? gender : ""][body_build]"

	if(force_icon)
		mob_icon = new /icon(force_icon, icon_state)
	else
		if(!dna)
			mob_icon = new /icon('icons/mob/human_races/human.dmi', icon_state)
		else

			if(!gendered_icon)
				gender = null
			else
				if(dna.GetUIState(DNA_UI_GENDER))
					gender = "f"
				else
					gender = "m"

			if(skeletal)
				mob_icon = new /icon('icons/mob/human_races/skeleton.dmi', icon_state)
			else if (robotic >= ORGAN_ROBOT)
				mob_icon = new /icon('icons/mob/human_races/robotic.dmi', icon_state)
			else
				if(is_stump()) icon_state += "_s"
				mob_icon = new /icon(owner.species.icobase, icon_state)
				apply_colouration(mob_icon)
				if(tattoo)
					mob_icon.Blend(new/icon('icons/mob/tattoo.dmi', "[organ_tag]_[tattoo][body_build]"), ICON_OVERLAY)
				if(tattoo2)
					mob_icon.Blend(new/icon('icons/mob/tattoo.dmi', "[organ_tag]2_[tattoo2][body_build]"), ICON_OVERLAY)

	dir = EAST
	icon = mob_icon
	return mob_icon

/obj/item/organ/external/proc/apply_colouration(var/icon/applying)

	if(status & ORGAN_DEAD)
		applying.ColorTone(rgb(10,50,0))
		applying.SetIntensity(0.7)

	if(!isnull(s_tone))
		if(s_tone >= 0)
			applying.Blend(rgb(s_tone, s_tone, s_tone), ICON_ADD)
		else
			applying.Blend(rgb(-s_tone,  -s_tone,  -s_tone), ICON_SUBTRACT)
	else if(s_col)
		applying.Blend(s_col, ICON_ADD)


	return applying


// new damage icon system
// adjusted to set damage_state to brute/burn code only (without r_name0 as before)
/obj/item/organ/external/update_icon()
	var/n_is = damage_state_text()
	if (n_is != damage_state)
		damage_state = n_is
		return 1
	return 0
