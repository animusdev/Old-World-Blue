/datum/job/science
	department = "Science"
	department_flag = MEDSCI
	faction = "Station"
	supervisors = "the research director"
	selection_color = "#ffeeff"

	ear = /obj/item/device/radio/headset/sci
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science

	backpack  = /obj/item/weapon/storage/backpack/toxins
	satchel_j = /obj/item/weapon/storage/backpack/satchel/tox
	messenger = /obj/item/weapon/storage/backpack/messenger/tox


/datum/job/science/rd
	title = "Research Director"
	flag = RD
	head_position = 1
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#ffddff"
	idtype = /obj/item/weapon/card/id/silver
	req_admin_notify = 1
	economic_modifier = 15
	minimal_access = list(
		access_rd, access_heads, access_RC_announce, access_keycard_auth, access_teleporter, access_tcomsat,
		access_research, access_sec_doors, access_ai_upload, access_gateway, access_tech_storage, access_xenoarch,
		access_tox, access_tox_storage, access_robotics, access_genetics, access_morgue, access_xenobiology)

	minimum_character_age = 30
	minimal_player_age = 30
	ideal_character_age = 50

	uniform = /obj/item/clothing/under/rank/research_director
	pda = /obj/item/device/pda/heads/rd
	ear = /obj/item/device/radio/headset/heads/rd
	shoes = /obj/item/clothing/shoes/brown
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	hand = /obj/item/weapon/clipboard


/datum/job/science/scientist
	title = "Scientist"
	flag = SCIENTIST
	total_positions = 5
	spawn_positions = 3
	economic_modifier = 7
	addcional_access = list(access_robotics, access_xenobiology)
	minimal_access = list(access_tox, access_tox_storage, access_research, access_xenoarch)
	alt_titles = list("Xenoarcheologist", "Anomalist", "Phoron Researcher")

	minimal_player_age = 14

	uniform = /obj/item/clothing/under/rank/scientist
	pda = /obj/item/device/pda/science

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		if (H.mind && H.mind.role_alt_title)
			switch(H.mind.role_alt_title)
				if("Xenoarcheologist")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/xenoarch(H), slot_w_uniform)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/labcoat/science)
				if("Anomalist")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/anomalist(H), slot_w_uniform)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/labcoat/science)
				if("Phoron Researcher")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/plasmares(H), slot_w_uniform)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/labcoat/science)
		return ..()


/datum/job/science/xenobiologist
	title = "Xenobiologist"
	flag = XENOBIOLOGIST
	total_positions = 3
	spawn_positions = 2
	economic_modifier = 7
	addcional_access = list(access_robotics, access_tox, access_tox_storage)
	minimal_access = list(access_research, access_xenobiology, access_hydroponics, access_tox_storage)
	alt_titles = list("Xenobotanist")

	minimal_player_age = 14
	minimum_character_age = 23

	uniform = /obj/item/clothing/under/rank/xenobio
	pda = /obj/item/device/pda/science


/datum/job/science/roboticist
	title = "Roboticist"
	flag = ROBOTICIST
	total_positions = 2
	spawn_positions = 2
	supervisors = "research director"
	economic_modifier = 5
	//As a job that handles so many corpses, it makes sense for them to have morgue access.
	addcional_access = list(access_tox, access_tox_storage)
	minimal_access = list(access_robotics, access_tech_storage, access_morgue, access_research)
	alt_titles = list("Biomechanical Engineer","Mechatronic Engineer")

	minimal_player_age = 7
	minimum_character_age = 23

	uniform = /obj/item/clothing/under/rank/roboticist
	ear = /obj/item/device/radio/headset/rob
	pda = /obj/item/device/pda/roboticist
	hand = /obj/item/weapon/storage/toolbox/mechanical
	shoes = /obj/item/clothing/shoes/black

	backpack  = /obj/item/weapon/storage/backpack
	satchel_j = /obj/item/weapon/storage/backpack/satchel/norm
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag
	messenger = /obj/item/weapon/storage/backpack/messenger/black

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		if (H.mind && H.mind.role_alt_title)
			switch(H.mind.role_alt_title)
				if("Biomechanical Engineer")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/biomechanical(H), slot_w_uniform)
				if("Mechatronic Engineer")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/mechatronic(H), slot_w_uniform)
		return ..()
