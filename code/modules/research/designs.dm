/***************************************************************
**						Design Datums						  **
**	All the data for building stuff and tracking reliability. **
***************************************************************/
/*
For the materials datum, it assumes you need reagents unless specified otherwise. To designate a material that isn't a reagent,
you use one of the material IDs below. These are NOT ids in the usual sense (they aren't defined in the object or part of a datum),
they are simply references used as part of a "has materials?" type proc. They all start with a  to denote that they aren't reagents.

Don't add new keyword/IDs if they are made from an existing one (such as rods which are made from metal). Only add raw materials.

Design Guidlines
- The reliability formula for all R&D built items is reliability_base (a fixed number) + total tech levels required to make it +
reliability_mod (starts at 0, gets improved through experimentation). Example: PACMAN generator. 79 base reliablity + 6 tech
(3 phorontech, 3 powerstorage) + 0 (since it's completely new) = 85% reliability. Reliability is the chance it works CORRECTLY.
- When adding new designs, check rdreadme.dm to see what kind of things have already been made and where new stuff is needed.
- A single sheet of anything is 2000 units of material. Materials besides metal/glass require help from other jobs (mining for
other types of metals and chemistry for reagents).

*/
//Note: More then one of these can be added to a design.

/datum/design						//Datum for object designs, used in construction
	var/name = null					//Name of the created object. If null it will be 'guessed' from build_path if possible.
	var/desc = null					//Description of the created object. If null it will use group_desc and name where applicable.
	var/item_name = null			//An item name before it is modified by various name-modifying procs
	var/id = "id"					//ID of the created object for easy refernece. Alphanumeric, lower-case, no symbols.
	var/list/req_tech = list()		//IDs of that techs the object originated from and the minimum level requirements.
	var/reliability_mod = 0			//Reliability modifier of the device at it's starting point.
	var/reliability_base = 100		//Base reliability of a device before modifiers.
	var/reliability = 100			//Reliability of the device.
	var/build_type = null			//Flag as to what kind machine the design is built in. See defines.
	var/list/materials = list()		//List of materials. Format: "id" = amount.
	var/list/chemicals = list()		//List of chemicals.
	var/build_path = null			//The path of the object that gets created.
	var/time = 10					//How many ticks it requires to build
	var/category = "Misc"			//Primarily used for Mech Fabricators, but can be used for anything.

//A proc to calculate the reliability of a design based on tech levels and innate modifiers.
//Input: A list of /datum/tech; Output: The new reliabilty.
/datum/design/proc/CalcReliability(var/list/temp_techs)
	var/new_reliability = reliability_mod + reliability_base
	for(var/datum/tech/T in temp_techs)
		if(T.id in req_tech)
			new_reliability += T.level
	new_reliability = between(reliability_base, new_reliability, 100)
	reliability = new_reliability
	return

/datum/design/New()
	..()
	item_name = name
	AssembleDesignInfo()

//These procs are used in subtypes for assigning names and descriptions dynamically
/datum/design/proc/AssembleDesignInfo()
	AssembleDesignName()
	AssembleDesignDesc()
	return

/datum/design/proc/AssembleDesignName()
	if(!name && build_path)					//Get name from build path if posible
		var/atom/movable/A = build_path
		name = initial(A.name)
		item_name = name
	return

/datum/design/proc/AssembleDesignDesc()
	if(!desc)								//Try to make up a nice description if we don't have one
		desc = "Allows for the construction of \a [item_name]."
	return

///////////////////////////////////
/////General Type Definitions//////
///////////////////////////////////
/datum/design/item
	build_type = PROTOLATHE

////////////////////////////////////////
//////////Disk Construction Disks///////
////////////////////////////////////////
/datum/design/design_disk
	name = "Design Storage Disk"
	desc = "Produce additional disks for storing device designs."
	id = "design_disk"
	req_tech = list(TECH_DATA = 1)
	build_type = PROTOLATHE
	materials = list(MATERIAL_STEEL = 30, MATERIAL_GLASS = 10)
	build_path = /obj/item/weapon/disk/design_disk

/datum/design/tech_disk
	name = "Technology Data Storage Disk"
	desc = "Produce additional disks for storing technology data."
	id = "tech_disk"
	req_tech = list(TECH_DATA = 1)
	build_type = PROTOLATHE
	materials = list(MATERIAL_STEEL = 30, MATERIAL_GLASS = 10)
	build_path = /obj/item/weapon/disk/tech_disk

///////////////////////////////////
/////Non-Board Computer Stuff//////
///////////////////////////////////

/datum/design/item/intellicard
	name = "'intelliCard', AI preservation and transportation system"
	desc = "Allows for the construction of an intelliCard."
	id = "intellicard"
	req_tech = list(TECH_DATA = 4, TECH_MATERIAL = 4)
	materials = list(MATERIAL_GLASS = 1000, MATERIAL_GOLD = 200)
	build_path = /obj/item/device/aicard

