/////////////////////////////
///// Part Fabricator ///////
/////////////////////////////

/obj/machinery/mecha_part_fabricator
	icon = 'icons/obj/robotics.dmi'
	icon_state = "fab-idle"
	name = "Exosuit Fabricator"
	desc = "Nothing is being built."
	density = 1
	anchored = 1
	use_power = 1
	idle_power_usage = 20
	active_power_usage = 5000
	circuit = /obj/item/weapon/circuitboard/mechfab
	req_access = list(access_robotics)
	var/time_coeff = 1.5 //can be upgraded with research
	var/resource_coeff = 1.5 //can be upgraded with research
	var/list/resources = list(
		DEFAULT_WALL_MATERIAL=0,
		"glass"=0,
		"gold"=0,
		"silver"=0,
		"diamond"=0,
		"phoron"=0,
		"uranium"=0,
		"plasteel"=0
	)

	var/res_max_amount = 200000
	var/datum/research/files
	var/id
	var/sync = 0
	var/part_set
	var/obj/being_built
	var/list/queue = list()
	var/processing_queue = 0
	var/temp
	var/output_dir = SOUTH	//the direction relative to the fabber at which completed parts appear.
	var/list/categories = list()
	var/category = null


/obj/machinery/mecha_part_fabricator/New()
	..()
	files = new /datum/research(src) //Setup the research data holder.
	update_categories()
	return

/obj/machinery/mecha_part_fabricator/RefreshParts()
	var/T = 0
	for(var/obj/item/weapon/stock_parts/matter_bin/M in component_parts)
		T += M.rating
	res_max_amount = (187500+(T * 37500))

	T = 0
	for(var/obj/item/weapon/stock_parts/micro_laser/Ma in component_parts)
		T += Ma.rating
	if(T >= 1)
		T -= 1
	var/diff
	diff = round(initial(resource_coeff) - (initial(resource_coeff)*(T))/25,0.01)
	if(resource_coeff!=diff)
		resource_coeff = diff

	T = 0
	for(var/obj/item/weapon/stock_parts/manipulator/Ml in component_parts)
		T += Ml.rating
	if(T>= 1)
		T -= 1
	diff = round(initial(time_coeff) - (initial(time_coeff)*(T))/25,0.01)
	if(time_coeff!=diff)
		time_coeff = diff

/obj/machinery/mecha_part_fabricator/proc/update_categories()
	for(var/datum/design/D in files.known_designs)
		if(!D.build_path || !(D.build_type & MECHFAB))
			continue
		categories |= D.category
	if(!(category in categories))
		category = null

/obj/machinery/mecha_part_fabricator/emag_act(var/remaining_charges, var/mob/user)
	switch(emagged)
		if(0)
			emagged = 0.5
			visible_message("\icon[src] <b>[src]</b> beeps: \"DB error \[Code 0x00F1\]\"")
			sleep(10)
			visible_message("\icon[src] <b>[src]</b> beeps: \"Attempting auto-repair\"")
			sleep(15)
			visible_message("\icon[src] <b>[src]</b> beeps: \"User DB corrupted \[Code 0x00FA\]. Truncating data structure...\"")
			sleep(30)
			visible_message("\icon[src] <b>[src]</b> beeps: \"User DB truncated. Please contact your Nanotrasen system operator for future assistance.\"")
			req_access = null
			emagged = 1
			return 1
		if(0.5)
			visible_message("\icon[src] <b>[src]</b> beeps: \"DB not responding \[Code 0x0003\]...\"")
		if(1)
			visible_message("\icon[src] <b>[src]</b> beeps: \"No records in User DB\"")

/obj/machinery/mecha_part_fabricator/proc/output_parts_list(var/category)
	if(!category in categories)
		return

	var/output = ""
	for(var/datum/design/D in files.known_designs)
		if(D.build_path && (D.build_type & MECHFAB) && D.category == category)
			output += "<div class='part'>[output_part_info(D)]<br>\["
			if(check_resources(D))
				output += "<a href='?src=\ref[src];build=[D.id]'>Build</a> | "
			output += "<a href='?src=\ref[src];add_to_queue=[D.id]'>Add to queue</a>\]\[<a href='?src=\ref[src];part_desc=[D.id]'>?</a>\]</div>"
	return output

