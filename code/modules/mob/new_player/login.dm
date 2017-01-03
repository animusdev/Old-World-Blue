var/obj/effect/lobby_image = new /obj/effect/lobby_image

/obj/effect/lobby_image
	name = "Polaris"
	desc = "How are you reading this?"
	icon = 'icons/misc/title.dmi'
	icon_state = "title"
	screen_loc = "1,1"

/mob/new_player
	var/client/my_client // Need to keep track of this ourselves, since by the time Logout() is called the client has already been nulled

/mob/new_player/Login()
	update_Login_details()	//handles setting lastKnownIP and computer_id for use by the ban systems as well as checking for multikeying
	if(join_motd && !(client.prefs.toggles & HIDE_MOTD))
		src << "<div class=\"motd\">[join_motd]</div>"

	if(config.soft_popcap && living_player_count() >= config.soft_popcap)
		src << "<span class='notice'><b>Server Notice:</b>\n \t [config.soft_popcap_message]</span>"

	if(!mind)
		mind = new /datum/mind(key)
		mind.active = 1
		mind.current = src

	loc = null
	client.screen += lobby_image
	sight |= SEE_TURFS
	player_list |= src

	new_player_panel()
	spawn(40)
		if(client)
			client.playtitlemusic()
