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

	materials = list("glass" = 0, "gold" = 0, "diamond" = 0, "uranium" = 0)

	max_material_storage = 75000
	mat_efficiency = 1

	use_power = 1
	idle_power_usage = 30
	active_power_usage = 2500

/obj/machinery/r_n_d/circuit_imprinter/RefreshParts()
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

/obj/machinery/r_n_d/circuit_imprinter/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(shocked)
		shock(user, 50)
	if(default_deconstruction_screwdriver(user, O))
		if(linked_console)
			linked_console.linked_imprinter = null
			linked_console = null
		return
	if(default_deconstruction_crowbar(user, O))
		return
	if(default_part_replacement(user, O))
		return
	if(panel_open)
		user << "<span class='notice'>You can't load \the [src] while it's opened.</span>"
		return 1
	if(disabled)
		user << "\The [src] appears to not be working!"
		return
	if(!linked_console)
		user << "\The [src] must be linked to an R&D console first!"
		return 1
	if(O.is_open_container())
		return 0
	if(stat)
		return 1
	if(busy)
		user << "<span class='notice'>\The [src] is busy. Please wait for completion of previous operation.</span>"
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
		var/material = stack.get_material_name()
		if(do_after(usr, 16) && stack.use(amount))
			user << "<span class='notice'>You add [amount] sheets to \the [src].</span>"
			use_power(max(1000, (SHEET_MATERIAL_AMOUNT * amount / 10)))
			materials[material] += amount * SHEET_MATERIAL_AMOUNT
		busy = 0
		updateUsrDialog()
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

	for(var/M in D.materials)
		materials[M] = max(0, materials[M] - D.materials[M] * mat_efficiency)

	for(var/C in D.chemicals)
		reagents.remove_reagent(C, D.chemicals[C] * mat_efficiency)

	var/obj/new_item = new D.build_path(src.loc)
	new_item.reliability = D.reliability
	if(hacked)
		new_item.reliability = max((reliability / 2), 0)

	busy = 0

