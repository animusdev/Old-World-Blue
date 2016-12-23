/datum/preferences
	//The mob should have a gender you want before running this proc. Will run fine without H
/datum/preferences/proc/randomize_appearance_for(var/mob/living/carbon/human/H)
	if(H)
		if(H.gender == MALE)
			gender = MALE
		else
			gender = FEMALE
	s_tone = random_skin_tone()
	h_style = random_hair_style(gender, species)
	f_style = random_facial_hair_style(gender, species)
	randomize_hair_color("hair")
	randomize_hair_color("facial")
	randomize_eyes_color()
	randomize_skin_color()
	underwear = pick(all_underwears)
	undershirt = pick(all_undershirts)
	socks = pick(all_socks)
	backbag = rand(1,backbaglist.len)
	age = rand(current_species.min_age, current_species.max_age)
	if(H) copy_to(H,1)

/datum/preferences/proc/randomize_hair_color(var/target = "hair")
	if(prob (75) && target == "facial") // Chance to inherit hair color
		facial_color = hair_color
		return

	var/red
	var/green
	var/blue

	var/col = pick ("blonde", "black", "chestnut", "copper", "brown", "wheat", "old", "punk")
	switch(col)
		if("blonde")
			red = 255
			green = 255
			blue = 0
		if("black")
			red = 0
			green = 0
			blue = 0
		if("chestnut")
			red = 153
			green = 102
			blue = 51
		if("copper")
			red = 255
			green = 153
			blue = 0
		if("brown")
			red = 102
			green = 51
			blue = 0
		if("wheat")
			red = 255
			green = 255
			blue = 153
		if("old")
			red = rand (100, 255)
			green = red
			blue = red
		if("punk")
			red = rand (0, 255)
			green = rand (0, 255)
			blue = rand (0, 255)

	red   = max(min(red   + rand (-25, 25), 255), 0)
	green = max(min(green + rand (-25, 25), 255), 0)
	blue  = max(min(blue  + rand (-25, 25), 255), 0)
	var/new_color = rgb(red, green, blue)

	switch(target)
		if("hair")
			hair_color = new_color
		if("facial")
			facial_color = new_color

/datum/preferences/proc/randomize_eyes_color()
	var/red
	var/green
	var/blue

	var/col = pick ("black", "grey", "brown", "chestnut", "blue", "lightblue", "green", "albino")
	switch(col)
		if("black")
			red = 0
			green = 0
			blue = 0
		if("grey")
			red = rand (100, 200)
			green = red
			blue = red
		if("brown")
			red = 102
			green = 51
			blue = 0
		if("chestnut")
			red = 153
			green = 102
			blue = 0
		if("blue")
			red = 51
			green = 102
			blue = 204
		if("lightblue")
			red = 102
			green = 204
			blue = 255
		if("green")
			red = 0
			green = 102
			blue = 0
		if("albino")
			red = rand (200, 255)
			green = rand (0, 150)
			blue = rand (0, 150)

	red   = max(min(red   + rand (-25, 25), 255), 0)
	green = max(min(green + rand (-25, 25), 255), 0)
	blue  = max(min(blue  + rand (-25, 25), 255), 0)

	eyes_color = rgb(red, green, blue)

/datum/preferences/proc/randomize_skin_color()
	var/red
	var/green
	var/blue

	var/col = pick ("black", "grey", "brown", "chestnut", "blue", "lightblue", "green", "albino")
	switch(col)
		if("black")
			red = 0
			green = 0
			blue = 0
		if("grey")
			red = rand (100, 200)
			green = red
			blue = red
		if("brown")
			red = 102
			green = 51
			blue = 0
		if("chestnut")
			red = 153
			green = 102
			blue = 0
		if("blue")
			red = 51
			green = 102
			blue = 204
		if("lightblue")
			red = 102
			green = 204
			blue = 255
		if("green")
			red = 0
			green = 102
			blue = 0
		if("albino")
			red = rand (200, 255)
			green = rand (0, 150)
			blue = rand (0, 150)

	red   = max(min(red   + rand (-25, 25), 255), 0)
	green = max(min(green + rand (-25, 25), 255), 0)
	blue  = max(min(blue  + rand (-25, 25), 255), 0)

	skin_color = rgb(red, green, blue)

