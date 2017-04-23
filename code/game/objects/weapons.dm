/obj/item/weapon
	name = "weapon"
	icon = 'icons/obj/weapons.dmi'
	hitsound = "swing_hit"

/obj/item/weapon/melee
	sprite_group = SPRITE_MELEE

/obj/item/weapon/Bump(mob/M as mob)
	spawn(0)
		..()
	return