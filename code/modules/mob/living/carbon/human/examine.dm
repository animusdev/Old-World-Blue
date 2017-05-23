/mob/living/carbon/human/examine(mob/user)
	var/skipgloves = 0
	var/skipsuitstorage = 0
	var/skipjumpsuit = 0
	var/skipshoes = 0
	var/skipmask = 0

	var/skipears = 0
	var/skipeyes = 0
	var/skipface = 0
	var/skipchest = 0
	var/skipgroin = 0
	var/skiphands = 0
	var/skiplegs = 0
	var/skiparms = 0
	var/skipfeet = 0

	var/looks_synth = looksSynthetic()

	//exosuits and helmets obscure our view and stuff.
	if(wear_suit)
		skipsuitstorage |= wear_suit.flags_inv & HIDESUITSTORAGE
		if(wear_suit.flags_inv & HIDEJUMPSUIT)
			skipjumpsuit |= 1
			skiparms |= 1
			skiplegs |= 1
			skipchest |= 1
			skipgroin |= 1
		if(wear_suit.flags_inv & HIDESHOES)
			skipshoes |= 1
			skipfeet |= 1
		if(wear_suit.flags_inv & HIDEGLOVES)
			skipgloves |= 1
			skiphands |= 1

	if(w_uniform)
		skiplegs |= w_uniform.body_parts_covered & LEGS
		skiparms |= w_uniform.body_parts_covered & ARMS
		skipchest |= w_uniform.body_parts_covered & UPPER_TORSO
		skipgroin |= w_uniform.body_parts_covered & LOWER_TORSO

	if(gloves)
		skiphands |= gloves.body_parts_covered & HANDS

	if(shoes)
		skipfeet |= shoes.body_parts_covered & FEET

	if(head)
		skipmask |= head.flags_inv & HIDEMASK
		skipeyes |= head.flags_inv & HIDEEYES
		skipears |= head.flags_inv & HIDEEARS
		skipface |= head.flags_inv & HIDEFACE

	if(wear_mask)
		skipface |= wear_mask.flags_inv & HIDEFACE

	//This is what hides what
	var/list/hidden = list(
		BP_GROIN = skipgroin,
		BP_CHEST = skipchest,
		BP_HEAD  = skipface,
		BP_L_ARM = skiparms,
		BP_R_ARM = skiparms,
		BP_L_HAND= skiphands,
		BP_R_HAND= skiphands,
		BP_L_FOOT= skipfeet,
		BP_R_FOOT= skipfeet,
		BP_L_LEG = skiplegs,
		BP_R_LEG = skiplegs
	)

	var/list/msg = list("<span class='info'>*---------*")
	var/name_line = "This is <EM>[src.name]</EM>"

	var/datum/gender/T = gender_datums[get_gender()]
	if(skipjumpsuit && skipface) //big suits/masks/helmets make it hard to tell their gender
		T = gender_datums[PLURAL]

	if(!T)
		// Just in case someone VVs the gender to something strange. It'll runtime anyway when it hits usages, better to CRASH() now with a helpful message.
		CRASH("Gender datum was null; key was '[(skipjumpsuit && skipface) ? PLURAL : gender]'")

	//big suits/masks/helmets make it hard to tell their gender and age
	if(!skipjumpsuit || !skipface)

		var/t_appeal = "<b><font color='[get_flesh_colour()]'>[species.name]</font></b>"
		if(species.name == SPECIES_HUMAN)
			t_appeal = (T.key == FEMALE) ? "woman" : "man"

		if (species.name == SPECIES_IPC)
			name_line += ", a [t_appeal]"
		else switch(age)
			if(1 to 25)
				name_line += ", a young [t_appeal]"
			if(26 to 45)
				name_line += ", a [t_appeal]"
			if(46 to 75)
				name_line += ", an old [t_appeal]"
			else
				name_line += ", a very old [t_appeal]"

	msg += "[name_line]!"

	//uniform
	if(w_uniform && !skipjumpsuit)
		msg += w_uniform.on_mob_description(src, T, slot_w_uniform)

	//head
	if(head)
		msg += head.on_mob_description(src, T, slot_head, "head")

	//suit/armour
	if(wear_suit)
		msg += wear_suit.on_mob_description(src, T, slot_wear_suit, "suit")

		//suit/armour storage
		if(s_store && !skipsuitstorage)
			msg += s_store.on_mob_description(src, T, slot_s_store, wear_suit.name)

	//back
	if(back)
		msg += back.on_mob_description(src, T, slot_back, "back")

	//left hand
	if(l_hand)
		msg += l_hand.on_mob_description(src, T, slot_l_hand, "left hand")

	//right hand
	if(r_hand)
		msg += r_hand.on_mob_description(src, T, slot_r_hand, "right hand")

	//gloves
	if(!skipgloves)
		if(gloves)
			msg += gloves.on_mob_description(src, T, slot_gloves, "hands")
		else if(blood_DNA)
			msg += SPAN_WARN("[T.He] [T.has] [(hand_blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained hands!")

	//handcuffed?
	if(handcuffed)
		msg += handcuffed.on_mob_description(src, T, slot_handcuffed, "handcuffs")

	//buckled
	if(buckled)
		msg += SPAN_WARN("[T.He] [T.is] \icon[buckled] buckled to [buckled]!")

	//belt
	if(belt)
		msg += belt.on_mob_description(src, T, slot_belt, "belt")

	//shoes
	if(!skipshoes)
		if(shoes)
			msg += shoes.on_mob_description(src, T, slot_shoes, "feet")
		else if(feet_blood_DNA)
			msg += SPAN_WARN("[T.He] [T.has] [(feet_blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained feet!")

	//mask
	if(wear_mask && !skipmask)
		msg += wear_mask.on_mob_description(src, T, slot_wear_mask, "neck")

	//eyes
	if(glasses && !skipeyes)
		msg += glasses.on_mob_description(src, T, slot_glasses, "eyes")

	if(!skipears)
		if(l_ear)
			msg += l_ear.on_mob_description(src, T, slot_l_ear, "left ear")
		if(r_ear)
			msg += r_ear.on_mob_description(src, T, slot_r_ear, "right ear")

	//ID
	if(wear_id)
		msg += wear_id.on_mob_description(src, T, slot_wear_id, "id")

	//Jitters
	if(is_jittery)
		if(jitteriness >= 300)
			msg += SPAN_DANG("[T.He] [T.is] convulsing violently!")
		else if(jitteriness >= 200)
			msg += SPAN_WARN("[T.He] [T.is] extremely jittery.")
		else if(jitteriness >= 100)
			msg += SPAN_WARN("[T.He] [T.is] twitching ever so slightly.")

	//splints
	for(var/organ in list(BP_L_LEG, BP_R_LEG, BP_L_ARM, BP_R_ARM))
		var/obj/item/organ/external/o = get_organ(organ)
		if(o && o.status & ORGAN_SPLINTED)
			msg += SPAN_WARN("[T.He] [T.has] a splint on [T.his] [o.name]!")

	if(suiciding)
		msg += SPAN_WARN("[T.He] appears to have commited suicide... there is no hope of recovery.")

	var/distance = get_dist(user,src)
	if(isobserver(user) || usr.stat == DEAD) // ghosts can see anything
		distance = 1
	if (src.birth)
		msg += SPAN_WARN("[T.He] [T.has] a large hole in [T.his] chest!")
	if (src.stat)
		msg += SPAN_WARN("[T.He] [T.is]n't responding to anything around [T.him] and seems to be asleep.")
		if((stat == DEAD || src.losebreath) && distance <= 3)
			msg += SPAN_WARN("[T.He] [T.does] not appear to be breathing.")
		if(ishuman(user) && !usr.stat && Adjacent(user))
			spawn(0)
				usr.visible_message("<b>[user]</b> checks [src]'s pulse.", "You check [src]'s pulse.")
				if(do_mob(user, src, 15))
					if(pulse == PULSE_NONE)
						user << "<span class='deadsay'>[T.He] [T.has] no pulse[src.client ? "" : " and [T.his] soul has departed"]...</span>"
					else
						user << "<span class='deadsay'>[T.He] [T.has] a pulse!</span>"

	if(fire_stacks)
		msg += "[T.He] [T.is] covered in some liquid."
	if(on_fire)
		msg += SPAN_WARN("[T.He] [T.is] on fire!.")

	if(nutrition < 100)
		msg += SPAN_WARN("[T.He] [T.is] severely malnourished.")
	else if(nutrition >= 500)
		msg += SPAN_WARN("[T.He] [T.is] quite chubby.")

	var/ssd_msg = get_ssd()
	if(ssd_msg && (!should_have_organ(O_BRAIN) || has_brain()) && stat != DEAD)
		if(!key)
			msg += "<span class='deadsay'>[T.He] [T.is] [ssd_msg]. It doesn't look like [T.he] [T.is] waking up anytime soon.</span>"
		else if(!client)
			msg += "<span class='deadsay'>[T.He] [T.is] [ssd_msg].</span>"

	var/list/wound_flavor_text = list()
	var/list/is_bleeding = list()

	for(var/organ_tag in species.has_limbs)
		var/datum/organ_description/organ_data = species.has_limbs[organ_tag]
		var/obj/item/organ/external/E = organs_by_name[organ_tag]
		if(!E)
			wound_flavor_text[organ_data.name] = SPAN_DANG("[T.He] [T.is] missing [T.his] [organ_data.name].")
		else if(E.is_stump())
			wound_flavor_text[organ_data.name] = SPAN_DANG("[T.He] [T.has] a stump where [T.his] [organ_data.name] should be.")
		else
			continue

	for(var/obj/item/organ/external/temp in organs)
		if((temp.organ_tag in hidden) && hidden[temp.organ_tag])
			continue //Organ is hidden, don't talk about it
		if(temp.status & ORGAN_DESTROYED)
			wound_flavor_text[temp.name] = SPAN_DANG("[T.He] [T.is] missing [T.his] [temp.name].")
			continue
		if(!looks_synth && (temp.robotic >= ORGAN_ROBOT))
			if(!(temp.brute_dam + temp.burn_dam))
				wound_flavor_text[temp.name] = "[T.He] [T.has] a [temp.name]."
			else
				wound_flavor_text[temp.name] = SPAN_WARN("[T.He] [T.has] a [temp.name] with [temp.get_wounds_desc()]!")
			continue
		else if(temp.wounds.len > 0 || temp.open)
			if(temp.is_stump() && temp.parent)
				var/obj/item/organ/external/parent = temp.parent
				wound_flavor_text[temp.name] = SPAN_WARN("[T.He] has [temp.get_wounds_desc()] on [T.his] [parent.name].")
			else
				wound_flavor_text[temp.name] = SPAN_WARN("[T.He] has [temp.get_wounds_desc()] on [T.his] [temp.name].")
			if(temp.status & ORGAN_BLEEDING)
				is_bleeding[temp.name] = SPAN_WARN("[T.His] [temp.name] is bleeding!")
		else
			wound_flavor_text[temp.name] = ""

		if(temp.dislocated == 2)
			wound_flavor_text[temp.name] += SPAN_WARN("[T.His] [temp.joint] is dislocated!")
		if(((temp.status & ORGAN_BROKEN) && temp.brute_dam > temp.min_broken_damage) || (temp.status & ORGAN_MUTATED))
			wound_flavor_text[temp.name] += SPAN_WARN("[T.His] [temp.name] is dented and swollen!")

	for(var/limb in wound_flavor_text)
		if(wound_flavor_text[limb])
			msg += wound_flavor_text[limb]
			is_bleeding[limb] = null
	for(var/limb in is_bleeding)
		if(is_bleeding[limb])
			msg += is_bleeding[limb]

	for(var/implant in get_visible_implants(0))
		msg += SPAN_DANG("[src] [T.has] \a [implant] sticking out of [T.his] flesh!")

	if(digitalcamo)
		msg += "[T.He] [T.is] repulsively uncanny!"

	if(hasHUD(usr,"security"))
		var/perpname = "wot"
		var/criminal = "None"

		if(wear_id)
			var/obj/item/weapon/card/id/I = wear_id.GetID()
			if(I)
				perpname = I.registered_name
			else
				perpname = name
		else
			perpname = name

		if(perpname)
			for (var/datum/data/record/E in data_core.general)
				if(E.fields["name"] == perpname)
					for (var/datum/data/record/R in data_core.security)
						if(R.fields["id"] == E.fields["id"])
							criminal = R.fields["criminal"]

			msg += "<span class = 'deptradio'>Criminal status:</span> <a href='?src=\ref[src];criminal=1'>\[[criminal]\]</a>"
			msg += "<span class = 'deptradio'>Security records:</span> <a href='?src=\ref[src];secrecord=`'>\[View\]</a>  <a href='?src=\ref[src];secrecordadd=`'>\[Add comment\]</a>"

	if(hasHUD(usr,"medical"))
		var/perpname = "wot"
		var/medical = "None"

		if(wear_id)
			if(istype(wear_id,/obj/item/weapon/card/id))
				perpname = wear_id:registered_name
			else if(istype(wear_id,/obj/item/device/pda))
				var/obj/item/device/pda/tempPda = wear_id
				perpname = tempPda.owner
		else
			perpname = src.name

		for (var/datum/data/record/E in data_core.general)
			if (E.fields["name"] == perpname)
				for (var/datum/data/record/R in data_core.general)
					if (R.fields["id"] == E.fields["id"])
						medical = R.fields["p_stat"]

		msg += "<span class = 'deptradio'>Physical status:</span> <a href='?src=\ref[src];medical=1'>\[[medical]\]</a>"
		msg += "<span class = 'deptradio'>Medical records:</span> <a href='?src=\ref[src];medrecord=`'>\[View\]</a> <a href='?src=\ref[src];medrecordadd=`'>\[Add comment\]</a>"

		var/obj/item/clothing/under/U = w_uniform
		if(U && istype(U) && U.sensor_mode >= 2)
			msg += "<span class='deptradio'><b>Damage Specifics:</span> <span style=\"color:blue\">[round(src.getOxyLoss(), 1)]</span>-<span style=\"color:green\">[round(src.getToxLoss(), 1)]</span>-<span style=\"color:#FFA500\">[round(src.getFireLoss(), 1)]</span>-<span style=\"color:red\">[round(src.getBruteLoss(), 1)]</span></b>"

	msg += print_flavor_text()

	msg += "*---------*</span>"
	if (pose)
		if(findtext(pose,".",lentext(pose)) == 0 && findtext(pose,"!",lentext(pose)) == 0 && findtext(pose,"?",lentext(pose)) == 0 )
			pose = addtext(pose,".") //Makes sure all emotes end with a period.
		msg += "[T.He] [pose]"

	user << jointext(msg, "\n")

