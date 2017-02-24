var/global/list/all_robolimbs = list()
var/global/list/chargen_robolimbs = list()
var/global/datum/robolimb/basic_robolimb

/proc/populate_robolimb_list()
	basic_robolimb = new()
	for(var/limb_type in typesof(/datum/robolimb))
		var/datum/robolimb/R = new limb_type()
		all_robolimbs[R.company] = R
		if(!R.unavailable_at_chargen)
			chargen_robolimbs[R.company] = R

/datum/robolimb
	var/company = "Unbranded"                            // Shown when selecting the limb.
	var/desc = "A generic unbranded robotic prosthesis." // Seen when examining a limb.
	var/icon = 'icons/mob/human_races/cyberlimbs/robotic.dmi' // Icon base to draw from.
	var/unavailable_at_chargen                           // If set, not available at chargen.

	var/unavailable_to_build							 // If set, can't be constructed.
	var/lifelike										 // If set, appears organic.
	var/blood_color = SYNTH_BLOOD_COLOUR
	var/list/species_cannot_use = list("Vox")
/*
	var/list/monitor_styles								 //If empty, the model of limbs offers a head compatible with monitors.
	var/parts = BP_ALL									 //Defines what parts said brand can replace on a body.
	var/health_hud_intensity = 1						 // Intensity modifier for the health GUI indicator.
*/

/datum/robolimb/bishop
	company = "Bishop Cybernetics"
	desc = "This limb has a white polymer casing with blue holo-displays."
	icon = 'icons/mob/human_races/cyberlimbs/bishop.dmi'

/datum/robolimb/hesphaistos
	company = "Hesphiastos Industries"
	desc = "This limb has a militaristic black and green casing with gold stripes."
	icon = 'icons/mob/human_races/cyberlimbs/hesphaistos.dmi'

/datum/robolimb/zenghu
	company = "Zeng-Hu Pharmaceuticals"
	desc = "This limb has a rubbery fleshtone covering with visible seams."
	icon = 'icons/mob/human_races/cyberlimbs/zenghu.dmi'

/datum/robolimb/xion
	company = "Xion Manufacturing Group"
	desc = "This limb has a minimalist black and red casing."
	icon = 'icons/mob/human_races/cyberlimbs/xion.dmi'

/datum/robolimb/cyber
	company = "Cyber Industries"
	desc = "This limb has a dark metal casing and looks a bit brutal."
	icon = 'icons/mob/human_races/cyberlimbs/cyber.dmi'
