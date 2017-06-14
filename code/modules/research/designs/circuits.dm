///////////////////////////////////
/////General Type Definitions//////
///////////////////////////////////
/datum/design/circuit
	build_type = IMPRINTER
	req_tech = list(TECH_DATA = 2)
	materials = list(MATERIAL_GLASS = 2000)
	chemicals = list("sacid" = 20)

/datum/design/circuit/AssembleDesignName()
	..()
	name = "Circuit design ([item_name])"

/datum/design/circuit/AssembleDesignDesc()
	if(!desc)
		desc = "Allows for the construction of \a [item_name] circuit board."

///////////////////////////////////
//////////Computer Boards//////////
///////////////////////////////////
/datum/design/circuit/seccamera
	name = "security camera monitor"
	id = "seccamera"
	build_path = /obj/item/weapon/circuitboard/security

/datum/design/circuit/aicore
	name = "AI core"
	id = "aicore"
	req_tech = list(TECH_DATA = 4, TECH_BIO = 3)
	build_path = /obj/item/weapon/circuitboard/aicore

/datum/design/circuit/aiupload
	name = "AI upload console"
	id = "aiupload"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/aiupload

/datum/design/circuit/borgupload
	name = "cyborg upload console"
	id = "borgupload"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/borgupload

/datum/design/circuit/comconsole
	name = "communications console"
	id = "comconsole"
	build_path = /obj/item/weapon/circuitboard/communications

/datum/design/circuit/idcardconsole
	name = "ID card modification console"
	id = "idcardconsole"
	build_path = /obj/item/weapon/circuitboard/card

/datum/design/circuit/emp_data
	name = "employment records console"
	id = "emp_data"
	build_path = /obj/item/weapon/circuitboard/skills

/datum/design/circuit/med_data
	name = "medical records console"
	id = "med_data"
	build_path = /obj/item/weapon/circuitboard/med_data

/datum/design/circuit/secdata
	name = "security records console"
	id = "sec_data"
	build_path = /obj/item/weapon/circuitboard/secure_data

/datum/design/circuit/robocontrol
	name = "robotics control console"
	id = "robocontrol"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/robotics

/datum/design/circuit/arcademachine
	name = "arcade machine"
	id = "arcademachine"
	req_tech = list(TECH_DATA = 1)
	build_path = /obj/item/weapon/circuitboard/arcade

/datum/design/circuit/faxmachine
	name = "fax machine"
	id = "faxmachine"
	req_tech = list(TECH_DATA = 2)
	build_path = /obj/item/weapon/circuitboard/fax

/datum/design/circuit/commandfaxmachine
	name = "fax machine - command"
	id = "commandfaxmachine"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/fax/command

/datum/design/circuit/prisonmanage
	name = "prisoner management console"
	id = "prisonmanage"
	build_path = /obj/item/weapon/circuitboard/prisoner

/datum/design/circuit/rdconsole
	name = "R&D control console"
	id = "rdconsole"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/rdconsole

/datum/design/circuit/ordercomp
	name = "supply ordering console"
	id = "ordercomp"
	build_path = /obj/item/weapon/circuitboard/order

/datum/design/circuit/order/supply
	name = "supply control console"
	id = "supplycomp"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/order/supply

///////////////////////////////////
///////Engineering Machinery///////
///////////////////////////////////
/datum/design/circuit/teleconsole
	name = "teleporter control console"
	id = "teleconsole"
	req_tech = list(TECH_DATA = 3, TECH_BLUESPACE = 2)
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/teleporter

/datum/design/circuit/atmosalerts
	name = "atmosphere alert console"
	id = "atmosalerts"
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/atmos_alert

/datum/design/circuit/air_management
	name = "atmosphere monitoring console"
	id = "air_management"
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/air_management

/datum/design/circuit/rcon_console
	name = "RCON remote control console"
	id = "rcon_console"
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 3, TECH_POWER = 5)
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/rcon_console

/* Uncomment if someone makes these buildable
/datum/design/circuit/general_alert
	name = "general alert console"
	id = "general_alert"
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/general_alert
*/

/datum/design/circuit/dronecontrol
	name = "drone control console"
	id = "dronecontrol"
	req_tech = list(TECH_DATA = 4)
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/drone_control

/datum/design/circuit/powermonitor
	name = "power monitoring console"
	id = "powermonitor"
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/powermonitor

/datum/design/circuit/solarcontrol
	name = "solar control console"
	id = "solarcontrol"
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/solar_control

/datum/design/circuit/gas_heater
	name = "gas heating system"
	id = "gasheater"
	req_tech = list(TECH_POWER = 2, TECH_ENGINEERING = 1)
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/unary_atmos/heater

/datum/design/circuit/gas_cooler
	name = "gas cooling system"
	id = "gascooler"
	req_tech = list(TECH_MAGNET = 2, TECH_ENGINEERING = 2)
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/unary_atmos/cooler

