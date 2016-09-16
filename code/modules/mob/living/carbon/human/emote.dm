/mob/living/carbon/human/emote(var/act,var/m_type=1,var/message = null)

	for (var/obj/item/weapon/implant/I in src)
		if (I.implanted)
			I.trigger(act, src)

	if(src.stat == 2.0 && (act != "deathgasp"))
		return

	switch(act)
		if ("custom")
			var/input = sanitize(input("Choose an emote to display.") as text|null)
			if (!input)
				return
			var/input2 = input("Is this a visible or hearable emote?") in list("Visible","Hearable")
			if (input2 == "Visible")
				m_type = 1
			else if (input2 == "Hearable")
				if (src.miming)
					return
				m_type = 2
			else
				alert("Unable to use this emote, must be either hearable or visible.")
				return
			return custom_emote(m_type, input)

		if ("me")
			//if(silent && silent > 0 && findtext(message,"\"",1, null) > 0)
			//	return //This check does not work and I have no idea why, I'm leaving it in for reference.
			if (src.client)
				if (client.prefs.muted & MUTE_IC)
					src << "\red You cannot send IC messages (muted)."
					return
				if (src.client.handle_spam_prevention(message,MUTE_IC))
					return
			if (stat)
				return
			if(!(message))
				return
			return custom_emote(m_type, message)

		if("swish")
			src.animate_tail_once()

		if("wag", "sway")
			src.animate_tail_start()

		if("qwag", "fastsway")
			src.animate_tail_fast()

		if("swag", "stopsway")
			src.animate_tail_stop()

		if ("help")
			var/all_emotes = ""
			src << emotes_list.len
			for(var/emote in emotes_list)
				all_emotes += ", [emote]"
			src << "\blue Possible emotes: [copytext(all_emotes, 3)]"
		else
			if(act in emotes_list)
				var/datum/emote/E = emotes_list[act]
				E.act(src)
			else src << "\blue Unusable emote '[act]'. Say *help for a list."

	if (message)
		log_emote("[name]/[key] : [message]")

 //Hearing gasp and such every five seconds is not good emotes were not global for a reason.
 // Maybe some people are okay with that.

		for(var/mob/M in dead_mob_list)
			if(!M.client || istype(M, /mob/new_player))
				continue //skip monkeys, leavers and new players
			if(M.stat == DEAD && (M.client.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(M in viewers(src,null)))
				M.show_message(message)

		if (m_type & 1)
			for (var/mob/O in get_mobs_in_view(world.view,src))
				O.show_message(message, m_type)
		else if (m_type & 2)
			for (var/mob/O in (hearers(src.loc, null) | get_mobs_in_view(world.view,src)))
				O.show_message(message, m_type)


/mob/living/carbon/human/verb/pose()
	set name = "Set Pose"
	set desc = "Sets a description which will be shown when someone examines you."
	set category = "IC"

	pose =  sanitize(input(usr, "This is [src]. \He is...", "Pose", null)  as text)

/mob/living/carbon/human/verb/set_flavor()
	set name = "Set Flavour Text"
	set desc = "Sets an extended description of your character's features."
	set category = "IC"

	var/HTML = "<body>"
	HTML += "<tt><center>"
	HTML += "<b>Update Flavour Text</b> <hr />"
	HTML += "<br></center>"
	for( var/flavor in flavs_list )
		HTML += "<a href='byond://?src=\ref[src];flavor_change=[flavor]'>[flavs_list[flavor]]</a>: [TextPreview(flavor_texts[flavor])]<br>"
	HTML += "<br>"
	HTML += "<hr />"
	HTML +="<a href='?src=\ref[src];flavor_change=done'>\[Done\]</a>"
	HTML += "<tt>"
	src << browse(HTML, "window=flavor_changes;size=430x300")
