/datum/power/changeling/transformation_sting
	name = "Transformation Sting"
	desc = "We silently sting a human, injecting a retrovirus that forces them to transform into another."
	helptext = "Does not provide a warning to others. The victim will transform much like a changeling would."
	enhancedtext = "Requires a neck grab."
	genomecost = 3
	verbpath = /mob/living/proc/changeling_transformation_sting

/mob/living/proc/changeling_transformation_sting()
	set category = "Changeling"
	set name = "Transformation sting (40)"
	set desc="Sting target"

	var/datum/changeling/changeling = changeling_power(40)
	if(!changeling)
		return 0

	var/obj/item/weapon/grab/G = src.get_active_hand()
	if(!istype(G))
		src << "<span class='warning'>We must be grabbing a creature in our active hand to transform them.</span>"
		return 0
	if(G.state < GRAB_NECK)
		src << "<span class='warning'>We must have a tighter grip to transform this creature.</span>"
		return 0

	var/list/names = list()
	for(var/datum/dna/DNA in changeling.absorbed_dna)
		names += "[DNA.real_name]"

	var/S = input("Select the target DNA: ", "Target DNA", null) as null|anything in names
	if(!S)
		return

	var/datum/dna/chosen_dna = changeling.GetDNA(S)
	if(!chosen_dna)
		return

	changeling.chem_charges -= 40
	src.verbs -= /mob/living/proc/changeling_transformation_sting
	spawn(10)
		src.verbs += /mob/living/proc/changeling_transformation_sting

	var/mob/living/carbon/T = G.affecting
	if((HUSK in T.mutations) || !ishuman(T) || issmall(T))
		src << "<span class='warning'>Our sting appears ineffective against its DNA.</span>"
		return 0
	src << "<span class='notice'>We stealthily sting [T] in the neck.</span>"
	if(!T.mind || !T.mind.changeling)
		T.visible_message("<span class='warning'>[T] transforms!</span>")
		T.dna = chosen_dna.Clone()
		T.real_name = chosen_dna.real_name
		T.UpdateAppearance()
		domutcheck(T, null)
		return 1
	T << "<span class='warning'>You feel a tiny prick.</span>"
	return 1
