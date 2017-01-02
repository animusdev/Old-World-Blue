/obj/structure/closet/secure_closet/freezer
	icon_state = "fridge"
	icon_opened = "fridgeopen"
	icon_broken = "fridgebroken"

/obj/structure/closet/secure_closet/freezer/kitchen
	name = "kitchen cabinet"
	req_access = list(access_kitchen)

	New()
		..()
		for(var/i = 1 to 7)
			new /obj/item/weapon/reagent_containers/condiment/flour(src)
		for(var/i = 1 to 2)
			new /obj/item/weapon/reagent_containers/condiment/sugar(src)
		for(var/i = 1 to 3)
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
		for(var/i = 1 to 6)
			new /obj/item/weapon/reagent_containers/glass/drinks/milk(src)
		for(var/i = 1 to 4)
			new /obj/item/weapon/reagent_containers/glass/drinks/soymilk(src)
		for(var/i = 1 to 2)
			new /obj/item/weapon/storage/fancy/egg_box(src)
		return



/obj/structure/closet/secure_closet/freezer/money
	name = "freezer"
	req_access = list(access_heads_vault)


	New()
		..()
		for(var/i = 1 to 3)
			new /obj/item/weapon/spacecash/c1000(src)
		for(var/i = 1 to 4)
			new /obj/item/weapon/spacecash/c500(src)
		for(var/i = 1 to 5)
			new /obj/item/weapon/spacecash/c200(src)
		return