/datum/design/item/paicard
	name = "'pAI', personal artificial intelligence device"
	id = "paicard"
	req_tech = list(TECH_DATA = 2)
	materials = list(MATERIAL_GLASS = 500, MATERIAL_STEEL = 500)
	build_path = /obj/item/device/paicard

/datum/design/item/posibrain
	id = "posibrain"
	req_tech = list(TECH_ENGINEERING = 4, TECH_MATERIAL = 6, TECH_BLUESPACE = 2, TECH_DATA = 4)
	materials = list(MATERIAL_STEEL = 2000, MATERIAL_GLASS = 1000, MATERIAL_SILVER = 1000, MATERIAL_GOLD = 500, MATERIAL_PHORON = 500, MATERIAL_DIAMOND = 100)
	build_path = /obj/item/device/mmi/digital/posibrain

////////////////////////////////////////
/////////////Stock Parts////////////////
////////////////////////////////////////
/datum/design/item/stock_part
	category = "Stock parts"
	build_type = PROTOLATHE

/datum/design/item/stock_part/AssembleDesignName()
	..()
	name = "Component design ([item_name])"

/datum/design/item/stock_part/AssembleDesignDesc()
	if(!desc)
		desc = "A stock part used in the construction of various devices."

/datum/design/item/stock_part/RPED
	name = "Rapid Part Exchange Device"
	desc = "Special mechanical module made to store, sort, and apply standard machine parts."
	id = "rped"
	req_tech = list(TECH_ENGINEERING = 3, TECH_MATERIAL = 3)
	materials = list(MATERIAL_STEEL = 15000, MATERIAL_GLASS = 5000)
	build_path = /obj/item/storage/part_replacer

/datum/design/item/stock_part/basic_capacitor
	build_type = PROTOLATHE
	id = "basic_capacitor"
	req_tech = list(TECH_POWER = 1)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)
	build_path = /obj/item/weapon/stock_parts/capacitor

/datum/design/item/stock_part/basic_sensor
	build_type = PROTOLATHE
	id = "basic_sensor"
	req_tech = list(TECH_MAGNET = 1)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 20)
	build_path = /obj/item/weapon/stock_parts/scanning_module

/datum/design/item/stock_part/micro_mani
	build_type = PROTOLATHE
	id = "micro_mani"
	req_tech = list(TECH_MATERIAL = 1, TECH_DATA = 1)
	materials = list(MATERIAL_STEEL = 30)
	build_path = /obj/item/weapon/stock_parts/manipulator

/datum/design/item/stock_part/basic_micro_laser
	build_type = PROTOLATHE
	id = "basic_micro_laser"
	req_tech = list(TECH_MAGNET = 1)
	materials = list(MATERIAL_STEEL = 10, MATERIAL_GLASS = 20)
	build_path = /obj/item/weapon/stock_parts/micro_laser

/datum/design/item/stock_part/basic_matter_bin
	build_type = PROTOLATHE
	id = "basic_matter_bin"
	req_tech = list(TECH_MATERIAL = 1)
	materials = list(MATERIAL_STEEL = 80)
	build_path = /obj/item/weapon/stock_parts/matter_bin

/datum/design/item/stock_part/adv_capacitor
	id = "adv_capacitor"
	req_tech = list(TECH_POWER = 3)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)
	build_path = /obj/item/weapon/stock_parts/capacitor/adv

/datum/design/item/stock_part/adv_sensor
	id = "adv_sensor"
	req_tech = list(TECH_MAGNET = 3)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 20)
	build_path = /obj/item/weapon/stock_parts/scanning_module/adv

/datum/design/item/stock_part/nano_mani
	id = "nano_mani"
	req_tech = list(TECH_MATERIAL = 3, TECH_DATA = 2)
	materials = list(MATERIAL_STEEL = 30)
	build_path = /obj/item/weapon/stock_parts/manipulator/nano

/datum/design/item/stock_part/high_micro_laser
	id = "high_micro_laser"
	req_tech = list(TECH_MAGNET = 3)
	materials = list(MATERIAL_STEEL = 10, MATERIAL_GLASS = 20)
	build_path = /obj/item/weapon/stock_parts/micro_laser/high

/datum/design/item/stock_part/adv_matter_bin
	id = "adv_matter_bin"
	req_tech = list(TECH_MATERIAL = 3)
	materials = list(MATERIAL_STEEL = 80)
	build_path = /obj/item/weapon/stock_parts/matter_bin/adv

/datum/design/item/stock_part/super_capacitor
	id = "super_capacitor"
	req_tech = list(TECH_POWER = 5, TECH_MATERIAL = 4)
	reliability_base = 71
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50, MATERIAL_GOLD = 20)
	build_path = /obj/item/weapon/stock_parts/capacitor/super

/datum/design/item/stock_part/phasic_sensor
	id = "phasic_sensor"
	req_tech = list(TECH_MAGNET = 5, TECH_MATERIAL = 3)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 20, MATERIAL_SILVER = 10)
	reliability_base = 72
	build_path = /obj/item/weapon/stock_parts/scanning_module/phasic

