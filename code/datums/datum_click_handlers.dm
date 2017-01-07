/datum/click_handler
//	var/mob_type
	var/species
	var/mouse_icon
	var/handler_name

/datum/click_handler/proc/mob_check(mob/living/carbon/human/user) //Check can mob use a ability
	return

/datum/click_handler/proc/use_ability(mob/living/carbon/human/user,atom/target) //Check can mob use a ability
	return

/datum/click_handler/human/mob_check(mob/living/carbon/human/user)
	if(ishuman(user))
		if(user.species.name == src.species)
			return 1
	return 0

/datum/click_handler/human/use_ability(mob/living/carbon/human/user,atom/target)
	return

/datum/click_handler/human/arachna_leap
//	mob_type = /mob/living/carbon/human
	species = "Arachna"
	handler_name = "Poison Bite"

/datum/click_handler/human/arachna_leap/use_ability(mob/living/carbon/human/user,atom/target)
	user.try_bite(target)
