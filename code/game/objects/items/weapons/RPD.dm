/*
CONTAINS:
RPD
*/

/*var/global/list/RPD_data = list(
	"simple",
	"he",
	"connector",
	"manifold",
	"junction",
	"uvent",
	"mvalve",
	"pump",
	"scrubber",
	"insulated",
	"meter",
	"filter_control",
	"filter",
	"mixer",
	"passivegate",
	"volumepump",
	"heunary",
	"mtvalve",
	"mtvalvem",
	"manifold4w",
	"cap",
	"cap-f",
	"m_filter",
	"t_mixer",
	"m_mixer",
	"omni_filter",
	"omni_mixer",
	"universal"
	)*/

/obj/item/weapon/rpd
	name = "rapid pipeping device"
	desc = "A device used to rapidly build pipes."
	icon = 'icons/obj/items.dmi'
	icon_state = "rcd"
	opacity = 0
	density = 0
	anchored = 0.0
	flags = CONDUCT
	force = 10.0
	throwforce = 10.0
	throw_speed = 1
	throw_range = 5
	w_class = 3.0
	//matter = list(DEFAULT_WALL_MATERIAL = 50000)
	origin_tech = "engineering=4;materials=2"
	var/datum/effect/effect/system/spark_spread/spark_system
	var/stored_matter = 0
	var/working = 0
	var/mode = 1
	var/list/modes = list("Pipes","Disporal Pipes","Deconstruct pipe")
	var/canRwall = 0
	var/disabled = 0
	var/p_type = 0
	var/p_dir = 1
	var/what_icon_state = "simple"
	var/wait = 0
	var/get_dir = NORTH

