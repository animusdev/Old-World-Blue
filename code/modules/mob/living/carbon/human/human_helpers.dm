/mob/living/carbon/human/get_ear_protection()
	for(var/obj/item/clothing/C in list(l_ear, r_ear, head))
		if(istype(C))
			. += C.ear_protection
	return

/mob/living/carbon/human/proc/get_blood_colour()
	var/datum/robolimb/company = isSynthetic()
	if(company)
		return company.blood_color
	else
		return species.blood_color

/mob/living/carbon/human/proc/get_ssd()
	if(looksSynthetic())
		return "flashing a 'system offline' light"
	else
		return species.show_ssd

/mob/living/carbon/human/proc/get_knockout_message()
	return isSynthetic() ? "encounters a hardware fault and suddenly reboots!" : species.knockout_message

// This is the 'mechanical' check for synthetic-ness, not appearance
// Returns the company that made the synthetic
/mob/living/carbon/human/isSynthetic()
	if(synthetic) return synthetic //Your synthetic-ness is not going away
	var/obj/item/organ/external/T = organs_by_name[BP_CHEST]
	if(T && T.status & ORGAN_ROBOT)
//		src.verbs += /mob/living/carbon/human/proc/self_diagnostics
		var/datum/robolimb/R = all_robolimbs[T.model]
		synthetic = R
		return synthetic

	return 0

// Would an onlooker know this person is synthetic?
// Based on sort of logical reasoning, 'Look at head, look at torso'
/mob/living/carbon/human/proc/looksSynthetic()
	//Look at their head
	var/obj/item/organ/external/H = organs_by_name[BP_HEAD]
	if(!head || !(head && (head.flags_inv & HIDEFACE)))
		if(H && H.status & ORGAN_ROBOT) //Exactly robotic, not higher as lifelike is higher
			return 1

	//Look at their torso
	var/obj/item/organ/external/T = organs_by_name[BP_CHEST]
	if(!wear_suit || (wear_suit && !(wear_suit.flags_inv & HIDEJUMPSUIT)))
		if(!w_uniform || (w_uniform && !(w_uniform.body_parts_covered & UPPER_TORSO)))
			if(T && T.status & ORGAN_ROBOT)
				return 1

	return 0

/mob/living/carbon/human/proc/set_body_build(var/prefered = "Default")
	species.get_body_build(prefered)
	fix_body_build()

/mob/living/carbon/human/proc/fix_body_build()
	if(body_build && (gender in body_build.genders) && (body_build in species.body_builds))
		return 1
	for(var/datum/body_build/BB in species.body_builds)
		if(gender in BB.genders)
			body_build = BB
			return 1
	world.log << "Can't find possible body_build. Gender = [gender], Species = [species]"
	return 0