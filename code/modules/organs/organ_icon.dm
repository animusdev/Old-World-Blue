var/global/list/limb_icon_cache = list()

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
	if(status & ORGAN_ROBOT)
		return
	if(!isnull(human.s_tone) && (human.species.flags & HAS_SKIN_TONE))
		s_tone = human.s_tone
	if(human.species.flags & HAS_SKIN_COLOR)
		s_col = human.skin_color

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
	if(!owner || !owner.species)
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
		var/icon/lip_icon = new/icon(owner.species.icobase, "lips[owner.body_build.index]")
		lip_icon.Blend(owner.lip_color, ICON_ADD)
		mob_icon.Blend(lip_icon, ICON_OVERLAY)

	if(owner.f_style)
		var/datum/sprite_accessory/facial_hair_style = facial_hair_styles_list[owner.f_style]
		if(facial_hair_style && facial_hair_style.species_allowed && (owner.species.get_bodytype() in facial_hair_style.species_allowed))
			facial = new/icon(facial_hair_style.icon, facial_hair_style.icon_state)
			if(facial_hair_style.do_colouration)
				facial.Blend(owner.facial_color, ICON_ADD)
			overlays |= facial

	if(owner.h_style && !(owner.head && (owner.head.flags_inv & BLOCKHEADHAIR)))
		var/datum/sprite_accessory/hair_style = hair_styles_list[owner.h_style]
		if(hair_style && (owner.species.get_bodytype() in hair_style.species_allowed))
			hair = new/icon(hair_style.icon, hair_style.icon_state)
			if(hair_style.do_colouration)
				hair.Blend(owner.hair_color, ICON_ADD)
			overlays |= hair

	icon = mob_icon
	return mob_icon

/obj/item/organ/external/proc/get_icon_key()
	if(status & ORGAN_ROBOT)
		. = "2[model ? "-[model]": ""]"
	else if(status & ORGAN_MUTATED)
		. = "3"
	else if(status & ORGAN_DEAD)
		. = "4"
	else
		. = "1[tattoo][tattoo2]"

/obj/item/organ/external/proc/get_icon(var/skeletal)

	var/gender = "_f"
	var/body_build = ""
	if(owner)
		if(owner.gender == MALE)
			gender = "_m"
		body_build = owner.body_build.index

	icon_state = "[organ_tag][gendered ? gender : ""][body_build]"

	if(force_icon)
		mob_icon = new /icon(force_icon, icon_state)
	else
		if((status & ORGAN_ROBOT) && !(owner.species && owner.species.flags & IS_SYNTHETIC))
			mob_icon = new /icon('icons/mob/human_races/robotic.dmi', icon_state)
		else if(skeletal)
			mob_icon = new /icon('icons/mob/human_races/skeleton.dmi', icon_state)
		else
			if (status & ORGAN_MUTATED)
				mob_icon = new /icon(owner.species.deform, icon_state)
			else
				if(is_stump()) icon_state+="_s"
				mob_icon = new /icon(owner.species.icobase, icon_state)

			if(status & ORGAN_DEAD)
				mob_icon.ColorTone(rgb(10,50,0))
				mob_icon.SetIntensity(0.7)

			if(!isnull(s_tone))
				if(s_tone >= 0)
					mob_icon.Blend(rgb(s_tone, s_tone, s_tone), ICON_ADD)
				else
					mob_icon.Blend(rgb(-s_tone,  -s_tone,  -s_tone), ICON_SUBTRACT)
			else if(s_col)
				mob_icon.Blend(s_col, ICON_ADD)

			if(tattoo)
				mob_icon.Blend(new/icon('icons/mob/tattoo.dmi', "[organ_tag]_[tattoo][body_build]"), ICON_OVERLAY)
			if(tattoo2)
				mob_icon.Blend(new/icon('icons/mob/tattoo.dmi', "[organ_tag]2_[tattoo2][body_build]"), ICON_OVERLAY)

	dir = EAST
	icon = mob_icon

	return mob_icon

// new damage icon system
// adjusted to set damage_state to brute/burn code only (without r_name0 as before)
/obj/item/organ/external/update_icon()
	var/n_is = damage_state_text()
	if (n_is != damage_state)
		damage_state = n_is
		return 1
	return 0
