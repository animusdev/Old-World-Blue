
////////////////////////////////////////////////////////////////////////////////
/// (Mixing)Glass.
////////////////////////////////////////////////////////////////////////////////
/obj/item/weapon/reagent_containers/glass
	name = " "
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
	unacidable = 1 //glass doesn't dissolve in acid
	center_of_mass = list("x"=16, "y"=16)
	var/isGlass = 1
	var/label_text = ""

	var/list/can_be_placed_into = list(
		/obj/machinery/chem_master/,
		/obj/machinery/chemical_dispenser,
		/obj/machinery/reagentgrinder,
		/obj/structure/table,
		/obj/structure/closet,
		/obj/structure/sink,
		/obj/item/weapon/storage,
		/obj/machinery/atmospherics/unary/cryo_cell,
		/obj/machinery/dna_scannernew,
		/obj/item/weapon/grenade/chem_grenade,
		/mob/living/bot/medbot,
		/obj/machinery/computer/pandemic,
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

	attack_self()
		..()
		if(is_open_container())
			usr << "<span class = 'notice'>You put the lid on \the [src].</span>"
			flags ^= OPENCONTAINER
		else
			usr << "<span class = 'notice'>You take the lid off \the [src].</span>"
			flags |= OPENCONTAINER
		update_icon()

	afterattack(var/obj/target, var/mob/user, var/flag)
		if(!flag)
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

	self_feed_message(var/mob/user)
		user << "<span class='notice'>You swallow a gulp from \the [src].</span>"

	feed_sound(var/mob/user)
		playsound(user.loc, 'sound/items/drink.ogg', rand(10, 50), 1)

	bullet_act(var/obj/item/projectile/bullet/Proj)
		..()
		if(Proj.damage_type != BRUTE)
			return

		if(!isGlass)
			if(reagents)
				if(reagents.total_volume)
					reagents.splash(src.loc, reagents.total_volume)
					visible_message("<span class = 'warning'>Bullet flies through the [src], splashing it's contents all around!</span>")
				else
					visible_message("<span class = 'warning'>Bullet flies through the [src]!</span>")
				qdel(reagents)
				name = "spoiled [name]"
				desc = "It's kinda useless now, you know. Think first, shoot after."
			else
				visible_message("<span class = 'warning'>Bullet flies through the [src]!</span>")

			var/image/hole = image('icons/effects/effects.dmi', "scorch")
			hole.pixel_x = rand(-3,3)+15
			hole.pixel_y = rand(-5,5)+14
			overlays += hole
			return PROJECTILE_CONTINUE

		else
			isGlass = 0

			if(reagents && reagents.total_volume)
				reagents.splash(src.loc, reagents.total_volume)

			visible_message("<span class = 'warning'>The [src] explodes in the shower of shards!</span>")

			var/obj/item/weapon/broken_bottle/B = new(loc)
			B.name = "broken [name]"
			B.force = src.force
			B.icon_state = src.icon_state
			var/icon/Q = new(src.icon, B.icon_state)
			Q.Blend(B.broken_outline, ICON_OVERLAY, rand(5), 1)
			Q.SwapColor(rgb(255, 0, 220, 255), rgb(0, 0, 0, 0))
			B.icon = Q
			B.pixel_x = pixel_x
			B.pixel_y = pixel_y
			src.transfer_fingerprints_to(B)

			playsound(src, "shatter", 70, 1)
			if(prob(66))
				new /obj/item/weapon/material/shard(src.loc)
			qdel(src)

	throw_impact(var/atom/hit_atom)
		..()
		if(isGlass && prob(30))
			visible_message("<span class = 'warning'>The [src] explodes in the shower of shards!</span>")

			if(reagents && reagents.total_volume)
				if(isliving(hit_atom))
					visible_message("<span class = 'warning'>The soluton splashes all over the [hit_atom]!</span>")
					reagents.splash(hit_atom, reagents.total_volume)
				else
					reagents.splash(hit_atom, reagents.total_volume)

			//create new broken bottle
			var/obj/item/weapon/broken_bottle/B = new /obj/item/weapon/broken_bottle(loc)
			B.force = src.force
			B.icon_state = src.icon_state

			src.transfer_fingerprints_to(B)

			var/icon/Q = new(src.icon, B.icon_state)
			Q.Blend(B.broken_outline, ICON_OVERLAY, rand(5), 1)
			Q.SwapColor(rgb(255, 0, 220, 255), rgb(0, 0, 0, 0))
			B.icon = Q

			playsound(src, "shatter", 70, 1)

			if(prob(50))
				new /obj/item/weapon/material/shard(src.loc)
			qdel(src)

/obj/item/weapon/reagent_containers/glass/beaker
	name = "beaker"
	desc = "A beaker."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "beaker"
	item_state = "beaker"
	matter = list("glass" = 500)
	center_of_mass = list("x"=16, "y"=11)

	New()
		..()
		base_name = name
		desc += " Can hold up to [volume] units."

	examine(var/mob/user, return_dist=1)
		.=..()
		if(.<=2)
			if(reagents && reagents.reagent_list.len)
				user << "<span class='notice'>It contains [reagents.total_volume] units of liquid.</span>"
			else
				user << "<span class='notice'>It is empty.</span>"
			if(!is_open_container())
				user << "<span class='notice'>Airtight lid seals it completely.</span>"

	on_reagent_change()
		update_icon()

	pickup(mob/user)
		..()
		update_icon()

	dropped(mob/user)
		..()
		update_icon()

	attack_hand()
		..()
		update_icon()

	update_icon()
		overlays.Cut()

		if(reagents.total_volume)
			var/image/filling = image('icons/obj/reagentfillings.dmi', src, "[icon_state]10")

			var/percent = round((reagents.total_volume / volume) * 100)
			switch(percent)
				if(0 to 9)		filling.icon_state = "[icon_state]-00"
				if(10 to 24) 	filling.icon_state = "[icon_state]-10"
				if(25 to 49)	filling.icon_state = "[icon_state]-25"
				if(50 to 74)	filling.icon_state = "[icon_state]-50"
				if(75 to 79)	filling.icon_state = "[icon_state]-75"
				if(80 to 90)	filling.icon_state = "[icon_state]-80"
				if(91 to INFINITY)	filling.icon_state = "[icon_state]-100"

			filling.color = reagents.get_color()
			overlays += filling

		if (!is_open_container())
			overlays += image(icon, src, "lid_[initial(icon_state)]")

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(istype(W, /obj/item/weapon/pen) || istype(W, /obj/item/device/flashlight/pen))
			var/tmp_label = sanitizeName(input(user, "Enter a label for [name]", "Label", label_text), MAX_NAME_LEN, 1)
			if(length(tmp_label) > 20)
				user << "<span class='notice'>The label can be at most 10 characters long.</span>"
			else
				user << "<span class='notice'>You set the label to \"[tmp_label]\".</span>"
				label_text = tmp_label
				update_name_label()

	proc/update_name_label()
		if(label_text == "")
			name = base_name
		else
			name = "[base_name] ([label_text])"


/obj/item/weapon/reagent_containers/glass/beaker/large
	name = "large beaker"
	desc = "A large beaker."
	icon_state = "beakerlarge"
	matter = list("glass" = 5000)
	volume = 120
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,25,30,60,120)
	flags = OPENCONTAINER

