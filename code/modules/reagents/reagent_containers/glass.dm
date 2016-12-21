////////////////////////////////////////////////////////////////////////////////
/// (Mixing)Glass.
////////////////////////////////////////////////////////////////////////////////
/obj/item/weapon/reagent_containers/glass
	name = ""
	var/base_name = ""
	desc = " "
	icon = 'icons/obj/chemical.dmi'
	icon_state = "null"
	item_state = "null"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,25,30,60)
	volume = 60
	w_class = 2
	flags = OPENCONTAINER
	center_of_mass = list("x"=16, "y"=16)
	var/isGlass = 1

	var/label_text = ""
	var/list/preloaded = null

	var/list/can_be_placed_into = list(
		/obj/machinery/chem_master,
		/obj/machinery/chem_dispenser,
		/obj/machinery/reagentgrinder,
		/obj/structure/table,
		/obj/structure/closet,
		/obj/structure/sink,
		/obj/item/weapon/storage,
		/obj/machinery/atmospherics/unary/cryo_cell,
		/obj/machinery/dna_scannernew,
		/obj/item/weapon/grenade/chem_grenade,
		/mob/living/bot/medbot,
		/obj/item/weapon/storage/secure/safe,
		/obj/machinery/iv_drip,
		/obj/machinery/disease2/incubator,
		/obj/machinery/disposal,
		/obj/machinery/apiary,
		/mob/living/simple_animal/cow,
		/mob/living/simple_animal/hostile/retaliate/goat,
		/obj/machinery/computer/centrifuge,
		/obj/machinery/sleeper,
		/obj/machinery/smartfridge/,
		/obj/machinery/biogenerator,
		/obj/machinery/constructable_frame,
		/obj/machinery/radiocarbon_spectrometer
		)

// Self procs //

/obj/item/weapon/reagent_containers/glass/New()
	..()
	if(isGlass) unacidable = 1
	if(!base_name)
		base_name = name
	else
		update_name_label()
	if(preloaded)
		for(var/reagent in preloaded)
			reagents.add_reagent(reagent, preloaded[reagent])

/obj/item/weapon/reagent_containers/glass/proc/update_name_label()
	if(label_text == "")
		name = base_name
	else
		name = "[base_name] ([label_text])"

/obj/item/weapon/reagent_containers/glass/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/pen) || istype(W, /obj/item/device/flashlight/pen))
		var/max_label_len = MAX_NAME_LEN - length(base_name)
		var/tmp_label = sanitizeSafe(input(user, "Enter a label for [name]", "Label", label_text), max_label_len)
		if(length(tmp_label) > max_label_len)
			user << "<span class='notice'>The label can be at most [max_label_len] characters long.</span>"
		else
			user << "<span class='notice'>You set the label to \"[tmp_label]\".</span>"
			label_text = tmp_label
			update_name_label()


/obj/item/weapon/reagent_containers/glass/bullet_act(var/obj/item/projectile/bullet/Proj)
	..()
	if(Proj.damage_type != BRUTE)
		return

	if(!isGlass)
		if(reagents)
			if(reagents.total_volume)
				visible_message("<span class = 'warning'>Bullet flies through the [src], \
								splashing it's contents all around!</span>")
				reagents.splash(src.loc, reagents.total_volume)
			else
				visible_message("<span class = 'warning'>Bullet flies through the [src]!</span>")

			name = "spoiled [name]"
			desc = "It's kinda useless now, you know. Think first, shoot after."
			qdel(reagents)
		else
			visible_message("<span class = 'warning'>Bullet flies through the [src]!</span>")

		var/image/hole = image('icons/effects/effects.dmi', "scorch")
		hole.pixel_x = rand(-3,3)+15
		hole.pixel_y = rand(-5,5)+14
		overlays += hole
	else
		src.smash(loc)

	return PROJECTILE_CONTINUE

/obj/item/weapon/reagent_containers/glass/throw_impact(atom/hit_atom, var/speed)
	..()
	//when thrown on impact, bottles smash and spill their contents
	var/mob/M = thrower
	if(isGlass && istype(M) && M.a_intent == I_HURT)
		var/throw_dist = get_dist(throw_source, loc)
		if(speed >= throw_speed && smash_check(throw_dist)) //not as reliable as smashing directly
			src.smash(loc, hit_atom)


