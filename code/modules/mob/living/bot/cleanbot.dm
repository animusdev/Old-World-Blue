/mob/living/bot/cleanbot
	name = "Cleanbot"
	desc = "A little cleaning robot, he looks so excited!"
	icon_state = "cleanbot0"
	req_one_access = list(access_janitor, access_robotics)
	botcard_access = list(access_janitor, access_maint_tunnels)

	var/tmp/obj/effect/decal/cleanable/target = null
	var/tmp/list/patrol_path = list()
	var/tmp/list/ignorelist = list()

	var/tmp/obj/cleanbot_listener/listener = null
	var/beacon_freq = 1445 // navigation beacon frequency
	var/tmp/signal_sent = 0
	var/tmp/closest_dist
	var/tmp/next_dest
	var/tmp/next_dest_loc

	var/tmp/cleaning = 0
	var/screwloose = 0
	var/oddbutton = 0
	var/should_patrol = 0
	var/blood = 1
	var/tmp/list/target_types = list()

/mob/living/bot/cleanbot/proc/set_target(var/obj/effect/decal/cleanable/target)
	if(!istype(target) || !isturf(target.loc)) return 0

	src.target = target
	return 1

/mob/living/bot/cleanbot/New()
	..()
	get_targets()

	listener = new /obj/cleanbot_listener(src)
	listener.cleanbot = src

	if(radio_controller)
		radio_controller.add_object(listener, beacon_freq, filter = RADIO_NAVBEACONS)

/mob/living/bot/cleanbot/Life()
	..()

	if(!on)
		return
	if(client)
		return
	if(cleaning)
		return

	if(screwloose)
		if(prob(5)) // Make a mess
			if(istype(loc, /turf/simulated))
				var/turf/simulated/T = loc
				T.wet_floor()
	else if(!oddbutton && prob(5))
		custom_emote(2, "makes an excited beeping booping sound!")

	if(oddbutton && prob(5)) // Make a big mess
		visible_message("Something flies out of [src]. He seems to be acting oddly.")
		var/obj/effect/decal/cleanable/blood/gibs/gib = new(loc)
		ignorelist += gib
		spawn(600)
			ignorelist -= gib

	if(pulledby) // Don't wiggle if someone pulls you
		patrol_path = list()
		path = list()
		target = null
		return

	if(!target) // Find a target
		for(var/obj/effect/decal/cleanable/D in reverselist(view(src)))
			if(D in ignorelist)
				continue
			for(var/T in target_types)
				if(istype(D, T))
					if(set_target(D))
						break

		if(!target) // No targets in range
			if(!should_patrol)
				return

			if(!patrol_path || !patrol_path.len)
				if(!signal_sent || signal_sent > world.time + 200) // Waited enough or didn't send yet
					var/datum/radio_frequency/frequency = radio_controller.return_frequency(beacon_freq)
					if(!frequency)
						return

					closest_dist = 9999
					next_dest = null
					next_dest_loc = null

					var/datum/signal/signal = new()
					signal.source = src
					signal.transmission_method = 1
					signal.data = list("findbeakon" = "patrol")
					frequency.post_signal(src, signal, filter = RADIO_NAVBEACONS)
					signal_sent = world.time
				else
					if(next_dest)
						next_dest_loc = listener.memorized[next_dest]
						if(next_dest_loc)
							patrol_path = AStar(loc, next_dest_loc, /turf/proc/CardinalTurfsWithAccess, /turf/proc/Distance, 0, 120, id = botcard, exclude = null)
							signal_sent = 0
			else
				if(patrol_path[1] == loc)
					patrol_path -= patrol_path[1]
				var/moved = step_towards(src, patrol_path[1])
				if(moved)
					patrol_path -= patrol_path[1]
	if(target)
		if(loc == target.loc)
			if(!cleaning)
				UnarmedAttack(target)
				target = null
		else
			if(!path.len)
				spawn(0)
					path = AStar(loc, target.loc, /turf/proc/CardinalTurfsWithAccess, /turf/proc/Distance, 0, 30, id = botcard)
					if(!path)
						path = list()
						var/bad_target = target
						target = null
						ignorelist += bad_target
						spawn(600)
							ignorelist -= bad_target
				return
			if(path.len)
				step_to(src, path[1])
				path -= path[1]
				return

/mob/living/bot/cleanbot/UnarmedAttack(var/obj/effect/decal/cleanable/D, var/proximity)
	if(!..())
		return

	if(D.loc != loc)
		return

	if(!istype(D))
		return

	cleaning = 1
	custom_emote(2, "begins to clean up the [D]")
	update_icons()
	var/cleantime = istype(D, /obj/effect/decal/cleanable/dirt) ? 10 : 40
	if(do_after(src, cleantime))
		if(istype(loc, /turf/simulated))
			var/turf/simulated/f = loc
			f.dirt = 0
			f.clean_blood()
		if(!D)
			return
		qdel(D)
	cleaning = 0
	update_icons()

