/mob/observer/dead/say(var/message)
	message = sanitize(message)

	if (!message)
		return

	log_say("Ghost/[src.key] : [message]")

	if (src.client)
		if(src.client.prefs.muted & MUTE_DEADCHAT)
			src << "\red You cannot talk in deadchat (muted)."
			return

	. = src.say_dead(message)


/mob/observer/dead/custom_emote(var/type, var/message)
	//message = sanitize(message) - already sanitized in verb/me_verb()
	if(!src.client.holder)
		if(!config.dsay_allowed)
			src << "<span class='danger'>Deadchat is globally muted.</span>"
			return

	if(client)
		if(client.prefs.muted & MUTE_DEADCHAT)
			src << "\red You cannot emote in deadchat (muted)."
			return
		if(!(client.prefs.chat_toggles & CHAT_DEAD))
			src << "<span class='danger'>You have deadchat muted.</span>"
			return

	if(!message)
		message = sanitize(input(src, "Choose an emote to display.") as text|null)

	if(message)
		log_emote("Ghost/[src.key] : [message]")
		say_dead_direct(message, src)

	return


/mob/observer/dead/hear_say(var/message, var/verb = "says", var/datum/language/language = null, var/alt_name = "",
		var/italics = 0, var/mob/speaker = null, var/sound/speech_sound, var/sound_vol)
	if(!client) return

	if(speaker && !speaker.client && client.prefs.chat_toggles & CHAT_GHOSTEARS && !speaker in view(src))
		//Does the speaker have a client?  It's either random stuff that observers won't care about
		//Experiment 97B says, 'EHEHEHEHEHEHEHE' or someone snoring.  So we make it where they won't hear it.
		return
	..()
