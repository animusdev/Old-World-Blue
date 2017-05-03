/obj/item/weapon/implanter
	name = "implanter"
	icon = 'icons/obj/items.dmi'
	icon_state = "implanter0"
	item_state = "syringe_0"
	throw_speed = 1
	throw_range = 5
	w_class = ITEM_SIZE_SMALL
	var/obj/item/weapon/implant/imp = null
	var/start_with = null

/obj/item/weapon/implanter/New()
	..()
	if(start_with)
		imp = new start_with(src)
		update_icon()

/*
/obj/item/weapon/implanter/attack_self(var/mob/user)
	if(!imp)
		return ..()
	user.put_in_hands(imp)
	user << SPAN_NOTE("You remove \the [imp] from \the [src].")
	name = "implanter"
	imp = null
	update_icon()
	return
*/

/obj/item/weapon/implanter/update_icon()
	if (src.imp)
		src.icon_state = "implanter1"
	else
		src.icon_state = "implanter0"
	return

/obj/item/weapon/implanter/attack(mob/living/M, mob/user)
	if (!istype(M, /mob/living/carbon))
		return

	var/obj/item/organ/external/affected = null
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		affected = H.get_organ(user.zone_sel.selecting)

	if(!affected)
		user << SPAN_WARN("[M] miss that body part!")
		return

	if (user && src.imp)
		M.visible_message(SPAN_WARN("[user] is attemping to implant [M]."))

		user.setClickCooldown(DEFAULT_QUICK_COOLDOWN)
		user.do_attack_animation(M)

		if(do_mob(user, M, 50) && src && src.imp)
			M.visible_message(
				SPAN_WARN("[user] has implanted [M] in [affected]."),
				SPAN_NOTE("You implanted \the [src.imp] into [M]'s [affected].")
			)

			admin_attack_log(user, M,
				"Implanted using \the [src.name] ([src.imp.name])",
				"Implanted with \the [src.name] ([src.imp.name])",
				"used an implanter, [src.name] ([src.imp.name]), on"
			)

			src.imp.implanted(M, affected)
			src.imp = null
			update_icon()

	return

/obj/item/weapon/implanter/loyalty
	name = "implanter-loyalty"
	start_with = /obj/item/weapon/implant/loyalty

/obj/item/weapon/implanter/explosive
	name = "implanter (E)"
	start_with = /obj/item/weapon/implant/explosive

/obj/item/weapon/implanter/adrenalin
	name = "implanter-adrenalin"
	start_with = /obj/item/weapon/implant/adrenalin

/obj/item/weapon/implanter/compressed
	name = "implanter (C)"
	icon_state = "cimplanter1"
	start_with = /obj/item/weapon/implant/compressed

/obj/item/weapon/implanter/compressed/update_icon()
	if (imp)
		var/obj/item/weapon/implant/compressed/c = imp
		if(!c.scanned)
			icon_state = "cimplanter1"
		else
			icon_state = "cimplanter2"
	else
		icon_state = "cimplanter0"
	return

/obj/item/weapon/implanter/compressed/attack(mob/M as mob, mob/user as mob)
	var/obj/item/weapon/implant/compressed/c = imp
	if (!c)	return
	if (c.scanned == null)
		user << "Please scan an object with the implanter first."
		return
	..()

/obj/item/weapon/implanter/compressed/afterattack(obj/item/A, mob/user, proximity)
	if(!proximity || src.loc != user)
		return
	if(istype(A,/obj/item) && imp)
		var/obj/item/weapon/implant/compressed/c = imp
		if (c.scanned)
			user << SPAN_WARN("Something is already scanned inside the implant!")
			return
		if(ismob(A.loc))
			var/mob/M = A.loc
			if(!M.unEquip(A))
				return
		else if(istype(A.loc,/obj/item/storage))
			var/obj/item/storage/S = A.loc
			S.remove_from_storage(A)

		A.forceMove(c)
		c.scanned = A
		update_icon()