/obj/item/weapon/rpd/proc/build_pipe(user as mob)
	var/dirname
	switch(get_dir)
		if(NORTH)
			dirname = "NORTH"
		if(SOUTH)
			dirname = "SOUTH"
		if(EAST)
			dirname = "EAST"
		if(WEST)
			dirname = "WEST"

	var/icon/dir_icon = new('icons/obj/pipe-item.dmi',what_icon_state)
	if(p_dir == 1)
		user << browse_rsc(new /icon(dir_icon, dir=NORTH), "n.png")
		user << browse_rsc(new /icon(dir_icon, dir=EAST),  "e.png")
		user << browse_rsc(new /icon(dir_icon, dir=SOUTH), "s.png")
		user << browse_rsc(new /icon(dir_icon, dir=WEST),  "w.png")
	else
		user << browse_rsc(new /icon(dir_icon, dir=NORTH + turn(NORTH, 90)), "n.png")
		user << browse_rsc(new /icon(dir_icon, dir=EAST + turn(EAST, 90)),  "e.png")
		user << browse_rsc(new /icon(dir_icon, dir=SOUTH + turn(SOUTH, 90)), "s.png")
		user << browse_rsc(new /icon(dir_icon, dir=WEST + turn(WEST, 90)),  "w.png")

	var/dat = {"
<b>Direction: [dirname]</b><BR>
<A href='?src=\ref[src];get_dir=[NORTH]'>N<img src="n.png"></A> <A href='?src=\ref[src];get_dir=[SOUTH]'>S<img src="s.png"></A> <A href='?src=\ref[src];get_dir=[EAST]'>E<img src="e.png"></A> <A href='?src=\ref[src];get_dir=[WEST]'>W<img src="w.png"></A><BR>
<b>Regular pipes:</b><BR>
<A href='?src=\ref[src];make=0;pipe_type=simple;dir=1'>Pipe</A><BR>
<A href='?src=\ref[src];make=1;pipe_type=simple;dir=5'>Bent Pipe</A><BR>
<A href='?src=\ref[src];make=5;pipe_type=manifold;dir=1'>Manifold</A><BR>
<A href='?src=\ref[src];make=8;pipe_type=mvalve;dir=1'>Manual Valve</A><BR>
<A href='?src=\ref[src];make=20;pipe_type=cap;dir=1'>Pipe Cap</A><BR>
<A href='?src=\ref[src];make=19;pipe_type=manifold4w;dir=1'>4-Way Manifold</A><BR>
<A href='?src=\ref[src];make=18;pipe_type=mtvalve;dir=1'>Manual T-Valve</A><BR>
<A href='?src=\ref[src];make=43;pipe_type=mtvalvem;dir=1'>Manual T-Valve - Mirrored</A><BR>
<A href='?src=\ref[src];make=21;dir=1'>Upward Pipe</A><BR>
<A href='?src=\ref[src];make=22;dir=1'>Downward Pipe</A><BR>
<b>Supply pipes:</b><BR>
<A href='?src=\ref[src];make=29;pipe_type=simple;dir=1'>Pipe</A><BR>
<A href='?src=\ref[src];make=30;pipe_type=simple;dir=5'>Bent Pipe</A><BR>
<A href='?src=\ref[src];make=33;pipe_type=manifold;dir=1'>Manifold</A><BR>
<A href='?src=\ref[src];make=41;pipe_type=cap;dir=1'>Pipe Cap</A><BR>
<A href='?src=\ref[src];make=35;pipe_type=manifold4w;dir=1'>4-Way Manifold</A><BR>
<A href='?src=\ref[src];make=37;dir=1'>Upward Pipe</A><BR>
<A href='?src=\ref[src];make=39;dir=1'>Downward Pipe</A><BR>
<b>Scrubbers pipes:</b><BR>
<A href='?src=\ref[src];make=31;pipe_type=simple;dir=1'>Pipe</A><BR>
<A href='?src=\ref[src];make=32;pipe_type=simple;dir=5'>Bent Pipe</A><BR>
<A href='?src=\ref[src];make=34;pipe_type=manifold;dir=1'>Manifold</A><BR>
<A href='?src=\ref[src];make=42;pipe_type=cap;dir=1'>Pipe Cap</A><BR>
<A href='?src=\ref[src];make=36;pipe_type=manifold4w;dir=1'>4-Way Manifold</A><BR>
<A href='?src=\ref[src];make=38;dir=1'>Upward Pipe</A><BR>
<A href='?src=\ref[src];make=40;dir=1'>Downward Pipe</A><BR>
<b>Devices:</b><BR>
<A href='?src=\ref[src];make=28;pipe_type=universal;dir=1'>Universal pipe adapter</A><BR>
<A href='?src=\ref[src];make=4;pipe_type=connector;dir=1'>Connector</A><BR>
<A href='?src=\ref[src];make=7;pipe_type=uvent;dir=1'>Unary Vent</A><BR>
<A href='?src=\ref[src];make=9;pipe_type=pump;dir=1'>Gas Pump</A><BR>
<A href='?src=\ref[src];make=15;pipe_type=passivegate;dir=1'>Pressure Regulator</A><BR>
<A href='?src=\ref[src];make=16;pipe_type=volumepump;dir=1'>High Power Gas Pump</A><BR>
<A href='?src=\ref[src];make=10;pipe_type=scrubber;dir=1'>Scrubber</A><BR>
<A href='?src=\ref[src];make=-1;pipe_type=meter;dir=1'>Meter</A><BR>
<A href='?src=\ref[src];make=13;pipe_type=filter;dir=1'>Gas Filter</A><BR>
<A href='?src=\ref[src];make=23;pipe_type=m_filter;dir=1'>Gas Filter - Mirrored</A><BR>
<A href='?src=\ref[src];make=14;pipe_type=mixer;dir=1'>Gas Mixer</A><BR>
<A href='?src=\ref[src];make=25;pipe_type=m_mixer;dir=1'>Gas Mixer - Mirrored</A><BR>
<A href='?src=\ref[src];make=24;pipe_type=t_mixer;dir=1'>Gas Mixer - T</A><BR>
<A href='?src=\ref[src];make=26;pipe_type=omni_mixer;dir=1'>Omni Gas Mixer</A><BR>
<A href='?src=\ref[src];make=27;pipe_type=omni_filter;dir=1'>Omni Gas Filter</A><BR>
<b>Heat exchange:</b><BR>
<A href='?src=\ref[src];make=2;pipe_type=he;dir=1'>Pipe</A><BR>
<A href='?src=\ref[src];make=3;pipe_type=he;dir=5'>Bent Pipe</A><BR>
<A href='?src=\ref[src];make=6;pipe_type=junction;dir=1'>Junction</A><BR>
<A href='?src=\ref[src];make=17;pipe_type=heunary;dir=1'>Heat Exchanger</A><BR>
<b>Insulated pipes:</b><BR>
<A href='?src=\ref[src];make=11;pipe_type=insulated;dir=1'>Pipe</A><BR>
<A href='?src=\ref[src];make=12;pipe_type=insulated;;dir=5'>Bent Pipe</A><BR>

"}
///// Z-Level stuff
//What number the make points to is in the define # at the top of construction.dm in same folder

	user << browse("<HEAD><TITLE>[src]</TITLE></HEAD><TT>[dat]</TT>", "window=rpd")
	onclose(user, "RPD")
	return

/obj/item/weapon/rpd/Topic(href, href_list)
	if(!usr.canmove || usr.stat || usr.restrained() || !in_range(loc, usr))
		usr << browse(null, "window=rpd")
		return
	usr.set_machine(src)
	src.add_fingerprint(usr)
	if(href_list["get_dir"])
		get_dir = text2num(href_list["get_dir"])
	if(href_list["make"])
		if(!wait)
			p_type = text2num(href_list["make"])
			p_dir = text2num(href_list["dir"])
	if(href_list["pipe_type"])
		what_icon_state = href_list["pipe_type"]
			//var/obj/item/pipe/P = new (/*usr.loc*/ src.loc, pipe_type=p_type, dir=p_dir)
			//P.update()
			//P.add_fingerprint(usr)
			//wait = 1
			//spawn(10)
			//	wait = 0
/*	if(href_list["makemeter"])
		if(!wait)
			new /obj/item/pipe_meter(/*usr.loc*/ src.loc)
			wait = 1
			spawn(15)
				wait = 0*/
	attack_self(usr)
	return






