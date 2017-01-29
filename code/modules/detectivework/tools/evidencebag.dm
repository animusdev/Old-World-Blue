//CONTAINS: Evidence bags and fingerprint cards

/obj/item/weapon/evidencebag
	name = "evidence bag"
	desc = "An empty evidence bag."
	icon = 'icons/obj/storage.dmi'
	icon_state = "evidenceobj"
	item_state = ""
	w_class = 1
	var/obj/item/stored_item = null

/obj/item/weapon/evidencebag/resolve_attackby(obj/item/I, mob/user)
	if(!istype(I) || I.anchored || istype(I, /obj/item/weapon/storage))
		return ..()

	if(istype(I, /obj/item/weapon/evidencebag))
		user << "<span class='notice'>You find putting an evidence bag in another evidence bag to be slightly absurd.</span>"
		return

	if(contents.len)
		user << "<span class='notice'>[src] already has something inside it.</span>"
		return ..()

	if(I.w_class > 3)
		user << "<span class='notice'>[I] won't fit in [src].</span>"
		return ..()

	if(ismob(I.loc))
		var/mob/M = I.loc
		if(!M.unEquip(I)) return
	else if(isobj(I.loc))
		if(!istype(I.loc, /obj/item/weapon/storage))
			return
		else
			var/obj/item/weapon/storage/S = I.loc
			if(!S.remove_from_storage(I))
				return

	user.visible_message("[user] puts [I] into [src]", "You put [I] inside [src].",\
	"You hear a rustle as someone puts something into a plastic bag.")

	icon_state = "evidence"

	var/xx = I.pixel_x	//save the offset of the item
	var/yy = I.pixel_y
	I.pixel_x = 0		//then remove it so it'll stay within the evidence bag
	I.pixel_y = 0
	var/image/img = image(icon=I, layer=FLOAT_LAYER)	//take a snapshot. (necessary to stop the underlays appearing under our inventory-HUD slots ~Carn
	I.pixel_x = xx		//and then return it
	I.pixel_y = yy
	overlays += img
	overlays += "evidence"	//should look nicer for transparent stuff. not really that important, but hey.

	desc = "An evidence bag containing [I]."
	I.loc = src
	stored_item = I
	w_class = I.w_class
	return


/obj/item/weapon/evidencebag/attack_self(mob/user as mob)
	if(contents.len)
		var/obj/item/I = contents[1]
		user.visible_message("[user] takes [I] out of [src]", "You take [I] out of [src].",\
		"You hear someone rustle around in a plastic bag, and remove something.")
		overlays.Cut()	//remove the overlays

		user.put_in_hands(I)
		stored_item = null

		w_class = initial(w_class)
		icon_state = "evidenceobj"
		desc = "An empty evidence bag."
	else
		user << "[src] is empty."
		icon_state = "evidenceobj"
	return

/obj/item/weapon/evidencebag/examine(mob/user, return_dist = 1)
	. = ..()
	if (.<4 && stored_item)
		user.examinate(stored_item)
