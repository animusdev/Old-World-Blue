//Procedures in this file: Robotic limbs attachment
//////////////////////////////////////////////////////////////////
//						LIMB SURGERY							//
//////////////////////////////////////////////////////////////////

/datum/surgery_step/limb/
	can_infect = 0
	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if (!hasorgans(target))
			return 0
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		if (affected)
			return 0
		var/list/organ_data = target.species.has_limbs["[target_zone]"]
		return !isnull(organ_data) && !(target_zone in list("head","groin","chest"))

/datum/surgery_step/limb/attach
	allowed_tools = list(/obj/item/prosthesis = 100)

	min_duration = 80
	max_duration = 100

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if(..())
			var/obj/item/prosthesis/p = tool
			if (p.part)
				if (!(target_zone in p.part))
					return 0
			if(target.body_build == BODY_SLIM && !tool:allow_slim_body)
				user << "<span class = 'warning'>[target.name]'s spine and bones is too weak for using [tool].</span>"
				return 0
			return isnull(target.get_organ(target_zone))

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message("[user] starts attaching \the [tool] to [target].", \
		"You start attaching \the [tool] to [target].")

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/prosthesis/L = tool
		user.visible_message("\blue [user] has attached \the [tool] to [target].",	\
		"\blue You have attached \the [tool] to [target].")

		if(L.part)
			for(var/part_name in L.part)
				if(target.get_organ(part_name))
					continue
				var/datum/organ_description/organ_data = target.species.has_limbs[part_name]
				if(!organ_data)
					continue
				var/new_limb_type = L.part[part_name]
				var/obj/item/organ/external/new_limb = new new_limb_type(target, organ_data)
				if(L.sabotaged)
					new_limb.sabotaged = 1

		target.update_body()
		target.updatehealth()
		target.UpdateDamageIcon()

		qdel(tool)

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message("\red [user]'s hand slips, damaging [target]'s flesh!", \
		"\red Your hand slips, damaging [target]'s flesh!")
		target.apply_damage(10, BRUTE, null, sharp=1)
