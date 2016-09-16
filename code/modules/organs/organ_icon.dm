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
	s_col = "#000000"
	if(status & ORGAN_ROBOT)
		return
	if(!isnull(human.s_tone) && (human.species.flags & HAS_SKIN_TONE))
		s_tone = human.s_tone
	if(human.species.flags & HAS_SKIN_COLOR)
		s_col = human.skin_color

/obj/item/organ/external/head/sync_colour_to_human(var/mob/living/carbon/human/human)
	..()
	var/obj/item/organ/internal/eyes/eyes = owner.internal_organs_by_name["eyes"]
	if(eyes) eyes.update_colour()

/obj/item/organ/external/head
	var/icon/hair_s
	var/icon/facial_s

/obj/item/organ/external/head/removed(user, delete_children)
	get_icon()
	mob_icon.Blend(hair_s, ICON_OVERLAY)
	mob_icon.Blend(facial_s, ICON_OVERLAY)
	icon = mob_icon
	..()

/obj/item/organ/external/head/get_icon()

	..()
	overlays.Cut()
	if(!owner || !owner.species)
		return
	if(owner.species.has_organ["eyes"])
		var/obj/item/organ/internal/eyes/eyes = owner.internal_organs_by_name["eyes"]
		var/icon/eyes_icon
		if(eyes)
			eyes_icon = eyes.get_icon()
		else
			eyes_icon = new/icon(owner.species.icobase, "eyes_[owner.body_build]")
			eyes_icon.Blend(rgb(128,0,0), ICON_ADD)

		mob_icon.Blend(eyes_icon, ICON_OVERLAY)
		overlays |= eyes_icon

	if(owner.lip_color && (owner.species.flags & HAS_LIPS))
		var/icon/lip_icon = new/icon(owner.species.icobase, "lips_[owner.body_build]")
		lip_icon.Blend(owner.lip_color, ICON_ADD)
		overlays |= lip_icon
		mob_icon.Blend(lip_icon, ICON_OVERLAY)

	if(owner.f_style)
		var/datum/sprite_accessory/facial_hair_style = facial_hair_styles_list[owner.f_style]
		if(facial_hair_style && facial_hair_style.species_allowed && (owner.species.get_bodytype() in facial_hair_style.species_allowed))
			facial_s = new/icon("icon" = facial_hair_style.icon, "icon_state" = facial_hair_style.icon_state)
			if(facial_hair_style.do_colouration)
				facial_s.Blend(owner.facial_color, ICON_ADD)
			overlays |= facial_s

	if(owner.h_style && !(owner.head && (owner.head.flags & BLOCKHEADHAIR)))
		var/datum/sprite_accessory/hair_style = hair_styles_list[owner.h_style]
		if(hair_style && (owner.species.get_bodytype() in hair_style.species_allowed))
			hair_s = new/icon("icon" = hair_style.icon, "icon_state" = hair_style.icon_state)
			if(hair_style.do_colouration)
				hair_s.Blend(owner.hair_color, ICON_ADD)
			overlays |= hair_s

	icon = mob_icon
	return mob_icon

/obj/item/organ/external/proc/get_icon(var/skeletal)

	var/body_build = owner ? (owner.body_build) : 0
	var/gender = (owner.gender == FEMALE)?"f":"m"
	icon_state = "[limb_name]_[gendered ? gender : ""][body_build]"

	if(force_icon)
		mob_icon = new /icon(force_icon, icon_state)
	else
		if((status & ORGAN_ROBOT) && !(owner.species && owner.species.flags & IS_SYNTHETIC))
			mob_icon = new /icon('icons/mob/human_races/robotic.dmi', icon_state)
		else if(skeletal)
			mob_icon = new /icon('icons/mob/human_races/r_skeleton.dmi', icon_state)
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
				mob_icon.Blend(new/icon('icons/mob/tattoo.dmi', "[limb_name]_[tattoo]_[body_build]"), ICON_OVERLAY)
			if(tattoo2)
				mob_icon.Blend(new/icon('icons/mob/tattoo.dmi', "[limb_name]2_[tattoo2]_[body_build]"), ICON_OVERLAY)

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
