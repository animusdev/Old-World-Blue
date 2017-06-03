var/datum/antagonist/wizard/wizards

/datum/antagonist/wizard
	id = ROLE_WIZARD
	role_text = "Space Wizard"
	role_text_plural = "Space Wizards"
	bantype = "wizard"
	landmark_id = "wizard"
	welcome_text = "You will find a list of available spells in your spell book. Choose your magic arsenal carefully.<br>In your pockets you will find a teleport scroll. Use it as needed."
	flags = ANTAG_OVERRIDE_JOB | ANTAG_CLEAR_EQUIPMENT | ANTAG_CHOOSE_NAME | ANTAG_VOTABLE | ANTAG_SET_APPEARANCE
	antaghud_indicator = "hudwizard"

	hard_cap = 1
	hard_cap_round = 3
	initial_spawn_req = 1
	initial_spawn_target = 1


/datum/antagonist/wizard/New()
	..()
	wizards = src

/datum/antagonist/wizard/create_objectives(var/datum/mind/wizard)

	if(!..())
		return

	var/kill
	var/escape
	var/steal
	var/hijack

	switch(rand(1,100))
		if(1 to 30)
			escape = 1
			kill = 1
		if(31 to 60)
			escape = 1
			steal = 1
		if(61 to 99)
			kill = 1
			steal = 1
		else
			hijack = 1

	if(kill)
		var/datum/objective/assassinate/kill_objective = new
		kill_objective.owner = wizard
		kill_objective.find_target()
		wizard.objectives |= kill_objective
	if(steal)
		var/datum/objective/steal/steal_objective = new
		steal_objective.owner = wizard
		steal_objective.find_target()
		wizard.objectives |= steal_objective
	if(escape)
		var/datum/objective/survive/survive_objective = new
		survive_objective.owner = wizard
		wizard.objectives |= survive_objective
	if(hijack)
		var/datum/objective/hijack/hijack_objective = new
		hijack_objective.owner = wizard
		wizard.objectives |= hijack_objective
	return

/datum/antagonist/wizard/update_antag_mob(var/datum/mind/wizard)
	..()
	wizard.store_memory("<B>Remember:</B> do not forget to prepare your spells.")
	wizard.current.real_name = "[pick(wizard_first)] [pick(wizard_second)]"
	wizard.current.name = wizard.current.real_name

/datum/antagonist/wizard/equip(var/mob/living/carbon/human/wizard_mob)

	if(!..())
		return 0

	wizard_mob.equip_to_slot_or_del(new /obj/item/device/radio/headset(wizard_mob), slot_l_ear)
	wizard_mob.equip_to_slot_or_del(new /obj/item/clothing/under/color/lightpurple(wizard_mob), slot_w_uniform)
	wizard_mob.equip_to_slot_or_del(new /obj/item/clothing/shoes/sandal(wizard_mob), slot_shoes)
	wizard_mob.equip_to_slot_or_del(new /obj/item/clothing/suit/wizrobe(wizard_mob), slot_wear_suit)
	wizard_mob.equip_to_slot_or_del(new /obj/item/clothing/head/wizard(wizard_mob), slot_head)
	switch(wizard_mob.backbag)
		if(2) wizard_mob.equip_to_slot_or_del(new /obj/item/storage/backpack(wizard_mob), slot_back)
		if(3) wizard_mob.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/norm(wizard_mob), slot_back)
		if(4) wizard_mob.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(wizard_mob), slot_back)
		if(5) wizard_mob.equip_to_slot_or_del(new /obj/item/storage/backpack/dufflebag(wizard_mob), slot_back)
		if(6) wizard_mob.equip_to_slot_or_del(new /obj/item/storage/backpack/messenger(wizard_mob), slot_back)
	wizard_mob.equip_to_slot_or_del(new /obj/item/storage/box(wizard_mob), slot_in_backpack)
	wizard_mob.equip_to_slot_or_del(new /obj/item/weapon/teleportation_scroll(wizard_mob), slot_r_store)
	wizard_mob.equip_to_slot_or_del(new /obj/item/weapon/spellbook(wizard_mob), slot_r_hand)
	wizard_mob.equip_survival_gear()
	wizard_mob.update_icons()
	return 1

/datum/antagonist/wizard/check_victory()
	var/survivor
	for(var/datum/mind/player in current_antagonists)
		if(!player.current || player.current.stat)
			continue
		survivor = 1
		break
	if(!survivor)
		world << "<span class='danger'><font size = 3>The [(current_antagonists.len>1)?"[role_text_plural] have":"[role_text] has"] been killed by the crew! The Space Wizards Federation has been taught a lesson they will not soon forget!</font></span>"

//To batch-remove wizard spells. Linked to mind.dm.
/mob/proc/spellremove()
	for(var/spell/spell_to_remove in src.spell_list)
		remove_spell(spell_to_remove)

obj/item/clothing
	var/wizard_garb = 0

// Does this clothing slot count as wizard garb? (Combines a few checks)
/proc/is_wiz_garb(var/obj/item/clothing/C)
	return C && C.wizard_garb

/*Checks if the wizard is wearing the proper attire.
Made a proc so this is not repeated 14 (or more) times.*/
/mob/proc/is_like_wizard(var/knowledge = FALSE, var/clothing = FALSE)
	src << "Silly creature, you're not a human. Only humans can cast this spell."
	return 0

// Humans can wear clothes.
/mob/living/carbon/human/is_like_wizard(knowledge = FALSE, clothing = TRUE)
	if(clothing)
		if(!is_wiz_garb(src.wear_suit))
			src << SPAN_WARN("I don't feel strong enough without my robe.")
			return FALSE
		if(!is_wiz_garb(src.shoes))
			src << SPAN_WARN("I don't feel strong enough without my sandals.")
			return FALSE
		if(!is_wiz_garb(src.head))
			src << SPAN_WARN("I don't feel strong enough without my hat.")
			return FALSE
	if(knowledge)
		if(wizards && wizards.is_antagonist(mind))
			return TRUE
	return 1

/datum/antagonist/wizard/remove_antagonist(var/datum/mind/player, var/mob/M)
	switch(input("What to remove?") in list ("Spells", "Mob", "Role (without spells)"))
		if("Spells")
			player.current.spellremove()
		if("Mob")
			M = player.current
			..()
			qdel(M)
		if ("Role")
			..()