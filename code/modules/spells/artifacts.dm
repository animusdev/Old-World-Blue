//////////////////////Scrying orb//////////////////////

/obj/item/weapon/scrying
	name = "scrying orb"
	desc = "An incandescent orb of otherworldly energy, staring into it gives you vision beyond mortal means."
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "bluespace"
	throw_speed = 3
	throw_range = 7
	throwforce = 10
	damtype = BURN
	force = 10
	hitsound = 'sound/items/welder2.ogg'
	origin_tech = list(TECH_ARCANE = 2)

/obj/item/weapon/scrying/attack_self(mob/user as mob)
	visible_message("<span class='danger'>[user] stares into [src], their eyes glazing over.</span>")
	if(wizards && wizards.is_antagonist(user.mind))
		user << "<span class='info'>You can see... everything!</span>"
		user.teleop = user.ghostize(1)
		announce_ghost_joinleave(user.teleop, 1, "You feel that they used a powerful artifact to [pick("invade","disturb","disrupt","infest","taint","spoil","blight")] this place with their presence.")
	else
		user << SPAN_WARN("You see light inside [src]... It's too bright!")
		user.eye_blurry = max(user.eye_blurry, 20)
