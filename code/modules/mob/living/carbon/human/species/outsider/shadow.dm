/datum/species/shadow
	name = "Shadow"
	name_plural = "shadows"

	icobase = 'icons/mob/human_races/shadow.dmi'
	deform = 'icons/mob/human_races/shadow.dmi'

	language = "Sol Common" //todo?
	unarmed_attacks = list(
		new /datum/unarmed_attack/claws/strong,
		new /datum/unarmed_attack/bite/sharp
		)
	darksight = 8
	has_organ = list()
	siemens_coefficient = 0

	blood_color = "#CCCCCC"
	flesh_color = "#AAAAAA"

	remains_type = /obj/effect/decal/cleanable/ash
	death_message = "dissolves into ash..."

	flags = IS_RESTRICTED | NO_BLOOD | NO_SCAN | NO_SLIP | NO_POISON

/datum/species/shadow/handle_environment_special(var/mob/living/carbon/human/H)
	var/light_amount = 0
	if(isturf(H.loc))
		var/turf/T = H.loc
		var/atom/movable/lighting_overlay/L = locate(/atom/movable/lighting_overlay) in T
		if(L)
			light_amount = L.lum_r + L.lum_g + L.lum_b //hardcapped so it's not abused by having a ton of flashlights
		else
			light_amount =  10
	if(light_amount > 2) //if there's enough light, start dying
		H.take_overall_damage(1,1)
	else //heal in the dark
		H.heal_overall_damage(1,1)


/datum/species/shadow/handle_death(var/mob/living/carbon/human/H)
	spawn(1)
		new /obj/effect/decal/cleanable/ash(H.loc)
		qdel(H)