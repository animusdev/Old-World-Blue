/obj/item/clothing/accessory/holster
	name = "shoulder holster"
	desc = "A handgun holster."
	icon_state = "holster"
	slot = "utility"
	var/obj/item/holstered = null

/obj/item/clothing/accessory/holster/update_clothing_icon()
	if(has_suit)
		has_suit.update_clothing_icon()

/obj/item/clothing/accessory/holster/proc/can_holster(var/obj/item/I, var/mob/living/user)
	if(holstered && istype(user))
		user << "<span class='warning'>There is already \a [holstered] holstered here!</span>"
		return 0
	return 1

/obj/item/clothing/accessory/holster/proc/holster(var/obj/item/I, var/mob/living/user)
	if(can_holster(I, user) && user.unEquip(I,src))
		holstered = I
		holstered.add_fingerprint(user)
		w_class = max(w_class, holstered.w_class)
		user.visible_message("<span class='notice'>[user] holsters \the [holstered].</span>", "<span class='notice'>You holster \the [holstered].</span>")
		name = "occupied [initial(name)]"

/obj/item/clothing/accessory/holster/proc/clear_holster()
	holstered = null
	name = initial(name)

/obj/item/clothing/accessory/holster/proc/unholster(mob/user as mob)
	if(!holstered)
		return

	user.put_in_hands(holstered)
	holstered.add_fingerprint(user)
	w_class = initial(w_class)
	clear_holster()


/obj/item/clothing/accessory/holster/attack_hand(mob/user as mob)
	if (has_suit)	//if we are part of a suit
		if (holstered)
			unholster(user)
		return

	..(user)

/obj/item/clothing/accessory/holster/attackby(obj/item/W as obj, mob/user as mob)
	holster(W, user)

/obj/item/clothing/accessory/holster/emp_act(severity)
	if (holstered)
		holstered.emp_act(severity)
	..()

/obj/item/clothing/accessory/holster/examine(mob/user)
	. = ..()
	if(. <= 4)
		if (holstered)
			user << "A [holstered] is holstered here."
		else
			user << "It is empty."

/obj/item/clothing/accessory/holster/on_attached(obj/item/clothing/under/S, mob/user as mob)
	..()
	has_suit.verbs += /obj/item/clothing/accessory/holster/verb/holster_verb

/obj/item/clothing/accessory/holster/on_removed(mob/user as mob)
	has_suit.verbs -= /obj/item/clothing/accessory/holster/verb/holster_verb
	..()

//For the holster hotkey
/obj/item/clothing/accessory/holster/verb/holster_verb()
	set name = "Holster"
	set category = "Object"
	set src in usr
	if(!istype(usr, /mob/living)) return
	if(usr.stat) return

	//can't we just use src here?
	var/obj/item/clothing/accessory/holster/H = null
	if (istype(src, /obj/item/clothing/accessory/holster))
		H = src
	else if (istype(src, /obj/item/clothing/under))
		var/obj/item/clothing/under/S = src
		if (S.accessories.len)
			H = locate() in S.accessories

	if (!H)
		usr << "<span class='warning'>Something is very wrong.</span>"
		return

	if(!H.holstered)
		var/obj/item/W = usr.get_active_hand()
		if(!istype(W, /obj/item))
			usr << "<span class='warning'>You have nothing in hand or in [src]!</span>"
			return
		H.holster(W, usr)
	else
		H.unholster(usr)


////GUNS////
/obj/item/clothing/accessory/holster/gun/can_holster(var/obj/item/I, var/mob/living/user)
	if (!(I.slot_flags & SLOT_HOLSTER))
		user << "<span class='warning'>[I] won't fit in [src]!</span>"
		return 0
	return ..()

/obj/item/clothing/accessory/holster/gun/unholster(mob/user as mob)
	if(istype(user.get_active_hand(),/obj) && istype(user.get_inactive_hand(),/obj))
		user << "<span class='warning'>You need an empty hand to draw \the [holstered]!</span>"
	else
		if(user.a_intent == I_HURT)
			usr.visible_message(
				"<span class='danger'>[user] draws \the [holstered], ready to shoot!</span>",
				"<span class='warning'>You draw \the [holstered], ready to shoot!</span>"
				)
		else
			user.visible_message(
				"<span class='notice'>[user] draws \the [holstered], pointing it at the ground.</span>",
				"<span class='notice'>You draw \the [holstered], pointing it at the ground.</span>"
				)
		return ..()

/obj/item/clothing/accessory/holster/gun/armpit
	name = "armpit holster"
	desc = "A worn-out handgun holster. Perfect for concealed carry"
	icon_state = "holster"

/obj/item/clothing/accessory/holster/gun/waist
	name = "waist holster"
	desc = "A handgun holster. Made of expensive leather."
	icon_state = "holster_low"

/obj/item/clothing/accessory/holster/gun/hip
	name = "hip holster"
	desc = "A handgun holster slung low on the hip, draw pardner!"
	icon_state = "holster_hip"


////KNIFES////
/obj/item/clothing/accessory/holster/knife
	name = "shoulder scabbard"
	desc = "A knife holster."
	icon_state = "sheath"
	allowed = list(
		/obj/item/weapon/material/hatchet,
		/obj/item/weapon/material/hatchet/unathiknife,
		/obj/item/weapon/material/knife
	)


/obj/item/clothing/accessory/holster/knife/hip
	name = "hip knife sheath"
	icon_state = "hip_sheath"

/obj/item/clothing/accessory/holster/knife/clear_holster()
	..()
	icon_state = initial(icon_state)
	update_clothing_icon()

/obj/item/clothing/accessory/holster/knife/holster(var/obj/item/I, var/mob/living/user)
	..()
	if(holstered)
		icon_state += "_full"
		update_clothing_icon()

/obj/item/clothing/accessory/holster/knife/unholster(mob/user as mob)
	if(user.get_active_hand() && user.get_inactive_hand())
		user << "<span class='warning'>You need an empty hand to draw \the [holstered]!</span>"
	else
		user.visible_message(
			"<span class='danger'>[user] draws \the [holstered]!</span>",
			"<span class='warning'>You draw \the [holstered]!</span>"
			)
		return ..()

/obj/item/clothing/accessory/holster/knife/can_holster(var/obj/item/I, var/mob/living/user)
	if(!is_type_in_list(I, allowed))
		user << "<span class='warning'>You can't put [I] here!</span>"
		return 0
	return ..()