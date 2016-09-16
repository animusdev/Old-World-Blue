/*
	Datum-based species. Should make for much cleaner and easier to maintain race code.
*/

/datum/species

	// Descriptors and strings.
	var/name                                             // Species name.
	var/name_plural                                      // Pluralized name (since "[name]s" is not always valid)
	var/blurb = "A completely nondescript species."      // A brief lore summary for use in the chargen screen.

	// Icon/appearance vars.
	var/icobase = 'icons/mob/human_races/r_human.dmi'    // Normal icon set.
	var/deform = 'icons/mob/human_races/r_def_human.dmi' // Mutated icon set.

	// Damage overlay and masks.
	var/damage_overlays = 'icons/mob/human_races/masks/dam_human.dmi'
	var/damage_mask = 'icons/mob/human_races/masks/dam_mask_human.dmi'
	var/blood_mask = 'icons/mob/human_races/masks/blood_human.dmi'

	var/prone_icon                           // If set, draws this from icobase when mob is prone.
	var/blood_color = "#A10808"              // Red.
	var/flesh_color = "#FFC896"              // Pink.
	var/base_color                           // Used by changelings. Should also be used for icon previes..
	var/tail                                 // Name of tail state in species effects icon file.
	var/tail_animation                       // If set, the icon to obtain tail animation states from.
	var/race_key = 0                         // Used for mob icon cache string.
	var/icon/icon_template                   // Used for mob icon generation for non-32x32 species.
	var/is_small
	var/show_ssd = "fast asleep"

	// Language/culture vars.
	var/default_language = "Galactic Common" // Default language is used when 'say' is used without modifiers.
	var/language = "Galactic Common"         // Default racial language, if any.
	var/secondary_langs = list()             // The names of secondary languages that are available to this species.
	var/list/speech_sounds                   // A list of sounds to potentially play when speaking.
	var/list/speech_chance                   // The likelihood of a speech sound playing.

	// Combat vars.
	var/total_health = 100                   // Point at which the mob will enter crit.
	var/list/unarmed_attacks = list(         // For empty hand harm-intent attack
		new /datum/unarmed_attack,
		new /datum/unarmed_attack/bite
		)
	var/brute_mod = 1                        // Physical damage multiplier.
	var/burn_mod = 1                         // Burn damage multiplier.
	var/vision_flags = SEE_SELF              // Same flags as glasses.
	var/taste_sensitivity = TASTE_NORMAL                   // How sensitive the species is to minute tastes. Higher values means less sensitive. Lower values means more sensitive.

	// Death vars.
	var/meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/human
	var/gibber_type = /obj/effect/gibspawner/human
	var/single_gib_type = /obj/effect/decal/cleanable/blood/gibs
	var/remains_type = /obj/effect/decal/remains/xeno
	var/gibbed_anim = "gibbed-h"
	var/dusted_anim = "dust-h"
	var/death_sound
	var/death_message = "seizes up and falls limp, their eyes dead and lifeless..."

	// Environment tolerance/life processes vars.
	var/reagent_tag                                   //Used for metabolizing reagents.
	var/breath_pressure = 16                          // Minimum partial pressure safe for breathing, kPa
	var/breath_type = "oxygen"                        // Non-oxygen gas breathed, if any.
	var/poison_type = "phoron"                        // Poisonous air.
	var/exhale_type = "carbon_dioxide"                // Exhaled gas type.
	var/cold_level_1 = 260                            // Cold damage level 1 below this point.
	var/cold_level_2 = 200                            // Cold damage level 2 below this point.
	var/cold_level_3 = 120                            // Cold damage level 3 below this point.
	var/heat_level_1 = 360                            // Heat damage level 1 above this point.
	var/heat_level_2 = 400                            // Heat damage level 2 above this point.
	var/heat_level_3 = 1000                           // Heat damage level 3 above this point.
	var/synth_temp_gain = 0			                  // IS_SYNTHETIC species will gain this much temperature every second
	var/hazard_high_pressure = HAZARD_HIGH_PRESSURE   // Dangerously high pressure.
	var/warning_high_pressure = WARNING_HIGH_PRESSURE // High pressure warning.
	var/warning_low_pressure = WARNING_LOW_PRESSURE   // Low pressure warning.
	var/hazard_low_pressure = HAZARD_LOW_PRESSURE     // Dangerously low pressure.
	var/light_dam                                     // If set, mob will be damaged in light over this value and heal in light below its negative.
	var/body_temperature = 310.15	                  // Non-IS_SYNTHETIC species will try to stabilize at this temperature.
	                                                  // (also affects temperature processing)

	var/heat_discomfort_level = 315                   // Aesthetic messages about feeling warm.
	var/cold_discomfort_level = 285                   // Aesthetic messages about feeling chilly.
	var/list/heat_discomfort_strings = list(
		"You feel sweat drip down your neck.",
		"You feel uncomfortably warm.",
		"Your skin prickles in the heat."
		)
	var/list/cold_discomfort_strings = list(
		"You feel chilly.",
		"You shiver suddely.",
		"Your chilly flesh stands out in goosebumps."
		)

	// HUD data vars.
	var/datum/hud_data/hud
	var/hud_type

	// Body/form vars.
	var/list/inherent_verbs 	  // Species-specific verbs.
	var/has_fine_manipulation = 1 // Can use small items.
	var/siemens_coefficient = 1   // The lower, the thicker the skin and better the insulation.
	var/darksight = 2             // Native darksight distance.
	var/toxins_mod = 1            // Toxloss modifier
	var/flags = 0                 // Various specific features.
	var/slowdown = 0              // Passive movement speed malus (or boost, if negative)
	var/primitive_form            // Lesser form, if any (ie. monkey for humans)
	var/greater_form              // Greater form, if any, ie. human for monkeys.
	var/holder_type
	var/gluttonous                // Can eat some mobs. 1 for mice, 2 for monkeys, 3 for people.
	var/rarity_value = 1          // Relative rarity/collector value for this species.
	                              // Determines the organs that the species spawns with and
	var/list/has_organ = list(    // which required-organ checks are conducted.
		"heart" =    /obj/item/organ/internal/heart,
		"lungs" =    /obj/item/organ/internal/lungs,
		"liver" =    /obj/item/organ/internal/liver,
		"kidneys" =  /obj/item/organ/internal/kidneys,
		"brain" =    /obj/item/organ/internal/brain,
		"appendix" = /obj/item/organ/internal/appendix,
		"eyes" =     /obj/item/organ/internal/eyes
		)

	var/list/has_limbs = list(
		"chest"  = new /datum/organ_description,
		"groin"  = new /datum/organ_description/groin,
		"head"   = new /datum/organ_description/head,
		"l_arm"  = new /datum/organ_description/arm/left,
		"r_arm"  = new /datum/organ_description/arm/right,
		"l_leg"  = new /datum/organ_description/leg/left,
		"r_leg"  = new /datum/organ_description/leg/right,
		"l_hand" = new /datum/organ_description/hand/left,
		"r_hand" = new /datum/organ_description/hand/right,
		"l_foot" = new /datum/organ_description/foot/left,
		"r_foot" = new /datum/organ_description/foot/right
	)

	// Bump vars
	var/bump_flag  = HUMAN	// What are we considered to be when bumped?
	var/push_flags = ~HEAVY	// What can we push?
	var/swap_flags = ~HEAVY	// What can we swap place with?

	// Misc
	var/list/restricted_jobs = list()
	var/list/accent = list()
	var/list/accentFL = list()
	var/allow_slim_fem = 0

	//Species Abilities
	var/tmp/evolution_points = 0 //How many points race have for abilities


	// Srites
	proc/get_uniform_sprite(state = "", var/body_build = 0)
		return 'icons/mob/uniform.dmi'

	proc/get_suit_sprite(state = "", var/body_build = 0)
		return 'icons/mob/suit.dmi'

	proc/get_head_sprite(state = "", var/body_build = 0)
		return 'icons/mob/head.dmi'

	proc/get_gloves_sprite(state = "", var/body_build = 0)
		return 'icons/mob/hands.dmi'

	proc/get_shoes_sprite(state = "", var/body_build = 0)
		return 'icons/mob/feet.dmi'

	proc/get_glasses_sprite(state = "", var/body_build = 0)
		return 'icons/mob/eyes.dmi'

