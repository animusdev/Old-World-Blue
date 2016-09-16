/obj/machinery/computer/order
	name = "supply ordering console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "request"
	circuit = /obj/item/weapon/circuitboard/order
	var/temp = null
	var/head = null
	var/reqtime = 0 //Cooldown for requisitions - Quarxink
	var/last_viewed_group = "categories"
	var/list/menu_items = list("Request items"="order=categories",\
								"View approved orders"="vieworders=1",\
								"View requests"="viewrequests=1")

/obj/machinery/computer/order/supply
	name = "supply control console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "supply"
	light_color = "#b88b2e"
	req_access = list(access_cargo)
	circuit = /obj/item/weapon/circuitboard/order/supply
	var/hacked = 0
	var/can_order_contraband = 0

/obj/machinery/computer/order/supply/qm
	name = "quartermaster control console"
	req_access = list(access_qm, access_cargo)
	circuit = /obj/item/weapon/circuitboard/order/supply/qm
	menu_items = list("Request items"="order=categories",\
								"View approved orders"="vieworders=1",\
								"View requests"="viewrequests=1",\
								"Settings"="settings=1")

/obj/machinery/computer/order/attack_ai(var/mob/user as mob)
	return attack_hand(user)

/obj/machinery/computer/order/attack_hand(var/mob/user as mob)
	if(..())
		return
	user.set_machine(src)
	var/dat
	if(temp)
		dat = head + temp
	else
		var/datum/shuttle/ferry/supply/shuttle = supply_controller.shuttle
		if (shuttle)
			dat += {"<BR><B>Supply shuttle</B><HR>
			Location: [generate_shuttle_info(shuttle)]<BR>
			<HR>Supply points: [supply_controller.points]<BR><BR>"}
		for(var/menu_item in menu_items)
			dat += "<A href='?src=\ref[src];[menu_items[menu_item]]'>[menu_item]</A><BR><BR>"
		dat += "<A href='?src=\ref[user];mach_close=computer'>Close</A>"

	user << browse(dat, "window=computer;size=575x450")
	onclose(user, "computer")
	return

/obj/machinery/computer/order/supply/attack_hand(var/mob/user as mob)
	if(!allowed(user))
		user << "<span class='warning'>Access Denied.</span>"
		return
	post_signal("supply")
	return ..()

/obj/machinery/computer/order/proc/generate_shuttle_info( datum/shuttle/ferry/supply/shuttle )
	if ( shuttle.has_arrive_time() )
		return "Moving to station ([shuttle.eta_minutes()] Mins.)"
	else if ( shuttle.at_station() )
		return "Docked"
	else
		return "Away"

/obj/machinery/computer/order/supply/generate_shuttle_info( datum/shuttle/ferry/supply/shuttle )
	if (shuttle.has_arrive_time())
		return "In transit ([shuttle.eta_minutes()] Mins.)"

	var dat = ""
	if (shuttle.at_station())
		if (shuttle.docking_controller)
			switch(shuttle.docking_controller.get_docking_status())
				if ("docked") 	dat += "Docked at station"
				if ("undocked")	dat += "Undocked from station"
				if ("docking")	dat += "Docking with station"
				if ("undocking")dat += "Undocking from station"
			if ( shuttle.can_force() )
				dat += "<BR><span class='warning'><A href='?src=\ref[src];force_send=1'>Force Launch</A></span>"
		else
			dat += "Station"
		dat += "<BR>"
		if (shuttle.can_launch())
			dat += "<A href='?src=\ref[src];send=1'>Send away</A>"
		else if (shuttle.can_cancel())
			dat += "<A href='?src=\ref[src];cancel_send=1'>Cancel launch</A>"
		else
			dat += "*Shuttle is busy*"
		dat += "<BR>\n<BR>"
	else
		dat += "Away<BR>"
		if (shuttle.can_launch())
			dat += "<A href='?src=\ref[src];send=1'>Request supply shuttle</A>"
		else if (shuttle.can_cancel())
			dat += "<A href='?src=\ref[src];cancel_send=1'>Cancel request</A>"
		else
			dat += "*Shuttle is busy*"
		dat += "<BR>\n"
	return dat

/obj/machinery/computer/order/Topic(href, href_list)
	if(..())
		return 1

	if( isturf(loc) && ( in_range(src, usr) || istype(usr, /mob/living/silicon) ) )
		usr.set_machine(src)

	head = "<BR><b>Supply points: [supply_controller.points]</b><BR>"
	head += "<A href='?src=\ref[src];mainmenu=1'>Main Menu</A><HR><BR>"

	Handle_Topic( href, href_list )

	add_fingerprint(usr)
	updateUsrDialog()
	return

/obj/machinery/computer/order/proc/Handle_Topic( href, href_list )

	if(href_list["order"])
		if(href_list["order"] == "categories")
			last_viewed_group = "categories"
			temp = "<b>Select a category</b><BR><BR>"
			for(var/supply_group_name in all_supply_groups )
				temp += "<A href='?src=\ref[src];order=[supply_group_name]'>[supply_group_name]</A><BR>"
		else
			head = "<BR><b>Supply points: [supply_controller.points]</b><BR>"
			head += "<A href='?src=\ref[src];order=categories'>Back to all categories</A><HR><BR>"
			last_viewed_group = href_list["order"]
			temp = "<b>Request from: [last_viewed_group]</b><BR><BR>"
			for(var/supply_name in supply_controller.supply_packs )
				temp += show_pack(supply_name)

	else if (href_list["doorder"])
		if(world.time < reqtime)
			for(var/mob/V in hearers(src))
				V.show_message("<b>[src]</b>'s monitor flashes, \"[world.time - reqtime] seconds remaining until another requisition form may be printed.\"")
			return

		//Find the correct supply_pack datum
		var/datum/supply_packs/P = supply_controller.supply_packs[href_list["doorder"]]
		if(!istype(P))	return

		var/timeout = world.time + 600
		var/reason = sanitize(copytext(input(usr,"Reason:","Why do you require this item?","") as null|text,1,MAX_MESSAGE_LEN))
		if(world.time > timeout)	return
		if(!reason)	return

		var/idname = "*None Provided*"
		var/idrank = "*None Provided*"
		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			idname = H.get_authentification_name()
			idrank = H.get_assignment()
		else if(issilicon(usr))
			idname = usr.real_name

		supply_controller.ordernum++
		var/obj/item/weapon/paper/reqform = new /obj/item/weapon/paper(loc)
		reqform.name = "Requisition Form - [P.name]"
		reqform.info += "<h3>[station_name] Supply Requisition Form</h3><hr>"
		reqform.info += "INDEX: #[supply_controller.ordernum]<br>"
		reqform.info += "REQUESTED BY: [idname]<br>"
		reqform.info += "RANK: [idrank]<br>"
		reqform.info += "REASON: [reason]<br>"
		reqform.info += "SUPPLY CRATE TYPE: [P.name]<br>"
		reqform.info += "ACCESS RESTRICTION: [get_access_desc(P.access)]<br>"
		reqform.info += "CONTENTS:<br>"
		reqform.info += P.manifest
		reqform.info += "<hr>"
		reqform.info += "STAMP BELOW TO APPROVE THIS REQUISITION:<br>"

		reqform.update_icon()	//Fix for appearing blank when printed.
		reqtime = (world.time + 5) % 1e5

		//make our supply_order datum
		var/datum/supply_order/O = new /datum/supply_order()
		O.ordernum = supply_controller.ordernum
		O.object = P
		O.orderedby = idname
		O.cost = P.cost
		supply_controller.requestlist += O

		if ( istype(src, /obj/machinery/computer/order/supply) )
			temp = "Order request placed.<BR>"
			temp += "<BR><A href='?src=\ref[src];order=[last_viewed_group]'>Back</A> | <A href='?src=\ref[src];mainmenu=1'>Main Menu</A> | <A href='?src=\ref[src];confirmorder=[O.ordernum]'>Authorize Order</A>"
		else
			temp = "Thanks for your request. The cargo team will process it as soon as possible.<BR>"
			temp += "<BR><A href='?src=\ref[src];order=[last_viewed_group]'>Back</A> <A href='?src=\ref[src];mainmenu=1'>Main Menu</A>"

	else if (href_list["vieworders"])
		temp = "<b>Current approved orders: </b><BR><BR>"
		for(var/S in supply_controller.shoppinglist)
			var/datum/supply_order/SO = S
			temp += "#[SO.ordernum] - [SO.object.name] approved by [SO.orderedby][SO.comment ? " ([SO.comment])":""]<BR>"
		temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"

	else if (href_list["viewrequests"])
		temp = "<b>Current requests: </b><BR><BR>"
		for(var/S in supply_controller.requestlist)
			var/datum/supply_order/SO = S
			temp += "#[SO.ordernum] - [SO.object.name] requested by [SO.orderedby]"
		temp += "<BR>"
		temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"

	else if (href_list["mainmenu"])
		temp = null

/obj/machinery/computer/order/supply/Handle_Topic( href, href_list )
	if(!supply_controller)
		world.log << "## ERROR: Eek. The supply_controller controller datum is missing somehow."
		return 1
	var/datum/shuttle/ferry/supply/shuttle = supply_controller.shuttle
	if (!shuttle)
		world.log << "## ERROR: Eek. The supply/shuttle datum is missing somehow."
		return 1

	//Calling the shuttle
	if(href_list["send"])
		if(shuttle.at_station())
			if (shuttle.forbidden_atoms_check())
				temp = "For safety reasons the automated supply shuttle cannot transport live organisms, classified nuclear weaponry or homing beacons.<BR><BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"
			else
				shuttle.launch(src)
				temp = "Initiating launch sequence. \[<span class='warning'><A href='?src=\ref[src];force_send=1'>Force Launch</A></span>\]<BR><BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"
		else
			shuttle.launch(src)
			temp = "The supply shuttle has been called and will arrive in approximately [round(supply_controller.movetime/600,1)] minutes.<BR><BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"
			post_signal("supply")

	else if (href_list["force_send"])
		shuttle.force_launch(src)

	else if (href_list["cancel_send"])
		shuttle.cancel_launch(src)

	else if (href_list["viewrequests"])
		last_viewed_group = ""
		temp = "<style>span.cost{padding-left: 50px;}</style>"
		temp += "<b>Current requests: </b><BR><BR>"
		for(var/S in supply_controller.requestlist)
			var/datum/supply_order/SO = S
			temp += "#[SO.ordernum] - [SO.object.name] requested by [SO.orderedby].<BR>"
			temp += "<span class='cost'>Cost: [SO.cost] supply points. <A href='?src=\ref[src];confirmorder=[SO.ordernum]'>Approve</A> <A href='?src=\ref[src];rreq=[SO.ordernum]'>Remove</A><BR></span>"
		temp += "<BR><A href='?src=\ref[src];clearreq=1'>Clear list</A>"
		temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"

	else if(href_list["confirmorder"])
		//Find the correct supply_order datum
		var/ordernum = text2num(href_list["confirmorder"])
		var/datum/supply_order/O
		var/datum/supply_packs/P
		temp = "Invalid Request"
		for(var/i=1, i<=supply_controller.requestlist.len, i++)
			var/datum/supply_order/SO = supply_controller.requestlist[i]
			if(SO.ordernum == ordernum)
				O = SO
				P = O.object
				if(supply_controller.points >= P.cost)
					supply_controller.requestlist.Cut(i,i+1)
					supply_controller.points -= P.cost
					supply_controller.shoppinglist += O
					temp = "Thanks for your order.<BR>"
				else
					temp = "Not enough supply points.<BR>"
				temp += "<BR><A href='?src=\ref[src];[last_viewed_group?"order=[last_viewed_group]":"viewrequests=1"]'>Back</A> <A href='?src=\ref[src];mainmenu=1'>Main Menu</A>"
				break

	else if (href_list["rreq"])
		var/ordernum = text2num(href_list["rreq"])
		temp = "Invalid Request.<BR>"
		for(var/i=1, i<=supply_controller.requestlist.len, i++)
			var/datum/supply_order/SO = supply_controller.requestlist[i]
			if(SO.ordernum == ordernum)
				supply_controller.requestlist.Cut(i,i+1)
				temp = "Request removed.<BR>"
				break
		temp += "<BR><A href='?src=\ref[src];viewrequests=1'>Back</A> <A href='?src=\ref[src];mainmenu=1'>Main Menu</A>"

	else if (href_list["clearreq"])
		supply_controller.requestlist.Cut()
		temp = "List cleared.<BR>"
		temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"
	else
		..(href, href_list)

/obj/machinery/computer/order/supply/qm/Handle_Topic( href, href_list )
	if (href_list["settings"])
		temp = "<b>Current settings: </b><BR><BR>"
		temp += "Toggle custom packs: OFF<BR>"
		temp += "Toggle pricing: OFF<BR>"
		temp += "Toggle cargo technican access: OFF<BR>"
	else
		..( href, href_list )

/obj/machinery/computer/order/proc/show_pack( var/supply_name )
	var/datum/supply_packs/SP = supply_controller.supply_packs[supply_name]
	if(SP.hidden || SP.contraband || SP.group != src.last_viewed_group) return ""
	return "<A href='?src=\ref[src];doorder=[supply_name]'>[supply_name]</A> Cost: [SP.cost]<BR>"

/obj/machinery/computer/order/supply/show_pack( var/supply_name )
	var/datum/supply_packs/SP = supply_controller.supply_packs[supply_name]
	if((SP.hidden && !hacked) || (SP.contraband && !can_order_contraband) || SP.group != last_viewed_group) return
	temp += "<A href='?src=\ref[src];doorder=[supply_name]'>[supply_name]</A> Cost: [SP.cost]<BR>"

/obj/machinery/computer/order/supply/attackby(I as obj, user as mob)
	if(istype(I,/obj/item/weapon/card/emag) && !hacked)
		user << "\blue Special supplies unlocked."
		hacked = 1
		return
	else
		..()
	return

/obj/machinery/computer/order/supply/proc/post_signal(var/command)

	var/datum/radio_frequency/frequency = radio_controller.return_frequency(1435)

	if(!frequency) return

	var/datum/signal/status_signal = new
	status_signal.source = src
	status_signal.transmission_method = 1
	status_signal.data["command"] = command

	frequency.post_signal(src, status_signal)
