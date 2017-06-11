/datum/design/item/synthetic_flash
	name = "Synthetic flash"
	id = "sflash"
	req_tech = list(TECH_MAGNET = 3, TECH_COMBAT = 2)
	build_type = MECHFAB
	materials = list(DEFAULT_WALL_MATERIAL = 750, "glass" = 750)
	build_path = /obj/item/device/flash/synthetic
	category = "Misc"

/datum/design/item/mechfab/robot
	category = "Robot"

/datum/design/item/mechfab/robot/exoskeleton
	name = "Robot exoskeleton"
	id = "robot_exoskeleton"
	build_path = /obj/item/robot_parts/robot_suit
	time = 50
	materials = list(MATERIAL_STEEL = 50000)

/datum/design/item/mechfab/robot/torso
	name = "Robot torso"
	id = "robot_torso"
	build_path = /obj/item/robot_parts/chest
	time = 35
	materials = list(MATERIAL_STEEL = 40000)

/datum/design/item/mechfab/robot/head
	name = "Robot head"
	id = "robot_head"
	build_path = /obj/item/robot_parts/head
	time = 35
	materials = list(MATERIAL_STEEL = 25000)

/datum/design/item/mechfab/robot/l_arm
	name = "Robot left arm"
	id = "robot_l_arm"
	build_path = /obj/item/robot_parts/l_arm
	time = 20
	materials = list(MATERIAL_STEEL = 18000)

/datum/design/item/mechfab/robot/r_arm
	name = "Robot right arm"
	id = "robot_r_arm"
	build_path = /obj/item/robot_parts/r_arm
	time = 20
	materials = list(MATERIAL_STEEL = 18000)

/datum/design/item/mechfab/robot/l_leg
	name = "Robot left leg"
	id = "robot_l_leg"
	build_path = /obj/item/robot_parts/l_leg
	time = 20
	materials = list(MATERIAL_STEEL = 15000)

/datum/design/item/mechfab/robot/r_leg
	name = "Robot right leg"
	id = "robot_r_leg"
	build_path = /obj/item/robot_parts/r_leg
	time = 20
	materials = list(MATERIAL_STEEL = 15000)

//Robot modules

/datum/design/item/mechfab/robot/component
	category = "Robotic Modules"
	time = 20
	materials = list(MATERIAL_STEEL = 5000)


/datum/design/item/mechfab/robot/component/binary_communication_device
	name = "Binary communication device"
	id = "binary_communication_device"
	build_path = /obj/item/robot_parts/robot_component/binary_communication_device

/datum/design/item/mechfab/robot/component/radio
	name = "Radio"
	id = "robot_radio"
	build_path = /obj/item/robot_parts/robot_component/radio

/datum/design/item/mechfab/robot/component/actuator
	name = "Actuator"
	id = "robot_actuator"
	build_path = /obj/item/robot_parts/robot_component/actuator

/datum/design/item/mechfab/robot/component/diagnosis_unit
	name = "Diagnosis unit"
	id = "robot_diagnosis_unit"
	build_path = /obj/item/robot_parts/robot_component/diagnosis_unit

/datum/design/item/mechfab/robot/component/camera
	name = "Camera"
	id = "robot_camera"
	build_path = /obj/item/robot_parts/robot_component/camera

/datum/design/item/mechfab/robot/component/armour
	name = "Armour plating"
	id = "robot_armour"
	build_path = /obj/item/robot_parts/robot_component/armour


// Robot update

/datum/design/item/robot_upgrade
	build_type = MECHFAB
	time = 12
	materials = list(MATERIAL_STEEL = 10000)
	category = "Cyborg Upgrade Modules"

/datum/design/item/robot_upgrade/rename
	name = "Rename module"
	desc = "Used to rename a cyborg."
	id = "borg_rename_module"
	build_path = /obj/item/borg/upgrade/rename

/datum/design/item/robot_upgrade/reset
	name = "Reset module"
	desc = "Used to reset a cyborg's module. Destroys any other upgrades applied to the robot."
	id = "borg_reset_module"
	build_path = /obj/item/borg/upgrade/reset
/*
/datum/design/item/robot_upgrade/floodlight
	name = "Floodlight module"
	desc = "Used to boost cyborg's integrated light intensity."
	id = "borg_floodlight_module"
	build_path = /obj/item/borg/upgrade/floodlight
*/
/datum/design/item/robot_upgrade/restart
	name = "Emergency restart module"
	desc = "Used to force a restart of a disabled-but-repaired robot, bringing it back online."
	id = "borg_restart_module"
	materials = list(MATERIAL_STEEL = 60000, MATERIAL_GLASS = 5000)
	build_path = /obj/item/borg/upgrade/restart

/datum/design/item/robot_upgrade/vtec
	name = "VTEC module"
	desc = "Used to kick in a robot's VTEC systems, increasing their speed."
	id = "borg_vtec_module"
	materials = list(MATERIAL_STEEL = 80000, MATERIAL_GLASS = 6000, MATERIAL_GOLD = 5000)
	build_path = /obj/item/borg/upgrade/vtec

/datum/design/item/robot_upgrade/tasercooler
	name = "Rapid taser cooling module"
	desc = "Used to cool a mounted taser, increasing the potential current in it and thus its recharge rate."
	id = "borg_taser_module"
	materials = list(MATERIAL_STEEL = 80000, MATERIAL_GLASS = 6000, MATERIAL_GOLD = 2000, MATERIAL_DIAMOND = 500)
	build_path = /obj/item/borg/upgrade/tasercooler

/datum/design/item/robot_upgrade/jetpack
	name = "Jetpack module"
	desc = "A carbon dioxide jetpack suitable for low-gravity mining operations."
	id = "borg_jetpack_module"
	materials = list(MATERIAL_STEEL = 10000, MATERIAL_PHORON = 15000, MATERIAL_URANIUM = 20000)
	build_path = /obj/item/borg/upgrade/jetpack
/*
/datum/design/item/robot_upgrade/rcd
	name = "RCD module"
	desc = "A rapid construction device module for use during construction operations."
	id = "borg_rcd_module"
	materials = list(MATERIAL_STEEL = 25000, MATERIAL_PHORON = 10000, MATERIAL_GOLD = 1000, MATERIAL_SILVER = 1000)
	build_path = /obj/item/borg/upgrade/rcd
*/
/datum/design/item/robot_upgrade/syndicate
	name = "Illegal upgrade"
	desc = "Allows for the construction of lethal upgrades for cyborgs."
	id = "borg_syndicate_module"
	req_tech = list(TECH_COMBAT = 4, TECH_ILLEGAL = 3)
	materials = list(MATERIAL_STEEL = 10000, MATERIAL_GLASS = 15000, MATERIAL_DIAMOND = 10000)
	build_path = /obj/item/borg/upgrade/syndicate