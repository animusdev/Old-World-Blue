/mob/dead/observer/say(var/message)
	message = sanitize(message)

	if (!message)
		return

	log_say("Ghost/[src.key] : [message]")

	if (src.client)
		if(src.client.prefs.muted & MUTE_DEADCHAT)
			src << "\red You cannot talk in deadchat (muted)."
			return

		if (src.client.handle_spam_prevention(message,MUTE_DEADCHAT))
			return

	. = src.say_dead(message)


/mob/dead/observer/emote(var/act, var/type, var/message)
	//message = sanitize(message) - already sanitized in verb/me_verb()

	if(!message)
		return

	if(act != "me")
		return

	log_emote("Ghost/[src.key] : [message]")

	if(src.client)
		if(src.client.prefs.muted & MUTE_DEADCHAT)
			src << "\red You cannot emote in deadchat (muted)."
			return

		if(src.client.handle_spam_prevention(message, MUTE_DEADCHAT))
			return

	. = src.emote_dead(message)


/mob/dead/observer/hear_say(var/message, var/verb = "says", var/datum/language/language = null, var/alt_name = "",var/italics = 0, var/mob/speaker = null, var/sound/speech_sound, var/sound_vol)
	if(!client) return

	if(speaker && !speaker.client && client.prefs.chat_toggles & CHAT_GHOSTEARS && !speaker in view(src))
		//Does the speaker have a client?  It's either random stuff that observers won't care about (Experiment 97B says, 'EHEHEHEHEHEHEHE')
		//Or someone snoring.  So we make it where they won't hear it.
		return
	..()
