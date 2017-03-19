/proc/create_material_stack(var/material, var/amount, var/atom/location)
	var/units = round(amount/SHEET_MATERIAL_AMOUNT)
	while(units > 0)
		var/obj/item/stack/material/S = PoolOrNew(/obj/item/stack/material, location)
		S.set_material(material)
		S.amount = min(units,S.max_amount)
		units -= S.amount


// Stacked resources. They use a material datum for a lot of inherited values.
/obj/item/stack/material
	force = 5.0
	throwforce = 5
	w_class = 3.0
	randpixel = 4
	throw_speed = 3
	throw_range = 3
	max_amount = 50

	var/default_type = DEFAULT_WALL_MATERIAL
	var/material/material
	var/apply_colour //temp pending icon rewrite

/obj/item/stack/material/New()
	..()

	if(!default_type)
		default_type = DEFAULT_WALL_MATERIAL
	set_material(default_type)
	return 1

/obj/item/stack/material/get_material()
	return material

/obj/item/stack/material/proc/set_material(var/material_name)
	material = get_material_by_name(material_name)

	if(!material)
		qdel(src)
		return 0

	icon_state = material.icon_state
	recipes = material.get_recipes()
	stacktype = material.stack_type
	origin_tech = material.stack_origin_tech

	if(apply_colour)
		color = material.icon_colour

	if(material.conductive)
		flags |= CONDUCT

	matter = material.get_matter()
	update_strings()

/obj/item/stack/material/proc/update_strings()
	if(!material)
		return

	// Update from material datum.
	singular_name = material.sheet_singular_name

	if(amount>1)
		name = "[material.use_name] [material.sheet_plural_name]"
		desc = "A stack of [material.use_name] [material.sheet_plural_name]."
		gender = PLURAL
	else
		name = "[material.use_name] [material.sheet_singular_name]"
		desc = "A [material.sheet_singular_name] of [material.use_name]."
		gender = NEUTER

/obj/item/stack/material/split()
	var/obj/item/stack/material/M = ..()
	M.set_material(material.name)
	return M

/obj/item/stack/material/use(var/used)
	. = ..()
	update_strings()
	return

/obj/item/stack/material/transfer_to(obj/item/stack/S, var/tamount=null, var/type_verified)
	var/obj/item/stack/material/M = S
	if(!istype(M) || material.name != M.material.name)
		return 0
	var/transfer = ..(S,tamount,1)
	if(src) update_strings()
	if(M) M.update_strings()
	return transfer

/obj/item/stack/material/attack_self(var/mob/user)
	if(!material.build_windows(user, src))
		..()

/obj/item/stack/material/attackby(var/obj/item/W, var/mob/user)
	if(istype(W,/obj/item/stack/cable_coil))
		material.build_wired_product(user, W, src)
		return
	else if(istype(W, /obj/item/stack/rods))
		material.build_rod_product(user, W, src)
		return
	return ..()

/obj/item/stack/material/iron
	name = "iron"
	default_type = "iron"
	icon_state = "sheet-silver"
	apply_colour = 1

/obj/item/stack/material/iron/full
	amount = 50

/obj/item/stack/material/sandstone
	name = "sandstone brick"
	default_type = "sandstone"
	icon_state = "sheet-sandstone"

/obj/item/stack/material/sandstone/full
	amount = 50

/obj/item/stack/material/marble
	name = "marble brick"
	default_type = "marble"
	icon_state = "sheet-marble"

/obj/item/stack/material/marble/full
	amount = 50

/obj/item/stack/material/diamond
	name = "diamond"
	default_type = "diamond"
	icon_state = "sheet-diamond"

/obj/item/stack/material/diamond/full
	amount = 50

/obj/item/stack/material/uranium
	name = "uranium"
	default_type = "uranium"
	icon_state = "sheet-uranium"

/obj/item/stack/material/uranium/full
	amount = 50

/obj/item/stack/material/phoron
	name = "solid phoron"
	default_type = "phoron"
	icon_state = "sheet-phoron"

