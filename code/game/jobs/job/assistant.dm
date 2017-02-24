/datum/job/assistant
	title = "Assistant"
	flag = ASSISTANT
	department = "Civilian"
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "absolutely everyone"
	selection_color = "#dddddd"
	economic_modifier = 1
	minimal_access = list(access_maint_tunnels)	//See /datum/job/assistant/get_access()
	alt_titles = list("Security Cadet","Technical Assistant","Medical Intern","Research Assistant","Visitor","Private Eye")

	uniform = /obj/item/clothing/under/color/grey
	pda = /obj/item/device/pda
	ear = /obj/item/device/radio/headset
	shoes = /obj/item/clothing/shoes/black

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		if (H.mind && H.mind.role_alt_title)
			switch(H.mind.role_alt_title)
				if("Security Cadet")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/cadet(H), slot_w_uniform)
				if("Technical Assistant")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/color/lightbrown(H), slot_w_uniform)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest(H), slot_wear_suit)
				if("Medical Intern")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/color/lightblue(H), slot_w_uniform)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/labcoat(H), slot_wear_suit)
				if ("Research Assistant")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/scientist_new(H), slot_w_uniform)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/labcoat(H), slot_wear_suit)
				if ("Private Eye")
					H.equip_to_slot_or_del(new /obj/item/clothing/under/color/black(H), slot_w_uniform)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/leathercoat(H), slot_wear_suit)
					H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
					H.equip_to_slot_or_del(new /obj/item/weapon/flame/lighter/zippo(H), slot_in_backpack)
		return ..()
/*
/datum/job/assistant/get_access()
	if(config.assistant_maint)
		return list(access_maint_tunnels)
	else
		return list()
*/