/*///////////////Circuit Imprinter (By Darem)////////////////////////
	Used to print new circuit boards (for computers and similar systems) and AI modules. Each circuit board pattern are stored in
a /datum/desgin on the linked R&D console. You can then print them out in a fasion similar to a regular lathe. However, instead of
using metal and glass, it uses glass and reagents (usually sulphuric acid).
*/

/obj/machinery/r_n_d/circuit_imprinter
	name = "\improper Circuit Imprinter"
	icon_state = "circuit_imprinter"
	flags = OPENCONTAINER
	circuit = /obj/item/weapon/circuitboard/circuit_imprinter

	materials = list(MATERIAL_GLASS = 0, MATERIAL_GOLD = 0, MATERIAL_DIAMOND = 0, MATERIAL_URANIUM = 0)

	max_material_storage = 75000
	mat_efficiency = 1

	use_power = 1
	idle_power_usage = 30
	active_power_usage = 2500

/obj/machinery/r_n_d/circuit_imprinter/RefreshParts()
	var/T = 0
	for(var/obj/item/weapon/reagent_containers/glass/G in component_parts)
		T += G.reagents.maximum_volume
	if(!reagents)
		create_reagents(T)
	reagents.maximum_volume = T
	max_material_storage = 0
	for(var/obj/item/weapon/stock_parts/matter_bin/M in component_parts)
		max_material_storage += M.rating * 75000
	T = 0
	for(var/obj/item/weapon/stock_parts/manipulator/M in component_parts)
		T += M.rating
	mat_efficiency = 1 - (T - 1) / 4

/obj/machinery/r_n_d/circuit_imprinter/update_icon()
	if(panel_open)
		icon_state = "circuit_imprinter_t"
	else
		icon_state = "circuit_imprinter"

/obj/machinery/r_n_d/circuit_imprinter/blob_act()
	if(prob(50))
		qdel(src)

/obj/machinery/r_n_d/circuit_imprinter/meteorhit()
	qdel(src)
	return

/obj/machinery/r_n_d/circuit_imprinter/proc/Build(var/datum/design/D)
	if(!canBuild(D))
		return 0

	busy = 1

	var/power = active_power_usage
	for(var/M in D.materials)
		power += round(D.materials[M] / 5)
	power = max(active_power_usage, power)

	flick("circuit_imprinter_ani", src)
	sleep(16)
	use_power(power)

	var/list/required = D.materials.Copy()
	for(var/material in required)
		required[material] *= mat_efficiency

	for(var/M in required)
		materials[M] = max(0, materials[M] - required[M])

	for(var/C in D.chemicals)
		reagents.remove_reagent(C, D.chemicals[C] * mat_efficiency)

	var/obj/new_item = new D.build_path(src.loc)
	new_item.reliability = D.reliability
	new_item.matter = list()
	for(var/M in required)
		new_item.matter[M] = required[M] * 0.75

	busy = 0