//	proc/get_l_hand_sprite(state = "", var/body_build = 0)
//	proc/get_r_hand_sprite(state = "", var/body_build = 0)

	proc/get_belt_sprite(state = "", var/body_build = 0)
		return 'icons/mob/belt.dmi'

	proc/get_ears_sprite(state = "", var/body_build = 0)
		return 'icons/mob/ears.dmi'

	proc/get_back_sprite(state = "", var/body_build = 0)
		return 'icons/mob/back.dmi'

	proc/get_back_u_sprite(state = "", var/body_build = 0)
		if(state in icon_states('icons/mob/back.dmi'))
			return 'icons/mob/back.dmi'
		else return null

	proc/get_mask_sprite(state = "", var/body_build = 0)
		return 'icons/mob/mask.dmi'

	proc/get_store_sprite(state = "", var/body_build = 0)
		return 'icons/mob/belt_mirror.dmi'

	proc/get_hidden_slot_sprite(state = "", var/body_build)
		return 'icons/mob/hidden.dmi'

/datum/species/New()
	if(hud_type)
		hud = new hud_type()
	else
		hud = new()

/datum/species/proc/get_station_variant()
	return name

/datum/species/proc/get_bodytype()
	return name

/datum/species/proc/get_environment_discomfort(var/mob/living/carbon/human/H, var/msg_type)

	if(!prob(5))
		return

	var/covered = 0 // Basic coverage can help.
	for(var/obj/item/clothing/clothes in H)
		if(H.l_hand == clothes|| H.r_hand == clothes)
			continue
		if((clothes.body_parts_covered & UPPER_TORSO) && (clothes.body_parts_covered & LOWER_TORSO))
			covered = 1
			break

	switch(msg_type)
		if("cold")
			if(!covered)
				H << "<span class='danger'>[pick(cold_discomfort_strings)]</span>"
		if("heat")
			if(covered)
				H << "<span class='danger'>[pick(heat_discomfort_strings)]</span>"

