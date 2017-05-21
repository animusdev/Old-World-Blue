/datum/design/circuit/mechacontrol
	name = "exosuit control console"
	id = "mechacontrol"
	category = "Mechas"
	req_tech = list("programming" = 3)
	build_path = /obj/item/weapon/circuitboard/mecha_control

/datum/design/circuit/mechapower
	name = "mech bay power control console"
	id = "mechapower"
	category = "Mechas"
	build_path = /obj/item/weapon/circuitboard/mech_bay_power_console

/datum/design/circuit/mechfab
	name = "exosuit fabricator"
	id = "mechfab"
	category = "Mechas"
	req_tech = list("programming" = 3, "engineering" = 3)
	build_path = /obj/item/weapon/circuitboard/mechfab

///////////////////////////////////
////////////Mecha Modules//////////
///////////////////////////////////
/datum/design/circuit/mecha
	category = "Mechas"
	req_tech = list("programming" = 3)

/datum/design/circuit/mecha/AssembleDesignName()
	name = "Exosuit module circuit design ([name])"
/datum/design/circuit/mecha/AssembleDesignDesc()
	desc = "Allows for the construction of \a [name] module."

//Ripley ==============================================================

/datum/design/circuit/mecha/ripley_main
	name = "APLU 'Ripley' central control"
	id = "ripley_main"
	build_path = /obj/item/weapon/circuitboard/mecha/ripley/main

/datum/design/circuit/mecha/ripley_peri
	name = "APLU 'Ripley' peripherals control"
	id = "ripley_peri"
	build_path = /obj/item/weapon/circuitboard/mecha/ripley/peripherals

//Odysseus==============================================================

/datum/design/circuit/mecha/odysseus_main
	name = "'Odysseus' central control"
	id = "odysseus_main"
	req_tech = list("programming" = 3,"biotech" = 2)
	build_path = /obj/item/weapon/circuitboard/mecha/odysseus/main

/datum/design/circuit/mecha/odysseus_peri
	name = "'Odysseus' peripherals control"
	id = "odysseus_peri"
	req_tech = list("programming" = 3,"biotech" = 2)
	build_path = /obj/item/weapon/circuitboard/mecha/odysseus/peripherals

//Gygax==============================================================

/datum/design/circuit/mecha/gygax_main
	name = "'Gygax' central control"
	id = "gygax_main"
	req_tech = list("programming" = 4)
	build_path = /obj/item/weapon/circuitboard/mecha/gygax/main

/datum/design/circuit/mecha/gygax_peri
	name = "'Gygax' peripherals control"
	id = "gygax_peri"
	req_tech = list("programming" = 4)
	build_path = /obj/item/weapon/circuitboard/mecha/gygax/peripherals

/datum/design/circuit/mecha/gygax_targ
	name = "'Gygax' weapon control and targeting"
	id = "gygax_targ"
	req_tech = list("programming" = 4, "combat" = 2)
	build_path = /obj/item/weapon/circuitboard/mecha/gygax/targeting

//Durand==============================================================

/datum/design/circuit/mecha/durand_main
	name = "'Durand' central control"
	id = "durand_main"
	req_tech = list("programming" = 4)
	build_path = /obj/item/weapon/circuitboard/mecha/durand/main

/datum/design/circuit/mecha/durand_peri
	name = "'Durand' peripherals control"
	id = "durand_peri"
	req_tech = list("programming" = 4)
	build_path = /obj/item/weapon/circuitboard/mecha/durand/peripherals

/datum/design/circuit/mecha/durand_targ
	name = "'Durand' weapon control and targeting"
	id = "durand_targ"
	req_tech = list("programming" = 4, "combat" = 2)
	build_path = /obj/item/weapon/circuitboard/mecha/durand/targeting

//Phazon==============================================================

/datum/design/circuit/mecha/phazon_main
	name = "'Phazon' central control"
	id = "phazon_main"
	req_tech = list("programming" = 4, "bluespace" = 3)
	build_path = /obj/item/weapon/circuitboard/mecha/phazon/main

/datum/design/circuit/mecha/phazon_peri
	name = "'Phazon' peripherals control"
	id = "phazon_peri"
	req_tech = list("programming" = 4, "bluespace" = 3)
	build_path = /obj/item/weapon/circuitboard/mecha/phazon/peripherals

