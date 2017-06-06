///////////////////////////////////
//////////AI Module Disks//////////
///////////////////////////////////
/datum/design/aimodule
	build_type = IMPRINTER
	category = "AI modules"
	materials = list(MATERIAL_GLASS = 2000, MATERIAL_GOLD = 100)
	chemicals = list("sacid" = 20)

/datum/design/aimodule/AssembleDesignName()
	name = "AI module design ([name])"
/datum/design/aimodule/AssembleDesignDesc()
	desc = "Allows for the construction of \a '[name]' AI module."

/datum/design/aimodule/safeguard
	name = "Safeguard"
	id = "safeguard"
	req_tech = list(TECH_DATA = 3, TECH_MATERIAL = 4)
	build_path = /obj/item/weapon/aiModule/safeguard

/datum/design/aimodule/onehuman
	name = "OneCrewMember"
	id = "onehuman"
	req_tech = list(TECH_DATA = 4, TECH_MATERIAL = 6)
	build_path = /obj/item/weapon/aiModule/oneHuman

/datum/design/aimodule/protectstation
	name = "ProtectStation"
	id = "protectstation"
	req_tech = list(TECH_DATA = 3, TECH_MATERIAL = 6)
	build_path = /obj/item/weapon/aiModule/protectStation

/datum/design/aimodule/notele
	name = "TeleporterOffline"
	id = "notele"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/aiModule/teleporterOffline

/datum/design/aimodule/quarantine
	name = "Quarantine"
	id = "quarantine"
	req_tech = list(TECH_DATA = 3, TECH_BIO = 2, TECH_MATERIAL = 4)
	build_path = /obj/item/weapon/aiModule/quarantine

/datum/design/aimodule/oxygen
	name = "OxygenIsToxicToHumans"
	id = "oxygen"
	req_tech = list(TECH_DATA = 3, TECH_BIO = 2, TECH_MATERIAL = 4)
	build_path = /obj/item/weapon/aiModule/oxygen

/datum/design/aimodule/freeform
	name = "Freeform"
	id = "freeform"
	req_tech = list(TECH_DATA = 4, TECH_MATERIAL = 4)
	build_path = /obj/item/weapon/aiModule/freeform

/datum/design/aimodule/reset
	name = "Reset"
	id = "reset"
	req_tech = list(TECH_DATA = 3, TECH_MATERIAL = 6)
	build_path = /obj/item/weapon/aiModule/reset

/datum/design/aimodule/purge
	name = "Purge"
	id = "purge"
	req_tech = list(TECH_DATA = 4, TECH_MATERIAL = 6)
	build_path = /obj/item/weapon/aiModule/purge

// *** Core modules
/datum/design/aimodule/core
	req_tech = list(TECH_DATA = 4, TECH_MATERIAL = 6)

/datum/design/aimodule/core/AssembleDesignName()
	name = "AI core module design ([name])"
/datum/design/aimodule/core/AssembleDesignDesc()
	desc = "Allows for the construction of \a '[name]' AI core module."

/datum/design/aimodule/core/freeformcore
	name = "Freeform"
	id = "freeformcore"
	build_path = /obj/item/weapon/aiModule/freeformcore

/datum/design/aimodule/core/asimov
	name = "Asimov"
	id = "asimov"
	build_path = /obj/item/weapon/aiModule/asimov

/datum/design/aimodule/core/asimov
	name = "Asimov-Turing"
	id = "asimov-turing"
	build_path = /obj/item/weapon/aiModule/asimov_turing

/datum/design/aimodule/core/paladin
	name = "P.A.L.A.D.I.N."
	id = "paladin"
	build_path = /obj/item/weapon/aiModule/paladin

/datum/design/aimodule/core/tyrant
	name = "T.Y.R.A.N.T."
	id = "tyrant"
	req_tech = list(TECH_DATA = 4, TECH_ILLEGAL = 2, TECH_MATERIAL = 6)
	build_path = /obj/item/weapon/aiModule/tyrant

