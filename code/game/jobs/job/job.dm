/datum/job

	//The name of the job
	var/title = "BASIC"
	//Job access. The use of minimal_access or access is determined by a config setting: config.jobs_have_minimal_access
	var/list/minimal_access = list()      // Only have access given to the places a job absolutely needs.
	var/list/addcional_access = list()    // Additionasl access. Need be enabled in config.
	var/flag = 0 	                      // Bitflags for the job
	var/department_flag = 0
	var/faction = "None"	              // Players will be allowed to spawn in as jobs that are set to "Station"
	var/total_positions = 0               // How many players can be this job
	var/spawn_positions = 0               // How many players can spawn in as this job
	var/current_positions = 0             // How many players have this job
	var/supervisors = null                // Supervisors, who this person answers to directly
	var/selection_color = "#ffffff"       // Selection screen color
	var/list/alt_titles                   // List of alternate titles, if any
	var/req_admin_notify                  // Telling player that he should let admins know that he has to disconnect.
	var/minimal_player_age = 0            // Add a requirement for players to be at least minimal_player_age days old.
	var/department = null                 // Does this position have a department tag?
	var/head_position = 0                 // Is this position Command?
	var/minimum_character_age = 0
	var/ideal_character_age = 30

	var/account_allowed = 1				  // Does this job type come with a station account?
	var/economic_modifier = 2			  // With how much does this job modify the initial account amount?

	var/idtype = /obj/item/weapon/card/id // The type of the ID the player will have
	var/custom_survival_gear = null       // Custom box for spawn in backpack

	//job equipment
	var/implanted = 0
	var/uniform = /obj/item/clothing/under/color/grey
	var/shoes = /obj/item/clothing/shoes/black
	var/pda = /obj/item/device/pda
	var/hat = null
	var/suit = null
	var/gloves = null
	var/mask = null
	var/belt = null
	var/ear = /obj/item/device/radio/headset
	var/hand = null
	var/glasses = null
	var/suit_store = null

	var/backpack  = /obj/item/weapon/storage/backpack
	var/satchel   = /obj/item/weapon/storage/backpack/satchel
	var/satchel_j = /obj/item/weapon/storage/backpack/satchel/norm
	var/dufflebag = /obj/item/weapon/storage/backpack/dufflebag
	var/messenger = /obj/item/weapon/storage/backpack/messenger

	//This will be put in backpack. List ordered by priority!
	var/list/put_in_backpack = list()

/*
For copy-pasting:

	implanted =
	uniform =
	pda =
	ear =
	shoes =
	suit =
	suit_store =
	gloves =
	mask =
	belt =
	hand =
	glasses =
	hat =

	backpack  =
	satchel   =
	satchel_j =
	dufflebag =
	messenger =

	put_in_backpack = list(
	)
*/

/datum/job/New()
	..()
	put_in_backpack += /obj/item/weapon/gift/new_year

/datum/job/proc/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	//Put items in hands
	if(hand) H.equip_to_slot_or_del(new hand (H), slot_l_hand)

	var/backpack_category = backbaglist[H.backbag]

	//Put items in backpack
	if( backpack_category != "None" )
		var/backpack_type = backpack
		switch(backpack_category)
			if("Backpack")		backpack_type = backpack
			if("Satchel")		backpack_type = satchel
			if("Satchel Job")	backpack_type = satchel_j
			if("Dufflebag")		backpack_type = dufflebag
			if("Messenger")		backpack_type = messenger

		var/obj/item/weapon/storage/backpack/BPK = new backpack_type(H)
		if(H.equip_to_slot_or_del(BPK, slot_back,1))
			for( var/path in put_in_backpack )
				new path(BPK)

	//Survival equipment
	H.equip_survival_gear(custom_survival_gear)

	//No-check items (suits, gloves, etc)
	if(ear)
		H.equip_to_slot_or_del(new ear (H), slot_l_ear)
		H << "<b>To speak on your department's radio channel use :h. For the use of other channels, examine your headset.</b>"
	if(shoes)		H.equip_to_slot_or_del(new shoes (H), slot_shoes)
	if(uniform)		H.equip_to_slot_or_del(new uniform (H), slot_w_uniform)
	if(suit)		H.equip_to_slot_or_del(new suit (H), slot_wear_suit)
	if(suit_store)	H.equip_to_slot_or_del(new suit_store (H), slot_s_store)
	if(mask)		H.equip_to_slot_or_del(new mask (H), slot_wear_mask)
	if(hat)			H.equip_to_slot_or_del(new hat (H), slot_head)
	if(gloves)		H.equip_to_slot_or_del(new gloves (H), slot_gloves)
	if(glasses)		H.equip_to_slot_or_del(new glasses (H), slot_glasses)

	//Belt and PDA
	if(H.belt)
		H.equip_to_slot_or_del(new pda (H), slot_l_store)
		if(belt)
			H.equip_to_slot_or_del(new belt (H), slot_in_backpack)
	else
		if(belt)
			H.equip_to_slot_or_del(new belt (H), slot_belt)
			H.equip_to_slot_or_del(new pda (H), slot_l_store)
		else
			H.equip_to_slot_or_del(new pda (H), slot_belt)

	if(!H.back || !istype(H.back, /obj/item/weapon/storage/backpack))
		var/list/slots = list( slot_belt, slot_r_store, slot_l_store, slot_r_hand, slot_l_hand, slot_s_store )
		for( var/path in put_in_backpack )
			if( !slots.len ) break
			var/obj/item/I = new path(H)
			for( var/slot in slots )
				if( H.equip_to_slot_if_possible(I, slot, 0, 1, 0) )
					slots -= slot
					break
			if(istype(H.r_hand,/obj/item/weapon/storage))
				new path(H.r_hand)
			else if(istype(H.l_hand, /obj/item/weapon/storage))
				new path(H.l_hand)

	//Loyalty implant
	if(implanted) H.implant_loyalty(H)

	return 1