/datum/design/item/stock_part/pico_mani
	id = "pico_mani"
	req_tech = list(TECH_MATERIAL = 5, TECH_DATA = 2)
	materials = list(MATERIAL_STEEL = 30)
	reliability_base = 73
	build_path = /obj/item/weapon/stock_parts/manipulator/pico

/datum/design/item/stock_part/ultra_micro_laser
	id = "ultra_micro_laser"
	req_tech = list(TECH_MAGNET = 5, TECH_MATERIAL = 5)
	materials = list(MATERIAL_STEEL = 10, MATERIAL_GLASS = 20, MATERIAL_URANIUM = 10)
	reliability_base = 70
	build_path = /obj/item/weapon/stock_parts/micro_laser/ultra

/datum/design/item/stock_part/super_matter_bin
	id = "super_matter_bin"
	req_tech = list(TECH_MATERIAL = 5)
	materials = list(MATERIAL_STEEL = 80)
	reliability_base = 75
	build_path = /obj/item/weapon/stock_parts/matter_bin/super

/////////////////////////////////////////
//////////Tcommsat Stock Parts///////////
/////////////////////////////////////////

/datum/design/item/stock_part/tcommsat
	category = "Telecomms"

/datum/design/item/stock_part/tcommsat/subspace_ansible
	id = "s-ansible"
	req_tech = list(TECH_DATA = 3, TECH_MAGNET = 4, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	materials = list(MATERIAL_STEEL = 80, MATERIAL_SILVER = 20)
	build_path = /obj/item/weapon/stock_parts/subspace/ansible

/datum/design/item/stock_part/tcommsat/hyperwave_filter
	id = "s-filter"
	req_tech = list(TECH_DATA = 3, TECH_MAGNET = 3)
	materials = list(MATERIAL_STEEL = 40, MATERIAL_SILVER = 10)
	build_path = /obj/item/weapon/stock_parts/subspace/filter

/datum/design/item/stock_part/tcommsat/subspace_amplifier
	id = "s-amplifier"
	req_tech = list(TECH_DATA = 3, TECH_MAGNET = 4, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	materials = list(MATERIAL_STEEL = 10, MATERIAL_GOLD = 30, MATERIAL_URANIUM = 15)
	build_path = /obj/item/weapon/stock_parts/subspace/amplifier

/datum/design/item/stock_part/tcommsat/subspace_treatment
	id = "s-treatment"
	req_tech = list(TECH_DATA = 3, TECH_MAGNET = 2, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	materials = list(MATERIAL_STEEL = 10, MATERIAL_SILVER = 20)
	build_path = /obj/item/weapon/stock_parts/subspace/treatment

/datum/design/item/stock_part/tcommsat/subspace_analyzer
	id = "s-analyzer"
	req_tech = list(TECH_DATA = 3, TECH_MAGNET = 4, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	materials = list(MATERIAL_STEEL = 10, MATERIAL_GOLD = 15)
	build_path = /obj/item/weapon/stock_parts/subspace/analyzer

/datum/design/item/stock_part/tcommsat/subspace_crystal
	id = "s-crystal"
	req_tech = list(TECH_MAGNET = 4, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	materials = list(MATERIAL_GLASS = 1000, MATERIAL_SILVER = 20, MATERIAL_GOLD = 20)
	build_path = /obj/item/weapon/stock_parts/subspace/crystal

/datum/design/item/stock_part/tcommsat/subspace_transmitter
	id = "s-transmitter"
	req_tech = list(TECH_MAGNET = 5, TECH_MATERIAL = 5, TECH_BLUESPACE = 3)
	materials = list(MATERIAL_GLASS = 100, MATERIAL_SILVER = 10, MATERIAL_URANIUM = 15)
	build_path = /obj/item/weapon/stock_parts/subspace/transmitter

////////////////////////////////////////
///////////////Power Items//////////////
////////////////////////////////////////
/datum/design/item/light_replacer
	name = "Light replacer"
	desc = "A device to automatically replace lights. Refill with working lightbulbs."
	id = "light_replacer"
	req_tech = list(TECH_MAGNET = 3, TECH_MATERIAL = 4)
	materials = list(MATERIAL_STEEL = 1500, MATERIAL_SILVER = 150, MATERIAL_GLASS = 3000)
	build_path = /obj/item/device/lightreplacer

// *** Power cells
/datum/design/item/powercell
	build_type = PROTOLATHE | MECHFAB
	category = "Misc"

/datum/design/item/powercell/AssembleDesignName()
	name = "Power cell model ([item_name])"

/datum/design/item/powercell/AssembleDesignDesc()
	if(build_path)
		var/obj/item/weapon/cell/C = build_path
		desc = "Allows the construction of power cells that can hold [initial(C.maxcharge)] units of energy."

/datum/design/item/powercell/basic
	name = "basic"
	build_type = PROTOLATHE | MECHFAB
	id = "basic_cell"
	req_tech = list(TECH_POWER = 1)
	materials = list(MATERIAL_STEEL = 700, MATERIAL_GLASS = 50)
	build_path = /obj/item/weapon/cell

/datum/design/item/powercell/high
	name = "high-capacity"
	build_type = PROTOLATHE | MECHFAB
	id = "high_cell"
	req_tech = list(TECH_POWER = 2)
	materials = list(MATERIAL_STEEL = 700, MATERIAL_GLASS = 60)
	build_path = /obj/item/weapon/cell/high

/datum/design/item/powercell/super
	name = "super-capacity"
	id = "super_cell"
	req_tech = list(TECH_POWER = 3, TECH_MATERIAL = 2)
	reliability_base = 75
	materials = list(MATERIAL_STEEL = 700, MATERIAL_GLASS = 70)
	build_path = /obj/item/weapon/cell/super

/datum/design/item/powercell/hyper
	name = "hyper-capacity"
	id = "hyper_cell"
	req_tech = list(TECH_POWER = 5, TECH_MATERIAL = 4)
	reliability_base = 70
	materials = list(MATERIAL_STEEL = 400, MATERIAL_GOLD = 150, MATERIAL_SILVER = 150, MATERIAL_GLASS = 70)
	build_path = /obj/item/weapon/cell/hyper

/////////////////////////////////////////
////////////Medical Tools////////////////
/////////////////////////////////////////
/datum/design/item/medical
	category = "Biotech"
	materials = list(MATERIAL_STEEL = 30, MATERIAL_GLASS = 20)

/datum/design/item/medical/AssembleDesignName()
	..()
	name = "Biotech device ([item_name])"

/datum/design/item/medical/robot_scanner
	desc = "A hand-held scanner able to diagnose robotic injuries."
	id = "robot_scanner"
	req_tech = list(TECH_MAGNET = 3, TECH_BIO = 2, TECH_ENGINEERING = 3)
	materials = list(MATERIAL_STEEL = 500, MATERIAL_GLASS = 200)
	build_path = /obj/item/device/robotanalyzer

/datum/design/item/medical/mass_spectrometer
	desc = "A device for analyzing chemicals in blood."
	id = "mass_spectrometer"
	req_tech = list(TECH_BIO = 2, TECH_MAGNET = 2)
	reliability_base = 76
	build_path = /obj/item/device/mass_spectrometer

/datum/design/item/medical/adv_mass_spectrometer
	desc = "A device for analyzing chemicals in blood and their quantities."
	id = "adv_mass_spectrometer"
	req_tech = list(TECH_BIO = 2, TECH_MAGNET = 4)
	reliability_base = 74
	build_path = /obj/item/device/mass_spectrometer/adv

/datum/design/item/medical/reagent_scanner
	desc = "A device for identifying chemicals."
	id = "reagent_scanner"
	req_tech = list(TECH_BIO = 2, TECH_MAGNET = 2)
	reliability_base = 76
	build_path = /obj/item/device/reagent_scanner

/datum/design/item/medical/adv_reagent_scanner
	desc = "A device for identifying chemicals and their proportions."
	id = "adv_reagent_scanner"
	req_tech = list(TECH_BIO = 2, TECH_MAGNET = 4)
	reliability_base = 74
	build_path = /obj/item/device/reagent_scanner/adv

/datum/design/item/medical/mmi
	id = "mmi"
	req_tech = list(TECH_DATA = 2, TECH_BIO = 3)
	build_type = PROTOLATHE | MECHFAB
	materials = list(MATERIAL_STEEL = 1000, MATERIAL_GLASS = 500)
	reliability_base = 76
	build_path = /obj/item/device/mmi
	category = "Misc"

/datum/design/item/medical/mmi_radio
	id = "mmi_radio"
	req_tech = list(TECH_DATA = 2, TECH_BIO = 4)
	build_type = PROTOLATHE | MECHFAB
	materials = list(MATERIAL_STEEL = 1200, MATERIAL_GLASS = 500)
	reliability_base = 74
	build_path = /obj/item/device/mmi/radio_enabled
	category = "Misc"

/datum/design/item/medical/nanopaste
	desc = "A tube of paste containing swarms of repair nanites. Very effective in repairing robotic machinery."
	id = "nanopaste"
	req_tech = list(TECH_MATERIAL = 4, TECH_ENGINEERING = 3)
	materials = list(MATERIAL_STEEL = 7000, MATERIAL_GLASS = 7000)
	build_path = /obj/item/stack/nanopaste

/datum/design/item/scalpel_laser1
	name = "Basic Laser Scalpel"
	desc = "A scalpel augmented with a directed laser, for more precise cutting without blood entering the field. This one looks basic and could be improved."
	id = "scalpel_laser1"
	req_tech = list(TECH_BIO = 2, TECH_MATERIAL = 2, TECH_MAGNET = 2)
	category = "Biotech"
	materials = list(MATERIAL_STEEL = 12500, MATERIAL_GLASS = 7500)
	build_path = /obj/item/weapon/scalpel/laser1

/datum/design/item/scalpel_laser2
	name = "Improved Laser Scalpel"
	desc = "A scalpel augmented with a directed laser, for more precise cutting without blood entering the field. This one looks somewhat advanced."
	id = "scalpel_laser2"
	req_tech = list(TECH_BIO = 3, TECH_MATERIAL = 4, TECH_MAGNET = 4)
	category = "Biotech"
	materials = list(MATERIAL_STEEL = 12500, MATERIAL_GLASS = 7500, MATERIAL_SILVER = 2500)
	build_path = /obj/item/weapon/scalpel/laser2

/datum/design/item/scalpel_laser3
	name = "Advanced Laser Scalpel"
	desc = "A scalpel augmented with a directed laser, for more precise cutting without blood entering the field. This one looks to be the pinnacle of precision energy cutlery!"
	id = "scalpel_laser3"
	req_tech = list(TECH_BIO = 4, TECH_MATERIAL = 6, TECH_MAGNET = 5)
	category = "Biotech"
	materials = list(MATERIAL_STEEL = 12500, MATERIAL_GLASS = 7500, MATERIAL_SILVER = 2000, MATERIAL_GOLD = 1500)
	build_path = /obj/item/weapon/scalpel/laser3

/datum/design/item/scalpel_manager
	name = "Incision Management System"
	desc = "A true extension of the surgeon's body, this marvel instantly and completely prepares an incision allowing for the immediate commencement of therapeutic steps."
	id = "scalpel_manager"
	req_tech = list(TECH_BIO = 4, TECH_MATERIAL = 7, TECH_MAGNET = 5, TECH_DATA = 4)
	category = "Biotech"
	materials = list (MATERIAL_STEEL = 12500, MATERIAL_GLASS = 7500, MATERIAL_SILVER = 1500, MATERIAL_GOLD = 1500, MATERIAL_DIAMOND = 750)
	build_path = /obj/item/weapon/scalpel/manager

// *** Beakers (not really a subtype of design/item/medical)
/datum/design/item/beaker/AssembleDesignName()
	name = "Beaker prototype ([item_name])"

/datum/design/item/beaker/bluespace
	name = TECH_BLUESPACE
	desc = "A bluespace beaker, powered by experimental bluespace technology and Element Cuban combined with the Compound Pete. Can hold up to 300 units."
	id = "bluespacebeaker"
	req_tech = list(TECH_BLUESPACE = 2, TECH_MATERIAL = 6)
	materials = list(MATERIAL_STEEL = 3000, MATERIAL_PHORON = 3000, MATERIAL_DIAMOND = 500)
	reliability_base = 76
	build_path = /obj/item/weapon/reagent_containers/glass/beaker/bluespace

/datum/design/item/beaker/noreact
	name = "cryostasis"
	desc = "A cryostasis beaker that allows for chemical storage without reactions. Can hold up to 50 units."
	id = "splitbeaker"
	req_tech = list(TECH_MATERIAL = 2)
	materials = list(MATERIAL_STEEL = 3000)
	reliability_base = 76
	build_path = /obj/item/weapon/reagent_containers/glass/beaker/noreact
	category = "Misc"

// *** Implants (not really a subtype of design/item/medical)
/datum/design/item/implant
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)

/datum/design/item/implant/AssembleDesignName()
	..()
	name = "Implantable biocircuit design ([item_name])"

/* // Removal of loyalty implants. Can't think of a way to add this to the config option.
/datum/design/item/implant/loyalty
	name = "loyalty"
	id = "implant_loyal"
	req_tech = list(TECH_MATERIAL = 2, TECH_BIO = 3)
	materials = list(MATERIAL_STEEL = 7000, MATERIAL_GLASS = 7000)
	build_path = /obj/item/weapon/implantcase/loyalty"
*/

/datum/design/item/implant/chemical
	name = "chemical"
	id = "implant_chem"
	req_tech = list(TECH_MATERIAL = 2, TECH_BIO = 3)
	build_path = /obj/item/weapon/implantcase/chem

/datum/design/item/implant/freedom
	name = "freedom"
	id = "implant_free"
	req_tech = list(TECH_ILLEGAL = 2, TECH_BIO = 3)
	build_path = /obj/item/weapon/implantcase/freedom

/////////////////////////////////////////
/////////////////Weapons/////////////////
/////////////////////////////////////////
/datum/design/item/weapon
	category = "Weapons"

/datum/design/item/weapon/AssembleDesignName()
	..()
	name = "Weapon prototype ([item_name])"

/datum/design/item/weapon/AssembleDesignDesc()
	if(!desc)
		if(build_path)
			var/obj/item/I = build_path
			desc = initial(I.desc)
		..()

/datum/design/item/weapon/vortex_manipulator
	id = "timelord_vortex"
	name = "Vortex Manipulator"
	desc = "Ancient reverse-engineered technology of some old species designed to travel through space and time. Time-shifting is DNA-locked, sadly."
	req_tech = list(TECH_MATERIAL = 8, TECH_BLUESPACE = 9, TECH_MAGNET = 7, TECH_POWER = 7, TECH_DATA = 6)
	materials = list(MATERIAL_STEEL = 10000, MATERIAL_GLASS = 5000, MATERIAL_SILVER = 1000, MATERIAL_GOLD = 1000, MATERIAL_DIAMOND = 2000)
	build_path = /obj/item/weapon/vortex_manipulator


/datum/design/item/weapon/nuclear_gun
	id = "nuclear_gun"
	req_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 5, TECH_POWER = 3)
	materials = list(MATERIAL_STEEL = 5000, MATERIAL_GLASS = 1000, MATERIAL_URANIUM = 500)
	reliability_base = 76
	build_path = /obj/item/weapon/gun/energy/gun/nuclear

/datum/design/item/weapon/stunrevolver
	id = "stunrevolver"
	req_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 3, TECH_POWER = 2)
	materials = list(MATERIAL_STEEL = 4000)
	build_path = /obj/item/weapon/gun/energy/stunrevolver

/datum/design/item/weapon/lasercannon
	desc = "The lasing medium of this prototype is enclosed in a tube lined with uranium-235 and subjected to high neutron flux in a nuclear reactor core."
	id = "lasercannon"
	req_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3, TECH_POWER = 3)
	materials = list(MATERIAL_STEEL = 10000, MATERIAL_GLASS = 1000, MATERIAL_DIAMOND = 2000)
	build_path = /obj/item/weapon/gun/energy/lasercannon

/datum/design/item/weapon/decloner
	id = "decloner"
	req_tech = list(TECH_COMBAT = 8, TECH_MATERIAL = 7, TECH_BIO = 5, TECH_POWER = 6)
	materials = list(MATERIAL_GOLD = 5000,MATERIAL_URANIUM = 10000)
//	chemicals = list("mutagen" = 40)
	build_path = /obj/item/weapon/gun/energy/decloner

/datum/design/item/weapon/chemsprayer
	desc = "An advanced chem spraying device."
	id = "chemsprayer"
	req_tech = list(TECH_MATERIAL = 3, TECH_ENGINEERING = 3, TECH_BIO = 2)
	materials = list(MATERIAL_STEEL = 5000, MATERIAL_GLASS = 1000)
	reliability_base = 100
	build_path = /obj/item/weapon/reagent_containers/spray/chemsprayer

/datum/design/item/weapon/rapidsyringe
	id = "rapidsyringe"
	req_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 3, TECH_ENGINEERING = 3, TECH_BIO = 2)
	materials = list(MATERIAL_STEEL = 5000, MATERIAL_GLASS = 1000)
	build_path = /obj/item/weapon/gun/launcher/syringe/rapid

