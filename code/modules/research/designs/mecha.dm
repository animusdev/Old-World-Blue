/datum/design/item/mecha_tracking
	name = "Exosuit tracking beacon"
	build_type = MECHFAB
	time = 5
	materials = list(DEFAULT_WALL_MATERIAL = 500)
	build_path = /obj/item/mecha_parts/mecha_tracking
	category = "Misc"

// Mecha Equipment

/////////////////////////////////////////
/////////// Mecha Equpment /////////////
////////////////////////////////////////

/datum/design/item/mechfab
	build_type = MECHFAB
	category = "Misc"
	time = 10
	materials = list(MATERIAL_STEEL = 10000)
	req_tech = list(TECH_MATERIAL = 1)

/datum/design/item/mechfab/equipment
	category = "Exosuit Equipment"
/*
/datum/design/item/mechfab/equipment/AssembleDesignName()
	..()
	name = "Exosuit module design ([item_name])"
*/
/datum/design/item/mechfab/equipment/AssembleDesignDesc()
	if(!desc)
		desc = "Allows for the construction of \a '[item_name]' exosuit module."

// *** Default equipment *** //
/datum/design/item/mechfab/equipment/default/hydraulic_clamp
	name = "Hydraulic clamp"
	id = "hydraulic_clamp"
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp

/datum/design/item/mechfab/equipment/default/drill
	name = "Drill"
	id = "mech_drill"
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/drill

/datum/design/item/mechfab/equipment/default/extinguisher
	name = "Extinguisher"
	id = "extinguisher"
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/extinguisher

/datum/design/item/mechfab/equipment/default/cable_layer
	name = "Cable layer"
	id = "mech_cable_layer"
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/cable_layer
/*
/datum/design/item/mechfab/equipment/default/flaregun
	name = "Flare launcher"
	id = "mecha_flare_gun"
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/flare
	materials = list(DEFAULT_WALL_MATERIAL = 12500)
*/
/datum/design/item/mechfab/equipment/default/sleeper
	name = "Sleeper"
	id = "mech_sleeper"
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/sleeper
	materials = list(DEFAULT_WALL_MATERIAL = 5000, "glass" = 10000)

/datum/design/item/mechfab/equipment/default/syringe_gun
	name = "Syringe gun"
	id = "mech_syringe_gun"
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/syringe_gun
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 3000, "glass" = 2000)

/datum/design/item/mechfab/equipment/default/passenger
	name = "Passenger compartment"
	id = "mech_passenger"
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/passenger
	materials = list(DEFAULT_WALL_MATERIAL = 5000, "glass" = 5000)

/datum/design/item/mechfab/equipment/default/jetpack
	name = "Mecha jetpack"
	id = "mech_jetpack"
	build_path = /obj/item/mecha_parts/mecha_equipment/jetpack

//obj/item/mecha_parts/mecha_equipment/repair_droid,

/datum/design/item/mechfab/equipment/default/taser
	name = "PBT \"Pacifier\" mounted taser"
	id = "mech_taser"
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/taser

/datum/design/item/mechfab/equipment/default/lmg
	name = "Ultra AC 2"
	id = "mech_lmg"
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg


// *** Weapon modules *** //
/*
/datum/design/item/mechfab/equipment/weapon
	req_tech = list(TECH_COMBAT = 3)
*/

/datum/design/item/mechfab/equipment/weapon/AssembleDesignName()
	..()
	name = "Exosuit weapon ([item_name])"