/datum/species/proc/get_random_name(var/gender)
	var/datum/language/species_language = all_languages[language]
	if(!species_language)
		species_language = all_languages[default_language]
	if(!species_language)
		return "unknown"
	return species_language.get_random_name(gender)

/datum/species/proc/equip_survival_gear(var/mob/living/carbon/human/H, var/custom_survival_gear = /obj/item/weapon/storage/box/survival)
	if(H.back)
		H.equip_to_slot_or_del(new custom_survival_gear(H.back), slot_in_backpack)
	else
		H.equip_to_slot_or_del(new custom_survival_gear(H), slot_r_hand)


/datum/species/proc/create_organs(var/mob/living/carbon/human/H, var/datum/preferences/prefs = null) //Handles creation of mob organs.

	for(var/obj/item/organ/organ in (H.organs|H.internal_organs))
		qdel(organ)

	if(H.organs.len) H.organs.Cut()
	if(H.internal_organs.len) H.internal_organs.Cut()
	if(H.organs_by_name.len) H.organs_by_name.Cut()
	if(H.internal_organs_by_name.len) H.internal_organs_by_name.Cut()

	var/organ_type = null

	for(var/limb_type in has_limbs)
		var/datum/organ_description/OD = has_limbs[limb_type]
		organ_type = OD.default_type
		new organ_type(H, OD)

	for(var/organ in has_organ)
		organ_type = has_organ[organ]
		new organ_type(H)

	if(flags & IS_SYNTHETIC)
		for(var/obj/item/organ/external/E in H.organs)
			if(E.status & ORGAN_CUT_AWAY || E.status & ORGAN_DESTROYED) continue
			E.robotize()
		for(var/obj/item/organ/internal/I in H.internal_organs)
			I.robotize()

