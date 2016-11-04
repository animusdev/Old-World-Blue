/obj/structure/closet/secure_closet/personal
	name = "personal closet"
	desc = "It's a secure locker for personnel. The first card swiped gains control."
	req_access = list(access_all_personal_lockers)
	var/registered_name = null

/obj/structure/closet/secure_closet/personal/New()
	..()
	spawn(2)
		switch(rand(3))
			if(1) new /obj/item/weapon/storage/backpack(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel_norm(src)
			if(3) new /obj/item/weapon/storage/backpack/duffle(src)
		new /obj/item/device/radio/headset( src )
	return


/obj/structure/closet/secure_closet/personal/patient
	name = "patient's closet"

/obj/structure/closet/secure_closet/personal/patient/New()
	..()
	spawn(4)
		// Not really the best way to do this, but it's better than "contents = list()"!
		for(var/atom/movable/AM in contents)
			qdel(AM)
		new /obj/item/clothing/under/color/white( src )
		new /obj/item/clothing/shoes/white( src )
	return

/obj/structure/closet/secure_closet/personal/cabinet
	icon_state = "cabinetdetective"
	icon_opened = "cabinetdetective_open"
	icon_broken = "cabinetdetective_broken"

/obj/structure/closet/secure_closet/personal/cabinet/New()
	..()
	spawn(4)
		// Not really the best way to do this, but it's better than "contents = list()"!
		for(var/atom/movable/AM in contents)
			qdel(AM)
		new /obj/item/weapon/storage/backpack/satchel/withwallet( src )
		new /obj/item/device/radio/headset( src )
	return

/obj/structure/closet/secure_closet/personal/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (src.opened)
		if (istype(W, /obj/item/weapon/grab))
			src.MouseDrop_T(W:affecting, user)      //act like they were dragged onto the closet
		user.unEquip(W, src.loc)
	else if(istype(W, /obj/item/weapon/card/id))
		if(src.broken)
			user << "<span class='warning'>It appears to be broken.</span>"
			return
		var/obj/item/weapon/card/id/I = W
		if(!I || !I.registered_name)	return
		if(src.allowed(user) || !src.registered_name || (istype(I) && (src.registered_name == I.registered_name)))
			//they can open all lockers, or nobody owns this, or they own this locker
			src.locked = !( src.locked )
			update_icon()

			if(!src.registered_name)
				src.registered_name = I.registered_name
				src.desc = "Owned by [I.registered_name]."
		else
			user << "<span class='warning'>Access Denied</span>"
	else if( (istype(W, /obj/item/weapon/card/emag)||istype(W, /obj/item/weapon/melee/energy/blade)) && !src.broken)
		broken = 1
		locked = 0
		desc = "It appears to be broken."
		update_icon()
		if(istype(W, /obj/item/weapon/melee/energy/blade))
			var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
			spark_system.set_up(5, 0, src.loc)
			spark_system.start()
			playsound(src.loc, 'sound/weapons/blade1.ogg', 50, 1)
			playsound(src.loc, "sparks", 50, 1)
			for(var/mob/O in viewers(user, 3))
				O.show_message("\blue The locker has been sliced open by [user] with an energy blade!", 1, "\red You hear metal being sliced and sparks flying.", 2)
	else
		user << "<span class='warning'>Access Denied</span>"
	return

/obj/structure/closet/secure_closet/personal/verb/reset()
	set src in oview(1) // One square distance
	set category = "Object"
	set name = "Reset Lock"
	if(!usr.canmove || usr.stat || usr.restrained()) // Don't use it if you're not able to! Checks for stuns, ghost and restrain
		return
	if(ishuman(usr))
		src.add_fingerprint(usr)
		if (src.locked || !src.registered_name)
			usr << "<span class='warning'>You need to unlock it first.</span>"
		else if (src.broken)
			usr << "<span class='warning'>It appears to be broken.</span>"
		else
			if (src.opened)
				if(!src.close())
					return
			src.locked = 1
			update_icon()
			src.registered_name = null
			src.desc = "It's a secure locker for personnel. The first card swiped gains control."
	return
