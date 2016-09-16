/obj/structure/closet/secure_closet/freezer
	icon_state = "fridge"
	icon_closed = "fridge"
	icon_opened = "fridgeopen"
	icon_broken = "fridgebroken"
	icon_off = "fridge"

/obj/structure/closet/secure_closet/freezer/kitchen
	name = "kitchen cabinet"
	req_access = list(access_kitchen)

	New()
		..()
		for(var/i = 0, i < 6, i++)
			new /obj/item/weapon/reagent_containers/food/condiment/flour(src)
		new /obj/item/weapon/reagent_containers/food/condiment/sugar(src)
		for(var/i = 0, i < 3, i++)
			new /obj/item/weapon/reagent_containers/food/snacks/meat/monkey(src)
		return


/obj/structure/closet/secure_closet/freezer/kitchen/mining
	req_access = list()


/obj/structure/closet/secure_closet/freezer/meat
	name = "meat fridge"

	New()
		..()
		for(var/i = 0, i < 4, i++)
			new /obj/item/weapon/reagent_containers/food/snacks/meat/monkey(src)
		return



/obj/structure/closet/secure_closet/freezer/fridge
	name = "refrigerator"

	New()
		..()
		for(var/i = 0, i < 5, i++)
			new /obj/item/weapon/reagent_containers/glass/drinks/milk(src)
		for(var/i = 0, i < 3, i++)
			new /obj/item/weapon/reagent_containers/glass/drinks/soymilk(src)
		for(var/i = 0, i < 2, i++)
			new /obj/item/weapon/storage/fancy/egg_box(src)
		return



/obj/structure/closet/secure_closet/freezer/money
	name = "freezer"
	req_access = list(access_heads_vault)


	New()
		..()
		for(var/i = 0, i < 3, i++)
			new /obj/item/weapon/spacecash/c1000(src)
		for(var/i = 0, i < 5, i++)
			new /obj/item/weapon/spacecash/c500(src)
		for(var/i = 0, i < 6, i++)
			new /obj/item/weapon/spacecash/c200(src)
		return
