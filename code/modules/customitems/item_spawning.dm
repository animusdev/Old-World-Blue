// Switch this out to use a database at some point. Each ckey is
// associated with a list of custom item datums. When the character
// spawns, the list is checked and all appropriate datums are spawned.
// See config/example/custom_items.txt for a more detailed overview
// of how the config system works.

// CUSTOM ITEM ICONS:
// Inventory icons must be in CUSTOM_ITEM_OBJ with state name [item_icon].
// On-mob icons must be in CUSTOM_ITEM_MOB with state name [item_icon].
// Inhands must be in CUSTOM_ITEM_MOB as [icon_state]_l and [icon_state]_r.

// Kits must have mech icons in CUSTOM_ITEM_OBJ under [kit_icon].
// Broken must be [kit_icon]-broken and open must be [kit_icon]-open.

// Kits must also have hardsuit icons in CUSTOM_ITEM_MOB as [kit_icon]_suit
// and [kit_icon]_helmet, and in CUSTOM_ITEM_OBJ as [kit_icon].

/var/list/custom_items = list()

/datum/custom_item
	var/assoc_key
	var/character_name
	var/inherit_inhands = 1 //if unset, and inhands are not provided, then the inhand overlays will be invisible.
	var/item_icon
	var/item_desc
	var/name
	var/item_path = /obj/item
	var/req_access = 0
	var/list/req_titles = list()
	var/kit_name
	var/kit_desc
	var/kit_icon
	var/additional_data

/datum/custom_item/proc/spawn_item(var/newloc)
	var/obj/item/citem = new item_path(newloc)
	apply_to_item(citem)
	return citem

/datum/custom_item/proc/apply_to_item(var/obj/item/item)
	if(!item)
		return
	if(name)
		item.name = name
	if(item_desc)
		item.desc = item_desc
	if(item_icon)
		if(!istype(item))
			item.icon_state = item_icon
			return
		else
			item.item_state_slots = null
			item.sprite_group = null

			item.icon_state = item_icon
			item.item_state = null

		var/obj/item/clothing/under/U = item
		if(istype(U))
			U.update_status()

	// Kits are dumb so this is going to have to be hardcoded/snowflake.
	if(istype(item, /obj/item/device/kit))
		var/obj/item/device/kit/K = item
		K.new_name = kit_name
		K.new_desc = kit_desc
		K.new_icon = kit_icon
		if(istype(item, /obj/item/device/kit/paint))
			var/obj/item/device/kit/paint/kit = item
			kit.allowed_types = splittext(additional_data, ", ")
		else if(istype(item, /obj/item/device/kit/suit))
			var/obj/item/device/kit/suit/kit = item
			kit.new_light_overlay = additional_data

	return item

// Parses the config file into the custom_items list.
/hook/startup/proc/load_custom_items()

	var/datum/custom_item/current_data
	var/list/L

///Fox231///

	L = list()

	current_data = new()
	current_data.assoc_key = "fox231"
	current_data.character_name = "Zoy Anderson"
	current_data.item_path = /obj/item/clothing/under/phantom
	L |= current_data

	current_data = new()
	current_data.assoc_key = "fox231"
	current_data.character_name = "Zoy Anderson"
	current_data.item_path = /obj/item/clothing/accessory/locket/Evans
	L |= current_data

	custom_items["fox231"] = L

///Shamah///

	L = list()

	current_data = new()
	current_data.assoc_key = "shamah"
	current_data.character_name = "Niels Johansson"
	current_data.item_path = /obj/item/clothing/suit/storage/toggle/bomber/niels
	L |= current_data

	custom_items["shamah"] = L

///Lethal Ghost///

	L = list()

	current_data = new()
	current_data.assoc_key = "lethalghost"
	current_data.character_name = "April Evans"
	current_data.item_path = /obj/item/clothing/accessory/locket/Evans
	L |= current_data

	custom_items["lethalghost"] = L

