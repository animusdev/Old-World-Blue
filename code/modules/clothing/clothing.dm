/obj/item/clothing
	name = "clothing"
	siemens_coefficient = 0.9
	var/list/species_restricted = null //Only these species can wear this kit.
	var/gunshot_residue //Used by forensics.

	var/list/accessories = list()
	var/list/valid_accessory_slots
	var/list/restricted_accessory_slots
	var/list/starting_accessories

	/*
		Sprites used when the clothing item is refit. This is done by setting icon_override.
		Ideally, sprite_sheets_refit should be used for "hard" clothing items that can't change shape very well to fit the wearer (e.g. helmets, hardsuits).
	*/
	var/list/sprite_sheets_refit = null
	var/ear_protection = 0

//Updates the icons of the mob wearing the clothing item, if any.
/obj/item/clothing/proc/update_clothing_icon()
	return

// Aurora forensics port.
/obj/item/clothing/clean_blood()
	..()
	gunshot_residue = null
	if(istype(loc, /mob))
		var/mob/M = loc
		M.update_icon = 1
		M.update_icons()

/obj/item/clothing/New()
	..()
	if(starting_accessories)
		for(var/T in starting_accessories)
			var/obj/item/clothing/accessory/tie = new T(src)
			src.attach_accessory(null, tie)

//BS12: Species-restricted clothing check.
/obj/item/clothing/mob_can_equip(M as mob, slot)

	//if we can't equip the item anyway, don't bother with species_restricted (cuts down on spam)
	if (!..())
		return 0

	if(slot in list(slot_l_hand, slot_r_hand))
		return 1

	if(species_restricted && ishuman(M))
		var/exclusive = null
		var/wearable = null
		var/mob/living/carbon/human/H = M

		if("exclude" in species_restricted)
			exclusive = 1

		if(H.species)
			if(exclusive)
				if(!(H.species.get_bodytype() in species_restricted))
					wearable = 1
			else
				if(H.species.get_bodytype() in species_restricted)
					wearable = 1

			if(!wearable && !(slot in list(slot_l_store, slot_r_store, slot_s_store)))
				H << "<span class='danger'>Your species cannot wear [src].</span>"
				return 0
	return 1

/obj/item/clothing/proc/refit_for_species(var/target_species)
	if(!species_restricted)
		return //this item doesn't use the species_restricted system

	//Set species_restricted list
	switch(target_species)
		if("Human", "Skrell")	//humanoid bodytypes
			species_restricted = list("Human", "Skrell") //skrell/humans can wear each other's suits
		else
			species_restricted = list(target_species)

	//Set icon
	if (sprite_sheets_refit && (target_species in sprite_sheets_refit))
		icon_override = sprite_sheets_refit[target_species]
	else
		icon_override = initial(icon_override)

	if (sprite_sheets_obj && (target_species in sprite_sheets_obj))
		icon = sprite_sheets_obj[target_species]
	else
		icon = initial(icon)

/obj/item/clothing/head/helmet/refit_for_species(var/target_species)
	if(!species_restricted)
		return //this item doesn't use the species_restricted system

	//Set species_restricted list
	switch(target_species)
		if("Skrell")
			species_restricted = list("Human", "Skrell") //skrell helmets fit humans too

		else
			species_restricted = list(target_species)

	if(target_species == "Vox")
		flags_inv &= ~BLOCKHAIR
		flags_inv &= ~BLOCKHEADHAIR
	else
		if(initial(flags_inv) & BLOCKHAIR)
			flags_inv |= BLOCKHAIR
		if(initial(flags_inv) & BLOCKHEADHAIR)
			flags_inv |= BLOCKHEADHAIR

	//Set icon
	if (sprite_sheets_refit && (target_species in sprite_sheets_refit))
		icon_override = sprite_sheets_refit[target_species]
	else
		icon_override = initial(icon_override)

	if (sprite_sheets_obj && (target_species in sprite_sheets_obj))
		icon = sprite_sheets_obj[target_species]
	else
		icon = initial(icon)

