/obj/item/clothing/hidden/socks
	icon = 'icons/inv_slots/hidden/icon.dmi'
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

/obj/item/clothing/hidden/socks/white
	name = "White socks"
	wear_state = "ss_white"
	icon_state = "socks_white"

/obj/item/clothing/hidden/socks/white/thigh
	name = "Thigh white socks"
	wear_state = "st_white"

/obj/item/clothing/hidden/socks/white/thin
	name = "White thin socks"
	wear_state = "sst_white"
	icon_state = "socks_white"

/obj/item/clothing/hidden/socks/white/thigh/thin
	name = "Thigh thin white socks"
	wear_state = "stt_white"

/obj/item/clothing/hidden/socks/black
	name = "Black socks"
	wear_state = "ss_black"
	icon_state = "socks_black"

/obj/item/clothing/hidden/socks/black/thigh
	name = "Thigh black socks"
	wear_state = "st_black"

/obj/item/clothing/hidden/socks/black/thin
	name = "Black thin socks"
	wear_state = "sst_black"
	icon_state = "socks_black"

/obj/item/clothing/hidden/socks/black/thigh/thin
	name = "Thigh black thin socks"
	wear_state = "stt_black"

/obj/item/clothing/hidden/socks/striped
	name = "Knee-length striped socks"
	icon_state = "socks_striped"
	wear_state = "ss_striped"

/obj/item/clothing/hidden/socks/striped/thigh
	name = "Thigh striped socks"
	wear_state = "st_striped"

/obj/item/clothing/hidden/socks/pantyhose
	name = "pantyhose"
	wear_state = "pantyhose"
	icon_state = "pantyhose"

/obj/item/clothing/hidden/socks/stock
	name = "Black stockings"
	wear_state = "ss_black"
	icon_state = "socks_black"
