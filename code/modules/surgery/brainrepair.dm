//////////////////////////////////////////////////////////////////
//				BRAIN DAMAGE FIXING								//
//////////////////////////////////////////////////////////////////

/datum/surgery_step/brain/bone_chips
	allowed_tools = list(
		/obj/item/weapon/hemostat = 100,
		/obj/item/weapon/wirecutters = 75,
		/obj/item/weapon/material/kitchen/utensil/fork = 20
	)

	priority = 3
	min_duration = 80
	max_duration = 100

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		if(!affected) return
		var/obj/item/organ/internal/brain/sponge = target.internal_organs_by_name[O_BRAIN]
		return (sponge && sponge.damage > 0 && sponge.damage <= 20) && affected.open == 3

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message(
			"[user] starts taking bone chips out of [target]'s brain with \the [tool].",
			"You start taking bone chips out of [target]'s brain with \the [tool]."
		)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message(
			SPAN_NOTE("[user] takes out all the bone chips in [target]'s brain with \the [tool]."),
			SPAN_NOTE("You take out all the bone chips in [target]'s brain with \the [tool].")
		)
		var/obj/item/organ/internal/brain/sponge = target.internal_organs_by_name[O_BRAIN]
		if (sponge)
			sponge.damage = 0

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message(
			SPAN_WARN("[user]'s hand slips, jabbing \the [tool] in [target]'s brain!"),
			SPAN_WARN("Your hand slips, jabbing \the [tool] in [target]'s brain!")
		)
		target.apply_damage(30, BRUTE, BP_HEAD, 1, sharp=1)

/datum/surgery_step/brain/hematoma
	allowed_tools = list(
		/obj/item/weapon/FixOVein = 100,
		/obj/item/stack/cable_coil = 75
	)

	priority = 3
	min_duration = 90
	max_duration = 110

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		if(!affected) return
		var/obj/item/organ/internal/brain/sponge = target.internal_organs_by_name[O_BRAIN]
		return (sponge && sponge.damage > 20) && affected.open == 3

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message(
			"[user] starts mending hematoma in [target]'s brain with \the [tool].",
			"You start mending hematoma in [target]'s brain with \the [tool]."
		)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message(
			SPAN_NOTE("[user] mends hematoma in [target]'s brain with \the [tool]."),
			SPAN_NOTE("You mend hematoma in [target]'s brain with \the [tool].")
		)
		var/obj/item/organ/internal/brain/sponge = target.internal_organs_by_name[O_BRAIN]
		if (sponge)
			sponge.damage = 20

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message(
			SPAN_WARN("[user]'s hand slips, bruising [target]'s brain with \the [tool]!"),
			SPAN_WARN("Your hand slips, bruising [target]'s brain with \the [tool]!")
		)
		target.apply_damage(20, BRUTE, BP_HEAD, 1, sharp=1)