/datum/design/item/mechfab/equipment/weapon/scattershot
	name = "LBX AC 10 \"Scattershot\""
	id = "mech_scattershot"
	req_tech = list(TECH_COMBAT = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot

/datum/design/item/mechfab/equipment/weapon/laser
	name = "CH-PS \"Immolator\" laser"
	id = "mech_laser"
	req_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser

/datum/design/item/mechfab/equipment/weapon/laser_rigged
	name = "Jury-rigged welder-laser"
	desc = "Allows for the construction of a welder-laser assembly package for non-combat exosuits."
	id = "mech_laser_rigged"
	req_tech = list(TECH_COMBAT = 2, TECH_MAGNET = 2)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/riggedlaser

/datum/design/item/mechfab/equipment/weapon/laser_heavy
	name = "CH-LC \"Solaris\" laser cannon"
	id = "mech_laser_heavy"
	req_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy

/datum/design/item/mechfab/equipment/weapon/ion
	name = "mkIV ion heavy cannon"
	id = "mech_ion"
	req_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/ion

/datum/design/item/mechfab/equipment/weapon/grenade_launcher
	name = "SGL-6 grenade launcher"
	id = "mech_grenade_launcher"
	req_tech = list(TECH_COMBAT = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/flashbang

/datum/design/item/mechfab/equipment/weapon/clusterbang_launcher
	name = "SOP-6 grenade launcher"
	desc = "A weapon that violates the Geneva Convention at 6 rounds per minute."
	id = "clusterbang_launcher"
	req_tech = list(TECH_COMBAT= 5, TECH_MATERIAL = 5, TECH_ILLEGAL = 3)
	materials = list(DEFAULT_WALL_MATERIAL = 20000, "gold" = 6000, "uranium" = 6000)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/flashbang/clusterbang/limited

// *** Nonweapon modules *** //
/datum/design/item/mechfab/equipment/wormhole_gen
	name = "Wormhole generator"
	desc = "An exosuit module that can generate small quasi-stable wormholes."
	id = "mech_wormhole_gen"
	req_tech = list(TECH_BLUESPACE = 3, TECH_MAGNET = 2)
	build_path = /obj/item/mecha_parts/mecha_equipment/wormhole_generator

/datum/design/item/mechfab/equipment/teleporter
	name = "Teleporter"
	desc = "An exosuit module that allows teleportation to any position in view."
	id = "mech_teleporter"
	req_tech = list(TECH_BLUESPACE = 6, TECH_MAGNET = 5)
	build_path = /obj/item/mecha_parts/mecha_equipment/teleporter

/datum/design/item/mechfab/equipment/rcd
	name = "RCD"
	desc = "An exosuit-mounted rapid construction device."
	id = "mech_rcd"
	time = 120
	materials = list(DEFAULT_WALL_MATERIAL = 30000, "phoron" = 25000, "silver" = 20000, "gold" = 20000)
	req_tech = list(TECH_MATERIAL = 4, TECH_BLUESPACE = 3, TECH_MAGNET = 4, TECH_POWER = 4, TECH_ENGINEERING = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/rcd

/datum/design/item/mechfab/equipment/gravcatapult
	name = "Gravitational catapult"
	desc = "An exosuit-mounted gravitational catapult."
	id = "mech_gravcatapult"
	req_tech = list(TECH_BLUESPACE = 2, TECH_MAGNET = 3, TECH_ENGINEERING = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/gravcatapult

/datum/design/item/mechfab/equipment/repair_droid
	name = "Repair droid"
	desc = "Automated repair droid, exosuits' best companion. BEEP BOOP"
	id = "mech_repair_droid"
	req_tech = list(TECH_MAGNET = 3, TECH_DATA = 3, TECH_ENGINEERING = 3)
	materials = list(DEFAULT_WALL_MATERIAL = 10000, "gold" = 1000, "silver" = 2000, "glass" = 5000)
	build_path = /obj/item/mecha_parts/mecha_equipment/repair_droid

/datum/design/item/mechfab/equipment/phoron_generator
	desc = "Exosuit-mounted phoron generator."
	id = "mech_phoron_generator"
	req_tech = list(TECH_PHORON = 2, TECH_POWER = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/mecha_parts/mecha_equipment/generator
	materials = list(DEFAULT_WALL_MATERIAL = 10000, "silver" = 500, "glass" = 1000)

/datum/design/item/mechfab/equipment/energy_relay
	name = "Energy relay"
	id = "mech_energy_relay"
	req_tech = list(TECH_MAGNET = 4, TECH_POWER = 3)
	materials = list(DEFAULT_WALL_MATERIAL = 10000, "gold" = 2000, "silver" = 3000, "glass" = 2000)
	build_path = /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay

/datum/design/item/mechfab/equipment/ccw_armor
	name = "CCW armor booster"
	desc = "Exosuit close-combat armor booster."
	id = "mech_ccw_armor"
	req_tech = list(TECH_MATERIAL = 5, TECH_COMBAT = 4)
	materials = list(DEFAULT_WALL_MATERIAL = 20000, "silver" = 5000)
	build_path = /obj/item/mecha_parts/mecha_equipment/anticcw_armor_booster

/datum/design/item/mechfab/equipment/proj_armor
	desc = "Exosuit projectile armor booster."
	id = "mech_proj_armor"
	req_tech = list(TECH_MATERIAL = 5, TECH_COMBAT = 5, TECH_ENGINEERING = 3)
	materials = list(DEFAULT_WALL_MATERIAL = 20000, "gold" = 5000)
	build_path = /obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster

/datum/design/item/mechfab/equipment/diamond_drill
	name = "Diamond drill"
	desc = "A diamond version of the exosuit drill. It's harder, better, faster, stronger."
	id = "mech_diamond_drill"
	req_tech = list(TECH_MATERIAL = 4, TECH_ENGINEERING = 3)
	materials = list(DEFAULT_WALL_MATERIAL = 10000, "diamond" = 6500)
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/drill/diamonddrill

/datum/design/item/mechfab/equipment/generator_nuclear
	name = "Nuclear reactor"
	desc = "Exosuit-held nuclear reactor. Converts uranium and everyone's health to energy."
	id = "mech_generator_nuclear"
	req_tech = list(TECH_POWER= 3, TECH_ENGINEERING = 3, TECH_MATERIAL = 3)
	materials = list(DEFAULT_WALL_MATERIAL = 10000, "silver" = 500, "glass" = 1000)
	build_path = /obj/item/mecha_parts/mecha_equipment/generator/nuclear
