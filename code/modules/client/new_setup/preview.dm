datum/preferences
	var/icon/preview_south = null
	var/icon/preview_north = null
	var/icon/preview_east  = null
	var/icon/preview_west  = null
	var/preview_dir = SOUTH

	proc/new_update_preview_icon()
		req_update_icon = 0			//No check. Can be forced.
		qdel(preview_south)
		qdel(preview_north)
		qdel(preview_east)
		qdel(preview_west)

		var/g = "m"
		if(gender == FEMALE)
			g = "f"
		var/b="[body_build]"
		g+=b

		var/icon/icobase = current_species.icobase

		preview_icon = new /icon('icons/mob/human.dmi', "blank")

		var/list/organ_list = list("chest","groin","head")
		if(preview_dir & (SOUTH|WEST))
			organ_list += list("r_arm","r_hand","r_leg","r_foot", "l_leg","l_foot","l_arm","l_hand")
		else
			organ_list += list("l_leg","l_foot","l_arm","l_hand", "r_arm","r_hand","r_leg","r_foot")
		for(var/organ in organ_list)
			var/datum/body_modification/mod = get_modification(organ)
			if(!mod.replace_limb)
				var/icon/organ_icon
				if(organ in list("head", "chest", "groin"))
					organ_icon = new(icobase, "[organ]_[g]")
				else
					organ_icon = new(icobase, "[organ]_[b]")
				// Skin color
				if(current_species && (current_species.flags & HAS_SKIN_COLOR))
					organ_icon.Blend(skin_color, ICON_ADD)

				// Skin tone
				if(current_species && (current_species.flags & HAS_SKIN_TONE))
					if (s_tone >= 0)
						organ_icon.Blend(rgb(s_tone, s_tone, s_tone), ICON_ADD)
					else
						organ_icon.Blend(rgb(-s_tone,  -s_tone,  -s_tone), ICON_SUBTRACT)
				preview_icon.Blend(organ_icon, ICON_OVERLAY)
			preview_icon.Blend(mod.get_mob_icon(organ, body_build, modifications_colors[organ], gender), ICON_OVERLAY)

		//Tail
		if(current_species.tail)
			var/icon/temp = new/icon(icobase, "tail")
			// Skin color
			if(current_species && (current_species.flags & HAS_SKIN_COLOR))
				temp.Blend(skin_color, ICON_ADD)

			// Skin tone
			if(current_species && (current_species.flags & HAS_SKIN_TONE))
				if (s_tone >= 0)
					temp.Blend(rgb(s_tone, s_tone, s_tone), ICON_ADD)
				else
					temp.Blend(rgb(-s_tone,  -s_tone,  -s_tone), ICON_SUBTRACT)
			preview_icon.Blend(temp, ICON_OVERLAY)

		// Eyes color
		var/icon/eyes = new /icon('icons/mob/human.dmi', "blank")
		var/datum/body_modification/mod = get_modification("eyes")
		if(!mod.replace_limb)
			eyes.Blend(new/icon(icobase, "eyes_[body_build]"), ICON_OVERLAY)
			if((current_species && (current_species.flags & HAS_EYE_COLOR)))
				eyes.Blend(eyes_color, ICON_ADD)
		eyes.Blend(mod.get_mob_icon("eyes", body_build, modifications_colors["eyes"]), ICON_OVERLAY)

		// Hair Style'n'Color
		var/datum/sprite_accessory/hair_style = hair_styles_list[h_style]
		if(hair_style)
			var/icon/hair = new/icon(hair_style.icon, hair_style.icon_state)
			hair.Blend(hair_color, ICON_ADD)
			eyes.Blend(hair, ICON_OVERLAY)

		var/datum/sprite_accessory/facial_hair_style = facial_hair_styles_list[f_style]
		if(facial_hair_style)
			var/icon/facial = new/icon(facial_hair_style.icon, facial_hair_style.icon_state)
			facial.Blend(facial_color, ICON_ADD)
			eyes.Blend(facial, ICON_OVERLAY)

		var/icon/clothes = null
		if(job_civilian_low & ASSISTANT || !job_master)//This gives the preview icon clothes depending on which job(if any) is set to 'high'
			clothes = new /icon(current_species.get_uniform_sprite("grey", body_build), "grey")
			clothes.Blend(new /icon(current_species.get_shoes_sprite("black", body_build), "black"), ICON_UNDERLAY)
			if(backbag == 2)
				clothes.Blend(new /icon(current_species.get_uniform_sprite("backpack", body_build), "backpack"), ICON_OVERLAY)
			else if(backbag == 3 || backbag == 4)
				clothes.Blend(new /icon(current_species.get_shoes_sprite("satchel", body_build), "satchel"), ICON_OVERLAY)

		else
			var/datum/job/J = job_master.GetJob(high_job_title)
			if(J)

				var/obj/item/clothing/under/UF = J.uniform
				clothes = new /icon(current_species.get_uniform_sprite(initial(UF.icon_state), body_build), initial(UF.icon_state))

				var/obj/item/clothing/shoes/SH = J.shoes
				clothes.Blend(new /icon(current_species.get_shoes_sprite(initial(SH.icon_state), body_build), initial(SH.icon_state)), ICON_UNDERLAY)

				var/obj/item/clothing/gloves/GL = J.gloves
				if(GL) clothes.Blend(new /icon(current_species.get_gloves_sprite(initial(GL.icon_state), body_build), initial(GL.icon_state)), ICON_UNDERLAY)

				var/obj/item/weapon/storage/belt/BT = J.belt
				if(BT) clothes.Blend(new /icon(current_species.get_belt_sprite(initial(BT.icon_state), body_build), initial(BT.icon_state)), ICON_OVERLAY)

				var/obj/item/clothing/suit/ST = J.suit
				if(ST) clothes.Blend(new /icon(current_species.get_suit_sprite(initial(ST.icon_state), body_build), initial(ST.icon_state)), ICON_OVERLAY)

				var/obj/item/clothing/head/HT = J.hat
				if(HT) clothes.Blend(new /icon(current_species.get_head_sprite(initial(HT.icon_state), body_build), initial(HT.icon_state)), ICON_OVERLAY)

				if( backbag > 1 )
					var/obj/item/weapon/storage/backpack/BP = J.backpacks[backbag-1]
					clothes.Blend(new /icon(current_species.get_back_sprite(initial(BP.icon_state), body_build), initial(BP.icon_state)), ICON_OVERLAY)

		if(disabilities & NEARSIGHTED)
			preview_icon.Blend(new /icon((g == "f1")?'icons/mob/eyes_f.dmi':'icons/mob/eyes.dmi', "glasses"), ICON_OVERLAY)

		preview_icon.Blend(eyes, ICON_OVERLAY)

		if(clothes)
			preview_icon.Blend(clothes, ICON_OVERLAY)

		preview_south = new(preview_icon, dir = SOUTH)
		preview_north = new(preview_icon, dir = NORTH)
		preview_east  = new(preview_icon, dir = EAST)
		preview_west  = new(preview_icon, dir = WEST)

		qdel(eyes)
		qdel(underwear)
		qdel(undershirt)
		qdel(clothes)