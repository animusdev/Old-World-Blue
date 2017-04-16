#define VERB_PAGE "Shapeshifting"

var/list/shapeshifters = new

/obj/shapeshifter
	var/global/list/possible_shapeshifters_IDs = list(
		"Alpha","Beta","Gamma","Delta","Epsilon","Zeta","Eta",
		"Theta","Iota","Kappa","Lambda","Mu","Nu","Xi","Omicron",
		"Pi","Rho","Sigma","Tau","Upsilon","Phi","Chi","Psi","Omega"
	)

	var/mob/living/carbon/human/owner = null
	var/mob/living/carbon/shifter/shifter = null

	var/chem_storage = 50
	var/chem_charges = 20
	var/chem_recharge_rate = 0.5

	var/max_points = 100
	var/current_points = 50
	var/list/absorbed_dna = new
	var/list/captured_persons = new
	var/list/known_species = new

/obj/shapeshifter/New(var/mob/living/carbon/human/H)
	..()
	owner = H
	var/honorific = (owner.gender == FEMALE) ? "Ms." : "Mr."
	if(possible_changeling_IDs.len)
		name = pick(possible_shapeshifters_IDs)
		possible_shapeshifters_IDs -= name
	else
		name = "[rand(1,999)]"
	shapeshifters[name] = src


/obj/shapeshifter/proc/use_points(var/amount)
	if(amount < current_points)
		owner << SPAN_WARN("You have not enought points!")
		return 0
	current_points = max(0, current_points - amount)
	return 1


/obj/shapeshifter/verb/switch_species()
	set name = "Switch species"
	set category = VERB_PAGE

	var/new_species = input("Select species", current_species.name) in known_species


/obj/shapeshifter/verb/switch_form()
	set name = "Switch form"
	set category = VERB_PAGE

	if(!use_points(50))
		return


