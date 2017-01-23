/datum/firemode/energy
	var/projectile_type = null
	var/modifystate = null
	var/charge_cost = null
	var/fire_sound = null

/obj/item/weapon/gun/energy
	name = "energy gun"
	desc = "A basic energy-based gun."
	icon_state = "energy"
	fire_sound = 'sound/weapons/Taser.ogg'
	fire_sound_text = "laser blast"
	firemode_type = /datum/firemode/energy

	var/obj/item/weapon/cell/power_supply //What type of power cell this uses
	var/charge_cost = 240 //How much energy is needed to fire.
	var/cell_type = null
	var/projectile_type = /obj/item/projectile/beam/practice
	var/modifystate
	var/charge_meter = 1	//if set, the icon state will be chosen based on the current charge

	//self-recharging
	var/self_recharge = 0	//if set, the weapon will recharge itself
	var/use_external_power = 0 //if set, the weapon will look for an external power source to draw from, otherwise it recharges magically
	var/recharge_time = 4
	var/charge_tick = 0

	var/battery_lock = 0	//If set, weapon cannot switch batteries

/obj/item/weapon/gun/energy/switch_firemodes(mob/user=null)
	..()
	var/datum/firemode/energy/current_mode = firemodes[sel_mode]
	if(istype(current_mode))
		projectile_type = isnull(current_mode.projectile_type)? initial(projectile_type) : current_mode.projectile_type
		modifystate = isnull(current_mode.modifystate)? initial(modifystate) : current_mode.modifystate
		charge_cost = isnull(current_mode.charge_cost)? initial(charge_cost) : current_mode.charge_cost
		fire_sound = isnull(current_mode.fire_sound)? initial(fire_sound) : current_mode.fire_sound

		update_icon()
		update_held_icon()

/obj/item/weapon/gun/energy/emp_act(severity)
	..()
	update_icon()

/obj/item/weapon/gun/energy/New()
	..()
	if(cell_type)
		power_supply = new cell_type(src)
	else
		power_supply = new /obj/item/weapon/cell/device/weapon(src)
	if(self_recharge)
		processing_objects.Add(src)
	update_icon()

/obj/item/weapon/gun/energy/Destroy()
	if(self_recharge)
		processing_objects.Remove(src)
	..()

/obj/item/weapon/gun/energy/process()
	if(self_recharge) //Every [recharge_time] ticks, recharge a shot for the cyborg
		charge_tick++
		if(charge_tick < recharge_time) return 0
		charge_tick = 0

		if(!power_supply || power_supply.charge >= power_supply.maxcharge)
			return 0 // check if we actually need to recharge

		if(use_external_power)
			var/obj/item/weapon/cell/external = get_external_power_supply()
			if(!external || !external.use(charge_cost)) //Take power from the borg...
				return 0

		power_supply.give(charge_cost) //... to recharge the shot
		update_icon()
	return 1

/obj/item/weapon/gun/energy/consume_next_projectile()
	if(!power_supply) return null
	if(!ispath(projectile_type)) return null
	if(!power_supply.checked_use(charge_cost)) return null
	return new projectile_type(src)

/obj/item/weapon/gun/energy/proc/load_ammo(var/obj/item/C, mob/user)
	if(istype(C, /obj/item/weapon/cell))
		if(self_recharge || battery_lock)
			user << "<span class='notice'>[src] does not have a battery port.</span>"
			return
		if(istype(C, /obj/item/weapon/cell/device))
			var/obj/item/weapon/cell/device/P = C
			if(power_supply)
				user << "<span class='notice'>[src] already has a power cell.</span>"
			else
				user.visible_message("[user] is reloading [src].", "<span class='notice'>You start to insert [P] into [src].</span>")
				if(do_after(user, 10))
					user.remove_from_mob(P)
					power_supply = P
					P.loc = src
					user.visible_message("[user] inserts [P] into [src].", "<span class='notice'>You insert [P] into [src].</span>")
					playsound(src.loc, 'sound/weapons/flipblade.ogg', 50, 1)
					update_icon()
					update_held_icon()
		else
			user << "<span class='notice'>This cell is not fitted for [src].</span>"
	return

/obj/item/weapon/gun/energy/proc/unload_ammo(mob/user)
	if(self_recharge || battery_lock)
		user << "<span class='notice'>[src] does not have a battery port.</span>"
		return
	if(power_supply)
		user.put_in_hands(power_supply)
		power_supply.update_icon()
		user.visible_message("[user] removes [power_supply] from [src].", "<span class='notice'>You remove [power_supply] from [src].</span>")
		power_supply = null
		playsound(src.loc, 'sound/weapons/empty.ogg', 50, 1)
		update_icon()
		update_held_icon()
	else
		user << "<span class='notice'>[src] does not have a power cell.</span>"

/obj/item/weapon/gun/energy/attackby(var/obj/item/A as obj, mob/user as mob)
	..()
	load_ammo(A, user)

/obj/item/weapon/gun/energy/attack_hand(mob/user as mob)
	if(user.get_inactive_hand() == src)
		unload_ammo(user)
	else
		return ..()

/obj/item/weapon/gun/energy/proc/get_external_power_supply()
	if(isrobot(src.loc))
		var/mob/living/silicon/robot/R = src.loc
		return R.cell
	if(istype(src.loc, /obj/item/rig_module))
		var/obj/item/rig_module/module = src.loc
		if(module.holder && module.holder.wearer)
			var/mob/living/carbon/human/H = module.holder.wearer
			if(istype(H) && H.back)
				var/obj/item/weapon/rig/suit = H.back
				if(istype(suit))
					return suit.cell
	return null

/obj/item/weapon/gun/energy/examine(mob/user, return_dist=1)
	.=..()
	if(.<=3)
		var/shots_remaining = round(power_supply.charge / charge_cost)
		user << "Has [shots_remaining] shot\s remaining."

/obj/item/weapon/gun/energy/update_icon(var/ignore_inhands)
	if(power_supply == null)
		if(modifystate)
			icon_state = "[modifystate]_open"
		else
			icon_state = "[initial(icon_state)]_open"
		return

	if(charge_meter)
		var/ratio = power_supply.charge / power_supply.maxcharge

		//make sure that rounding down will not give us the empty state even if we have charge for a shot left.
		if(power_supply.charge < charge_cost)
			ratio = 0
		else
			ratio = max(round(ratio, 0.25) * 100, 25)

		if(modifystate)
			icon_state = "[modifystate][ratio]"
		else
			icon_state = "[initial(icon_state)][ratio]"
	if(!ignore_inhands) update_held_icon()

