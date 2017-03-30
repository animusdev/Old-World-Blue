//print an error message to world.log


// On Linux/Unix systems the line endings are LF, on windows it's CRLF,
// admins that don't use notepad++ will get logs that are one big line if the system is Linux
// and they are using notepad.  This solves it by adding CR to every line ending in the logs.
// ascii character 13 = CR

/var/global/log_end= world.system_type == UNIX ? ascii2text(13) : ""


/proc/error(msg)
	world.log << "## ERROR: [msg][log_end]"

#define WARNING(MSG) warning("[MSG] in [__FILE__] at line [__LINE__] src: [src] usr: [usr].")
//print a warning message to world.log
/proc/warning(msg)
	world.log << "## WARNING: [msg][log_end]"

//print a testing-mode debug message to world.log
/proc/testing(msg)
	world.log << "## TESTING: [msg][log_end]"

/proc/log_generic(var/type, var/message, var/location, var/log_to_diary = 1, var/notify_admin = 1, var/req_toggles = 0)
	var/turf/T = get_turf(location)
	if(location && T)
		if(log_to_diary)
			diary << "\[[time_stamp()]][type]: [message] ([T.x],[T.y],[T.z])[log_end]"
		if(notify_admin)
			message += " (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[T.x];Y=[T.y];Z=[T.z]'>JMP</a>)"
	else if(log_to_diary)
		diary << "\[[time_stamp()]][type]: [message][log_end]"

	var/rendered = "<span class=\"log_message\"><span class=\"prefix\">[type]:</span> <span class=\"message\">[message]</span></span>"
	if(notify_admin)
		for(var/client/C in admins)
			if(!req_toggles || (C.prefs.chat_toggles & req_toggles))
				C << rendered



/proc/log_admin(text, location, notify_admin)
	log_generic("ADMIN", text, location, config.log_admin, notify_admin)

/proc/log_debug(text, location)
	log_generic("DEBUG", text, location, config.log_debug, 1, CHAT_DEBUGLOGS)

/proc/log_game(text, location, notify_admin = 1)
	log_generic("GAME", text, location, config.log_game, notify_admin)

/proc/log_mode(text, location, notify_admin)
	log_generic("GAMEMODE", text, location, config.log_game, notify_admin, CHAT_GAMEMODELOGS)

/proc/log_vote(text)
	log_generic("VOTE", text, null, config.log_vote, 0)

/proc/log_access(text, notify_admin = 0)
	log_generic("ACCESS", text, null, config.log_vote, notify_admin)

/proc/log_say(text)
	log_generic("SAY", text, null, config.log_say, 0)

/proc/log_ooc(text)
	log_generic("OOC", text, null, config.log_ooc, 0)

/proc/log_whisper(text)
	log_generic("WHISPER", text, null, config.log_whisper, 0)

/proc/log_emote(text)
	log_generic("EMOTE", text, null, config.log_emote, 0)

/proc/log_attack(text, location, notify_admin)
	log_generic("ATTACK", text, location, config.log_attack, notify_admin, CHAT_ATTACKLOGS)

/proc/log_adminsay(text)
	log_generic("ADMINSAY", text, null, config.log_adminchat, 0)

/proc/log_adminwarn(text, location, notify_admin = 0)
	log_generic("ADMINWARN", text, location, config.log_adminwarn, notify_admin)

/proc/log_pda(text)
	log_generic("PDA", text, null, config.log_pda, 0)

/proc/log_misc(text) //Replace with log_game ?
	log_generic("MISC", text, null, 1, 0)

//pretty print a direction bitflag, can be useful for debugging.
/proc/print_dir(var/dir)
	var/list/comps = list()
	if(dir & NORTH) comps += "NORTH"
	if(dir & SOUTH) comps += "SOUTH"
	if(dir & EAST)  comps += "EAST"
	if(dir & WEST)  comps += "WEST"
	if(dir & UP)    comps += "UP"
	if(dir & DOWN)  comps += "DOWN"

	return english_list(comps, nothing_text="0", and_text="|", comma_text="|")

//more or less a logging utility
/proc/key_name(var/whom, var/include_link = null, var/include_name = 1, var/highlight_special_characters = 1)
	var/mob/M
	var/client/C
	var/key

	if(!whom)	return "*null*"
	if(istype(whom, /client))
		C = whom
		M = C.mob
		key = C.key
	else if(ismob(whom))
		M = whom
		C = M.client
		key = M.key
	else if(istype(whom, /datum/mind))
		var/datum/mind/D = whom
		key = D.key
		M = D.current
		if(D.current)
			C = D.current.client
	else if(istype(whom, /datum))
		var/datum/D = whom
		return "*invalid:[D.type]*"
	else
		return "*invalid*"

	. = ""

	if(key)
		if(include_link && C)
			. += "<a href='?priv_msg=\ref[C]'>"

		if(C && C.holder && C.holder.fakekey && !include_name)
			. += "Administrator"
		else
			. += key

		if(include_link)
			if(C)	. += "</a>"
			else	. += " (DC)"
	else
		. += "*no key*"

	if(include_name && M)
		var/name

		if(M.real_name)
			name = M.real_name
		else if(M.name)
			name = M.name

		if(include_link && is_special_character(M) && highlight_special_characters)
			. += "/(<font color='#FFA500'>[name]</font>)" //Orange
		else
			. += "/([name])"

	return .

/proc/key_name_admin(var/whom, var/include_name = 1)
	return key_name(whom, 1, include_name)
