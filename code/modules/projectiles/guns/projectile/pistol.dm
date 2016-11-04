/obj/item/weapon/gun/projectile/colt
	name = "vintage .45 pistol"
	desc = "A cheap Martian knock-off of a Colt M1911. Uses .45 rounds."
	magazine_type = /obj/item/ammo_magazine/c45m
	icon_state = "colt"
	caliber = ".45"
	origin_tech = "combat=2;materials=2"
	fire_sound = 'sound/weapons/gunshotpistol.ogg'
	load_method = MAGAZINE

/obj/item/weapon/gun/projectile/colt/detective
	desc = "A cheap Martian knock-off of a Colt M1911. Uses .45 rounds."
	magazine_type = /obj/item/ammo_magazine/c45m/rubber

/obj/item/weapon/gun/projectile/colt/detective/verb/rename_gun()
	set name = "Name Gun"
	set category = "Object"
	set desc = "Rename your gun. If you're the detective."

	var/mob/M = usr
	if(!M.mind)	return 0
	if(!M.mind.assigned_role == "Detective")
		M << "<span class='notice'>You don't feel cool enough to name this gun, chump.</span>"
		return 0

	var/input = sanitizeSafe(input("What do you want to name the gun?", ,""), MAX_NAME_LEN)

	if(src && input && !M.stat && in_range(M,src))
		name = input
		M << "You name the gun [input]. Say hello to your new friend."
		return 1

/obj/item/weapon/gun/projectile/sec
	desc = "The NT Mk58 is a NanoTrasen designed sidearm, found pretty much everywhere humans are. Uses .45 rounds."
	name = ".45 pistol"
	icon_state = "secguncomp"
	magazine_type = /obj/item/ammo_magazine/c45m/rubber
	caliber = ".45"
	origin_tech = "combat=2;materials=2"
	fire_sound = 'sound/weapons/gunshotpistol.ogg'
	load_method = MAGAZINE
	fire_delay = 2
	accuracy = 1

/obj/item/weapon/gun/projectile/sec/update_icon()
	..()
	icon_state = (ammo_magazine)? "secguncomp" : "secguncomp-empty"
	update_held_icon()


/obj/item/weapon/gun/projectile/sec/flash
	name = ".45 signal pistol"
	magazine_type = /obj/item/ammo_magazine/c45m/flash

/obj/item/weapon/gun/projectile/sec/wood
	desc = "The NT Mk58 is a designed sidearm, this one is made of light materials and doesn't have any recoil. Uses .45 rounds."
	name = "custom .45 pistol (LW)"
	icon_state = "secgunlight"
	recoil = 0
	fire_delay = 3

/obj/item/weapon/gun/projectile/sec/wood/update_icon()
	..()
	icon_state = (ammo_magazine)? "secgunlight" : "secgunlight-empty"
	update_held_icon()

/obj/item/weapon/gun/projectile/sec/longbarrel
	desc = "The NT Mk58 is a designed sidearm, this one has a long barrel and will be more accurate. Uses .45 rounds."
	name = "custom .45 pistol (LB)"
	icon_state = "secgunlongbarrel"
	recoil = 2
	fire_delay = 4
	accuracy = 2
	fire_sound = 'sound/weapons/revolver_shoot.ogg'

/obj/item/weapon/gun/projectile/sec/longbarrel/update_icon()
	..()
	icon_state = (ammo_magazine)? "secgunlongbarrel" : "secgunlongbarrel-empty"
	update_held_icon()

/obj/item/weapon/gun/projectile/sec/shortbarrel
	desc = "The NT Mk58 is a designed sidearm, this one has a shortened barrel and must fit into a pocket. Uses .45 rounds."
	name = "custom .45 pistol (SB)"
	icon_state = "secgunshortbarrel"
	recoil = 1
	fire_delay = 2
	accuracy = 0
	w_class = 2

/obj/item/weapon/gun/projectile/sec/shortbarrel/update_icon()
	..()
	icon_state = (ammo_magazine)? "secgunshortbarrel" : "secgunshortbarrel-empty"
	update_held_icon()

/obj/item/weapon/gun/projectile/sec/tactical
	desc = "The NT Mk58 is a designed sidearm, this one has a system of automated magazine drop. Uses .45 rounds."
	name = "custom .45 pistol (T)"
	icon_state = "secguntactical"
	fire_delay = 4
	auto_eject = 1

/obj/item/weapon/gun/projectile/sec/tactical/update_icon()
	..()
	icon_state = (ammo_magazine)? "secguntactical" : "secguntactical-empty"
	update_held_icon()


/obj/item/weapon/gun/projectile/silenced
	name = "silenced pistol"
	desc = "A small, quiet,  easily concealable gun. Uses .45 rounds."
	icon_state = "silenced_pistol"
	w_class = 3
	caliber = ".45"
	silenced = 1
	origin_tech = "combat=2;materials=2;syndicate=8"
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/c45m

/obj/item/weapon/gun/projectile/deagle
	name = "desert eagle"
	desc = "A robust handgun that uses .50 AE ammo"
	icon_state = "deagle"
	item_state = "deagle"
	force = 14.0
	caliber = ".50"
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/a50
	auto_eject = 1

/obj/item/weapon/gun/projectile/deagle/gold
	desc = "A gold plated gun folded over a million times by superior martian gunsmiths. Uses .50 AE ammo."
	icon_state = "deagleg"
	item_state = "deagleg"

/obj/item/weapon/gun/projectile/deagle/camo
	desc = "A Deagle brand Deagle for operators operating operationally. Uses .50 AE ammo."
	icon_state = "deaglecamo"
	item_state = "deagleg"
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'



