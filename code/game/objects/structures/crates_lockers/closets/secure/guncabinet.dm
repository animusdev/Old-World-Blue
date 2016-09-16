/obj/structure/closet/secure_closet/guncabinet
	name = "gun cabinet"
	req_access = list(access_armory)
	icon = 'icons/obj/guncabinet.dmi'
	icon_state = "base"

/obj/structure/closet/secure_closet/guncabinet/update_icon()
	overlays.Cut()
	icon_state = "base"
	if(opened)
		overlays += "door_open"
	else
		var/lazors = 0
		var/shottas = 0
		for (var/obj/item/weapon/gun/G in contents)
			if (istype(G, /obj/item/weapon/gun/energy))
				lazors++
			if (istype(G, /obj/item/weapon/gun/projectile/))
				shottas++
		if (lazors || shottas)
			for (var/i = 0 to 2)
				var/image/gun = null

				if (lazors > 0 && (shottas <= 0 || prob(50)))
					lazors--
					gun = new/image("icon" = src.icon, "icon_state" = "laser")
				else if (shottas > 0)
					shottas--
					gun = new/image("icon" = src.icon, "icon_state" = "projectile")

				if(gun)
					gun.pixel_x = i*4
					overlays += gun

		overlays += image("icon" = src.icon, "icon_state" = "door")

		if(broken)
			overlays += image("icon" = src.icon, "icon_state" = "broken")
		else if (locked)
			overlays += image("icon" = src.icon, "icon_state" = "locked")
		else
			overlays += image("icon" = src.icon, "icon_state" = "open")
