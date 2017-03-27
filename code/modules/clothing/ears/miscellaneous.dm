/obj/item/clothing/ears/earmuffs
	name = "earmuffs"
	desc = "Protects your hearing from loud noises, and quiet ones as well."
	icon_state = "earmuffs"
	item_state = "earmuffs"
	slot_flags = SLOT_EARS | SLOT_TWOEARS
	ear_protection = 2

/obj/item/clothing/ears/earmuffs/mp3
	name = "headphones with MP3"
	desc = "It is a black portable wireless stereo head hanging, blue LCD display built-in FM radio Mp3 headset."
	icon_state = "headphones"
	item_state = "headphones"
	icon_action_button = "action_music"
	var/obj/item/device/player/player = null

/obj/item/clothing/ears/earmuffs/mp3/New()
	..()
	player = new(src)

/obj/item/clothing/ears/earmuffs/mp3/update_icon()
	overlays.Cut()
	..() //blood overlay, etc.
	if(player.current_track)
		overlays += "headphones_on"

/obj/item/clothing/ears/earmuffs/mp3/ui_action_click()
	player.OpenInterface(usr)

/obj/item/clothing/ears/earmuffs/mp3/dropped(var/mob/user)
	..()
	player.stop(user)

/obj/item/clothing/ears/earmuffs/mp3/equipped(var/mob/user, var/slot)
	..()
	player.play(user)
