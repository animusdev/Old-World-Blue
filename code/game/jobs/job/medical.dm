/datum/job/medical
	faction = "Station"
	department = "Medical"
	department_flag = MEDSCI
	supervisors = "the chief medical officer"
	selection_color = "#ffeef0"

	uniform = /obj/item/clothing/under/rank/medical
	shoes = /obj/item/clothing/shoes/white
	ear = /obj/item/device/radio/headset/med
	pda = /obj/item/device/pda/medical

	backpack  = /obj/item/weapon/storage/backpack/medic
	satchel_j = /obj/item/weapon/storage/backpack/satchel/med
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag/med
	messenger = /obj/item/weapon/storage/backpack/messenger/med


/datum/job/medical/cmo
	title = "Chief Medical Officer"
	flag = CMO
	head_position = 1
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#ffddf0"
	idtype = /obj/item/weapon/card/id/silver
	req_admin_notify = 1
	economic_modifier = 10
	minimal_access = list(
		access_heads, access_RC_announce, access_keycard_auth, access_sec_doors, access_eva,
		access_cmo,  access_medical, access_medical_equip, access_morgue, access_genetics,
		access_chemistry, access_virology, access_surgery,  access_psychiatrist,
		access_external_airlocks, access_maint_tunnels)

	minimum_character_age = 27
	minimal_player_age = 30
	ideal_character_age = 50

	uniform = /obj/item/clothing/under/rank/chief_medical_officer
	shoes = /obj/item/clothing/shoes/brown
	pda = /obj/item/device/pda/heads/cmo
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/cmo
	suit_store = /obj/item/device/flashlight/pen
	ear = /obj/item/device/radio/headset/heads/cmo
	hand = /obj/item/weapon/storage/firstaid/adv


/datum/job/medical/doctor
	title = "Medical Doctor"
	flag = DOCTOR
	total_positions = 5
	spawn_positions = 3
	economic_modifier = 7
	addcional_access = list(access_chemistry)
	minimal_access = list(
		access_medical, access_medical_equip, access_morgue, access_surgery, access_virology, access_genetics
	)
	alt_titles = list("Surgeon","Emergency Physician","Nurse","Virologist")
	minimal_player_age = 14

	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	suit_store = /obj/item/device/flashlight/pen
	hand = /obj/item/weapon/storage/firstaid/adv

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		if (H.mind && H.mind.role_alt_title)
			switch(H.mind.role_alt_title)
				if("Emergency Physician")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical(H), slot_w_uniform)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/fr_jacket(H), slot_wear_suit)
				if("Surgeon")
					if(H.gender == FEMALE)
						H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/sleeveless/blue(H), slot_w_uniform)
						H.equip_to_slot_or_del(new /obj/item/clothing/head/surgery/blue(H), slot_head)
					else
						H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/sleeveless/green(H), slot_w_uniform)
						H.equip_to_slot_or_del(new /obj/item/clothing/head/surgery/green(H), slot_head)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/labcoat(H), slot_wear_suit)
				if("Virologist")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/virologist(H), slot_w_uniform)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/labcoat/virologist(H), slot_wear_suit)
					H.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(H), slot_wear_mask)
					switch(H.backbag)
						if(2) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/virology(H), slot_back)
						if(3) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/satchel/vir(H), slot_back)
						if(4) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
						if(5) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/dufflebag/med(H), slot_back)
						if(6) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/messenger/vir(H), slot_back)
				if("Medical Doctor")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical(H), slot_w_uniform)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/labcoat(H), slot_wear_suit)
				if("Nurse")
					if(H.gender == FEMALE)
						if(prob(50))
							H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/nursesuit(H), slot_w_uniform)
						else
							H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/nurse(H), slot_w_uniform)
						H.equip_to_slot_or_del(new /obj/item/clothing/head/nursehat(H), slot_head)
					else
						H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/sleeveless/purple(H), slot_w_uniform)
		..()
		return 1