/obj/item/stack/material/phoron/full
	amount = 50

/obj/item/stack/material/plastic
	name = "plastic"
	default_type = "plastic"
	icon_state = "sheet-plastic"

/obj/item/stack/material/plastic/full
	amount = 50

/obj/item/stack/material/gold
	name = "gold"
	default_type = "gold"
	icon_state = "sheet-gold"

/obj/item/stack/material/gold/full
	amount = 50

/obj/item/stack/material/silver
	name = "silver"
	default_type = "silver"
	icon_state = "sheet-silver"

/obj/item/stack/material/silver/full
	amount = 50

//Valuable resource, cargo can sell it.
/obj/item/stack/material/platinum
	name = "platinum"
	default_type = "platinum"
	icon_state = "sheet-adamantine"

/obj/item/stack/material/platinum/full
	amount = 50

//Extremely valuable to Research.
/obj/item/stack/material/mhydrogen
	name = "metallic hydrogen"
	default_type = "mhydrogen"
	icon_state = "sheet-mythril"

/obj/item/stack/material/mhydrogen/full
	amount = 50

//Fuel for MRSPACMAN generator.
/obj/item/stack/material/tritium
	name = "tritium"
	default_type = "tritium"
	icon_state = "sheet-silver"
	apply_colour = 1

/obj/item/stack/material/tritium/full
	amount = 50

/obj/item/stack/material/osmium
	name = "osmium"
	default_type = "osmium"
	icon_state = "sheet-silver"
	apply_colour = 1

/obj/item/stack/material/osmium/full
	amount = 50

/obj/item/stack/material/steel
	name = DEFAULT_WALL_MATERIAL
	default_type = DEFAULT_WALL_MATERIAL
	icon_state = "sheet-metal"

/obj/item/stack/material/steel/full
	amount = 50

/obj/item/stack/material/plasteel
	name = "plasteel"
	default_type = "plasteel"
	icon_state = "sheet-plasteel"

/obj/item/stack/material/plasteel/full
	amount = 50

/obj/item/stack/material/wood
	name = "wooden plank"
	default_type = "wood"
	icon_state = "sheet-wood"

/obj/item/stack/material/wood/full
	amount = 50

/obj/item/stack/material/cloth
	name = "cloth"
	default_type = "cloth"

/obj/item/stack/material/cloth/full
	amount = 50

/obj/item/stack/material/cardboard
	name = "cardboard"
	default_type = "cardboard"
	icon_state = "sheet-card"

/obj/item/stack/material/cardboard/full
	amount = 50

/obj/item/stack/material/leather
	name = "leather"
	desc = "The by-product of mob grinding."
	default_type = "leather"

/obj/item/stack/material/leather/full
	amount = 50

/obj/item/stack/material/glass
	name = "glass"
	default_type = "glass"
	icon_state = "sheet-glass"

/obj/item/stack/material/glass/full
	amount = 50

/obj/item/stack/material/glass/reinforced
	name = "reinforced glass"
	default_type = "rglass"
	icon_state = "sheet-rglass"

/obj/item/stack/material/glass/reinforced/full
	amount = 50

/obj/item/stack/material/glass/phoronglass
	name = "borosilicate glass"
	desc = "This sheet is special platinum-glass alloy designed to withstand large temperatures"
	singular_name = "borosilicate glass sheet"
	default_type = "phglass"
	icon_state = "sheet-phoronglass"

/obj/item/stack/material/glass/phoronglass/full
	amount = 50

/obj/item/stack/material/glass/phoronrglass
	name = "reinforced borosilicate glass"
	desc = "This sheet is special platinum-glass alloy designed to withstand large temperatures. It is reinforced with few rods."
	singular_name = "reinforced borosilicate glass sheet"
	default_type = "rphglass"
	icon_state = "sheet-phoronrglass"

/obj/item/stack/material/glass/phoronrglass/full
	amount = 50
