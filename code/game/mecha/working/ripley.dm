/obj/mecha/working/ripley
	desc = "Autonomous Power Loader Unit. The workhorse of the exosuit world."
	name = "APLU \"Ripley\""
	icon_state = "ripley"
	initial_icon = "ripley"
	step_in = 6
	max_temperature = 20000
	health = 200
	wreckage = /obj/effect/decal/mecha_wreckage/ripley
	cargo_capacity = 10

/obj/mecha/working/ripley/Destroy()
	for(var/atom/movable/A in src.cargo)
		A.loc = loc
		var/turf/T = loc
		if(istype(T))
			T.Entered(A)
		step_rand(A)
	cargo.Cut()
	..()

/obj/mecha/working/ripley/firefighter
	desc = "Standart APLU chassis was refitted with additional thermal protection and cistern."
	name = "APLU \"Firefighter\""
	icon_state = "firefighter"
	initial_icon = "firefighter"
	max_temperature = 65000
	health = 250
	lights_power = 8
	damage_absorption = list("fire"=0.5,"bullet"=0.8,"bomb"=0.5)
	wreckage = /obj/effect/decal/mecha_wreckage/ripley/firefighter

/obj/mecha/working/ripley/deathripley
	desc = "OH SHIT IT'S THE DEATHSQUAD WE'RE ALL GONNA DIE"
	name = "DEATH-RIPLEY"
	icon_state = "deathripley"
	step_in = 2
	opacity=0
	lights_power = 60
	wreckage = /obj/effect/decal/mecha_wreckage/ripley/deathripley
	step_energy_drain = 0

/obj/mecha/working/ripley/deathripley/New()
	..()
	attach(new /obj/item/mecha_parts/mecha_equipment/tool/safety_clamp)
	return

/obj/mecha/working/ripley/lagan
	desc = "ROW ROW FIGHT THE POWAH!"
	name = "Lagan"
	icon_state = "lagann"
	initial_icon = "lagann"
	step_in = 3
	max_temperature = 35000
	health = 300
	wreckage = /obj/effect/decal/mecha_wreckage/ripley/lagan

/obj/mecha/working/ripley/lagan/New()
	..()
	//Attach drill
	attach(new /obj/item/mecha_parts/mecha_equipment/tool/drill/diamonddrill)
	//Attach hydrolic clamp
	attach(new /obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp)
	attach(new /obj/item/mecha_parts/mecha_equipment/tool/passenger)
	attach(new /obj/item/mecha_parts/mecha_equipment/tool/passenger)
	return
