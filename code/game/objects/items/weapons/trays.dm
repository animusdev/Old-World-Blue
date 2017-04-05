/*
 * Trays - Agouri
 */
/obj/item/weapon/tray
	name = "tray"
	icon = 'icons/obj/food.dmi'
	icon_state = "tray"
	desc = "A metal tray to lay food on."
	throwforce = 12.0
	throwforce = 10.0
	throw_speed = 1
	throw_range = 5
	w_class = 3.0
	flags = CONDUCT
	matter = list(DEFAULT_WALL_MATERIAL = 3000)
	var/max_carry = 8

/obj/item/weapon/tray/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)

	// Drop all the things. All of them.
	overlays.Cut()
	for(var/obj/item/I in src)
		I.loc = M.loc
		if(isturf(I.loc))
			spawn()
				for(var/i = 1, i <= rand(1,2), i++)
					if(I)
						step(I, pick(NORTH,SOUTH,EAST,WEST))
						sleep(rand(2,4))


	//TODO: DNA3 clown_block
	/*
	if((CLUMSY in user.mutations) && prob(50))              //What if he's a clown?
		M << "<span class='warning'>You accidentally slam yourself with the [src]!</span>"
		M.Weaken(1)
		user.take_organ_damage(2)
		if(prob(50))
			playsound(M, 'sound/items/trayhit1.ogg', 50, 1)
			return
		else
			playsound(M, 'sound/items/trayhit2.ogg', 50, 1) //sound playin'
			return //it always returns, but I feel like adding an extra return just for safety's sakes. EDIT; Oh well I won't :3
	*/

	if(!(user.zone_sel.selecting in list(O_EYES, BP_HEAD))) //hitting anything else other than the eyes
		if(prob(33))
			src.add_blood(M)
			var/turf/location = M.loc
			if (istype(location, /turf/simulated))
				location.add_blood(M)     ///Plik plik, the sound of blood

		admin_attack_log(user, M,
			"Used the [src.name] to attack [key_name(M)]",
			"Has been attacked with [src.name] by [key_name(user)]",
			"used the [src.name] to attack"
		)

		if(prob(15))
			M.Weaken(3)
			M.take_organ_damage(3)
		else
			M.take_organ_damage(5)
		if(prob(50))
			playsound(M, 'sound/items/trayhit1.ogg', 50, 1)
			for(var/mob/O in viewers(M, null))
				O.show_message("<span class='danger'>[user] slams [M] with the tray!</span>", 1)
			return
		else
			playsound(M, 'sound/items/trayhit2.ogg', 50, 1)  //we applied the damage, we played the sound, we showed the appropriate messages. Time to return and stop the proc
			for(var/mob/O in viewers(M, null))
				O.show_message("<span class='danger'>[user] slams [M] with the tray!</span>", 1)
			return


	var/obj/item/protection = null
	var/mob/living/carbon/human/H
	if(ishuman(M))
		H = M
		for(var/slot in list(slot_head, slot_wear_mask, slot_glasses))
			protection = H.get_equipped_item(slot)
			if(istype(protection) && (protection.body_parts_covered & FACE))
				break

	if(H && protection)
		M << "<span class='warning'>You get slammed in the face with the tray, against your [protection]!</span>"
		if(prob(33))
			src.add_blood(H)
			if (H.wear_mask)
				H.wear_mask.add_blood(H)
			if (H.head)
				H.head.add_blood(H)
			if (H.glasses && prob(33))
				H.glasses.add_blood(H)
			var/turf/location = H.loc
			if (istype(location, /turf/simulated))     //Addin' blood! At least on the floor and item :v
				location.add_blood(H)

		for(var/mob/O in viewers(M, null))
			O.show_message("<span class='danger'>[user] slams [H] with the tray!</span>", 1)

		if(prob(50))
			playsound(H, 'sound/items/trayhit1.ogg', 50, 1)
		else
			playsound(M, 'sound/items/trayhit2.ogg', 50, 1)  //sound playin'

		if(prob(10))
			M.Stun(rand(1,3))
			M.take_organ_damage(3)
			return
		else
			M.take_organ_damage(5)
			return

	else //No eye or head protection, tough luck!
		M << "<span class='warning'>You get slammed in the face with the tray!</span>"
		if(prob(33))
			src.add_blood(M)
			var/turf/location = M.loc
			if (istype(location, /turf/simulated))
				location.add_blood(M)

		for(var/mob/O in viewers(M, null))
			O.show_message("<span class='danger'>[user] slams [M] in the face with the tray!</span>", 1)

		if(prob(50))
			playsound(M, 'sound/items/trayhit1.ogg', 50, 1)
		else
			playsound(M, 'sound/items/trayhit2.ogg', 50, 1)  //sound playin' again

		if(prob(30))
			M.Stun(rand(2,4))
			M.take_organ_damage(4)
			return
		else
			M.take_organ_damage(8)
			if(prob(30))
				M.Weaken(2)
				return
			return