/datum/design/item/weapon/largecrossbow
	name = "Energy Crossbow"
	desc = "A weapon favoured by syndicate infiltration teams."
	id = "largecrossbow"
	req_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 5, TECH_ENGINEERING = 3, TECH_BIO = 4, TECH_ILLEGAL = 3)
	materials = list(MATERIAL_STEEL = 5000, MATERIAL_GLASS = 1000, MATERIAL_URANIUM = 1000, MATERIAL_SILVER = 1000)
	build_path = /obj/item/weapon/gun/energy/crossbow/largecrossbow

/datum/design/item/weapon/temp_gun
	desc = "A gun that shoots high-powered glass-encased energy temperature bullets."
	id = "temp_gun"
	req_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 4, TECH_POWER = 3, TECH_MAGNET = 2)
	materials = list(MATERIAL_STEEL = 5000, MATERIAL_GLASS = 500, MATERIAL_SILVER = 3000)
	build_path = /obj/item/weapon/gun/energy/temperature

/datum/design/item/weapon/flora_gun
	id = "flora_gun"
	req_tech = list(TECH_MATERIAL = 2, TECH_BIO = 3, TECH_POWER = 3)
	materials = list(MATERIAL_STEEL = 2000, MATERIAL_GLASS = 500, MATERIAL_URANIUM = 500)
	build_path = /obj/item/weapon/gun/energy/floragun