/obj/item/weapon/gun/projectile/gyropistol
	name = "gyrojet pistol"
	desc = "A bulky pistol designed to fire self propelled rounds"
	icon_state = "gyropistol"
	max_shells = 8
	caliber = "75"
	fire_sound = 'sound/effects/Explosion1.ogg'
	origin_tech = "combat=3"
	ammo_type = "/obj/item/ammo_casing/a75"
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/a75
	auto_eject = 1
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'

/obj/item/weapon/gun/projectile/gyropistol/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "gyropistolloaded"
	else
		icon_state = "gyropistol"

/obj/item/weapon/gun/projectile/pistol
	name = "\improper holdout pistol"
	desc = "The Lumoco Arms P3 Whisper. small, easily concealable gun. Uses 9mm rounds."
	icon_state = "pistol"
	item_state = null
	w_class = 2
	caliber = "9mm"
	silenced = 0
	origin_tech = "combat=2;materials=2;syndicate=2"
	fire_sound = 'sound/weapons/Gunshot_light.ogg'
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/mc9mm

/obj/item/weapon/gun/projectile/pistol/flash
	name = "\improper Stechtkin signal pistol"
	desc = "A small, easily concealable gun. Uses 9mm rounds."
	magazine_type = /obj/item/ammo_magazine/mc9mm/flash

/obj/item/weapon/gun/projectile/pistol/attack_hand(mob/user as mob)
	if(user.get_inactive_hand() == src)
		if(silenced)
			if(user.l_hand != src && user.r_hand != src)
				..()
				return
			user << "<span class='notice'>You unscrew [silenced] from [src].</span>"
			user.put_in_hands(silenced)
			silenced = 0
			w_class = 2
			update_icon()
			return
	..()

/obj/item/weapon/gun/projectile/pistol/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/silencer))
		if(user.l_hand != src && user.r_hand != src)	//if we're not in his hands
			user << "<span class='notice'>You'll need [src] in your hands to do that.</span>"
			return
		user.drop_from_inventory(I, src) //put the silencer into the gun
		user << "<span class='notice'>You screw [I] onto [src].</span>"
		silenced = I	//dodgy?
		w_class = 3
		update_icon()
		return
	..()

/obj/item/weapon/gun/projectile/pistol/update_icon()
	..()
	if(silenced)
		icon_state = "pistol-silencer"
	else
		icon_state = "pistol"

/obj/item/weapon/silencer
	name = "silencer"
	desc = "a silencer"
	icon = 'icons/obj/gun.dmi'
	icon_state = "silencer"
	w_class = 2

/obj/item/weapon/gun/projectile/pirate
	name = "zipgun"
	desc = "Little more than a barrel, handle, and firing mechanism, cheap makeshift firearms like this one are not uncommon in frontier systems."
	icon_state = "sawnshotgun"
	item_state = "sawnshotgun"
	handle_casings = CYCLE_CASINGS //player has to take the old casing out manually before reloading
	load_method = SINGLE_CASING
	max_shells = 1 //literally just a barrel

	var/global/list/ammo_types = list(
		/obj/item/ammo_casing/a357              = ".357",
		/obj/item/ammo_casing/c9mm/flash        = "9mm",
		/obj/item/ammo_casing/c45/flash         = ".45",
		/obj/item/ammo_casing/a12mm             = "12mm",
		/obj/item/ammo_casing/shotgun           = "12 gauge",
		/obj/item/ammo_casing/shotgun           = "12 gauge",
		/obj/item/ammo_casing/shotgun/pellet    = "12 gauge",
		/obj/item/ammo_casing/shotgun/pellet    = "12 gauge",
		/obj/item/ammo_casing/shotgun/pellet    = "12 gauge",
		/obj/item/ammo_casing/shotgun/beanbag   = "12 gauge",
		/obj/item/ammo_casing/shotgun/stunshell = "12 gauge",
		/obj/item/ammo_casing/shotgun/flash     = "12 gauge",
		/obj/item/ammo_casing/a762              = "7.62mm",
		/obj/item/ammo_casing/a556              = "5.56mm"
		)

/obj/item/weapon/gun/projectile/pirate/New()
	ammo_type = pick(ammo_types)
	desc += " Uses [ammo_types[ammo_type]] rounds."

	var/obj/item/ammo_casing/ammo = ammo_type
	caliber = initial(ammo.caliber)
	..()

/obj/item/weapon/gun/projectile/legalist
	name = "Legalist MKI"
	desc = "A robust handgun that uses 12.5x45 CL ammo"
	icon_state = "legalist"
	item_state = "deagle"
	force = 10.0
	caliber = "12.5x45"
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/legalist
	ammo_type = /obj/item/ammo_casing/c125
	auto_eject = 1
	fire_delay = 3
	fire_sound = 'sound/weapons/revolver_shoot.ogg'

/obj/item/weapon/gun/projectile/legalist/update_icon()
	..()
	icon_state = (ammo_magazine)? "legalist" : "legalist-empty"
	update_held_icon()

/obj/item/weapon/gun/projectile/mk15
	name = "\improper service pistol"
	desc = "That's the Mk.15, standard-issue secondary weapon of NT colonial infantry. Uses 9mm rounds."
	icon_state = "mk15"
	item_state = "mk15"
	w_class = 3
	caliber = "9mm"
	fire_sound = 'sound/weapons/eventpistol.ogg'
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/mc9mmarmy

/obj/item/weapon/gun/projectile/mk15/update_icon()
	..()
	icon_state = (ammo_magazine)? "mk15" : "mk15-empty"
	update_held_icon()
