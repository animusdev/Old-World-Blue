/obj/item/device/flashlight
	name = "flashlight"
	desc = "A hand-held emergency light."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "flashlight"
	item_state = "flashlight"
	w_class = 2
	flags = CONDUCT
	slot_flags = SLOT_BELT

	matter = list(DEFAULT_WALL_MATERIAL = 50,"glass" = 20)

	icon_action_button = "action_flashlight"
	var/on = 0
	var/brightness_on = 4 //luminosity when on
	var/obj/item/weapon/cell/cell
	var/cell_type = /obj/item/weapon/cell/device
	var/power_usage
	var/power_use = 1
	var/list/brightness_levels
	var/brightness_level = "medium"

/obj/item/device/flashlight/initialize()
	..()
	update_icon()

/obj/item/device/flashlight/New()
	if(power_use)
		processing_objects |= src

		if(cell_type)
			cell = new cell_type(src)
			brightness_levels = list("low" = 0.25, "medium" = 0.5, "high" = 1)
			power_usage = brightness_levels[brightness_level]

	else
		verbs -= /obj/item/device/flashlight/verb/toggle
	..()

/obj/item/device/flashlight/verb/toggle()
	set name = "Toggle Flashlight Brightness"
	set category = "Object"
	set src in usr
	set_brightness(usr)

/obj/item/device/flashlight/Destroy()
	if(power_use)
		processing_objects -= src
	..()

/obj/item/device/flashlight/proc/set_brightness(mob/user as mob)
	var/choice = input("Choose a brightness level.") as null|anything in brightness_levels
	if(choice)
		brightness_level = choice
		power_usage = brightness_levels[choice]
		user << "<span class='notice'>You set the brightness level on \the [src] to [brightness_level].</span>"
		update_icon()

/obj/item/device/flashlight/process()
	if(on)
		if(cell)
			if(brightness_level && power_usage)
				if(power_usage < cell.charge)
					cell.charge -= power_usage
				else
					cell.charge = 0
					visible_message("<span class='warning'>\The [src] flickers before going dull.</span>")
					set_light(0)
					on = 0
					update_icon()


/obj/item/device/flashlight/update_icon()
	if(on)
		icon_state = "[initial(icon_state)]-on"

		if(brightness_level == "low")
			set_light(brightness_on/2)
		else if(brightness_level == "high")
			set_light(brightness_on*4)
		else
			set_light(brightness_on)

	else
		icon_state = "[initial(icon_state)]"
		set_light(0)

/obj/item/device/flashlight/examine(mob/user)
	..()
	if(power_use && brightness_level)
		var/tempdesc
		tempdesc += "\The [src] is set to [brightness_level]. "
		if(cell)
			tempdesc += "\The [src] has a \the [cell] attached. "

			if(cell.charge <= cell.maxcharge*0.25)
				tempdesc += "It appears to have a low amount of power remaining."
			else if(cell.charge > cell.maxcharge*0.25 && cell.charge <= cell.maxcharge*0.5)
				tempdesc += "It appears to have an average amount of power remaining."
			else if(cell.charge > cell.maxcharge*0.5 && cell.charge <= cell.maxcharge*0.75)
				tempdesc += "It appears to have an above average amount of power remaining."
			else if(cell.charge > cell.maxcharge*0.75 && cell.charge <= cell.maxcharge)
				tempdesc += "It appears to have a high amount of power remaining."

		user << "[tempdesc]"

/obj/item/device/flashlight/attack_self(mob/user)
	if(!isturf(user.loc))
		user << "You cannot turn the light on while in this [user.loc]." //To prevent some lighting anomalities.
		return 0
	on = !on
	update_icon()
	return 1


/obj/item/device/flashlight/attack(mob/living/M as mob, mob/living/user as mob)
	add_fingerprint(user)
	if(on && user.zone_sel.selecting == O_EYES)

		if(user.getBrainLoss() >= 60 && prob(50))	//too dumb to use flashlight properly
			return ..()	//just hit them in the head

		var/mob/living/carbon/human/H = M	//mob has protective eyewear
		if(istype(H))
			for(var/obj/item/clothing/C in list(H.head,H.wear_mask,H.glasses))
				if(istype(C) && (C.body_parts_covered & EYES))
					user << "<span class='warning'>You're going to need to remove [C.name] first.</span>"
					return

			var/obj/item/organ/vision
			if(H.species.vision_organ)
				vision = H.internal_organs_by_name[H.species.vision_organ]
			if(!vision)
				user << "<span class='warning'>You can't find any [H.species.vision_organ ? H.species.vision_organ : "eyes"] on [H]!</span>"

			user.visible_message("<span class='notice'>\The [user] directs [src] to [M]'s eyes.</span>", \
							 	 "<span class='notice'>You direct [src] to [M]'s eyes.</span>")
			if(H != user)	//can't look into your own eyes buster
				if(H.stat == DEAD || H.blinded)	//mob is dead or fully blind
					user << "<span class='warning'>\The [H]'s pupils do not react to the light!</span>"
					return
				if(XRAY in H.mutations)
					user << "<span class='notice'>\The [H] pupils give an eerie glow!</span>"
				if(vision.is_bruised())
					user << "<span class='warning'>There's visible damage to [H]'s [vision.name]!</span>"
				else if(M.eye_blurry)
					user << "<span class='notice'>\The [H]'s pupils react slower than normally.</span>"
				if(H.getBrainLoss() > 15)
					user << "<span class='notice'>There's visible lag between left and right pupils' reactions.</span>"

				var/list/pinpoint = list("oxycodone"=1,"tramadol"=5)
				var/list/dilating = list("space_drugs"=5,"mindbreaker"=1)
				if(M.reagents.has_any_reagent(pinpoint) || H.ingested.has_any_reagent(pinpoint))
					user << "<span class='notice'>\The [H]'s pupils are already pinpoint and cannot narrow any more.</span>"
				else if(H.reagents.has_any_reagent(dilating) || H.ingested.has_any_reagent(dilating))
					user << "<span class='notice'>\The [H]'s pupils narrow slightly, but are still very dilated.</span>"
				else
					user << "<span class='notice'>\The [H]'s pupils narrow.</span>"

			user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN) //can be used offensively
			flick("flash", M.flash)
			//M.flash_eyes()
	else
		return ..()

