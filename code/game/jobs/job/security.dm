/datum/job/security
	department = "Security"
	department_flag = ENGSEC
	faction = "Station"
	supervisors = "the head of security"
	selection_color = "#ffeeee"

	implanted = 1

	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/black
	ear = /obj/item/device/radio/headset/headset_sec

	backpack = /obj/item/weapon/storage/backpack/security
	satchel = /obj/item/weapon/storage/backpack/satchel_sec
	duffle = /obj/item/weapon/storage/backpack/duffle/security

	backpacks = list(
		/obj/item/weapon/storage/backpack/security,\
		/obj/item/weapon/storage/backpack/satchel_sec,\
		/obj/item/weapon/storage/backpack/satchel
		)


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
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_court,
			            access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
			            access_research, access_engine, access_mining, access_medical, access_construction, access_mailsorting,
			            access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_court,
			            access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
			            access_research, access_engine, access_mining, access_medical, access_construction, access_mailsorting,
			            access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway, access_external_airlocks)
	minimal_player_age = 14

	uniform = /obj/item/clothing/under/rank/head_of_security
	pda = /obj/item/device/pda/heads/hos
	ear = /obj/item/device/radio/headset/heads/hos
	glasses = /obj/item/clothing/glasses/sunglasses/sechud

	put_in_backpack = list(\
		/obj/item/weapon/gun/energy/gun,\
		/obj/item/weapon/handcuffs
		)



/datum/job/security/warden
	title = "Warden"
	flag = WARDEN
	total_positions = 1
	spawn_positions = 1
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_court, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_court, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 5

	uniform = /obj/item/clothing/under/rank/warden
	pda = /obj/item/device/pda/warden
	glasses = /obj/item/clothing/glasses/sunglasses/sechud

	put_in_backpack = list(\
		/obj/item/device/flash,\
		/obj/item/weapon/handcuffs
		)



/datum/job/security/detective
	title = "Detective"
	flag = DETECTIVE
	total_positions = 1
	spawn_positions = 1

	access = list(access_security, access_sec_doors, access_forensics_lockers, access_morgue, access_maint_tunnels, access_court)
	minimal_access = list(access_security, access_sec_doors, access_forensics_lockers, access_morgue, access_maint_tunnels, access_court)
	minimal_player_age = 3

	uniform = /obj/item/clothing/under/det
	pda = /obj/item/device/pda/detective
	shoes = /obj/item/clothing/shoes/brown
	hat = /obj/item/clothing/head/det_hat
	suit = /obj/item/clothing/suit/storage/det_suit

	put_in_backpack = list(\
		/obj/item/weapon/flame/lighter/zippo,\
		/obj/item/weapon/storage/box/evidence,\
		)

	backpacks = list(
		/obj/item/weapon/storage/backpack,\
		/obj/item/weapon/storage/backpack/satchel_norm,\
		/obj/item/weapon/storage/backpack/satchel
	)



/datum/job/security/detective/forentech
	title = "Forensic Technician"
	flag = FORENTEC

	uniform = /obj/item/clothing/under/rank/forentech
	suit = /obj/item/clothing/suit/storage/forensics/red



/datum/job/security/officer
	title = "Security Officer"
	flag = OFFICER
	total_positions = 5
	spawn_positions = 5
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_court, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_court, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 3

	uniform = /obj/item/clothing/under/rank/security
	pda = /obj/item/device/pda/security
	gloves = null

	put_in_backpack = list(\
		/obj/item/weapon/handcuffs,\
		/obj/item/weapon/handcuffs,\
		/obj/item/device/flash
		)
