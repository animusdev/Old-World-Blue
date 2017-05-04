/mob/living/carbon/verb/give()
	set category = null
	set name = "Give to"
	set src in oview(1)

	if(istype(usr, /mob/living) && src != usr)
		var/mob/living/L = usr
		L.handle_give(src)

/mob/living/verb/handle_give(var/mob/target)
	set category = "IC"
	set name = "Give"

	return

/mob/living/carbon/handle_give(var/mob/target)
	set category = "IC"
	set name = "Give"

	if(stat)
		return

	var/obj/item/I = src.get_active_hand()
	if(!I)
		src << SPAN_WARN("You don't have anything in your active hand!")
		return

	if(!target)
		var/list/target_list = list()
		for(var/mob/living/carbon/C in view(1,src))
			if((C == usr) || (C.loc == usr))
				continue
			target_list += C

		target = input(src, "Select whom you wanna give [I]") as anything in target_list

	if(!istype(target) || target.stat || target.client == null)
		return

	if(!Adjacent(target))
		src << SPAN_WARN("You need to stay in reaching distance while giving an object.")
		if(src in view(world.view, target))
			target << SPAN_WARN("[src] wanna give you [I] but moved too far away.")
		return

	if(!target.get_active_hand() || !target.get_inactive_hand())
		switch(alert(target,"[usr] wants to give you \a [I]?",,"Yes","No"))
			if("Yes")
				if(!I)
					return
				if(!Adjacent(usr))
					src << SPAN_WARN("You need to stay in reaching distance while giving an object.")
					target << SPAN_WARN("[usr.name] moved too far away.")
					return
				if(src.get_active_hand() != I)
					src << SPAN_WARN("You need to keep the item in your active hand.")
					target << SPAN_WARN("[usr.name] seem to have given up on giving \the [I.name] to you.")
					return
				if(target.get_active_hand() && target.get_inactive_hand())
					target << SPAN_WARN("Your hands are full.")
					src << SPAN_WARN("Their hands are full.")
					return
				if(!src.unEquip(I))
					return
				target.put_in_hands(I)
				target.visible_message(SPAN_NOTE("[src] handed \the [I.name] to [target]."))
			if("No")
				target.visible_message(SPAN_WARN("[src] tried to hand [I] to [target] but \he didn't want it."))
	else
		usr << SPAN_WARN("[target.name]'s hands are full.")