/datum/preferences/proc/update_preview_icon()		//seriously. This is horrendous.
	qdel(preview_icon_front)
	qdel(preview_icon_side)
	qdel(preview_icon)

	var/datum/body_build/body_build = current_species.get_body_build(gender, body)
	var/g = "_m"
	if(gender == FEMALE)
		g = "_f"
	var/b=body_build.index
	g+=b

	var/icon/icobase
//	var/datum/species/current_species = all_species[species]

	if(current_species)
		icobase = current_species.icobase
	else
		icobase = 'icons/mob/human_races/human.dmi'

	preview_icon = new /icon('icons/mob/human.dmi', "blank")

	for(var/name in list(BP_CHEST,BP_GROIN,BP_HEAD,BP_R_ARM,BP_R_HAND,BP_R_LEG,BP_R_FOOT,BP_L_LEG,BP_L_FOOT,BP_L_ARM,BP_L_HAND))
		if(organ_data[name] == "amputated") continue
		if(organ_data[name] == "cyborg")
			var/datum/robolimb/R
			if(rlimb_data[name]) R = all_robolimbs[rlimb_data[name]]
			if(!R) R = basic_robolimb
			// This doesn't check gendered_icon. Not an issue while only limbs can be robotic.
			preview_icon.Blend(icon(R.icon, "[name][b]"), ICON_OVERLAY)
			continue
		if(name in list(BP_CHEST,BP_GROIN,BP_HEAD))
			preview_icon.Blend(new /icon(icobase, "[name][g]"), ICON_OVERLAY)
		else
			preview_icon.Blend(new /icon(icobase, "[name][b]"), ICON_OVERLAY)
		var/tattoo = tattoo_data[name]
		var/tattoo2 = tattoo_data["[name]2"]
		if(tattoo)  preview_icon.Blend(new/icon('icons/mob/tattoo.dmi', "[name]_[tattoo][b]"), ICON_OVERLAY)
		if(tattoo2) preview_icon.Blend(new/icon('icons/mob/tattoo.dmi', "[name]2_[tattoo2][b]"), ICON_OVERLAY)

	//Tail
	if(current_species.tail)
		var/icon/temp = new/icon(icobase, "tail")
		preview_icon.Blend(temp, ICON_OVERLAY)

	// Skin color
	if(current_species.flags & HAS_SKIN_COLOR)
		preview_icon.Blend(skin_color, ICON_ADD)

	// Skin tone
	if(current_species.flags & HAS_SKIN_TONE)
		if (s_tone >= 0)
			preview_icon.Blend(rgb(s_tone, s_tone, s_tone), ICON_ADD)
		else
			preview_icon.Blend(rgb(-s_tone,  -s_tone,  -s_tone), ICON_SUBTRACT)

	if(underwear && current_species.flags & HAS_UNDERWEAR)
		var/obj/item/clothing/hidden/H = all_underwears[underwear]
		var/t_state = initial(H.wear_state)
		if(!t_state) t_state = initial(H.icon_state)
		preview_icon.Blend(icon(body_build.hidden_icon, t_state), ICON_OVERLAY)
	if(socks)
		var/obj/item/clothing/hidden/H = all_socks[socks]
		var/t_state = initial(H.wear_state)
		if(!t_state) t_state = initial(H.icon_state)
		preview_icon.Blend(icon(body_build.hidden_icon, t_state), ICON_OVERLAY)
	if(undershirt && current_species.flags & HAS_UNDERWEAR)
		var/obj/item/clothing/hidden/H = all_undershirts[undershirt]
		var/t_state = initial(H.wear_state)
		if(!t_state) t_state = initial(H.icon_state)
		preview_icon.Blend(icon(body_build.hidden_icon, t_state), ICON_OVERLAY)


	// Eyes color
	var/icon/eyes = new/icon(icobase, "eyes[b]")
	if ((current_species && (current_species.flags & HAS_EYE_COLOR)))
		eyes.Blend(eyes_color, ICON_ADD)

	if(disabilities & NEARSIGHTED)
		eyes.Blend(new /icon(body_build.glasses_icon, "glasses"), ICON_OVERLAY)

	// Hair Style'n'Color
	var/datum/sprite_accessory/hair_style = hair_styles_list[h_style]
	if(hair_style)
		var/icon/hair = new/icon(hair_style.icon, hair_style.icon_state)
		hair.Blend(hair_color, ICON_ADD)
		eyes.Blend(hair, ICON_OVERLAY)

	hair_style = facial_hair_styles_list[f_style]
	if(hair_style)
		var/icon/facial = new/icon(hair_style.icon, hair_style.icon_state)
		facial.Blend(facial_color, ICON_ADD)
		eyes.Blend(facial, ICON_OVERLAY)

	preview_icon.Blend(eyes, ICON_OVERLAY)

	var/icon/clothes = null
	//This gives the preview icon clothes depending on which job(if any) is set to 'high'
	if(job_civilian_low & ASSISTANT || !job_master)
		clothes = new /icon(body_build.uniform_icon, "grey")
		clothes.Blend(new /icon(body_build.shoes_icon, "black"), ICON_UNDERLAY)
		if(backbag == 2)
			clothes.Blend(new /icon(body_build.back_icon, "backpack"), ICON_OVERLAY)
		else if(backbag == 3 || backbag == 4)
			clothes.Blend(new /icon(body_build.back_icon, "satchel"), ICON_OVERLAY)

	else
		var/datum/job/J = job_master.GetJob(high_job_title)
		if(J)//I hate how this looks, but there's no reason to go through this switch if it's empty

			var/obj/item/clothing/under/UF = J.uniform
			clothes = new /icon(body_build.uniform_icon, initial(UF.icon_state))

			var/obj/item/clothing/shoes/SH = J.shoes
			clothes.Blend(new /icon(body_build.shoes_icon, initial(SH.icon_state)), ICON_UNDERLAY)

			var/obj/item/clothing/gloves/GL = J.gloves
			if(GL) clothes.Blend(new /icon(body_build.gloves_icon, initial(GL.icon_state)), ICON_UNDERLAY)

			var/obj/item/weapon/storage/belt/BT = J.belt
			if(BT) clothes.Blend(new /icon(body_build.belt_icon, initial(BT.icon_state)), ICON_OVERLAY)

			var/obj/item/clothing/suit/ST = J.suit
			if(ST) clothes.Blend(new /icon(body_build.suit_icon, initial(ST.icon_state)), ICON_OVERLAY)

			var/obj/item/clothing/head/HT = J.hat
			if(HT) clothes.Blend(new /icon(body_build.hat_icon, initial(HT.icon_state)), ICON_OVERLAY)

			if( backbag > 1 )
				var/obj/item/weapon/storage/backpack/BP = J.backpack
				switch(backbaglist[backbag])
					if("Backpack")		BP = J.backpack
					if("Satchel")		BP = J.satchel
					if("Satchel Job")	BP = J.satchel_j
					if("Dufflebag")		BP = J.dufflebag
					if("Messenger")		BP = J.messenger
				clothes.Blend(new /icon(body_build.back_icon, initial(BP.icon_state)), ICON_OVERLAY)

	if(clothes)
		preview_icon.Blend(clothes, ICON_OVERLAY)
	preview_icon_front = new(preview_icon, dir = SOUTH)
	preview_icon_side = new(preview_icon, dir = WEST)

	qdel(eyes)
	qdel(clothes)
