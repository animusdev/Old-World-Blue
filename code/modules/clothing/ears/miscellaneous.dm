/obj/item/clothing/ears/earmuffs
	name = "earmuffs"
	desc = "Protects your hearing from loud noises, and quiet ones as well."
	icon_state = "earmuffs"
	item_state = "earmuffs"
	slot_flags = SLOT_EARS | SLOT_TWOEARS

#define MP3_CHANNEL 4

/obj/item/clothing/ears/earmuffs/mp3
	name = "Headphones with MP3"
	desc = "It is a black portable wireless stereo head hanging, blue LCD display built-in FM radio Mp3 headset."
	icon_state = "headphones_off"
	item_state = "headphones_off"
	slot_flags = SLOT_EARS | SLOT_TWOEARS
	var/up = 0
	icon_action_button = "action_music"


/obj/item/clothing/ears/earmuffs/mp3/attack_self()
	toggle()

/obj/item/clothing/ears/earmuffs/mp3/verb/toggle()
	set category = "Object"
	set name = "Adjust headphones"
	set src in usr

	if(usr.canmove && !usr.stat && !usr.restrained())
		if(src.up)
			src.up = !src.up
			icon_state = "headphones_off"
			usr << sound(null, channel = MP3_CHANNEL)
			usr << browse(null, "window=mp3")
			usr << "You turn off [src]"
		else
			src.up = !src.up
			icon_state = "headphones_on"
			if (istype(usr:l_ear,/obj/item/clothing/ears/earmuffs/mp3)||istype(usr:r_ear,/obj/item/clothing/ears/earmuffs/mp3))
				OpenInterface(usr)
//			usr << browse(Body,Options)
			usr << "You turn on [src]"
		update_clothing_icon()	//so our mob-overlays update

/obj/item/clothing/ears/earmuffs/mp3/dropped(var/mob/user)
	..(user)
	user << sound(null, channel = MP3_CHANNEL)
	user << browse(null, "window=mp3")

/obj/item/clothing/ears/earmuffs/mp3/proc/OpenInterface(mob/user as mob)

	var/dat = "MP3 player<BR>"

	dat += "Space Oddity      <a href='byond://?src=\ref[src];music1=1'>Play</a><br>"
	dat += "Space Dwarfs      <a href='byond://?src=\ref[src];music2=1'>Play</a><br>"
	dat += "Space Faunts      <a href='byond://?src=\ref[src];music3=1'>Play</a><br>"
	dat += "Space Fly         <a href='byond://?src=\ref[src];music4=1'>Play</a><br>"
	dat += "Space Solus       <a href='byond://?src=\ref[src];music5=1'>Play</a><br>"
	dat += "Space Asshole     <a href='byond://?src=\ref[src];music6=1'>Play</a><br>"
	dat += "Space Thunderdome <a href='byond://?src=\ref[src];music7=1'>Play</a><br>"
	dat += "Space Title1      <a href='byond://?src=\ref[src];music8=1'>Play</a><br>"
	dat += "Space Title2      <a href='byond://?src=\ref[src];music9=1'>Play</a><br>"
	dat += "Space Traitor     <a href='byond://?src=\ref[src];music10=1'>Play</a><br>"
	dat += "Space Undertale   <a href='byond://?src=\ref[src];music11=1'>Play</a><br>"

	dat += "Stop Music <a href='byond://?src=\ref[src];music12=1'>Stop</a><br>"

	user << browse(dat, "window=mp3")
	onclose(user, "mp3")
	return


/obj/item/clothing/ears/earmuffs/mp3/Topic(href, href_list)
	if (istype(usr:l_ear,/obj/item/clothing/ears/earmuffs/mp3))
		usr << sound(null, channel = MP3_CHANNEL)
		if(href_list["music1"])
			usr << sound('sound/music/space_oddity.ogg',channel=MP3_CHANNEL, volume=100);
		else if(href_list["music2"])
			usr << sound('sound/music/b12_combined_start.ogg',channel=MP3_CHANNEL, volume=100);
		else if(href_list["music3"])
			usr << sound('sound/music/faunts-das_malefitz.ogg',channel=MP3_CHANNEL, volume=100);
		else if(href_list["music4"])
			usr << sound('sound/music/main.ogg',channel=MP3_CHANNEL, volume=100);
		else if(href_list["music5"])
			usr << sound('sound/music/space.ogg',channel=MP3_CHANNEL, volume=100);
		else if(href_list["music6"])
			usr << sound('sound/music/space_asshole.ogg',channel=MP3_CHANNEL, volume=100);
		else if(href_list["music7"])
			usr << sound('sound/music/THUNDERDOME.ogg',channel=MP3_CHANNEL, volume=100);
		else if(href_list["music8"])
			usr << sound('sound/music/title1.ogg',channel=MP3_CHANNEL, volume=100);
		else if(href_list["music9"])
			usr << sound('sound/music/title2.ogg',channel=MP3_CHANNEL, volume=100);
		else if(href_list["music10"])
			usr << sound('sound/music/traitor.ogg',channel=MP3_CHANNEL, volume=100);
		else if(href_list["music11"])
			usr << sound('sound/music/undertale.ogg',channel=MP3_CHANNEL, volume=100);
		else if(href_list["music12"])
			usr << sound(null, channel = MP3_CHANNEL)

	updateUsrDialog()

#undef MP3_CHANNEL