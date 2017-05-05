/obj/item/robot_parts
	name = "robot parts"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	icon = 'icons/obj/robot_parts.dmi'
	item_state = "buildpipe"
	icon_state = "blank"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	dir = SOUTH
	var/body_part = "part"

/obj/item/robot_parts/set_dir()
	return

/obj/item/robot_parts/proc/is_ready(var/mob/living/user)
	return TRUE

/obj/item/robot_parts/l_arm
	name = "left arm"
	icon_state = "l_arm"
	body_part = "l_arm"
	matter = list(DEFAULT_WALL_MATERIAL = 12000)

/obj/item/robot_parts/r_arm
	name = "right arm"
	icon_state = "r_arm"
	body_part = "r_arm"
	matter = list(DEFAULT_WALL_MATERIAL = 12000)

/obj/item/robot_parts/l_leg
	name = "left leg"
	icon_state = "l_leg"
	body_part = "l_leg"
	matter = list(DEFAULT_WALL_MATERIAL = 10000)

/obj/item/robot_parts/r_leg
	name = "right leg"
	icon_state = "r_leg"
	body_part = "r_leg"
	matter = list(DEFAULT_WALL_MATERIAL = 10000)

/obj/item/robot_parts/chest
	name = "torso"
	desc = "A heavily reinforced case containing cyborg logic boards, with space for a standard power cell."
	icon_state = "chest"
	body_part = "chest"
	matter = list(DEFAULT_WALL_MATERIAL = 32000)
	var/wires = 0.0
	var/obj/item/weapon/cell/cell = null

/obj/item/robot_parts/chest/is_ready(var/mob/living/user)
	if(!wires)
		user << SPAN_WARN("You need to attach wires to it first!")
		return FALSE
	else if(!cell)
		user << SPAN_WARN("You need to attach a cell to it first!")
		return FALSE
	return TRUE

/obj/item/robot_parts/head
	name = "head"
	desc = "A standard reinforced braincase, with spine-plugged neural socket and sensor gimbals."
	icon_state = "head"
	body_part = "head"
	matter = list(DEFAULT_WALL_MATERIAL = 20000)
	var/obj/item/device/flash/flash1 = null
	var/obj/item/device/flash/flash2 = null

/obj/item/robot_parts/head/is_ready(var/mob/living/user)
	if(!flash1 || !flash2)
		user << SPAN_WARN("You need to attach a flash to it first!")
		return FALSE
	return TRUE

/obj/item/robot_parts/robot_suit
	name = "endoskeleton"
	desc = "A complex metal backbone with standard limb sockets and pseudomuscle anchors."
	icon_state = "robo_suit"
	matter = list(DEFAULT_WALL_MATERIAL = 42000)
	var/list/req_parts = list(
		"chest",
		"head",
		"l_arm",
		"r_arm",
		"l_leg",
		"r_leg"
	)
	var/list/parts = list()
	var/created_name = ""

/obj/item/robot_parts/robot_suit/with_limbs/New()
	..()
	var/list/preinstalled = list(
		/obj/item/robot_parts/r_arm,
		/obj/item/robot_parts/l_arm,
		/obj/item/robot_parts/r_leg,
		/obj/item/robot_parts/l_leg
	)
	for(var/path in preinstalled)
		var/obj/item/robot_parts/P = new path (src)
		parts[P.body_part] = P
	update_icon()

/obj/item/robot_parts/robot_suit/update_icon()
	src.overlays.Cut()
	for(var/part in parts)
		if(parts[part])
			overlays += "[part]+o"

/obj/item/robot_parts/robot_suit/is_ready()
	var/list/missed = req_parts - parts
	return !missed.len

