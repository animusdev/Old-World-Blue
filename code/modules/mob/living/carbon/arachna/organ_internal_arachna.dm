/****************************************************
				INTERNAL ORGANS DEFINES
****************************************************/
/*
		add_reagent(var/id, var/amount, var/data = null, var/safety = 0)
			Adds [amount] units of [id] reagent. [data] will be passed to reagent's mix_data() or initialize_data(). If [safety] is 0, handle_reactions() will be called. Returns 1 if successful, 0 otherwise.

		trans_to_holder(var/datum/reagents/target, var/amount = 1, var/multiplier = 1, var/copy = 0)
			Transfers [amount] reagents from [src] to [target], multiplying them by [multiplier]. Returns actual amount removed from [src] (not amount transferred to [target]). If [copy] is 1, copies reagents instead.

		trans_to(var/atom/target, var/amount = 1, var/multiplier = 1, var/copy = 0)
			The general proc for applying reagents to things externally (as opposed to directly injected into the contents).
			It first calls touch, then the appropriate trans_to_*() or splash_mob().
			If for some reason you want touch effects to be bypassed (e.g. injecting stuff directly into a reagent container or person), call the appropriate trans_to_*() proc.

			Calls touch() before checking the type of [target], calling splash_mob(target, amount), trans_to_turf(target, amount, multiplier, copy), or trans_to_obj(target, amount, multiplier, copy).

		trans_id_to(var/atom/target, var/id, var/amount = 1)
			Transfers [amount] of [id] to [target]. Returns amount transferred.
*/

// Brain is defined in brain_item.dm.
/obj/item/organ/internal/heart/arachna // Heart in spider abdomen
	icon_state = "heart-on"
	parent_organ = BP_GROIN

/obj/item/organ/internal/kidneys/arachna
	parent_organ = BP_CHEST

/obj/item/organ/internal/liver/arachna
	parent_organ = BP_CHEST

/obj/item/organ/internal/appendix/arachna
	parent_organ = BP_CHEST

/obj/item/organ/internal/arachna/poison_gland
	name = "poison_gland"
	organ_tag = "poison_gland"
	parent_organ = BP_HEAD
	var/list/poisons = list()
	var/delay = 0
	var/bite_ready = 0

/*/obj/item/organ/internal/arachna/poison_gland/New()
	..()
	create_reagents(0)*/

/obj/item/organ/internal/arachna/poison_gland/proc/init(var/list/init_reagents)
	del(reagents)
	create_reagents(init_reagents.len * 5)
	poisons = init_reagents
	for (var/reagent in poisons)
		reagents.add_reagent(reagent, 5)

/obj/item/organ/internal/arachna/poison_gland/process()
	..()
	if(!owner || owner.stat || !reagents  || (!poisons.len))// если не в хоз€ине или хоз€ин мертв или не инциализирован список реагентов или не выбраны реагенты
		return
	if (!reagents.get_free_space())
		return
	else if (delay != 0)
		delay --
		return
	for (var/poison in poisons)
		reagents.add_reagent(poison, 1)
	delay = 20
	//owner.nutriment --
	return


/obj/item/organ/internal/arachna/silk_gland
	name = "silk_gland"
	organ_tag = "silk_gland"
	parent_organ = BP_GROIN
	var/silk = 50
	var/silk_max=100
	var/delay = 0

/obj/item/organ/internal/arachna/silk_gland/process()
	..()
	if(!owner || owner.stat)// если не в хоз€ине или хоз€ин мертв
		//owner << "\red silk gland not work."
		return
	if (silk >= silk_max)
		//owner << "\red silk gland full"
		return
	else if (delay > 0)
		delay --
		//owner << "\red silk gland [delay]"
		return
	else if (delay < 0)
		delay = 0
	silk++
	delay = 5
	//owner.nutriment --
	return