/datum/job/proc/setup_account(var/mob/living/carbon/human/H)
	if(!account_allowed || (H.mind && H.mind.initial_account))
		return

	var/loyalty = 1
	if(H.client)
		switch(H.client.prefs.nanotrasen_relation)
			if(COMPANY_LOYAL)		loyalty = 1.30
			if(COMPANY_SUPPORTATIVE)loyalty = 1.15
			if(COMPANY_NEUTRAL)		loyalty = 1
			if(COMPANY_SKEPTICAL)	loyalty = 0.85
			if(COMPANY_OPPOSED)		loyalty = 0.70

	//give them an account in the station database
	var/species_modifier = (H.species ? economic_species_modifier[H.species.type] : 2)
	if(!species_modifier)
		species_modifier = economic_species_modifier[/datum/species/human]

	var/money_amount = rand(10,100) * loyalty * economic_modifier * species_modifier
	var/datum/money_account/M = create_account(H.real_name, money_amount, null)
	if(H.mind)
		var/remembered_info = ""
		remembered_info += "<b>Your account number is:</b> #[M.account_number]<br>"
		remembered_info += "<b>Your account pin is:</b> [M.remote_access_pin]<br>"
		remembered_info += "<b>Your account funds are:</b> $[M.money]<br>"

		if(M.transaction_log.len)
			var/datum/transaction/T = M.transaction_log[1]
			remembered_info += "<b>Your account was created:</b> [T.time], [T.date] at [T.source_terminal]<br>"
		H.mind.store_memory(remembered_info)

		H.mind.initial_account = M

	H << "<span class='notice'><b>Your account number is: [M.account_number], your account pin is: [M.remote_access_pin]</b></span>"

/datum/job/proc/get_access()
	if(!config || config.jobs_have_minimal_access)
		return minimal_access.Copy()
	else
		return minimal_access.Copy() | addcional_access.Copy()

//If the configuration option is set to require players to be logged as old enough to play certain jobs,
// then this proc checks that they are, otherwise it just returns 1
/datum/job/proc/player_old_enough(client/C)
	return (available_in_days(C) == 0) //Available in 0 days = available right now = player is old enough to play.

/datum/job/proc/available_in_days(client/C)
	if(C && config.use_age_restriction_for_jobs && isnum(C.player_age) && isnum(minimal_player_age))
		return max(0, minimal_player_age - C.player_age)
	return 0

/datum/job/proc/apply_fingerprints(var/mob/living/carbon/human/target)
	if(!istype(target))
		return 0
	for(var/obj/item/item in target.contents)
		apply_fingerprints_to_item(target, item)
	return 1

/datum/job/proc/apply_fingerprints_to_item(var/mob/living/carbon/human/holder, var/obj/item/item)
	item.add_fingerprint(holder,1)
	if(item.contents.len)
		for(var/obj/item/sub_item in item.contents)
			apply_fingerprints_to_item(holder, sub_item)

/datum/job/proc/is_position_available(var/latejoin = 0)
	if(latejoin)
		return (total_positions - current_positions) != 0
	else
		return (spawn_positions - current_positions) != 0
