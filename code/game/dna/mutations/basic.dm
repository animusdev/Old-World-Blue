var/list/all_mutations = new

/datum/species
	var/list/mutations = new
/*
/mob/verb/check_powers_list()
	set name = "List mutations"
	set category = "Debug"

	src << "Begin check"
	src << "All mutations ammount = [all_mutations.len]"
	for(var/block in all_mutations)
		var/datum/mutation/M = all_mutations[block]
		src << "\tMutation \"[M.id]\""
	src << "============="
	src << "Alt: [jointext(all_mutations, ", ")]"
	src << "End check"
*/

/hook/startup/proc/populate_mutation_list()
	for(var/path in subtypesof(/datum/mutation))
		var/datum/mutation/M = new path
		if(!M.id)
			qdel(M)
			continue

		all_mutations[M.id] = M
		var/list/check_list = list()
		if(M.affected_species && M.affected_species.len)
			check_list = M.affected_species
		else
			check_list = playable_species - M.restricted_species

		for(var/species in check_list)
			var/datum/species/S = all_species[species]
			S.mutations += M.id
			if(S.primitive_form && M.affect_primitive)
				S = all_species[S.primitive_form]
				S.mutations += M.id
	return TRUE

/mob/living/carbon/human/proc/update_mutations()
	var/datum/mutation/mutation = null
	for(var/i = 1 to dna.SE.len)
		mutation = all_mutations[species.mutations[i]]
		mutation.test(src, dna.SE[i], 0)


/////////////////////
// MUTATION ITSELF //
/////////////////////

/datum/mutation
	var/id = ""
	var/tier = 1
	var/affect_primitive = FALSE
	var/list/activation_messages
	var/list/deactivation_messages
	var/list/affected_species
	var/list/restricted_species
	var/activation_level = 2048
	var/aligment = MUTATION_NEUTRAL

/datum/mutation/proc/get_state(var/SE_level)
	if(activation_level > SE_level)
		return 1
	else
		return 0

/datum/mutation/proc/pick_state_value(var/state)
	if(!state)
		return pick(1, activation_level-1)
	else
		return pick(activation_level, MAX_SE_VALUE)

/datum/mutation/proc/test(var/mob/living/carbon/human/H, var/SE_level, var/modif)
	modif = SIGN(modif) * 0.5 * activation_level

	if(src in H.mutations && (H.isSynthetic() || (activation_level - modif) > SE_level))
		deactivate(H)
	else
		activate(H)

/datum/mutation/proc/forced_activate(var/mob/living/carbon/human/H, var/state)
	H.dna.SE[id] = pick(activation_level, MAX_SE_VALUE)
	src.activate(H)

/datum/mutation/proc/forced_deactivate(var/mob/living/carbon/human/H)
	H.dna.SE[id] = pick(1, activation_level-1)
	src.deactivate(H)

/datum/mutation/proc/activate(var/mob/living/carbon/human/H)
	H.mutations.Add(src)
	if(activation_messages && activation_messages.len)
		var/msg = pick(activation_messages)
		H << "<span class='notice'>[msg]</span>"

/datum/mutation/proc/deactivate(var/mob/living/carbon/human/H)
	H.mutations.Remove(src)
	if(deactivation_messages && deactivation_messages.len)
		var/msg = pick(deactivation_messages)
		H << "<span class='warning'>[msg]</span>"

/datum/mutation/proc/on_mob_life(var/mob/living/carbon/human)
	return

