/mob/living/silicon/robot/get_possible_emotes()
	var/list/tmp_emotes = robot_emotes_list.Copy()
	if(module)
		for(var/emote in module.emotes)
			tmp_emotes[emote] = module.emotes[emote]
	return tmp_emotes

/datum/emote/special/law
	key = "law"
	message = "shows its legal authorization barcode."
	r_message =  "демонстрирует значок охраны."
	m_type = MESSAGE_VISIBLE
	autolist = null
	act(var/mob/living/H)
		if(..())
			playsound(H.loc, 'sound/voice/biamthelaw.ogg', 50, 0)

/datum/emote/special/halt
	key = "halt"
	message = "speakers sсreech, \"Halt! Security!\"."
	r_message =  "хрипло кричит \"Halt! Security!\""
	m_type = MESSAGE_VISIBLE
	autolist = null
	act(var/mob/living/H)
		if(..())
			playsound(H.loc, 'sound/voice/halt.ogg', 50, 0)
