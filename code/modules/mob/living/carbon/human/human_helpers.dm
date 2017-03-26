/mob/living/carbon/human/get_ear_protection()
	for(var/obj/item/clothing/C in list(l_ear, r_ear, head))
		if(istype(C))
			. += C.ear_protection
	return

// This is the 'mechanical' check for synthetic-ness, not appearance
// Returns the company that made the synthetic
/mob/living/carbon/human/isSynthetic()
	if(synthetic) return synthetic //Your synthetic-ness is not going away
	var/obj/item/organ/external/T = organs_by_name[BP_CHEST]
	if(T && T.robotic >= ORGAN_ROBOT)
//		src.verbs += /mob/living/carbon/human/proc/self_diagnostics
		var/datum/robolimb/R = all_robolimbs[T.model]
		return R ? R : basic_robolimb

	return 0

// Would an onlooker know this person is synthetic?
// Based on sort of logical reasoning, 'Look at head, look at torso'
/mob/living/carbon/human/proc/looksSynthetic()
	//Look at their head
	var/obj/item/organ/external/H = organs_by_name[BP_HEAD]
	if(!head || !(head && (head.flags_inv & HIDEFACE)))
		if(H && H.robotic == ORGAN_ROBOT) //Exactly robotic, not higher as lifelike is higher
			return 1

	//Look at their torso
	var/obj/item/organ/external/T = organs_by_name[BP_CHEST]
	if(!wear_suit || (wear_suit && !(wear_suit.flags_inv & HIDEJUMPSUIT)))
		if(!w_uniform || (w_uniform && !(w_uniform.body_parts_covered & UPPER_TORSO)))
			if(T && T.robotic == ORGAN_ROBOT)
				return 1

	return 0

/mob/living/carbon/human/proc/should_have_organ(var/organ_check)

	var/obj/item/organ/external/affecting
	if(organ_check in list(O_HEART, O_LUNGS))
		affecting = organs_by_name[BP_CHEST]
	else if(organ_check in list(O_LIVER, O_KIDNEYS))
		affecting = organs_by_name[BP_GROIN]

	if(affecting && (affecting.robotic >= ORGAN_ROBOT)) //LETHALGHOST: check that
		return 0
	return (species && species.has_organ[organ_check])

/mob/living/carbon/human/proc/can_feel_pain(var/check_organ)
	if(isSynthetic())
		return 0
	return !(species.flags & NO_PAIN)

/mob/living/carbon/human/proc/fix_body_build()
	if(body_build && (gender in body_build.genders) && (body_build in species.body_builds))
		return 1
	for(var/datum/body_build/BB in species.body_builds)
		if(gender in BB.genders)
			body_build = BB
			return 1
	world.log << "Can't find possible body_build. Gender = [gender], Species = [species]"
	return 0

/mob/living/carbon/human/proc/get_knockout_message()
	return isSynthetic() ? "encounters a hardware fault and suddenly reboots!" : species.knockout_message

/mob/living/carbon/human/proc/get_ssd()
	if(looksSynthetic())
		return "flashing a 'system offline' light"
	else
		return species.show_ssd

/mob/living/carbon/human/proc/get_death_message()
	return (isSynthetic() ? "gives one shrill beep before falling lifeless." : species.death_message)

/mob/living/carbon/human/proc/get_blood_colour()
	var/datum/robolimb/company = isSynthetic()
	if(company)
		return company.blood_color
	else
		return species.blood_color

/mob/living/carbon/human/proc/is_virus_immune()
	return isSynthetic() || species.virus_immune

/mob/living/carbon/human/proc/get_flesh_colour()
	return isSynthetic() ? SYNTH_FLESH_COLOUR : species.flesh_color


