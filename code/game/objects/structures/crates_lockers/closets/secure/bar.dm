/obj/structure/closet/secure_closet/cabinet/bar
	name = "booze closet"
	req_access = list(access_bar)

	New()
		..()
		for(var/i = 1 to 10)
			new /obj/item/weapon/reagent_containers/glass/drinks/bottle/small/beer( src )
		return

