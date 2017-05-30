datum/design/circuit/mechacontrol
	name = "exosuit control console"
	id = "mechacontrol"
	category = "Mechas"
	req_tech = list(TECH_DATA = 3)
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
	req_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 3)
	build_path = /obj/item/weapon/circuitboard/mechfab

///////////////////////////////////
////////////Mecha Modules//////////
///////////////////////////////////
/datum/design/circuit/mecha
	category = "Mechas"
	req_tech = list(TECH_DATA = 3)

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
	req_tech = list(TECH_DATA = 3,TECH_BIO = 2)
	build_path = /obj/item/weapon/circuitboard/mecha/odysseus/main

/datum/design/circuit/mecha/odysseus_peri
	name = "'Odysseus' peripherals control"
	id = "odysseus_peri"
	req_tech = list(TECH_DATA = 3,TECH_BIO = 2)
	build_path = /obj/item/weapon/circuitboard/mecha/odysseus/peripherals

//Gygax==============================================================

/datum/design/circuit/mecha/gygax_main
	name = "'Gygax' central control"
	id = "gygax_main"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/mecha/gygax/main

/datum/design/circuit/mecha/gygax_peri
	name = "'Gygax' peripherals control"
	id = "gygax_peri"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/mecha/gygax/peripherals

/datum/design/circuit/mecha/gygax_targ
	name = "'Gygax' weapon control and targeting"
	id = "gygax_targ"
	req_tech = list(TECH_DATA = 4, TECH_COMBAT = 2)
	build_path = /obj/item/weapon/circuitboard/mecha/gygax/targeting

//Durand==============================================================

/datum/design/circuit/mecha/durand_main
	name = "'Durand' central control"
	id = "durand_main"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/mecha/durand/main

/datum/design/circuit/mecha/durand_peri
	name = "'Durand' peripherals control"
	id = "durand_peri"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/mecha/durand/peripherals

/datum/design/circuit/mecha/durand_targ
	name = "'Durand' weapon control and targeting"
	id = "durand_targ"
	req_tech = list(TECH_DATA = 4, TECH_COMBAT = 2)
	build_path = /obj/item/weapon/circuitboard/mecha/durand/targeting

//Phazon==============================================================

/datum/design/circuit/mecha/phazon_main
	name = "'Phazon' central control"
	id = "phazon_main"
	req_tech = list(TECH_DATA = 4, TECH_BLUESPACE = 3)
	build_path = /obj/item/weapon/circuitboard/mecha/phazon/main

/datum/design/circuit/mecha/phazon_peri
	name = "'Phazon' peripherals control"
	id = "phazon_peri"
	req_tech = list(TECH_DATA = 4, TECH_BLUESPACE = 3)
	build_path = /obj/item/weapon/circuitboard/mecha/phazon/peripherals

/datum/design/circuit/mecha/phazon_targ
	name = "'Phazon' weapon control and targeting"
	id = "phazon_targ"
	req_tech = list(TECH_DATA = 4, TECH_COMBAT = 2, TECH_BLUESPACE = 6)
	build_path = /obj/item/weapon/circuitboard/mecha/phazon/targeting


