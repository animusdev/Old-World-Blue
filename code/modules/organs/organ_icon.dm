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

/obj/item/organ/external/sync_to_owner()
	for(var/obj/item/organ/I in internal_organs)
		I.sync_to_owner()
	s_tone = null
	s_col = null
	if(owner.species.flags & HAS_SKIN_TONE)
		s_tone = owner.s_tone
	if(owner.species.flags & HAS_SKIN_COLOR)
		s_col = owner.skin_color

	if(gendered)
		gendered = (owner.gender == MALE)? "_m": "_f"
	body_build = owner.body_build.index
	icon = null

/obj/item/organ/external/update_icon(var/skeletal)

/*
	if(owner)
		if(gendered)
			gendered = (owner.gender == MALE)? "_m": "_f"
		body_build = owner.body_build.index
*/
	icon = null
	mob_icon = get_icon(skeletal)
	apply_colors()
	draw_internals()
	dir  = EAST
	icon = mob_icon
	return icon

/obj/item/organ/external/get_icon(var/skeletal)
	icon_state = "[organ_tag][gendered][body_build]"

	var/icon/tmp_icon
	if(default_icon)
		tmp_icon = new /icon(default_icon, icon_state)
	else if(skeletal)
		tmp_icon = new /icon('icons/mob/human_races/skeleton.dmi', icon_state)
	else if (status & ORGAN_MUTATED)
		tmp_icon = new /icon(owner.species.deform, icon_state)
	else
		tmp_icon = new /icon(owner.species.icobase, icon_state)
	return tmp_icon

/obj/item/organ/external/proc/apply_colors()
	if(status & ORGAN_DEAD)
		mob_icon.ColorTone(rgb(10,50,0))
		mob_icon.SetIntensity(0.7)

	if(!isnull(s_tone))
		if(s_tone >= 0)
			mob_icon.Blend(rgb(s_tone, s_tone, s_tone), ICON_ADD)
		else
			mob_icon.Blend(rgb(-s_tone,  -s_tone,  -s_tone), ICON_SUBTRACT)
	if(s_col)
		mob_icon.Blend(s_col, ICON_ADD)

	if(tattoo)
		var/icon/tattoo_icon = new/icon('icons/mob/tattoo.dmi', "[organ_tag]_[tattoo][body_build]")
		tattoo_icon.Blend(tattoo_color, ICON_ADD)
		mob_icon.Blend(tattoo_icon, ICON_OVERLAY)
	if(tattoo2)
		mob_icon.Blend(new/icon('icons/mob/tattoo.dmi', "[organ_tag]2_[tattoo2][body_build]"), ICON_OVERLAY)

	return mob_icon

/obj/item/organ/external/proc/draw_internals()
	if(internal_organs)
		var/icon/tmp_icon = null
		for(var/obj/item/organ/I in internal_organs)
			tmp_icon = I.get_icon()
			if(tmp_icon)
				mob_icon.Blend(tmp_icon, ICON_OVERLAY)

	return mob_icon

/obj/item/organ/external/head
	var/icon/hair
	var/icon/facial

/obj/item/organ/external/head/removed(user, delete_children)
	update_icon()
	if(hair)   mob_icon.Blend(hair, ICON_OVERLAY)
	if(facial) mob_icon.Blend(facial, ICON_OVERLAY)
	icon = mob_icon
	..()

/obj/item/organ/external/head/update_icon()

	..()
	overlays.Cut()
	if(!owner || !owner.species)
		return icon

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
	return icon

/obj/item/organ/external/get_icon_key()
	if(status & ORGAN_MUTATED)
		. = "mutated"
	else if(status & ORGAN_DEAD)
		. = "dead"
	else
		. = "normal"

	. += "[model][tattoo][tattoo_color][tattoo2]"

	if(owner.species.flags & HAS_SKIN_TONE)
		. += num2text(s_tone)
	if(owner.species.flags & HAS_SKIN_COLOR)
		. += s_col

	for(var/obj/item/organ/I in internal_organs)
		. += I.get_icon_key()

/obj/item/organ/external
	var/icon_cache_key

// Returns an image for use by the human health dolly HUD element.
// If the user has traumatic shock, it will be passed in as a minimum
// damage amount to represent the pain of the injuries involved.

// Global scope, used in code below.
var/list/flesh_hud_colours = list("#02BA08","#9ECF19","#DEDE10","#FFAA00","#FF0000","#AA0000","#660000")
var/list/robot_hud_colours = list("#CFCFCF","#AFAFAF","#8F8F8F","#6F6F6F","#4F4F4F","#2F2F2F","#000000")

/obj/item/organ/external/proc/get_damage_hud_image(var/forced_dam_state)

	// Generate the greyscale base icon and cache it for later.
	// icon_cache_key is set by any get_icon() calls that are made.
	var/cache_key = "[icon_state][model][owner.species.name]"
	if(!icon_cache_key || !limb_icon_cache[cache_key])
		var/icon/new_icon = icon(get_icon(), null, SOUTH)
		new_icon.Blend("#000000", ICON_MULTIPLY)
		new_icon.SwapColor("#000000", "#FFFFFF")
		limb_icon_cache[cache_key] = new_icon
	var/image/hud_damage_image = image(limb_icon_cache[cache_key])

	// Calculate the required color index.
	if(istext(forced_dam_state))
		switch(forced_dam_state)
			if("numb")
				hud_damage_image.color = "#A8A8A8"
			if("dead")
				hud_damage_image.color = "#3D1212"
	else
		if(!isnum(forced_dam_state))
			forced_dam_state = 0

		var/dam_state = min(1,((brute_dam+burn_dam)/max_damage))
		if(!isnull(forced_dam_state) && dam_state < forced_dam_state)
			dam_state = forced_dam_state
		// Apply colour and return product.
		var/list/hud_colours = (robotic < ORGAN_ROBOT) ? flesh_hud_colours : robot_hud_colours
		hud_damage_image.color = hud_colours[max(1,min(ceil(dam_state*hud_colours.len),hud_colours.len))]
	return hud_damage_image
