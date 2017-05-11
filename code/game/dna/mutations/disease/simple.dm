/datum/mutation/disease
	affect_primitive = TRUE
	aligment = MUTATION_BAD

/datum/mutation/disease/activate(mob/living/carbon/human/H)
	H.mutations.Add(src)
	if(activation_messages && activation_messages.len)
		var/msg = pick(activation_messages)
		H << "<span class='warning'>[msg]</span>"

/datum/mutation/disease/deactivate(mob/living/carbon/human/H)
	H.mutations.Remove(src)
	if(deactivation_messages && deactivation_messages.len)
		var/msg = pick(deactivation_messages)
		H << "<span class='notice'>[msg]</span>"

/datum/mutation/disease/nearsighted
	id = MUTATION_NEARSIGHTED
	activate(mob/living/carbon/human/H)
		..()
		var/obj/item/organ/internal/eyes/E = H.internal_organs_by_name[O_EYES]
		if(E && E.robotic < ORGAN_ROBOT)
			E.nearsighted = TRUE
	deactivate(mob/living/carbon/human/H)
		..()
		var/obj/item/organ/internal/eyes/E = H.internal_organs_by_name[O_EYES]
		E.nearsighted = FALSE


/*
NEARSIGHTED
#define EPILEPSY    2
#define COUGHING    4
#define TOURETTES   8
#define NERVOUS     16
*/

