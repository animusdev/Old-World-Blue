/datum/job/engi
	department = "Engineering"
	department_flag = ENGSEC
	faction = "Station"
	supervisors = "the chief engineer"
	selection_color = "#fff5cc"

	ear = /obj/item/device/radio/headset/headset_eng
	custom_survival_gear = /obj/item/weapon/storage/box/engineer

	backpack = /obj/item/weapon/storage/backpack/industrial
	satchel = /obj/item/weapon/storage/backpack/satchel_eng
	duffle = /obj/item/weapon/storage/backpack/duffle/engie

	backpacks = list(
		/obj/item/weapon/storage/backpack/industrial,\
		/obj/item/weapon/storage/backpack/satchel_eng,\
		/obj/item/weapon/storage/backpack/satchel
		)



/datum/job/engi/chief_engineer
	title = "Chief Engineer"
	flag = CHIEF
	head_position = 1
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#ffeeaa"
	idtype = /obj/item/weapon/card/id/silver
	req_admin_notify = 1

	access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction, access_sec_doors,
			            access_ce, access_RC_announce, access_keycard_auth, access_tcomsat, access_ai_upload)
	minimal_access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction, access_sec_doors,
			            access_ce, access_RC_announce, access_keycard_auth, access_tcomsat, access_ai_upload)
	minimal_player_age = 7

	uniform = /obj/item/clothing/under/rank/chief_engineer
	shoes = /obj/item/clothing/shoes/brown
	pda = /obj/item/device/pda/heads/ce
	hat = /obj/item/clothing/head/hardhat/white
	gloves = /obj/item/clothing/gloves/black
	belt = /obj/item/weapon/storage/belt/utility/full
	ear = /obj/item/device/radio/headset/heads/ce



/datum/job/engi/engineer
	title = "Station Engineer"
	flag = ENGINEER
	total_positions = 5
	spawn_positions = 5
	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics)
	minimal_access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction)
	alt_titles = list("Maintenance Technician","Engine Technician","Electrician")

	uniform = /obj/item/clothing/under/rank/engineer
	shoes = /obj/item/clothing/shoes/workboots
	pda = /obj/item/device/pda/engineering
	hat = /obj/item/clothing/head/hardhat
	belt = /obj/item/weapon/storage/belt/utility/full

	put_in_backpack = list(\
		/obj/item/device/t_scanner
		)

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		if (H.mind && H.mind.role_alt_title)
			switch(H.mind.role_alt_title)
				if("Maintenance Technician")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/maintenance_tech(H), slot_w_uniform)
				if("Engine Technician")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/engine_tech(H), slot_w_uniform)
				if("Electrician")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/electrician(H), slot_w_uniform)
		return ..()



/datum/job/engi/atmos
	title = "Atmospheric Technician"
	flag = ATMOSTECH
	total_positions = 3
	spawn_positions = 2
	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_external_airlocks)
	minimal_access = list(access_eva, access_engine, access_atmospherics, access_maint_tunnels, access_emergency_storage, access_construction, access_external_airlocks)

	uniform = /obj/item/clothing/under/rank/atmospheric_technician
	pda = /obj/item/device/pda/atmos
	belt = /obj/item/weapon/storage/belt/utility/atmostech