/datum/species/proc/hug(var/mob/living/carbon/human/H,var/mob/living/target)

	var/t_him = "them"
	switch(target.gender)
		if(MALE)
			t_him = "him"
		if(FEMALE)
			t_him = "her"

	H.visible_message("<span class='notice'>[H] hugs [target] to make [t_him] feel better!</span>", \
					"<span class='notice'>You hug [target] to make [t_him] feel better!</span>")

/datum/species/proc/remove_inherent_verbs(var/mob/living/carbon/human/H)
	if(inherent_verbs)
		for(var/verb_path in inherent_verbs)
			H.verbs -= verb_path
	return

/datum/species/proc/add_inherent_verbs(var/mob/living/carbon/human/H)
	if(inherent_verbs)
		for(var/verb_path in inherent_verbs)
			H.verbs |= verb_path
	return

/datum/species/proc/handle_post_spawn(var/mob/living/carbon/human/H) //Handles anything not already covered by basic species assignment.
	add_inherent_verbs(H)
	H.mob_bump_flag = bump_flag
	H.mob_swap_flags = swap_flags
	H.mob_push_flags = push_flags

/datum/species/proc/handle_death(var/mob/living/carbon/human/H) //Handles any species-specific death events (such as dionaea nymph spawns).
	return

// Only used for alien plasma weeds atm, but could be used for Dionaea later.
/datum/species/proc/handle_environment_special(var/mob/living/carbon/human/H)
	return

// Used to update alien icons for aliens.
/datum/species/proc/handle_login_special(var/mob/living/carbon/human/H)
	return

// As above.
/datum/species/proc/handle_logout_special(var/mob/living/carbon/human/H)
	return

// Builds the HUD using species-specific icons and usable slots.
/datum/species/proc/build_hud(var/mob/living/carbon/human/H)
	return

//Used by xenos understanding larvae and dionaea understanding nymphs.
/datum/species/proc/can_understand(var/mob/other)
	return

// Called when using the shredding behavior.
/datum/species/proc/can_shred(var/mob/living/carbon/human/H, var/ignore_intent)

	if(!ignore_intent && H.a_intent != I_HURT)
		return 0

	for(var/datum/unarmed_attack/attack in unarmed_attacks)
		if(!attack.is_usable(H))
			continue
		if(attack.shredding)
			return 1

	return 0

/datum/species/proc/handle_accent(n)
	if(!accent.len && !accentFL.len)
		return n
	var/te = rhtml_decode(n)
	var/t = ""
	n = length(n)
	var/new_word = 1
	var/p = 1//1 is the start of any word
	while(p <= n)
		var/n_letter = copytext(te, p, p + 1)
		if (prob(80))
			if( n_letter in accent )
				n_letter = accent[n_letter]
			else if( new_word && n_letter in accentFL )
				n_letter = accentFL[n_letter]
		if (length(n_letter)>1 && prob(50)) n_letter = copytext(n_letter, 1,2)+"-"+copytext(n_letter,2)
		if (n_letter == " ") new_word = 1
		else				 new_word = 0
		t += n_letter
		p++
	return sanitize(copytext(t,1,MAX_MESSAGE_LEN))


// Called in life() when the mob has no client.
/datum/species/proc/handle_npc(var/mob/living/carbon/human/H)
	return

/datum/species/proc/Stat(var/mob/living/carbon/human/H)
	if (H.internal)
		if (!H.internal.air_contents)
			qdel(H.internal)
		else
			stat("Internal Atmosphere Info", H.internal.name)
			stat("Tank Pressure", H.internal.air_contents.return_pressure())
			stat("Distribution Pressure", H.internal.distribute_pressure)

	if(H.back && istype(H.back,/obj/item/weapon/rig))
		var/obj/item/weapon/rig/suit = H.back
		var/cell_status = "ERROR"
		if(suit.cell) cell_status = "[suit.cell.charge]/[suit.cell.maxcharge]"
		stat(null, "Suit charge: [cell_status]")
	return