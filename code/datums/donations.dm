var/list/donat_categoryes = list()
var/list/donators = list()
var/donation_cached = ""

/*
/client/verb/sim_donate()
	set name = "Simulate donation"

	var/ckey = input("Ckey") as text
	var/money = input("Money") as num
	new /datum/donator(ckey, money)
	return
*/

/datum/donator
	var/ownerkey
	var/money = 0
	var/maxmoney = 0
	var/allowed_num_items = 1000

	New(ckey, money)
		..()
		ownerkey = ckey
		src.money = money
		maxmoney = money
		donators[ckey] = src

	proc/show()
		var/dat = "<title>Donator panel</title>"
		dat += "You have [money] / [maxmoney]<br>"
		dat += "You can spawn [ allowed_num_items ? allowed_num_items : "no" ] more items.<br><br>"

		if (allowed_num_items)
			if (!donation_cached)
				build_prizes_list()

			usr << browse(dat+donation_cached, "window=donatorpanel;size=250x400")

	Topic(href, href_list)
		var/datum/donat_stuff/item = locate(href_list["item"])

		var/mob/living/carbon/human/user = usr.client.mob

		var/list/slots = list (
			"backpack" = slot_in_backpack,
			"left pocket" = slot_l_store,
			"right pocket" = slot_r_store,
			"left hand" = slot_l_hand,
			"right hand" = slot_r_hand,
		)

		if(item.cost > money)
			usr << SPAN_WARN("You don't have enough funds.")
			return 0

		if(!allowed_num_items)
			usr << SPAN_WARN("You have reached maximum amount of spawned items.")
			return 0

		if(!user)
			user << SPAN_WARN("You have reached maximum amount of spawned items.")
			return 0

		if(user.stat) return 0

		var/obj/spawned = new item.path

		var/where = user.equip_in_one_of_slots(spawned, slots, del_on_fail=0)

		if (!where)
			spawned.loc = user.loc
			usr << "<span class='info'>Your [spawned.name] has been spawned!</span>"
		else
			usr << "<span class='info'>Your [spawned.name] has been spawned in your [where]!</span>"

		money -= item.cost
		allowed_num_items--

		show()

/proc/load_donator(ckey)
	var/DBConnection/dbcon2 = new()
	dbcon2.Connect("dbi:mysql:forum2:[sqladdress]:[sqlport]","[sqlfdbklogin]","[sqlfdbkpass]")

	if(!dbcon2.IsConnected())
		world.log << "Failed to connect to database [dbcon2.ErrorMsg()] in load_donator([ckey])."
		diary << "Failed to connect to database in load_donator([ckey])."
		return 0

	var/DBQuery/query = dbcon2.NewQuery("SELECT round(sum) FROM Z_donators WHERE byond='[ckey]'")
	query.Execute()
	while(query.NextRow())
		var/money = round(text2num(query.item[1]))
		new /datum/donator(ckey, money)
	dbcon2.Disconnect()
	return 1

/proc/build_prizes_list()
	for(var/path in subtypesof(/datum/donat_stuff))
		var/datum/donat_stuff/T = path
		if(!initial(T.name))
			continue
		T = new path
		if(!donat_categoryes[T.category])
			donat_categoryes[T.category] = list()
		donat_categoryes[T.category] += T

	donation_cached = null
	var/list/dat = list()
	for(var/cur_cat in donat_categoryes)
		dat += "<hr><b>[cur_cat]</b><br>"
		for(var/datum/donat_stuff/item in donat_categoryes[cur_cat])
			dat += "<a href='?src=\ref[src];item=\ref[item]'>[item.name] : [item.cost]</a><br>"
	donation_cached = jointext(dat, null)

/client
	var/next_donat_check = null

/client/verb/cmd_donator_panel()
	set name = "Donator panel"
	set category = "OOC"

	if(world.time < next_donat_check)
		return
	next_donat_check = world.time + 5


	if(!ticker || ticker.current_state < 3)
		alert("Please wait until game setting up!")
		return

	if (!donators[ckey]) //It doesn't exist yet
		load_donator(ckey)

	var/datum/donator/D = donators[ckey]
	if(istype(D))
		D.show()
	else
		donators[ckey] = -1 // No recheck
		usr << browse ("<b>You have not donated or the database is inaccessible.</b>", "window=donatorpanel")