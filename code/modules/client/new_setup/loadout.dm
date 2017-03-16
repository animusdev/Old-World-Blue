var/list/loadout_categories = list()
var/list/gear_datums = list()

/datum/loadout_category
	var/category = ""
	var/list/gear = list()

/datum/loadout_category/New(var/cat)
	category = cat
	..()

/hook/startup/proc/populate_gear_list()

	//create a list of gear datums to sort
	for(var/geartype in typesof(/datum/gear)-/datum/gear)
		var/datum/gear/G = geartype

		var/use_name = initial(G.display_name)
		var/use_category = initial(G.sort_category)

		if(!use_name) // Basic type
			continue
		if(!initial(G.cost))
			world.log << "Warning: Loadout - Missing cost: [G]"
			continue
		if(!initial(G.path))
			world.log << "Loadout - Missing path definition: [G]"
			continue

		if(!loadout_categories[use_category])
			loadout_categories[use_category] = new /datum/loadout_category(use_category)
		var/datum/loadout_category/LC = loadout_categories[use_category]
		gear_datums[use_name] = new geartype
		LC.gear[use_name] = gear_datums[use_name]

	loadout_categories = sortAssoc(loadout_categories)
	for(var/loadout_category in loadout_categories)
		var/datum/loadout_category/LC = loadout_categories[loadout_category]
		LC.gear = sortAssoc(LC.gear)
	return 1

/datum/gear
	var/display_name       //Name/index. Must be unique.
	var/description        //Description of this gear. If left blank will default to the description of the pathed item.
	var/path               //Path to item.
	var/list/options       //Specific modificators list. Affect spawned item or way it spawns.
	var/cost = 1           //Number of points used. Items in general cost 1 point, storage/armor/gloves/special use costs 2 points.
	var/slot               //Slot to equip to.
	var/list/allowed_roles //Roles that can spawn with this item.
	var/whitelisted        //Term to check the whitelist for..
	var/sort_category = "General"

/datum/gear/New()
	..()
	if (!sort_category)
		sort_category = "[slot]"

/datum/gear/proc/set_option(var/mob/user)
	var/option = input(user, "Select special modifications of item for spawn", "Select modification") as null|anything in options
	return option ? option : options[1]

/datum/gear/proc/spawn_for(var/mob/living/carbon/human/H, var/option)
	if(allowed_roles && !(H.job in allowed_roles))
		H << "<span class='warning'>Your current job does not permit you to spawn with [display_name]!</span>"
		return null

	if(whitelisted && !is_alien_whitelisted(H, whitelisted))
		H << "<span class='warning'>Your current whitelist status does not permit you to spawn with [display_name]!</span>"
		return null

	var/build_path
	if(options && option in options)
		build_path = options[option]

	if(!build_path)
		build_path = path

	return new build_path(H)

//PAGE GENERATION AND HANDLING

/datum/preferences
	var/current_tab = "General" //Loadout tab

/datum/preferences/proc/GetLoadOutPage()
	. = list()
	var/total_cost = 0
	if(gear && gear.len)
		for(var/i = 1; i <= gear.len; i++)
			var/datum/gear/G = gear_datums[gear[i]]
			if(G)
				total_cost += G.cost

	var/fcolor =  "red"
	if(total_cost < MAX_GEAR_COST)
		fcolor = "blue"

	. += "<div><center><b><font color=[fcolor]>[total_cost]/[MAX_GEAR_COST]</font> loadout points spent.</b> \[<a href='?src=\ref[src];clear_loadout=1'>Clear Loadout</a>\]</center></div>"

	. += "<div><center>"
	var/list/categories = list()
	for(var/category in loadout_categories)

		var/datum/loadout_category/LC = loadout_categories[category]
		var/category_cost = 0
		for(var/name in LC.gear)
			if(name in gear)
				var/datum/gear/G = LC.gear[name]
				category_cost += G.cost

		var/disp_name = replacetext(category, " ", "&nbsp;")

		if(category == current_tab)
			categories += "[disp_name]&nbsp;\[[category_cost]]"
		else
			if(category_cost)
				categories += "<a href='?src=\ref[src];select_category=[category]'><font color=blue>[disp_name]&nbsp;\[[category_cost]]</font></a>"
			else
				categories += "<a href='?src=\ref[src];select_category=[category]'>[disp_name]&nbsp;\[0]</a>"

	. += jointext(categories, "&nbsp;| ")

	. += "</center></div>"

	var/datum/loadout_category/LC = loadout_categories[current_tab]
	. += "<div style='height:335px;overflow-y:auto;border:solid;margin: 7,0,0,0;padding:3px'>"

	for(var/gear_name in LC.gear)
		var/datum/gear/G = LC.gear[gear_name]
		var/ticked = (G.display_name in gear)
		. += "<div title = \"[G.description]\">"
		. += "<a[ticked ? " style='font-weight: bold;'" : ""] href='?src=\ref[src];toggle_gear=[html_encode(G.display_name)]'>[G.display_name]</a>"
		if(ticked && G.options)
			var/option = gear[G.display_name]
			if(!option) option = G.options[1]
			. += ", <a href='?src=\ref[src];gear=[G.display_name];option=set'>\[[option]]</a>"
		. += " ([G.cost])</div>"

	. += "</div>"
	return (jointext(., null))


/datum/preferences/proc/HandleLoadOutTopic(mob/user, list/href_list)
	if(href_list["toggle_gear"])
		var/datum/gear/TG = gear_datums[href_list["toggle_gear"]]
		if(TG.display_name in gear)
			gear -= TG.display_name
		else
			var/total_cost = 0
			for(var/gear_name in gear)
				var/datum/gear/G = gear_datums[gear_name]
				if(istype(G)) total_cost += G.cost
			if((total_cost+TG.cost) <= MAX_GEAR_COST)
				gear += TG.display_name
		return

	if(href_list["gear"] && href_list["option"])
		var/datum/gear/G = gear_datums[href_list["gear"]]
		if(!G.display_name in gear)
			return
		var/option = G.set_option(usr)
		if(G.display_name in gear)
			gear[G.display_name] = option
		return

	else if(href_list["select_category"])
		current_tab = href_list["select_category"]
		return
	else if(href_list["clear_loadout"])
		gear.Cut()
		return