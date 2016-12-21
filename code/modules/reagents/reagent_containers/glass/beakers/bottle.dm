
//Not to be confused with /obj/item/weapon/reagent_containers/glass/drinks/bottle

/obj/item/weapon/reagent_containers/glass/beaker/bottle
	/*Specials:
		New()   get special bottle icon.*/
	name = "bottle"
	desc = "A small bottle."
	icon = 'icons/obj/chemical.dmi'
	icon_state = null
	item_state = "atoxinbottle"
	center_of_mass = list("x"=15, "y"=10)
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,25,30,60)
	flags = 0
	volume = 60
	lid_type = "bottle"

/obj/item/weapon/reagent_containers/glass/beaker/bottle/New()
	if(!icon_state)
		icon_state = "bottle-[rand(1,4)]"
	..()
	update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/inaprovaline
	name = "inaprovaline bottle"
	desc = "A small bottle. Contains inaprovaline - used to stabilize patients."
	icon_state = "bottle-4"
	preloaded = list("inaprovaline" = 60)

/obj/item/weapon/reagent_containers/glass/beaker/bottle/toxin
	name = "toxin bottle"
	desc = "A small bottle of toxins. Do not drink, it is poisonous."
	icon_state = "bottle-3"
	preloaded = list("toxin" = 60)

//for aphrodisiac
/obj/item/weapon/reagent_containers/glass/beaker/bottle/kurovasicin
	name = "kurovasicin bottle"
	desc = "Not safe for work."
	icon_state = "bottle-3"
	preloaded = list("kurovasicin" = 60)

/obj/item/weapon/reagent_containers/glass/beaker/bottle/cyanide
	name = "cyanide bottle"
	desc = "A small bottle of cyanide. Bitter almonds?"
	icon_state = "bottle-3"
	preloaded = list("cyanide" = 30)

/obj/item/weapon/reagent_containers/glass/beaker/bottle/stoxin
	name = "soporific bottle"
	desc = "A small bottle of soporific. Just the fumes make you sleepy."
	icon_state = "bottle-3"
	preloaded = list("stoxin" = 60)

/obj/item/weapon/reagent_containers/glass/beaker/bottle/chloralhydrate
	name = "Chloral Hydrate Bottle"
	desc = "A small bottle of Choral Hydrate. Mickey's Favorite!"
	icon_state = "bottle-3"
	preloaded = list("chloralhydrate" = 30)

/obj/item/weapon/reagent_containers/glass/beaker/bottle/antitoxin
	name = "dylovene bottle"
	desc = "A small bottle of dylovene. Counters poisons, and repairs damage. A wonder drug."
	icon_state = "bottle-4"
	preloaded = list("anti_toxin" = 60)

/obj/item/weapon/reagent_containers/glass/beaker/bottle/mutagen
	name = "unstable mutagen bottle"
	desc = "A small bottle of unstable mutagen. Randomly changes the DNA structure of whoever comes in contact."
	icon_state = "bottle-1"
	preloaded = list("mutagen" = 60)

/obj/item/weapon/reagent_containers/glass/beaker/bottle/ammonia
	name = "ammonia bottle"
	desc = "A small bottle."
	icon_state = "bottle-1"
	preloaded = list("ammonia" = 60)

/obj/item/weapon/reagent_containers/glass/beaker/bottle/diethylamine
	name = "diethylamine bottle"
	desc = "A small bottle."
	icon_state = "bottle-4"
	preloaded = list("diethylamine" = 60)

/obj/item/weapon/reagent_containers/glass/beaker/bottle/pacid
	name = "Polytrinic Acid Bottle"
	desc = "A small bottle. Contains a small amount of Polytrinic Acid"
	icon_state = "bottle-4"
	preloaded = list("pacid" = 60)

/obj/item/weapon/reagent_containers/glass/beaker/bottle/adminordrazine
	name = "Adminordrazine Bottle"
	desc = "A small bottle. Contains the liquid essence of the gods."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "holyflask"
	preloaded = list("adminordrazine" = 60)

/obj/item/weapon/reagent_containers/glass/beaker/bottle/capsaicin
	name = "Capsaicin Bottle"
	desc = "A small bottle. Contains hot sauce."
	icon_state = "bottle-4"
	preloaded = list("capsaicin" = 60)

/obj/item/weapon/reagent_containers/glass/beaker/bottle/frostoil
	name = "Frost Oil Bottle"
	desc = "A small bottle. Contains cold sauce."
	icon_state = "bottle-4"
	preloaded = list("frostoil" = 60)
