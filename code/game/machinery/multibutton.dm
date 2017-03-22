/*

	Button modes
		0: airlock
		1: blastdoor
		2: emmiter
		3: massdriver
		4: flasher
		5: igniter

	Airlock control bitflags
		1= open
		2= idscan,
		4= bolts
		8= shock
		16= door safties

	To add button, add this to controls	list
	list(
		"name" = "button name",
		"id" = "id",
		"mode" = button mode,
		"airmode" = airlock control node (optional)
	),

*/

/obj/machinery/button/remote/multibutton
	name = "remote object control"
	desc = "It controls several objects, remotely."
	icon_state = "mbutton0"

	var/controls = list()

/obj/machinery/button/remote/multibutton/attack_hand(mob/user as mob)
	//if(..())
	//	return

	add_fingerprint(user)

	ui_interact(user)

/obj/machinery/button/remote/multibutton/update_icon()
	if(stat & NOPOWER)
		icon_state = "mbutton-p"
	else
		icon_state = "mbutton0"

/obj/machinery/button/remote/multibutton/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)

	if(!controls)
		return

	var/data = controls
	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		// the ui does not exist, so we'll create a new() one
        // for a list of parameters and their descriptions see the code docs in \code\modules\nano\nanoui.dm
		ui = new(user, src, ui_key, "multibutton.tmpl", "[src.name]", 400, 300)
		// when the ui is first opened this is the data it will use
		ui.set_initial_data(data)
		// open the new ui window
		ui.open()

/obj/machinery/button/remote/multibutton/Topic(href, href_list)
	if(..())
		return 1

	if(!in_range(src,usr) && !issilicon(usr))
		return 1

	if(stat & (NOPOWER|BROKEN))
		return 1

	if(!allowed(usr) && (wires & 1))
		usr << "<span class='warning'>Access Denied</span>"
		flick("mbutton-deny",src)
		return 1

	use_power(5)

	if(!href_list || !href_list["mode"] || !href_list["id"])
		return 1

	icon_state = "mbutton1"

	var/mode = text2num(href_list["mode"])

	if(mode == 0)
		if(!href_list["airmode"])
			airlock(href_list["id"])
		else
			airlock(href_list["id"],text2num(href_list["airmode"]))
	else if(mode == 1)
		blastdoor(href_list["id"])
	else if(mode == 2)
		emitter(href_list["id"])
	else if(mode == 3)
		massdriver(href_list["id"])
	else if(mode == 4)
		flasher(href_list["id"])
	else if(mode == 5)
		igniter(href_list["id"])


	spawn(15)
		update_icon()

//	Airlock remote control

// Bitmasks for door switches.
#define OPEN   0x1
#define IDSCAN 0x2
#define BOLTS  0x4
#define SHOCK  0x8
#define SAFE   0x10

/obj/machinery/button/remote/multibutton/proc/airlock(var/cid, var/mode = 1)
	for(var/obj/machinery/door/airlock/D in world)
		if(D.id_tag == cid)
			if(mode & OPEN)
				if(D.density)
					spawn(0)
						D.open()
						return
				else
					spawn(0)
						D.close()
						return
			if(mode & IDSCAN)
				if(!D.aiDisabledIdScanner)
					D.set_idscan(0)
				else
					D.set_idscan(1)
			if(mode & BOLTS)
				if(!D.locked)
					D.lock()
				else
					D.unlock()
			if(mode & SHOCK)
				if(D.electrified_until > 0)
					D.electrify(-1)
				else
					D.electrify(0)
			if(mode & SAFE)
				if(D.safe)
					D.set_safeties(0)
				else
					D.set_safeties(1)

#undef OPEN
#undef IDSCAN
#undef BOLTS
#undef SHOCK
#undef SAFE

//	Blast door remote control

/obj/machinery/button/remote/multibutton/proc/blastdoor(var/cid)
	for(var/obj/machinery/door/blast/M in world)
		if(M.id == cid)
			if(M.density)
				spawn(0)
					M.open()
					return
			else
				spawn(0)
					M.close()
					return


//	Emitter remote control

/obj/machinery/button/remote/multibutton/proc/emitter(var/cid)
	for(var/obj/machinery/power/emitter/E in world)
		if(E.id == cid)
			spawn(0)
				if(E.active)
					E.active = 0
				else
					E.active = 1
					E.shot_number = 0
					E.fire_delay = 100
				E.update_icon()
				return

//	Mass driver remote control

/obj/machinery/button/remote/multibutton/proc/massdriver(var/cid)
	active = 1
	update_icon()

	for(var/obj/machinery/door/blast/M in machines)
		if(M.id == cid)
			spawn(0)
				M.open()
				return

	sleep(20)

	for(var/obj/machinery/mass_driver/M in machines)
		if(M.id == cid)
			M.drive()

	sleep(50)

	for(var/obj/machinery/door/blast/M in machines)
		if(M.id == cid)
			spawn(0)
				M.close()
				return
	return

