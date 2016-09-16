////////////////////////////////////////////////////////////////////////////////
/// Drinks.
////////////////////////////////////////////////////////////////////////////////
/obj/item/weapon/reagent_containers/glass/drinks
	name = "drink"
	desc = "yummy"
	icon = 'icons/obj/drinks.dmi'
	icon_state = null
	flags = OPENCONTAINER
	amount_per_transfer_from_this = 5
	volume = 50
	isGlass = 0
	on_reagent_change()
		return

	attack_self(mob/user as mob)
		return

	examine(mob/user, return_dist = 1)
		.=..()
		if(.<=2)
			if(!reagents || reagents.total_volume == 0)
				user << "<span class='notice'>\The [src] is empty!</span>"
			else if (reagents.total_volume <= volume * 0.25)
				user << "<span class='notice'>\The [src] is almost empty!</span>"
			else if (reagents.total_volume <= volume * 0.66)
				user << "<span class='notice'>\The [src] is half full!</span>"
			else if (reagents.total_volume <= volume * 0.90)
				user << "<span class='notice'>\The [src] is almost full!</span>"
			else
				user << "<span class='notice'>\The [src] is full!</span>"


////////////////////////////////////////////////////////////////////////////////
/// Drinks. END
////////////////////////////////////////////////////////////////////////////////

/obj/item/weapon/reagent_containers/glass/drinks/golden_cup
	desc = "A golden cup"
	name = "golden cup"
	icon_state = "golden_cup"
	item_state = "" //nope :(
	w_class = 4
	force = 14
	throwforce = 10
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = null
	volume = 150
	flags = CONDUCT | OPENCONTAINER

/obj/item/weapon/reagent_containers/glass/drinks/golden_cup/tournament_26_06_2011
	desc = "A golden cup. It will be presented to a winner of tournament 26 june and name of the winner will be graved on it."


///////////////////////////////////////////////Drinks
//Notes by Darem: Drinks are simply containers that start preloaded. Unlike condiments, the contents can be ingested directly
//	rather then having to add it to something else first. They should only contain liquids. They have a default container size of 50.
//	Formatting is the same as food.

/obj/item/weapon/reagent_containers/glass/drinks/milk
	name = "Space Milk"
	desc = "It's milk. White and nutritious goodness!"
	icon_state = "milk"
	item_state = "carton"
	center_of_mass = list("x"=16, "y"=9)
	New()
		..()
		reagents.add_reagent("milk", 50)

/obj/item/weapon/reagent_containers/glass/drinks/soymilk
	name = "SoyMilk"
	desc = "It's soy milk. White and nutritious goodness!"
	icon_state = "soymilk"
	item_state = "carton"
	center_of_mass = list("x"=16, "y"=9)
	New()
		..()
		reagents.add_reagent("soymilk", 50)

/obj/item/weapon/reagent_containers/glass/drinks/coffee
	name = "Robust Coffee"
	desc = "Careful, the beverage you're about to enjoy is extremely hot."
	icon_state = "coffee"
	center_of_mass = list("x"=15, "y"=10)
	New()
		..()
		reagents.add_reagent("coffee", 30)

/obj/item/weapon/reagent_containers/glass/drinks/tea
	name = "Duke Purple Tea"
	desc = "An insult to Duke Purple is an insult to the Space Queen! Any proper gentleman will fight you, if you sully this tea."
	icon_state = "teacup"
	item_state = "coffee"
	center_of_mass = list("x"=16, "y"=14)
	New()
		..()
		reagents.add_reagent("tea", 30)

/obj/item/weapon/reagent_containers/glass/drinks/ice
	name = "Ice Cup"
	desc = "Careful, cold ice, do not chew."
	icon_state = "coffee"
	center_of_mass = list("x"=15, "y"=10)
	New()
		..()
		reagents.add_reagent("ice", 30)

/obj/item/weapon/reagent_containers/glass/drinks/h_chocolate
	name = "Dutch Hot Coco"
	desc = "Made in Space South America."
	icon_state = "hot_coco"
	item_state = "coffee"
	center_of_mass = list("x"=15, "y"=13)
	New()
		..()
		reagents.add_reagent("hot_coco", 30)