/datum/design/circuit/secure_airlock
	name = "secure airlock electronics"
	desc =  "Allows for the construction of a tamper-resistant airlock electronics."
	id = "securedoor"
	req_tech = list(TECH_DATA = 3)
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/airlock_electronics/secure

///////////////////////////////////
/////////Shield Generators/////////
///////////////////////////////////
/datum/design/circuit/shield
	req_tech = list(TECH_BLUESPACE = 4, TECH_PHORON = 3)
	materials = list(MATERIAL_GLASS = 2000, MATERIAL_DIAMOND = 5000, MATERIAL_GOLD = 10000)
	chemicals = list("sacid" = 20)

/datum/design/circuit/shield/AssembleDesignName()
	name = "Shield generator circuit design ([name])"
/datum/design/circuit/shield/AssembleDesignDesc()
	if(!desc)
		desc = "Allows for the construction of \a [name] shield generator."

/datum/design/circuit/shield/bubble
	name = "bubble"
	id = "shield_gen"
	build_path = /obj/item/weapon/circuitboard/shield_gen

/datum/design/circuit/shield/hull
	name = "hull"
	id = "shield_gen_ex"
	build_path = /obj/item/weapon/circuitboard/shield_gen_ex

/datum/design/circuit/shield/capacitor
	name = "capacitor"
	desc = "Allows for the construction of a shield capacitor circuit board."
	id = "shield_cap"
	req_tech = list(TECH_MAGNET = 3, TECH_POWER = 4)
	build_path = /obj/item/weapon/circuitboard/shield_cap

/datum/design/circuit/aifixer
	name = "AI integrity restorer"
	id = "aifixer"
	req_tech = list(TECH_DATA = 3, TECH_BIO = 2)
	build_path = /obj/item/weapon/circuitboard/aifixer

///////////////////////////////////
/////////Medical Machinery/////////
///////////////////////////////////
/datum/design/circuit/operating
	name = "patient monitoring console"
	id = "operating"
	category = TECH_BIO
	build_path = /obj/item/weapon/circuitboard/operating

/datum/design/circuit/scan_console
	name = "DNA machine"
	id = "scan_console"
	category = TECH_BIO
	build_path = /obj/item/weapon/circuitboard/scan_consolenew

/datum/design/circuit/crewconsole
	name = "crew monitoring console"
	id = "crewconsole"
	req_tech = list(TECH_DATA = 3, TECH_MAGNET = 2, TECH_BIO = 2)
	category = TECH_BIO
	build_path = /obj/item/weapon/circuitboard/crew

/datum/design/circuit/clonecontrol
	name = "cloning control console"
	id = "clonecontrol"
	req_tech = list(TECH_DATA = 3, TECH_BIO = 3)
	category = TECH_BIO
	build_path = /obj/item/weapon/circuitboard/cloning

/datum/design/circuit/clonepod
	name = "clone pod"
	id = "clonepod"
	req_tech = list(TECH_DATA = 3, TECH_BIO = 3)
	category = TECH_BIO
	build_path = /obj/item/weapon/circuitboard/clonepod

/datum/design/circuit/clonescanner
	name = "cloning scanner"
	id = "clonescanner"
	req_tech = list(TECH_DATA = 3, TECH_BIO = 3)
	category = TECH_BIO
	build_path = /obj/item/weapon/circuitboard/clonescanner

/datum/design/circuit/bioprinter
	name = "bioprinter"
	id = "bioprinter"
	req_tech = list(TECH_DATA = 4, TECH_BIO = 5)
	category = TECH_BIO
	build_path = /obj/item/weapon/circuitboard/bioprinter

///////////////////////////////////
////////Telecomms Machinery////////
///////////////////////////////////
/datum/design/circuit/tcommsat
	category = "Telecomms"
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 4)

/datum/design/circuit/tcommsat/AssembleDesignName()
	name = "Telecommunications machinery circuit design ([name])"
/datum/design/circuit/tcommsat/AssembleDesignDesc()
	desc = "Allows for the construction of a telecommunications [name] circuit board."

/datum/design/circuit/tcommsat/monitor
	name = "telecommunications monitoring console"
	id = "comm_monitor"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/comm_monitor

/datum/design/circuit/tcommsat/server
	name = "telecommunications server monitoring console"
	id = "comm_server"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/comm_server

/datum/design/circuit/tcommsat/message_monitor
	name = "messaging monitor console"
	id = "message_monitor"
	req_tech = list(TECH_DATA = 5)
	build_path = /obj/item/weapon/circuitboard/message_monitor

/datum/design/circuit/tcommsat/traffic_control
	name = "traffic control console"
	id = "traffic_control"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/comm_traffic

/datum/design/circuit/tcommsat/server
	name = "server mainframe"
	id = "tcom-server"
	build_path = /obj/item/weapon/circuitboard/telecomms/server

/datum/design/circuit/tcommsat/processor
	name = "processor unit"
	id = "tcom-processor"
	build_path = /obj/item/weapon/circuitboard/telecomms/processor

