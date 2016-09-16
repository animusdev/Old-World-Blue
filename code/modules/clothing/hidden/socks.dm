/obj/item/clothing/hidden/socks
	icon = 'icons/obj/clothing/hidden.dmi'
	wear_slot = slot_socks
	slot_name = "socks"
	species_restricted = list("Human", "Skrell")
	var/clipped = 0

/obj/item/clothing/hidden/socks/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if( !clipped && (istype(W, /obj/item/weapon/wirecutters) || istype(W, /obj/item/weapon/scalpel)) )
		playsound(src.loc, 'sound/items/Wirecutter.ogg', 100, 1)
		user.visible_message("\red [user] cuts the fingertips off of the [src].","\red You cut the fingertips off of the [src].")

		clipped = 1
		name = "modified [name]"
		desc = "[desc]<br>They have had the fingertips cut off of them."
		species_restricted = list("Unathi","Tajara")
		return
	..()

/obj/item/clothing/hidden/socks/white_norm
	name = "White socks"
	item_state = "white_norm"
	icon_state = "socks_white"

/obj/item/clothing/hidden/socks/white_short
	name = "Short white socks"
	item_state = "white_short"
	icon_state = "socks_white"

/obj/item/clothing/hidden/socks/white_knee
	name = "Knee-length white socks"
	item_state = "white_knee"
	icon_state = "socks_white"

/obj/item/clothing/hidden/socks/white_thigh
	name = "Thigh white socks"
	item_state = "white_thigh"
	icon_state = "socks_white"

/obj/item/clothing/hidden/socks/black_norm
	name = "Black socks"
	item_state = "black_norm"
	icon_state = "socks_black"

/obj/item/clothing/hidden/socks/black_short
	name = "Short black socks"
	item_state = "black_short"
	icon_state = "socks_black"

/obj/item/clothing/hidden/socks/black_knee
	name = "Knee-length black socks"
	item_state = "black_knee"
	icon_state = "socks_black"

/obj/item/clothing/hidden/socks/black_thigh
	name = "Thigh black socks"
	item_state = "black_thigh"
	icon_state = "socks_black"

/obj/item/clothing/hidden/socks/thin_knee
	name = "Knee-length thin socks"
	item_state = "thin_knee"
	icon_state = "socks_thin"

/obj/item/clothing/hidden/socks/thin_thigh
	name = "Thigh thin socks"
	item_state = "thin_thigh"
	icon_state = "socks_thin"

/*/obj/item/clothing/hidden/socks/rainbow_knee
	name = "Knee-length rainbow socks"
	item_state = "rainbow_knee"

/obj/item/clothing/hidden/socks/rainbow_thigh
	name = "Thigh rainbow socks"
	item_state = "rainbow_thigh"*/

/obj/item/clothing/hidden/socks/pantyhose
	name = "pantyhose"
	item_state = "pantyhose"
	icon_state = "pantyhose"

/obj/item/clothing/hidden/socks/striped_knee
	name = "Knee-length striped socks"
	icon_state = "socks_striped"
	item_state = "striped_knee"

/obj/item/clothing/hidden/socks/striped_thigh
	name = "Thigh striped socks"
	icon_state = "socks_striped"
	item_state = "striped_thigh"
