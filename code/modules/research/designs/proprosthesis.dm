/datum/design/organ_module
	build_type = MECHFAB
	category = "Prosthesis"

/datum/design/organ_module/armblade
	name = "Biotech prototype (steel armblade)"
	desc = "Combat organ module steel armblade."
	id = "armblade"
	build_path = /obj/item/weapon/material/hatchet/tacknife/armblade
	req_tech = list("materials" = 3, "combat" = 4, "biotech" = 4)

/datum/design/organ_module/armor
	name = "Biotech prototype (subdermal armor - chest)"
	desc = "Combat subdermal armor."
	id = "OM-armor"
	build_path = /obj/item/organ_module/armor
	req_tech = list("materials" = 4, "combat" = 2, "biotech" = 4)

/////////////////////////////////////
////////////PROSTHESIS////////////////
/////////////////////////////////////
/datum/design/prosthesis
	build_type = MECHFAB
	category = "Prosthesis"

/datum/design/prosthesis/simple
	desc = "Full/partial limb prosthesis."

/datum/design/prosthesis/simple/r_arm
	name = "right arm"
	id = "prosthesis_simple_r_arm"
	build_path = /obj/item/prosthesis/r_arm

/datum/design/prosthesis/simple/l_arm
	name = "left arm"
	id = "prosthesis_simple_l_arm"
	build_path = /obj/item/prosthesis/l_arm

/datum/design/prosthesis/simple/r_leg
	name = "right leg"
	id = "prosthesis_simple_r_leg"
	build_path = /obj/item/prosthesis/r_leg

/datum/design/prosthesis/simple/l_leg
	name = "left leg"
	id = "prosthesis_simple_l_leg"
	build_path = /obj/item/prosthesis/l_leg


/datum/design/prosthesis/enforcer
	req_tech = list("materials" = 3, "engineering" = 2, "combat" = 2, "biotech" = 3)
	desc = "Fulllimb combat prosthesis with magboots and powerfists modules."

/datum/design/prosthesis/enforcer/AssembleDesignName()
	name = "Prosthesis design of \"Enforcer Charge\" ([name])"

/datum/design/prosthesis/enforcer/r_arm
	name = "right arm"
	id = "enforcer_r_arm"
	build_path = /obj/item/prosthesis/enforcer/r_arm

/datum/design/prosthesis/enforcer/l_arm
	name = "left arm"
	id = "enforcer_l_arm"
	build_path = /obj/item/prosthesis/enforcer/l_arm

/datum/design/prosthesis/enforcer/r_leg
	name = "right leg"
	id = "enforcer_r_leg"
	build_path = /obj/item/prosthesis/enforcer/r_leg

/datum/design/prosthesis/enforcer/l_leg
	name = "left leg"
	id = "enforcer_l_leg"
	build_path = /obj/item/prosthesis/enforcer/l_leg


/datum/design/prosthesis/runner
	req_tech = list("materials" = 3, "engineering" = 2, "biotech" = 3)
	desc = "Fulllimb runner prosthesis. Light and quick."

/datum/design/prosthesis/runner/AssembleDesignName()
	name = "Prosthesis design of \"R.U.N.N.E.R.\" ([name])"

/datum/design/prosthesis/runner/r_leg
	name = "right leg"
	id = "runner_r_leg"
	build_path = /obj/item/prosthesis/runner/r_leg

/datum/design/prosthesis/runner/l_leg
	name = "left leg"
	id = "runner_l_leg"
	build_path = /obj/item/prosthesis/runner/l_leg