/obj/machinery/mecha_part_fabricator/proc/output_part_info(var/datum/design/D)
	return "[D.name] (Cost: [output_part_cost(D)]) [get_construction_time_w_coeff(D)] sec"

/obj/machinery/mecha_part_fabricator/proc/output_part_cost(var/datum/design/D)
	var/list/output = list()
	for(var/M in D.materials)
		if(M in resources)
			var/req_amount = get_resource_cost_w_coeff(D.materials[M])
			if(req_amount>resources[M])
				output += "<span class='deficiency'>[req_amount] [M]</span>"
			output = "[req_amount] [M]"
	return jointext(output, "|")

/obj/machinery/mecha_part_fabricator/proc/output_available_resources()
	var/output
	for(var/resource in resources)
		var/amount = min(res_max_amount, resources[resource])
		output += "<span class=\"res_name\">[resource]: </span>[amount] cm&sup3;"
		if(amount>0)
			output += "<span style='font-size:80%;'> - Remove \[<a href='?src=\ref[src];remove_mat=1;material=[resource]'>1</a>\] | \[<a href='?src=\ref[src];remove_mat=10;material=[resource]'>10</a>\] | \[<a href='?src=\ref[src];remove_mat=[res_max_amount];material=[resource]'>All</a>\]</span>"
		output += "<br/>"
	return output

/obj/machinery/mecha_part_fabricator/proc/remove_resources(var/datum/design/D)
	for(var/M in D.materials)
		if(M in resources)
			src.resources[M] -= get_resource_cost_w_coeff(D.materials[M])

/obj/machinery/mecha_part_fabricator/proc/check_resources(var/datum/design/D)
	for(var/M in D.materials)
		if(M in resources)
			if(resources[M] < get_resource_cost_w_coeff(D.materials[M]))
				return FALSE
	return TRUE

/obj/machinery/mecha_part_fabricator/proc/build(var/datum/design/D)
	if(!istype(D) || !(D.build_type & MECHFAB))
		return

	src.being_built = new D.build_path(src)

	src.desc = "It's building [src.being_built]."
	src.remove_resources(D)
	src.overlays += "fab-active"
	src.use_power = 2
	src.updateUsrDialog()
	sleep(get_construction_time_w_coeff(D)*10)
	src.use_power = 1
	src.overlays -= "fab-active"
	src.desc = initial(src.desc)
	if(being_built)
		src.being_built.Move(get_step(src,output_dir))
		src.visible_message("\icon[src] <b>[src]</b> beeps, \"The following has been completed: [src.being_built] is built\".")
		src.being_built = null
	src.updateUsrDialog()
	return 1

/obj/machinery/mecha_part_fabricator/proc/update_queue_on_page()
	send_byjax(usr,"mecha_fabricator.browser","queue",src.list_queue())
	return

/obj/machinery/mecha_part_fabricator/proc/add_part_set_to_queue(var/category)
	for(var/datum/design/D in files.known_designs)
		if(D.category == category)
			add_to_queue(D)
	return

/obj/machinery/mecha_part_fabricator/proc/add_to_queue(var/datum/design/D)
	if(!D.build_path || !(D.build_type & MECHFAB))
		return

	if(!istype(queue))
		queue = list()
	if(istype(D))
		queue[++queue.len] = D

/obj/machinery/mecha_part_fabricator/proc/remove_from_queue(index)
	if(!isnum(index) || !istype(queue) || (index<1 || index>queue.len))
		return 0
	queue.Cut(index,++index)
	return 1