//Chemist is a medical job damnit	//YEAH FUCK YOU SCIENCE	-Pete	//Guys, behave -Erro
/datum/job/medical/chemist
	title = "Chemist"
	flag = CHEMIST
	total_positions = 2
	spawn_positions = 2
	economic_modifier = 5
	addcional_access = list(access_morgue, access_surgery, access_virology, access_genetics)
	minimal_access = list(access_medical, access_medical_equip, access_chemistry)
	alt_titles = list("Pharmacist")
	minimum_character_age = 20
	minimal_player_age = 14

	uniform = /obj/item/clothing/under/rank/chemist
	pda = /obj/item/device/pda/chemist
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/chemist

	backpack  = /obj/item/weapon/storage/backpack/chemistry
	satchel_j = /obj/item/weapon/storage/backpack/satchel/chem
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag/med
	messenger = /obj/item/weapon/storage/backpack/messenger/chem

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		if (H.mind && H.mind.role_alt_title)
			switch(H.mind.role_alt_title)
				if("Pharmacist")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/pharma(H), slot_w_uniform)
		return ..()


/datum/job/medical/geneticist
	title = "Geneticist"
	flag = GENETICIST
	total_positions = 0
	spawn_positions = 0
	supervisors = "the chief medical officer and research director"
	economic_modifier = 7
	addcional_access = list(access_surgery, access_chemistry, access_virology)
	minimal_access = list(access_medical, access_morgue, access_genetics, access_research, access_medical_equip)

	uniform = /obj/item/clothing/under/rank/geneticist
	pda = /obj/item/device/pda/geneticist
	ear = /obj/item/device/radio/headset/medsci
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/genetics
	suit_store = /obj/item/device/flashlight/pen

	backpack  = /obj/item/weapon/storage/backpack/genetics
	satchel_j = /obj/item/weapon/storage/backpack/satchel/gen
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag/med
	messenger = /obj/item/weapon/storage/backpack/messenger/med


/datum/job/medical/psychiatrist
	title = "Psychiatrist"
	flag = PSYCHIATRIST
	total_positions = 1
	spawn_positions = 1
	economic_modifier = 5
	addcional_access = list(access_morgue)
	minimal_access = list(access_medical, access_medical_equip, access_psychiatrist)
	alt_titles = list("Psychologist")
	minimum_character_age = 20

	uniform = /obj/item/clothing/under/rank/psych
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	suit_store = null

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		if (H.mind && H.mind.role_alt_title)
			switch(H.mind.role_alt_title)
				if("Psychologist")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/psych/turtleneck(H), slot_w_uniform)
		return ..()



/datum/job/medical/paramedic
	title = "Paramedic"
	flag = PARAMEDIC
	total_positions = 2
	spawn_positions = 2
	economic_modifier = 4
	addcional_access = list(access_surgery, access_chemistry, access_virology, access_psychiatrist)
	minimal_access = list(
		access_medical, access_medical_equip, access_morgue, access_eva, access_maint_tunnels,
		access_external_airlocks
	)
	alt_titles = list("Emergency Medical Technician")

	uniform = /obj/item/clothing/under/rank/medical/sleeveless/paramedic
	suit = /obj/item/clothing/suit/storage/vest/ems
	hat = /obj/item/clothing/head/soft/emt
	shoes = /obj/item/clothing/shoes/jackboots
	pda = /obj/item/device/pda/emt
	belt = /obj/item/weapon/storage/belt/medical/emt
	hand = /obj/item/weapon/storage/firstaid/adv
	adv_survival_gear = 1

	backpack  = /obj/item/weapon/storage/backpack/emt
	satchel_j = /obj/item/weapon/storage/backpack/satchel/emt
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag/emt
	messenger = /obj/item/weapon/storage/backpack/messenger/emt

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		if (H.mind && H.mind.role_alt_title)
			switch(H.mind.role_alt_title)
				if("Emergency Medical Technician")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/sleeveless/paramedic(H), slot_w_uniform)
		return ..()
