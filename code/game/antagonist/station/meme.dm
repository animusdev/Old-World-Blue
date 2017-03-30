/datum/antagonist/meme
	id = MODE_MEME
	role_type = BE_MEME
	role_text = "Meme"
	role_text_plural = "Meme"
	bantype = "meme"
	welcome_text = "You'r meme now. Enjoy!"
	flags = ANTAG_RANDSPAWN | ANTAG_VOTABLE | ANTAG_OVERRIDE_MOB | ANTAG_OVERRIDE_JOB
	antaghud_indicator = "hudmeme"

/datum/antagonist/meme/get_special_objective_text(var/datum/mind/player)
	return "<br><b>Human indoctrinated:</b> [player.current:indoctrinated.len]"

/datum/antagonist/meme/get_extra_panel_options(var/datum/mind/player)
	return "<a href='?src=\ref[src];move=\ref[player.current]'>\[Move to selected human\].</a>"

/datum/antagonist/meme/Topic(href, href_list)
	if (..())
		return
	if(href_list["move"])
		var/list/allowed_mob = list()
		var/mob/living/parasite/meme/player = locate(href_list["move"])
		if(!istype(player))
			usr << "\red [player] isn't meme!"
			return

		for (var/mob/living/carbon/human/H in mob_list)
			if(/*H.client && */istype(H) && !H.parasites.len)
				allowed_mob += H

		if(allowed_mob.len == 0)
			usr << "\red There is no hosts available now!"
		else
			var/new_host = input("Select new host for meme ([player]).", "New host", null) as null|anything in allowed_mob
			if (new_host)
				player.switch_host(new_host)
				log_admin("[key_name(usr)] moved [key_name(player)] (meme) into [key_name(player.host)]", player.host)

/datum/antagonist/meme/create_objectives(var/datum/mind/meme)
	if(!..())
		return

	var/datum/objective/meme_attune/attune = new
	attune.gen_amount_goal()
	attune.owner = meme
	meme.objectives += attune

	for(var/i=rand(2,3);i;i--)
		switch(rand(1,100))
			if(1 to 49)
				var/datum/objective/assassinate/kill_objective = new
				kill_objective.owner = meme
				kill_objective.find_target()
				meme.objectives += kill_objective
			else
				var/datum/objective/steal/steal_objective = new
				steal_objective.owner = meme
				steal_objective.find_target()
				meme.objectives += steal_objective

	switch(rand(1,100))
		if(1 to 80)
			if (!(locate(/datum/objective/escape) in meme.objectives))
				var/datum/objective/escape/escape_objective = new
				escape_objective.owner = meme
				meme.objectives += escape_objective
		else
			if (!(locate(/datum/objective/survive) in meme.objectives))
				var/datum/objective/survive/survive_objective = new
				survive_objective.owner = meme
				meme.objectives += survive_objective
	return

/datum/antagonist/meme/update_antag_mob(var/datum/mind/player)
	..()

	if(!istype(player.current, /mob/living/parasite/meme))
		var/list/allowed_mob = list()
		for (var/mob/living/carbon/human/H in mob_list-player.current)
			if(H.client)
				allowed_mob += H
		if(!allowed_mob.len)
			message_admins("Not enougth humans for spawn meme")
			return 0
		else
			var/mob/living/parasite/meme/M = new(pick(allowed_mob))
			log_admin("[key_name_admin(usr)] transform [key_name(player.current)] into meme.")
			player.transfer_to(M)


//OBJECTIVES

datum/objective/meme_attune
	proc/gen_amount_goal(var/lowbound = 4, var/highbound = 6)
		target_amount = rand (lowbound,highbound)

		explanation_text = "Attune [target_amount] humanoid brains."
		return target_amount

	check_completion()
		if(owner && owner.current && istype(owner.current,/mob/living/parasite/meme) && (owner.current:indoctrinated.len >= target_amount))
			return 1
		else
			return 0