/obj/machinery/mecha_part_fabricator/proc/process_queue()
	var/datum/design/D = listgetindex(src.queue, 1)
	if(!istype(D))
		remove_from_queue(1)
		if(src.queue.len)
			return process_queue()
		else
			return
	temp = null
	while(D)
		if(stat&(NOPOWER|BROKEN))
			return 0
		if(!check_resources(D))
			src.visible_message("\icon[src] <b>[src]</b> beeps, \"Not enough resources. Queue processing stopped\".")
			temp = {"<font color='red'>Not enough resources to build next part.</font><br>
						<a href='?src=\ref[src];process_queue=1'>Try again</a> | <a href='?src=\ref[src];clear_temp=1'>Return</a><a>"}
			return 0
		remove_from_queue(1)
		build(D)
		D = listgetindex(src.queue, 1)
	src.visible_message("\icon[src] <b>[src]</b> beeps, \"Queue processing finished successfully\".")
	return 1

/obj/machinery/mecha_part_fabricator/proc/list_queue()
	var/output = "<b>Queue contains:</b>"
	if(!istype(queue) || !queue.len)
		output += "<br>Nothing"
	else
		output += "<ol>"
		for(var/i=1;i<=queue.len;i++)
			var/datum/design/D = listgetindex(src.queue, i)
			if(istype(D))
				var/arrows = ""
				if(i>1)
					arrows += "<a href='?src=\ref[src];queue_move=-1;index=[i]' class='arrow'>&uarr;</a>"
				if(i<queue.len)
					arrows += "<a href='?src=\ref[src];queue_move=+1;index=[i]' class='arrow'>&darr;</a>"
				output += "<li[!check_resources(D)?" style='color: #f00;'":null]>[D.name] - [arrows] <a href='?src=\ref[src];remove_from_queue=[i]'>Remove</a></li>"
		output += "</ol>"
		output += "\[<a href='?src=\ref[src];process_queue=1'>Process queue</a> | <a href='?src=\ref[src];clear_queue=1'>Clear queue</a>\]"
	return output

/obj/machinery/mecha_part_fabricator/proc/update_tech()
	if(!files) return
	var/output
	for(var/datum/tech/T in files.known_tech)
		if(T && T.level > 1)
			var/diff
			switch(T.id) //bad, bad formulas
				if("materials")
					var/pmat = 0//Calculations to make up for the fact that these parts and tech modify the same thing
					for(var/obj/item/weapon/stock_parts/micro_laser/Ml in component_parts)
						pmat += Ml.rating
					if(pmat >= 1)
						pmat -= 1//So the equations don't have to be reworked, upgrading a single part from T1 to T2 is == to 1 tech level
					diff = round(initial(resource_coeff) - (initial(resource_coeff)*(T.level+pmat))/25,0.01)
					if(resource_coeff!=diff)
						resource_coeff = diff
						output+="Production efficiency increased.<br>"
				if("programming")
					var/ptime = 0
					for(var/obj/item/weapon/stock_parts/manipulator/Ma in component_parts)
						ptime += Ma.rating
					if(ptime >= 2)
						ptime -= 2
					diff = round(initial(time_coeff) - (initial(time_coeff)*(T.level+ptime))/25,0.1)
					if(time_coeff!=diff)
						time_coeff = diff
						output+="Production routines updated.<br>"
	return output


/obj/machinery/mecha_part_fabricator/proc/sync(silent=null)
	if(!silent)
		temp = "Updating local R&D database..."
		src.updateUsrDialog()
		sleep(30) //only sleep if called by user

	var/designs_count = 0
	for(var/datum/design/D in files.known_designs)
		if(D.build_type&MECHFAB)
			--designs_count

	var/found = 0
	for(var/obj/machinery/computer/rdconsole/RDC in get_area_all_atoms(get_area(src)))
		if(!RDC.sync)
			continue
		found++
		for(var/datum/tech/T in RDC.files.known_tech)
			files.AddTech2Known(T)
		for(var/datum/design/D in RDC.files.known_designs)
			files.AddDesign2Known(D)
		files.RefreshResearch()
		for(var/datum/design/D in files.known_designs)
			if(D.build_type&MECHFAB)
				++designs_count
		var/tech_output = update_tech()
		if(!silent)
			temp = "Processed [designs_count] equipment designs.<br>"
			temp += tech_output
			temp += "<a href='?src=\ref[src];clear_temp=1'>Return</a>"
			src.updateUsrDialog()
		update_categories()
		if(designs_count>0 || tech_output)
			src.visible_message("\icon[src] <b>[src]</b> beeps, \"Successfully synchronized with R&D server. New data processed.\"")
	if(found == 0)
		temp = "Couldn't contact R&D server.<br>"
		temp += "<a href='?src=\ref[src];clear_temp=1'>Return</a>"
		src.updateUsrDialog()
		src.visible_message("\icon[src] <b>[src]</b> beeps, \"Error! Couldn't connect to R&D server.\"")
	return

/obj/machinery/mecha_part_fabricator/proc/get_resource_cost_w_coeff(var/req_amount, var/roundto=1)
	return round(req_amount*resource_coeff, roundto)


/obj/machinery/mecha_part_fabricator/proc/get_construction_time_w_coeff(var/datum/design/D, var/roundto=1)
	return round(D.time * time_coeff, roundto)

/obj/machinery/mecha_part_fabricator/attack_hand(mob/user as mob)
	var/dat, left_part
	if (..())
		return
	if(!allowed(user))
		user << "<font color='red'>You don't have required permissions to use [src]</font>"
		return
	user.set_machine(src)
	var/turf/exit = get_step(src,output_dir)
	if(exit.density)
		src.visible_message("\icon[src] <b>[src]</b> beeps, \"Error! Part outlet is obstructed\".")
		return
	if(temp)
		left_part = temp
	else if(src.being_built)
		left_part = {"<TT>Building [src.being_built.name].<BR>
							Please wait until completion...</TT>"}
	else if(category && (category in categories))
		left_part += output_parts_list(category)
		left_part += "<hr><a href='?src=\ref[src];category=clean'>Return</a>"
	else
		left_part = output_available_resources()+"<hr>"
		left_part += "<a href='?src=\ref[src];sync=1'>Sync with R&D servers</a><hr>"
		for(var/category in categories)
			left_part += "<a href='?src=\ref[src];category=[category]'>[category]</a> - "
			left_part += "\[<a href='?src=\ref[src];partset_to_queue=[category]'>Add all parts to queue\]<br>"
	dat = {"<html>
		<head>
			<title>[src.name]</title>
			<style>
				span.deficiency{color: red}
				.res_name {font-weight: bold; text-transform: capitalize;}
				.red {color: #f00;}
				.part {margin-bottom: 10px;}
				.arrow {text-decoration: none; font-size: 10px;}
				body, table {height: 100%;}
				td {vertical-align: top; padding: 5px;}
				html, body {padding: 0px; margin: 0px;}
				h1 {font-size: 18px; margin: 5px 0px;}
				</style>
			<script language='javascript' type='text/javascript'>
				[js_byjax]
			</script>
		</head>
		<body>
			<table style='width: 100%;'>
				<tr>
				<td style='width: 70%; padding-right: 10px;'>
				[left_part]
				</td>
				<td style='width: 30%; background: #ccc;' id='queue'>
				[list_queue()]
				</td>
				<tr>
			</table>
		</body>
		</html>"}
	user << browse(dat, "window=mecha_fabricator;size=1000x400")
	onclose(user, "mecha_fabricator")
	return

/obj/machinery/mecha_part_fabricator/proc/exploit_prevention(var/datum/design/D, mob/user as mob, var/desc_exploit)
	if(!D || !user || !istype(D) || !istype(user)) // sanity
		return 1

	// these 3 are the current requirements for an object being buildable by the mech_fabricator
	if(!(locate(D) in files.known_designs))
		log_game("EXPLOIT : [key_name(user)] tried to exploit an Exosuit Fabricator to [desc_exploit ? "get the desc of" : "duplicate"] [D.name] !", src)
		return 1

	return null

/obj/machinery/mecha_part_fabricator/Topic(href, href_list)

	if(..()) // critical exploit prevention, do not remove unless you replace it -walter0o
		return

	var/datum/topic_input/filter = new /datum/topic_input(href,href_list)
	if(href_list["category"])
		var/tcategory = href_list["category"]
		if(!tcategory || tcategory=="clean")
			category = null
		else
			category = tcategory

	if(href_list["build"])
		var/design_id = href_list["build"]

		var/datum/design/D = null
		for(D in files.known_designs)
			if(D.id == design_id)
				break

		if(!processing_queue)
			build(D)
		else
			add_to_queue(D)

	if(href_list["add_to_queue"])
		var/design_id = href_list["add_to_queue"]

		var/datum/design/D = null
		for(D in files.known_designs)
			if(D.id == design_id)
				break

		add_to_queue(D)
		return update_queue_on_page()

	if(href_list["remove_from_queue"])
		remove_from_queue(filter.getNum("remove_from_queue"))
		return update_queue_on_page()

	if(href_list["partset_to_queue"])
		add_part_set_to_queue(href_list["partset_to_queue"])
		return update_queue_on_page()

	if(href_list["process_queue"])
		spawn(-1)
			if(processing_queue || being_built)
				return 0
			processing_queue = 1
			process_queue()
			processing_queue = 0

	if(href_list["clear_temp"])
		temp = null

	if(href_list["queue_move"] && href_list["index"])
		var/index = filter.getNum("index")
		var/new_index = index + filter.getNum("queue_move")
		if(isnum(index) && isnum(new_index))
			if(InRange(new_index,1,queue.len))
				queue.Swap(index,new_index)
		return update_queue_on_page()
	if(href_list["clear_queue"])
		queue = list()
		return update_queue_on_page()
	if(href_list["sync"])
		queue = list()
		src.sync()
		return update_queue_on_page()
	if(href_list["part_desc"])
		var/design_id = href_list["part_desc"]
		var/datum/design/D = null
		for(D in files.known_designs)
			if(D.id == design_id)
				break

		if(D)
			temp = {"
				<h1>[D.name] description:</h1>
				[D.desc]<br>
				<a href='?src=\ref[src];clear_temp=1'>Return</a>
			"}
	if(href_list["remove_mat"] && href_list["material"])
		temp = "Ejected [remove_material(href_list["material"],text2num(href_list["remove_mat"]))] of [href_list["material"]]<br><a href='?src=\ref[src];clear_temp=1'>Return</a>"
	src.updateUsrDialog()
	return


/obj/machinery/mecha_part_fabricator/proc/remove_material(var/M, var/amount)
	if(!M in resources || amount <= 0)
		return
	var/eject_amount = min(round(amount)*SHEET_MATERIAL_AMOUNT, resources[M])
	if(eject_amount >= SHEET_MATERIAL_AMOUNT)
		resources[M] = resources[M] - eject_amount
		create_material_stack(M, eject_amount, src.loc)
	return eject_amount


/obj/machinery/mecha_part_fabricator/update_icon()
	..()
	if(panel_open)
		icon_state = "fab-o"
	else
		icon_state = "fab-idle"

/obj/machinery/mecha_part_fabricator/dismantle()
	for(var/material in resources)
		create_material_stack(material, resources[material], src.loc)
	return ..()


/obj/machinery/mecha_part_fabricator/attackby(obj/W as obj, mob/user as mob)
	if(src.being_built)
		user << "The fabricator is currently processing. Please wait until completion."
		return

	if(default_deconstruction_screwdriver(user, W))
		return
	if(default_deconstruction_crowbar(user, W))
		return
	if(default_part_replacement(user, W))
		return

	if(istype(W, /obj/item/stack/material))
		var/material = W.get_material_name()
		if(!material in resources) return ..()

		var/obj/item/stack/material/stack = W

		var/sname = stack.name
		if(src.resources[material] < res_max_amount)
			if(stack && stack.amount >= 1)
				src.overlays += "fab-load-[material]"//loading animation is now an overlay based on material type. No more spontaneous conversion of all ores to metal. -vey
				if(!do_after(user, 10, src))
					return
				var/free_space = res_max_amount - resources[material]
				var/transfer_amount = min(stack.amount, round(free_space/SHEET_MATERIAL_AMOUNT))
				stack.use(transfer_amount)
				src.resources[material] += transfer_amount * SHEET_MATERIAL_AMOUNT
				src.overlays -= "fab-load-[material]"
				user << "You insert [transfer_amount] [sname] into the fabricator."
				src.updateUsrDialog()
			else
				user << "The fabricator can only accept full sheets of [sname]."
				return
		else
			user << "The fabricator cannot hold more [sname]."
		return
