/obj/item/clothing/shoes/galoshes
	desc = "Rubber boots"
	name = "galoshes"
	icon_state = "galoshes"
	permeability_coefficient = 0.05
	item_flags = NOSLIP
	slowdown = 1
	species_restricted = null

/obj/item/clothing/shoes/jackboots
	name = "jackboots"
	desc = "Nanotrasen-issue Security combat boots for combat scenarios or combat situations. All combat, all the time."
	icon_state = "jackboots"
	force = 3
	armor = list(melee = 30, bullet = 10, laser = 10, energy = 15, bomb = 20, bio = 0, rad = 0)
	siemens_coefficient = 0.7
	var/obj/item/weapon/material/hatchet/tacknife/knife = null

/obj/item/clothing/shoes/jackboots/verb/remove_knife()
	set name = "Remove knife"
	set desc = "Get knife from boot and put in your hand."
	set category = "Object"

	var/mob/living/carbon/human/M = usr
	if(knife && istype(M))
		if(M.put_in_hands(knife))
			M << "<div class='notice'>You slide the [knife] out of [src].</div>"
			knife = null
			update_icon()

/obj/item/clothing/shoes/jackboots/attackby(var/obj/item/weapon/material/hatchet/tacknife/I, var/mob/living/M)
	if(istype(I))
		if(knife) return
		M.drop_from_inventory(I, src)
		knife = I
		M << "<div class='notice'>You slide the [I] into [src].<div>"
		update_icon()
	else ..()

/obj/item/clothing/shoes/jackboots/update_icon()
	..() // Drop overlays, add blood overlay and so on
	if(knife)
		overlays += image(icon, "[initial(icon_state)]_knife")

/obj/item/clothing/shoes/jackboots/unathi
	name = "toe-less jackboots"
	desc = "Modified pair of jackboots, particularly friendly to those species whose toes hold claws."
	icon_state = "digiboots"
	species_restricted = null

/obj/item/clothing/shoes/workboots
	name = "workboots"
	desc = "A pair of steel-toed work boots designed for use in industrial settings. Safety first."
	icon_state = "workboots"
	armor = list(melee = 40, bullet = 0, laser = 0, energy = 15, bomb = 20, bio = 0, rad = 20)
	siemens_coefficient = 0.7

/obj/item/clothing/shoes/workboots/toeless
	name = "toe-less workboots"
	desc = "A pair of toeless work boots designed for use in industrial settings. Modified for species whose toes have claws."
	icon_state = "workbootstoeless"
	species_restricted = null