/obj/item/weapon/reagent_containers/glass/beaker/noreact
	name = "cryostasis beaker"
	desc = "A cryostasis beaker that allows for chemical storage without reactions."
	icon_state = "beakernoreact"
	matter = list("glass" = 500)
	volume = 60
	amount_per_transfer_from_this = 10
	flags = OPENCONTAINER | NOREACT
	center_of_mass = list("x"=16, "y"=9)
	isGlass = 0

/obj/item/weapon/reagent_containers/glass/beaker/bluespace
	name = "bluespace beaker"
	desc = "A bluespace beaker, powered by experimental bluespace technology."
	icon_state = "beakerbluespace"
	matter = list("glass" = 5000)
	volume = 300
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,25,30,60,120,300)
	flags = OPENCONTAINER
	isGlass = 0

/obj/item/weapon/reagent_containers/glass/beaker/vial
	name = "vial"
	desc = "A small glass vial."
	icon_state = "vial"
	matter = list("glass" = 250)
	volume = 30
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,25)
	flags = OPENCONTAINER
	center_of_mass = list("x"=16, "y"=9)

/obj/item/weapon/reagent_containers/glass/beaker/cryoxadone
	New()
		..()
		reagents.add_reagent("cryoxadone", 30)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/sulphuric
	New()
		..()
		reagents.add_reagent("sacid", 60)
		update_icon()

/obj/item/weapon/reagent_containers/glass/bucket
	desc = "It's a bucket."
	name = "bucket"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "bucket"
	item_state = "bucket"
	matter = list(DEFAULT_WALL_MATERIAL = 200)
	w_class = 3.0
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = list(10,20,30,60,120)
	volume = 120
	flags = OPENCONTAINER
	unacidable = 0
	center_of_mass = list("x"=16, "y"=9)
	isGlass = 0

	attackby(var/obj/D, mob/user as mob)
		if(isprox(D))
			user << "You add [D] to [src]."
			qdel(D)
			user.put_in_hands(new /obj/item/weapon/bucket_sensor)
			user.drop_from_inventory(src)
			qdel(src)

	update_icon()
		overlays.Cut()

		if (!is_open_container())
			var/image/lid = image(icon, src, "lid_[initial(icon_state)]")
			overlays += lid

/*
/obj/item/weapon/reagent_containers/glass/blender_jug
	name = "Blender Jug"
	desc = "A blender jug, part of a blender."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "blender_jug_e"
	volume = 100

	on_reagent_change()
		switch(src.reagents.total_volume)
			if(0)
				icon_state = "blender_jug_e"
			if(1 to 75)
				icon_state = "blender_jug_h"
			if(76 to 100)
				icon_state = "blender_jug_f"

/obj/item/weapon/reagent_containers/glass/canister		//not used apparantly
	desc = "It's a canister. Mainly used for transporting fuel."
	name = "canister"
	icon = 'icons/obj/tank.dmi'
	icon_state = "canister"
	item_state = "canister"
	m_amt = 300
	g_amt = 0
	w_class = 4.0

	amount_per_transfer_from_this = 20
	possible_transfer_amounts = list(10,20,30,60)
	volume = 120
*/
