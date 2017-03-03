/obj/item/weapon/tape_roll
	name = "tape roll"
	desc = "A roll of sticky tape. Possibly for taping ducks... or was that ducts?"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "taperoll"
	w_class = 1
	var/in_action = 0

/* -- Disabled for now until it has a use --
/obj/item/weapon/tape_roll/attack_self(mob/user as mob)
	user << "You remove a length of tape from [src]."

	var/obj/item/weapon/ducttape/tape = new()
	user.put_in_hands(tape)
*/

/obj/item/weapon/tape_roll/proc/stick(var/obj/item/weapon/W, mob/user)
	if(!istype(W, /obj/item/weapon/paper))
		return

	user.drop_from_inventory(W)
	var/obj/item/weapon/ducttape/tape = new(get_turf(src))
	tape.attach(W)
	user.put_in_hands(tape)

/obj/item/weapon/tape_roll/attack(mob/living/carbon/C as mob, mob/living/carbon/user as mob)
	if(!istype(C))	return ..()
	if(in_action)
		return
	in_action = 1
	if(user.zone_sel.selecting == O_MOUTH || user.zone_sel.selecting == BP_HEAD)
		if(!C.wear_mask)
			if(C==user)
				if(user.equip_to_slot_or_del( new/obj/item/clothing/mask/muzzle/tape(user), slot_wear_mask))
					C.update_inv_wear_mask()
				in_action = 0
				return

			var/turf/p_loc = user.loc
			var/turf/p_loc_m = C.loc
			playsound(src.loc, 'sound/weapons/tapecuff.wav', 30, 1, -2)
			user.visible_message("\red <B>[user] is trying to close up [C]'s mouth with [src]!</B>")

			if (ishuman(C))
				var/can_use = 0
				for (var/obj/item/weapon/grab/G in C.grabbed_by)
					if (G.loc == user && G.state >= GRAB_AGGRESSIVE)
						can_use = 1
						break
				if(!can_use) return
				var/mob/living/carbon/human/H = C
				if (!H.has_organ_for_slot(slot_wear_mask))
					in_action = 0
					return

				spawn(12)
					if(!C)
						in_action = 0
						return
					if(p_loc == user.loc && p_loc_m == C.loc)
						var/obj/item/clothing/mask/muzzle/tape/T = new(C)
						if(C.equip_to_slot_or_del(T, slot_wear_mask))
							C.update_inv_wear_mask()
		in_action = 0

	else
		if(C!=user)
			var/obj/item/weapon/handcuffs/tape/T = new(src)
			T.attack(C, user)
		in_action = 0

/obj/item/weapon/tape_piece
	name = "utilized piece of tape"
	desc = "Not sticky for now"
	icon_state = "taperoll_piece"

/obj/item/weapon/ducttape
	name = "tape"
	desc = "A piece of sticky tape."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "tape"
	w_class = 1
	layer = 4
	anchored = 1 //it's sticky, no you cant move it

	var/obj/item/weapon/stuck = null

/obj/item/weapon/ducttape/New()
	..()
	flags |= NOBLUDGEON

/obj/item/weapon/ducttape/examine(mob/user, return_dist = 0)
	return stuck.examine(user, return_dist)

/obj/item/weapon/ducttape/proc/attach(var/obj/item/weapon/W)
	stuck = W
	W.forceMove(src)
	icon_state = W.icon_state + "_taped"
	name = W.name + " (taped)"
	overlays = W.overlays

/obj/item/weapon/ducttape/attack_self(mob/user)
	if(!stuck)
		return

	user << "You remove \the [initial(name)] from [stuck]."

	user.drop_from_inventory(src)
	user.put_in_hands(stuck)
	stuck = null
	overlays = null
	qdel(src)

/obj/item/weapon/ducttape/afterattack(var/A, mob/user, flag, params)
	if(!in_range(user, A) || istype(A, /obj/machinery/door) || !stuck)
		return

	var/turf/target_turf = get_turf(A)
	var/turf/source_turf = get_turf(user)

	var/dir_offset = 0
	if(target_turf != source_turf)
		dir_offset = get_dir(source_turf, target_turf)
		if(!(dir_offset in cardinal))
			user << "You cannot reach that from here."		// can only place stuck papers in cardinal directions, to
			return											// reduce papers around corners issue.

	user.drop_from_inventory(src)
	forceMove(source_turf)

	if(params)
		var/list/mouse_control = params2list(params)
		if(mouse_control["icon-x"])
			pixel_x = text2num(mouse_control["icon-x"]) - 16
			if(dir_offset & EAST)
				pixel_x += 32
			else if(dir_offset & WEST)
				pixel_x -= 32
		if(mouse_control["icon-y"])
			pixel_y = text2num(mouse_control["icon-y"]) - 16
			if(dir_offset & NORTH)
				pixel_y += 32
			else if(dir_offset & SOUTH)
				pixel_y -= 32