///////////////////////////////////////////////////////////////////////
// Ears: headsets, earmuffs and tiny objects
/obj/item/clothing/ears
	name = "ears"
	w_class = 1.0
	throwforce = 2
	slot_flags = SLOT_EARS

/obj/item/clothing/ears/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_ears()


///////////////////////////////////////////////////////////////////////
//Gloves
/obj/item/clothing/gloves
	name = "gloves"
	gender = PLURAL //Carn: for grammarically correct text-parsing
	w_class = 2.0
	item_state = null
	icon = 'icons/inv_slots/gloves/icon.dmi'
	siemens_coefficient = 0.75
	var/wired = 0
	var/obj/item/weapon/cell/cell = 0
	var/clipped = 0
	sprite_group = SPRITE_GLOVES
	body_parts_covered = HANDS
	slot_flags = SLOT_GLOVES
	attack_verb = list("challenged")
	species_restricted = list("exclude","Unathi","Tajara")

/obj/item/clothing/gloves/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_gloves()

/obj/item/clothing/gloves/emp_act(severity)
	if(cell)
		//why is this not part of the powercell code?
		cell.charge -= 1000 / severity
		if (cell.charge < 0)
			cell.charge = 0
		if(cell.reliability != 100 && prob(50/severity))
			cell.reliability -= 10 / severity
	..()

// Called just before an attack_hand(), in mob/UnarmedAttack()
/obj/item/clothing/gloves/proc/Touch(var/atom/A, var/proximity)
	return 0 // return 1 to cancel attack_hand()

/obj/item/clothing/gloves/proc/clipped(var/mob/user)
	if (clipped)
		user << "<span class='notice'>The [src] have already been clipped!</span>"
		update_icon()
		return

	playsound(src.loc, 'sound/items/Wirecutter.ogg', 100, 1)
	user.visible_message("\red [user] cuts the fingertips off of the [src].","\red You cut the fingertips off of the [src].")

	clipped = 1
	name = "fingerless [name]"
	desc = "[desc]<br>They have had the fingertips cut off of them."
	if("exclude" in species_restricted)
		species_restricted -= "Unathi"
		species_restricted -= "Tajara"
	return


/obj/item/clothing/gloves/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/weapon/wirecutters) || istype(W, /obj/item/weapon/scalpel))
		clipped(user)

///////////////////////////////////////////////////////////////////////
//Head
/obj/item/clothing/head
	name = "head"
	icon = 'icons/inv_slots/hats/icon.dmi'
	body_parts_covered = HEAD
	slot_flags = SLOT_HEAD
	w_class = 2.0

	var/light_overlay = "helmet_light"
	var/light_applied
	var/brightness_on
	var/has_light = 1
	var/on = 0

/obj/item/clothing/head/New()
	..()
	if(!icon_action_button && brightness_on)
		icon_action_button = "[icon_state]"

/obj/item/clothing/head/attack_self(mob/user)
	if(has_light == 0)
		return
	if(brightness_on)
		if(!isturf(user.loc))
			user << "You cannot turn the light on while in this [user.loc]"
			return
		on = !on
		user << "You [on ? "enable" : "disable"] the helmet light."
		update_flashlight(user)
	else
		return ..(user)

/obj/item/clothing/head/proc/update_flashlight(var/mob/user = null)
	if(on && !light_applied)
		set_light(brightness_on)
		light_applied = 1
	else if(!on && light_applied)
		set_light(0)
		light_applied = 0
	update_icon(user)

/obj/item/clothing/head/update_icon(var/mob/user)

	overlays.Cut()
	if(on)
		if(!light_overlay_cache["[light_overlay]_icon"])
			light_overlay_cache["[light_overlay]_icon"] = image('icons/obj/light_overlays.dmi', light_overlay)
		if(!light_overlay_cache[light_overlay])
			light_overlay_cache[light_overlay] = image('icons/mob/light_overlays.dmi', light_overlay)
		overlays |= light_overlay_cache["[light_overlay]_icon"]
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.update_inv_head()