//Helper procedure. Called by /mob/living/carbon/human/examine() and /mob/living/carbon/human/Topic() to determine HUD access to security and medical records.
/proc/hasHUD(mob/M as mob, hudtype)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		switch(hudtype)
			if("security")
				return istype(H.glasses, /obj/item/clothing/glasses/hud/security) || istype(H.glasses, /obj/item/clothing/glasses/sunglasses/sechud)
			if("medical")
				return istype(H.glasses, /obj/item/clothing/glasses/hud/health)
			else
				return 0
	else if(istype(M, /mob/living/silicon/robot))
		var/mob/living/silicon/robot/R = M
		switch(hudtype)
			if("security")
				return istype(R.module_state_1, /obj/item/borg/sight/hud/sec) || istype(R.module_state_2, /obj/item/borg/sight/hud/sec) || istype(R.module_state_3, /obj/item/borg/sight/hud/sec)
			if("medical")
				return istype(R.module_state_1, /obj/item/borg/sight/hud/med) || istype(R.module_state_2, /obj/item/borg/sight/hud/med) || istype(R.module_state_3, /obj/item/borg/sight/hud/med)
			else
				return 0
	else if(istype(M, /mob/living/silicon/pai))
		var/mob/living/silicon/pai/P = M
		switch(hudtype)
			if("security")
				return P.secHUD
			if("medical")
				return P.medHUD
	else
		return 0