/obj/item/weapon/tray/var/cooldown = 0	//shield bash cooldown. based on world.time

/obj/item/weapon/tray/attack_hand(mob/user)
	if(user.get_inactive_hand() == src && contents.len)
		var/obj/item/I = input("Select item for picking up") as null|anything in src.contents
		if(!I || !I in src)
			return
		src.contents -= I
		src.overlays -= I
		src.update_icon()
		user.put_in_hands(I)
		user.visible_message(
			"<span class='notice'>[user] pick [I] from [src].</span>",
			"<span class='notice'>You pick [I] from [src].</span>"
		)
		return

	return ..()

/obj/item/weapon/tray/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(user.get_inactive_hand() == src && istype(W, /obj/item/weapon/material/kitchen/rollingpin))
		if(cooldown < world.time - 25)
			user.visible_message("<span class='warning'>[user] bashes [src] with [W]!</span>")
			playsound(user.loc, 'sound/effects/shieldbash.ogg', 50, 1)
			cooldown = world.time
	else if(istype(W, /obj/item))
		if(ismob(src.loc))
			if((carry + W.w_class) <= max_carry)
				if(add_to_carry(W))
					return 1
		else
			user.unEquip(W, src.loc)
	else
		..()

/*
===============~~~~~================================~~~~~====================
=																			=
=  Code for trays carrying things. By Doohl for Doohl erryday Doohl Doohl~  =
=																			=
===============~~~~~================================~~~~~====================
*/

/obj/item/weapon/tray
	var/carry = 0
	var/static/list/reject_types = list(
		/obj/item/clothing/under,
		/obj/item/clothing/suit,
		/obj/item/weapon/stool,
		/obj/item/projectile
	)

/obj/item/weapon/tray/MouseDrop(mob/living/carbon/human/H) //Drag'n'drop for pass object grabbing.
	if(!H || usr!=H) return
	if(!isturf(loc) || !Adjacent(H)) return
	H.put_in_active_hand(src)

/obj/item/weapon/tray/update_icon()
	overlays.Cut()
	for(var/item in src)
		var/obj/item/I = item
		var/image/Img = image(I, layer=FLOAT_LAYER)
		Img.pixel_x = I.pixel_x
		Img.pixel_y = I.pixel_y
		overlays += Img

/obj/item/weapon/tray/pickup(mob/user)
	grab_objects()

/obj/item/weapon/tray/proc/add_to_carry(var/obj/item/I, var/mob/user)
	if(carry > max_carry)
		if(user)
			user << "<span class='warning'>There is not enough free space for [I].</span>"
		return 0
	if(ismob(I.loc))
		var/mob/M = I.loc
		if(!M.unEquip(I, src))
			return 0
	else
		I.forceMove(src)
	carry += I.w_class
	update_icon()
	return 1

/obj/item/weapon/tray/proc/grab_objects(var/turf/T)
	if(!T)
		T = loc

	if(!istype(T))
		return

	for(var/obj/item/I in loc)
		if( I != src && !I.anchored && !is_type_in_list(I, reject_types))
			if(!add_to_carry(I))
				return

/obj/item/weapon/tray/dropped(mob/user)
	spawn() //Allows the tray to udpate location, rather than just checking against mob's location
		if(!isturf(src.loc))
			return
		var/Table = locate(/obj/structure/table) in src.loc
		if(!Table) //Put on the floor
			Table = user && (user.loc==src.loc)

		overlays.Cut()
		carry = 0
		for(var/obj/item/I in src)
			I.forceMove(src.loc)
			src.contents.Remove(I)
			if(!Table)
				for(var/i = 1 to rand(1,2))
					if(I)
						step(I, pick(NORTH,SOUTH,EAST,WEST))
						sleep(rand(2,4))
