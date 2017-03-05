/obj/machinery/computer/order
	name = "supply ordering console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "request"
	circuit = /obj/item/weapon/circuitboard/order
	var/datum/shuttle/ferry/supply/shuttle
	var/temp = null
	var/head = null
	var/reqtime = 0 //Cooldown for requisitions - Quarxink
	var/last_viewed_group = "categories"

/obj/machinery/computer/order/supply
	name = "supply control console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "supply"
	light_color = "#b88b2e"
	req_access = list(access_cargo)
	circuit = /obj/item/weapon/circuitboard/order/supply
	var/hacked = 0
	var/can_order_contraband = 0

/obj/machinery/computer/order/attack_ai(var/mob/user as mob)
	return attack_hand(user)

/obj/machinery/computer/order/attack_hand(var/mob/user as mob)
	if(..())
		return
	user.set_machine(src)
	update_head()
	if(!temp)
		Handle_Topic(list("viewrequests"=1))

	user << browse(head + temp, "window=computer;size=575x450")
	onclose(user, "computer")
	return

/obj/machinery/computer/order/supply/attack_hand(var/mob/user as mob)
	if(!allowed(user))
		user << "<span class='warning'>Access Denied.</span>"
		return
	post_signal("supply")
	return ..()

/obj/machinery/computer/order/proc/update_head()
	head = "<b>Supply points:</b> [supply_controller.points]"
	if(!shuttle && supply_controller)
		shuttle = supply_controller.shuttle
	if (shuttle)
		head += "<br><b>Supply shuttle</b>:"
		if(shuttle.has_arrive_time())
			head += "Moving to station ([shuttle.eta_minutes()] Mins.)"
		else if(shuttle.at_station())
			head += "Docked"
		else
			head += "Away"

	head += {"<hr>
		<A href='?src=\ref[src];order=categories'>Categories</A> |
		<A href='?src=\ref[src];viewrequests=1'>View request</A> |
		<A href='?src=\ref[src];vieworders=1'>View orders</A>
		<hr><br>"}


/obj/machinery/computer/order/supply/update_head()
	head = "<b>Supply points:</b> [supply_controller.points]"
	if(!shuttle && supply_controller)
		shuttle = supply_controller.shuttle
	if(shuttle)
		head += "<br><b>Supply shuttle</b>: "
		if(shuttle.has_arrive_time())
			head += "In transit ([shuttle.eta_minutes()] Mins.)"
		else
			if(shuttle.at_station())
				if (shuttle.docking_controller)
					switch(shuttle.docking_controller.get_docking_status())
						if("docked") 	head += "Docked at station"
						if("undocked")	head += "Undocked from station"
						if("docking")	head += "Docking with station"
						if("undocking")	head += "Undocking from station"
				else
					head += "Station"
				head += "<br>"
				if (shuttle.can_launch())
					head += "<A href='?src=\ref[src];send=1'>Send away</A>"
				else if (shuttle.can_cancel())
					head += "<A href='?src=\ref[src];cancel_send=1'>Cancel request</A>"
				else
					head += "*Shuttle is busy*"

			else
				head += "Away<br>"
				if (shuttle.can_launch())
					head += "<A href='?src=\ref[src];send=1'>Request supply shuttle</A>"
				else if (shuttle.can_cancel())
					head += "<A href='?src=\ref[src];cancel_send=1'>Cancel request</A>"
				else
					head += "*Shuttle is busy*"

	head += {"<hr>
		<A href='?src=\ref[src];order=categories'>Categories</A> |
		<A href='?src=\ref[src];viewrequests=1'>View request</A> |
		<A href='?src=\ref[src];vieworders=1'>View orders</A>
		<hr><br>"}


/obj/machinery/computer/order/Topic(href, href_list)
	if(..())
		return 1

/*
	if(in_range(src, usr) || issilicon(usr))
		usr.set_machine(src)
*/

	update_head()

	Handle_Topic(href_list )

	add_fingerprint(usr)
	updateUsrDialog()
	return

/obj/machinery/computer/order/proc/Handle_Topic( href_list )

	if(href_list["order"])
		if(href_list["order"] == "categories")
			last_viewed_group = "categories"
			temp = "<b>Select a category</b><BR><BR>"
			for(var/supply_group_name in all_supply_groups )
				temp += "<A href='?src=\ref[src];order=[supply_group_name]'>[supply_group_name]</A><BR>"
		else
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
		var/reason = cp1251_to_utf8( sanitize(input(usr,"Reason:","Why do you require this item?","") as null|text,MAX_MESSAGE_LEN,1) )
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
		supply_controller.requestlist += O

		if ( istype(src, /obj/machinery/computer/order/supply) )
			temp = "Order request placed.<BR>"
			temp +="<BR><A href='?src=\ref[src];order=[last_viewed_group]'>Back</A> |\
				 	<A href='?src=\ref[src];confirmorder=[O.ordernum]'>Authorize Order</A> |\
				 	<A href='?src=\ref[src];order=categories'>All categories</A>"
		else
			temp = "Thanks for your request. The cargo team will process it as soon as possible.<BR>"
			temp +="<BR><A href='?src=\ref[src];order=[last_viewed_group]'>Back</A> | \
					<A href='?src=\ref[src];order=categories'>All categories</A>"

	else if (href_list["vieworders"])
		temp = "<b>Current approved orders: </b><BR><BR>"
		for(var/S in supply_controller.shoppinglist)
			var/datum/supply_order/SO = S
			temp += "#[SO.ordernum] - [SO.object.name] approved by [SO.orderedby][SO.comment ? " ([SO.comment])":""]<BR>"

	else if (href_list["viewrequests"])
		temp = "<b>Current requests: </b><BR><BR>"
		for(var/S in supply_controller.requestlist)
			var/datum/supply_order/SO = S
			temp += "#[SO.ordernum] - [SO.object.name] requested by [SO.orderedby]<BR>"


/obj/machinery/computer/order/supply/Handle_Topic( href_list )
	//Calling the shuttle
	if(href_list["send"])
		if(shuttle.at_station())
			if (shuttle.forbidden_atoms_check())
				temp = "For safety reasons the automated supply shuttle cannot transport live organisms, classified nuclear weaponry or homing beacons."
			else
				shuttle.launch(src)
		else
			shuttle.launch(src)
			post_signal("supply")

	else if (href_list["cancel_send"])
		shuttle.cancel_launch(src)

	else if (href_list["viewrequests"])
		last_viewed_group = ""
		temp = "<style>span.cost{padding-left: 50px;}</style>"
		temp += "<b>Current requests: </b><BR><BR>"
		for(var/S in supply_controller.requestlist)
			var/datum/supply_order/SO = S
			temp += "#[SO.ordernum] - [SO.object.name] requested by [SO.orderedby].<BR>"
			temp += "<span class='cost'>Cost: [SO.object.cost] supply points. \
					<A href='?src=\ref[src];confirmorder=[SO.ordernum]'>\[Approve]</A> \
					<A href='?src=\ref[src];rreq=[SO.ordernum]'>\[Remove]</A><BR></span>"
		temp += "<BR><A href='?src=\ref[src];clearreq=1'>Clear list</A>"

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
				temp += "<BR><A href='?src=\ref[src];[last_viewed_group?"order=[last_viewed_group]":"viewrequests=1"]'>Back</A>"
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
		temp += "<BR><A href='?src=\ref[src];viewrequests=1'>Back</A>"

	else if (href_list["clearreq"])
		supply_controller.requestlist.Cut()
	else
		..(href_list)


/obj/machinery/computer/order/proc/show_pack( var/supply_name )
	var/datum/supply_packs/SP = supply_controller.supply_packs[supply_name]
	if(SP.hidden || SP.contraband || SP.group != src.last_viewed_group) return ""
	return "<A href='?src=\ref[src];doorder=[supply_name]'>[supply_name]</A> Cost: [SP.cost]<BR>"

/obj/machinery/computer/order/supply/show_pack( var/supply_name )
	var/datum/supply_packs/SP = supply_controller.supply_packs[supply_name]
	if((SP.hidden && !hacked) || (SP.contraband && !can_order_contraband) || SP.group != last_viewed_group) return
	temp += "<A href='?src=\ref[src];doorder=[supply_name]'>[supply_name]</A> Cost: [SP.cost]<BR>"

/obj/machinery/computer/order/supply/emag_act(var/remaining_charges, var/mob/user)
	if(!hacked)
		user << "<span class='notice'>Special supplies unlocked.</span>"
		hacked = 1
		return 1

/obj/machinery/computer/order/supply/proc/post_signal(var/command)

	var/datum/radio_frequency/frequency = radio_controller.return_frequency(1435)

	if(!frequency) return

	var/datum/signal/status_signal = new
	status_signal.source = src
	status_signal.transmission_method = 1
	status_signal.data["command"] = command

	frequency.post_signal(src, status_signal)
