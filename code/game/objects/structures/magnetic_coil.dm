//
/obj/machinery/magnetic_coil
	name = "Magnetic coil"
	desc = "Coil + wires = magnet"
	icon = 'icons/obj/magcoil.dmi'
	icon_state = "magnocoil"
	density = 1
	var/cable = 0
	var/active = 0
	var/power = 0
	var/magnetic_range = 2
	use_power = 0


	update_icon()
		if(cable)
			if(active && power)
				icon_state = "magcoilon"
			else
				icon_state = "magcoil"
		else
			icon_state = "magnocoil"

	attackby(obj/item/W, mob/user)
		if(iswrench(W))
			if(active)
				user << "Turn off the coil first"
				return
			anchored = !anchored
			playsound(src.loc, 'sound/items/Ratchet.ogg', 75, 1)    // [user] secures the magnetic coil assembly to the floor.
			if(anchored)
				user.visible_message("[user] secures [src.name] to the floor.", "You secure [src] to the floor.")
			else
				user.visible_message("[user]unsecures [src.name] from the floor.", "You unsecure [src] from the floor.")
		else if(!anchored && iscrowbar(W))
			user.visible_message("[user] disassembles [src.name].", "You disassemble [src].")
			if(cable)
				new/obj/item/stack/cable_coil(loc,15)
			new/obj/item/stack/material/steel(loc,2)
			del(src)
		else if(cable==0 && iscoil(W))
			if(W:use(15,user))
				user.visible_message("[user] adds wires to the [src.name].", "You add some wires.")
				cable = 1
				update_icon()
			else
				user << "You need more cable"
		else if(isscrewdriver(W))
			magnetic_range++
			if(magnetic_range>4)
				magnetic_range = initial(magnetic_range)
			user.visible_message("[user] adjusts the [src.name].", "You set magnetic range to [magnetic_range].")

	attack_hand(mob/user as mob)
		if(!cable) return
		if(!anchored)
			user << "Secure the coil to the floor"
			return
		active = !active
		user.visible_message("[user] [active?"activates":"deactivates"] the [src.name].", "You [active?"activate":"deactivate"] the [src.name].")
		update_icon()

	process()
		power()
		if(power)
			for(var/obj/M in orange(magnetic_range, src.loc))
				if(!M.anchored && (M.flags & CONDUCT))
					step_towards(M, src)

			for(var/mob/living/silicon/S in orange(magnetic_range, src.loc))
				if(istype(S, /mob/living/silicon/ai)) continue
				step_towards(S, src)

	proc/power()
		if(!anchored || !cable || !active)
			power = 0
			return
		var/turf/T = src.loc

		var/obj/structure/cable/C = T.get_cable_node()
		var/datum/powernet/PN
		if(C)	PN = C.powernet		// find the powernet of the connected cable

		if(!PN)
			power = 0
			update_icon()
			return

		var/surplus = PN.avail-PN.load
		var/needpower = 600*magnetic_range
		if(surplus < needpower)		// no cable or no power, and no power stored
			power = 0
		else
			power = 1
			if(PN)
				PN.load += needpower
		update_icon()
