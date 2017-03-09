/obj/mecha/working/laydlaw
	desc = "Autonomous Power Loader Unit. The workhorse of the exosuit world."
	name = "Laydlaw"
	icon_state = "laydlaw"
	initial_icon = "laydlaw"
	step_in = 6
	max_temperature = 20000
	health = 200
//	wreckage = /obj/effect/decal/mecha_wreckage/laydlaw
	cargo_capacity = 6
	var/running = 0

/obj/mecha/working/laydlaw/Destroy()
	for(var/atom/movable/A in src.cargo)
		A.loc = loc
		var/turf/T = loc
		if(istype(T))
			T.Entered(A)
		step_rand(A)
	cargo.Cut()
	..()

/obj/mecha/working/laydlaw/verb/running_mode()
	set category = "Exosuit Interface"
	set name = "Toggle running mode"
	set src = usr.loc
	set popup_menu = 0
	if(usr!=src.occupant)
		return
	running = !running
	if(running)
		step_in = 1
		src.occupant_message("<font color='blue'>You enable [src] running mode.</font>")
	else
		step_in = initial(step_in)
		src.occupant_message("<font color='red'>You disable [src] running mode.</font>")
	src.log_message("Toggled running mode.")
	update_icon()
	return

/obj/mecha/working/laydlaw/click_action(atom/target,mob/user)
	if(running)
		src.occupant_message("Unable to interact with objects while in running mode")
		return
	else
		return ..()

/obj/mecha/working/laydlaw/get_stats_part()
	var/output = ..()
	output += "<b>Running mode: [running?"on":"off"]</b>"
	return output

/obj/mecha/working/laydlaw/get_commands()
	var/output= {"
		<div class='wr'>
			<div class='header'>Special</div>
			<div class='links'>
				<a href='?src=\ref[src];toggle_running_mode=1'>Toggle running mode</a>
			</div>
		</div>
	"}
	output += ..()
	return output

/obj/mecha/working/laydlaw/Topic(href, href_list)
	..()
	if (href_list["toggle_running_mode"])
		src.running_mode()
	return

/obj/mecha/working/laydlaw/update_icon()
	if (initial_icon)
		icon_state = initial_icon
	else
		icon_state = initial(icon_state)

	if(!occupant)
		icon_state += "-open"
	else if(running)
		icon_state += "-run"
