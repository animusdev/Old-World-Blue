/datum/power/changeling/DeathSting
	name = "Death Sting"
	desc = "We silently sting a human, filling them with potent chemicals. Their rapid death is all but assured."
	genomecost = 10
	verbpath = /mob/living/proc/changeling_DEATHsting

/mob/living/proc/changeling_DEATHsting()
	set category = "Changeling"
	set name = "Death Sting (40)"
	set desc = "Causes spasms onto death."

	var/mob/living/carbon/T = changeling_sting(40,/mob/living/proc/changeling_DEATHsting)
	if(!T)
		return 0
	T << "<span class='danger'>You feel a small prick and your chest becomes tight.</span>"
	T.silent = 10
	T.Paralyse(10)
	T.make_jittery(100)
	if(T.reagents)	T.reagents.add_reagent("lexorin", 40)
	return 1
