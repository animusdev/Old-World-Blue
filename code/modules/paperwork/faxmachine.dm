var/list/admin_departments = list("Central Command", "Sol Government")
var/list/alldepartments = list()

var/list/adminfaxes = list()	//cache for faxes that have been sent to admins


/obj/item/weapon/circuitboard/fax
	name = T_BOARD("fax macine")
	origin_tech = list(TECH_DATA = 2)
	build_path = /obj/machinery/photocopier/faxmachine
	board_type = "machine"
	var/department = ""
	req_components = list(
		/obj/item/stack/cable_coil = 4,
		/obj/item/weapon/stock_parts/manipulator = 1)

/obj/item/weapon/circuitboard/fax/command
	name = T_BOARD("command fax macine")
	build_path = /obj/machinery/photocopier/faxmachine/command
	origin_tech = list(TECH_DATA = 3)
	req_components = list(
		/obj/item/stack/cable_coil = 4,
		/obj/item/weapon/stock_parts/manipulator = 1,
		/obj/item/weapon/stock_parts/subspace/filter = 1
		)

/obj/item/weapon/circuitboard/fax/construct(var/obj/machinery/photocopier/faxmachine/M)
	if(..())
		M.department = department
		registrate_fax_department(department, M)
		return 1
	return 0

/obj/item/weapon/circuitboard/fax/deconstruct(var/obj/machinery/photocopier/faxmachine/M)
	if(..())
		department = M.department
		drop_fax_department(department)
		return 1
	return 0

/obj/item/weapon/circuitboard/fax/attack_self(mob/living/user)
	var/new_dep = input("Choose a new department", "New Department", department) as null|text
	if(user.get_active_hand() == src || user.get_inactive_hand() == src)
		department = new_dep

/proc/registrate_fax_department(var/department, var/obj/machinery/photocopier/faxmachine/FM)
	if(!department)
		return null

	FM.department = null

	if(!alldepartments[department])
		alldepartments[department] = FM
		FM.department = department
		return 1
	else
		for(var/i = 1 to 10)
			var/tmp_dep = "[department] #[i]"
			if(!alldepartments[tmp_dep])
				alldepartments[tmp_dep] = FM
				FM.department = tmp_dep
				return 1

	return null

/proc/drop_fax_department(var/department)
	alldepartments -= department
	return 1


/obj/machinery/photocopier/faxmachine
	name = "fax machine"
	icon = 'icons/obj/library.dmi'
	icon_state = "fax"
	insert_anim = "faxsend"
	circuit = /obj/item/weapon/circuitboard/fax

	use_power = 1
	idle_power_usage = 30
	active_power_usage = 200
	density = 0

	var/obj/item/weapon/card/id/scan = null // identification
	var/authenticated = 0
	var/sendcooldown = 0 // to avoid spamming fax messages

	var/department = "" // our department

	var/destination = "Vacant office" // the department we're sending to
	var/command = 0

	pass_flags = PASSTABLE


/obj/machinery/photocopier/faxmachine/command
	name = "command fax machine"
	destination = "Central Command"
	command = 1
	circuit = /obj/item/weapon/circuitboard/fax/command
	req_one_access = list(access_lawyer, access_heads, access_armory) //Warden needs to be able to Fax solgov too.


/obj/machinery/photocopier/faxmachine/New(new_loc, new_department)
	..(new_loc)
	if(new_department && istext(new_department))
		department = new_department
	if(department)
		department = registrate_fax_department(department, src)

/obj/machinery/photocopier/faxmachine/Destroy()
	drop_fax_department(department)
	return ..()

/obj/machinery/photocopier/faxmachine/attackby(obj/item/O as obj, mob/user as mob)
	if(default_deconstruction_screwdriver(user, O))
		return 1
	else if(default_deconstruction_crowbar(user, O))
		return 1
	else
		return ..()

/obj/machinery/photocopier/faxmachine/dismantle()
	if(scan)
		scan.forceMove(src.loc)
		scan = null
	if(copyitem)
		copyitem.forceMove(src.loc)
		copyitem = null
	..()


/obj/machinery/photocopier/faxmachine/attack_hand(mob/user as mob)
	user.set_machine(src)

	var/dat = "Fax Machine<BR>"

	var/scan_name
	if(scan)
		scan_name = scan.name
	else
		scan_name = "--------"

	dat += "Confirm Identity: <a href='byond://?src=\ref[src];scan=1'>[scan_name]</a><br>"

	if(!department)
		if(copyitem)
			dat += "<a href='byond://?src=\ref[src];remove=1'>Remove Item</a><br><br>"
		dat += "Department is not setted yet! <a href='byond://?src=\ref[src];department=set'>Set</a><br>"

	else
		if(authenticated)
			dat += "<a href='byond://?src=\ref[src];logout=1'>{Log Out}</a>"
		else
			dat += "<a href='byond://?src=\ref[src];auth=1'>{Log In}</a>"

		dat += "<hr>"

		if(authenticated)
			dat += "<b>Logged in to:</b> Central Command Quantum Entanglement Network<br><br>"

			if(copyitem)
				dat += "<a href='byond://?src=\ref[src];remove=1'>Remove Item</a><br><br>"

				if(sendcooldown)
					dat += "<b>Transmitter arrays realigning. Please stand by.</b><br>"

				else
					dat += "<a href='byond://?src=\ref[src];send=1'>Send</a><br>"
					dat += "<b>Currently sending:</b> [copyitem.name]<br>"
					dat += "<b>Sending to:</b> <a href='byond://?src=\ref[src];dept=1'>[destination]</a><br>"

			else
				if(sendcooldown)
					dat += "Please insert paper to send via secure connection.<br><br>"
					dat += "<b>Transmitter arrays realigning. Please stand by.</b><br>"
				else
					dat += "Please insert paper to send via secure connection.<br><br>"

		else
			dat += "Proper authentication is required to use this device.<br><br>"

			if(copyitem)
				dat += "<a href ='byond://?src=\ref[src];remove=1'>Remove Item</a><br>"

	user << browse(dat, "window=copier")
	onclose(user, "copier")
	return