// Interaction //

/obj/item/weapon/reagent_containers/glass/afterattack(var/obj/target, var/mob/user, var/proximity, var/param)
	if(!proximity)
		return
	..()

	if(!is_open_container()) return

	for(var/type in can_be_placed_into)
		if(istype(target, type))
			return

	if(user.a_intent == I_HELP)
		if(standard_feed_mob(user, target))
			return
	else if(standard_splash_mob(user, target))
		return

	if(standard_dispenser_refill(user, target))
		return

	if(standard_pour_into(user, target))
		return

	if(reagents && reagents.total_volume)
		user << "<span class='notice'>You splash the solution onto [target].</span>"
		reagents.splash(target, reagents.total_volume)
		return

/obj/item/weapon/reagent_containers/glass/self_feed_message(var/mob/user)
	user << "<span class='notice'>You swallow a gulp from \the [src].</span>"

/obj/item/weapon/reagent_containers/glass/feed_sound(var/mob/user)
	playsound(user.loc, 'sound/items/drink.ogg', rand(10, 50), 1)

/obj/item/weapon/reagent_containers/glass/standard_feed_mob(var/mob/user, var/mob/target)
	if(!is_open_container())
		user << "<span class='notice'>You need to open [src] first!</span>"
		return 1
	return ..()

/obj/item/weapon/reagent_containers/glass/standard_dispenser_refill(var/mob/user, var/obj/structure/reagent_dispensers/target)
	if(!is_open_container())
		user << "<span class='notice'>You need to open [src] first!</span>"
		return 1
	return ..()

/obj/item/weapon/reagent_containers/glass/standard_pour_into(var/mob/user, var/atom/target)
	if(!is_open_container())
		user << "<span class='notice'>You need to open [src] first!</span>"
		return 1
	return ..()

// Smashing //

var/global/list/broken_bottle_icon_cache = list()

/obj/item/weapon/reagent_containers/glass
	var/smash_duration = 5 //Directly relates to the 'weaken' duration. Lowered by armor (i.e. helmets)

/obj/item/weapon/reagent_containers/glass/proc/smash_check(var/distance)
	if(!isGlass || !smash_duration)
		return 0

	var/list/chance_table = list(100, 95, 90, 85, 75, 55, 35) //starting from distance 0
	var/idx = max(distance + 1, 1) //since list indices start at 1
	if(idx > chance_table.len)
		return 0
	return prob(chance_table[idx])

/obj/item/weapon/reagent_containers/glass/proc/smash(var/newloc, atom/against = null)
	//Creates a shattering noise and make the bottle broken
	if(findtext(name, "broken")) return // Not the best way. Must be rewrite oneday.
	if(!against) against = newloc
	if(prob(33))
		new/obj/item/weapon/material/shard(newloc)

	if(reagents)
		against.visible_message("<span class='notice'>The contents of \the [src] splash all over [against]!</span>")
		reagents.splash(against, reagents.total_volume)
		qdel(reagents)

	name = "broken [name]"
	desc = "Careful, those edges are sharp."
	force = 10
	attack_verb = list("stabbed", "slashed", "attacked")
	sharp = 1
	icon = get_broken_icon()

	playsound(src, "shatter", 70, 1)

/obj/item/weapon/reagent_containers/glass/proc/get_broken_icon()
	var/shift_x = rand(5)
	var/cache_key = "[icon][icon_state][shift_x]"
	if(!broken_bottle_icon_cache[cache_key])
		var/icon/new_icon = new(icon, icon_state)
		new_icon.Blend(icon('icons/obj/drinks.dmi', "broken"), ICON_OVERLAY, shift_x, 1)
		new_icon.SwapColor(rgb(255, 0, 220, 255), rgb(0, 0, 0, 0))
		broken_bottle_icon_cache[cache_key] = new_icon
	return broken_bottle_icon_cache[cache_key]
