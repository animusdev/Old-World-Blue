//toggles
/client/verb/toggle_ghost_ears()
	set name = "Show/Hide GhostEars"
	set category = "Preferences"
	set desc = ".Toggle Between seeing all mob speech, and only speech of nearby mobs"
	prefs.chat_toggles ^= CHAT_GHOSTEARS
	src << "As a ghost, you will now [(prefs.chat_toggles & CHAT_GHOSTEARS) ? "see all speech in the world" : "only see speech from nearby mobs"]."
	prefs.save_preferences()

/client/verb/toggle_ghost_sight()
	set name = "Show/Hide GhostSight"
	set category = "Preferences"
	set desc = ".Toggle Between seeing all mob emotes, and only emotes of nearby mobs"
	prefs.chat_toggles ^= CHAT_GHOSTSIGHT
	src << "As a ghost, you will now [(prefs.chat_toggles & CHAT_GHOSTSIGHT) ? "see all emotes in the world" : "only see emotes from nearby mobs"]."
	prefs.save_preferences()

/client/verb/toggle_ghost_radio()
	set name = "Enable/Disable GhostRadio"
	set category = "Preferences"
	set desc = ".Toggle between hearing all radio chatter, or only from nearby speakers"
	prefs.chat_toggles ^= CHAT_GHOSTRADIO
	src << "As a ghost, you will now [(prefs.chat_toggles & CHAT_GHOSTRADIO) ? "hear all radio chat in the world" : "only hear from nearby speakers"]."
	prefs.save_preferences()

/client/proc/toggle_hear_radio()
	set name = "Show/Hide RadioChatter"
	set category = "Preferences"
	set desc = "Toggle seeing radiochatter from radios and speakers"
	if(!holder && !(prefs.chat_toggles & CHAT_RADIO)) return
	prefs.chat_toggles ^= CHAT_RADIO
	prefs.save_preferences()
	usr << "You will [(prefs.chat_toggles & CHAT_RADIO) ? "now" : "no longer"] see radio chatter from radios or speakers"

/client/proc/toggleadminhelpsound()
	set name = "Hear/Silence Adminhelps"
	set category = "Preferences"
	set desc = "Toggle hearing a notification when admin PMs are recieved"
	if(!holder)	return
	prefs.toggles ^= SOUND_ADMINHELP
	prefs.save_preferences()
	usr << "You will [(prefs.toggles & SOUND_ADMINHELP) ? "now" : "no longer"] hear a sound when adminhelps arrive."

/client/verb/deadchat() // Deadchat toggle is usable by anyone.
	set name = "Show/Hide Deadchat"
	set category = "Preferences"
	set desc ="Toggles seeing deadchat"
	prefs.chat_toggles ^= CHAT_DEAD
	prefs.save_preferences()

	if(src.holder)
		src << "You will [(prefs.chat_toggles & CHAT_DEAD) ? "now" : "no longer"] see deadchat."
	else
		src << "As a ghost, you will [(prefs.chat_toggles & CHAT_DEAD) ? "now" : "no longer"] see deadchat."


/client/proc/toggleprayers()
	set name = "Show/Hide Prayers"
	set category = "Preferences"
	set desc = "Toggles seeing prayers"
	prefs.chat_toggles ^= CHAT_PRAYER
	prefs.save_preferences()
	src << "You will [(prefs.chat_toggles & CHAT_PRAYER) ? "now" : "no longer"] see prayerchat."

/client/verb/toggletitlemusic()
	set name = "Hear/Silence LobbyMusic"
	set category = "Preferences"
	set desc = "Toggles hearing the GameLobby music"
	prefs.toggles ^= SOUND_LOBBY
	prefs.save_preferences()
	if(prefs.toggles & SOUND_LOBBY)
		src << "You will now hear music in the game lobby."
		if(istype(mob, /mob/new_player))
			playtitlemusic()
	else
		src << "You will no longer hear music in the game lobby."
		if(istype(mob, /mob/new_player))
			src << sound(null, repeat = 0, wait = 0, volume = 85, channel = 1) // stop the jamsz

/client/verb/togglemidis()
	set name = "Hear/Silence Midis"
	set category = "Preferences"
	set desc = "Toggles hearing sounds uploaded by admins"
	prefs.toggles ^= SOUND_MIDI
	prefs.save_preferences()
	if(prefs.toggles & SOUND_MIDI)
		src << "You will now hear any sounds uploaded by admins."
		var/sound/break_sound = sound(null, repeat = 0, wait = 0, channel = 777)
		break_sound.priority = 250
		src << break_sound	//breaks the client's sound output on channel 777
	else
		src << "You will no longer hear sounds uploaded by admins; any currently playing midis have been disabled."

