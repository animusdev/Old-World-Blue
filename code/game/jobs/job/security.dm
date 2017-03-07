/datum/job/security
	department = "Security"
	department_flag = ENGSEC
	faction = "Station"
	supervisors = "the head of security"
	selection_color = "#ffeeee"

	implanted = 1

	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/black
	ear = /obj/item/device/radio/headset/sec

	backpack  = /obj/item/weapon/storage/backpack/security
	satchel_j = /obj/item/weapon/storage/backpack/satchel/sec
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag/sec
	messenger = /obj/item/weapon/storage/backpack/messenger/sec


/datum/job/security/hos
	title = "Head of Security"
	flag = HOS
	head_position = 1
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#ffdddd"
	idtype = /obj/item/weapon/card/id/silver
	req_admin_notify = 1
	minimal_access = list(
		access_security, access_eva, access_sec_doors, access_brig, access_armory, access_court,
		access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
		access_research, access_engine, access_mining, access_medical, access_construction, access_mailsorting,
		access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway, access_external_airlocks
	)
	minimum_character_age = 27
	minimal_player_age = 30

	uniform = /obj/item/clothing/under/rank/head_of_security
	pda = /obj/item/device/pda/heads/hos
	ear = /obj/item/device/radio/headset/heads/hos
	glasses = /obj/item/clothing/glasses/sunglasses/sechud

	put_in_backpack = list(
		/obj/item/weapon/gun/energy/gun,
		/obj/item/weapon/handcuffs
	)


/datum/job/security/warden
	title = "Warden"
	flag = WARDEN
	total_positions = 1
	spawn_positions = 1
	economic_modifier = 5
	addcional_access = list(access_morgue)
	minimal_access = list(
		access_security, access_eva, access_sec_doors, access_brig, access_armory, access_court,
		access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 14
	minimum_character_age = 23

	uniform = /obj/item/clothing/under/rank/warden
	pda = /obj/item/device/pda/warden
	glasses = /obj/item/clothing/glasses/sunglasses/sechud

	put_in_backpack = list(
		/obj/item/device/flash,
		/obj/item/weapon/handcuffs
	)


/datum/job/security/detective
	title = "Detective"
	flag = DETECTIVE
	total_positions = 1
	spawn_positions = 1

	minimal_access = list(
		access_security, access_sec_doors, access_forensics_lockers, access_morgue, access_maint_tunnels,
		access_court
	)
	economic_modifier = 5
	minimal_player_age = 14
	minimum_character_age = 23
	uniform = /obj/item/clothing/under/rank/det/black
	pda = /obj/item/device/pda/detective
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/storage/toggle/investigator

	put_in_backpack = list(
		/obj/item/weapon/flame/lighter/zippo,
		/obj/item/weapon/storage/box/evidence,
	)

	backpack  = /obj/item/weapon/storage/backpack
	satchel_j = /obj/item/weapon/storage/backpack/satchel/norm
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag
	messenger = /obj/item/weapon/storage/backpack/messenger


/datum/job/security/detective/forentech
	title = "Forensic Technician"
	flag = FORENTEC

	uniform = /obj/item/clothing/under/rank/forensic
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/forensic


/datum/job/security/officer
	title = "Security Officer"
	flag = OFFICER
	total_positions = 5
	spawn_positions = 5
	economic_modifier = 4
	addcional_access = list(access_morgue)
	minimal_access = list(
		access_security, access_eva, access_sec_doors, access_brig, access_court, access_maint_tunnels,
		access_external_airlocks
	)
	minimal_player_age = 7
	minimum_character_age = 20
	uniform = /obj/item/clothing/under/rank/security
	pda = /obj/item/device/pda/security
	gloves = null

	put_in_backpack = list(
		/obj/item/weapon/handcuffs,
		/obj/item/weapon/handcuffs,
		/obj/item/device/flash
	)