/datum/design/circuit/mecha/phazon_targ
	name = "'Phazon' weapon control and targeting"
	id = "phazon_targ"
	req_tech = list("programming" = 4, "combat" = 2, "bluespace" = 6)
	build_path = /obj/item/weapon/circuitboard/mecha/phazon/targeting


////////////////////////////////////////
/////////// Mecha Equpment /////////////
////////////////////////////////////////

datum/design/item/mechfab
	build_type = MECHFAB
	category = "Misc"
	time = 10
	materials = list(DEFAULT_WALL_MATERIAL = 10000)
	req_tech = list(TECH_MATERIAL = 1)

/datum/design/item/mechfab/equipment
	req_tech = list("combat" = 3)
	category = "Exosuit Equipment"

/datum/design/item/mechfab/equipment/AssembleDesignName()
	..()
	name = "Exosuit module design ([item_name])"

/datum/design/item/mechfab/equipment/weapon/AssembleDesignName()
	..()
	name = "Exosuit weapon design ([item_name])"

/datum/design/item/mechfab/equipment/AssembleDesignDesc()
	if(!desc)
		desc = "Allows for the construction of \a '[item_name]' exosuit module."

// *** Weapon modules
/datum/design/item/mechfab/equipment/weapon/scattershot
	id = "mech_scattershot"
	req_tech = list("combat" = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot

/datum/design/item/mechfab/equipment/weapon/laser
	id = "mech_laser"
	req_tech = list("combat" = 3, "magnets" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser

/datum/design/item/mechfab/equipment/weapon/laser_rigged
	desc = "Allows for the construction of a welder-laser assembly package for non-combat exosuits."
	id = "mech_laser_rigged"
	req_tech = list("combat" = 2, "magnets" = 2)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/riggedlaser

/datum/design/item/mechfab/equipment/weapon/laser_heavy
	id = "mech_laser_heavy"
	req_tech = list("combat" = 4, "magnets" = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy

/datum/design/item/mechfab/equipment/weapon/ion
	id = "mech_ion"
	req_tech = list("combat" = 4, "magnets" = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/ion

/datum/design/item/mechfab/equipment/weapon/grenade_launcher
	id = "mech_grenade_launcher"
	req_tech = list("combat" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/flashbang

/datum/design/item/mechfab/equipment/weapon/clusterbang_launcher
	desc = "A weapon that violates the Geneva Convention at 6 rounds per minute."
	id = "clusterbang_launcher"
	req_tech = list("combat"= 5, "materials" = 5, "syndicate" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/flashbang/clusterbang/limited

// *** Nonweapon modules
/datum/design/item/mechfab/equipment/wormhole_gen
	desc = "An exosuit module that can generate small quasi-stable wormholes."
	id = "mech_wormhole_gen"
	req_tech = list("bluespace" = 3, "magnets" = 2)
	build_path = /obj/item/mecha_parts/mecha_equipment/wormhole_generator

/datum/design/item/mechfab/equipment/teleporter
	desc = "An exosuit module that allows teleportation to any position in view."
	id = "mech_teleporter"
	req_tech = list("bluespace" = 6, "magnets" = 5)
	build_path = /obj/item/mecha_parts/mecha_equipment/teleporter

/datum/design/item/mechfab/equipment/rcd
	desc = "An exosuit-mounted rapid construction device."
	id = "mech_rcd"
	req_tech = list("materials" = 4, "bluespace" = 3, "magnets" = 4, "powerstorage"=4, "engineering" = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/rcd

/datum/design/item/mechfab/equipment/gravcatapult
	desc = "An exosuit-mounted gravitational catapult."
	id = "mech_gravcatapult"
	req_tech = list("bluespace" = 2, "magnets" = 3, "engineering" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/gravcatapult

/datum/design/item/mechfab/equipment/repair_droid
	desc = "Automated repair droid, exosuits' best companion. BEEP BOOP"
	id = "mech_repair_droid"
	req_tech = list("magnets" = 3, "programming" = 3, "engineering" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/repair_droid

/datum/design/item/mechfab/equipment/phoron_generator
	desc = "Exosuit-mounted phoron generator."
	id = "mech_phoron_generator"
	req_tech = list("phorontech" = 2, "powerstorage"= 2, "engineering" = 2)
	build_path = /obj/item/mecha_parts/mecha_equipment/generator

/datum/design/item/mechfab/equipment/energy_relay
	id = "mech_energy_relay"
	req_tech = list("magnets" = 4, "powerstorage" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay

/datum/design/item/mechfab/equipment/ccw_armor
	desc = "Exosuit close-combat armor booster."
	id = "mech_ccw_armor"
	req_tech = list("materials" = 5, "combat" = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/anticcw_armor_booster

/datum/design/item/mechfab/equipment/proj_armor
	desc = "Exosuit projectile armor booster."
	id = "mech_proj_armor"
	req_tech = list("materials" = 5, "combat" = 5, "engineering"=3)
	build_path = /obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster

/datum/design/item/mechfab/equipment/syringe_gun
	desc = "Exosuit-mounted syringe gun and chemical synthesizer."
	id = "mech_syringe_gun"
	req_tech = list("materials" = 3, "biotech"=4, "magnets"=4, "programming"=3)
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/syringe_gun

/datum/design/item/mechfab/equipment/diamond_drill
	desc = "A diamond version of the exosuit drill. It's harder, better, faster, stronger."
	id = "mech_diamond_drill"
	req_tech = list("materials" = 4, "engineering" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/drill/diamonddrill

/datum/design/item/mechfab/equipment/generator_nuclear
	desc = "Exosuit-held nuclear reactor. Converts uranium and everyone's health to energy."
	id = "mech_generator_nuclear"
	req_tech = list("powerstorage"= 3, "engineering" = 3, "materials" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/generator/nuclear


/datum/design/item/mechfab/ripley
	category = "Ripley"
	time = 15

/datum/design/item/mechfab/ripley/chassis
	name = "Ripley chassis"
	id = "ripley_chassis"
	build_path = /obj/item/mecha_parts/chassis/ripley
	time = 10
	materials = list(DEFAULT_WALL_MATERIAL = 20000)

/datum/design/item/mechfab/ripley/chassis/firefighter
	name = "Firefigher chassis"
	id = "firefighter_chassis"
	build_path = /obj/item/mecha_parts/chassis/firefighter

/datum/design/item/mechfab/ripley/torso
	name = "Ripley torso"
	id = "ripley_torso"
	build_path = /obj/item/mecha_parts/part/ripley/torso
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 40000, "glass" = 15000)

/datum/design/item/mechfab/ripley/left_arm
	name = "Ripley left arm"
	id = "ripley_left_arm"
	build_path = /obj/item/mecha_parts/part/ripley/left_arm
	materials = list(DEFAULT_WALL_MATERIAL = 25000)

/datum/design/item/mechfab/ripley/right_arm
	name = "Ripley right arm"
	id = "ripley_right_arm"
	build_path = /obj/item/mecha_parts/part/ripley/right_arm
	materials = list(DEFAULT_WALL_MATERIAL = 25000)

/datum/design/item/mechfab/ripley/left_leg
	name = "Ripley left leg"
	id = "ripley_left_leg"
	build_path = /obj/item/mecha_parts/part/ripley/left_leg
	materials = list(DEFAULT_WALL_MATERIAL = 30000)

/datum/design/item/mechfab/ripley/right_leg
	name = "Ripley right leg"
	id = "ripley_right_leg"
	build_path = /obj/item/mecha_parts/part/ripley/right_leg
	materials = list(DEFAULT_WALL_MATERIAL = 30000)


/datum/design/item/mechfab/odysseus
	category = "Odysseus"

/datum/design/item/mechfab/odysseus/chassis
	name = "Odysseus chassis"
	id = "odysseus_chassis"
	build_path = /obj/item/mecha_parts/chassis/odysseus
	time = 10
	materials = list(DEFAULT_WALL_MATERIAL = 20000)

/datum/design/item/mechfab/odysseus/torso
	name = "Odysseus torso"
	id = "odysseus_torso"
	build_path = /obj/item/mecha_parts/part/odysseus/torso
	time = 18
	materials = list(DEFAULT_WALL_MATERIAL = 25000)

/datum/design/item/mechfab/odysseus/head
	name = "Odysseus head"
	id = "odysseus_head"
	build_path = /obj/item/mecha_parts/part/odysseus/head
	time = 10
	materials = list(DEFAULT_WALL_MATERIAL = 2000, "glass" = 10000)

/datum/design/item/mechfab/odysseus/left_arm
	name = "Odysseus left arm"
	id = "odysseus_left_arm"
	build_path = /obj/item/mecha_parts/part/odysseus/left_arm
	time = 12
	materials = list(DEFAULT_WALL_MATERIAL = 10000)

/datum/design/item/mechfab/odysseus/right_arm
	name = "Odysseus right arm"
	id = "odysseus_right_arm"
	build_path = /obj/item/mecha_parts/part/odysseus/right_arm
	time = 12
	materials = list(DEFAULT_WALL_MATERIAL = 10000)

/datum/design/item/mechfab/odysseus/left_leg
	name = "Odysseus left leg"
	id = "odysseus_left_leg"
	build_path = /obj/item/mecha_parts/part/odysseus/left_leg
	time = 13
	materials = list(DEFAULT_WALL_MATERIAL = 15000)

/datum/design/item/mechfab/odysseus/right_leg
	name = "Odysseus right leg"
	id = "odysseus_right_leg"
	build_path = /obj/item/mecha_parts/part/odysseus/right_leg
	time = 13
	materials = list(DEFAULT_WALL_MATERIAL = 15000)

/datum/design/item/mechfab/gygax
	category = "Gygax"
	time = 20

/datum/design/item/mechfab/gygax/chassis
	name = "Gygax chassis"
	id = "gygax_chassis"
	build_path = /obj/item/mecha_parts/chassis/gygax
	time = 10
	materials = list(DEFAULT_WALL_MATERIAL = 25000)

/datum/design/item/mechfab/gygax/torso
	name = "Gygax torso"
	id = "gygax_torso"
	build_path = /obj/item/mecha_parts/part/gygax/torso
	time = 30
	materials = list(DEFAULT_WALL_MATERIAL = 50000, "glass" = 20000)

/datum/design/item/mechfab/gygax/head
	name = "Gygax head"
	id = "gygax_head"
	build_path = /obj/item/mecha_parts/part/gygax/head
	materials = list(DEFAULT_WALL_MATERIAL = 20000, "glass" = 10000)

/datum/design/item/mechfab/gygax/left_arm
	name = "Gygax left arm"
	id = "gygax_left_arm"
	build_path = /obj/item/mecha_parts/part/gygax/left_arm
	materials = list(DEFAULT_WALL_MATERIAL = 30000)

/datum/design/item/mechfab/gygax/right_arm
	name = "Gygax right arm"
	id = "gygax_right_arm"
	build_path = /obj/item/mecha_parts/part/gygax/right_arm
	materials = list(DEFAULT_WALL_MATERIAL = 30000)

/datum/design/item/mechfab/gygax/left_leg
	name = "Gygax left leg"
	id = "gygax_left_leg"
	build_path = /obj/item/mecha_parts/part/gygax/left_leg
	materials = list(DEFAULT_WALL_MATERIAL = 35000)

/datum/design/item/mechfab/gygax/right_leg
	name = "Gygax right leg"
	id = "gygax_right_leg"
	build_path = /obj/item/mecha_parts/part/gygax/right_leg
	materials = list(DEFAULT_WALL_MATERIAL = 35000)

/datum/design/item/mechfab/gygax/armour
	name = "Gygax armour plates"
	id = "gygax_armour"
	build_path = /obj/item/mecha_parts/part/gygax/armour
	time = 60
	materials = list(DEFAULT_WALL_MATERIAL = 50000, "diamond" = 10000)

/datum/design/item/mechfab/durand
	category = "Durand"
	time = 20

/datum/design/item/mechfab/durand/chassis
	name = "Durand chassis"
	id = "durand_chassis"
	build_path = /obj/item/mecha_parts/chassis/durand
	time = 10
	materials = list(DEFAULT_WALL_MATERIAL = 25000)

/datum/design/item/mechfab/durand/torso
	name = "Durand torso"
	id = "durand_torso"
	build_path = /obj/item/mecha_parts/part/durand/torso
	time = 30
	materials = list(DEFAULT_WALL_MATERIAL = 55000, "glass" = 20000, "silver" = 10000)

/datum/design/item/mechfab/durand/head
	name = "Durand head"
	id = "durand_head"
	build_path = /obj/item/mecha_parts/part/durand/head
	materials = list(DEFAULT_WALL_MATERIAL = 25000, "glass" = 10000, "silver" = 3000)

/datum/design/item/mechfab/durand/left_arm
	name = "Durand left arm"
	id = "durand_left_arm"
	build_path = /obj/item/mecha_parts/part/durand/left_arm
	materials = list(DEFAULT_WALL_MATERIAL = 35000, "silver" = 3000)

/datum/design/item/mechfab/durand/right_arm
	name = "Durand right arm"
	id = "durand_right_arm"
	build_path = /obj/item/mecha_parts/part/durand/right_arm
	materials = list(DEFAULT_WALL_MATERIAL = 35000, "silver" = 3000)

/datum/design/item/mechfab/durand/left_leg
	name = "Durand left leg"
	id = "durand_left_leg"
	build_path = /obj/item/mecha_parts/part/durand/left_leg
	materials = list(DEFAULT_WALL_MATERIAL = 40000, "silver" = 3000)

/datum/design/item/mechfab/durand/right_leg
	name = "Durand right leg"
	id = "durand_right_leg"
	build_path = /obj/item/mecha_parts/part/durand/right_leg
	materials = list(DEFAULT_WALL_MATERIAL = 40000, "silver" = 3000)

/datum/design/item/mechfab/durand/armour
	name = "Durand armour plates"
	id = "durand_armour"
	build_path = /obj/item/mecha_parts/part/durand/armour
	time = 60
	materials = list(DEFAULT_WALL_MATERIAL = 50000, "uranium" = 10000)

/datum/design/item/mechfab/phazon
	category = "Phazon"
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL=20000,"phoron"=10000,"silver"=3000)

/datum/design/item/mechfab/phazon/chassis
	name = "Phazon chassis"
	id = "phazon_chassis"
	build_path = /obj/item/mecha_parts/chassis/phazon
	time = 10
	materials = list(DEFAULT_WALL_MATERIAL = 25000)

/datum/design/item/mechfab/phazon/torso
	name = "Phazon torso"
	id = "phazon_torso"
	build_path = /obj/item/mecha_parts/part/phazon/torso
	time = 30
	materials = list(DEFAULT_WALL_MATERIAL=35000,"glass"=10000,"phoron"=20000)

/datum/design/item/mechfab/phazon/head
	name = "Phazon head"
	id = "phazon_head"
	build_path = /obj/item/mecha_parts/part/phazon/head
	materials = list(DEFAULT_WALL_MATERIAL=15000,"glass"=5000,"phoron"=10000,"silver"=3000)

/datum/design/item/mechfab/phazon/left_arm
	name = "Phazon left arm"
	id = "phazon_left_arm"
	build_path = /obj/item/mecha_parts/part/phazon/left_arm

/datum/design/item/mechfab/phazon/right_arm
	name = "Phazon right arm"
	id = "phazon_right_arm"
	build_path = /obj/item/mecha_parts/part/phazon/right_arm

/datum/design/item/mechfab/phazon/left_leg
	name = "Phazon left leg"
	id = "phazon_left_leg"
	build_path = /obj/item/mecha_parts/part/phazon/left_leg

/datum/design/item/mechfab/phazon/right_leg
	name = "Phazon right leg"
	id = "phazon_right_leg"
	build_path = /obj/item/mecha_parts/part/phazon/right_leg

/datum/design/item/mechfab/phazon/armour
	name = "Phazon armour plates"
	id = "phazon_armour"
	build_path = /obj/item/mecha_parts/part/phazon/armor
	time = 60
	materials = list(DEFAULT_WALL_MATERIAL=20000,"phoron"=10000,"uranium"=10000,"silver"=3000,"diamond"=1000)

