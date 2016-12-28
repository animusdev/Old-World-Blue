/datum/species/arachna
	name = "Arachna"
	name_plural = "Arachnas"
	blurb = "Arachna history here"

	icobase = 'code/modules/mob/living/carbon/arachna/r_arachna.dmi'
	deform = 'code/modules/mob/living/carbon/arachna/r_def_arachna.dmi'

	damage_overlays = 'icons/mob/human_races/masks/dam_human.dmi'
	damage_mask = 'icons/mob/human_races/masks/dam_mask_human.dmi'
	blood_mask = 'icons/mob/human_races/masks/blood_human.dmi'

	prone_icon
	blood_color = "#A10808"
	flesh_color = "#FFC896"
	base_color

	ability_datum = /datum/species_abilities/arachna //For power needs
//	tail                                             // Name of tail state in species effects icon file.
//	tail_animation                                   // If set, the icon to obtain tail animation states from.

	race_key = 0       	                             // Used for mob icon cache string.
	icon/icon_template                               // Used for mob icon generation for non-32x32 species.
//	is_small
	show_ssd = "fast asleep"
	hunger_factor = 0.05                             // Multiplier for hunger.
	taste_sensitivity = TASTE_NORMAL

	min_age = 17
	max_age = 70

	default_language = "Galactic Common" // Default language is used when 'say' is used without modifiers.
	language = "Sol Common"
//	secondary_langs = list()             // The names of secondary languages that are available to this species.
//	list/speech_sounds                   // A list of sounds to potentially play when speaking.
//	list/speech_chance                   // The likelihood of a speech sound playing.


//	eyes = "arachna_eyes"
	total_health = 100 // Point at which the mob will enter crit.
	unarmed_attacks = list(
		new /datum/unarmed_attack/stomp,
		new /datum/unarmed_attack/kick,
		new /datum/unarmed_attack/punch,
		new /datum/unarmed_attack/bite
		)

	brute_mod =     1                    // Physical damage multiplier.
	burn_mod =      1                    // Burn damage multiplier.
	oxy_mod =       1                    // Oxyloss modifier
	toxins_mod =    1                    // Toxloss modifier
	radiation_mod = 1                    // Radiation modifier
	vision_flags = SEE_SELF              // Same flags as glasses.

	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/human
	remains_type = /obj/effect/decal/remains/xeno
	gibbed_anim = "gibbed-h"
	dusted_anim = "dust-h"
//	death_sound
	death_message = "seizes up and falls limp, their eyes dead and lifeless..."
	knockout_message = "has been knocked unconscious!"


	// Environment tolerance/life processes vars.
	reagent_tag                                   //Used for metabolizing reagents.
	breath_pressure = 16                          // Minimum partial pressure safe for breathing, kPa
	breath_type = "oxygen"                        // Non-oxygen gas breathed, if any.
	poison_type = "phoron"                        // Poisonous air.
	exhale_type = "carbon_dioxide"                // Exhaled gas type.
	cold_level_1 = 260                            // Cold damage level 1 below this point.
	cold_level_2 = 200                            // Cold damage level 2 below this point.
	cold_level_3 = 120                            // Cold damage level 3 below this point.
	heat_level_1 = 360                            // Heat damage level 1 above this point.
	heat_level_2 = 400                            // Heat damage level 2 above this point.
	heat_level_3 = 1000                           // Heat damage level 3 above this point.
	passive_temp_gain = 0		                  // Species will gain this much temperature every second
	hazard_high_pressure = HAZARD_HIGH_PRESSURE   // Dangerously high pressure.
	warning_high_pressure = WARNING_HIGH_PRESSURE // High pressure warning.
	warning_low_pressure = WARNING_LOW_PRESSURE   // Low pressure warning.
	hazard_low_pressure = HAZARD_LOW_PRESSURE     // Dangerously low pressure.
//	light_dam                                     // If set, mob will be damaged in light over this value and heal in light below its negative.
	body_temperature = 310.15	                  // Species will try to stabilize at this temperature.
	                                                  // (also affects temperature processing)

	heat_discomfort_level = 315                   // Aesthetic messages about feeling warm.
	cold_discomfort_level = 285                   // Aesthetic messages about feeling chilly.
	list/heat_discomfort_strings = list(
		"You feel sweat drip down your neck.",
		"You feel uncomfortably warm.",
		"Your skin prickles in the heat."
		)
	list/cold_discomfort_strings = list(
		"You feel chilly.",
		"You shiver suddenly.",
		"Your chilly flesh stands out in goosebumps."
		)




//	// HUD data vars.
//	var/datum/hud_data/hud = new

	// Body/form vars.
	inherent_verbs = list(
		/mob/living/carbon/human/arachna/verb/add_venom,
		/mob/living/carbon/human/arachna/verb/remove_venom,
		/mob/living/carbon/human/arachna/proc/prepare_bite,
		/mob/living/carbon/human/arachna/proc/use_silk_gland,
//		/datum/species_abilities/arachna/proc/EvolutionMenu
	)
	has_fine_manipulation = 1 // Can use small items.
	siemens_coefficient = 1   // The lower, the thicker the skin and better the insulation.
	darksight = 2             // Native darksight distance.
	flags = HAS_SKIN_TONE | HAS_EYE_COLOR | IS_RESTRICTED | IS_WHITELISTED
	slowdown = 0              // Passive movement speed malus (or boost, if negative)
	primitive_form = "Monkey"
//	greater_form              // Greater form, if any, ie. human for monkeys.
//	holder_type
	gluttonous  = 1              // Can eat some mobs. 1 for mice, 2 for monkeys, 3 for people.
	rarity_value = 1          // Relative rarity/collector value for this species.

