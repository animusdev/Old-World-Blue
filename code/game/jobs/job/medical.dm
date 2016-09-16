/datum/job/medical
	faction = "Station"
	department = "Medical"
	department_flag = MEDSCI
	supervisors = "the chief medical officer"
	selection_color = "#ffeef0"

	uniform = /obj/item/clothing/under/rank/medical
	shoes = /obj/item/clothing/shoes/white
	ear = /obj/item/device/radio/headset/headset_med
	pda = /obj/item/device/pda/medical

	backpack = /obj/item/weapon/storage/backpack/medic
	satchel = /obj/item/weapon/storage/backpack/satchel_med
	duffle = /obj/item/weapon/storage/backpack/duffle/med

	backpacks = list(
		/obj/item/weapon/storage/backpack/medic,\
		/obj/item/weapon/storage/backpack/satchel_med,\
		/obj/item/weapon/storage/backpack/satchel
		)

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
	access = list(access_medical, access_medical_equip, access_morgue, access_genetics, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_external_airlocks)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_genetics, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_external_airlocks)
	minimal_player_age = 10

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
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_virology, access_genetics)
	alt_titles = list("Surgeon","Emergency Physician","Nurse","Virologist")

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
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/blue(H), slot_w_uniform)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/labcoat(H), slot_wear_suit)
					H.equip_to_slot_or_del(new /obj/item/clothing/head/surgery/blue(H), slot_head)
				if("Virologist")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/virologist(H), slot_w_uniform)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/labcoat/virologist(H), slot_wear_suit)
					H.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(H), slot_wear_mask)
					switch(H.backbag)
						if(2) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/virology(H), slot_back)
						if(3) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/satchel_vir(H), slot_back)
						if(4) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
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
						H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/purple(H), slot_w_uniform)
		..()
		return 1



//Chemist is a medical job damnit	//YEAH FUCK YOU SCIENCE	-Pete	//Guys, behave -Erro
/datum/job/medical/chemist
	title = "Chemist"
	flag = CHEMIST
	total_positions = 2
	spawn_positions = 2
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics)
	minimal_access = list(access_medical, access_medical_equip, access_chemistry)
	alt_titles = list("Pharmacist")

	uniform = /obj/item/clothing/under/rank/chemist
	pda = /obj/item/device/pda/chemist
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/chemist

	backpacks = list(
		/obj/item/weapon/storage/backpack/chemistry,\
		/obj/item/weapon/storage/backpack/satchel_chem,\
		/obj/item/weapon/storage/backpack/satchel
		)

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		if (H.mind && H.mind.role_alt_title)
			switch(H.mind.role_alt_title)
				if("Pharmacist")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/pharma(H), slot_w_uniform)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/fr_jacket(H), slot_wear_suit)
		return ..()


/datum/job/medical/geneticist
	title = "Geneticist"
	flag = GENETICIST
	total_positions = 2
	spawn_positions = 2
	supervisors = "the chief medical officer and research director"
	access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_research)
	minimal_access = list(access_medical, access_morgue, access_genetics, access_research, access_medical_equip)

	uniform = /obj/item/clothing/under/rank/geneticist
	pda = /obj/item/device/pda/geneticist
	ear = /obj/item/device/radio/headset/headset_medsci
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/genetics
	suit_store = /obj/item/device/flashlight/pen

	backpacks = list(
		/obj/item/weapon/storage/backpack/genetics,\
		/obj/item/weapon/storage/backpack/satchel_gen,\
		/obj/item/weapon/storage/backpack/satchel
		)


/datum/job/medical/psychiatrist
	title = "Psychiatrist"
	flag = PSYCHIATRIST
	total_positions = 1
	spawn_positions = 1
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_psychiatrist)
	minimal_access = list(access_medical, access_medical_equip, access_psychiatrist)
	alt_titles = list("Psychologist")

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
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_eva, access_maint_tunnels, access_external_airlocks, access_psychiatrist)
	minimal_access = list(access_medical, access_medical_equip, access_eva, access_maint_tunnels, access_external_airlocks, access_morgue)
	alt_titles = list("Emergency Medical Technician")

	uniform = /obj/item/clothing/under/rank/medical/black
	suit = /obj/item/clothing/suit/storage/vest/ems
	shoes = /obj/item/clothing/shoes/jackboots
	belt = /obj/item/weapon/storage/belt/medical/emt
	hand = /obj/item/weapon/storage/firstaid/adv
	custom_survival_gear = /obj/item/weapon/storage/box/engineer

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		if (H.mind && H.mind.role_alt_title)
			switch(H.mind.role_alt_title)
				if("Emergency Medical Technician")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/paramedic(H), slot_w_uniform)
		return ..()
