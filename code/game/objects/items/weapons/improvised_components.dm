/obj/item/weapon/material/butterflyblade
	name = "knife blade"
	desc = "A knife blade. Unusable as a weapon without a grip."
	icon = 'icons/obj/buildingobject.dmi'
	icon_state = "butterfly2"
	force_divisor = 0.1
	thrown_force_divisor = 0.1

/obj/item/weapon/material/butterflyhandle
	name = "concealed knife grip"
	desc = "A plasteel grip with screw fittings for a blade."
	icon = 'icons/obj/buildingobject.dmi'
	icon_state = "butterfly1"
	force_divisor = 0.1
	thrown_force_divisor = 0.1
	var/obj/item/weapon/material/butterflyblade/blade = null

/obj/item/weapon/material/butterflyhandle/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/material/butterflyblade))
		user.drop_from_inventory(W, src)
		blade = W
		name = "unfinished concealed knife"
		icon_state = "butterflystep1"
		desc = "An unfinished concealed knife, it looks like the screws need to be tightened."
		user << "You attach the two concealed blade parts."
		return 1

	if(istype(W,/obj/item/weapon/screwdriver) && blade)
		user << "You finish the concealed blade weapon."
		var/obj/item/weapon/material/butterfly/BF = new (src.loc, material.name)
		if(!isturf(src.loc))
			user.drop_from_inventory(src)
			user.put_in_hands(BF)
		qdel(src)
		return 1


/obj/item/weapon/material/wirerod
	name = "wired rod"
	desc = "A rod with some wire wrapped around the top. It'd be easy to attach something to the top bit."
	icon_state = "wiredrod"
	item_state = "rods"
	flags = CONDUCT
	force = 8
	throwforce = 10
	w_class = 3
	attack_verb = list("hit", "bludgeoned", "whacked", "bonked")
	force_divisor = 0.1
	thrown_force_divisor = 0.1

/obj/item/weapon/material/wirerod/attackby(var/obj/item/I, mob/user as mob)
	..()
	var/obj/item/finished
	if(istype(I, /obj/item/weapon/material/shard))
		var/obj/item/weapon/material/tmp_shard = I
		finished = new /obj/item/weapon/material/twohanded/spear(get_turf(user), tmp_shard.material.name)
		user << "<span class='notice'>You fasten \the [I] to the top of the rod with the cable.</span>"
	else if(istype(I, /obj/item/weapon/wirecutters))
		finished = new /obj/item/weapon/melee/baton/cattleprod(get_turf(user))
		user << "<span class='notice'>You fasten the wirecutters to the top of the rod with the cable, prongs outward.</span>"
	else if (istype(I, /obj/item/weapon/material/butterflyblade))
		var/obj/item/weapon/material/tmp_shard = I
		finished = new /obj/item/weapon/material/twohanded/spear(get_turf(user), tmp_shard.material.name)
		user << "<span class='notice'>You fasten \the [I] to the top of the rod with the cable.</span>"
	if(finished)
		user.drop_from_inventory(src)
		user.drop_from_inventory(I)
		qdel(I)
		qdel(src)
		user.put_in_hands(finished)
	update_icon(user)
