/obj/machinery/computer/new_shuttle_control
	name = "shuttle control console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "shuttle"
	circuit = null
	var/datum/shuttle/untethered/my_shuttle = null

/obj/machinery/computer/new_shuttle_control/New()
	..()
	var/area/my_area = get_area(src)
	if(!my_area)
		return
	my_shuttle = my_area.is_shuttle

/obj/machinery/computer/new_shuttle_control/attack_hand(mob/user)
	user.set_machine(src)
	interact(user)
	onclose(user, "shuttle")

//NanoUI
///obj/machinery/computer/new_shuttle_control/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
/obj/machinery/computer/new_shuttle_control/interact(mob/user)
	if(!my_shuttle)
		var/dat = SPAN_WARN("<H1>Shuttle connection lost!</H1>")
		user << browse(dat, "window=shuttle")
		return

	var/dat = list()
	dat += "<html><head><title>Shuttle control console</title></head><body>"
	dat += "Target dock: <a href='?src=\ref[src];select_dock=1'>[my_shuttle.target_dock ? my_shuttle.target_dock.name : "Not set"]</a>"

	var/shuttle_state
	switch(my_shuttle.moving_status)
		if(SHUTTLE_IDLE) shuttle_state = "idle"
		if(SHUTTLE_WARMUP) shuttle_state = "warmup"
		if(SHUTTLE_INTRANSIT) shuttle_state = "in_transit"

	dat += "Shuttle state: [shuttle_state]"
	dat += "<a href='src=\ref[src];move=1'>Move</a>"
/*
	dat += "<a href='src=\ref[src];force=1'>Force Move</a>"
	dat += "<a href='src=\ref[src];cancel=1'>Cancel Move</a>"
*/
	dat += "</body></html>"

	user << browse(jointext(dat, "<br>"), "window=shuttle")


/*
	var/data[0]
	var/datum/shuttle/ferry/shuttle = shuttle_controller.shuttles[shuttle_tag]
	if (!istype(shuttle))
		return

	var/shuttle_state
	switch(shuttle.moving_status)
		if(SHUTTLE_IDLE) shuttle_state = "idle"
		if(SHUTTLE_WARMUP) shuttle_state = "warmup"
		if(SHUTTLE_INTRANSIT) shuttle_state = "in_transit"

	var/shuttle_status
	switch (shuttle.process_state)
		if(IDLE_STATE)
			if (shuttle.in_use)
				shuttle_status = "Busy."
			else if (!shuttle.location)
				shuttle_status = "Standing-by at station."
			else
				shuttle_status = "Standing-by at offsite location."
		if(WAIT_LAUNCH, FORCE_LAUNCH)
			shuttle_status = "Shuttle has recieved command and will depart shortly."
		if(WAIT_ARRIVE)
			shuttle_status = "Proceeding to destination."
		if(WAIT_FINISH)
			shuttle_status = "Arriving at destination now."

	data = list(
		"shuttle_status" = shuttle_status,
		"shuttle_state" = shuttle_state,
		"has_docking" = shuttle.docking_controller? 1 : 0,
		"docking_status" = shuttle.docking_controller? shuttle.docking_controller.get_docking_status() : null,
		"docking_override" = shuttle.docking_controller? shuttle.docking_controller.override_enabled : null,
		"can_launch" = shuttle.can_launch(),
		"can_cancel" = shuttle.can_cancel(),
		"can_force" = shuttle.can_force(),
	)

	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)

	if (!ui)
		ui = new(user, src, ui_key, "shuttle_control_console.tmpl", "[shuttle_tag] Shuttle Control", 470, 310)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)
*/
/obj/machinery/computer/new_shuttle_control/Topic(href, href_list)
	if(..())
		return 1

	usr.set_machine(src)
	src.add_fingerprint(usr)

	if (!istype(my_shuttle))
		usr << SPAN_WARN("Shuttle connection lost!")
		return

	if(href_list["select_dock"])
		var/selected = input("Select new target dock", "Target dock") as null|anything in my_shuttle.get_dock_list()
		if(!selected)
			return
		if(in_range(usr,src) && !src.stat)
			my_shuttle.select_dock(selected)

	if(href_list["move"] && my_shuttle.target_dock)
		var/result = my_shuttle.beacon_move(my_shuttle.target_dock)
		if(result)
			usr << SPAN_WARN(result)
	interact(usr)

/*
	if(href_list["move"])
		my_shuttle.launch(src)
	if(href_list["force"])
		my_shuttle.force_launch(src)
	else if(href_list["cancel"])
		my_shuttle.cancel_launch(src)
	updateDialog()
*/
