/datum/species/vox
	name = "Vox"
	name_plural = "Vox"
	icobase = 'icons/mob/human_races/vox.dmi'
	deform = 'icons/mob/human_races/vox_def.dmi'
	default_language = "Vox-pidgin"
	language = "Galactic Common"
	unarmed_attacks = list(
		new /datum/unarmed_attack/stomp,
		new /datum/unarmed_attack/kick,
		new /datum/unarmed_attack/claws/strong,
		new /datum/unarmed_attack/bite/strong
		)
	rarity_value = 4
	gluttonous = 1

	blurb = "The Vox are the broken remnants of a once-proud race, now reduced to little more than \
	scavenging vermin who prey on isolated stations, ships or planets to keep their own ancient arkships \
	alive. They are four to five feet tall, reptillian, beaked, tailed and quilled; human crews often \
	refer to them as 'shitbirds' for their violent and offensive nature, as well as their horrible \
	smell.<br/><br/>Most humans will never meet a Vox raider, instead learning of this insular species through \
	dealing with their traders and merchants; those that do rarely enjoy the experience."

	taste_sensitivity = TASTE_DULL

	speech_sounds = list('sound/voice/shriek1.ogg')
	speech_chance = 20

	warning_low_pressure = 50
	hazard_low_pressure = 0

	cold_level_1 = 80
	cold_level_2 = 50
	cold_level_3 = 0

	breath_type = "nitrogen"
	poison_type = "oxygen"
	siemens_coefficient = 0.2

	flags = CAN_JOIN | IS_WHITELISTED | NO_SCAN | HAS_EYE_COLOR

	blood_color = "#2299FC"
	flesh_color = "#808D11"

	reagent_tag = IS_VOX

	inherent_verbs = list(
		/mob/living/carbon/human/proc/leap
	)

	has_organ = list(
		O_HEART =    /obj/item/organ/internal/heart,
		O_LUNGS =    /obj/item/organ/internal/lungs,
		O_LIVER =    /obj/item/organ/internal/liver,
		O_KIDNEYS =  /obj/item/organ/internal/kidneys,
		O_BRAIN =    /obj/item/organ/internal/brain,
		O_EYES =     /obj/item/organ/internal/eyes,
		"stack" =    /obj/item/organ/internal/stack/vox
	)

	body_builds = list(
		new/datum/body_build/vox
	)

	restricted_jobs = list(
		"Captain","Head of Personnel","Head of Security","Chief Engineer","Research Director",
		"Chief Medical Officer", "Warden", "Detective", "Security Officer", "Station Engineer",
		"Atmospheric Technician","Medical Doctor","Geneticist","Psychiatrist","Chemist","Paramedic",
		"Scientist", "Roboticist", "Xenobiologist", "Bartender", "Gardener", "Chef", "Librarian",
		"Quartermaster", "Lawyer", "Internal Affairs Agent", "Chaplain"
	)

/datum/species/vox/get_random_name(var/gender)
	var/datum/language/species_language = all_languages[default_language]
	return species_language.get_random_name(gender)

/datum/species/vox/equip_survival_gear(var/mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/vox_breath(H), slot_wear_mask)
	if(H.back)
		H.equip_to_slot_or_del(new /obj/item/weapon/tank/nitrogen(H), slot_r_hand)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/box/vox(H.back), slot_in_backpack)
		H.internal = H.r_hand
	else
		H.equip_to_slot_or_del(new /obj/item/weapon/tank/nitrogen(H), slot_back)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/box/vox(H), slot_r_hand)
		H.internal = H.back
	H.internals.icon_state = "internal1"

/datum/species/vox/get_station_variant()
	return "Vox Pariah"

// Joining as a station vox will give you this template, hence IS_RESTRICTED flag.
/datum/species/vox/pariah
	name = "Vox Pariah"
	rarity_value = 0.1
	speech_chance = 60        // No volume control.
	siemens_coefficient = 0.5 // Ragged scaleless patches.

	warning_low_pressure = (WARNING_LOW_PRESSURE-20)
	hazard_low_pressure =  (HAZARD_LOW_PRESSURE-10)
	total_health = 80

	taste_sensitivity = 3

	cold_level_1 = 130
	cold_level_2 = 100
	cold_level_3 = 60

	unarmed_attacks = list(
		new /datum/unarmed_attack/stomp,
		new /datum/unarmed_attack/kick,
		new /datum/unarmed_attack/claws,
		new /datum/unarmed_attack/bite
		)

	// Pariahs have no stack.
	has_organ = list(
		O_HEART =    /obj/item/organ/internal/heart,
		O_LUNGS =    /obj/item/organ/internal/lungs,
		O_LIVER =    /obj/item/organ/internal/liver,
		O_KIDNEYS =  /obj/item/organ/internal/kidneys,
		O_BRAIN =    /obj/item/organ/internal/pariah_brain,
		O_EYES =     /obj/item/organ/internal/eyes
		)
	flags = IS_RESTRICTED | NO_SCAN | HAS_EYE_COLOR

// Pariahs are really gross.
/datum/species/vox/pariah/handle_environment_special(var/mob/living/carbon/human/H)
	if(prob(5))
		var/stink_range = rand(3,5)
		for(var/mob/living/M in range(H,stink_range))
			if(M.stat || M == H)
				continue
			var/mob/living/carbon/human/target = M
			if(istype(target))
				if(target.head && (target.head.body_parts_covered & FACE) && (target.head.item_flags & AIRTIGHT))
					continue
				if(target.wear_mask && (target.wear_mask.body_parts_covered & FACE) && (target.wear_mask.item_flags & BLOCK_GAS_SMOKE_EFFECT))
					continue
			M << "<span class='danger'>A terrible stench emanates from \the [H].</span>"

/datum/species/vox/pariah/get_bodytype()
	return "Vox"