/obj/item/clothing/head/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_head()

///////////////////////////////////////////////////////////////////////
//Mask
/obj/item/clothing/mask
	name = "mask"
	icon = 'icons/inv_slots/masks/icon.dmi'
	slot_flags = SLOT_MASK
	body_parts_covered = FACE|EYES

	var/voicechange = 0
	var/list/say_messages
	var/list/say_verbs

/obj/item/clothing/mask/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_wear_mask()

/obj/item/clothing/mask/proc/filter_air(datum/gas_mixture/air)
	return

///////////////////////////////////////////////////////////////////////
//Shoes
/obj/item/clothing/shoes
	name = "shoes"
	icon = 'icons/inv_slots/shoes/icon.dmi'
	desc = "Comfortable-looking shoes."
	gender = PLURAL //Carn: for grammarically correct text-parsing
	siemens_coefficient = 0.9
	body_parts_covered = FEET
	slot_flags = SLOT_FEET

	permeability_coefficient = 0.50
	force = 2
	var/overshoes = 0
	species_restricted = list("exclude","Unathi","Tajara")

/obj/item/clothing/shoes/proc/handle_movement(var/turf/walking, var/running)
	return

/obj/item/clothing/shoes/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_shoes()

///////////////////////////////////////////////////////////////////////
//Suit
/obj/item/clothing/suit
	icon = 'icons/inv_slots/suits/icon.dmi'
	name = "suit"
	var/fire_resist = T0C+100
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	allowed = list(/obj/item/weapon/tank/emergency_oxygen)
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	slot_flags = SLOT_OCLOTHING
	var/blood_overlay_type = "suit"
	siemens_coefficient = 0.9
	center_of_mass = null
	w_class = 3

/obj/item/clothing/suit/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_wear_suit()

///////////////////////////////////////////////////////////////////////
//Under clothing

#define ROLL_NONE 0
#define ROLL_DOWN 1
#define ROLL_SLEV 2

/obj/item/clothing/under
	icon = 'icons/inv_slots/uniforms/icon.dmi'
	sprite_group = SPRITE_UNIFORMS
	name = "under"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	permeability_coefficient = 0.90
	slot_flags = SLOT_ICLOTHING
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	center_of_mass = null
	w_class = 3
	var/has_sensor = 1 //For the crew computer 2 = unable to change mode
	var/sensor_mode = 0
		/*
		1 = Report living/dead
		2 = Report detailed damages
		3 = Report location
		*/
	var/displays_id = 1
	var/status = 0 //0 = default, 1 = rolled dows, 2 = rolled sleeves
	valid_accessory_slots = list("utility","armband","decor","over")
	restricted_accessory_slots = list("utility", "armband")


/obj/item/clothing/under/attack_hand(var/mob/user)
	if(accessories && accessories.len)
		..()
	if (ishuman(usr) && src.loc == user)
		return
	..()

/obj/item/clothing/under/equipped(mob/user, slot)
	update_status()

/obj/item/clothing/under/proc/update_status()
	if(!ishuman(loc)) return

	var/mob/living/carbon/human/H = loc

	body_parts_covered = initial(body_parts_covered)
	wear_state = icon_state

	if(status != ROLL_NONE)
		var/icon/under_icon = H.body_build.uniform_icon
		if(icon_override)
			under_icon = icon_override

		switch(status)
			if(ROLL_DOWN)
				if("[icon_state]_d" in icon_states(under_icon))
					body_parts_covered &= ~(UPPER_TORSO|ARMS)
					wear_state = "[icon_state]_d"
				else
					status = ROLL_NONE
			if(ROLL_SLEV)
				if("[icon_state]_r" in icon_states(under_icon))
					body_parts_covered &= ~ARMS
					wear_state = "[icon_state]_r"
				else
					status = ROLL_NONE

	update_clothing_icon()

