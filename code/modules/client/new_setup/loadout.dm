/datum/loadout
	var/name = ""
	var/description = ""
	var/cost = 0
	var/path = ""
	var/slot = slot_in_backpack
	var/list/allowed_roles = list()

/datum/loadout/uniform
	slot = slot_w_uniform

/datum/loadout/suit
	slot = slot_wear_suit

/datum/loadout/hat
	slot = slot_head

/datum/loadout/shoes
	slot = slot_shoes

/datum/loadout/gloves
	slot = slot_gloves

/datum/loadout/glasses
	slot = slot_glasses

/datum/loadout/backpack
	slot = slot_back

/datum/loadout/backpack/nothing
	name = "Nothing"

/datum/loadout/backpack/job
	name = "Job default"

/datum/loadout/backpack/job_satchel
	name = "Job satchel"

/datum/loadout/backpack/job_duffle
	name = "Job duffle"


/datum/loadout/mask
	slot = slot_wear_mask

/datum/loadout/socks
	slot = slot_socks

/datum/loadout/underwear
	slot = slot_underwear

/datum/loadout/undersuit
	slot = slot_undershirt

/datum/loadout/attachment
	slot = slot_tie
