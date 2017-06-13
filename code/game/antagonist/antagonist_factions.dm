/mob/living/proc/convert_to_rev(mob/M as mob in oview(src))
	set name = "Convert Bourgeoise"
	set category = "Abilities"
	if(!M.mind)
		return
	convert_to_faction(M.mind, revs)

/mob/living/proc/convert_to_faction(var/datum/mind/player, var/datum/antagonist/faction)

	if(!player || !faction || !player.current)
		return

	if(!faction.faction_verb || !faction.faction_descriptor || !faction.faction_verb)
		return

	if(world.time < player.rev_cooldown)
		src << "<span class='danger'>You must wait five seconds between attempts.</span>"
		return
		
	if(faction.is_antagonist(player))
		src << "<span class='warning'>\The [player.current] already serves the [faction.faction_descriptor].</span>"
		return

	log_mode("[key_name(src)] attempted to convert [key_name(player.current)].", player.current)
	src << "<span class='danger'>You are attempting to convert \the [player.current]...</span>"
	player.rev_cooldown = world.time+100
	
	// Prevents meta-using of 'convert' verb in order to indicate antags.
	if(player_is_antag(player) || !faction.can_become_antag(player))
		player << "<span class='danger'>The [src] is trying to force you to join the [faction.faction_descriptor]! With no chance of success, actually.</span>"
		var/choice = alert(player.current,"Asked by [src]: Do you want to join the [faction.faction_descriptor]?","Join the [faction.faction_descriptor]?","No!","Yes!(no)")
		if(choice == "No!" || choice == "Yes!(no)")
			player << "<span class='danger'>You had literally no choice!</span>"
		src << "<span class='danger'>\The [player.current] does not support the [faction.faction_descriptor]!</span>"
		return
	
	var/choice = alert(player.current,"Asked by [src]: Do you want to join the [faction.faction_descriptor]?","Join the [faction.faction_descriptor]?","No!","Yes!")
	if(choice == "Yes!" && faction.add_antagonist_mind(player, 0, faction.faction_role_text, faction.faction_welcome))
		src << "<span class='notice'>\The [player.current] joins the [faction.faction_descriptor]!</span>"
		return
	if(choice == "No!")
		player << "<span class='danger'>You reject this traitorous cause!</span>"
	src << "<span class='danger'>\The [player.current] does not support the [faction.faction_descriptor]!</span>"

/mob/living/proc/convert_to_loyalist(mob/M as mob in oview(src))
	set name = "Convert Recidivist"
	set category = "Abilities"
	if(!M.mind)
		return
	convert_to_faction(M.mind, loyalists)