/obj/item/weapon/rpd/attack_self(mob/user) // change mode
	//Change the mode
/*	if(++mode > 3)
		mode = 1
	user << "<span class='notice'>Changed mode to '[modes[mode]]'</span>"
	playsound(src.loc, 'sound/effects/pop.ogg', 50, 0)
	if(prob(20)) src.spark_system.start()*/
	return build_pipe(user)


/*/obj/item/weapon/rpd/attack(mob/M as mob, mob/user as mob)
	if (M == user)
		switch (mode)
			if (1)
				return build_pipe(user)
			if (2)
				user << "<span class='notice'>not working right now</span>"
			if (3)
				user << "<span class='notice'>deconstruct not working right now</span>"
	/*else //if (istype(M,/turf/simulated/floor))
		user << "<span class='notice'>alter turf go!</span>"
		return alter_turf (M,user,(mode == 3))*/
	return 0*/

/obj/item/weapon/rpd/afterattack(atom/A, mob/user as mob, proximity)
	var/build_cost = 5
	var/spawn_dir = get_dir
	if(!proximity) return

	if(istype(user,/mob/living/silicon/robot))
		var/mob/living/silicon/robot/R = user
		if(R.stat || !R.cell || R.cell.charge <= 0)
			return
	else
		if(stored_matter <= 0)
			return


	if(!istype(A, /obj/structure/table) && !istype(A, /turf/simulated/floor))
		return

	if(!useResource(build_cost, user))
		user << "Insufficient resources."
		return 0

	playsound(src.loc, 'sound/machines/click.ogg', 10, 1)
	//var/obj/product
	if(p_type>=0)
		if(p_dir == 5)
			spawn_dir = get_dir + turn(get_dir, 90)
		//	var/obj/item/pipe/P = new (/*usr.loc*/ get_turf(A), pipe_type=p_type, dir=get_dir + (turn(get_dir, 90)))
		var/obj/item/pipe/P = new (/*usr.loc*/ get_turf(A), pipe_type=p_type, dir=spawn_dir)
		P.update()
		P.add_fingerprint(usr)
	else
		new /obj/item/pipe_meter(/*usr.loc*/ get_turf(A))