/datum/design/circuit/tcommsat/bus
	name = "bus mainframe"
	id = "tcom-bus"
	build_path = /obj/item/weapon/circuitboard/telecomms/bus

/datum/design/circuit/tcommsat/hub
	name = "hub mainframe"
	id = "tcom-hub"
	build_path = /obj/item/weapon/circuitboard/telecomms/hub

/datum/design/circuit/tcommsat/relay
	name = "relay mainframe"
	id = "tcom-relay"
	req_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 4, TECH_BLUESPACE = 3)
	build_path = /obj/item/weapon/circuitboard/telecomms/relay

/datum/design/circuit/tcommsat/broadcaster
	name = "subspace broadcaster"
	id = "tcom-broadcaster"
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 4, TECH_BLUESPACE = 2)
	build_path = /obj/item/weapon/circuitboard/telecomms/broadcaster

/datum/design/circuit/tcommsat/receiver
	name = "subspace receiver"
	id = "tcom-receiver"
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 3, TECH_BLUESPACE = 2)
	build_path = /obj/item/weapon/circuitboard/telecomms/receiver

/datum/design/circuit/tcommsat/bluespacerelay
	name = "emergency bluespace relay"
	id = "bluespace-relay"
	req_tech = list(TECH_DATA = 4, TECH_BLUESPACE = 4)
	build_path = /obj/item/weapon/circuitboard/bluespacerelay

////////////////////////////////////////
//////////Misc Circuit Boards///////////
////////////////////////////////////////

/datum/design/circuit/destructive_analyzer
	name = "destructive analyzer"
	id = "destructive_analyzer"
	req_tech = list(TECH_DATA = 2, TECH_MAGNET = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/destructive_analyzer

/datum/design/circuit/protolathe
	name = "protolathe"
	id = "protolathe"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/protolathe

/datum/design/circuit/circuit_imprinter
	name = "circuit imprinter"
	id = "circuit_imprinter"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/circuit_imprinter

/datum/design/circuit/autolathe
	name = "autolathe board"
	id = "autolathe"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/autolathe

/datum/design/circuit/autolathe/industrial
	name = "industrial autolathe board"
	id = "autolathe_industrial"
	req_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 4)
	build_path = /obj/item/weapon/circuitboard/autolathe/industrial

/datum/design/circuit/rdservercontrol
	name = "R&D server control console"
	id = "rdservercontrol"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/rdservercontrol

/datum/design/circuit/rdserver
	name = "R&D server"
	id = "rdserver"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/rdserver

/datum/design/circuit/PDApainter
	name = "PDA painter board"
	id = "pda_painter"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/pdapainter

/datum/design/circuit/biogenerator
	name = "biogenerator"
	id = "biogenerator"
	req_tech = list(TECH_DATA = 2)
	build_path = /obj/item/weapon/circuitboard/biogenerator

/datum/design/circuit/recharge_station
	name = "cyborg recharge station"
	id = "recharge_station"
	req_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/recharge_station

/////////////////////////////////////////
////////Power Stuff Circuitboards////////
/////////////////////////////////////////
/datum/design/circuit/pacman
	name = "PACMAN-type generator"
	id = "pacman"
	req_tech = list(TECH_DATA = 3, TECH_PHORON = 3, TECH_POWER = 3, TECH_ENGINEERING = 3)
	reliability_base = 79
	materials = list(MATERIAL_GLASS = 2000)
	chemicals = list("sacid" = 20)
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/pacman

/datum/design/circuit/superpacman
	name = "SUPERPACMAN-type generator"
	id = "superpacman"
	req_tech = list(TECH_DATA = 3, TECH_POWER = 4, TECH_ENGINEERING = 4)
	reliability_base = 76
	materials = list(MATERIAL_GLASS = 2000)
	chemicals = list("sacid" = 20)
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/pacman/super

/datum/design/circuit/mrspacman
	name = "MRSPACMAN-type generator"
	id = "mrspacman"
	req_tech = list(TECH_DATA = 3, TECH_POWER = 5, TECH_ENGINEERING = 5)
	reliability_base = 74
	materials = list(MATERIAL_GLASS = 2000)
	chemicals = list("sacid" = 20)
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/pacman/mrs

/datum/design/circuit/batteryrack
	name = "cell rack PSU"
	id = "batteryrack"
	req_tech = list(TECH_POWER = 3, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_GLASS = 2000)
	chemicals = list("sacid" = 20)
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/batteryrack

/datum/design/circuit/smes_cell
	name = "'SMES' superconductive magnetic energy storage"
	desc = "Allows for the construction of circuit boards used to build a SMES."
	id = "smes_cell"
	req_tech = list(TECH_POWER = 7, TECH_ENGINEERING = 5)
	//A uniquely-priced board; probably not the best idea
	materials = list(MATERIAL_GLASS = 2000, MATERIAL_GOLD = 1000, MATERIAL_SILVER = 1000, MATERIAL_DIAMOND = 500)
	chemicals = list("sacid" = 20)
	category = TECH_ENGINEERING
	build_path = /obj/item/weapon/circuitboard/smes

