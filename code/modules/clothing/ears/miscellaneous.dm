/obj/item/clothing/ears/earmuffs
	name = "earmuffs"
	desc = "Protects your hearing from loud noises, and quiet ones as well."
	icon_state = "earmuffs"
	item_state = "earmuffs"
	slot_flags = SLOT_EARS | SLOT_TWOEARS
	ear_protection = 2

#define MP3_CHANNEL 4

/obj/item/clothing/ears/earmuffs/mp3
	name = "headphones with MP3"
	desc = "It is a black portable wireless stereo head hanging, blue LCD display built-in FM radio Mp3 headset."
	icon_state = "headphones"
	item_state = "headphones"
	slot_flags = SLOT_EARS | SLOT_TWOEARS
	icon_action_button = "action_music"
	var/current_track = ""
	var/list/songs = list(
		"Space Oddity" = 'sound/music/space_oddity.ogg',
		"Space Dwarfs" = 'sound/music/b12_combined_start.ogg',
		"Space Faunts" = 'sound/music/faunts-das_malefitz.ogg',
		"Space Fly" = 'sound/music/main.ogg',
		"Space Solus" = 'sound/music/space.ogg',
		"Space Asshole" = 'sound/music/space_asshole.ogg',
		"Space Thunderdome" = 'sound/music/THUNDERDOME.ogg',
		"Space Title1" = 'sound/music/title1.ogg',
		"Space Title2" = 'sound/music/title2.ogg',
		"Space Traitor" = 'sound/music/traitor.ogg',
		"Space Undertale" = 'sound/music/undertale.ogg'
	)

/obj/item/clothing/ears/earmuffs/mp3/update_icon()
	overlays.Cut()
	..() //blood overlay, etc.
	if(current_track)
		overlays += "headphones_on"


/obj/item/clothing/ears/earmuffs/mp3/attack_self()
	toggle()

/obj/item/clothing/ears/earmuffs/mp3/proc/stop_playing(var/mob/affected)
	current_track = null
	update_icon()
	if(!affected)
		if(ismob(loc))
			affected = loc
		else
			return
	affected << sound(null, channel = MP3_CHANNEL)

/obj/item/clothing/ears/earmuffs/mp3/proc/play_song()
	if(!ear_protection || !current_track || !(current_track in songs))
		stop_playing(usr)

	update_icon()
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		if(src in list(H.l_ear, H.r_ear))
			H << sound(songs[current_track], channel = MP3_CHANNEL, volume=100)

/obj/item/clothing/ears/earmuffs/mp3/ui_action_click()
	OpenInterface(loc)

/obj/item/clothing/ears/earmuffs/mp3/verb/toggle()
	set category = "Object"
	set name = "Adjust headphones"
	set src in usr

	if(usr.canmove && !usr.stat && !usr.restrained())
		if(ear_protection && current_track)
			ear_protection = 0
			stop_playing()
			usr << "You turn off [src]"
		else
			ear_protection = initial(ear_protection)
			play_song()
			usr << "You turn on [src]"
		update_clothing_icon()	//so our mob-overlays update

/obj/item/clothing/ears/earmuffs/mp3/dropped(var/mob/user)
	..()
	user << sound(null, channel = MP3_CHANNEL)

/obj/item/clothing/ears/earmuffs/mp3/equipped(var/mob/user, var/slot)
	..()
	play_song()

/obj/item/clothing/ears/earmuffs/mp3/proc/OpenInterface(mob/user as mob)

	var/dat = "MP3 player<BR><br>"

	for(var/song in songs)
		if(song == current_track)
			dat += "<a href='byond://?src=\ref[src];play=[song]'><b>[song]</b></a><br>"
		else
			dat += "<a href='byond://?src=\ref[src];play=[song]'>[song]</a><br>"
	dat += "<br><a href='byond://?src=\ref[src];stop=1'>Stop Music</a>"

	user << browse(dat, "window=mp3")
	onclose(user, "mp3")
	return


/obj/item/clothing/ears/earmuffs/mp3/Topic(href, href_list)
	if(!src in usr) return
	if(href_list["play"])
		current_track = href_list["play"]
		play_song()
	else if(href_list["stop"] && usr == loc)
		stop_playing(loc)
	spawn OpenInterface(usr)

#undef MP3_CHANNEL