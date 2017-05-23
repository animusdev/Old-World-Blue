var/list/all_mutations = new

/datum/mutation
	var/id
	var/tier = 1
	var/list/activation_messages
	var/list/deactivation_messages
	var/list/affected_species
	var/activation_level

/datum/mutation/proc/test(var/mob/living/carbon/human/H, var/SE_level, var/modif)
	modif = SIGN(modif) * 0.5 * activation_level

	if(src in H.mutations && (activation_level - modif) > SE_level)
		deactivate(H)
	else
		activate(H)

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

