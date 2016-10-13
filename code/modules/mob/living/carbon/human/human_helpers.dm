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