/obj/machinery/button/remote/multibutton/proc/flasher(var/cid)
	for(var/obj/machinery/flasher/M in machines)
		if(M.id == cid)
			spawn()
				M.flash()

/obj/machinery/button/remote/multibutton/proc/igniter(var/cid)
	for(var/obj/machinery/sparker/M in machines)
		if (M.id == cid)
			spawn()
				M.ignite()

	for(var/obj/machinery/igniter/M in machines)
		if(M.id == cid)
			use_power(50)
			M.on = !(M.on)
			M.icon_state = text("igniter[]", M.on)


//////////////////////////////////////////////////


/obj/machinery/button/remote/multibutton/cmo
	name = "Medbay Control"
	controls = list(
	list(
		"name" = "Medbay Quarantine Shutters Control",
		"id" = "medbayquar",
		"mode" = 1
	),
	list(
		"name" = "Virology Quarantine Shutters Control",
		"id" = "virologyout",
		"mode" = 1
	),
	list(
		"name" = "CMO Office Door Control",
		"id" = "cmodoor",
		"mode" = 0,
		"airmode" = 1
	),
	list(
		"name" = "CMO Office Privacy Shutters",
		"id" = "cmooffice",
		"mode" = 1
	),
	)
	req_access = list(5)

/obj/machinery/button/remote/multibutton/hos
	name = "Brig Control"
	controls = list(
	list(
		"name" = "HoS Office Door Control",
		"id" = "HoSdoor",
		"mode" = 0,
		"airmode" = 1
	),
	list(
		"name" = "Prison Lockdown",
		"id" = "Secure Gate",
		"mode" = 1
	),
	)
	req_access = list(2)

/obj/machinery/button/remote/multibutton/rd
	name = "Research Division Control"
	controls = list(
	list(
		"name" = "RD Office Door Control",
		"id" = "rddoor",
		"mode" = 0,
		"airmode" = 1
	),
	list(
		"name" = "Biohazard Shutters",
		"id" = "Biohazard",
		"mode" = 1
	),
	list(
		"name" = "Research Division Door Control",
		"id" = "researchdoor",
		"mode" = 0,
		"airmode" = 1
	),
	)
	req_access = list(30)

/obj/machinery/button/remote/multibutton/ce
	name = "Engineering Control"
	controls = list(
	list(
		"name" = "CE Office Door Control",
		"id" = "cedoor",
		"mode" = 0,
		"airmode" = 1
	),
	list(
		"name" = "Engine Access Hatch",
		"id" = "engine_access_hatch",
		"mode" = 0,
		"airmode" = 4
	),
	list(
		"name" = "Engine Ventillatory Control",
		"id" = "EngineVent",
		"mode" = 1
	),
	)
	req_access = list(11)

/obj/machinery/button/remote/multibutton/engine
	name = "Engine Control"
	controls = list(
	list(
		"name" = "Engine Monitoring Blast Doors",
		"id" = "EngineBlast",
		"mode" = 1,
	),
	list(
		"name" = "Reactor Blast Doors",
		"id" = "SupermatterPort",
		"mode" = 1,
	),
	list(
		"name" = "Engine Emitter",
		"id" = "EngineEmitter",
		"mode" = 2
	),
	)
	req_access = list(11)

/obj/machinery/button/remote/multibutton/prison
	name = "Prison Control"
	controls = list(
	list(
		"name" = "Exit Prison Door",
		"id" = "prisonexit",
		"mode" = 0,
		"airmode" = 1
	),
	list(
		"name" = "Entry Prison Door",
		"id" = "prisonentry",
		"mode" = 0,
		"airmode" = 1
	),
	list(
		"name" = "Prison Lockdown",
		"id" = "Secure Gate",
		"mode" = 1
	),
	list(
		"name" = "Prison Observation Shutters",
		"id" = "brigobs",
		"mode" = 1
	),
	list(
		"name" = "Entry Flash",
		"id" = "permentryflash",
		"mode" = 4
	),
	list(
		"name" = "Prison Flash",
		"id" = "permflash",
		"mode" = 4
	),
	)
	req_access = list(2)

/*
/obj/machinery/button/remote/multibutton/test
	controls = list(
	list(
		"name" = "test1a",
		"id" = "mbt1",
		"mode" = 0,
		"airmode" = 1
	),
	list(
		"name" = "test2a",
		"id" = "mbt2",
		"mode" = 0,
		"airmode" = 4
	),
	list(
		"name" = "test3b",
		"id" = "mbt3",
		"mode" = 1
	),
	list(
		"name" = "test4e",
		"id" = "mbt4",
		"mode" = 2
	),
	list(
		"name" = "test5m",
		"id" = "mbt5",
		"mode" = 3
	)
	)
	*/

