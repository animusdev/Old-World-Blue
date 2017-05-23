//original code and idea from Alfie275 (luna era) and ISaidNo (goonservers) - with thanks

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Xenoarchaeological finds

/datum/find
	var/find_type = 0				//random according to the digsite type
	var/excavation_required = 0		//random 5-95%
	var/view_range = 20				//how close excavation has to come to show an overlay on the turf
	var/clearance_range = 3			//how close excavation has to come to extract the item
									//if excavation hits var/excavation_required exactly, it's contained find is extracted cleanly without the ore
	var/prob_delicate = 90			//probability it requires an active suspension field to not insta-crumble
	var/dissonance_spread = 1		//proportion of the tile that is affected by this find
									//used in conjunction with analysis machines to determine correct suspension field type

/datum/find/New(var/digsite, var/exc_req)
	excavation_required = exc_req
	find_type = get_random_find_type(digsite)
	clearance_range = rand(2,6)
	dissonance_spread = rand(1500,2500) / 100

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Strange rocks

//have all strange rocks be cleared away using welders for now
/obj/item/weapon/ore/strangerock
	name = "Strange rock"
	desc = "Seems to have some unusal strata evident throughout it."
	icon = 'icons/obj/xenoarchaeology.dmi'
	icon_state = "strange"
	var/obj/item/weapon/inside
	var/method = 0// 0 = fire, 1 = brush, 2 = pick
	origin_tech = list(TECH_MATERIAL = 5)

/obj/item/weapon/ore/strangerock/New(loc, var/inside_item_type = 0)
	..(loc)

	//method = rand(0,2)
	if(inside_item_type)
		inside = new/obj/item/weapon/archaeological_find(src, new_item_type = inside_item_type)
		if(!inside)
			inside = locate() in contents

/*/obj/item/weapon/ore/strangerock/ex_act(var/severity)
	if(severity && prob(30))
		src.visible_message("The [src] crumbles away, leaving some dust and gravel behind.")*/

/obj/item/weapon/ore/strangerock/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/weldingtool/))
		var/obj/item/weapon/weldingtool/w = W
		if(w.isOn())
			if(w.get_fuel() >= 4 && !src.method)
				if(inside)
					inside.loc = get_turf(src)
					for(var/mob/M in viewers(world.view, user))
						M.show_message("<span class='info'>[src] burns away revealing [inside].</span>",1)
				else
					for(var/mob/M in viewers(world.view, user))
						M.show_message("<span class='info'>[src] burns away into nothing.</span>",1)
				qdel(src)
				w.remove_fuel(4)
			else
				for(var/mob/M in viewers(world.view, user))
					M.show_message("<span class='info'>A few sparks fly off [src], but nothing else happens.</span>",1)
				w.remove_fuel(1)
			return

	else if(istype(W,/obj/item/device/core_sampler/))
		var/obj/item/device/core_sampler/S = W
		S.sample_item(src, user)
		return

	..()

	if(prob(33))
		src.visible_message("<span class='warning'>[src] crumbles away, leaving some dust and gravel behind.</span>")
		qdel(src)
