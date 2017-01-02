/*
*	Here is where any supply packs related
*		to being hospitable tasks live
*/


/datum/supply_packs/hospitality
	group = "Hospitality"

/datum/supply_packs/hospitality/party
	name = "Party equipment"
	contains = list(
		/obj/item/weapon/storage/box/drinkingglasses,
		/obj/item/weapon/reagent_containers/glass/drinks/shaker,
		/obj/item/weapon/reagent_containers/glass/drinks/flask/barflask,
		/obj/item/weapon/reagent_containers/glass/drinks/bottle/patron,
		/obj/item/weapon/reagent_containers/glass/drinks/bottle/goldschlager,
		/obj/item/weapon/storage/fancy/cigarettes/dromedaryco,
		/obj/item/weapon/lipstick/random,
		/obj/item/weapon/reagent_containers/glass/drinks/bottle/small/ale = 2,
		/obj/item/weapon/reagent_containers/glass/drinks/bottle/small/beer = 4
	)
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Party equipment"


/datum/supply_packs/randomised/hospitality/
	group = "Hospitality"

/datum/supply_packs/randomised/hospitality/pizza
	num_contained = 5
	contains = list(
		/obj/item/pizzabox/margherita,
		/obj/item/pizzabox/mushroom,
		/obj/item/pizzabox/meat,
		/obj/item/pizzabox/vegetable
	)
	name = "Surprise pack of five pizzas"
	cost = 15
	containertype = /obj/structure/closet/crate/freezer
	containername = "Pizza crate"
