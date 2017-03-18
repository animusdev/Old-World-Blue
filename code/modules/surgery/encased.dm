//Procedures in this file: Generic ribcage opening steps, Removing alien embryo, Fixing internal organs.
//////////////////////////////////////////////////////////////////
//				GENERIC	RIBCAGE SURGERY							//
//////////////////////////////////////////////////////////////////
/datum/surgery_step/open_encased
	priority = 2
	can_infect = 1
	blood_level = 1
	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

		if (!hasorgans(target))
			return 0

		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		return affected && affected.encased && affected.open >= 2


/datum/surgery_step/open_encased/saw
	allowed_tools = list(
		/obj/item/weapon/circular_saw = 100,
		/obj/item/weapon/material/hatchet = 75
	)

	min_duration = 50
	max_duration = 70

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		return ..() && affected && affected.open == 2

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)

		user.visible_message(
			"[user] begins to cut through [target]'s [affected.encased] with \the [tool].",
			"You begin to cut through [target]'s [affected.encased] with \the [tool]."
		)
		target.custom_pain("Something hurts horribly in your [affected.name]!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)

		user.visible_message(
			SPAN_NOTE("[user] has cut [target]'s [affected.encased] open with \the [tool]."),
			SPAN_NOTE("You have cut [target]'s [affected.encased] open with \the [tool].")
		)
		affected.open = 2.5

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)

		user.visible_message(
			SPAN_WARN("[user]'s hand slips, cracking [target]'s [affected.encased] with \the [tool]!"),
			SPAN_WARN("Your hand slips, cracking [target]'s [affected.encased] with \the [tool]!")
		)

		affected.createwound(CUT, 20)
		affected.fracture()


/datum/surgery_step/open_encased/retract
	allowed_tools = list(
		/obj/item/weapon/retractor = 100,
		/obj/item/weapon/crowbar = 75
	)

	min_duration = 30
	max_duration = 40

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		return ..() && affected && affected.open == 2.5

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)

		user.visible_message(
			"[user] starts to force open the [affected.encased] in [target]'s [affected.name] with \the [tool].",
			"You start to force open the [affected.encased] in [target]'s [affected.name] with \the [tool]."
		)
		target.custom_pain("Something hurts horribly in your [affected.name]!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)

		user.visible_message(
			SPAN_NOTE("[user] forces open [target]'s [affected.encased] with \the [tool]."),
			SPAN_NOTE("You force open [target]'s [affected.encased] with \the [tool].")
		)

		affected.open = 3

		// Whoops!
		if(prob(10))
			affected.fracture()

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)

		user.visible_message(
			SPAN_WARN("[user]'s hand slips, cracking [target]'s [affected.encased]!"),
			SPAN_WARN("Your hand slips, cracking [target]'s  [affected.encased]!")
		)

		affected.createwound(BRUISE, 20)
		affected.fracture()

/datum/surgery_step/open_encased/close
	allowed_tools = list(
		/obj/item/weapon/retractor = 100,
		/obj/item/weapon/crowbar = 75
	)

	min_duration = 20
	max_duration = 40

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		return ..() && affected && affected.open == 3

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)

		user.visible_message(
			"[user] starts bending [target]'s [affected.encased] back into place with \the [tool].",
			"You start bending [target]'s [affected.encased] back into place with \the [tool]."
		)
		target.custom_pain("Something hurts horribly in your [affected.name]!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)

		user.visible_message(
			SPAN_NOTE("[user] bends [target]'s [affected.encased] back into place with \the [tool]."),
			SPAN_NOTE("You bend [target]'s [affected.encased] back into place with \the [tool].")
		)

		affected.open = 2.5

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)

		user.visible_message(
			SPAN_WARN("[user]'s hand slips, bending [target]'s [affected.encased] the wrong way!"),
			SPAN_WARN("Your hand slips, bending [target]'s [affected.encased] the wrong way!")
		)

		affected.createwound(BRUISE, 20)
		affected.fracture()

		if(affected.internal_organs && affected.internal_organs.len)
			if(prob(40))
				var/obj/item/organ/internal/O = pick(affected.internal_organs) //TODO weight by organ size
				user.visible_message(
					SPAN_DANG("A wayward piece of [target]'s [affected.encased] pierces \his [O.name]!")
				)
				O.bruise()

/datum/surgery_step/open_encased/mend
	allowed_tools = list(
		/obj/item/weapon/bonegel = 100,
		/obj/item/weapon/screwdriver = 75
	)

	min_duration = 20
	max_duration = 40

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		return ..() && affected && affected.open == 2.5

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)

		user.visible_message(
			"[user] starts applying \the [tool] to [target]'s [affected.encased].",
			"You start applying \the [tool] to [target]'s [affected.encased]."
		)
		target.custom_pain("Something hurts horribly in your [affected.name]!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

		if (!hasorgans(target))
			return
		var/obj/item/organ/external/affected = target.get_organ(target_zone)

		user.visible_message(
			SPAN_NOTE("[user] applied \the [tool] to [target]'s [affected.encased]."),
			SPAN_NOTE("You applied \the [tool] to [target]'s [affected.encased].")
		)

		affected.open = 2