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
	icon_state = "headphones_off"
	item_state = "headphones"
	slot_flags = SLOT_EARS | SLOT_TWOEARS
	icon_action_button = "action_music"
	var/last_song = ""
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


/obj/item/clothing/ears/earmuffs/mp3/attack_self()
	toggle()

/obj/item/clothing/ears/earmuffs/mp3/proc/stop_playing(var/mob/affected)
	affected << sound(null, channel = MP3_CHANNEL)

/obj/item/clothing/ears/earmuffs/mp3/proc/play_song(var/song = "")
	if(!song || !(song in songs))
		if(!last_song) return
	else
		last_song = song
	if(!ishuman(loc)) return
	var/mob/living/carbon/human/H = loc
	if(src in list(H.l_ear, H.r_ear))
		H << sound(last_song, channel = MP3_CHANNEL, volume=100)

/obj/item/clothing/ears/earmuffs/mp3/ui_action_click()
	OpenInterface(loc)

/obj/item/clothing/ears/earmuffs/mp3/verb/toggle()
	set category = "Object"
	set name = "Adjust headphones"
	set src in usr

	if(usr.canmove && !usr.stat && !usr.restrained())
		if(ear_protection)
			ear_protection = 0
			icon_state = "headphones_off"
			stop_playing(usr)
			usr << "You turn off [src]"
		else
			ear_protection = initial(ear_protection)
			icon_state = "headphones_on"
			play_song()
			usr << "You turn on [src]"
		update_clothing_icon()	//so our mob-overlays update

/obj/item/clothing/ears/earmuffs/mp3/dropped(var/mob/user)
	..(user)
	stop_playing(user)
	user << browse(null, "window=mp3")

/obj/item/clothing/ears/earmuffs/mp3/proc/OpenInterface(mob/user as mob)

	var/dat = "MP3 player<BR><br>"

	for(var/song in songs)
		if(song == last_song)
			dat += "<a href='byond://src=\ref[src];play=[song]'><b>[song]</b></a><br>"
		else
			dat += "<a href='byond://src=\ref[src];play=[song]'>[song]</a><br>"
	dat += "<a href='byond://?src=\ref[src];stop=1'>Stop Music</a>"

	user << browse(dat, "window=mp3")
	onclose(user, "mp3")
	return


/obj/item/clothing/ears/earmuffs/mp3/Topic(href, href_list)
	if(href_list["play"])
		play_song(href_list["play"])
	else if(href_list["stop"] && usr == loc)
		stop_playing(loc)
	updateUsrDialog()

#undef MP3_CHANNEL