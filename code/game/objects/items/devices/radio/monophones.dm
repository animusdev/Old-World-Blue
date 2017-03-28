/obj/item/device/radio/headset/moonphones
	name = "moonphones"
	desc = "Looks very nice!"
	icon_state = "moonphones"
	item_state = "moonphones"
	slot_flags = SLOT_EARS | SLOT_TWOEARS
	icon_action_button = "action_music"
	var/obj/item/device/player/player = null

/obj/item/device/radio/headset/moonphones/New()
	..()
	player = new(src)

/obj/item/device/radio/headset/moonphones/update_icon()
	overlays.Cut()
	..()
	if(player.current_track)
		overlays += "moonphones_on"

/obj/item/device/radio/headset/moonphones/ui_action_click()
	player.OpenInterface(usr)

/obj/item/device/radio/headset/moonphones/dropped(var/mob/user)
	..()
	player.stop(user)

/obj/item/device/radio/headset/moonphones/equipped(var/mob/user, var/slot)
	..()
	player.play(user)
