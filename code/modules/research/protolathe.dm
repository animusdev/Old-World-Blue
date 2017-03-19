/*
Protolathe

Similar to an autolathe, you load glass and metal sheets (but not other objects) into it to be used as raw materials for the stuff
it creates. All the menus and other manipulation commands are in the R&D console.

Note: Must be placed west/left of and R&D console to function.

*/
/obj/machinery/r_n_d/protolathe
	name = "Protolathe"
	icon_state = "protolathe"
	flags = OPENCONTAINER
	circuit = /obj/item/weapon/circuitboard/protolathe

	use_power = 1
	idle_power_usage = 30
	active_power_usage = 5000

	max_material_storage = 100000 //All this could probably be done better with a list but meh.
	materials = list(
		DEFAULT_WALL_MATERIAL = 0,
		"glass" = 0,
		"gold" = 0,
		"silver" = 0,
		"phoron" = 0,
		"uranium" = 0,
		"diamond" = 0
	)

/obj/machinery/r_n_d/protolathe/RefreshParts()
	var/T = 0
	for(var/obj/item/weapon/reagent_containers/glass/G in component_parts)
		T += G.reagents.maximum_volume
	var/datum/reagents/R = new/datum/reagents(T)		//Holder for the reagents used as materials.
	reagents = R
	R.my_atom = src
	T = 0
	for(var/obj/item/weapon/stock_parts/matter_bin/M in component_parts)
		T += M.rating
	max_material_storage = T * 75000
	T = 0
	for(var/obj/item/weapon/stock_parts/manipulator/M in component_parts)
		T += M.rating
	mat_efficiency = 1 - (T - 2) / 8

/obj/machinery/r_n_d/protolathe/update_icon()
	if(panel_open)
		icon_state = "protolathe_t"
	else
		icon_state = "protolathe"

/obj/machinery/r_n_d/protolathe/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(shocked)
		shock(user, 50)
	if(default_deconstruction_screwdriver(user, O))
		if(linked_console)
			linked_console.linked_lathe = null
			linked_console = null
		return
	if(default_deconstruction_crowbar(user, O))
		return
	if(default_part_replacement(user, O))
		return
	if(O.is_open_container())
		return 1
	if(panel_open)
		user << "<span class='notice'>You can't load \the [src] while it's opened.</span>"
		return 1
	if(disabled)
		return
	if(!linked_console)
		user << "<span class='notice'>\The [src] must be linked to an R&D console first!</span>"
		return 1
	if(busy)
		user << "<span class='notice'>\The [src] is busy. Please wait for completion of previous operation.</span>"
		return 1
	if(stat)
		return 1

	if(istype(O, /obj/item/stack/material) && O.get_material_name() in materials)

		var/obj/item/stack/material/stack = O
		var/free_space = (max_material_storage - TotalMaterials())/SHEET_MATERIAL_AMOUNT
		if(free_space < 1)
			user << "<span class='notice'>\The [src] is full. Please remove some material from \the [src] in order to insert more.</span>"
			return 1

		var/amount = round(input("How many sheets do you want to add?") as num)
		amount = min(amount, stack.amount, free_space)
		if(amount <= 0 || busy)
			return

		busy = 1

		overlays += "protolathe_[stack.name]"
		sleep(10)
		overlays -= "protolathe_[stack.name]"

		var/material = stack.get_material_name()
		if(do_after(usr, 16) && stack.use(amount))
			user << "<span class='notice'>You add [amount] sheets to \the [src].</span>"
			use_power(max(1000, (SHEET_MATERIAL_AMOUNT * amount / 10)))
			materials[material] += amount * SHEET_MATERIAL_AMOUNT
		busy = 0
		updateUsrDialog()
		return

/obj/machinery/r_n_d/protolathe/proc/Build(var/datum/design/D)
	if(!canBuild(D))
		return 0
	busy = 1
	var/power = active_power_usage
	for(var/M in D.materials)
		power += round(D.materials[M] / 5)
	power = max(active_power_usage, power)

	var/key = usr.key	//so we don't lose the info during the spawn delay
	sleep(16)
	flick("protolathe_n",src)
	use_power(power)
	sleep(16)
	for(var/M in D.materials)
		materials[M] = max(0, materials[M] - D.materials[M] * mat_efficiency)

	for(var/C in D.chemicals)
		reagents.remove_reagent(C, D.materials[C] * mat_efficiency)

	if(D.build_path)
		var/obj/new_item = new D.build_path(loc)

		if( new_item.type == /obj/item/weapon/storage/backpack/holding )
			new_item.investigate_log("built by [key]","singulo")

		new_item.reliability = D.reliability
		if(hacked)
			D.reliability = max((reliability / 2), 0)
		if(mat_efficiency != 1) // No matter out of nowhere
			if(new_item.matter && new_item.matter.len > 0)
				for(var/i in new_item.matter)
					new_item.matter[i] = new_item.matter[i] * mat_efficiency
	busy = 0

//This is to stop these machines being hackable via clicking.
/obj/machinery/r_n_d/protolathe/attack_hand(mob/user as mob)
	return