/obj/item/weapon/rpd/proc/can_use(var/mob/user,var/turf/T)
	return (user.Adjacent(T) && user.get_active_hand() == src && !user.stat && !user.restrained())

/*/obj/item/weapon/rpd/proc/alter_turf(var/turf/T,var/mob/user,var/deconstruct)

/*
	var/build_cost = 5
	var/build_type = "pipe"
	var/build_turf
	var/build_delay = 10
	var/build_other
*/
	user << "<span class='pt [p_type], dir [p_dir]</span>"
	var/obj/item/pipe/P = new (usr.loc /*src.loc*/, pipe_type=p_type, dir=p_dir)
	P.update()
	P.add_fingerprint(usr)
	//spawn(10)
	return 1
*/

/*/obj/item/weapon/rpd/examine()
	. = ..()
	if(src.type == /obj/item/weapon/rpd && loc == usr)
		usr << "It currently holds [stored_matter]/30 matter-units."
*/
/obj/item/weapon/rpd/New()
	..()
	src.spark_system = new /datum/effect/effect/system/spark_spread
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)

/obj/item/weapon/rpd/Destroy()
	qdel(spark_system)
	spark_system = null
	return ..()

/*/obj/item/weapon/rpd/attackby(obj/item/weapon/W, mob/user)

	if(istype(W, /obj/item/weapon/rpd_ammo))
		if((stored_matter + 10) > 30)
			user << "<span class='notice'>The RCD can't hold any more matter-units.</span>"
			return
		user.drop_from_inventory(W)
		qdel(W)
		stored_matter += 10
		playsound(src.loc, 'sound/machines/click.ogg', 50, 1)
		user << "<span class='notice'>The RCD now holds [stored_matter]/30 matter-units.</span>"
		return
	..()*/



/*/obj/item/weapon/rpd/afterattack(atom/A, mob/user, proximity)
	if(!proximity)
		return
	if(disabled && !isrobot(user))
		return 0
	if(istype(get_area(A),/area/shuttle)||istype(get_area(A),/turf/space/transit))
		return 0
	return alter_turf(A,user,(mode == 3))*/

/obj/item/weapon/rpd/proc/useResource(var/amount, var/mob/user)
	if(stored_matter < amount)
		return 0
	stored_matter -= amount
	return 1


/*/obj/item/weapon/rpd_ammo
	name = "compressed matter cartridge"
	desc = "Highly compressed matter for the RPD."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "rpd"
	item_state = "rpdammo"
	w_class = 2
	origin_tech = "materials=2"
	matter = list(DEFAULT_WALL_MATERIAL = 30000,"glass" = 15000)
*/
/obj/item/weapon/rpd/borg
	canRwall = 1

/obj/item/weapon/rpd/borg/useResource(var/amount, var/mob/user)
	if(isrobot(user))
		var/mob/living/silicon/robot/R = user
		if(R.cell)
			var/cost = amount*10
			if(R.cell.charge >= cost)
				R.cell.use(cost)
				return 1
	return 0

/obj/item/weapon/rpd/borg/attackby()
	return

/obj/item/weapon/rpd/borg/can_use(var/mob/user,var/turf/T)
	return (user.Adjacent(T) && !user.stat)


/*/obj/item/weapon/rpd/mounted/useResource(var/amount, var/mob/user)
	var/cost = amount*130 //so that a rig with default powercell can build ~2.5x the stuff a fully-loaded RCD can.
	if(istype(loc,/obj/item/rig_module))
		var/obj/item/rig_module/module = loc
		if(module.holder && module.holder.cell)
			if(module.holder.cell.charge >= cost)
				module.holder.cell.use(cost)
				return 1
	return 0

/obj/item/weapon/rpd/mounted/attackby()
	return

/obj/item/weapon/rpd/mounted/can_use(var/mob/user,var/turf/T)
	return (user.Adjacent(T) && !user.stat && !user.restrained())
*/