/obj/machinery/photocopier/faxmachine/Topic(href, href_list)
	if(href_list["department"])
		if(department)
			return 0
		var/new_dep = input("Choose a new department", "New Department", department) as null|text
		if(Adjacent(usr))
			department = new_dep
			registrate_fax_department(department, src)
	else
		if(!department)
			usr << "<span class='warning'>Department setting is incorrect! Need rebuild.</span>"
			return 0
		if(href_list["send"])
			if(copyitem)
				sendfax(destination, usr)
				if (sendcooldown)
					spawn(sendcooldown) // cooldown time
						sendcooldown = 0

		else if(href_list["remove"])
			if(copyitem)
				copyitem.loc = usr.loc
				usr.put_in_hands(copyitem)
				usr << "<span class='notice'>You take \the [copyitem] out of \the [src].</span>"
				copyitem = null
				updateUsrDialog()

		if(href_list["scan"])
			if (scan)
				usr.put_in_hands(scan)
				scan.forceMove(loc)
				scan = null
			else
				var/obj/item/I = usr.get_active_hand()
				if (istype(I, /obj/item/weapon/card/id))
					usr.drop_from_inventory(I, src)
					scan = I
			authenticated = 0

		if(href_list["dept"])
			var/lastdestination = destination
			destination = input(usr, "Which department?", "Choose a department", "") as null|anything in command ? alldepartments : (alldepartments - admin_departments)
			if(!destination) destination = lastdestination

		if(href_list["auth"])
			if (!authenticated && scan)
				if (check_access(scan))
					authenticated = 1

		if(href_list["logout"])
			authenticated = 0

	updateUsrDialog()


/obj/machinery/photocopier/faxmachine/proc/sendfax(var/destination, var/mob/living/user)
	if(stat & (BROKEN|NOPOWER))
		return

	use_power(200)

	var/success = 0
	if(destination in admin_departments)
		success = adminfax(copyitem, department, user)

	var/obj/machinery/photocopier/faxmachine/F = alldepartments[destination]
	success |= F && F.recievefax(copyitem)

	if (success)
		visible_message("[src] beeps, \"Message transmitted successfully.\"")
		if(success > 1)
			sendcooldown = 1800
	else
		visible_message("[src] beeps, \"Error transmitting message.\"")


/obj/machinery/photocopier/faxmachine/proc/recievefax(var/obj/item/incoming)
	if(stat & (BROKEN|NOPOWER))
		return 0

	flick("faxreceive", src)
	playsound(loc, "sound/items/polaroid1.ogg", 50, 1)

	// give the sprite some time to flick
	sleep(20)

	if (istype(incoming, /obj/item/weapon/paper))
		copy(incoming)
	else if (istype(incoming, /obj/item/weapon/photo))
		photocopy(incoming)
	else if (istype(incoming, /obj/item/weapon/paper_bundle))
		bundlecopy(incoming)
	else
		return 0

	use_power(active_power_usage)
	return 1


/obj/machinery/photocopier/faxmachine/proc/adminfax(var/obj/item/incoming, var/from, var/mob/sender)
	var/obj/item/weapon/rcvdcopy = null
	if (istype(incoming, /obj/item/weapon/paper))
		rcvdcopy = copy(incoming)
	else if (istype(incoming, /obj/item/weapon/photo))
		rcvdcopy = photocopy(incoming)
	else if (istype(incoming, /obj/item/weapon/paper_bundle))
		rcvdcopy = bundlecopy(incoming, 0)
	else
		return 0

	adminfaxes += rcvdcopy
	//message badmins that a fax has arrived
	switch(destination)
		if ("Central Command")
			message_admins(sender, "CENTCOMM FAX", rcvdcopy, "CentcommFaxReply", "#006100")
		if ("Sol Government")
			message_admins(sender, "SOL GOVERNMENT FAX", rcvdcopy, "CentcommFaxReply", "#1F66A0")
	return 2


/obj/machinery/photocopier/faxmachine/proc/message_admins(var/mob/sender, var/faxname, var/obj/item/sent, var/reply_type, font_colour="#006100")
	var/msg = "\blue <b><font color='[font_colour]'>[faxname]: </font>[key_name(sender, 1)] (<A HREF='?_src_=holder;adminplayeropts=\ref[sender]'>PP</A>) (<A HREF='?_src_=vars;Vars=\ref[sender]'>VV</A>) (<A HREF='?_src_=holder;subtlemessage=\ref[sender]'>SM</A>) (<A HREF='?_src_=holder;adminplayerobservejump=\ref[sender]'>JMP</A>) (<A HREF='?_src_=holder;secretsadmin=check_antagonist'>CA</A>) (<a href='?_src_=holder;[reply_type]=\ref[sender];originfax=\ref[src]'>REPLY</a>)</b>: Receiving '[sent.name]' via secure connection ... <a href='?_src_=holder;AdminFaxView=\ref[sent]'>view message</a>"

	for(var/client/C in admins)
		if(R_ADMIN & C.holder.rights)
			C << msg