///Eclipse///

	current_data = new()
	current_data.assoc_key = "solareclipse84"
	current_data.character_name = "Aiden McMurray"
	current_data.item_path = /obj/item/clothing/under/rank/mechatronic/solar
	L |= current_data

	current_data = new()
	current_data.assoc_key = "solareclipse84"
	current_data.req_titles = list("Paramedic")
	current_data.character_name = "Aiden McMurray"
	current_data.item_path = /obj/item/clothing/suit/storage/vest/pcrc
	L |= current_data

	current_data = new()
	current_data.assoc_key = "solareclipse84"
	current_data.character_name = "Aiden McMurray"
	current_data.item_path = /obj/item/clothing/accessory/purple_heart/solar
	L |= current_data

	current_data = new()
	current_data.assoc_key = "solareclipse84"
	current_data.req_titles = list("Head of Security", "Security Officer", "Warden")
	current_data.character_name = "Aiden McMurray"
	current_data.item_path = /obj/item/clothing/suit/storage/vest/solar
	L |= current_data

	current_data = new()
	current_data.assoc_key = "solareclipse84"
	current_data.req_titles = list("Head of Security", "Security Officer", "Warden")
	current_data.character_name = "Aiden McMurray"
	current_data.item_path = /obj/item/clothing/under/rank/security/solar
	L |= current_data

	current_data = new()
	current_data.assoc_key = "solareclipse84"
	current_data.req_titles = list("Head of Security", "Security Officer", "Warden")
	current_data.character_name = "Aiden McMurray"
	current_data.item_path = /obj/item/clothing/head/helmet/pmcsolar
	L |= current_data

	current_data = new()
	current_data.assoc_key = "solareclipse84"
	current_data.req_titles = list("Head of Security", "Security Officer", "Warden")
	current_data.character_name = "Aiden McMurray"
	current_data.item_path = /obj/item/clothing/mask/keffiehsolar
	L |= current_data

	custom_items["solareclipse84"] = L

///Venligen///

	L = list()

	current_data = new()
	current_data.assoc_key = "venligen"
	current_data.character_name = "Rawick Devine"
	current_data.item_path = /obj/item/clothing/under/rank/security/venligen
	L |= current_data

	current_data = new()
	current_data.assoc_key = "venligen"
	current_data.character_name = "Rawick Devine"
	current_data.req_access = access_brig
	current_data.item_path = /obj/item/clothing/suit/armor/vest/venligen
	L |= current_data

	current_data = new()
	current_data.assoc_key = "venligen"
	current_data.character_name = "William Dearborn"
	current_data.item_path = /obj/item/clothing/under/rank/security/venligen_alt
	L |= current_data

	current_data = new()
	current_data.assoc_key = "venligen"
	current_data.character_name = "William Dearborn"
	current_data.req_access = access_brig
	current_data.item_path = /obj/item/clothing/suit/armor/vest/venligen
	L |= current_data

	current_data = new()
	current_data.assoc_key = "venligen"
	current_data.character_name = "John Dearborn"
	current_data.item_path = /obj/item/clothing/under/rank/security/venligen_alt
	L |= current_data

	current_data = new()
	current_data.assoc_key = "venligen"
	current_data.character_name = "Roy Mercer"
	current_data.item_path = /obj/item/clothing/under/biker
	L |= current_data

	current_data = new()
	current_data.assoc_key = "venligen"
	current_data.character_name = "Nathan Floridor"
	current_data.item_path = /obj/item/clothing/under/biker
	L |= current_data

	current_data = new()
	current_data.assoc_key = "venligen"
	current_data.character_name = "John Dearborn"
	current_data.req_access = access_brig
	current_data.item_path = /obj/item/clothing/suit/armor/vest/venligen
	L |= current_data

	custom_items["venligen"] = L

///AllahBoom///

	L = list()

	current_data = new()
	current_data.assoc_key = "allahboom"
	current_data.character_name = "Nucky Thompson"
	current_data.item_path = /obj/item/clothing/suit/storage/toggle/leather_jacket/mil
	L |= current_data

	current_data = new()
	current_data.assoc_key = "allahboom"
	current_data.character_name = "James Darmody"
	current_data.item_path = /obj/item/clothing/suit/storage/toggle/leather_jacket/mil
	L |= current_data

	current_data = new()
	current_data.assoc_key = "allahboom"
	current_data.character_name = "Malcolm Washburn"
	current_data.item_path = /obj/item/clothing/suit/storage/toggle/leather_jacket/mil
	L |= current_data

	custom_items["allahboom"] = L