/datum/design/item/weapon/large_grenade
	id = "large_Grenade"
	req_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 2)
	materials = list(MATERIAL_STEEL = 3000)
	reliability_base = 79
	build_path = /obj/item/weapon/grenade/chem_grenade/large

/datum/design/item/weapon/smg
	id = "smg"
	req_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3)
	materials = list(MATERIAL_STEEL = 8000, MATERIAL_SILVER = 2000, MATERIAL_DIAMOND = 1000)
	build_path = /obj/item/weapon/gun/projectile/automatic

/datum/design/item/weapon/ammo_9mm
	id = "ammo_9mm"
	req_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3)
	materials = list(MATERIAL_STEEL = 3750, MATERIAL_SILVER = 100)
	build_path = /obj/item/ammo_magazine/c9mm

/datum/design/item/weapon/stunshell
	desc = "A stunning shell for a shotgun."
	id = "stunshell"
	req_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 3)
	materials = list(MATERIAL_STEEL = 4000)
	build_path = /obj/item/ammo_casing/shotgun/stunshell

/datum/design/item/weapon/phoronpistol
	id = "ppistol"
	req_tech = list(TECH_COMBAT = 5, TECH_PHORON = 4)
	materials = list(MATERIAL_STEEL = 5000, MATERIAL_GLASS = 1000, MATERIAL_PHORON = 3000)
	build_path = /obj/item/weapon/gun/energy/toxgun

