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

/datum/design/item/mecha
	build_type = MECHFAB
	req_tech = list("combat" = 3)
	category = "Exosuit Equipment"

/datum/design/item/mecha/AssembleDesignName()
	..()
	name = "Exosuit module design ([item_name])"

/datum/design/item/mecha/weapon/AssembleDesignName()
	..()
	name = "Exosuit weapon design ([item_name])"

/datum/design/item/mecha/AssembleDesignDesc()
	if(!desc)
		desc = "Allows for the construction of \a '[item_name]' exosuit module."

// *** Weapon modules
/datum/design/item/mecha/weapon/scattershot
	id = "mech_scattershot"
	req_tech = list("combat" = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot

/datum/design/item/mecha/weapon/laser
	id = "mech_laser"
	req_tech = list("combat" = 3, "magnets" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser

/datum/design/item/mecha/weapon/laser_rigged
	desc = "Allows for the construction of a welder-laser assembly package for non-combat exosuits."
	id = "mech_laser_rigged"
	req_tech = list("combat" = 2, "magnets" = 2)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/riggedlaser

/datum/design/item/mecha/weapon/laser_heavy
	id = "mech_laser_heavy"
	req_tech = list("combat" = 4, "magnets" = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy

/datum/design/item/mecha/weapon/ion
	id = "mech_ion"
	req_tech = list("combat" = 4, "magnets" = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/energy/ion

/datum/design/item/mecha/weapon/grenade_launcher
	id = "mech_grenade_launcher"
	req_tech = list("combat" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/flashbang

/datum/design/item/mecha/weapon/clusterbang_launcher
	desc = "A weapon that violates the Geneva Convention at 6 rounds per minute."
	id = "clusterbang_launcher"
	req_tech = list("combat"= 5, "materials" = 5, "syndicate" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/flashbang/clusterbang/limited

// *** Nonweapon modules
/datum/design/item/mecha/wormhole_gen
	desc = "An exosuit module that can generate small quasi-stable wormholes."
	id = "mech_wormhole_gen"
	req_tech = list("bluespace" = 3, "magnets" = 2)
	build_path = /obj/item/mecha_parts/mecha_equipment/wormhole_generator

/datum/design/item/mecha/teleporter
	desc = "An exosuit module that allows teleportation to any position in view."
	id = "mech_teleporter"
	req_tech = list("bluespace" = 6, "magnets" = 5)
	build_path = /obj/item/mecha_parts/mecha_equipment/teleporter

/datum/design/item/mecha/rcd
	desc = "An exosuit-mounted rapid construction device."
	id = "mech_rcd"
	req_tech = list("materials" = 4, "bluespace" = 3, "magnets" = 4, "powerstorage"=4, "engineering" = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/rcd

/datum/design/item/mecha/gravcatapult
	desc = "An exosuit-mounted gravitational catapult."
	id = "mech_gravcatapult"
	req_tech = list("bluespace" = 2, "magnets" = 3, "engineering" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/gravcatapult

/datum/design/item/mecha/repair_droid
	desc = "Automated repair droid, exosuits' best companion. BEEP BOOP"
	id = "mech_repair_droid"
	req_tech = list("magnets" = 3, "programming" = 3, "engineering" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/repair_droid

/datum/design/item/mecha/phoron_generator
	desc = "Exosuit-mounted phoron generator."
	id = "mech_phoron_generator"
	req_tech = list("phorontech" = 2, "powerstorage"= 2, "engineering" = 2)
	build_path = /obj/item/mecha_parts/mecha_equipment/generator

/datum/design/item/mecha/energy_relay
	id = "mech_energy_relay"
	req_tech = list("magnets" = 4, "powerstorage" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay

/datum/design/item/mecha/ccw_armor
	desc = "Exosuit close-combat armor booster."
	id = "mech_ccw_armor"
	req_tech = list("materials" = 5, "combat" = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/anticcw_armor_booster

/datum/design/item/mecha/proj_armor
	desc = "Exosuit projectile armor booster."
	id = "mech_proj_armor"
	req_tech = list("materials" = 5, "combat" = 5, "engineering"=3)
	build_path = /obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster

/datum/design/item/mecha/syringe_gun
	desc = "Exosuit-mounted syringe gun and chemical synthesizer."
	id = "mech_syringe_gun"
	req_tech = list("materials" = 3, "biotech"=4, "magnets"=4, "programming"=3)
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/syringe_gun

/datum/design/item/mecha/diamond_drill
	desc = "A diamond version of the exosuit drill. It's harder, better, faster, stronger."
	id = "mech_diamond_drill"
	req_tech = list("materials" = 4, "engineering" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/tool/drill/diamonddrill

/datum/design/item/mecha/generator_nuclear
	desc = "Exosuit-held nuclear reactor. Converts uranium and everyone's health to energy."
	id = "mech_generator_nuclear"
	req_tech = list("powerstorage"= 3, "engineering" = 3, "materials" = 3)
	build_path = /obj/item/mecha_parts/mecha_equipment/generator/nuclear
