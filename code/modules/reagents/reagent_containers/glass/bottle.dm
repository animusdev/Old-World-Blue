
//Not to be confused with /obj/item/weapon/reagent_containers/glass/drinks/bottle

/obj/item/weapon/reagent_containers/glass/beaker/bottle
	name = "bottle"
	desc = "A small bottle."
	icon_state = "bottle"
	item_state = "atoxinbottle"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,25,30,60)
	flags = 0
	volume = 60

	New()
		..()
		if(!icon_state)
			icon_state = "bottle-[rand(1,4)]"

	update_icon()
		if(icon_state in list("bottle-1", "bottle-2", "bottle-3", "bottle-4"))
			..()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/inaprovaline
	name = "inaprovaline bottle"
	desc = "A small bottle. Contains inaprovaline - used to stabilize patients."
	icon_state = "bottle-4"

	New()
		..()
		reagents.add_reagent("inaprovaline", 60)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/toxin
	name = "toxin bottle"
	desc = "A small bottle of toxins. Do not drink, it is poisonous."
	icon_state = "bottle-3"

	New()
		..()
		reagents.add_reagent("toxin", 60)
		update_icon()

//for aphrodisiac
/obj/item/weapon/reagent_containers/glass/beaker/bottle/kurovasicin
	name = "kurovasicin bottle"
	desc = "Not safe for work."
	icon_state = "bottle-3"

	New()
		..()
		reagents.add_reagent("kurovasicin", 60)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/cyanide
	name = "cyanide bottle"
	desc = "A small bottle of cyanide. Bitter almonds?"
	icon_state = "bottle-3"

	New()
		..()
		reagents.add_reagent("cyanide", 30) //volume changed to match chloral
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/stoxin
	name = "soporific bottle"
	desc = "A small bottle of soporific. Just the fumes make you sleepy."
	icon_state = "bottle-3"

	New()
		..()
		reagents.add_reagent("stoxin", 60)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/chloralhydrate
	name = "Chloral Hydrate Bottle"
	desc = "A small bottle of Choral Hydrate. Mickey's Favorite!"
	icon_state = "bottle-3"

	New()
		..()
		reagents.add_reagent("chloralhydrate", 30)		//Intentionally low since it is so strong. Still enough to knock someone out.
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/antitoxin
	name = "dylovene bottle"
	desc = "A small bottle of dylovene. Counters poisons, and repairs damage. A wonder drug."
	icon_state = "bottle-4"

	New()
		..()
		reagents.add_reagent("anti_toxin", 60)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/mutagen
	name = "unstable mutagen bottle"
	desc = "A small bottle of unstable mutagen. Randomly changes the DNA structure of whoever comes in contact."
	icon_state = "bottle-1"

	New()
		..()
		reagents.add_reagent("mutagen", 60)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/ammonia
	name = "ammonia bottle"
	desc = "A small bottle."
	icon_state = "bottle-1"

	New()
		..()
		reagents.add_reagent("ammonia", 60)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/diethylamine
	name = "diethylamine bottle"
	desc = "A small bottle."
	icon_state = "bottle-4"

	New()
		..()
		reagents.add_reagent("diethylamine", 60)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/flu_virion
	name = "Flu virion culture bottle"
	desc = "A small bottle. Contains H13N1 flu virion culture in synthblood medium."
	icon_state = "bottle-4"

	New()
		..()
		var/datum/disease/F = new /datum/disease/advance/flu(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/epiglottis_virion
	name = "Epiglottis virion culture bottle"
	desc = "A small bottle. Contains Epiglottis virion culture in synthblood medium."
	icon_state = "bottle-4"

	New()
		..()
		var/datum/disease/F = new /datum/disease/advance/voice_change(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/liver_enhance_virion
	name = "Liver enhancement virion culture bottle"
	desc = "A small bottle. Contains liver enhancement virion culture in synthblood medium."
	icon_state = "bottle-4"

	New()
		..()
		var/datum/disease/F = new /datum/disease/advance/heal(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/hullucigen_virion
	name = "Hullucigen virion culture bottle"
	desc = "A small bottle. Contains hullucigen virion culture in synthblood medium."
	icon_state = "bottle-4"

	New()
		..()
		var/datum/disease/F = new /datum/disease/advance/hullucigen(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/pierrot_throat
	name = "Pierrot's Throat culture bottle"
	desc = "A small bottle. Contains H0NI<42 virion culture in synthblood medium."
	icon_state = "bottle-4"

	New()
		..()
		var/datum/disease/F = new /datum/disease/pierrot_throat(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/cold
	name = "Rhinovirus culture bottle"
	desc = "A small bottle. Contains XY-rhinovirus culture in synthblood medium."
	icon_state = "bottle-4"

	New()
		..()
		var/datum/disease/advance/F = new /datum/disease/advance/cold(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/random
	name = "Random culture bottle"
	desc = "A small bottle. Contains a random disease."
	icon_state = "bottle-4"

	New()
		..()
		var/datum/disease/advance/F = new(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/retrovirus
	name = "Retrovirus culture bottle"
	desc = "A small bottle. Contains a retrovirus culture in a synthblood medium."
	icon_state = "bottle-4"

	New()
		..()
		var/datum/disease/F = new /datum/disease/dna_retrovirus(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)
		update_icon()


/obj/item/weapon/reagent_containers/glass/beaker/bottle/gbs
	name = "GBS culture bottle"
	desc = "A small bottle. Contains Gravitokinetic Bipotential SADS+ culture in synthblood medium."//Or simply - General BullShit
	amount_per_transfer_from_this = 5
	icon_state = "bottle-4"

	New()
		..()
		var/datum/reagents/R = new/datum/reagents(20)
		reagents = R
		R.my_atom = src
		var/datum/disease/F = new /datum/disease/gbs
		var/list/data = list("virus"= F)
		R.add_reagent("blood", 20, data)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/fake_gbs
	name = "GBS culture bottle"
	desc = "A small bottle. Contains Gravitokinetic Bipotential SADS- culture in synthblood medium."//Or simply - General BullShit
	icon_state = "bottle-4"

	New()
		..()
		var/datum/disease/F = new /datum/disease/fake_gbs(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)
		update_icon()
/*
/obj/item/weapon/reagent_containers/glass/beaker/bottle/rhumba_beat
	name = "Rhumba Beat culture bottle"
	desc = "A small bottle. Contains The Rhumba Beat culture in synthblood medium."//Or simply - General BullShit
	icon_state = "bottle-4"
	amount_per_transfer_from_this = 5

	New()
		var/datum/reagents/R = new/datum/reagents(20)
		reagents = R
		R.my_atom = src
		var/datum/disease/F = new /datum/disease/rhumba_beat
		var/list/data = list("virus"= F)
		R.add_reagent("blood", 20, data)
*/

/obj/item/weapon/reagent_containers/glass/beaker/bottle/brainrot
	name = "Brainrot culture bottle"
	desc = "A small bottle. Contains Cryptococcus Cosmosis culture in synthblood medium."
	icon_state = "bottle-4"

	New()
		..()
		var/datum/disease/F = new /datum/disease/brainrot(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/magnitis
	name = "Magnitis culture bottle"
	desc = "A small bottle. Contains a small dosage of Fukkos Miracos."
	icon_state = "bottle-4"

	New()
		..()
		var/datum/disease/F = new /datum/disease/magnitis(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)
		update_icon()


/obj/item/weapon/reagent_containers/glass/beaker/bottle/wizarditis
	name = "Wizarditis culture bottle"
	desc = "A small bottle. Contains a sample of Rincewindus Vulgaris."
	icon_state = "bottle-4"

	New()
		..()
		var/datum/disease/F = new /datum/disease/wizarditis(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/pacid
	name = "Polytrinic Acid Bottle"
	desc = "A small bottle. Contains a small amount of Polytrinic Acid"
	icon_state = "bottle-4"

	New()
		..()
		reagents.add_reagent("pacid", 60)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/adminordrazine
	name = "Adminordrazine Bottle"
	desc = "A small bottle. Contains the liquid essence of the gods."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "holyflask"

	New()
		..()
		reagents.add_reagent("adminordrazine", 60)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/capsaicin
	name = "Capsaicin Bottle"
	desc = "A small bottle. Contains hot sauce."
	icon_state = "bottle-4"

	New()
		..()
		reagents.add_reagent("capsaicin", 60)
		update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/bottle/frostoil
	name = "Frost Oil Bottle"
	desc = "A small bottle. Contains cold sauce."
	icon_state = "bottle-4"

	New()
		..()
		reagents.add_reagent("frostoil", 60)
		update_icon()