/////////////////////////////////////////
/////////////////Mining//////////////////
/////////////////////////////////////////
//Subtype of item/weapon/, because we get the nice desc update
/datum/design/item/weapon/mining/AssembleDesignName()
	..()
	name = "Mining equipment design ([item_name])"

/datum/design/item/weapon/mining/jackhammer
	id = "jackhammer"
	req_tech = list(TECH_MATERIAL = 3, TECH_POWER = 2, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 2000, MATERIAL_GLASS = 500, MATERIAL_SILVER = 500)
	build_path = /obj/item/weapon/pickaxe/jackhammer

/datum/design/item/weapon/mining/drill
	id = "drill"
	req_tech = list(TECH_MATERIAL = 2, TECH_POWER = 3, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 6000, MATERIAL_GLASS = 1000) //expensive, but no need for miners.
	build_path = /obj/item/weapon/pickaxe/drill

/datum/design/item/weapon/mining/plasmacutter
	id = "plasmacutter"
	req_tech = list(TECH_MATERIAL = 4, TECH_PHORON = 3, TECH_ENGINEERING = 3)
	materials = list(MATERIAL_STEEL = 1500, MATERIAL_GLASS = 500, MATERIAL_GOLD = 500, MATERIAL_PHORON = 500)
	reliability_base = 79
	build_path = /obj/item/weapon/pickaxe/plasmacutter

