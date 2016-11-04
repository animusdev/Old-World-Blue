/mob/living/carbon/verb/give(var/mob/living/carbon/target in view(1)-usr)
	set category = "IC"
	set name = "Give"
	if(!istype(target) || target.stat == 2 || usr.stat == 2|| target.client == null)
		return
	var/obj/item/I
	if(!usr.hand && usr.r_hand == null)
		usr << "<span class='warning'>You don't have anything in your right hand to give to [target.name]</span>"
		return
	if(usr.hand && usr.l_hand == null)
		usr << "<span class='warning'>You don't have anything in your left hand to give to [target.name]</span>"
		return
	I = usr.get_active_hand()
	if(!I)
		return
	if(target.r_hand == null || target.l_hand == null)
		switch(alert(target,"[usr] wants to give you \a [I]?",,"Yes","No"))
			if("Yes")
				if(!I)
					return
				if(!Adjacent(usr))
					usr << "<span class='warning'>You need to stay in reaching distance while giving an object.</span>"
					target << "<span class='warning'>[usr.name] moved too far away.</span>"
					return
				if((usr.hand && usr.l_hand != I) || (!usr.hand && usr.r_hand != I))
					usr << "<span class='warning'>You need to keep the item in your active hand.</span>"
					target << "<span class='warning'>[usr.name] seem to have given up on giving \the [I.name] to you.</span>"
					return
				if(target.r_hand != null && target.l_hand != null)
					target << "<span class='warning'>Your hands are full.</span>"
					usr << "<span class='warning'>Their hands are full.</span>"
					return
				if(!usr.unEquip(I))
					usr << "<span class='warning'>You can't drop [I]</span>"
					return
				target.put_in_hands(I)
				target.visible_message("<span class='notice'>[usr.name] handed \the [I.name] to [target.name].</span>")
			if("No")
				target.visible_message("<span class='warning'>[usr.name] tried to hand [I.name] to [target.name] but [target.name] didn't want it.</span>")
	else
		usr << "<span class='warning'>[target.name]'s hands are full.</span>"
