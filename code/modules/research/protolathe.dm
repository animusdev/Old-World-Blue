/*
Protolathe

Similar to an autolathe, you load glass and metal sheets (but not other objects) into it to be used as raw materials for the stuff
it creates. All the menus and other manipulation commands are in the R&D console.

Note: Must be placed west/left of and R&D console to function.

*/
/obj/machinery/r_n_d/protolathe
	name = "\improper Protolathe"
	icon_state = "protolathe"
	flags = OPENCONTAINER
	circuit = /obj/item/weapon/circuitboard/protolathe

	use_power = 1
	idle_power_usage = 30
	active_power_usage = 5000

	max_material_storage = 100000 //All this could probably be done better with a list but meh.
	materials = list(
		MATERIAL_STEEL = 0,
		MATERIAL_GLASS = 0,
		MATERIAL_GOLD = 0,
		MATERIAL_SILVER = 0,
		MATERIAL_PHORON = 0,
		MATERIAL_URANIUM = 0,
		MATERIAL_DIAMOND = 0
	)

/obj/machinery/r_n_d/protolathe/RefreshParts()
	var/T = 0
	for(var/obj/item/weapon/reagent_containers/glass/G in component_parts)
		T += G.reagents.maximum_volume
	create_reagents(T)
	max_material_storage = 0
	for(var/obj/item/weapon/stock_parts/matter_bin/M in component_parts)
		max_material_storage += M.rating * 75000
	T = 0
	for(var/obj/item/weapon/stock_parts/manipulator/M in component_parts)
		T += M.rating
	mat_efficiency = 1 - (T - 2) / 8

/obj/machinery/r_n_d/protolathe/update_icon()
	if(panel_open)
		icon_state = "protolathe_t"
	else
		icon_state = "protolathe"

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

	var/list/required = D.materials.Copy()
	for(var/material in required)
		required[material] *= mat_efficiency

	for(var/M in required)
		materials[M] = max(0, materials[M] - required[M])

	for(var/C in D.chemicals)
		reagents.remove_reagent(C, D.materials[C] * mat_efficiency)

	if(D.build_path)
		var/obj/new_item = new D.build_path(loc)

		if( new_item.type == /obj/item/storage/backpack/holding )
			new_item.investigate_log("built by [key]","singulo")

		new_item.reliability = D.reliability
		new_item.matter = list()
		for(var/M in required)
			new_item.matter[M] = required[M] * 0.75
	busy = 0
