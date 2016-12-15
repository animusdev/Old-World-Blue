/obj/item/device/pumpkinglamp
	name = "pumpking"
	desc = "A hand-held light."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "pumpkin1"
	item_state = "pumpkin"
	w_class = 2
	flags = CONDUCT
	slot_flags = SLOT_BELT

	matter = list(DEFAULT_WALL_MATERIAL = 50,"glass" = 20)

	var/on = 0
	var/brightness_on = 3 //luminosity when on

/obj/item/device/pumpkinglamp/New()
	..()
	icon_state = "pumpkin[rand(1,4)]"
	update_icon()

/obj/item/device/pumpkinglamp/update_icon()
	if(on)
		icon_state = "[initial(icon_state)]-on"
		set_light(brightness_on)
	else
		icon_state = "[initial(icon_state)]"
		set_light(0)

/obj/item/device/pumpkinglamp/attack_self(mob/user)
	if(!isturf(user.loc))
		user << "You cannot turn the light on while in this [user.loc]." //To prevent some lighting anomalities.
		return 0
	on = !on
	update_icon()
	return 1