///Egorkor///

	L = list()

	current_data = new()
	current_data.assoc_key = "egorkor"
	current_data.req_titles = list("Head of Security", "Security Officer", "Warden")
	current_data.character_name = "Graham Maclagan"
	current_data.item_path = /obj/item/clothing/accessory/purple_heart/egorkor
	L |= current_data

	custom_items["egorkor"] = L


///simonmoore///

	L = list()

	current_data = new()
	current_data.assoc_key = "elektronika71"
	current_data.req_titles = list("Head of Security", "Security Officer", "Warden")
	current_data.character_name = "Weston Ludwig"
	current_data.item_path = /obj/item/clothing/accessory/purple_heart/shepard
	L |= current_data

	custom_items["elektronika71"] = L

///Wajtswv///

	L = list()

	current_data = new()
	current_data.assoc_key = "wajtswv"
	current_data.character_name = "William Stern"
	current_data.item_path = /obj/item/clothing/under/russobluecamooutfit
	L |= current_data

	custom_items["wajtswv"] = L

///Tertiumdatur///

	L = list()

	current_data = new()
	current_data.assoc_key = "tertiumdatur"
	current_data.character_name = "Morlaiaschorr Ilirka"
	current_data.item_desc = "A kit for modifying a voidsuit."
	current_data.name = "Brown refitted modification of the ordinary atmospherics voidsuit made by Aether A&R. This one suitable only for tajaran."
	current_data.item_path = /obj/item/device/kit/suit
	current_data.req_titles = list("Atmospheric Technician", "Station Engineer")
	current_data.kit_name = "dark brown voidsuit"
	current_data.kit_desc = "Brown refitted version of the ordinary atmospherics voidsuit made by Aether A&R. This one suitable only for tajaran."
	current_data.kit_icon = "rig-atmos_special"
	L |= current_data

	current_data = new()
	current_data.assoc_key = "tertiumdatur"
	current_data.character_name = "Morlaiaschorr Ilirka"
	current_data.item_path = /obj/item/clothing/glasses/hud/engi
	L |= current_data

	current_data = new()
	current_data.assoc_key = "tertiumdatur"
	current_data.character_name = "Karamzi Khis'san"
	current_data.item_path = /obj/item/clothing/head/floral_crown
	L |= current_data

	current_data = new()
	current_data.assoc_key = "tertiumdatur"
	current_data.character_name = "Judas Insufledor"
	current_data.item_path = /obj/item/clothing/suit/storage/judas_jacket
	L |= current_data

	custom_items["tertiumdatur"] = L

///Nikiss2000///

	L = list()

	current_data = new()
	current_data.assoc_key = "nikiss2000"
	current_data.character_name = "Hayaya Chatahahita"
	current_data.item_path = /obj/item/clothing/head/vox_cap
	L |= current_data

	custom_items["nikiss2000"] = L



///Nikiton///

	L = list()
	current_data = new()
	current_data.assoc_key = "nikiton"
	current_data.req_titles = list("Head of Security", "Security Officer", "Warden")
	current_data.character_name = "Leroy Woodward"
	current_data.item_path = /obj/item/clothing/accessory/purple_heart/nikiton
	L |= current_data

	current_data = new()
	current_data.assoc_key = "nikiton"
	current_data.req_titles = list("Head of Security", "Security Officer", "Warden")
	current_data.character_name = "Leroy Woodward"
	current_data.item_path = /obj/item/clothing/shoes/jackboots/combat/nikiton
	L |= current_data

	custom_items["nikiton"] = L