/datum/design/item/weapon/mining/pick_diamond
	id = "pick_diamond"
	req_tech = list(TECH_MATERIAL = 6)
	materials = list(MATERIAL_DIAMOND = 3000)
	build_path = /obj/item/weapon/pickaxe/diamond

/datum/design/item/weapon/mining/drill_diamond
	id = "drill_diamond"
	req_tech = list(TECH_MATERIAL = 6, TECH_POWER = 4, TECH_ENGINEERING = 4)
	materials = list(MATERIAL_STEEL = 3000, MATERIAL_GLASS = 1000, MATERIAL_DIAMOND = 3750) //Yes, a whole diamond is needed.
	reliability_base = 79
	build_path = /obj/item/weapon/pickaxe/diamonddrill

/////////////////////////////////////////
//////////////Blue Space/////////////////
/////////////////////////////////////////
/datum/design/item/beacon
	name = "Bluespace tracking beacon design"
	id = "beacon"
	req_tech = list(TECH_BLUESPACE = 1)
	materials = list (MATERIAL_STEEL = 20, MATERIAL_GLASS = 10)
	build_path = /obj/item/device/radio/beacon

/datum/design/item/bag_holding
	name = "'Bag of Holding', an infinite capacity bag prototype"
	desc = "Using localized pockets of bluespace this bag prototype offers incredible storage capacity with the contents weighting nothing. It's a shame the bag itself is pretty heavy."
	id = "bag_holding"
	req_tech = list(TECH_BLUESPACE = 4, TECH_MATERIAL = 6)
	materials = list(MATERIAL_GOLD = 3000, MATERIAL_DIAMOND = 1500, MATERIAL_URANIUM = 250)
	reliability_base = 80
	build_path = /obj/item/storage/backpack/holding

/*
/datum/design/bluespace_crystal
	name = "Artificial bluespace crystal"
	desc = "A small blue crystal with mystical properties."
	id = "bluespace_crystal"
	req_tech = list(TECH_BLUESPACE = 5, TECH_MATERIAL = 7)
	build_type = PROTOLATHE
	materials = list(MATERIAL_GOLD = 1500, MATERIAL_DIAMOND = 3000, MATERIAL_PHORON = 1500)
	reliability_base = 100
	build_path = /obj/item/bluespace_crystal/artificial"
*/

/////////////////////////////////////////
/////////////////HUDs////////////////////
/////////////////////////////////////////
/datum/design/item/hud
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)

/datum/design/item/hud/AssembleDesignName()
	..()
	name = "HUD glasses prototype ([item_name])"

/datum/design/item/hud/AssembleDesignDesc()
	desc = "Allows for the construction of \a [item_name] HUD glasses."

/datum/design/item/hud/health
	name = "health scanner"
	id = "health_hud"
	req_tech = list(TECH_BIO = 2, TECH_MAGNET = 3)
	build_path = /obj/item/clothing/glasses/hud/health

/datum/design/item/hud/security
	name = "security records"
	id = "security_hud"
	req_tech = list(TECH_MAGNET = 3, TECH_COMBAT = 2)
	build_path = /obj/item/clothing/glasses/hud/security

/datum/design/item/hud/mesons
	name = "Optical meson scanners design"
	desc = "Using the meson-scanning technology those glasses allow you to see through walls, floor or anything else."
	id = "mesons"
	req_tech = list(TECH_MAGNET = 2, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)
	build_path = /obj/item/clothing/glasses/meson

