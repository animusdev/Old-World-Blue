/mob/living/carbon/human/examine(mob/user)
	var/skipgloves = 0
	var/skipsuitstorage = 0
	var/skipjumpsuit = 0
	var/skipshoes = 0
	var/skipmask = 0
	var/skipears = 0
	var/skipeyes = 0
	var/skipface = 0

	//exosuits and helmets obscure our view and stuff.
	if(wear_suit)
		skipgloves = wear_suit.flags_inv & HIDEGLOVES
		skipsuitstorage = wear_suit.flags_inv & HIDESUITSTORAGE
		skipjumpsuit = wear_suit.flags_inv & HIDEJUMPSUIT
		skipshoes = wear_suit.flags_inv & HIDESHOES

	if(head)
		skipmask = head.flags_inv & HIDEMASK
		skipeyes = head.flags_inv & HIDEEYES
		skipears = head.flags_inv & HIDEEARS
		skipface = head.flags_inv & HIDEFACE

	if(wear_mask)
		skipface |= wear_mask.flags_inv & HIDEFACE

	// crappy hacks because you can't do \his[src] etc. I'm sorry this proc is so unreadable, blame the text macros :<
	var/t_He = "They" //capitalised for use at the start of each line.
	var/t_he = "they"
	var/t_his = "their"
	var/t_him = "them"
	var/t_has = "have"
	var/t_is = "are"
	var/t_does = "do"


	var/msg = "<span class='info'>*---------*\nThis is "

	msg += "<EM>[src.name]</EM>"

	//big suits/masks/helmets make it hard to tell their gender and age
	if(!skipjumpsuit || !skipface)

		var/t_appeal = "<b><font color='[get_flesh_colour()]'>[species.name]</font></b>"
		switch(gender)
			if(MALE)
				t_He = "He"
				t_he = "he"
				t_his = "his"
				t_him = "him"
				t_has = "has"
				t_is = "is"
				t_does = "does"
				if(species.name == "Human") t_appeal = "man"
			if(FEMALE)
				t_He = "She"
				t_he = "she"
				t_his = "her"
				t_him = "her"
				t_has = "has"
				t_is = "is"
				t_does = "does"
				if(species.name == "Human") t_appeal = "woman"
			if(NEUTER)
				t_He = "It"
				t_he = "it"
				t_his = "its"
				t_him = "it"
				t_has = "has"
				t_is = "is"
				t_does = "does"

		if (species.name == "Machine")
			msg += ", a [t_appeal]"
		else switch(age)
			if(1 to 25)
				msg += ", a young [t_appeal]"
			if(26 to 45)
				msg += ", a [t_appeal]"
			if(46 to 75)
				msg += ", an old [t_appeal]"
			else
				msg += ", a very old [t_appeal]"

	msg += "!\n"

	//uniform
	if(w_uniform && !skipjumpsuit)
		//Ties
		var/tie_msg
		if(istype(w_uniform,/obj/item/clothing/under))
			var/obj/item/clothing/under/U = w_uniform
			if(U.accessories.len)
				tie_msg += ". Attached to it is [lowertext(english_list(U.accessories))]"

		if(w_uniform.blood_DNA)
			msg += "<span class='warning'>[t_He] [t_is] wearing \icon[w_uniform] [w_uniform.gender==PLURAL?"some":"a"] [(w_uniform.blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained [w_uniform.name][tie_msg]!</span>\n"
		else
			msg += "[t_He] [t_is] wearing \icon[w_uniform] \a [w_uniform][tie_msg].\n"

	//head
	if(head)
		if(head.blood_DNA)
			msg += "<span class='warning'>[t_He] [t_is] wearing \icon[head] [head.gender==PLURAL?"some":"a"] [(head.blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained [head.name] on [t_his] head!</span>\n"
		else
			msg += "[t_He] [t_is] wearing \icon[head] \a [head] on [t_his] head.\n"

	//suit/armour
	if(wear_suit)
		if(wear_suit.blood_DNA)
			msg += "<span class='warning'>[t_He] [t_is] wearing \icon[wear_suit] [wear_suit.gender==PLURAL?"some":"a"] [(wear_suit.blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained [wear_suit.name]!</span>\n"
		else
			msg += "[t_He] [t_is] wearing \icon[wear_suit] \a [wear_suit].\n"

		//suit/armour storage
		if(s_store && !skipsuitstorage)
			if(s_store.blood_DNA)
				msg += "<span class='warning'>[t_He] [t_is] carrying \icon[s_store] [s_store.gender==PLURAL?"some":"a"] [(s_store.blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained [s_store.name] on [t_his] [wear_suit.name]!</span>\n"
			else
				msg += "[t_He] [t_is] carrying \icon[s_store] \a [s_store] on [t_his] [wear_suit.name].\n"

	//back
	if(back)
		if(back.blood_DNA)
			msg += "<span class='warning'>[t_He] [t_has] \icon[back] [back.gender==PLURAL?"some":"a"] [(back.blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained [back] on [t_his] back.</span>\n"
		else
			msg += "[t_He] [t_has] \icon[back] \a [back] on [t_his] back.\n"

	//left hand
	if(l_hand)
		if(l_hand.blood_DNA)
			msg += "<span class='warning'>[t_He] [t_is] holding \icon[l_hand] [l_hand.gender==PLURAL?"some":"a"] [(l_hand.blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained [l_hand.name] in [t_his] left hand!</span>\n"
		else
			msg += "[t_He] [t_is] holding \icon[l_hand] \a [l_hand] in [t_his] left hand.\n"

	//right hand
	if(r_hand)
		if(r_hand.blood_DNA)
			msg += "<span class='warning'>[t_He] [t_is] holding \icon[r_hand] [r_hand.gender==PLURAL?"some":"a"] [(r_hand.blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained [r_hand.name] in [t_his] right hand!</span>\n"
		else
			msg += "[t_He] [t_is] holding \icon[r_hand] \a [r_hand] in [t_his] right hand.\n"

	//gloves
	if(gloves && !skipgloves)
		if(gloves.blood_DNA)
			msg += "<span class='warning'>[t_He] [t_has] \icon[gloves] [gloves.gender==PLURAL?"some":"a"] [(gloves.blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained [gloves.name] on [t_his] hands!</span>\n"
		else
			msg += "[t_He] [t_has] \icon[gloves] \a [gloves] on [t_his] hands.\n"
	else if(blood_DNA)
		msg += "<span class='warning'>[t_He] [t_has] [(hand_blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained hands!</span>\n"

	//handcuffed?

	//handcuffed?
	if(handcuffed)
		if(istype(handcuffed, /obj/item/weapon/handcuffs/cable))
			msg += "<span class='warning'>[t_He] [t_is] \icon[handcuffed] restrained with cable!</span>\n"
		else
			msg += "<span class='warning'>[t_He] [t_is] \icon[handcuffed] handcuffed!</span>\n"

	//buckled
	if(buckled)
		msg += "<span class='warning'>[t_He] [t_is] \icon[buckled] buckled to [buckled]!</span>\n"

	//belt
	if(belt)
		if(belt.blood_DNA)
			msg += "<span class='warning'>[t_He] [t_has] \icon[belt] [belt.gender==PLURAL?"some":"a"] [(belt.blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained [belt.name] about [t_his] waist!</span>\n"
		else
			msg += "[t_He] [t_has] \icon[belt] \a [belt] about [t_his] waist.\n"

	//shoes
	if(shoes && !skipshoes)
		if(shoes.blood_DNA)
			msg += "<span class='warning'>[t_He] [t_is] wearing \icon[shoes] [shoes.gender==PLURAL?"some":"a"] [(shoes.blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained [shoes.name] on [t_his] feet!</span>\n"
		else
			msg += "[t_He] [t_is] wearing \icon[shoes] \a [shoes] on [t_his] feet.\n"
	else if(feet_blood_DNA)
		msg += "<span class='warning'>[t_He] [t_has] [(feet_blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained feet!</span>\n"

	//mask
	if(wear_mask && !skipmask)
		if(wear_mask.blood_DNA)
			msg += "<span class='warning'>[t_He] [t_has] \icon[wear_mask] [wear_mask.gender==PLURAL?"some":"a"] [(wear_mask.blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained [wear_mask.name] on [t_his] face!</span>\n"
		else
			msg += "[t_He] [t_has] \icon[wear_mask] \a [wear_mask] on [t_his] face.\n"

	//eyes
	if(glasses && !skipeyes)
		if(glasses.blood_DNA)
			msg += "<span class='warning'>[t_He] [t_has] \icon[glasses] [glasses.gender==PLURAL?"some":"a"] [(glasses.blood_color != SYNTH_BLOOD_COLOUR) ? "blood" : "oil"]-stained [glasses] covering [t_his] eyes!</span>\n"
		else
			msg += "[t_He] [t_has] \icon[glasses] \a [glasses] covering [t_his] eyes.\n"

	//left ear
	if(l_ear && !skipears)
		msg += "[t_He] [t_has] \icon[l_ear] \a [l_ear] on [t_his] left ear.\n"

	//right ear
	if(r_ear && !skipears)
		msg += "[t_He] [t_has] \icon[r_ear] \a [r_ear] on [t_his] right ear.\n"

	//ID
	if(wear_id)
		/*var/id
		if(istype(wear_id, /obj/item/device/pda))
			var/obj/item/device/pda/pda = wear_id
			id = pda.owner
		else if(istype(wear_id, /obj/item/weapon/card/id)) //just in case something other than a PDA/ID card somehow gets in the ID slot :[
			var/obj/item/weapon/card/id/idcard = wear_id
			id = idcard.registered_name
		if(id && (id != real_name) && (get_dist(src, usr) <= 1) && prob(10))
			msg += "<span class='warning'>[t_He] [t_is] wearing \icon[wear_id] \a [wear_id] yet something doesn't seem right...</span>\n"
		else*/
		msg += "[t_He] [t_is] wearing \icon[wear_id] \a [wear_id].\n"

	//Jitters
	if(is_jittery)
		if(jitteriness >= 300)
			msg += "<span class='warning'><B>[t_He] [t_is] convulsing violently!</B></span>\n"
		else if(jitteriness >= 200)
			msg += "<span class='warning'>[t_He] [t_is] extremely jittery.</span>\n"
		else if(jitteriness >= 100)
			msg += "<span class='warning'>[t_He] [t_is] twitching ever so slightly.</span>\n"

	//splints
	for(var/organ in list(BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM))
		var/obj/item/organ/external/o = get_organ(organ)
		if(o && o.status & ORGAN_SPLINTED)
			msg += "<span class='warning'>[t_He] [t_has] a splint on [t_his] [o.name]!</span>\n"

	if(suiciding)
		msg += "<span class='warning'>[t_He] appears to have commited suicide... there is no hope of recovery.</span>\n"

	if(mSmallsize in mutations)
		msg += "[t_He] [t_is] small halfling!\n"

	var/distance = get_dist(usr,src)
	if(isobserver(usr) || usr.stat == DEAD) // ghosts can see anything
		distance = 1
	if (src.stat)
		msg += "<span class='warning'>[t_He] [t_is]n't responding to anything around [t_him] and seems to be asleep.</span>\n"
	if (src.birth)
		msg += "<span class='warning'>[t_He] [t_has] a large hole in [t_his] chest!</span>\n"
		if((stat == 2 || src.losebreath) && distance <= 3)
			msg += "<span class='warning'>[t_He] [t_does] not appear to be breathing.</span>\n"
		if(ishuman(usr) && !usr.stat && Adjacent(usr))
			usr.visible_message("<b>[usr]</b> checks [src]'s pulse.", "You check [src]'s pulse.")
		spawn(15)
			if(distance <= 1 && usr.stat != 1)
				if(pulse == PULSE_NONE)
					usr << "<span class='deadsay'>[t_He] [t_has] no pulse[src.client ? "" : " and [t_his] soul has departed"]...</span>"
				else
					usr << "<span class='deadsay'>[t_He] [t_has] a pulse!</span>"
	if(fire_stacks)
		msg += "[t_He] [t_is] covered in some liquid.\n"
	if(on_fire)
		msg += "<span class='warning'>[t_He] [t_is] on fire!.</span>\n"
	msg += "<span class='warning'>"

	if(nutrition < 100)
		msg += "[t_He] [t_is] severely malnourished.\n"
	else if(nutrition >= 500)
		/*if(usr.nutrition < 100)
			msg += "[t_He] [t_is] plump and delicious looking - Like a fat little piggy. A tasty piggy.\n"
		else*/
		msg += "[t_He] [t_is] quite chubby.\n"

	msg += "</span>"

	if(getBrainLoss() >= 60)
		msg += "[t_He] [t_has] a stupid expression on [t_his] face.\n"

	var/ssd_msg = get_ssd()
	if(ssd_msg && (!should_have_organ(O_BRAIN) || has_brain()) && stat != DEAD)
		if(!key)
			msg += "<span class='deadsay'>[t_He] [t_is] [ssd_msg]. It doesn't look like [t_he] [t_is] waking up anytime soon.</span>\n"
		else if(!client)
			msg += "<span class='deadsay'>[t_He] [t_is] [ssd_msg].</span>\n"

	var/list/wound_flavor_text = list()

	for(var/organ_tag in species.has_limbs)

		var/datum/organ_description/organ_data = species.has_limbs[organ_tag]
		var/obj/item/organ/external/E = organs_by_name[organ_tag]

		if(!E)
			wound_flavor_text[organ_tag] = "<b>[t_He] is missing [t_his] [organ_data.name].</b>\n"
			continue

		wound_flavor_text[E.name] = ""

		var/obj/item/clothing/hidden
		var/list/clothing_items = list(head, wear_mask, wear_suit, w_uniform, gloves, shoes)
		for(var/obj/item/clothing/C in clothing_items)
			if(istype(C) && (C.body_parts_covered & E.body_part))
				hidden = C
					break

		if(hidden && user != src)
			if(E.status & ORGAN_BLEEDING && !(hidden.item_flags & THICKMATERIAL)) //not through a spacesuit
				wound_flavor_text[hidden.name] = "[t_He] has blood soaking through [hidden]!<br>"
		else
			if(E.is_stump())
				wound_flavor_text[E.name] += "<b>[t_He] has a stump where [t_his] [organ_data.name] should be.</b>\n"
				if((E.wounds.len || E.open) && E.parent)
					wound_flavor_text[E.name] += "[t_He] has [E.get_wounds_desc()] on [t_his] [E.parent.name].<br>"
			else
				if(!IS_SYNTHETIC && E.robotic >= ORGAN_ROBOT && (E.parent && E.parent.robotic < ORGAN_ROBOT))
					wound_flavor_text[E.name] = "[t_He] has a [E.name].\n"
				if(E.wounds.len || E.open)
					wound_flavor_text[E.name] += "[t_He] has [E.get_wounds_desc()] on [t_his] [E.name].<br>"

		if(!hidden || distance <=1)
			if(E.dislocated > 0)
				wound_flavor_text[E.name] += "[capitalize(t_his)] [E.joint] is dislocated!<br>"
			if(((E.status & ORGAN_BROKEN) && E.brute_dam > E.min_broken_damage) || (E.status & ORGAN_MUTATED))
				wound_flavor_text[E.name] += "[capitalize(t_his)] [E.name] is dented and swollen!<br>"

	//Handles the text strings being added to the actual description.
	//If they have something that covers the limb, and it is not missing, put flavortext.  If it is covered but bleeding, add other flavortext.

	msg += "<span class='warning'>"
	for(var/limb in wound_flavor_text)
		msg += wound_flavor_text[limb]
	msg += "</span>"

	for(var/implant in get_visible_implants(0))
		msg += "<span class='danger'>[src] [t_has] \a [implant] sticking out of [t_his] flesh!</span>\n"
	if(digitalcamo)
		msg += "[t_He] [t_is] repulsively uncanny!\n"

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

			msg += "<span class = 'deptradio'>Criminal status:</span> <a href='?src=\ref[src];criminal=1'>\[[criminal]\]</a>\n"
			msg += "<span class = 'deptradio'>Security records:</span> <a href='?src=\ref[src];secrecord=`'>\[View\]</a>  <a href='?src=\ref[src];secrecordadd=`'>\[Add comment\]</a>\n"

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

		msg += "<span class = 'deptradio'>Physical status:</span> <a href='?src=\ref[src];medical=1'>\[[medical]\]</a>\n"
		msg += "<span class = 'deptradio'>Medical records:</span> <a href='?src=\ref[src];medrecord=`'>\[View\]</a> <a href='?src=\ref[src];medrecordadd=`'>\[Add comment\]</a>\n"

		var/obj/item/clothing/under/U = w_uniform
		if(U && istype(U) && U.sensor_mode >= 2)
			msg += "<span class='deptradio'><b>Damage Specifics:</span> <span style=\"color:blue\">[round(src.getOxyLoss(), 1)]</span>-<span style=\"color:green\">[round(src.getToxLoss(), 1)]</span>-<span style=\"color:#FFA500\">[round(src.getFireLoss(), 1)]</span>-<span style=\"color:red\">[round(src.getBruteLoss(), 1)]</span></b>\n"

	var/flavor = print_flavor_text()
	if(flavor) msg += "[flavor]\n"

	msg += "*---------*</span>"
	if (pose)
		if( findtext(pose,".",lentext(pose)) == 0 && findtext(pose,"!",lentext(pose)) == 0 && findtext(pose,"?",lentext(pose)) == 0 )
			pose = addtext(pose,".") //Makes sure all emotes end with a period.
		msg += "\n[t_He] [t_is] [pose]"

	user << msg

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