///Madman///

	L = list()
	current_data = new()
	current_data.assoc_key = "madmannobrain"
	current_data.req_titles = list("Head of Security", "Security Officer", "Warden")
	current_data.character_name = "Megan Abbott"
	current_data.item_path = /obj/item/clothing/accessory/purple_heart/madman
	L |= current_data

	current_data = new()
	current_data.assoc_key = "madmannobrain"
	current_data.req_titles = list("Head of Security", "Security Officer", "Warden")
	current_data.character_name = "Shirley Harris"
	current_data.item_path = /obj/item/clothing/suit/storage/vest/madman
	L |= current_data

	current_data = new()
	current_data.assoc_key = "madmannobrain"
	current_data.req_titles = list("Head of Security", "Security Officer", "Warden")
	current_data.character_name = "Shirley Harris"
	current_data.item_path = /obj/item/clothing/under/rank/security/madman
	L |= current_data

	current_data = new()
	current_data.assoc_key = "madmannobrain"
	current_data.req_titles = list("Head of Security", "Security Officer", "Warden")
	current_data.character_name = "Shirley Harris"
	current_data.item_path = /obj/item/clothing/head/helmet/pmcmadman
	L |= current_data

	current_data = new()
	current_data.assoc_key = "madmannobrain"
	current_data.req_titles = list("Head of Security", "Security Officer", "Warden")
	current_data.character_name = "Shirley Harris"
	current_data.item_path = /obj/item/weapon/gun/projectile/sec/madman
	L |= current_data

	custom_items["madmannobrain"] = L

///Subber///

	L = list()

	current_data = new()
	current_data.assoc_key = "subber"
	current_data.character_name = "Claire Sandford"
	current_data.item_path = /obj/item/clothing/suit/ianshirt/ash
	L|=current_data

	current_data = new()
	current_data.assoc_key = "subber"
	current_data.character_name = "Claire Sandford"
	current_data.item_path = /obj/item/toy/plushie/man
	L|=current_data

	custom_items["subber"] = L

///MarcusAga///

	L = list()

	current_data = new()
	current_data.assoc_key = "marcusaga"
	current_data.character_name = "Bertrand Francois"
	current_data.item_path = /obj/item/clothing/under/pants/sweaterj
	L |= current_data

	current_data = new()
	current_data.assoc_key = "marcusaga"
	current_data.character_name = "Bertrand Francois"
	current_data.item_path = /obj/item/clothing/suit/storage/pullover
	L |= current_data

	current_data = new()
	current_data.assoc_key = "marcusaga"
	current_data.character_name = "Bertrand Francois"
	current_data.item_path = /obj/item/clothing/shoes/red_boots
	L |= current_data

	current_data = new()
	current_data.assoc_key = "marcusaga"
	current_data.character_name = "Bertrand Francois"
	current_data.item_path = /obj/item/device/pda/chrome
	L |= current_data

	custom_items["marcusaga"] = L

	return 1

//gets the relevant list for the key from the listlist if it exists, check to make sure they are meant to have it and then calls the giving function
/proc/equip_custom_items(mob/living/carbon/human/M)
	var/list/key_list = custom_items[M.ckey]
	if(!key_list || key_list.len < 1)
		return

	for(var/datum/custom_item/citem in key_list)

		// Check for requisite ckey and character name.
		if((lowertext(citem.assoc_key) != lowertext(M.ckey)) || (lowertext(citem.character_name) != lowertext(M.real_name)))
			continue

		// Check for required access.
		var/obj/item/weapon/card/id/current_id = M.wear_id
		if(citem.req_access && citem.req_access > 0)
			if(!(istype(current_id) && (citem.req_access in current_id.access)))
				continue

		// Check for required job title.
		if(citem.req_titles && citem.req_titles.len > 0)
			var/has_title
			var/current_title = M.mind.role_alt_title ? M.mind.role_alt_title : M.mind.assigned_role
			for(var/title in citem.req_titles)
				if(title == current_title)
					has_title = 1
					break
			if(!has_title)
				continue

		// ID cards and PDAs are applied directly to the existing object rather than spawned fresh.
		var/obj/item/existing_item
		if(citem.item_path == /obj/item/weapon/card/id && istype(current_id)) //Set earlier.
			existing_item = M.wear_id
		else if(citem.item_path == /obj/item/device/pda)
			existing_item = locate(/obj/item/device/pda) in M.contents

		// Spawn and equip the item.
		if(existing_item)
			citem.apply_to_item(existing_item)
		else
			place_custom_item(M,citem)

// Places the item on the target mob.
/proc/place_custom_item(mob/living/carbon/human/M, var/datum/custom_item/citem)

	if(!citem) return
	var/obj/item/newitem = citem.spawn_item()

	if(M.equip_to_appropriate_slot(newitem))
		return newitem

	if(M.equip_to_storage(newitem))
		return newitem

	newitem.loc = get_turf(M.loc)
	return newitem
