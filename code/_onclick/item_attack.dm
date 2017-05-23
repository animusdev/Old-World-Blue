/*
=== Item Click Call Sequences ===
These are the default click code call sequences used when clicking on stuff with an item.

Atoms:

mob/ClickOn() calls the item's resolve_attackby() proc.
item/resolve_attackby() calls the target atom's attackby() proc.

*/

// Called when the item is in the active hand, and clicked; alternately, there is an 'activate held object' verb or you can hit pagedown.
/obj/item/proc/attack_self(mob/user)
	return

//I would prefer to rename this to attack(), but that would involve touching hundreds of files.
/obj/item/proc/resolve_attackby(atom/A, mob/user, var/click_params)
	add_fingerprint(user)
	return A.attackby(src, user, click_params)

// No comment
/atom/proc/attackby(obj/item/W, mob/user, var/click_params)
	return

/atom/movable/attackby(obj/item/W, mob/user)
	if(!(W.flags & NOBLUDGEON))
		visible_message("<span class='danger'>[src] has been hit by [user] with [W].</span>")

/mob/living/attackby(obj/item/I, mob/user)
	if(!ismob(user))
		return 0
	if(can_operate(src) && I.do_surgery(src,user)) //Surgery
		return 1
	user.next_move = world.time + 8
	return I.attack(src, user, user.zone_sel.selecting)

// Proximity_flag is 1 if this afterattack was called on something adjacent, in your square, or on your person.
// Click parameters is the params string from byond Click() code, see that documentation.
/obj/item/proc/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	return

//I would prefer to rename this attack_as_weapon(), but that would involve touching hundreds of files.
/obj/item/proc/attack(mob/living/M, mob/living/user, var/target_zone)
	if(!force || (flags & NOBLUDGEON))
		return 0
	if(M == user && user.a_intent != I_HURT)
		return 0

	// Knifing
	if(edge)
		for(var/obj/item/weapon/grab/G in M.grabbed_by)
			if(G.assailant == user && G.state >= GRAB_NECK && world.time >= (G.last_action + 20))
				//TODO: better alternative for applying damage multiple times? Nice knifing sound?
				M.apply_damage(20, BRUTE, BP_HEAD, 0, sharp=sharp, edge=edge)
				M.apply_damage(20, BRUTE, BP_HEAD, 0, sharp=sharp, edge=edge)
				M.apply_damage(20, BRUTE, BP_HEAD, 0, sharp=sharp, edge=edge)
				M.adjustOxyLoss(60) // Brain lacks oxygen immediately, pass out
				flick(G.hud.icon_state, G.hud)
				G.last_action = world.time
				user.visible_message("<span class='danger'>[user] slit [M]'s throat open with \the [name]!</span>")
				admin_attack_log(user, M,
					"Knifed [key_name(M)] with [name]",
					"Got knifed by [key_name(user)] with [name]",
					"used [name] to knifed"
				)
				return

	/////////////////////////
	user.lastattacked = M
	M.lastattacker = user

	if(!no_attack_log)
		admin_attack_log(user, M,
			"Attacked [key_name(M)] with [name] (DAMTYE: [uppertext(damtype)])",
			"Attacked by [key_name(user)] with [name] (DAMTYE: [uppertext(damtype)])",
			"used [name] (INTENT: [uppertext(user.a_intent)]) (DAMTYE: [uppertext(damtype)]) to attack"
		)
	/////////////////////////

	var/power = force
	//TODO: DNA3 hulk
	/*
	if(HULK in user.mutations)
		power *= 2
	*/

	// TODO: needs to be refactored into a mob/living level attacked_by() proc. ~Z
	user.do_attack_animation(M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M

		// Handle striking to cripple.
		var/dislocation_str
		if(user.a_intent == "disarm")
			dislocation_str = H.attack_joint(src, user, target_zone)
		if(H.attacked_by(src, user, target_zone) && hitsound)
			playsound(loc, hitsound, 50, 1, -1)
			spawn(1) //ugh I hate this but I don't want to root through human attack procs to print it after this call resolves.
				if(dislocation_str) user.visible_message("<span class='danger'>[dislocation_str]</span>")
			return 1
		return 0
	else
		if(attack_verb)
			user.visible_message("<span class='danger'>[M] has been [pick(attack_verb)] with [src] by [user]!</span>")
		else
			user.visible_message("<span class='danger'>[M] has been attacked with [src] by [user]!</span>")

		if (hitsound)
			playsound(loc, hitsound, 50, 1, -1)
		switch(damtype)
			if("brute")
				M.take_organ_damage(power)
				if(prob(33)) // Added blood for whacking non-humans too
					var/turf/simulated/location = get_turf(M)
					if(istype(location)) location.add_blood_floor(M)
			if("fire")
				M.take_organ_damage(0, power)
				M << "Aargh it burns!"
		M.updatehealth()
	add_fingerprint(user)
	return 1
