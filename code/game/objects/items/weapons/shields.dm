/obj/item/weapon/shield
	name = "shield"
	var/base_block_chance = 50

/obj/item/weapon/shield/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/attack_text = "the attack")
	//block as long as they are not directly behind us
	var/bad_arc = reverse_direction(user.dir) //arc of directions from which we cannot block
	if(check_shield_arc(user, bad_arc, damage_source, attacker))
		if(prob(get_block_chance(user, damage, damage_source, attacker)))
			user.visible_message("<span class='danger'>\The [user] blocks [attack_text] with \the [src]!</span>")
			return 1
	return 0

/obj/item/weapon/shield/proc/get_block_chance(mob/user, var/damage, atom/damage_source = null, mob/attacker = null)
	return base_block_chance

/obj/item/weapon/shield/riot
	name = "riot shield"
	desc = "A shield adept at blocking blunt objects from connecting with the torso of the shield wielder."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "riot"
	flags = CONDUCT
	slot_flags = SLOT_BACK
	force = 5.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 4

	w_class = 4.0
	matter = list("glass" = 7500, DEFAULT_WALL_MATERIAL = 1000)
	origin_tech = "materials=2"
	attack_verb = list("shoved", "bashed")
	var/cooldown = 0 //shield bash cooldown. based on world.time

/obj/item/weapon/shield/riot/handle_shield(mob/user)
	. = ..()
	if(.) playsound(user.loc, 'sound/weapons/Genhit.ogg', 50, 1)

/obj/item/weapon/shield/riot/get_block_chance(mob/user, var/damage, atom/damage_source = null, mob/attacker = null)
	if(istype(damage_source, /obj/item/projectile))
		var/obj/item/projectile/P = damage_source
		if((damage > 35) || istype(P, /obj/item/projectile/beam))
			return 0
	return base_block_chance

/obj/item/weapon/shield/riot/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/melee/baton))
		if(cooldown < world.time - 25)
			user.visible_message("<span class='warning'>[user] bashes [src] with [W]!</span>")
			playsound(user.loc, 'sound/effects/shieldbash.ogg', 50, 1)
			cooldown = world.time
	else
		..()

/obj/item/weapon/shield/buckler
	name = "wooden shield"
	desc = "CHAAAAAAAAAAAAAARGE!"
	icon = 'icons/obj/weapons.dmi'
	icon_state = "buckler"
	item_state = "buckler"
	flags = CONDUCT
	slot_flags = SLOT_BACK
	force = 3.0
	throwforce = 3.0
	throw_speed = 1
	throw_range = 4
	w_class = 4.0
	attack_verb = list("shoved", "bashed")
	var/cooldown = 0 //shield bash cooldown. based on world.time

/obj/item/weapon/shield/buckler/handle_shield(mob/user)
	. = ..()
	if(.) playsound(user.loc, 'sound/weapons/Genhit.ogg', 50, 1)

/obj/item/weapon/shield/buckler/get_block_chance(mob/user, var/damage, atom/damage_source = null, mob/attacker = null)
	if(istype(damage_source, /obj/item/projectile))
		var/obj/item/projectile/P = damage_source
		//���� ���� �����, ����, ����� ������� ������ ������..
		if((damage > 20) || istype(P, /obj/item/projectile/beam))
			return 0
	return base_block_chance

/obj/item/weapon/shield/buckler/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/material/twohanded/spear))
		if(cooldown < world.time - 25)
			user.visible_message("<span class='warning'>[user] bashes [src] with [W]!</span>")
			playsound(user.loc, 'sound/effects/shieldbash.ogg', 50, 1)
			cooldown = world.time
	else
		..()

/*
 * Energy Shield
 */

/obj/item/weapon/shield/energy
	name = "energy combat shield"
	desc = "A shield capable of stopping most projectile and melee attacks. It can be retracted, expanded, and stored anywhere."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "eshield0" // eshield1 for expanded
	flags = CONDUCT
	force = 3.0
	base_block_chance = 70
	throwforce = 5.0
	throw_speed = 1
	throw_range = 4
	w_class = 2
	origin_tech = "materials=4;magnets=3;syndicate=4"
	attack_verb = list("shoved", "bashed")
	var/active = 0

/obj/item/weapon/shield/energy/handle_shield(mob/user)
	if(!active)
		return 0 //������ �� ����������� ����� �����������
	. = ..()

	if(.)
		var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
		spark_system.set_up(5, 0, user.loc)
		spark_system.start()
		playsound(user.loc, 'sound/weapons/blade1.ogg', 50, 1)

/obj/item/weapon/shield/energy/get_block_chance(mob/user, var/damage, atom/damage_source = null, mob/attacker = null)
	if(istype(damage_source, /obj/item/projectile))
		var/obj/item/projectile/P = damage_source
		if((is_sharp(P) && damage > 10) || istype(P, /obj/item/projectile/beam))
			return (base_block_chance - round(damage / 3)) //block bullets and beams using the old block chance
	return base_block_chance

/obj/item/weapon/shield/energy/attack_self(mob/living/user as mob)
	if ((CLUMSY in user.mutations) && prob(50))
		user << "\red You beat yourself in the head with [src]."
		user.take_organ_damage(5)
	active = !active
	if (active)
		force = 10
		icon_state = "eshield[active]"
		w_class = 4
		playsound(user, 'sound/weapons/saberon.ogg', 50, 1)
		user << "\blue [src] is now active."

	else
		force = 3
		icon_state = "eshield[active]"
		w_class = 1
		playsound(user, 'sound/weapons/saberoff.ogg', 50, 1)
		user << "\blue [src] can now be concealed."

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.update_inv_l_hand()
		H.update_inv_r_hand()

	add_fingerprint(user)
	return

//////////////////////////SHIELD HELPER////////////////////////////////////////
/obj/item/proc/check_shield_arc(mob/user, var/bad_arc, atom/damage_source = null, mob/attacker = null)
	//check attack direction
	var/attack_dir = 0 //direction from the user to the source of the attack
	if(istype(damage_source, /obj/item/projectile))
		var/obj/item/projectile/P = damage_source
		attack_dir = get_dir(get_turf(user), P.starting)
	else if(attacker)
		attack_dir = get_dir(get_turf(user), get_turf(attacker))
	else if(damage_source)
		attack_dir = get_dir(get_turf(user), get_turf(damage_source))

	//world << "attack_dir: [print_dir(attack_dir)]"

	if(!(attack_dir && (attack_dir & bad_arc)))
		return 1
	return 0

