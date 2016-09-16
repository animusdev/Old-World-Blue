obj/item/weapon/reagent_containers/syringe/throw_impact(atom/hit_atom, var/speed)
	..()
	//check speed to see if we hit hard enough to trigger the rapid injection
	//incidentally, this means syringe_cartridges can be used with the pneumatic launcher
	if(speed >= 10 && isliving(hit_atom))
		var/mob/living/L = hit_atom
		//unfortuately we don't know where the dart will actually hit, since that's done by the parent.
		if(L.can_inject() && reagents)
			var/reagent_log = reagents.get_reagents()
			reagents.trans_to_mob(L, 15, CHEM_BLOOD)
			admin_inject_log(thrower, L, src, reagent_log, 15, violent=1)

	break_syringe(iscarbon(hit_atom)? hit_atom : null)
	update_icon()

/obj/item/weapon/gun/launcher/syringe
	name = "syringe gun"
	desc = "A spring loaded rifle designed to fit syringes, designed to incapacitate unruly patients from a distance."
	icon_state = "syringegun"
	item_state = "syringegun"
	w_class = 3
	force = 7
	matter = list(DEFAULT_WALL_MATERIAL = 2000)
	slot_flags = SLOT_BELT

	fire_sound = 'sound/weapons/empty.ogg'
	fire_sound_text = "a metallic thunk"
	recoil = 0
	release_force = 10
	throw_distance = 10

	var/list/darts = list()
	var/max_darts = 1
	var/obj/item/weapon/reagent_containers/syringe/next

/obj/item/weapon/gun/launcher/syringe/consume_next_projectile()
	if(next)
		return next
	return null

/obj/item/weapon/gun/launcher/syringe/handle_post_fire()
	..()
	darts -= next
	next = null

/obj/item/weapon/gun/launcher/syringe/attack_self(mob/living/user as mob)
	if(next)
		user.visible_message("[user] unlatches and carefully relaxes the bolt on [src].", "<span class='warning'>You unlatch and carefully relax the bolt on [src], unloading the spring.</span>")
		next = null
	else if(darts.len)
		playsound(src.loc, 'sound/weapons/flipblade.ogg', 50, 1)
		user.visible_message("[user] draws back the bolt on [src], clicking it into place.", "<span class='warning'>You draw back the bolt on the [src], loading the spring!</span>")
		next = darts[1]
	add_fingerprint(user)

/obj/item/weapon/gun/launcher/syringe/attack_hand(mob/living/user as mob)
	if(user.get_inactive_hand() == src)
		if(!darts.len)
			user << "<span class='warning'>[src] is empty.</span>"
			return
		if(next)
			user << "<span class='warning'>[src]'s cover is locked shut.</span>"
			return
		var/obj/item/weapon/reagent_containers/syringe/S = darts[1]
		darts -= S
		user.put_in_hands(S)
		user.visible_message("[user] removes \a [S] from [src].", "<span class='notice'>You remove \a [S] from [src].</span>")
	else
		..()

/obj/item/weapon/gun/launcher/syringe/attackby(var/obj/item/A as obj, mob/user as mob)
	if(istype(A, /obj/item/weapon/reagent_containers/syringe))
		var/obj/item/weapon/reagent_containers/syringe/S = A
		if(darts.len >= max_darts)
			user << "<span class='warning'>[src] is full!</span>"
			return
		user.remove_from_mob(S)
		S.loc = src
		darts += S //add to the end
		user.visible_message("[user] inserts \a [S] into [src].", "<span class='notice'>You insert \a [S] into [src].</span>")
	else
		..()

/obj/item/weapon/gun/launcher/syringe/rapid
	name = "syringe gun revolver"
	desc = "A modification of the syringe gun design, using a rotating cylinder to store up to five syringes. The spring still needs to be drawn between shots."
	icon_state = "rapidsyringegun"
	item_state = "rapidsyringegun"
	max_darts = 5