/*
	has_organ = list(
		O_LUNGS =        /obj/item/organ/internal/lungs,
		O_HEART =        /obj/item/organ/internal/heart/arachna,
		O_KIDNEYS =      /obj/item/organ/internal/kidneys/arachna,
		O_EYES =         /obj/item/organ/internal/eyes,
		O_LIVER =        /obj/item/organ/internal/liver,
		O_APPENDIX =     /obj/item/organ/internal/appendix,
		"poison_gland" = /obj/item/organ/internal/arachna/poison_gland,
		"silk_gland" =   /obj/item/organ/internal/arachna/silk_gland,
		O_BRAIN =        /obj/item/organ/internal/brain
		)*/

	has_organ = list(    // which required-organ checks are conducted.
		O_HEART =    /obj/item/organ/internal/heart,
		O_LUNGS =    /obj/item/organ/internal/lungs,
		O_LIVER =    /obj/item/organ/internal/liver,
		O_KIDNEYS =  /obj/item/organ/internal/kidneys,
		O_BRAIN =    /obj/item/organ/internal/brain,
		O_APPENDIX = /obj/item/organ/internal/appendix,
		O_EYES =     /obj/item/organ/internal/eyes,
		"poison_gland" = /obj/item/organ/internal/arachna/poison_gland,
		"silk_gland" =   /obj/item/organ/internal/arachna/silk_gland,
		)

//	vision_organ              // If set, this organ is required for vision. Defaults to "eyes" if the species has them.


	has_limbs = list(
		BP_CHEST =  new /datum/organ_description,
		BP_GROIN =  new /datum/organ_description/groin/arachna,
		BP_HEAD   = new /datum/organ_description/head,
		BP_L_ARM  = new /datum/organ_description/arm/left,
		BP_R_ARM  = new /datum/organ_description/arm/right,
		BP_L_LEG  = new /datum/organ_description/leg/left,
		BP_R_LEG  = new /datum/organ_description/leg/right,
		BP_L_HAND = new /datum/organ_description/hand/left,
		BP_R_HAND = new /datum/organ_description/hand/right,
		BP_L_FOOT = new /datum/organ_description/foot/left,
		BP_R_FOOT = new /datum/organ_description/foot/right
	)

	/*has_limbs = list(
		BP_CHEST =    list("path" = /obj/item/organ/external/chest),
		"abdomen" =  list("path" = /obj/item/organ/external/groin/arachna),
		BP_HEAD =     list("path" = /obj/item/organ/external/head),
		BP_L_ARM =    list("path" = /obj/item/organ/external/arm),
		BP_R_ARM =    list("path" = /obj/item/organ/external/arm/right),
		BP_L_HAND =   list("path" = /obj/item/organ/external/hand),
		BP_R_HAND =   list("path" = /obj/item/organ/external/hand/right),
		"l_f_leg" =  list("path" = /obj/item/organ/external/leg/arachna/left/f_leg),
		"l_f_foot" = list("path" = /obj/item/organ/external/foot/arachna/left/f_foot),
		"l_mf_leg" =  list("path" = /obj/item/organ/external/leg/arachna/left/mf_leg),
		"l_mf_foot" = list("path" = /obj/item/organ/external/foot/arachna/left/mf_foot),
		"l_mb_leg" =  list("path" = /obj/item/organ/external/leg/arachna/left/mb_leg),
		"l_mb_foot" = list("path" = /obj/item/organ/external/foot/arachna/left/mb_foot),
		"l_b_leg" =  list("path" = /obj/item/organ/external/leg/arachna/left/b_leg),
		"l_b_foot" = list("path" = /obj/item/organ/external/foot/arachna/left/b_foot),
		"r_f_leg" =  list("path" = /obj/item/organ/external/leg/arachna/right/f_leg),
		"r_f_foot" = list("path" = /obj/item/organ/external/foot/arachna/right/f_foot),
		"r_mf_leg" =  list("path" = /obj/item/organ/external/leg/arachna/right/mf_leg),
		"r_mf_foot" = list("path" = /obj/item/organ/external/foot/arachna/right/mf_foot),
		"r_mb_leg" =  list("path" = /obj/item/organ/external/leg/arachna/right/mb_leg),
		"r_mb_foot" = list("path" = /obj/item/organ/external/foot/arachna/right/mb_foot),
		"r_b_leg" =  list("path" = /obj/item/organ/external/leg/arachna/right/b_leg),
		"r_b_foot" = list("path" = /obj/item/organ/external/foot/arachna/right/b_foot)
	)*/

/*
	body_builds = list(
		new/datum/body_build
	)*/

	// Bump vars
	bump_flag = HUMAN	// What are we considered to be when bumped?
	push_flags = ~HEAVY	// What can we push?
	swap_flags = ~HEAVY	// What can we swap place with?

	// Misc
//	restricted_jobs = list()
//	accent = list()
//	accentFL = list()
//	allow_slim_fem = 0

	//Species Abilities
//	evolution_points = 0 //How many points race have for abilities






/datum/species/arachna/handle_post_spawn(var/mob/living/carbon/human/H)
	H.gender = FEMALE
	return ..()




datum/species/arachna/Stat(var/mob/living/carbon/human/H)
	..()
	var/obj/item/organ/internal/arachna/P = H.internal_organs_by_name["poison_gland"]
	if(P)
		stat("Poison Stored:", " [P.reagents.total_volume]/[P.reagents.maximum_volume]")
	P = H.internal_organs_by_name["silk_gland"]
	if(P)
		stat("Silk Stored:", " [P:silk]/[P:silk_max]")
	return
