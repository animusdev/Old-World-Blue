//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:33

//All devices that link into the R&D console fall into thise type for easy identification and some shared procs.


/obj/machinery/r_n_d
	name = "R&D Device"
	icon = 'icons/obj/machines/research.dmi'
	density = 1
	anchored = 1
	use_power = 1
	var/busy = 0
	var/hacked = 0
	var/disabled = 0
	var/shocked = 0
	var/list/wires = list()
	var/hack_wire
	var/disable_wire
	var/shock_wire
	var/obj/machinery/computer/rdconsole/linked_console

	var/list/materials
	var/max_material_storage = 0
	var/mat_efficiency = 1

/obj/machinery/r_n_d/New()
	..()
	wires["Red"] = 0
	wires["Blue"] = 0
	wires["Green"] = 0
	wires["Yellow"] = 0
	wires["Black"] = 0
	wires["White"] = 0
	var/list/w = list("Red","Blue","Green","Yellow","Black","White")
	src.hack_wire = pick(w)
	w -= src.hack_wire
	src.shock_wire = pick(w)
	w -= src.shock_wire
	src.disable_wire = pick(w)
	w -= src.disable_wire

/obj/machinery/r_n_d/dismantle()
	for(var/obj/item/weapon/reagent_containers/glass/beaker/I in component_parts)
		reagents.trans_to_obj(I, reagents.total_volume)
	for(var/M in materials)
		create_material_stack(M, materials[M], src.loc)
	..()

/obj/machinery/r_n_d/proc/eject_matter(var/M, var/amount)
	if(!M in materials || amount <= 0)
		return
	var/eject_amount = min(round(amount)*SHEET_MATERIAL_AMOUNT, materials[M])
	if(eject_amount > SHEET_MATERIAL_AMOUNT)
		materials[M] = materials[M] - eject_amount
		create_material_stack(M, eject_amount, src.loc)

/obj/machinery/r_n_d/attack_hand(mob/user as mob)
	if (shocked)
		shock(user,50)
	if(panel_open)
		var/dat as text
		dat += "[src.name] Wires:<BR>"
		for(var/wire in src.wires)
			dat += text("[wire] Wire: <A href='?src=\ref[src];wire=[wire];cut=1'>[src.wires[wire] ? "Mend" : "Cut"]</A> <A href='?src=\ref[src];wire=[wire];pulse=1'>Pulse</A><BR>")

		dat += text("The red light is [src.disabled ? "off" : "on"].<BR>")
		dat += text("The green light is [src.shocked ? "off" : "on"].<BR>")
		dat += text("The blue light is [src.hacked ? "off" : "on"].<BR>")
		user << browse("<HTML><HEAD><TITLE>[src.name] Hacking</TITLE></HEAD><BODY>[dat]</BODY></HTML>","window=hack_win")
	return


/obj/machinery/r_n_d/Topic(href, href_list)
	if(..())
		return
	usr.set_machine(src)
	src.add_fingerprint(usr)
	if(href_list["pulse"])
		var/temp_wire = href_list["wire"]
		if (!istype(usr.get_active_hand(), /obj/item/device/multitool))
			usr << "You need a multitool!"
		else
			if(src.wires[temp_wire])
				usr << "You can't pulse a cut wire."
			else
				if(src.hack_wire == href_list["wire"])
					src.hacked = !src.hacked
					spawn(100) src.hacked = !src.hacked
				if(src.disable_wire == href_list["wire"])
					src.disabled = !src.disabled
					src.shock(usr,50)
					spawn(100) src.disabled = !src.disabled
				if(src.shock_wire == href_list["wire"])
					src.shocked = !src.shocked
					src.shock(usr,50)
					spawn(100) src.shocked = !src.shocked
	if(href_list["cut"])
		if (!istype(usr.get_active_hand(), /obj/item/weapon/wirecutters))
			usr << "You need wirecutters!"
		else
			var/temp_wire = href_list["wire"]
			wires[temp_wire] = !wires[temp_wire]
			if(src.hack_wire == temp_wire)
				src.hacked = !src.hacked
			if(src.disable_wire == temp_wire)
				src.disabled = !src.disabled
				src.shock(usr,50)
			if(src.shock_wire == temp_wire)
				src.shocked = !src.shocked
				src.shock(usr,50)
	src.updateUsrDialog()

/obj/machinery/r_n_d/proc/CallMaterialName(var/ID)
	var/return_name = ID
	switch(return_name)
		if("metal")
			return_name = "Metal"
		if("glass")
			return_name = "Glass"
		if("gold")
			return_name = "Gold"
		if("silver")
			return_name = "Silver"
		if("phoron")
			return_name = "Solid Phoron"
		if("uranium")
			return_name = "Uranium"
		if("diamond")
			return_name = "Diamond"
	return capitalize(return_name)

/obj/machinery/r_n_d/proc/CallReagentName(var/ID)
	var/return_name = ID
	var/datum/reagent/temp_reagent
	for(var/R in subtypesof(/datum/reagent))
		temp_reagent = R
		if(initial(temp_reagent.id) == ID)
			return_name = initial(temp_reagent.name)
			break
	return return_name

/obj/machinery/r_n_d/proc/TotalMaterials()
	. = 0
	for(var/M in materials)
		. += materials[M]
	return .

/obj/machinery/r_n_d/proc/get_requirements(var/datum/design/D)
	. = list()
	for(var/M in D.materials)
		var/req_ammount = D.materials[M] * mat_efficiency
		if(materials[M] <= req_ammount)
			. += "<span class ='deficiency'>[req_ammount] [CallMaterialName(M)]</span>"
		else
			. += "[req_ammount] [CallMaterialName(M)]"
	for(var/C in D.chemicals)
		var/req_ammount = D.chemicals[C] * mat_efficiency
		if(!reagents.has_reagent(C, req_ammount))
			. += "<span class ='deficiency'>[req_ammount] [CallReagentName(C)]</span>"
		else
			. += "[req_ammount] [CallReagentName(C)]"
	return jointext(., ", ")

/obj/machinery/r_n_d/proc/canBuild(var/datum/design/D)
	for(var/M in D.materials)
		if(materials[M] <= D.materials[M] * mat_efficiency)
			return 0
	for(var/C in D.chemicals)
		if(!reagents.has_reagent(C, D.chemicals[C] * mat_efficiency))
			return 0
	return 1