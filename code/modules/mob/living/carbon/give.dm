/mob/living/carbon/verb/give_target()
	set category = null
	set name = "Give to"
	set src in oview(1)

	if(stat)
		return

	if(istype(usr, /mob/living) && src != usr)
		var/mob/living/L = usr
		L.handle_give(src)

/mob/living/verb/give()
	set category = "IC"
	set name = "Give"

	if(stat)
		return

	var/obj/item/I = src.get_active_hand()
	if(!I)
		src << SPAN_WARN("You don't have anything in your active hand!")
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/C in view(1,src))
		if((C == src) || (C.loc == src))
			continue
		target_list += C

	var/mob/living/carbon/target = input(src, "Select whom you wanna give [I]") as anything in target_list
	handle_give(target)


/mob/living/proc/handle_give(var/mob/living/target)

/mob/living/carbon/handle_give(var/mob/living/target)
	if(stat)
		return

	if(!istype(target) || target.stat || !target.client)
		src << SPAN_WARN("[target] is not respond.")
		return

	var/obj/item/I = src.get_active_hand()
	if(!I)
		src << SPAN_WARN("You don't have anything in your active hand!")
		return

	if(!Adjacent(target))
		src << SPAN_WARN("You need to stay in reaching distance while giving an object.")
		if(src in view(world.view, target))
			target << SPAN_WARN("[src] tried give you [I] but moved too far away.")
		return

	if(target.get_active_hand() && target.get_inactive_hand())
		src << SPAN_WARN("[target.name]'s hands are full.")
	else switch(alert(target,"[src] wants to give you \a [I]?",,"Yes","No"))
		if("Yes")
			if(!I)
				return
			if(!Adjacent(target))
				src << SPAN_WARN("You need to stay in reaching distance while giving an object.")
				target << SPAN_WARN("[src] moved too far away.")
				return
			if(src.get_active_hand() != I)
				src << SPAN_WARN("You need to keep the item in your active hand.")
				target << SPAN_WARN("[src] seem to have given up on giving \the [I.name] to you.")
				return
			if(target.get_active_hand() && target.get_inactive_hand())
				target << SPAN_WARN("Your hands are full.")
				src << SPAN_WARN("[target] hands are full.")
				return
			if(!src.unEquip(I))
				return
			target.put_in_hands(I)
			target.visible_message(SPAN_NOTE("[src] handed \the [I.name] to [target]."))
		if("No")
			target.visible_message(SPAN_WARN("[src] tried to hand [I] to [target] but \he didn't want it."))

/mob/living/silicon/robot/handle_give(var/mob/living/target)
	if(stat)
		return

	if(!istype(target) || target.stat || !target.client)
		src << SPAN_WARN("[target] is not respond.")
		return

	var/obj/item/weapon/gripper/G = src.get_active_hand()
	if(!istype(G) || !G.wrapped)
		src << SPAN_WARN("You have nothing to give!")
		return
	var/obj/item/I = G.wrapped

	if(!Adjacent(target))
		src << SPAN_WARN("You need to stay in reaching distance while giving an object.")
		if(src in view(world.view, target))
			target << SPAN_WARN("[src] tried give you [I] but moved too far away.")
		return

	if(target.get_active_hand() && target.get_inactive_hand())
		src << SPAN_WARN("[target.name]'s hands are full.")
	else switch(alert(target,"[src] wants to give you \a [I]?",,"Yes","No"))
		if("Yes")
			if(!G || !I)
				return
			if(!Adjacent(target))
				src << SPAN_WARN("You need to stay in reaching distance while giving an object.")
				target << SPAN_WARN("[src] moved too far away.")
				return
			if(src.get_active_hand() != G || G.wrapped != I)
				src << SPAN_WARN("You need to keep the item in your active gripper.")
				target << SPAN_WARN("[src] seem to have given up on giving \the [I.name] to you.")
				return
			if(target.get_active_hand() && target.get_inactive_hand())
				target << SPAN_WARN("Your hands are full.")
				src << SPAN_WARN("[target] hands are full.")
				return
			if(!src.unEquip(I))
				return
			target.put_in_hands(I)
			target.visible_message(SPAN_NOTE("[src] handed \the [I.name] to [target]."))
		if("No")
			target.visible_message(SPAN_WARN("[src] tried to hand [I] to [target] but \he didn't want it."))

