/* Two-handed Weapons
 * Contains:
 * 		Twohanded
 *		Fireaxe
 *		Double-Bladed Energy Swords
 */

/*##################################################################
##################### TWO HANDED WEAPONS BE HERE~ -Agouri :3 ########
####################################################################*/

//Rewrote TwoHanded weapons stuff and put it all here. Just copypasta fireaxe to make new ones ~Carn
//This rewrite means we don't have two variables for EVERY item which are used only by a few weapons.
//It also tidies stuff up elsewhere.

/*
 * Twohanded
 */
/obj/item/weapon/material/twohanded
	w_class = 4
	var/wielded = 0
	var/force_wielded = 0
	var/force_unwielded
	var/wieldsound = null
	var/unwieldsound = null
	var/base_icon
	var/base_name
	var/unwielded_force_divisor = 0.25

/obj/item/weapon/material/twohanded/proc/unwield()
	wielded = 0
	force = force_unwielded
	name = "[base_name]"
	update_icon()

/obj/item/weapon/material/twohanded/proc/wield()
	wielded = 1
	force = force_wielded
	name = "[base_name] (Wielded)"
	update_icon()

/obj/item/weapon/material/twohanded/update_force()
	base_name = name
	if(sharp || edge)
		force_wielded = material.get_edge_damage()
	else
		force_wielded = material.get_blunt_damage()
	force_wielded = round(force_wielded*force_divisor)
	force_unwielded = round(force_wielded*unwielded_force_divisor)
	force = force_unwielded
	throwforce = round(force*thrown_force_divisor)
	//world << "[src] has unwielded force [force_unwielded], wielded force [force_wielded] and throwforce [throwforce] when made from default material [material.name]"

/obj/item/weapon/material/twohanded/New()
	..()
	update_icon()

/obj/item/weapon/material/twohanded/mob_can_equip(M as mob, slot)
	//Cannot equip wielded items.
	if(wielded)
		M << "<span class='warning'>Unwield the [base_name] first!</span>"
		return 0

	return ..()

/obj/item/weapon/material/twohanded/dropped(mob/user as mob)
	//handles unwielding a twohanded weapon when dropped as well as clearing up the offhand
	if(user)
		var/obj/item/weapon/material/twohanded/O = user.get_inactive_hand()
		if(istype(O))
			O.unwield()
	return	unwield()

/obj/item/weapon/material/twohanded/update_icon()
	icon_state = "[base_icon][wielded]"
	item_state = icon_state

/obj/item/weapon/material/twohanded/pickup(mob/user)
	unwield()

/obj/item/weapon/material/twohanded/attack_self(mob/living/carbon/human/H as mob)

	..()

	if(!istype(H)) return

	if(H.species.is_small)
		H << "<span class='warning'>It's too heavy for you to wield fully.</span>"
		return

	if(wielded) //Trying to unwield it
		unwield()
		H << "<span class='notice'>You are now carrying the [name] with one hand.</span>"
		if (src.unwieldsound)
			playsound(src.loc, unwieldsound, 50, 1)

		var/obj/item/weapon/material/twohanded/offhand/O = H.get_inactive_hand()
		if(O && istype(O))
			O.unwield()

	else //Trying to wield it
		if(H.get_inactive_hand())
			H << "<span class='warning'>You need your other hand to be empty</span>"
			return
		wield()
		H << "<span class='notice'>You grab the [base_name] with both hands.</span>"
		if (src.wieldsound)
			playsound(src.loc, wieldsound, 50, 1)

		var/obj/item/weapon/material/twohanded/offhand/O = new(H) ////Let's reserve his other hand~
		O.name = "[base_name] - offhand"
		O.desc = "Your second grip on the [base_name]."
		H.put_in_inactive_hand(O)

	H.update_inv_l_hand()
	H.update_inv_r_hand()

	return

///////////OFFHAND///////////////
/obj/item/weapon/material/twohanded/offhand
	w_class = 5
	icon_state = "offhand"
	name = "offhand"
	default_material = "placeholder"

/obj/item/weapon/material/twohanded/offhand/unwield()
	qdel(src)

/obj/item/weapon/material/twohanded/offhand/wield()
	qdel(src)

/obj/item/weapon/material/twohanded/offhand/update_icon()
	return

/*
 * Fireaxe
 */
/obj/item/weapon/material/twohanded/fireaxe  // DEM AXES MAN, marker -Agouri
	icon_state = "fireaxe0"
	base_icon = "fireaxe"
	name = "fire axe"
	desc = "Truly, the weapon of a madman. Who would think to fight fire with an axe?"
	unwielded_force_divisor = 0.25
	force_divisor = 0.7 // 10/42 with hardness 60 (steel) and 0.25 unwielded divisor
	sharp = 1
	edge = 1
	pry = 1
	w_class = 4.0
	slot_flags = SLOT_BACK
	force_wielded = 30
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")
	applies_material_colour = 0

/obj/item/weapon/material/twohanded/fireaxe/afterattack(atom/A as mob|obj|turf|area, mob/user as mob, proximity)
	if(!proximity) return
	..()
	if(A && wielded)
		if(istype(A,/obj/structure/window))
			var/obj/structure/window/W = A
			W.shatter()
		else if(istype(A,/obj/structure/grille))
			qdel(A)
		else if(istype(A,/obj/effect/plant))
			var/obj/effect/plant/P = A
			P.die_off()




//spears, bay edition
/obj/item/weapon/material/twohanded/spear
	icon_state = "spearglass0"
	base_icon = "spearglass"
	name = "spear"
	desc = "A haphazardly-constructed yet still deadly weapon of ancient design."
	force = 10
	w_class = 4.0
	slot_flags = SLOT_BACK
	force_wielded = 0.35           // 22 when wielded with hardness 15 (glass)
	unwielded_force_divisor = 0.25 // 14 when unwielded based on above
	thrown_force_divisor = 1.5 // 20 when thrown with weight 15 (glass)
	throw_speed = 3
	edge = 1
	sharp = 1
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "poked", "jabbed", "torn", "gored")
	default_material = "glass"

/obj/item/weapon/material/twohanded/bostaff
	icon_state = "bostaff0"
	wear_state = "bostaff"
	base_icon = "bostaff"
	name = "bo staff"
	desc = "A long, tall staff made of polished wood. Traditionally used in ancient old-Earth martial arts. Can be wielded to both kill and incapacitate."
	force = 10
	w_class = 4
	slot_flags = SLOT_BACK
	hitsound = 'sound/weapons/genhit3.ogg'
	force_unwielded = 0.80
	force_wielded = 1.4
	throwforce = 0.40
	throw_speed = 2
	attack_verb = list("smashed", "slammed", "whacked", "thwacked")
