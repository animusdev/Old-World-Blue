/obj/item/weapon/reagent_containers
	name = "Container"
	desc = "..."
	icon = 'icons/obj/chemical.dmi'
	icon_state = null
	w_class = 2
	randpixel = 6
	var/amount_per_transfer_from_this = 5
	var/possible_transfer_amounts = list(5,10,15,25,30)
	var/volume = 30

/obj/item/weapon/reagent_containers/verb/set_APTFT() //set amount_per_transfer_from_this
	set name = "Set transfer amount"
	set category = "Object"
	set src in range(0)
	var/N = input("Amount per transfer from this:","[src]") as null|anything in possible_transfer_amounts
	if(N)
		amount_per_transfer_from_this = N

/obj/item/weapon/reagent_containers/New()
	..()
	if(!possible_transfer_amounts)
		src.verbs -= /obj/item/weapon/reagent_containers/verb/set_APTFT
	create_reagents(volume)

/obj/item/weapon/reagent_containers/attack_self(mob/user as mob)
	return

/obj/item/weapon/reagent_containers/proc/reagentlist() // For attack logs
	if(reagents)
		return reagents.get_reagents()
	return "No reagent holder"

/obj/item/weapon/reagent_containers/proc/standard_dispenser_refill(var/mob/user, var/obj/structure/reagent_dispensers/target) // This goes into afterattack
	if(!istype(target))
		return 0

	if(!reagents)
		user << "<span class='notice'>[src] can't hold reagents anymore.</span>"
		return 1

	if(!target.reagents || !target.reagents.total_volume)
		user << "<span class='notice'>[target] is empty.</span>"
		return 1

	if(reagents && !reagents.get_free_space())
		user << "<span class='notice'>[src] is full.</span>"
		return 1

	var/trans = target.reagents.trans_to_obj(src, target:amount_per_transfer_from_this)
	user << "<span class='notice'>You fill [src] with [trans] units of the contents of [target].</span>"
	return 1

/obj/item/weapon/reagent_containers/proc/standard_splash_mob(var/mob/user, var/mob/target) // This goes into afterattack
	if(!istype(target))
		return

	if(!reagents || !reagents.total_volume)
		user << "<span class='notice'>[src] is empty.</span>"
		return 1

	if(target.reagents && !target.reagents.get_free_space())
		user << "<span class='notice'>[target] is full.</span>"
		return 1

	var/contained = reagentlist()
	admin_attack_log(user, target,
		"Used the [name] to splash [key_name(target)]. Reagents: [contained]",
		"Has been splashed with [name] by [key_name(user)]. Reagents: [contained]",
		"used [name] (reagents: [contained]) for splash"
	)

	user.visible_message("<span class='danger'>[target] has been splashed with something by [user]!</span>", "<span class = 'notice'>You splash the solution onto [target].</span>")
	reagents.splash(target, reagents.total_volume*0.5)
	return 1

/obj/item/weapon/reagent_containers/proc/self_feed_message(var/mob/user)
	user << "<span class='notice'>You eat \the [src]</span>"

/obj/item/weapon/reagent_containers/proc/other_feed_message_start(var/mob/user, var/mob/target)
	user.visible_message("<span class='warning'>[user] is trying to feed [target] \the [src]!</span>")

/obj/item/weapon/reagent_containers/proc/other_feed_message_finish(var/mob/user, var/mob/target)
	user.visible_message("<span class='warning'>[user] has fed [target] \the [src]!</span>")

/obj/item/weapon/reagent_containers/proc/feed_sound(var/mob/user)
	return

/obj/item/weapon/reagent_containers/proc/standard_feed_mob(var/mob/user, var/mob/target) // This goes into attack
	if(!istype(target))
		return 0

	if(!reagents || !reagents.total_volume)
		user << "<span class='notice'>\The [src] is empty.</span>"
		return 1

	if(target == user)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(!H.check_has_mouth())
				user << "Where do you intend to put \the [src]? You don't have a mouth!"
				return
			var/obj/item/blocked = H.check_mouth_coverage()
			if(blocked)
				user << "<span class='warning'>\The [blocked] is in the way!</span>"
				return

		user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN) //puts a limit on how fast people can eat/drink things
		self_feed_message(user)
		reagents.trans_to_mob(user, amount_per_transfer_from_this, CHEM_INGEST)
		feed_sound(user)
		return 1
	else
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			if(!H.check_has_mouth())
				user << "Where do you intend to put \the [src]? \The [H] doesn't have a mouth!"
				return
			var/obj/item/blocked = H.check_mouth_coverage()
			if(blocked)
				user << "<span class='warning'>\The [blocked] is in the way!</span>"
				return

		other_feed_message_start(user, target)

		user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
		if(!do_mob(user, target, 15))
			return

		other_feed_message_finish(user, target)

		var/contained = reagentlist()
		admin_attack_log(user, target,
			"Fed [name] by [key_name(target)]. Reagents: [contained]",
			"Has been fed [name] by [key_name(user)]. Reagents: [contained]",
			"used [name] (reagents: [contained]) to fed"
		)

		reagents.trans_to_mob(target, amount_per_transfer_from_this, CHEM_INGEST)
		feed_sound(user)
		return 1

/obj/item/weapon/reagent_containers/proc/standard_pour_into(var/mob/user, var/atom/target) // This goes into afterattack and yes, it's atom-level
	if(!target.reagents)
		return 0

	if(!target.is_open_container())
		return 0

	if(!reagents || !reagents.total_volume)
		user << "<span class='notice'>[src] is empty.</span>"
		return 1

	if(!target.reagents.get_free_space())
		user << "<span class='notice'>[target] is full.</span>"
		return 1

	var/trans = reagents.trans_to(target, amount_per_transfer_from_this)
	user << "<span class='notice'>You transfer [trans] units of the solution to [target].</span>"
	return 1
