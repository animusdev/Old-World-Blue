// All mobs should have custom emote, really..
//m_type == 1 --> visual.
//m_type == 2 --> audible
/mob/proc/custom_emote(var/m_type=MESSAGE_VISIBLE, var/message = null)
	return


/mob/proc/emote(var/act, var/type, var/message)
	switch(act)
		if ("custom")
			if(!message)
				message = sanitize(input("Choose an emote to display.") as text|null)
				if (!message)
					return
			var/input2 = input("Is this a visible or hearable emote?") in list("Visible","Hearable")
			if (input2 == "Visible")
				type = MESSAGE_VISIBLE
			else if (input2 == "Hearable")
				type = MESSAGE_HEARABLE
			else
				alert("Unable to use this emote, must be either hearable or visible.")
				return
			return custom_emote(type, message)

		if ("me")
			if(!message)
				return
			return custom_emote(type, message)

		if ("help")
			var/list/emotes = get_possible_emotes()
			if(emotes.len)
				usr << "<span class='notice'>Possible emotes: [jointext(emotes, ", ")]</span>"
			else
				usr << "<span class='notice'>You can't use emotes</span>"
		else
			var/list/emotes = get_possible_emotes()
			if(act in emotes)
				var/datum/emote/E = emotes[act]
				E.act(src)
			else
				if(findtext(act, "s", -1))
					act = copytext(act, 1, -1)
				if(act in emotes)
					var/datum/emote/E = emotes[act]
					E.act(src)
				else src << "<span class='notice'>Unusable emote '[act]'. Say *help for a list.</span>"
				return


/mob/proc/get_possible_emotes()
	return list()