/obj/item/clothing/under/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_w_uniform()


/obj/item/clothing/under/examine(mob/user, return_dist=1)
	.=..()
	if(.<=2)
		switch(src.sensor_mode)
			if(0)
				user << "Its sensors appear to be disabled."
			if(1)
				user << "Its binary life sensors appear to be enabled."
			if(2)
				user << "Its vital tracker appears to be enabled."
			if(3)
				user << "Its vital tracker and tracking beacon appear to be enabled."

/obj/item/clothing/under/proc/set_sensors(mob/usr as mob)
	var/mob/M = usr
	if (istype(M, /mob/observer)) return
	if (usr.stat || usr.restrained()) return
	if(has_sensor >= 2)
		usr << "The controls are locked."
		return 0
	if(has_sensor <= 0)
		usr << "This suit does not have any sensors."
		return 0

	var/list/modes = list("Off", "Binary sensors", "Vitals tracker", "Tracking beacon")
	var/switchMode = input("Select a sensor mode:", "Suit Sensor Mode", modes[sensor_mode + 1]) as null|anything in modes
	if(!switchMode) return
	if(get_dist(usr, src) > 1)
		usr << "You have moved too far away."
		return
	sensor_mode = modes.Find(switchMode) - 1

	if (src.loc == usr)
		switch(sensor_mode)
			if(0)
				usr.visible_message(
					"[usr] adjusts their sensors.",
					"You disable your suit's remote sensing equipment."
				)
			if(1)
				usr.visible_message(
					"[usr] adjusts their sensors.",
					"Your suit will now report whether you are live or dead."
				)
			if(2)
				usr.visible_message(
					"[usr] adjusts their sensors.",
					"Your suit will now report your vital lifesigns."
				)
			if(3)
				usr.visible_message(
					"[usr] adjusts their sensors.",
					"Your suit will now report your vital lifesigns as well as your coordinate position."
				)

	else if (istype(src.loc, /mob))
		usr.visible_message("[usr] adjusts [src.loc]'s sensors.", "You adjust [src.loc]'s sensors.")

/obj/item/clothing/under/AltClick(mob/living/carbon/human/user)
	if(src in user)
		set_sensors(user)
	else
		return ..()

/obj/item/clothing/under/verb/toggle()
	set name = "Toggle Suit Sensors"
	set category = "Object"
	set src in usr
	set_sensors(usr)
	..()

/obj/item/clothing/under/verb/rollsuit()
	set name = "Roll Down Jumpsuit"
	set category = "Object"
	set src in usr
	if(!istype(usr, /mob/living)) return
	if(usr.stat || usr.restrained()) return

	if(status != ROLL_DOWN)
		status = ROLL_DOWN
		update_status()
		if(status == ROLL_DOWN)
			usr << "<span class='notice'>You roll down your [src].</span>"
		else
			usr << "<span class='warning'>You can't roll down [src].</span>"
	else
		usr << "<span class='notice'>You roll up your [src].</span>"
		status = ROLL_NONE
		update_status()


/obj/item/clothing/under/verb/rollsleeves()
	set name = "Roll Up Sleeves"
	set category = "Object"
	set src in usr
	if(!istype(usr, /mob/living)) return
	if(usr.stat || usr.restrained()) return

	if(status != ROLL_SLEV)
		status = ROLL_SLEV
		update_status()
		if(status == ROLL_SLEV)
			usr << "<span class='notice'>You roll up your [src]'s sleeves.</span>"
		else
			usr << "<span class='warning'>You can't roll up your [src]'s sleeves.</span>"
	else
		status = ROLL_NONE
		usr << "<span class='notice'>You roll down your [src]'s sleeves.</span>"
		update_status()


/obj/item/clothing/under/rank/New()
	sensor_mode = pick(0,1,2,3)
	..()

#undef ROLL_NONE
#undef ROLL_DOWN
#undef ROLL_SLEV