/obj/item/device/flashlight/attack_hand(mob/user as mob)
	if(user.get_inactive_hand() == src)
		if(cell)
			cell.update_icon()
			user.put_in_hands(cell)
			cell = null
			user << "<span class='notice'>You remove the cell from the [src].</span>"
			on = 0
			update_icon()
			return
		..()
	else
		return ..()

/obj/item/device/flashlight/attackby(obj/item/weapon/W, mob/user as mob)
	if(power_use)
		if(istype(W, /obj/item/weapon/cell))
			if(istype(W, /obj/item/weapon/cell/device))
				if(!cell)
					user.drop_from_inventory(W)
					W.loc = src
					cell = W
					user << "<span class='notice'>You install a cell in \the [src].</span>"
					update_icon()
				else
					user << "<span class='notice'>\The [src] already has a cell.</span>"
			else
				user << "<span class='notice'>\The [src] cannot use that type of cell.</span>"

	else
		..()

/obj/item/device/flashlight/pen
	name = "penlight"
	desc = "A pen-sized light, used by medical staff."
	icon_state = "penlight"
	item_state = ""
	flags = CONDUCT
	slot_flags = SLOT_EARS
	brightness_on = 2
	w_class = 1

/obj/item/device/flashlight/drone
	name = "low-power flashlight"
	desc = "A miniature lamp, that might be used by small robots."
	icon_state = "penlight"
	item_state = ""
	flags = CONDUCT
	brightness_on = 2
	w_class = 1

/obj/item/device/flashlight/heavy
	name = "heavy duty flashlight"
	desc = "A hand-held heavy-duty light."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "heavyduty"
	item_state = "heavyduty"
	brightness_on = 6

/obj/item/device/flashlight/seclite
	name = "security flashlight"
	desc = "A hand-held security flashlight. Very robust."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "seclite"
	item_state = "seclite"
	brightness_on = 5
	force = 10.0
	hitsound = 'sound/weapons/genhit1.ogg'


// the desk lamps are a bit special
/obj/item/device/flashlight/lamp
	name = "desk lamp"
	desc = "A desk lamp with an adjustable mount."
	icon_state = "lamp"
	item_state = "lamp"
	brightness_on = 5
	w_class = 4
	flags = CONDUCT

	on = 1


// green-shaded desk lamp
/obj/item/device/flashlight/lamp/green
	desc = "A classic green-shaded desk lamp."
	icon_state = "lampgreen"
	item_state = "lampgreen"
	brightness_on = 5
	light_color = "#FFC58F"

/obj/item/device/flashlight/lamp/verb/toggle_light()
	set name = "Toggle light"
	set category = "Object"
	set src in oview(1)

	if(!usr.stat)
		attack_self(usr)

/obj/item/device/flashlight/lamp/AltClick(var/mob/user)
	if(in_range(src,user))
		src.toggle_light()

// FLARES

/obj/item/device/flashlight/flare
	name = "flare"
	desc = "A red Nanotrasen issued flare. There are instructions on the side, it reads 'pull cord, make light'."
	w_class = 2.0
	brightness_on = 8 // Pretty bright.
	light_power = 3
	light_color = "#e58775"
	icon_state = "flare"
	item_state = "flare"
	icon_action_button = null	//just pull it manually, neckbeard.
	var/fuel = 0
	var/on_damage = 7
	var/produce_heat = 1500

/obj/item/device/flashlight/flare/New()
	fuel = rand(800, 1000) // Sorry for changing this so much but I keep under-estimating how long X number of ticks last in seconds.
	..()

/obj/item/device/flashlight/flare/process()
	var/turf/pos = get_turf(src)
	if(pos)
		pos.hotspot_expose(produce_heat, 5)
	fuel = max(fuel - 1, 0)
	if(!fuel || !on)
		turn_off()
		if(!fuel)
			src.icon_state = "[initial(icon_state)]-empty"
		processing_objects -= src

/obj/item/device/flashlight/flare/proc/turn_off()
	on = 0
	src.force = initial(src.force)
	src.damtype = initial(src.damtype)
	update_icon()

/obj/item/device/flashlight/flare/attack_self(mob/user)

	// Usual checks
	if(!fuel)
		user << "<span class='notice'>It's out of fuel.</span>"
		return
	if(on)
		return

	. = ..()
	// All good, turn it on.
	if(.)
		user.visible_message("<span class='notice'>[user] activates the flare.</span>", "<span class='notice'>You pull the cord on the flare, activating it!</span>")
		src.force = on_damage
		src.damtype = "fire"
		processing_objects += src

/obj/item/device/flashlight/slime
	gender = PLURAL
	name = "glowing slime extract"
	desc = "A glowing ball of what appears to be amber."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "floor1" //not a slime extract sprite but... something close enough!
	item_state = "slime"
	w_class = 1
	brightness_on = 6
	on = 1 //Bio-luminesence has one setting, on.

/obj/item/device/flashlight/slime/New()
	..()
	set_light(brightness_on)

/obj/item/device/flashlight/slime/update_icon()
	return

/obj/item/device/flashlight/slime/attack_self(mob/user)
	return //Bio-luminescence does not toggle.
