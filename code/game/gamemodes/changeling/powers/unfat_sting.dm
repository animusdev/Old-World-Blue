/datum/power/changeling/unfat_sting
	name = "Unfat Sting"
	desc = "We silently sting a human, forcing them to rapidly metabolize their fat."
	genomecost = 1
	verbpath = /mob/living/proc/changeling_unfat_sting

/mob/living/proc/changeling_unfat_sting()
	set category = "Changeling"
	set name = "Unfat sting (5)"
	set desc = "Sting target"

	var/mob/living/carbon/T = changeling_sting(5,/mob/living/proc/changeling_unfat_sting)
	if(!T)	return 0
	T << "<span class='danger'>you feel a small prick as stomach churns violently and you become to feel skinnier.</span>"
	T.overeatduration = 0
	T.nutrition -= 100
	return 1