/////////////////////////////////////////
////////////////PDA Stuff////////////////
/////////////////////////////////////////
/datum/design/item/pda
	name = "PDA design"
	desc = "Cheaper than whiny non-digital assistants."
	id = "pda"
	category = "PDA stuff"
	req_tech = list(TECH_ENGINEERING = 2, TECH_POWER = 3)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)
	build_path = /obj/item/device/pda

// *** Cartridges
/datum/design/item/pda_cartridge
	category = "PDA stuff"
	req_tech = list(TECH_ENGINEERING = 2, TECH_POWER = 3)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)

/datum/design/item/pda_cartridge/AssembleDesignName()
	..()
	name = "PDA accessory ([item_name])"

/datum/design/item/pda_cartridge/cart_basic
	id = "cart_basic"
	build_path = /obj/item/weapon/cartridge

/datum/design/item/pda_cartridge/engineering
	id = "cart_engineering"
	build_path = /obj/item/weapon/cartridge/engineering

/datum/design/item/pda_cartridge/atmos
	id = "cart_atmos"
	build_path = /obj/item/weapon/cartridge/atmos

/datum/design/item/pda_cartridge/medical
	id = "cart_medical"
	build_path = /obj/item/weapon/cartridge/medical

/datum/design/item/pda_cartridge/chemistry
	id = "cart_chemistry"
	build_path = /obj/item/weapon/cartridge/chemistry

/datum/design/item/pda_cartridge/security
	id = "cart_security"
	build_path = /obj/item/weapon/cartridge/security

/datum/design/item/pda_cartridge/janitor
	id = "cart_janitor"
	build_path = /obj/item/weapon/cartridge/janitor
/*
/datum/design/item/pda_cartridge/clown
	id = "cart_clown"
	build_path = /obj/item/weapon/cartridge/clown"
/datum/design/item/pda_cartridge/mime
	id = "cart_mime"
	build_path = /obj/item/weapon/cartridge/mime"
*/
/datum/design/item/pda_cartridge/science
	id = "cart_science"
	build_path = /obj/item/weapon/cartridge/signal/science

/datum/design/item/pda_cartridge/quartermaster
	id = "cart_quartermaster"
	build_path = /obj/item/weapon/cartridge/quartermaster

/datum/design/item/pda_cartridge/hop
	id = "cart_hop"
	build_path = /obj/item/weapon/cartridge/hop

/datum/design/item/pda_cartridge/hos
	id = "cart_hos"
	build_path = /obj/item/weapon/cartridge/hos

/datum/design/item/pda_cartridge/ce
	id = "cart_ce"
	build_path = /obj/item/weapon/cartridge/ce

/datum/design/item/pda_cartridge/cmo
	id = "cart_cmo"
	build_path = /obj/item/weapon/cartridge/cmo

/datum/design/item/pda_cartridge/rd
	id = "cart_rd"
	build_path = /obj/item/weapon/cartridge/rd

/datum/design/item/pda_cartridge/captain
	id = "cart_captain"
	build_path = /obj/item/weapon/cartridge/captain

/////////////////////////////////////////
///////////////Misc Stuff////////////////
/////////////////////////////////////////
/datum/design/item/holosign
	name = "Janitor holosign controller"
	desc = "Used for creating short time holographic markers"
	id = "holosing_janitor"
	req_tech = list(TECH_MATERIAL = 2, TECH_MAGNET = 3)
	materials = list(MATERIAL_STEEL = 300, MATERIAL_GLASS = 300)
	build_path = /obj/item/device/janiholo

/datum/design/item/binaryencrypt
	name = "Binary encryption key"
	desc = "Allows for deciphering the binary channel on-the-fly."
	id = "binaryencrypt"
	req_tech = list(TECH_ILLEGAL = 2)
	materials = list(MATERIAL_STEEL = 300, MATERIAL_GLASS = 300)
	build_path = /obj/item/device/encryptionkey/binary

/datum/design/item/chameleon
	name = "Holographic module"
	desc = "High-tech equipment with changeable looks."
	id = "chameleon"
	req_tech = list(TECH_ILLEGAL = 2)
	materials = list(MATERIAL_STEEL = 300, MATERIAL_GLASS = 100)
	build_path = /obj/item/chameleon

/datum/design/item/chameleon_backpack
	name = "Holographic backpack"
	desc = "High-tech equipment with changeable looks. Have internal storage."
	id = "chameleon_backpack"
	req_tech = list(TECH_ILLEGAL = 2, TECH_MATERIAL = 2)
	materials = list(MATERIAL_STEEL = 400, MATERIAL_GLASS = 150)
	build_path = /obj/item/storage/backpack/chameleon

/datum/design/item/chameleon_gun
	name = "Holographic gun"
	desc = "High-tech gun with changeable looks. Can't hurm."
	id = "chameleon_gun"
	req_tech = list(TECH_ILLEGAL = 2, TECH_MATERIAL = 2, TECH_COMBAT = 3)
	materials = list(MATERIAL_STEEL = 400, MATERIAL_GLASS = 150)
	build_path = /obj/item/weapon/gun/projectile/chameleon