/mob/living/bot/cleanbot/explode()
	on = 0
	visible_message("<span class='danger'>[src] blows apart!</span>")
	var/turf/Tsec = get_turf(src)

	new /obj/item/weapon/reagent_containers/glass/beaker/bucket(Tsec)
	new /obj/item/device/assembly/prox_sensor(Tsec)
	if(prob(50))
		new /obj/item/robot_parts/l_arm(Tsec)

	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	qdel(src)
	return

/mob/living/bot/cleanbot/update_icons()
	if(cleaning)
		icon_state = "cleanbot-c"
	else
		icon_state = "cleanbot[on]"

/mob/living/bot/cleanbot/turn_off()
	..()
	target = null
	path = list()
	patrol_path = list()

/mob/living/bot/cleanbot/attack_hand(var/mob/user)
	var/dat
	dat += "<TT><B>Automatic Station Cleaner v1.0</B></TT><BR><BR>"
	dat += "Status: <A href='?src=\ref[src];operation=start'>[on ? "On" : "Off"]</A><BR>"
	dat += "Behaviour controls are [locked ? "locked" : "unlocked"]<BR>"
	dat += "Maintenance panel is [open ? "opened" : "closed"]"
	if(!locked || issilicon(user))
		dat += "<BR>Cleans Blood: <A href='?src=\ref[src];operation=blood'>[blood ? "Yes" : "No"]</A><BR>"
		dat += "<BR>Patrol station: <A href='?src=\ref[src];operation=patrol'>[should_patrol ? "Yes" : "No"]</A><BR>"
	if(open && !locked)
		dat += "Odd looking screw twiddled: <A href='?src=\ref[src];operation=screw'>[screwloose ? "Yes" : "No"]</A><BR>"
		dat += "Weird button pressed: <A href='?src=\ref[src];operation=oddbutton'>[oddbutton ? "Yes" : "No"]</A>"

	user << browse("<HEAD><TITLE>Cleaner v1.0 controls</TITLE></HEAD>[dat]", "window=autocleaner")
	onclose(user, "autocleaner")
	return

/mob/living/bot/cleanbot/Topic(href, href_list)
	if(..())
		return
	usr.set_machine(src)
	add_fingerprint(usr)
	switch(href_list["operation"])
		if("start")
			if(on)
				turn_off()
			else
				turn_on()
		if("blood")
			blood = !blood
			get_targets()
		if("patrol")
			should_patrol = !should_patrol
			patrol_path = null
		if("freq")
			var/freq = text2num(input("Select frequency for  navigation beacons", "Frequnecy", num2text(beacon_freq / 10))) * 10
			if (freq > 0)
				beacon_freq = freq
		if("screw")
			screwloose = !screwloose
			usr << "<span class='notice'>You twiddle the screw.</span>"
		if("oddbutton")
			oddbutton = !oddbutton
			usr << "<span class='notice'>You press the weird button.</span>"
	attack_hand(usr)

/mob/living/bot/cleanbot/emag_act(var/remaining_uses, var/mob/user)
	. = ..()
	if(!screwloose || !oddbutton)
		if(user)
			user << "<span class='notice'>The [src] buzzes and beeps.</span>"
		oddbutton = 1
		screwloose = 1
		return 1

/mob/living/bot/cleanbot/proc/get_targets()
	target_types = list(
		/obj/effect/decal/cleanable/blood/oil,
		/obj/effect/decal/cleanable/vomit,
		/obj/effect/decal/cleanable/crayon,
		/obj/effect/decal/cleanable/liquid_fuel,
		/obj/effect/decal/cleanable/mucus,
		/obj/effect/decal/cleanable/dirt,
	)

	if(blood)
		target_types += /obj/effect/decal/cleanable/blood

/* Radio object that listens to signals */

/obj/cleanbot_listener
	var/mob/living/bot/cleanbot/cleanbot = null
	var/list/memorized = list()

/obj/cleanbot_listener/receive_signal(var/datum/signal/signal)
	var/recv = signal.data["beacon"]
	var/valid = signal.data["patrol"]
	if(!recv || !valid || !cleanbot)
		return

	var/dist = get_dist(cleanbot, signal.source.loc)
	memorized[recv] = signal.source.loc

	if(dist < cleanbot.closest_dist) // We check all signals, choosing the closest beakon; then we move to the NEXT one after the closest one
		cleanbot.closest_dist = dist
		cleanbot.next_dest = signal.data["next_patrol"]