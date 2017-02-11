//Procedures in this file: Fracture repair surgery
//////////////////////////////////////////////////////////////////
//						CHITIN SURGERY							//
//////////////////////////////////////////////////////////////////
//при поломке хитина делается следующее: вытаскиваются осколки, собирается воедино, склеиваем гелем.

/datum/surgery_step/arachna
	allowed_species = list("Arachna")

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