/client/verb/listen_ooc()
	set name = "Show/Hide OOC"
	set category = "Preferences"
	set desc = "Toggles seeing OutOfCharacter chat"
	prefs.chat_toggles ^= CHAT_OOC
	prefs.save_preferences()
	src << "You will [(prefs.chat_toggles & CHAT_OOC) ? "now" : "no longer"] see messages on the OOC channel."


/client/verb/listen_looc()
	set name = "Show/Hide LOOC"
	set category = "Preferences"
	set desc = "Toggles seeing Local OutOfCharacter chat"
	prefs.chat_toggles ^= CHAT_LOOC
	prefs.save_preferences()

	src << "You will [(prefs.chat_toggles & CHAT_LOOC) ? "now" : "no longer"] see messages on the LOOC channel."


/client/verb/toggle_chattags()
	set name = "Show/Hide Chat Tags"
	set category = "Preferences"
	set desc = "Toggles seeing chat tags/icons"
	prefs.toggles ^= CHAT_NOICONS
	prefs.save_preferences()

	src << "You will [!(prefs.toggles & CHAT_NOICONS) ? "now" : "no longer"] see chat tag icons."


/client/verb/Toggle_Soundscape() //All new ambience should be added here so it works with this verb until someone better at things comes up with a fix that isn't awful
	set name = "Hear/Silence Ambience"
	set category = "Preferences"
	set desc = "Toggles hearing ambient sound effects"
	prefs.toggles ^= SOUND_AMBIENCE
	prefs.save_preferences()
	if(prefs.toggles & SOUND_AMBIENCE)
		src << "You will now hear ambient sounds."
	else
		src << "You will no longer hear ambient sounds."
		src << sound(null, repeat = 0, wait = 0, volume = 0, channel = 1)
		src << sound(null, repeat = 0, wait = 0, volume = 0, channel = 2)

//be special
/client/verb/toggle_be_special(role in be_special_flags)
	set name = "Toggle SpecialRole Candidacy"
	set category = "Preferences"
	set desc = "Toggles which special roles you would like to be a candidate for, during events."
	var/role_flag = be_special_flags[role]
	if(!role_flag)	return
	prefs.be_special ^= role_flag
	prefs.save_preferences()
	src << "You will [(prefs.be_special & role_flag) ? "now" : "no longer"] be considered for [role] events (where possible)."


/client/verb/change_ui()
	set name = "Change UI"
	set category = "Preferences"
	set desc = "Configure your user interface"

	if(!ishuman(usr))
		usr << "This only for human"
		return

	var/UI_style_new = input(usr, "Select a style, we recommend White for customization") in list("White", "Midnight", "Orange", "old")
	if(!UI_style_new) return

	var/UI_style_alpha_new = input(usr, "Select a new alpha(transparence) parametr for UI, between 50 and 255") as num
	if(!UI_style_alpha_new | !(UI_style_alpha_new <= 255 && UI_style_alpha_new >= 50)) return

	var/UI_style_color_new = input(usr, "Choose your UI color, dark colors are not recommended!") as color|null
	if(!UI_style_color_new) return

	//update UI
	var/list/icons = usr.hud_used.adding + usr.hud_used.other +usr.hud_used.hotkeybuttons
	icons.Add(usr.zone_sel)

	for(var/obj/screen/I in icons)
		if(I.name in list(I_HELP, I_HURT, I_DISARM, I_GRAB)) continue
		I.icon = ui_style2icon(UI_style_new)
		I.color = UI_style_color_new
		I.alpha = UI_style_alpha_new



	if(alert("Like it? Save changes?",,"Yes", "No") == "Yes")
		prefs.UI_style = UI_style_new
		prefs.UI_style_alpha = UI_style_alpha_new
		prefs.UI_style_color = UI_style_color_new
		prefs.save_preferences()
		usr << "UI was saved"

/client/verb/autoemotes() // Toggle autoemote russification
	set name = "Toggle Emote Localization"
	set category = "Preferences"
	set desc ="Toggle autoemote localization"
	prefs.toggles ^= RUS_AUTOEMOTES
	prefs.save_preferences()

	src << "Your auto emote [(prefs.toggles & RUS_AUTOEMOTES) ? "now" : "no longer"] be russified."

/client/verb/toggle_motd()
	set name = "Show/Hide MOTD"
	set category = "Preferences"
	set desc ="Show or not MOTD at round join"
	prefs.toggles ^= HIDE_MOTD
	prefs.save_preferences()

	src << "You will [(prefs.toggles & HIDE_MOTD) ? "no longer" : "now"] see MOTD at join game."

/client/verb/toggle_progressbar()
	set name = "Toggle Progressbar"
	set category = "Preferences"
	set desc ="Toggle progressbar visibility"
	prefs.toggles ^= PROGRESSBAR
	prefs.save_preferences()

	src << "You will [(prefs.toggles & PROGRESSBAR) ? "now" : "no longer"] see the progressbar."