/obj/item/robot_parts/robot_suit/attackby(obj/item/W as obj, mob/user as mob)
	..()
	if(istype(W, /obj/item/stack/material) && W.get_material_name() == DEFAULT_WALL_MATERIAL && !parts.len)
		var/obj/item/stack/material/M = W
		if (M.use(1))
			var/obj/item/weapon/secbot_assembly/ed209_assembly/B = new(loc)
			B.loc = get_turf(src)
			user << SPAN_NOTE("You armed the robot frame.")
			if (user.get_inactive_hand() == src)
				user.remove_from_mob(src)
				user.put_in_inactive_hand(B)
			qdel(src)
		else
			user << SPAN_WARN("You need one sheet of metal to arm the robot frame.")

	if(istype(W, /obj/item/weapon/wrench))
		var/part = input("Select part for detach", "Detach") \
			as null|anything in parts
		var/obj/item/robot_parts/selected = part ? parts[part] : null
		if(!Adjacent(user) || !selected) return

		playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
		if(!do_after(user, 30, src))
			user << SPAN_NOTE("You stop detaching [selected].")
			return

		if(selected.loc == src)
			parts -= selected.body_part
		else
			return

		selected.forceMove(get_turf(src))
		src.update_icon()
		user.visible_message(
			SPAN_NOTE("[user] detached [selected] from [src]."),
			SPAN_NOTE("You had successfuly detach [selected] from [src]."),
			SPAN_WARN("You have hear how something metallic hit the floor.")
		)
		return

	if(istype(W, /obj/item/robot_parts))
		var/obj/item/robot_parts/RP = W
		if(!req_parts.Find(RP.body_part))
			user << SPAN_WARN("You can't attach that here!")
			return
		if(parts[RP.body_part])
			user << SPAN_WARN("There is already one [parts[RP.body_part]] attached.")
			return
		if(!RP.is_ready(user))
			return
		parts[RP.body_part] = RP

		user.drop_from_inventory(W, src)
		src.update_icon()

	if(istype(W, /obj/item/device/mmi))
		var/obj/item/device/mmi/M = W
		if(!is_ready(user))
			user << "<span class='warning'>The MMI must go in after everything else!</span>"
			return

		if(!istype(loc,/turf))
			user << SPAN_WARN("You can't put \the [W] in, the frame has to be standing on the ground to be perfectly precise.")
			return
		if(!M.brainmob)
			user << SPAN_WARN("Sticking an empty [W] into the frame would sort of defeat the purpose.")
			return
		if(!M.brainmob.key)
			var/ghost_can_reenter = 0
			if(M.brainmob.mind)
				for(var/mob/observer/dead/G in player_list)
					if(G.can_reenter_corpse && G.mind == M.brainmob.mind)
						ghost_can_reenter = 1
						break
			if(!ghost_can_reenter)
				user << SPAN_NOTE("\The [W] is completely unresponsive; there's no point.")
				return

		if(M.brainmob.stat == DEAD)
			user << SPAN_WARN("Sticking a dead [W] into the frame would sort of defeat the purpose.")
			return

		if(jobban_isbanned(M.brainmob, "Cyborg"))
			user << SPAN_WARN("This [W] does not seem to fit.")
			return

		var/mob/living/silicon/robot/O = new (get_turf(loc), unfinished = 1)
		if(!O)	return

		user.unEquip(M)

		O.mmi = M
		O.invisibility = 0
		O.custom_name = created_name
		O.updatename("Default")

		M.brainmob.mind.transfer_to(O)

		if(O.mind && O.mind.special_role)
			O.mind.store_memory({"
				In case you look at this after being borged,
				the objectives are only here until I find a way to make them not show up for you,
				as I can't simply delete them without screwing up round-end reporting. --NeoFite
			"})

		O.job = "Cyborg"
		var/obj/item/robot_parts/chest/chest = parts["chest"]
		O.cell = chest.cell
		O.cell.loc = O
		W.loc = O//Should fix cybros run time erroring when blown up. It got deleted before, along with the frame.

		// Since we "magically" installed a cell, we also have to update the correct component.
		if(O.cell)
			var/datum/robot_component/cell_component = O.components["power cell"]
			cell_component.wrapped = O.cell
			cell_component.installed = 1

		callHook("borgify", list(O))
		O.Namepick()

		qdel(src)

	if (istype(W, /obj/item/weapon/pen))
		var/t = sanitizeSafe(input(user, "Enter new robot name", src.name, src.created_name), MAX_NAME_LEN)
		if (!t)
			return
		if (!in_range(src, usr) && src.loc != usr)
			return

		src.created_name = t

	return

/obj/item/robot_parts/chest/attackby(obj/item/W as obj, mob/user as mob)
	..()
	if(isscrewdriver(W))
		if(cell)
			user << "<span class='warning'>You eject the cell!</span>"
			user.put_in_hands(cell)
			cell = null
		else
			user << "<span class='warning'There is nothing to eject.</span>"
		return
	else if(istype(W, /obj/item/weapon/cell))
		if(src.cell)
			user << "<span class='warning'>You have already inserted a cell!</span>"
		else
			user.drop_from_inventory(W, src)
			src.cell = W
			user << "<span class='notice'>You insert the cell!</span>"
		return
	else if(iswirecutter(W))
		if(wires)
			var/obj/item/stack/cable_coil/cut/C = new(src.loc)
			C.color = wires
			wires = 0
			user.put_in_hands(C)
			user << "<span class='warning'>You cut the wire!</span>"
		else
			user << "<span class='warning'>There is no wire inside!</span>"
	else if(iswire(W))
		if(src.wires)
			user << "<span class='warning'>You have already inserted wire!</span>"
			return
		else
			var/obj/item/stack/cable_coil/coil = W
			coil.use(1)
			src.wires = W.color
			user << "<span class='notice'>You insert the wire!</span>"
	return

/obj/item/robot_parts/head/attackby(obj/item/W as obj, mob/user as mob)
	..()
	if(istype(W, /obj/item/device/flash))
		if(istype(user,/mob/living/silicon/robot))
			var/current_module = user.get_active_hand()
			if(current_module == W)
				user << "<span class='warning'>How do you propose to do that?</span>"
				return
			else
				add_flashes(W,user)
		else
			add_flashes(W,user)
	else if(isscrewdriver(W) && (flash1 || flash2))
		if(flash2)
			user.put_in_hands(flash2)
			user.visible_message("<span class='notice'>[user] eject [flash2] from [src].</span>")
			flash2 = null
		else if(flash1)
			user.put_in_hands(flash1)
			user.visible_message("<span class='notice'>[user] eject [flash1] from [src].</span>")
			flash1 = null
		else
			user << "<span class='warning'There is nothing to eject.</span>"
			return
	else if(istype(W, /obj/item/weapon/stock_parts/manipulator))
		user << "<span class='notice'>You install some manipulators and modify the head, creating a functional spider-bot!</span>"
		new /mob/living/simple_animal/spiderbot(get_turf(loc))
		user.drop_from_inventory(W)
		qdel(W)
		qdel(src)
		return
	return

//Made into a seperate proc to avoid copypasta
/obj/item/robot_parts/head/proc/add_flashes(obj/item/W as obj, mob/user as mob)
	if(src.flash1 && src.flash2)
		user << "<span class='notice'>You have already inserted the eyes!</span>"
		return
	else if(src.flash1)
		src.flash2 = W
	else
		src.flash1 = W
	user.drop_from_inventory(W, src)
	user << "<span class='notice'>You insert the flash into the eye socket!</span>"
