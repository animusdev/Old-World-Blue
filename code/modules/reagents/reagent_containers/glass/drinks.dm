////////////////////////////////////////////////////////////////////////////////
/// Drinks.
////////////////////////////////////////////////////////////////////////////////
/obj/item/weapon/reagent_containers/glass/drinks
	/*Specials:
		attack_self() can only open container.
		update_icon() add lid overlay, ignore reagent data.
		examinate()   give rough info about container filling.*/
	name = "drink"
	desc = "yummy"
	icon = 'icons/obj/drinks.dmi'
	icon_state = null
	amount_per_transfer_from_this = 5
	volume = 50
	isGlass = 0

/obj/item/weapon/reagent_containers/glass/drinks/on_reagent_change()
	return

/obj/item/weapon/reagent_containers/glass/drinks/attack_self(mob/user as mob)
	if(!is_open_container())
		open(user)

/obj/item/weapon/reagent_containers/glass/drinks/proc/open(mob/user)
	playsound(loc,'sound/effects/canopen.ogg', rand(10,50), 1)
	user << "<span class='notice'>You open [src] with an audible pop!</span>"
	flags |= OPENCONTAINER

/obj/item/weapon/reagent_containers/glass/drinks/examine(var/mob/user)
	.=..()
	if(.<=2)
		if(!reagents)
			user << "<span class='notice'>\The [src] can't hold reagents anymore!</span>"
			return

		if(reagents.reagent_list.len)
			switch(round(reagents.total_volume/volume, 0.01))
				if(0 to 0.25)
					user << "<span class='notice'>\The [src] is almost empty!</span>"
				if(0.26 to 0.66)
					user << "<span class='notice'>\The [src] is half full!</span>"
				if(0.67 to 0.90)
					user << "<span class='notice'>\The [src] is almost full!</span>"
				else
					user << "<span class='notice'>\The [src] is full!</span>"
		else
			user << "<span class='notice'>It is empty.</span>"

		if(!is_open_container())
			user << "<span class='notice'>Must be open before use!</span>"

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
	name = "milk carton"
	desc = "It's milk. White and nutritious goodness!"
	icon_state = "milk"
	item_state = "carton"
	center_of_mass = list("x"=16, "y"=9)
	preloaded = list("milk" = 50)

/obj/item/weapon/reagent_containers/glass/drinks/soymilk
	name = "soymilk carton"
	desc = "It's soy milk. White and nutritious goodness!"
	icon_state = "soymilk"
	item_state = "carton"
	center_of_mass = list("x"=16, "y"=9)
	preloaded = list("soymilk" = 50)

/obj/item/weapon/reagent_containers/glass/drinks/milk/smallcarton
	name = "small milk carton"
	volume = 30
	icon_state = "mini-milk"
	preloaded = list("milk" = 30)

/obj/item/weapon/reagent_containers/glass/drinks/coffee
	name = "\improper Robust Coffee"
	desc = "Careful, the beverage you're about to enjoy is extremely hot."
	icon_state = "coffee"
	center_of_mass = list("x"=15, "y"=10)
	preloaded = list("coffee" = 30)

/obj/item/weapon/reagent_containers/glass/drinks/tea
	name = "cup of Duke Purple Tea"
	desc = "An insult to Duke Purple is an insult to the Space Queen! Any proper gentleman will fight you, if you sully this tea."
	icon_state = "teacup"
	item_state = "coffee"
	center_of_mass = list("x"=16, "y"=14)
	preloaded = list("tea" = 30)

/obj/item/weapon/reagent_containers/glass/drinks/ice
	name = "cup of ice"
	desc = "Careful, cold ice, do not chew."
	icon_state = "coffee"
	center_of_mass = list("x"=15, "y"=10)
	preloaded = list("ice" = 30)

/obj/item/weapon/reagent_containers/glass/drinks/h_chocolate
	name = "cup of Dutch hot coco"
	desc = "Made in Space South America."
	icon_state = "hot_coco"
	item_state = "coffee"
	center_of_mass = list("x"=15, "y"=13)
	preloaded = list("hot_coco" = 30)

/obj/item/weapon/reagent_containers/glass/drinks/dry_ramen
	name = "Cup Ramen"
	desc = "Just add 10ml water, self heats! A taste that reminds you of your school years."
	icon_state = "ramen"
	center_of_mass = list("x"=16, "y"=11)
	preloaded = list("dry_ramen" = 30)

/obj/item/weapon/reagent_containers/glass/drinks/orangejuice
	name = "Orange Juice"
	desc = "Full of vitamins and deliciousness!"
	icon_state = "orangejuice"
	item_state = "carton"
	volume = 100
	center_of_mass = list("x"=16, "y"=7)
	preloaded = list("orangejuice" = 100)

/obj/item/weapon/reagent_containers/glass/drinks/bottle/cream
	name = "Milk Cream"
	desc = "It's cream. Made from milk. What else did you think you'd find in there?"
	icon_state = "cream"
	item_state = "carton"
	volume = 100
	center_of_mass = list("x"=16, "y"=8)
	preloaded = list("cream" = 100)

/obj/item/weapon/reagent_containers/glass/drinks/bottle/tomatojuice
	name = "Tomato Juice"
	desc = "Well, at least it LOOKS like tomato juice. You can't tell with all that redness."
	icon_state = "tomatojuice"
	item_state = "carton"
	volume = 100
	center_of_mass = list("x"=16, "y"=8)
	preloaded = list("tomatojuice" = 100)

/obj/item/weapon/reagent_containers/glass/drinks/bottle/limejuice
	name = "Lime Juice"
	desc = "Sweet-sour goodness."
	icon_state = "limejuice"
	item_state = "carton"
	volume = 100
	center_of_mass = list("x"=16, "y"=8)
	preloaded = list("limejuice" = 100)

/obj/item/weapon/reagent_containers/glass/drinks/sillycup
	name = "paper cup"
	desc = "A paper water cup."
	icon_state = "water_cup_e"
	possible_transfer_amounts = null
	volume = 10
	center_of_mass = list("x"=16, "y"=12)

/obj/item/weapon/reagent_containers/glass/drinks/sillycup/update_icon()
	..()
	if(reagents.total_volume)
		icon_state = "water_cup"
	else
		icon_state = "water_cup_e"


//////////////////////////drinkingglass and shaker//
//Note by Darem: This code handles the mixing of drinks. New drinks go in three places:
//In Chemistry-Reagents.dm (for the drink itself),
//in Chemistry-Recipes.dm (for the reaction that changes the components into the drink),
//and here (for the drinking glass icon states).

/obj/item/weapon/reagent_containers/glass/drinks/shaker
	name = "shaker"
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
	isGlass = 1

/obj/item/weapon/reagent_containers/glass/drinks/flask
	name = "\improper Captain's flask"
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
	name = "\improper Detective's flask"
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
	name = "cup"
	desc = "A cup with the British flag emblazoned on it."
	icon_state = "britcup"
	volume = 30
	center_of_mass = list("x"=15, "y"=13)
	isGlass = 1

/obj/item/weapon/reagent_containers/glass/drinks/irecup
	name = "cup"
	desc = "A cup with the Irish flag emblazoned on it."
	icon_state = "irecup"
	volume = 30
	center_of_mass = list("x"=15, "y"=13)
	isGlass = 1

/obj/item/weapon/reagent_containers/glass/drinks/ntcup
	name = "cup"
	desc = "A cup with the NT logo emblazoned on it."
	icon_state = "nt"
	volume = 30
	center_of_mass = list("x"=15, "y"=13)
	isGlass = 1