/obj/item/weapon/reagent_containers/glass/drinks/dry_ramen
	name = "Cup Ramen"
	desc = "Just add 10ml water, self heats! A taste that reminds you of your school years."
	icon_state = "ramen"
	center_of_mass = list("x"=16, "y"=11)
	New()
		..()
		reagents.add_reagent("dry_ramen", 30)


/obj/item/weapon/reagent_containers/glass/drinks/sillycup
	name = "Paper Cup"
	desc = "A paper water cup."
	icon_state = "water_cup_e"
	possible_transfer_amounts = null
	volume = 10
	center_of_mass = list("x"=16, "y"=12)
	New()
		..()
	on_reagent_change()
		if(reagents.total_volume)
			icon_state = "water_cup"
		else
			icon_state = "water_cup_e"


//////////////////////////drinkingglass and shaker//
//Note by Darem: This code handles the mixing of drinks. New drinks go in three places: In Chemistry-Reagents.dm (for the drink
//	itself), in Chemistry-Recipes.dm (for the reaction that changes the components into the drink), and here (for the drinking glass
//	icon states.

/obj/item/weapon/reagent_containers/glass/drinks/shaker
	name = "Shaker"
	desc = "A metal shaker to mix drinks in."
	icon_state = "shaker"
	amount_per_transfer_from_this = 10
	volume = 120
	center_of_mass = list("x"=17, "y"=10)

/obj/item/weapon/reagent_containers/glass/drinks/teapot
	name = "teapot"
	desc = "An elegant teapot. It simply oozes class."
	icon_state = "teapot"
	item_state = "teapot"
	amount_per_transfer_from_this = 10
	volume = 120
	center_of_mass = list("x"=17, "y"=7)

/obj/item/weapon/reagent_containers/glass/drinks/flask
	name = "Captain's Flask"
	desc = "A metal flask belonging to the captain"
	icon_state = "flask"
	volume = 60
	center_of_mass = list("x"=17, "y"=7)

/obj/item/weapon/reagent_containers/glass/drinks/flask/shiny
	name = "shiny flask"
	desc = "A shiny metal flask. It appears to have a Greek symbol inscribed on it."
	icon_state = "shinyflask"

/obj/item/weapon/reagent_containers/glass/drinks/flask/lithium
	name = "lithium flask"
	desc = "A flask with a Lithium Atom symbol on it."
	icon_state = "lithiumflask"

/obj/item/weapon/reagent_containers/glass/drinks/flask/detflask
	name = "Detective's Flask"
	desc = "A metal flask with a leather band and golden badge belonging to the detective."
	icon_state = "detflask"
	volume = 60
	center_of_mass = list("x"=17, "y"=8)

/obj/item/weapon/reagent_containers/glass/drinks/flask/barflask
	name = "flask"
	desc = "For those who can't be bothered to hang out at the bar to drink."
	icon_state = "barflask"
	volume = 60
	center_of_mass = list("x"=17, "y"=7)

/obj/item/weapon/reagent_containers/glass/drinks/flask/vacuumflask
	name = "vacuum flask"
	desc = "Keeping your drinks at the perfect temperature since 1892."
	icon_state = "vacuumflask"
	volume = 60
	center_of_mass = list("x"=15, "y"=4)

/obj/item/weapon/reagent_containers/glass/drinks/britcup
	name = "British cup"
	desc = "A cup with the British flag emblazoned on it."
	icon_state = "britcup"
	volume = 30
	center_of_mass = list("x"=15, "y"=13)
	isGlass = 1

/obj/item/weapon/reagent_containers/glass/drinks/irecup
	name = "Irish cup"
	desc = "A cup with the Irish flag emblazoned on it."
	icon_state = "irecup"
	volume = 30
	center_of_mass = list("x"=15, "y"=13)
	isGlass = 1

/obj/item/weapon/reagent_containers/glass/drinks/ntcup
	name = "NT cup"
	desc = "A cup with the NT logo emblazoned on it."
	icon_state = "nt"
	volume = 30
	center_of_mass = list("x"=15, "y"=13)
	isGlass = 1

